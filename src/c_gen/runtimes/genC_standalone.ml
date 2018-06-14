open Usuba_AST
open Nodes_to_c
open Basic_utils
open Utils
       

(* Note: this isn't a general function, but it will do for now *)       
let gen_runtime (prog:prog) (conf:config) : string =
  
  let entry = List.(def_to_c (nth prog.nodes (length prog.nodes -1))
                             true conf) in
  let prog_c = map_no_end (fun x -> def_to_c x false conf) prog.nodes in

Printf.sprintf 
"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

/* Do NOT change the order of those define/include */

#define NO_RUNTIME
#ifndef BITS_PER_REG
#define BITS_PER_REG %d
#endif
/* including the architecture specific .h */
#include \"%s\"

/* auxiliary functions */
%s

/* main function */
%s
 "
  (if conf.archi = Std then conf.bits_per_reg else 64)
  (c_header conf.archi)
  (join "\n\n" prog_c)
  entry
