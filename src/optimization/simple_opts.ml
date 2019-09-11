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

let rec opt_def ?(retry:int=5) (def:def) =
  let def' =
    (Norm_tuples.norm_tuples_def
       (Copy_propagation.cp_def
          (CSE.cse_def
             (Constant_folding.fold_def def)))) in

  if retry > 0 then
    if def = def' then def else opt_def ~retry:(retry-1) def'
  else def'


let rec opt_prog ?(retry:int=5) (prog:prog) (conf:config) =

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in

  let fold_const = if conf.fold_const then Constant_folding.fold_prog else fun p _ -> p in
  let cse        = if conf.cse        then CSE.cse_prog               else fun p _ -> p in
  let copy_prop  = if conf.copy_prop  then Copy_propagation.cp_prog   else fun p _ -> p in

  let prog' =
    prog |>
      (run_pass "Constant_folding" fold_const)                    |>
      (run_pass "CSE" cse)                                        |>
      (run_pass "Copy_propagation" copy_prop)                     |>
      (run_pass "Norm_tuples" Norm_tuples.norm_tuples) in

  if retry > 0 then
    if prog = prog' then prog else opt_prog ~retry:(retry-1) prog' conf
  else prog'
