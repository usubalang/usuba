open Usuba_AST
open Basic_utils
open Utils


let sum_type = List.fold_left (fun tot vd -> tot + (typ_size vd.vtyp)) 0


(* ************************************************************************** *)

let reduce_same_list l =
  try
    List.fold_left (fun acc t -> if acc = t then acc else raise Exit) (List.hd l) l
  with Exit -> Printf.fprintf stderr "Error: list [%s] isn't type-homogeneous.\n"
                               (Usuba_print.typ_to_str_l l);
                assert false


let rec expand_intn (id: ident) (n: int) : ident list =
  if n = 1 || n = 0 then
    [ id ]
  else
    let rec aux i =
      if i > n then []
      else (fresh_suffix id (string_of_int i)) :: (aux (i+1))
    in aux 1

let expand_intn_typed (id: ident) (n: int) (ck: clock) =
  List.map (fun x -> (x,bool,ck)) (expand_intn id n)

let expand_intn_pat (id: ident) (n: int) : var list =
  List.map (fun x -> Var x) (expand_intn id n)

let rec expand_intn_expr (id: ident) (n: int option) : expr =
  match n with
  | Some n -> Tuple(List.map (fun x -> ExpVar(Var x)) (expand_intn id n))
  | None -> ExpVar(Var id)

(* Differs a bit from the version of utils in how Const are handled *)
let rec get_expr_type env_fun env_var (ltyp:typ list) (e:expr) : typ list =
  match e with
  | Const(n,None) -> Printf.eprintf "Invalid untyped const (0x%x). Exiting.\n" n;
                     assert false
  | Const(n,Some typ) -> [ typ ]
  | ExpVar v -> [ get_var_type env_var v ]
  | Tuple l -> flat_map (get_expr_type env_fun env_var ltyp) l
  | Not e -> get_expr_type env_fun env_var ltyp e
  | Shift(_,e,_) -> get_expr_type env_fun env_var ltyp e
  | Log(_,e,_) -> get_expr_type env_fun env_var ltyp e
  | Shuffle(v,_) -> [ get_var_type env_var v ]
  | Arith(_,e,_) -> get_expr_type env_fun env_var ltyp e
  | Fun(f,_) ->
     if f.name = "rand" then [ Uint(default_dir,Mint 1,1) ]
     else
       let def = Hashtbl.find env_fun f in
       List.map (fun vd -> vd.vtyp) def.p_out
  | _ -> assert false


let new_vars : p ref = ref []

let gen_tmp =
  let cpt = ref 0 in
  fun env_var typ ->
    incr cpt;
    let var = fresh_ident ("_tmp" ^ (string_of_int !cpt) ^ "_") in
    Hashtbl.replace env_var var typ;
    var

(* Note that when this function is called, Var have already been normalized *)
let rec get_expr_size env_var env_fun l : int =
  match l with
  | Const _ | Log _ | Not _ | Shuffle _ -> 1
  | ExpVar v -> get_var_size env_var v
  | Shift(_,e,_) -> get_expr_size env_var env_fun e
  | Tuple l -> List.length l
  | Fun(f,_) -> ( match Hashtbl.find_opt env_fun f with
                  | Some deq -> sum_type deq.p_out
                  | None -> if contains f.name "print" || contains f.name "rand" then 1
                            else raise (Error ("Undeclared " ^ f.name)))
  | _ -> raise (Error (Printf.sprintf "Not implemented yet get_expr_size(%s)\n" (Usuba_print.expr_to_str_types l)))

(* flatten_expr removes nested tuples *)
let rec flatten_expr (l: expr list) : expr list =
  match l with
  | [] -> []
  | hd::tl -> (match hd with
               | Tuple l -> flatten_expr l
               | _ -> [ hd ]) @ (flatten_expr tl)

(* A primitive expression doesn't need to be rewritten in Tuples or fun calls *)
let rec is_primitive e =
  match e with
  | (* Const _ |  *)ExpVar _ (* | Shuffle _ *) -> true
  | Tuple l -> List.fold_left (&&) true (List.map is_primitive l)
  | _ -> false

let rec expand_expr env_var (e:expr) : expr list =
  match e with
  | Const _ -> [ e ]
  | ExpVar v -> List.map (fun x -> ExpVar x) (expand_var env_var v)
  | Tuple l -> flat_map (fun e -> expand_expr env_var e) l
  | Not e -> List.map (fun x -> Not x) (expand_expr env_var e)
  | Shift(op,x,ae) ->
     let x' =
       (match expand_expr env_var x with
        | x' :: [] ->  x'
        | l -> Tuple l) in
     (try
       (match Bitslice_shift.shift env_var op x' (eval_arith_ne ae) with
        | Tuple l -> flat_map (expand_expr env_var) l
        | x' -> [x'])
      with Not_found -> (* |ae| does not simplify to a Const *)
        [ Shift(op,x',ae) ])
  | Log(op,x,y) -> List.map2 (fun x y -> Log(op,x,y))
                             (expand_expr env_var x)
                             (expand_expr env_var y)
  | Shuffle(v,pat) -> List.map (fun x -> Shuffle(x,pat)) (expand_var env_var v)
  | Arith(op,x,y) -> List.map2 (fun x y -> Arith(op,x,y))
                              (expand_expr env_var x)
                              (expand_expr env_var y)
  | Fun _ -> [ e ]
  | _ -> assert false

(* ************************************************************************** *)

let rec remove_call env_var env_fun (dir,mtyp:dir*mtyp) (ltyp:typ list) (e:expr)
        : deq list * expr =
  let (deq,e') = norm_expr env_var env_fun (dir,mtyp) ltyp e in

  if is_primitive e' then
    deq, e'
  else
    let expr_typ_l = get_expr_type env_fun env_var ltyp e' in
    let typ = if List.length expr_typ_l > 1
              then Array(reduce_same_list expr_typ_l,List.length expr_typ_l)
              else List.hd expr_typ_l in
    let typ = update_type_m (update_type_dir typ dir) mtyp in
    let new_var = gen_tmp env_var typ in
    new_vars := (make_var_d new_var typ Defclock []) :: !new_vars;

    deq @ [Eqn([Var new_var],e',false)], ExpVar (Var new_var)

and remove_calls env_var env_fun (dir,mtyp:dir*mtyp) (ltyp:typ list)  (l:expr list)
    : deq list * expr list =
  let pre_deqs = ref [] in
  let l' = List.map
             (fun e ->

              let (deq,e') = norm_expr env_var env_fun (dir,mtyp) ltyp e in
              pre_deqs := !pre_deqs @ deq;

              if is_primitive e' then
                [ e' ]
              else
                let expr_typ_l = try
                    get_expr_type env_fun env_var ltyp e'
                  with Not_found -> Printf.printf "Not found: %s\n" (Usuba_print.expr_to_str e');
                                    raise Not_found in
                let typ = if List.length expr_typ_l > 1
                          then Array(reduce_same_list expr_typ_l,
                                     List.length expr_typ_l)
                          else List.hd expr_typ_l in
                let typ = update_type_m (update_type_dir typ dir) mtyp in
                let new_var = gen_tmp env_var typ in
                new_vars := (make_var_d new_var typ Defclock []) :: !new_vars;
                pre_deqs := !pre_deqs @ [(Eqn([Var new_var],e',false))];

                [ExpVar (Var new_var)])
             l in
  !pre_deqs, flatten_expr (List.flatten l')


and norm_expr env_var env_fun (dir,mtyp:dir*mtyp) (ltyp:typ list) (e: expr)
    : deq list * expr =
  match e with
  | Const _ | ExpVar _ | Shuffle _-> [], e
  | Tuple (l) ->
     let (deqs,l') = remove_calls env_var env_fun (dir,mtyp) ltyp l in
     deqs, Tuple l'
  | Fun(f,l) ->
     let (deqs,l') = remove_calls env_var env_fun (dir,mtyp) ltyp l in
     deqs, Fun(f, l')
  | Log(op,x1,x2) ->
     let (deqs1, x1') = remove_call env_var env_fun (dir,mtyp) ltyp x1 in
     let (deqs2, x2') = remove_call env_var env_fun (dir,mtyp) ltyp x2 in
     deqs1 @ deqs2,
     ( match x1', x2' with
       | Tuple l1,Tuple l2 ->
          Tuple (List.map2 (fun x y -> Log(op,x,y))
                           (flat_map (expand_expr env_var) l1)
                           (flat_map (expand_expr env_var) l2))
       | _ ->
          Tuple(List.map2 (fun x y -> Log(op,x,y))
                              (expand_expr env_var x1')
                              (expand_expr env_var x2')))
  | Arith(op,x1,x2) ->
     let (deqs1, x1') = remove_call env_var env_fun (dir,mtyp) ltyp x1 in
     let (deqs2, x2') = remove_call env_var env_fun (dir,mtyp) ltyp x2 in
     deqs1 @ deqs2,
     ( match x1', x2' with
       | Tuple l1,Tuple l2 ->
          Tuple (List.map2 (fun x y -> Arith(op,x,y))
                   (flat_map (expand_expr env_var) l1)
                   (flat_map (expand_expr env_var) l2))
       | _ ->
          Tuple(List.map2 (fun x y -> Arith(op,x,y))
                  (expand_expr env_var x1')
                  (expand_expr env_var x2')))
  | Not e ->
     let (deqs,e') = remove_call env_var env_fun (dir,mtyp) ltyp e in
     deqs,
     ( match e' with
       | Tuple l -> Tuple (List.map (fun x -> Not x) (flat_map (expand_expr env_var) l))
       | _ -> Tuple(List.map (fun x -> Not x) (expand_expr env_var e') ))
  | Shift(op,e,n) ->
     let (deqs,e') = remove_call env_var env_fun (dir,mtyp) ltyp e in
     deqs, Shift(op,e',n)
  | _ -> assert false

let rec norm_deq env_var env_fun (body: deq list) : deq list =
  flat_map
    (function
     | Eqn (lhs,e,sync) ->
        let ltyp = flat_map (fun v -> expand_typ (get_var_type env_var v)) lhs in
        (match List.hd ltyp with
         | Nat -> [Eqn(lhs,e,sync)]
         | t   ->
            let dir = get_type_dir t in
            let m   = get_type_m   t in
            let (expr_l, e') = norm_expr env_var env_fun (dir,m) ltyp e in
            expr_l @ [Eqn(lhs,e',sync)])
      | Loop(x,ei,ef,dl,opts) ->
         [ Loop(x,ei,ef,norm_deq env_var env_fun dl,opts) ]) body

let norm_def env_fun (def: def) : def =
  match def.node with
  | Single(p_var,body) ->
     let env_var = build_env_var def.p_in def.p_out p_var in
     new_vars := [];
     let body = norm_deq env_var env_fun body in
     { def with node = Single(p_var @ !new_vars,body) }
  | _ ->
     def

let norm_prog (prog:prog) (conf:config) : prog =
  let env_fun = build_env_fun prog.nodes in
  { nodes = List.map (norm_def env_fun) prog.nodes }
