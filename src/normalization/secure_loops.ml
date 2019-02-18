open Usuba_AST
open Basic_utils
open Utils

(* Assumptions (TODO: fix those):
    - at most 1 loop per node
    - no need to secure static access
 *)
       
let deqs_contains_loop (deqs:deq list) : bool =
  List.exists (function Loop -> true | _ -> false) deqs

              
              
let secure_deqs (def:def) (vars:p) (body:deq list) : def =

  let nb_iter   = ref 0 in
  let to_secure = Hashtbl.create 100 in
  
  let body =
    flat_map (fun deq ->
              match deq with
              | Eqn _ -> deq
              | Loop(i,ei,ef,dl,opts) ->
                 let ei = eval_arith_ne ei in
                 let ef = eval_arith_ne ef in
                 let iter_count = ef - ei  in
                 List.iter (function
                             | Loop _ -> ()
                             | Eqn(lhs,e) -> find_vars_to_secure to_secure lhs e) dl;
                 
              
let secure_def (def:def) : def =
  match def with
  | Single(vars,body) ->
     if deqs_contains_loop body then
       secure_deqs def vars body
     else
       def
  | _ -> def

let secure_loops (prog:prog) (conf:config) : prog =
  if conf.secure_loops then
    { nodes = List.map secure_def prog.nodes }
  else
    prog
