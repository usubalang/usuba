open Usuba_AST
open Pass_runner

exception Unsound of string

let compare_tables (orig : def) (norm : def) =
  let nb_inputs = Utils.p_size norm.p_in in

  let out_size = Utils.p_size orig.p_out in
  for i = 0 to Basic_utils.pow 2 out_size - 1 do
    let input = Basic_utils.int_to_boollist i nb_inputs in
    let out_orig = Interp.Usuba.interp_table orig input in
    let out_norm = Interp.Usuba0.interp_node (Hashtbl.create 0) norm input in
    if out_orig <> out_norm then
      raise
        (Unsound
           (Format.asprintf "%a: %d => expect:%d -- got:%d" (Ident.pp ())
              orig.id i
              (Basic_utils.boollist_to_int out_orig)
              (Basic_utils.boollist_to_int out_norm)))
  done
(* Printf.fprintf stderr "Table %s sound.\n" orig.id.name *)

let tables_sound (runner : pass_runner) (orig : prog) (normalized : prog) : unit
    =
  List.iter
    (fun x ->
      match x.node with
      | Table _ -> (
          try
            let normed =
              List.find
                (fun def ->
                  Basic_utils.contains (Ident.name def.id) (Ident.name x.id))
                normalized.nodes
            in
            compare_tables x normed
          with Not_found -> ())
      | _ -> ())
    (runner#run_module ~conf:Utils.default_conf Expand_multiples.as_pass orig)
      .nodes
