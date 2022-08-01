(* ****************************************************************
                          clear_origins.ml

   This module removes all origins from the programs:

      - all var_d's vd_orig fields are set to []

      - all deq's orig fields are set to [].
*)

open Prelude
open Usuba_AST

let rec clear_deqs (deqs : deq list) : deq list =
  List.map
    (fun d ->
      {
        orig = [];
        content =
          (match d.content with
          | Eqn _ -> d.content
          | Loop (i, ei, ef, dl, opts) -> Loop (i, ei, ef, clear_deqs dl, opts));
      })
    deqs

let clear_vd (vd : var_d) : var_d = { vd with vd_orig = [] }

let clear_def (def : def) : def =
  let p_in = List.map clear_vd def.p_in in
  let p_out = List.map clear_vd def.p_out in
  {
    def with
    p_in;
    p_out;
    node =
      (match def.node with
      | Single (vars, body) ->
          let vars = List.map clear_vd vars in
          let body = clear_deqs body in
          Single (vars, body)
      | _ -> def.node);
  }

let run _ prog _ = { nodes = List.map clear_def prog.nodes }
let as_pass = (run, "Clear_origins", 0)
