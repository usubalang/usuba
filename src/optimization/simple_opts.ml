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
open Pass_runner

let rec opt_def ?(retry : int = 5) (def : def) =
  let def' =
    Norm_tuples.norm_tuples_def
      (Copy_propagation.cp_def (CSE.cse_def (Constant_folding.fold_def def)))
  in

  if retry > 0 then if def = def' then def else opt_def ~retry:(retry - 1) def'
  else def'

let rec _run (runner : pass_runner) ?(retry : int = 20) (prog : prog)
    (conf : Config.config) : prog =
  let prog' =
    runner#run_modules_guard
      [
        (Constant_folding.as_pass, conf.fold_const);
        (CSE.as_pass, conf.cse);
        (Copy_propagation.as_pass, conf.copy_prop);
        (Norm_tuples.as_pass, true);
      ]
      prog
  in

  if retry > 0 then
    if prog = prog' then prog else _run runner ~retry:(retry - 1) prog' conf
  else prog'

let run (runner : pass_runner) (prog : prog) (conf : Config.config) : prog =
  _run runner prog conf

let as_pass = (run, "Simple_opts", 1)
