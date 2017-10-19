open Usuba_AST
open Utils

exception Unsound of string

let compare_tables (orig:def) (norm:def)  =
  let nb_inputs = p_size norm.p_in in
  
  let out_size = p_size orig.p_out in
  for i = 0 to (pow 2 out_size) - 1 do
    let input = int_to_boollist i nb_inputs in
    let out_orig = Interp.Usuba.interp_table orig input in
    let out_norm = Interp.Usuba0.interp_node (Hashtbl.create 0) norm input in
    if out_orig <> out_norm then
      raise (Unsound (Printf.sprintf "%s: %d => %d vs %d" orig.id i
                                     (boollist_to_int out_orig)
                                     (boollist_to_int out_norm)))    
  done
  (* Printf.fprintf stderr "Table %s sound.\n" orig.id *)
    

let tables_sound (orig:prog) (normalized:prog) : unit =
  let tables = Hashtbl.create 10 in
  List.iter (fun x -> match x.node with
                      | Table _ -> env_add tables x.id x
                      | _ -> ()) orig.nodes;
  List.iter (fun x -> if env_contains tables x.id then
                        compare_tables (Hashtbl.find tables x.id) x) normalized.nodes;
