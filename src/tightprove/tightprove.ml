open Usuba_AST
open Basic_utils
open Utils
open Printf

(* Not quite the same "is_call_free" as in the Inline module: that one
   doesn't care about _no_inline functions. *)
let is_call_free (def:def) : bool =
  let rec deq_call_free (deq:deq) : bool =
    match deq with
    | Eqn(_,Fun(f,_),_) ->
       if f.name = "refresh" then true
       else false
    | Eqn _ -> true
    | Loop(_,_,_,dl,_) -> List.for_all deq_call_free dl in
  match def.node with
  | Single(_,body) ->
     List.for_all deq_call_free body
  | _ -> false



let refresh_def (conf:config) (def:def) : def =
  if is_call_free def then
    let (vars_corres,tp_def) = Usuba_to_tightprove.usuba_to_tp def in
    let r_tp_def = Tp_IO.get_refreshed_def tp_def conf in
    Tightprove_to_usuba.tp_to_usuba vars_corres def r_tp_def
  else
    def

(* This is a simplified version that doesn't do inlining/unrolling. To
   improve.*)
let process_prog (prog:prog) (conf:config) : prog =
  { nodes = List.map (refresh_def conf) prog.nodes }
