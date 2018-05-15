open Usuba_AST
open Basic_utils
open Utils


let no_arr = ref false 
       
(* Add a function (name,p_in,p_out) to env_fun *)
let env_add_fun (name: ident) (p_in: p) (p_out: p)
                (env_fun: (int list * int) env) : unit =
  let rec get_param_in_size = function
    | [] -> []
    | ((_,typ),_)::tl -> (typ_size typ) :: (get_param_in_size tl)
  in
  let rec get_param_out_size = function
    | [] -> 0
    | ((_,typ),_)::tl -> (typ_size typ) + (get_param_out_size tl)
  in
  env_add env_fun name (get_param_in_size p_in,get_param_out_size p_out)

          
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error (__LOC__ ^ ":Not found: " ^ v.name))


          
(* ************************************************************************** *)

let rec expand_intn (id: ident) (n: int) : ident list =
  if n = 1 || n = 0 then
    [ id ]
  else
    let rec aux i =
      if i > n then []
      else (fresh_suffix id (string_of_int i)) :: (aux (i+1))
    in aux 1
         
let expand_intn_typed (id: ident) (n: int) (ck: clock) =
  List.map (fun x -> (x,Bool,ck)) (expand_intn id n)
         
let expand_intn_pat (id: ident) (n: int) : var list =
  List.map (fun x -> Var x) (expand_intn id n)
         
let rec expand_intn_expr (id: ident) (n: int option) : expr =
  match n with
  | Some n -> Tuple(List.map (fun x -> ExpVar(Var x)) (expand_intn id n))
  | None -> ExpVar(Var id)

let new_vars : p ref = ref []
                   
let gen_tmp =
  let cpt = ref 0 in
  fun env_var size ->
    incr cpt;
    let var = fresh_ident ("_tmp" ^ (string_of_int !cpt) ^ "_") in
    if !no_arr then
      List.iter (fun x -> env_add env_var x Bool) (expand_intn var size)
    else
      if size > 1 then
        env_add env_var var (Array(Bool,Const_e size))
      else
        env_add env_var var Bool;
    var
                             
(* Note that when this function is called, Var have already been normalized *)
let rec get_expr_size env_var env_fun l : int =
  match l with
  | Const _ | Log _ | Not _ | Shuffle _ -> 1
  | ExpVar v -> get_var_size env_var v
  | Shift(_,e,_) -> get_expr_size env_var env_fun e
  | Tuple l -> List.length l
  | Fun(f,_) ->(match Utils.env_fetch env_fun f with
                 | Some (_,v) -> v
                 | None -> if contains f.name "print" then 1
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
  | Const _ | ExpVar _ | Shuffle _ -> true
  | Tuple l -> List.fold_left (&&) true (List.map is_primitive l)
  | _ -> false

let rec expand_expr env_var (e:expr) : expr list =
  match e with
  | Const _ -> [ e ]
  | ExpVar v -> List.map (fun x -> ExpVar x) (expand_var env_var v)
  | Tuple l -> flat_map (fun e -> expand_expr env_var e) l
  | Not e -> List.map (fun x -> Not x) (expand_expr env_var e)
  | Shift(op,x,ae) -> List.map (fun x -> Shift(op,x,ae)) (expand_expr env_var x)
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
                
let rec remove_call env_var env_fun e : deq list * expr =
  let (deq,e') = norm_expr env_var env_fun e in

  if is_primitive e' then
    deq, e'
  else
    let size = get_expr_size env_var env_fun e' in
    let new_var = gen_tmp env_var size in
    let tmp  = if !no_arr then List.map (fun x -> Var x) (expand_intn new_var size)
               else [Var new_var] in
    if !no_arr then
      new_vars := !new_vars @ (List.map (function
                                          | Var id -> ((id,Bool),Defclock)
                                          | _ -> assert false) tmp)
    else
      if size > 1 then
        new_vars := !new_vars @ [ ((new_var,Array(Bool,Const_e size)),Defclock) ]
      else
        new_vars := !new_vars @ [ ((new_var,Bool),Defclock) ];
    let left = tmp in

    deq @ [Norec(left,e')], Tuple (List.map (fun x -> ExpVar x) tmp)

and remove_calls env_var env_fun l : deq list * expr list =
  let pre_deqs = ref [] in
  let l' = List.map
             (fun e ->
              
              let (deq,e') = norm_expr env_var env_fun e in
              pre_deqs := !pre_deqs @ deq;

              if is_primitive e' then
                [ e' ]
              else
                let size = get_expr_size env_var env_fun e' in
                let new_var = gen_tmp env_var size in
                let tmp  = if !no_arr then List.map (fun x -> Var x) (expand_intn new_var size)
                           else [Var new_var] in
                if !no_arr then
                  new_vars := !new_vars @ (List.map (function
                                                      | Var id -> ((id,Bool),Defclock)
                                                      | _ -> assert false) tmp)
                else
                  if size > 1 then
                    new_vars := !new_vars @ [ ((new_var,Array(Bool,Const_e size)),Defclock) ]
                  else
                    new_vars := !new_vars @ [ ((new_var,Bool),Defclock) ];
                let left = tmp in
                pre_deqs := !pre_deqs @ [Norec(left,e')];
                
                List.map (fun x -> ExpVar x) tmp)
             l in
  !pre_deqs, flatten_expr (List.flatten l')
    

and norm_expr env_var env_fun (e: expr) : deq list * expr = 
  match e with
  | Const _ | ExpVar _ | Shuffle _-> [], e
  | Tuple (l) ->
     let (deqs,l') = remove_calls env_var env_fun l in
     deqs, Tuple l'
  | Fun(f,l) ->
     let (deqs,l') = remove_calls env_var env_fun l in
     deqs, Fun(f, l')
  | Log(op,x1,x2) ->
     let (deqs1, x1') = remove_call env_var env_fun x1 in
     let (deqs2, x2') = remove_call env_var env_fun x2 in
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
     let (deqs1, x1') = remove_call env_var env_fun x1 in
     let (deqs2, x2') = remove_call env_var env_fun x2 in
     deqs1 @ deqs2,
     ( match x1', x2' with
       | Tuple l1,Tuple l2 ->
          Tuple (List.map2 (fun x y -> Arith(op,x,y)) l1 l2)
       | _ -> Arith(op,x1',x2'))
       
  | Not e ->
     let (deqs,e') = remove_call env_var env_fun e in
     deqs,
     ( match e' with
       | Tuple l -> Tuple (List.map (fun x -> Not x) (flat_map (expand_expr env_var) l))
       | _ -> Tuple(List.map (fun x -> Not x) (expand_expr env_var e') ))
  | Shift(op,e,n) ->
     let (deqs,e') = remove_call env_var env_fun e in
     deqs, Shift(op,e',n)
  | _ -> assert false
               
let rec norm_deq env_var env_fun (body: deq list) : deq list =
  flat_map
    (function
      | Norec (p,e) ->
         let (expr_l, e') = norm_expr env_var env_fun e in
         expr_l @ [Norec(p,e')]
      | Rec(x,ei,ef,dl,opts) ->
         [ Rec(x,ei,ef,norm_deq env_var env_fun dl,opts) ]) body
    
let norm_def env_fun (def: def) : def =
  match def.node with
  | Single(p_var,body) ->
     let env_var = build_env_var def.p_in def.p_out p_var in
     env_add_fun def.id def.p_in def.p_out env_fun;
     new_vars := [];
     let body = norm_deq env_var env_fun body in
     { def with node = Single(p_var @ !new_vars,body) }
  | Perm _ ->
     env_add_fun def.id def.p_in def.p_out env_fun;
     def
  | _ ->
     def

let norm_prog (prog:prog) (conf:config) : prog =
  no_arr := conf.no_arr;
  let env_fun = make_env () in
  { nodes = List.map (norm_def env_fun) prog.nodes }
  
