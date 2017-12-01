(***************************************************************************** )
                              expand_array.ml                                 

   This module has several main functionalities:
    - Convert arrays of nodes into multiple nodes. 
    - Convert forall into a list of regular instructions.
    - Convert Ranges into multiple Tuples of Fields.
    - Convert Slices into multiple Tuples of Fields.
    - Convert access to arrays (variables) into access to variables
      (for instance, a[0] will become a'0)
    
    After this module has ran, there souldn't be any "Index" variable left, 
    nor any "Multiple" node.

( *****************************************************************************)

open Usuba_AST
open Utils
open Printf

(* Abstracting Hashtbl.
   This functions should replace the ones in Utils, one day. *)
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_fetch env v = Hashtbl.find env v
                                   

(* Returns the ident associated to the i'th element of id array. *)
let rec fetch_subarr (env:(string,ident) Hashtbl.t) (id:ident) (i:int) : ident =
  env_fetch env (sprintf "%s'%d" id.name i)

(* Generates the list of integers between i and f *)
let rec gen_list_bounds i f =
  if i < f then
    i :: (gen_list_bounds (i+1) f)
  else if i > f then
    i :: (gen_list_bounds (i-1) f)
  else [ f ]


(* Expand variables: arrays are converted to booleans *)
let rec expand_var (arith_env:(string,int) Hashtbl.t)
                   (ident_env:(string,ident) Hashtbl.t)
                   (type_env:(ident,int) Hashtbl.t)
                   (v:var) : var list =
  let rec_call = expand_var arith_env ident_env type_env in
  match v with
  (* If the variable has size 1 it's a boolean -> leave it as is,
     else, it's an array -> convert it to booleans *)
  | Var id -> ( match env_fetch type_env id with
                | 1 -> [ Var id ]
                | n -> List.flatten @@
                         List.map (fun x -> rec_call (Var(fetch_subarr ident_env id x)))
                                  (gen_list_0_int n) )
  (* Slices become Lists of variables *)
  | Slice(id,l) ->
     List.flatten @@
       (List.map (fun x -> rec_call (Var(fetch_subarr ident_env id
                                                      (eval_arith arith_env x)))) l)
  (* Ranges become Lists of variables *)
  | Range(id,ei,ef) ->
     let ei = eval_arith arith_env ei in
     let ef = eval_arith arith_env ef in
     List.flatten @@
       List.map (fun x -> rec_call (Var(fetch_subarr ident_env id x)))
                (gen_list_bounds ei ef)
  (* Index and u_n should be removed soon *)
  | _ -> assert false
       

(* Expand the variables inside an expression, and converted Fun_v to Fun *)
let rec expand_expr (arith_env:(string,int) Hashtbl.t)
                    (ident_env:(string,ident) Hashtbl.t)
                    (ident_fun_env:(string,ident) Hashtbl.t)
                    (type_env:(ident,int) Hashtbl.t)
                    (e:expr) : expr =
  let rec_call = expand_expr arith_env ident_env ident_fun_env type_env in
  match e with
  | Const _  -> e
  | ExpVar v -> Tuple(List.map (fun x -> ExpVar x)
                               (expand_var arith_env ident_env type_env v))
  | Tuple l  -> Tuple(List.map rec_call l)
  | Not e    -> Not (rec_call e)
  | Shift(op,e,ae)  -> Shift(op,rec_call e,ae)
  | Log(op,e1,e2)   -> Log(op,rec_call e1,rec_call e2)
  | Arith(op,e1,e2) -> Arith(op,rec_call e1,rec_call e2)
  | Fun(f,l)        -> Fun(f,List.map rec_call l)
  | Fun_v(f,ae,l)   -> Fun(fetch_subarr ident_fun_env f
                                        (eval_arith arith_env ae),
                           List.map rec_call l)
  | When(e,x,y)     -> When(rec_call e,x,y)
  | Merge(x,l)      -> Merge(x,List.map (fun (c,e) -> c,rec_call e) l)
  | _ -> assert false

(* Expand the variables inside deq, and remove Rec *)
let rec expand_deqs (arith_env:(string,int) Hashtbl.t)
                    (ident_env:(string,ident) Hashtbl.t)
                    (ident_fun_env:(string,ident) Hashtbl.t)
                    (type_env:(ident,int) Hashtbl.t)
                    (deqs:deq list) : deq list =
  List.flatten @@
    List.map
      (fun deq ->
       match deq with
       | Norec(lhs,e) ->
          [ Norec(List.(flatten @@ map (expand_var arith_env ident_env type_env) lhs),
                  expand_expr arith_env ident_env ident_fun_env type_env e) ]
       | Rec(x,ei,ef,l) ->
          let ei = eval_arith arith_env ei in
          let ef = eval_arith arith_env ef in
          let eqs =
            List.flatten @@
              List.map (fun i -> Hashtbl.replace arith_env x.name i;
                                 expand_deqs arith_env ident_env
                                             ident_fun_env type_env l)
                       (gen_list_bounds ei ef) in
          Hashtbl.remove arith_env x.name;
          eqs) deqs

(* For the coherence of "ident", the functions make_env and expand_p should be
   combined into a single function. (It's not hard to do btw)
   Otherwise, the "ident" from the env are not the same as the ones from p_in/out/vars *)
                        
(* Expand 'p' variables: Booleans are left as is, and array expanded to booleans *)
let expand_p (p:p) : p =
  (* Need an auxiliary function operating on a single var to allow reccursion *)
  let rec aux v =
    let ((id,typ),ck) = v in
    match typ with
    | Bool -> [ v ]
    | Array(t,s) -> let size = eval_arith (make_env ()) s in
                    List.flatten @@
                      List.map (fun i -> aux ((fresh_suffix id (sprintf "%d'" i),
                                               t),ck)) (gen_list_0_int size)
    | _ -> assert false in
  (* Actually expand the list of variables *)
  List.flatten @@ List.map aux p


(* Create two environments:
    - ident_env contains variables names and their corresponding "ident"
    - type_env  contains the size associated to each variable 
                (even the one resulting from expansion of arrays) *)
let make_env_from_p (p_in:p) (p_out:p) (vars:p) =
  let ident_env = make_env () in
  let type_env : (ident,int) Hashtbl.t = make_env () in
  (* A function identical to expand_p, but which stores intermediate variables *)
  let expand_p_for_env (p:p) =
    let rec aux v =
      let ((id,typ),ck) = v in
      match typ with
      | Bool -> env_add ident_env id.name id;
                env_add type_env id 1
      | Array(t,s) -> env_add ident_env id.name id;
                      env_add type_env id (typ_size typ);
                      let size = eval_arith (make_env ()) s in
                      List.iter (fun i -> aux ((fresh_suffix id (sprintf "%d'" i),
                                                t),ck)) (gen_list_0_int size)
      | _ -> assert false in
    List.iter aux p in

  expand_p_for_env p_in;
  expand_p_for_env p_out;
  expand_p_for_env vars;

  ident_env, type_env
      
    
                        
(* Expand the variables in the params & body of a 'def' *)
(* We assume that Multiple nodes have already been removed *)
let expand_def ident_fun_env (def:def) : def =
  { def with p_in  = expand_p def.p_in;
             p_out = expand_p def.p_out;
             node  = match def.node with
                     | Single(vars,body) ->
                        (* Building environments of variables and types *)
                        let (ident_env,type_env) =
                          make_env_from_p def.p_in def.p_out vars in
                        Single(expand_p vars,
                               (* Expanding variables in the equations *)
                               expand_deqs (make_env ())
                                           ident_env
                                           ident_fun_env
                                           type_env body)
                     | _ -> def.node }
                                                     

(* Expand "Multiple" to several "Single" *)
let rec expand_multiple (defs:def list) : def list =
  List.flatten @@
    List.map (fun def -> 
              match def.node with
              | Multiple nodes ->
                 List.mapi (fun i (vars,body) ->
                            { def with id = fresh_suffix def.id (sprintf "%d'" i);
                                       node = Single(vars,body) }) nodes
              | _ -> [ def ]) defs

             
let rec expand_array (prog:prog) : prog =
  let ident_fun_env = make_env () in
  
  (* Removing 'Multiple' *)
  (* (and build the environment of functions at the same time *)
  let no_multiple = 
    List.flatten @@
      List.map (fun def -> 
                match def.node with
                | Multiple nodes ->
                   List.mapi (fun i (vars,body) ->
                              let new_id = fresh_suffix def.id (sprintf "%d'" i) in
                              env_add ident_fun_env new_id.name new_id;
                              { def with id = new_id;
                                         node = Single(vars,body) }) nodes
                | _ -> env_add ident_fun_env def.id.name def.id;
                       [ def ]) prog.nodes in
             
  (* Removing arrays in the nodes *)
  { nodes = List.map (expand_def ident_fun_env) no_multiple }



     
(*       

       
let expand_var_array id size =
  (* List.map (fun x -> Var (fresh_suffix x "'")) (gen_list_0 id size) *)
  List.map (fun x -> Index(id,Const_e x)) (gen_list_0_int size)



let rec expand_var_range (v:var) : var list =
  
  let rec expand_range id i n acc =
    if i = n then
      (* List.rev (Var(fresh_suffix id ((string_of_int i) ^ "'")) :: acc) *)
      List.rev (Index(id,Const_e i) :: acc)
    else
      (* expand_range id (i+1) n (Var(fresh_suffix id ((string_of_int i) ^ "'")) :: acc) *)
      expand_range id (i+1) n (Index(id,Const_e i) :: acc)
  in
  
  match v with
  | Range(id,Const_e ei,Const_e ef) ->
     expand_range id ei ef []
  | Slice(id,l) -> List.flatten @@
                     List.map
                     expand_var_range
                     (List.map (fun n -> Index(id,n)) l)
  | Field(v',e) -> ( match expand_var_range v' with
                     | x::[] -> [ Field(x,e) ]
                     | l -> List.map (fun x -> Field(x,e)) l )
  | _ -> [ v ]
           
           
let expand_pat_range (pat:var list) : var list =
  List.flatten @@ List.map expand_var_range pat

let rec expand_expr_range (e:expr) : expr =
  Norm_tuples.Simplify_tuples.simpl_tuple
    (match e with
     | Const _  -> e
     | ExpVar v -> Tuple(List.map (fun x -> ExpVar x) (expand_var_range v))
     | Tuple l  -> Tuple (List.map expand_expr_range l)
     | Not e    -> Not (expand_expr_range e)
     | Shift(op,e,n) -> Shift(op,expand_expr_range e,n)
     | Log(op,x,y)   -> Log(op,expand_expr_range x,expand_expr_range y)
     | Arith(op,x,y) -> Arith(op,expand_expr_range x,expand_expr_range y)
     | Fun(f,l)      -> Fun(f,List.map expand_expr_range l)
     | Fun_v(f,n,l)  -> Fun_v(f,n,List.map expand_expr_range l)
     | Fby(x,y,f)    -> Fby(expand_expr_range x,expand_expr_range y,f)
     | When(e,x,c)   -> When(expand_expr_range e,x,c)
     | Merge(x,l)    -> Merge(x,List.map (fun (c,e) -> c,expand_expr_range e) l))
          
let rec rewrite_expr (loc_env: int env) env_var (e:expr) : expr =
  let rec_call = rewrite_expr loc_env env_var in
  match e with
  | Const _ -> e
  | ExpVar(Field(v,e)) -> ExpVar(Field(v,Const_e(eval_arith loc_env e)))
  | ExpVar(Var v) -> ( match env_fetch loc_env v with
                       | Some n -> Const n
                       | None ->
                          match env_fetch env_var v with
                          | Some size ->
                             Tuple(List.map (fun x -> rec_call (ExpVar x))
                                            (expand_var_array v size))
                          | None -> ExpVar(Var v))
  | ExpVar(Index(v,idx)) -> let n = eval_arith loc_env idx in
                            ExpVar(Var(fresh_suffix v ((string_of_int n) ^ "'")))
  | ExpVar(Range(v,ei,ef)) ->
     ExpVar(Range(v, Const_e(eval_arith loc_env ei),
                  Const_e(eval_arith loc_env ef)))
  | ExpVar(Slice(v,l)) ->
     ExpVar(Slice(v,List.map (fun n -> Const_e(eval_arith loc_env n)) l))
  | Tuple l -> Tuple (List.map rec_call l)
  | Not e -> Not (rec_call e)
  | Log(op,x,y) -> Log(op,rec_call x,rec_call y)
  | Arith(op,x,y) -> let x' = rec_call x in
                     let y' = rec_call y in
                     ( match x',y' with
                       | Const a, Const b ->
                          (match op with
                           | Add -> Const (a + b)
                           | Mul -> Const (a * b)
                           | Sub -> Const (a - b)
                           | Div -> Const (a / b)
                           | Mod -> Const (a mod b))
                       | _ -> Arith(op,rec_call x,rec_call y) )
  | Shift(op,e,n) -> Shift(op,rec_call e, Const_e(eval_arith loc_env n))
  | Fun(f,l) -> Fun(f,List.map rec_call l)
  | Fun_v(f,e,l) -> let idx = eval_arith loc_env e in
                    let f' = fresh_suffix f (string_of_int idx) in
                    rec_call (Fun(f',l))
  | When(e,c,x) -> When(rec_call e,c,x)
  | Merge(x,l)  -> Merge(x,List.map (fun (c,e) -> c,rec_call e) l)
  | Fby _ -> raise (Not_implemented "FBY")
             

let rec rewrite_pat env env_var (pat:var list) : var list =
  let rec aux x = match x with
    | Var v -> (match env_fetch env_var v with
                | Some size -> rewrite_pat env env_var (expand_var_array v size)
                | None -> [ Var v ])
    | Field(lasgn,i) -> let i' = eval_arith env i in
                        [ Field(List.nth (aux lasgn) 0,Const_e i') ]
    | Index(id,e) -> let n = eval_arith env e in
                     [ Var(fresh_suffix id ((string_of_int n) ^ "'")) ] 
    | Range(id,ei,ef) -> [ Range(id,Const_e(eval_arith env ei),
                                 Const_e(eval_arith env ef))]
    | Slice(id,l) -> [ Slice(id,List.map (fun n -> Const_e(eval_arith env n)) l) ] in
  List.flatten @@ List.map aux pat
           
let rewrite_rec env_var (iterator:ident) (startr:arith_expr) (endr:arith_expr)
                (pat:var list) (e:expr) : deq list =
  let env = Hashtbl.create 10 in
  let i_init = eval_arith env startr in
  let i_end  = eval_arith env endr in
  let body = ref [] in
  for i = i_init to i_end do
    env_add env iterator i;
    let pat_i  = rewrite_pat env env_var pat in
    let expr_i = rewrite_expr env env_var e in
    body := !body @ [ Norec(pat_i, expr_i) ]
  done;
  !body

let rec rewrite_p p =
  List.flatten @@
    List.map
      (fun ((id,typ),ck) ->
        match typ with
        | Bool -> [ ((id,Bool),ck) ]
        | Int n -> [ ((id, Int n), ck) ]
        | Nat -> [ ((id, Nat), ck) ]
        | Array (typ_in, Const_e size) ->
           List.map (fun x -> ((fresh_suffix x "'",typ_in),ck)) (gen_list_0 id size)
        | _ -> raise (Error "Invalid array size")) p

let make_env p_in p_out vars =
  let env = Hashtbl.create 10 in
  let f = List.iter (fun ((id,typ),ck) ->
               match typ with
               | Array(in_typ,Const_e size) -> env_add env id size
               | _ -> ()) in
  f p_in;
  f p_out;
  f vars;
  env
  
let rewrite_deqs p_in p_out vars (deqs:deq list) : deq list =
  let env_var = make_env p_in p_out vars in
  let rec aux env deq =
    match deq with
    | Norec(vars,e) ->
       [ Norec(rewrite_pat env env_var (expand_pat_range (rewrite_pat env env_var vars)),
               rewrite_expr env env_var (expand_expr_range (rewrite_expr env env_var e))) ]
    | Rec(i,startr,endr,d) ->
       let i_init = eval_arith env startr in
       let i_end  = eval_arith env endr in
       List.flatten @@
         List.map (fun v -> Hashtbl.add env i.name v;
                            let l = List.flatten @@ List.map (aux env) d in
                            Hashtbl.remove env i.name;
                            l) (gen_list_bound i_init i_end)
  in
  List.flatten @@
    List.map (fun x -> aux (Hashtbl.create 10) x) deqs

             
let expand_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with p_in = rewrite_p def.p_in;
                p_out = rewrite_p def.p_out;
                node = Single(rewrite_p vars,
                              rewrite_deqs def.p_in def.p_out vars body ) }
  | _ -> def
       
let expand_array (prog: prog) : prog =
  (* Converting arrays of nodes to single nodes *)
  let prog' = 
    List.flatten @@
      List.map (fun x -> match x.node with
                         | Multiple nodes ->
                            List.mapi (fun i (vars,body) ->
                                       { x with id = fresh_suffix x.id (string_of_int i);
                                                node = Single(vars,body) }) nodes
                         | _ -> [ x ] ) prog.nodes in

  (* Actually removing arrays *)
  let expanded =
    List.map (fun def ->
              match def.node with
              | Single(vars,body) ->
                 { def with p_in = rewrite_p def.p_in;
                            p_out = rewrite_p def.p_out;
                            node = Single(rewrite_p vars,
                                          rewrite_deqs def.p_in def.p_out vars body ) }
              | _ -> def) prog' in
  
  { nodes = expanded } 
    
 *)
