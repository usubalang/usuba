open Usuba_AST
open Basic_utils
open Utils
open Printf

open Print_tp

let process_prog (prog:prog) (conf:config) : prog =
  Usuba_to_tightprove.print_prog prog;
  prog
