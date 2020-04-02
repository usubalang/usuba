open Usuba_AST
open Basic_utils
open Utils
open Printf
open Pass_runner

exception Unsound of string


let compare_tables (orig:def) (norm:def)  =
  let nb_inputs = p_size norm.p_in in

  let out_size = p_size orig.p_out in
  for i = 0 to (pow 2 out_size) - 1 do
    let input = int_to_boollist i nb_inputs in
    let out_orig = Interp.Usuba.interp_table orig input in
    let out_norm = Interp.Usuba0.interp_node (Hashtbl.create 0) norm input in
    if out_orig <> out_norm then
      raise (Unsound (Printf.sprintf "%s: %d => expect:%d -- got:%d" orig.id.name i
                                     (boollist_to_int out_orig)
                                     (boollist_to_int out_norm)))
  done
  (* Printf.fprintf stderr "Table %s sound.\n" orig.id.name *)


let tables_sound (runner:pass_runner) (orig:prog) (normalized:prog) : unit =

  List.iter (fun x ->
             match x.node with
             | Table _ ->
                (try let normed =
                       List.find (fun def -> contains def.id.name x.id.name)
                                 normalized.nodes in
                     compare_tables x normed
                 with Not_found -> ())
             | _ -> ()) (runner#run_module ~conf:default_conf
                                           Expand_multiples.as_pass orig).nodes
