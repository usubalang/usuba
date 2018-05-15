open Usuba_AST
open Basic_utils
open Utils

       
let expand_multiples (prog:prog) (conf:config) : prog =
  { nodes =
      flat_map (fun def ->
                match def.node with
                | Multiple l ->
                   List.mapi (fun i x ->
                              { def with id = fresh_suffix def.id (Printf.sprintf "%d'" i); 
                                         node = x; })
                             l
                | _ -> [ def ] ) prog.nodes }
