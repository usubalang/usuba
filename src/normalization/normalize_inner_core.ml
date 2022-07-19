open Usuba_AST
open Pass_runner

let run (runner : pass_runner) (prog : prog) _ : prog =
  runner#run_modules
    [
      Unfold_unnest.as_pass;
      Expand_array.as_pass;
      Expand_permut.as_pass;
      Norm_tuples.as_pass;
      Shift_tuples.as_pass;
      Norm_tuples.as_pass;
    ]
    prog

let as_pass = (run, "Normalize_inner_core", 1)
