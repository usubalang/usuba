(***************************************************************************** )
                              expand_array.ml                                 

( *****************************************************************************)

open Usuba_AST
open Utils
open Printf

(* To notify calling function that unrolling is necessary *)
exception Need_unroll
            
(* Abstracting Hashtbl.
   This functions should replace the ones in Utils, one day. *)
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error ("Not found: " ^ v.name))


(* If the program contains permutations, then arrays must be unrolled
 This is a bit of a simplification: 
  - The permutation could be at some point where it doesn't impact unrolling
  - Dummy assigments are a sign that indicates that arrays should be unrolled as well
 *)
let must_expand (prog:prog) =
  List.exists (fun x -> match x.node with Perm _ -> true | _ -> false) prog.nodes

let rec uses_var (e:arith_expr) : bool =
  match e with
  | Const_e _ -> false
  | Var_e _ -> true
  | Op_e(_,e1,e2) -> (uses_var e1) && (uses_var e2)

let rec remove_arr (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v',Const_e i) ->
     begin
       match remove_arr v' with
       | Var id -> Var(fresh_suffix id (sprintf "%d'" i))
       | _ -> assert false
     end
  | _ -> assert false
                                        
let rec expand_var env_var env force (v:var) : var list =
  let rec aux (v:var) : var list = 
    match v with
    | Var _ -> [ v ]
    | Index(v',i) -> List.map (fun x -> Index(x,simpl_arith env i)) (aux v')
    | Range(v',ei,ef) -> (try
                             let ei = eval_arith env ei in
                             let ef = eval_arith env ef in
                             flat_map (fun i -> aux (Index(v',Const_e i)))
                                      (gen_list_bounds ei ef)
                                      (* The Not_found can be raised by the calls to eval_arith *)
                           with Not_found -> raise Need_unroll)
    | Slice(v',el) -> flat_map (fun i -> aux (Index(v',i))) el in
  if force then
    List.map remove_arr (flat_map (Utils.expand_var env_var) (aux v))
  else
    aux v
                             
let expand_vars env_var env force (vars:var list) : var list =
  flat_map (expand_var env_var env force) vars
           
let rec expand_expr env_var env force (e:expr) : expr =
  let rec_call = expand_expr env_var env force in
  match e with
  | Const _ -> e
  | ExpVar v -> Tuple(List.map (fun x -> ExpVar x) (expand_var env_var env force v))
  | Tuple el -> Tuple(List.map rec_call el)
  | Not e' -> Not (rec_call e')
  | Shift(op,e1,ae) -> Shift(op,rec_call e1,ae)
  | Log(op,e1,e2) -> Log(op,rec_call e1,rec_call e2)
  | Shuffle(v,pat) -> Tuple(List.map (fun x -> Shuffle(x,pat)) (expand_var env_var env force v))
  | Arith(op,e1,e2) -> Arith(op,rec_call e1,rec_call e2)
  | Fun(f,el) -> Fun(f,List.map rec_call el)
  | Fun_v(f,ae,el) -> (try Fun(fresh_suffix f (sprintf "%d'" (eval_arith env ae)),
                               List.map rec_call el)
                       with Not_found -> raise Need_unroll)
  | Fby _ | When _ | Merge _ -> e


let rec do_unroll env_var env force x ei ef deqs : deq list =
  try
    let ei = eval_arith env ei in
    let ef = eval_arith env ef in
    let eqs = flat_map (fun i -> env_update env x i;
                                 expand_deqs env_var ~env:env force deqs)
                       (gen_list_bounds ei ef) in
    env_remove env x;
    eqs
  with Not_found -> raise Need_unroll

and expand_deqs env_var ?(env=make_env ()) (force:bool) (deqs:deq list) : deq list =
  flat_map
    (fun deq -> 
     match deq with
     | Norec(lhs,e) -> [ Norec(expand_vars env_var env force lhs, expand_expr env_var env force e) ]
     | Rec(x,ei,ef,deqs,opts) ->
        if List.mem Unroll opts || force then
          do_unroll env_var env force x ei ef deqs
        else
          try
            [ Rec(x,ei,ef,expand_deqs env_var ~env:env force deqs,opts) ]
          with Need_unroll -> do_unroll env_var env force x ei ef deqs)
    deqs
    

let expand_p (p:p) : p =
  let rec aux v =
    let ((id,typ),ck) = v in
    match typ with
    | Bool -> [ v ]
    | Array(t,s) -> let size = eval_arith (make_env ()) s in
                    flat_map (fun i -> aux ((fresh_suffix id (sprintf "%d'" i), t),ck))
                             (gen_list_0_int size)
    | Int(n,1) -> [ v ]
    | Int(n,m) -> flat_map (fun i -> aux ((fresh_suffix id (sprintf "%d'" i), Int(n,1)),ck))
                           (gen_list_0_int m)
    | _ -> assert false in
  flat_map aux p

           
let expand_def (force:bool) (def:def) : def =
  let expand_p = if force then expand_p else (fun x -> x) in
  { def with p_in  = expand_p def.p_in;
             p_out = expand_p def.p_out;
             node  = match def.node with
                     | Single(vars,body) ->
                        let env_var = build_env_var def.p_in def.p_out vars in
                        Single(expand_p vars, expand_deqs env_var force body)
                     | _ -> def.node }
    

    
let rec expand_array (prog:prog) (conf:config): prog =
  let force = conf.no_arr || must_expand prog in
  { nodes = List.map (expand_def force) prog.nodes }

