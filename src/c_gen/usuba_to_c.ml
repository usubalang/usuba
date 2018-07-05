open Usuba_AST
open Basic_utils
open Utils
       
let prog_to_c (prog:prog) (conf:config) : string =

  
  let prog = if conf.interleave > 0 then
               Interleave.interleave prog conf
             else prog in
  

  if conf.openmp > 1 then
    if conf.bench then
      GenC_omp_bench.gen_runtime prog conf
    else
      GenC_omp_std.gen_runtime prog conf      
  else
    if conf.runtime then
      if conf.rand_input then
        GenC_rand_bench.gen_runtime prog conf
      else
        if conf.bench then
          GenC_bench.gen_runtime prog conf
        else
          GenC_std.gen_runtime prog conf
    else
      GenC_standalone.gen_runtime prog conf

  
