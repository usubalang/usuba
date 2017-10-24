open Usuba_AST
open Nodes_to_c
open Utils
       

(* Note: this isn't a general function, but it will do for now *)       
let gen_runtime (orig:prog) (prog:prog) (conf:config) : string =
  
  let entry = List.(def_to_c (nth orig.nodes (length orig.nodes -1))
                             (nth prog.nodes (length prog.nodes -1))
                             true) in
  let prog_c = map_no_end (fun x -> def_to_c x x false) prog.nodes in

Printf.sprintf 
"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* Do NOT change the order of those define/include */

/* defining \"BENCH\" or \"STD\" */
/* (will impact the .h functions loaded by the .h) */
#define NO_RUNTIME
/* including the architecture specific .h */
#include \"%s\"

/* auxiliary functions */
%s

/* main function */
%s
"
  (c_header conf.archi)
  (join "\n\n" prog_c)
  entry
