open Usuba_AST
open Utils

let def_to_c (def:def) : string =
  match def with
  | Single(id,p_in,p_out,vars,body) ->
     
       
let prog_to_c (prog:prog) : string =
  assert (Assert_lang.Usuba_norm.is_usuba_normalized prog);
  let prog = Choose_instr.choose_instr prog in
  assert (Assert_lang.Usuba_intrinsics.is_only_intrinsics prog);
  join "\n\n" (List.map def_to_c prog)
