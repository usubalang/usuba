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
let print_env env = ignore(Hashtbl.fold (fun k v n -> printf "%s:%d\n" k.name n; 1) env 0)
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_fetch env v = Hashtbl.find env v

(* Note: this version of "typ_size" returns 1 for an Int *)
let rec typ_size (typ:typ) : int =
  match typ with
  | Bool -> 1
  | Int _ -> 1 
  | Array(t,n) -> (eval_arith (Hashtbl.create 1) n)*(typ_size t)
  | _ -> raise (Error "Invalid Array with non-const size")                                   

let rec fetch_subarr (id:ident) (i:int) : ident =
  fresh_suffix id (sprintf "%d'" i)

(* Generates the list of integers between i and f *)
let rec gen_list_bounds i f =
  if i < f then
    i :: (gen_list_bounds (i+1) f)
  else if i > f then
    i :: (gen_list_bounds (i-1) f)
  else [ f ]


(* Expand variables: arrays are converted to booleans *)
let rec expand_var (arith_env:(string,int) Hashtbl.t)
                   (type_env:(ident,int) Hashtbl.t)
                   (v:var) : var list =
  let rec_call = expand_var arith_env type_env in
  match v with
  (* If the variable has size 1 it's a boolean -> leave it as is,
     else, it's an array -> convert it to booleans *)
  | Var id ->
     ( match env_fetch type_env id with
                | 1 -> [ Var id ]
                | n -> List.flatten @@
                         List.map (fun x -> rec_call (Var(fetch_subarr id x)))
                                  (gen_list_0_int n) )
  (* Slices become Lists of variables *)
  | Slice(id,l) ->
     List.flatten @@
       (List.map (fun x -> rec_call (Var(fetch_subarr id
                                           (eval_arith arith_env x)))) l)
  (* Ranges become Lists of variables *)
  | Range(id,ei,ef) ->
     let ei = eval_arith arith_env ei in
     let ef = eval_arith arith_env ef in
     List.flatten @@
       List.map (fun x -> rec_call (Var(fetch_subarr id x)))
                (gen_list_bounds ei ef)
  (* Index and u_n should be removed soon *)
  | Index(id,e) -> let e = eval_arith arith_env e in
                   rec_call (Var(fetch_subarr id e))
  (* | Field(var,e) -> let e = eval_arith arith_env e in
                    [ List.nth (rec_call var) e ] *)
  | Field(_,_)  -> [ v ]
       

(* Expand the variables inside an expression, and converted Fun_v to Fun *)
let rec expand_expr (arith_env:(string,int) Hashtbl.t)
                    (type_env:(ident,int) Hashtbl.t)
                    (e:expr) : expr =
  let rec_call = expand_expr arith_env type_env in
  match e with
  | Const _  -> e
  | ExpVar v -> Tuple(List.map (fun x -> ExpVar x)
                               (expand_var arith_env type_env v))
  | Tuple l  -> Tuple(List.map rec_call l)
  | Not e    -> Not (rec_call e)
  | Shift(op,e,ae)  -> Shift(op,rec_call e,ae)
  | Log(op,e1,e2)   -> Log(op,rec_call e1,rec_call e2)
  | Arith(op,e1,e2) -> Arith(op,rec_call e1,rec_call e2)
  | Fun(f,l)        -> Fun(f,List.map rec_call l)
  | Fun_v(f,ae,l)   -> Fun(fresh_suffix f (string_of_int (eval_arith arith_env ae)),
                           List.map rec_call l)
  | When(e,x,y)     -> When(rec_call e,x,y)
  | Merge(x,l)      -> Merge(x,List.map (fun (c,e) -> c,rec_call e) l)
  | _ -> assert false

(* Expand the variables inside deq, and remove Rec *)
let rec expand_deqs (arith_env:(string,int) Hashtbl.t)
                    (type_env:(ident,int) Hashtbl.t)
                    (deqs:deq list) : deq list =
  List.flatten @@
    List.map
      (fun deq ->
        match deq with
        | Norec(lhs,e) ->
           [ Norec(List.(flatten @@ map (expand_var arith_env type_env) lhs),
                   expand_expr arith_env type_env e) ]
        | Rec(x,ei,ef,l) ->
           let ei = eval_arith arith_env ei in
           let ef = eval_arith arith_env ef in
           let eqs =
             List.flatten @@
               List.map (fun i -> Hashtbl.replace arith_env x.name i;
                                  expand_deqs arith_env type_env l)
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
    | Int _ -> [ v ]
    | _ -> assert false in
  (* Actually expand the list of variables *)
  List.flatten @@ List.map aux p


(* Create the environment containing the size associated to each variable 
   (even the one resulting from expansion of arrays) *)
let make_env_from_p (p_in:p) (p_out:p) (vars:p) =
  let type_env : (ident,int) Hashtbl.t = make_env () in
  (* A function identical to expand_p, but which stores intermediate variables *)
  let expand_p_for_env (p:p) =
    let rec aux v =
      let ((id,typ),ck) = v in
      match typ with
      | Bool -> env_add type_env id 1
      | Array(t,s) -> env_add type_env id (typ_size typ);
                      let size = eval_arith (make_env ()) s in
                      List.iter (fun i -> aux ((fresh_suffix id (sprintf "%d'" i),
                                                t),ck)) (gen_list_0_int size)
      (* TODO: remove Int *)
      | Int _ -> env_add type_env id 1
      (* | Int(n,m) -> env_add type_env id m; *)
      (*               List.iter (fun i -> aux ((fresh_suffix id (sprintf "%d'" i), *)
      (*                                         Int(n,1)),ck)) (gen_list_0_int m) *)
      | _ -> assert false in
    List.iter aux p in

  expand_p_for_env p_in;
  expand_p_for_env p_out;
  expand_p_for_env vars;

  type_env
      
    
                        
(* Expand the variables in the params & body of a 'def' *)
(* We assume that Multiple nodes have already been removed *)
let expand_def (def:def) : def =
  { def with p_in  = expand_p def.p_in;
             p_out = expand_p def.p_out;
             node  = match def.node with
                     | Single(vars,body) ->
                        (* Building environments of variables and types *)
                        let type_env = make_env_from_p def.p_in def.p_out vars in
                        Single(expand_p vars,
                               (* Expanding variables in the equations *)
                               expand_deqs (make_env ()) type_env body)
                     | _ -> def.node }
    

             
let rec expand_array (prog:prog) : prog =

  (* Removing 'Multiple' *)
  let no_multiple = 
    flat_map (fun def -> 
              match def.node with
              | Multiple nodes ->
                 List.mapi (fun i (vars,body) ->
                            { def with id = fresh_suffix def.id (sprintf "%d'" i);
                                       node = Single(vars,body) }) nodes
              | _ -> [ def ]) prog.nodes in
             
  (* Removing arrays in the nodes *)
  { nodes = List.map expand_def no_multiple }

