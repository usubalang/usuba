open Usuba_AST
open Basic_utils
open Utils
       
let prog_to_c (prog:prog) (conf:config) : string =

  
  let prog = if conf.interleave > 0 then
               Interleave.interleave prog conf
             else prog in
  
  GenC_standalone.gen_runtime prog conf

  
