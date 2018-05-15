open Usuba_AST
open Basic_utils
open Utils
open Printf
     

let print title body conf =
  if conf.verbose >= 5 then
    begin
      print_endline title;
      if conf.verbose >= 100 then print_endline (Usuba_print.prog_to_str body)
    end
            

let run_pass title func conf prog =
  if conf.verbose >= 5 then
    Printf.printf "Running %s...\n" title;
  let res = func prog conf in
  if conf.verbose >= 5 then
    Printf.printf "%s done.\n" title;
  if conf.verbose >= 100 then
    Printf.printf "%s\n" (Usuba_print.prog_to_str res);
  res
    
(* Note: the print actually if the boolean if the function "print" above 
         are set to true (or at least the first one) *)
let norm_prog (prog: prog) (conf:config) =

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in

  prog |>
    (run_pass "Norm_uintn" Norm_uintn.norm_uintn) |>
    (run_pass "Expand_const" Expand_const.expand_prog) |>
    (run_pass "Unfold_unnest" Unfold_unnest.norm_prog) |>
    (run_pass "Expand_permut" Expand_permut.expand_permut) |>
    (run_pass "Norm_tuples.Split_tuples 1" Norm_tuples.Split_tuples.split_tuples) |>
    (run_pass "Norm_tuples.Simplify_tuples 1" Norm_tuples.Simplify_tuples.simplify_tuples) |>
    (run_pass "Bitslice_shift" Bitslice_shift.expand_shifts) |>
    (run_pass "Norm_tuples.Split_tuples 2" Norm_tuples.Split_tuples.split_tuples) |>
    (run_pass "Norm_tuples.Simplify_tuples 2" Norm_tuples.Simplify_tuples.simplify_tuples)
