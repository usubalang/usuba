(******************************************************************* )
                              simple_opts.ml

   This module just runs basic optimisations:
     - Constant Folding
     - Common Subexpression Elimination
     - Copy Propagation

   If I implement loop-invariant code motion, it will be ran here as
   well.


( ***************************************************************** *)

open Usuba_AST
open Basic_utils
open Utils


let print title body conf =
  if conf.verbose >= 5 then
    begin
      Printf.fprintf stderr "%s\n" title;
      if conf.verbose >= 100 then
        Printf.fprintf stderr "%s\n" (Usuba_print.prog_to_str body)
    end


let run_pass title func conf prog =
  if conf.verbose >= 5 then
    Printf.fprintf stderr "\n\nRunning %s...\n%!" title;
  let res = func prog conf in
  if conf.verbose >= 5 then
    Printf.fprintf stderr "\n%s done.\n%!" title;
  if conf.verbose >= 100 then
    Printf.fprintf stderr "%s\n%!" (Usuba_print.prog_to_str res);
  res


let opt_prog (prog:prog) (conf:config) =

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in

  let fold_const = if conf.fold_const then Constant_folding.fold_prog else fun p _ -> p in
  let cse        = if conf.cse        then CSE.cse_prog               else fun p _ -> p in
  let copy_prop  = if conf.copy_prop  then Copy_propagation.cp_prog   else fun p _ -> p in


  prog |>
    (* Running twice CF/CSE/CP; TODO: fixpoint instead? *)
    (run_pass "Constant_folding 1" fold_const)                    |>
    (run_pass "CSE 1" cse)                                        |>
    (run_pass "Copy_propagation 1" copy_prop)                     |>
    (run_pass "Norm_tuples 1" Norm_tuples.norm_tuples)            |>
    (run_pass "Constant_folding 2" fold_const)                    |>
    (run_pass "CSE 2" cse)                                        |>
    (run_pass "Copy_propagation 2" copy_prop)                     |>
    (run_pass "Norm_tuples 2" Norm_tuples.norm_tuples)
