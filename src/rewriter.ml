
open Abstract_syntax_tree
open Utils
open Specific_rewriter
open Rename

exception Not_implemented of string
exception Empty_list
exception Undeclared of string
exception Invalid_param_size
exception Invalid_operator_call
            
            
(* ************************************************** *)
(*   AST transformation to match naive bool backend   *)
(* ************************************************** *)

module Make (Aux : SPECIFIC_REWRITER ) = struct
                             
                             
  (* Auxiliary functions that need to be embeded in the code *)
  let aux_fun = ref []
  let print_fun = ref []
  let entry   = ref ""
  let before_deq : (pat * expr) list ref = ref []

  let tmp_generator =
    let counter = ref 0 in
    fun () -> incr counter;
              "tmp" ^ (string_of_int !counter)

                    
  (* Flatten a list of expr inside a tuple *)
  let rec flatten_expr (l: expr list) : expr list =
    match l with
    | [] -> []
    | hd::tl -> (match hd with
                 | Tuple l -> flatten_expr l
                 | _ -> [ hd ]) @ (flatten_expr tl)

  let rec distrib_not (l: expr list) : expr list =
    match l with
    | [] -> []
    | hd::tl -> (Op(Not,[hd])) :: (distrib_not tl)

  let rec combine_op op l1 l2 =
    match l1, l2 with
    | [], [] -> []
    | hd1::tl1, hd2::tl2 -> (Op(op,[hd1;hd2])) :: (combine_op op tl1 tl2)
    | _ -> raise Invalid_param_size

  let rec combine_xor l1 l2 =
    match l1, l2 with
    | [], [] -> []
    | hd1::tl1, hd2::tl2 -> ( Op(Or,
                                 [ Op(And, [ hd1; Op(Not, [ hd2 ]) ]) ;
                                   Op(And, [ Op(Not, [ hd1 ]); hd2 ])]) )
                            :: (combine_xor tl1 tl2)
    | _ -> raise Invalid_param_size

  let rec get_size e env =
    match e with
    | Const _ -> 1
    | Var x   -> 1 (* at this point, Var are only Bool *)
    | Field _ -> 1
    | Tuple l -> List.length l
    | Op _    -> 1 (* at this point, Op have already been normalized *)
    | Fun(f,_) -> (match env_fetch env f with
                   | Some (_,v) -> v
                   | None -> if f = "print" then 1
                             else raise @@ Undeclared("function " ^ f))
    | Mux _ -> raise (Not_implemented "Mux")
    | Demux _  -> raise (Not_implemented "Demux")
    | Fby(ei,_,_) -> get_size ei env
    | Nop -> 0
    | _ -> raise (Invalid_AST "Non-conform AST")

  let rec get_sizes l env =
    match l with
    | [] -> []
    | hd::tl -> ( get_size hd env ) :: (get_sizes tl env)
                                         
  let gen_conv =
    let cache = Hashtbl.create 10 in
    fun target orig ->
    if target = orig then "id"
    else
      let key = (join " " (List.map string_of_int orig)) ^ "_" ^
                  (join " " (List.map string_of_int target)) in
      match env_fetch cache key with
      | Some name -> name
      | None ->
        begin
          let id = "convert" ^ (string_of_int @@ id_generator ()) in
          let num_param = ref 0 in
          let param = List.map (fun n -> incr num_param;
                                         ("in"^(string_of_int !num_param),
                                          Int n,
                                          "_")) orig in
          let num_ret = ref 0 in
          let ret = List.map (fun n -> incr num_ret;
                                       ("out"^(string_of_int !num_ret),
                                        Int n,
                                        "_")) target in
          let rec make_body id_p num_p id_r num_r size_curr_p size_curr_r next_p next_r :
                    (pat * expr) list =
            if size_curr_p = 0 then
              match next_p with
              | [] -> []
              | hd::tl -> make_body (id_p+1) 1 id_r num_r hd size_curr_r tl next_r
            else if size_curr_r = 0 then
              match next_r with
              | [] -> []
              | hd::tl -> make_body id_p num_p (id_r+1) 1 size_curr_p hd next_p tl
            else
              ([Dotted(Ident("out"^(string_of_int id_r)),num_r)],
               Field(Var("in"^(string_of_int id_p)),num_p)) ::
                (make_body id_p (num_p+1) id_r (num_r+1) (size_curr_p-1)
                           (size_curr_r-1) next_p next_r)
          in
          let f = Single(id,param,ret,[], make_body 0 1 0 1 0 0 orig target) in
          aux_fun := (!aux_fun) @ [f];
          env_add cache key id;
          id
        end
                                           
  let format_param f l env =
    match env_fetch env f with
    | Some (params,_) ->
       let sizes = get_sizes l env in
       [ Fun (gen_conv params sizes, l) ]
    | None -> raise @@ Undeclared("function " ^ f)
         
         
  let rec rewrite_expr (env_var: (ident, int) Hashtbl.t)
                       (env_fun: (ident, int list * int) Hashtbl.t) (e: expr) : expr =
    match e with
    | Const c -> Const c (* TODO: convert potential integer to list of bool? *)
    | Var id  -> (match env_fetch env_var id with
                  | Some size -> if size > 1 then Tuple (expand_intn_expr id size)
                                 else e
                  | None -> e) (* Not_found -> it's a boolean *)
    | Field (Var id,n) -> Var (id ^ (string_of_int n))
    | Tuple (l)    -> Tuple (flatten_expr (List.map (rewrite_expr env_var env_fun) l))
    | Op (Xor,x1::x2::[]) -> let t1 = rewrite_expr env_var env_fun x1 in
                             let t2 = rewrite_expr env_var env_fun x2 in
                             ( match t1, t2 with
                               | Var _, Var _ | Var _, Const _ | Var _, Field _
                               | Const _, Var _ | Const _, Const _ | Const _, Field _
                               | Field _, Var _ | Field _, Const _ | Field _, Field _
                                    -> Op(Or,
                                        [ Op(And, [ t1; Op(Not,[t2])] ) ;
                                          Op(And, [ Op(Not,[t1]);t2])])
                               | _ -> 
                                  let tmp1 = tmp_generator () in
                                  let tmp2 = tmp_generator () in
                                  env_add env_var tmp1 (get_size t1 env_fun);
                                  env_add env_var tmp2 (get_size t2 env_fun);
                                  let tmp1_pat = rewrite_pat [Ident tmp1] env_var in
                                  let tmp2_pat = rewrite_pat [Ident tmp2] env_var in
                                  let tmp1_expr = rewrite_expr env_var env_fun (Var tmp1) in
                                  let tmp2_expr = rewrite_expr env_var env_fun (Var tmp2) in
                                  before_deq := (tmp1_pat,t1) :: (tmp2_pat,t2) ::
                                                  !before_deq;
                                  (match tmp1_expr, tmp2_expr with
                                   | Tuple l1, Tuple l2 -> Tuple(combine_xor l1 l2)
                                   | _ -> Op(Or,
                                             [ Op(And, [ tmp1_expr; Op(Not,[tmp2_expr])] ) ;
                                               Op(And, [ Op(Not,[tmp1_expr]);tmp2_expr])])))
    | Op (op,x1::x2::[]) -> let t1 = rewrite_expr env_var env_fun x1 in
                            let t2 = rewrite_expr env_var env_fun x2 in
                            ( match t1, t2 with
                              | Var _, Var _ | Var _, Const _ | Var _, Field _
                              | Const _, Var _ | Const _, Const _ | Const _, Field _
                              | Field _, Var _ | Field _, Const _ | Field _, Field _
                                                                    -> Op(op,[t1;t2])
                              | _ -> 
                                 let tmp1 = tmp_generator () in
                                 let tmp2 = tmp_generator () in
                                 env_add env_var tmp1 (get_size t1 env_fun);
                                 env_add env_var tmp2 (get_size t2 env_fun);
                                 let tmp1_pat = rewrite_pat [Ident tmp1] env_var in
                                 let tmp2_pat = rewrite_pat [Ident tmp2] env_var in
                                 let tmp1_expr = rewrite_expr env_var env_fun (Var tmp1) in
                                 let tmp2_expr = rewrite_expr env_var env_fun (Var tmp2) in
                                 before_deq := (tmp1_pat,t1) :: (tmp2_pat,t2) ::
                                                 !before_deq;
                                 (match tmp1_expr, tmp2_expr with
                                  | Tuple l1, Tuple l2 -> Tuple(combine_op And l1 l2)
                                  | _ -> Op(op,[tmp1_expr;tmp2_expr])))
    | Op (Not,x::[]) -> let x = rewrite_expr env_var env_fun x in
                        ( match x with
                          | Var _ | Const _ | Access _ | Field _
                                                         -> Op(Not,[x])
                          | _ -> 
                             let tmp = tmp_generator () in
                             env_add env_var tmp (get_size x env_fun);
                             let tmp_pat = rewrite_pat [Ident tmp] env_var in
                             let tmp_expr = rewrite_expr env_var env_fun (Var tmp) in
                             before_deq := (tmp_pat,x) ::
                                             !before_deq;
                             ( match tmp_expr with
                               | Tuple l -> Tuple(distrib_not
                                                    (List.map (rewrite_expr env_var env_fun) l))
                               | _ -> Op(Not,[tmp_expr])))
    | Op (Not,l) -> Tuple(distrib_not (List.map (rewrite_expr env_var env_fun) l))
    | Op _ -> raise Invalid_operator_call
    | Fun (f,l)    -> if f = "print" then
                        if Aux.keep_print then
                          (match l with
                           | (Var id)::[] ->
                              (match env_fetch env_var id with
                               | Some size ->  if size > 1 then
                                                 let l = expand_intn_expr id size in
                                                 let name = Aux.gen_print l in
                                                 Fun(name, l)
                                               else Fun(f, l)
                               | None -> raise (Undeclared id))
                           | _ -> raise Invalid_operator_call)
                        else Nop
                      else
                        Fun(f, format_param f (List.map (rewrite_expr env_var env_fun) l) env_fun)
    | Mux (e,c,id) -> rewrite_expr env_var env_fun e
    | Demux(id,l)  -> raise (Not_implemented "Demux")
    | Fby(ei,ef,f)   -> Fby(rewrite_expr env_var env_fun ei, rewrite_expr env_var env_fun ef,f)
    | Nop -> Nop
    | _ -> raise (Invalid_AST "Non-conform AST")
                           
                           
  and rewrite_pat (pat: pat) (env: (ident, int) Hashtbl.t) : pat =
    match pat with
    | [] -> []
    | hd::tl -> (match hd with
                 | Ident id -> ( match env_fetch env id with
                                 | Some size -> 
                                    if size > 1 then expand_intn_pat id size
                                    else [ Ident id ]
                                 | None -> [ Ident id ] )
                 | Dotted(Ident id,n) -> [ Ident (id ^ (string_of_int n)) ]
                 | _ -> raise (Invalid_AST "Non-conform AST"))
                @ (rewrite_pat tl env)
                    
  and rewrite_deq (deq: deq) (env_var: (ident, int) Hashtbl.t) env_fun : deq =
    match deq with
    | [] -> []
    | (pat,expr) :: tl -> match expr with
                          | Nop -> rewrite_deq tl env_var env_fun
                          | _ -> before_deq := [];
                                 let e = (rewrite_pat pat env_var,
                                          rewrite_expr env_var env_fun expr) in
                                 let head = !before_deq @ [e] in
                                 head @ (rewrite_deq tl env_var env_fun)


  (* mostly converting the uint_n to bools *)
  and rewrite_p (p: p) =
    match p with
    | [] -> []
    | (id,typ,ck)::tl -> ( match typ with
                           | Bool  -> [ (id,Bool,ck) ]
                           | Int x -> expand_intn_typed id x ck
                           | Array _ -> raise (Invalid_AST
                                                 "Arrays should have been cleaned by now")
                         ) @ (rewrite_p tl)

                                                                      
  and rewrite_def (def: def) env_fun : def =
    match def with
    | Single (name, p_in, p_out, p_var, body) ->
       let env_var = Hashtbl.create 10 in
       env_add_var p_in env_var;
       env_add_var p_out env_var;
       env_add_var p_var env_var;
       env_add_fun name p_in p_out env_fun;
       Single(name, p_in, rewrite_p p_out, p_var, rewrite_deq body env_var env_fun)
    | Multiple _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                          "Multiple nodes should have been cleaned by now"))
    | Temporary _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                           "Temporary should be gone by now"))
    | Perm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                      "Perm should be gone by now"))
    | MultiplePerm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                          "MultiplePerm should have been cleaned by now"))
                              
  and rewrite_defs (l: def list)
                       (env_fun: (ident, int list * int) Hashtbl.t)
          : def list =
    match l with
    | [] -> []
    | hd::tl -> let hd' = (rewrite_def hd env_fun) in
                hd' :: (rewrite_defs tl env_fun)
                     
                     
  and rewrite_prog (p: prog) : prog =
    let env_fun = Hashtbl.create 10 in
    let usuba0_prog = (Usuba1_rewriter.rewrite_prog p) in
    let renamed_prog = rename_prog usuba0_prog in
    let (prints,entry_point) =
      Aux.gen_entry_point (Utils.last renamed_prog) in
    print_fun := prints;
    entry := entry_point ;
    let p' = rewrite_defs renamed_prog env_fun in
    (!aux_fun) @ p'

end
