open Usuba_AST
open Basic_utils
open Utils
open Printf

let run_pass title func conf prog =
  if conf.verbose >= 5 then
    Printf.fprintf stderr "Running %s...\n" title;
  let res = func prog conf in
  if conf.verbose >= 5 then
    Printf.fprintf stderr "%s done.\n" title;
  if conf.verbose >= 100 then
    Printf.fprintf stderr "%s\n" (Usuba_print.prog_to_str res);
  res

    
let norm_prog (prog: prog) (conf:config) =

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in

  prog |>
    (run_pass "Expand_const" Expand_const.expand_prog) |>
    (run_pass "Unfold_unnest" Unfold_unnest.norm_prog) |>
    (run_pass "Expand_array (bitslice)" Expand_array.expand_array) |>
    (run_pass "Expand_permut" Expand_permut.expand_permut) |>
    (run_pass "Norm_tuples.norm_tuples 1" Norm_tuples.norm_tuples) |>
    (run_pass "Bitslice_shift" Bitslice_shift.expand_shifts) |>
    (run_pass "Norm_tuples.norm_tuples 2" Norm_tuples.norm_tuples)
