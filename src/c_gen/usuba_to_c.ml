open Usuba_AST
open Utils
       
let prog_to_c (orig:prog) (prog:prog) (conf:config) : string =
  assert (Assert_lang.Usuba_norm.is_usuba_normalized prog);

  if conf.runtime then
    if conf.bench then
      Gen_bench_runtime.gen_runtime orig prog conf
    else
      Gen_std_runtime.gen_runtime orig prog conf
  else
    Gen_no_runtime.gen_runtime orig prog conf

  
