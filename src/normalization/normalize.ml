open Usuba_AST
open Basic_utils
open Utils
open Pass_runner


module Normalize_inner_core = struct
  let run (runner:pass_runner) (prog:prog) (conf:config) =
    runner#run_modules [ Unfold_unnest.as_pass;
                         Expand_array.as_pass;
                         Expand_permut.as_pass;
                         Norm_tuples.as_pass;
                         Shift_tuples.as_pass;
                         Norm_tuples.as_pass ] prog

  let as_pass = (run, "Normalize_inner_core")
end

module Normalize_core = struct
  let run (runner:pass_runner) (prog:prog) (conf:config) =
    runner#run_modules [ Expand_array.as_pass;
                         Normalize_inner_core.as_pass;
                         Expand_parameters.as_pass;
                         Fix_dim.Dir_params.as_pass;
                         Expand_array.as_pass;
                         Normalize_inner_core.as_pass;
                         Expand_parameters.as_pass;
                         Fix_dim.Dir_inner.as_pass;
                         Expand_array.as_pass;
                         Normalize_inner_core.as_pass ] prog

  let as_pass = (run, "Normalize_core")
end


let norm_prog (rename:bool) (prog:prog) (conf:config) : prog =
  let runner = new pass_runner conf in

  let normed_prog =
    runner#run_modules  [ Rename.as_pass;
                          Expand_multiples.as_pass;
                          Convert_tables.as_pass;
                          Expand_array.as_pass;
                          Remove_sync.as_pass;
                          Init_scheduler.as_pass;
                          Normalize_core.as_pass;
                          Monomorphize.as_pass;
                          Normalize_core.as_pass;
                          Init_scheduler.as_pass; ] prog in

  if conf.check_tbl then
    Soundness.tables_sound runner (runner#run_module Rename.as_pass prog)
                           normed_prog;


  normed_prog


let optimize (prog:prog) (conf:config) : prog =
  let runner = new pass_runner conf in

  let prog =
    runner#run_modules_guard
           [ Simple_opts.as_pass,          true;
             Pre_schedule.as_pass,         conf.pre_schedule;
             Normalize_core.as_pass,       true ] prog in

  Inline.run_with_cont runner prog conf
                       [ Simple_opts.as_pass,          true;
                         Pre_schedule.as_pass,         true;
                         Normalize_inner_core.as_pass, true;
                         Optimize.as_pass,             true;
                         Normalize_inner_core.as_pass, true;
                         Tightprove.as_pass,           conf.tightPROVE;
                         Usuba_to_maskverif.as_pass,   conf.maskVerif;
                         Mask.as_pass,                 conf.ua_masked;
                         Fuse_loops.as_pass,           conf.loop_fusion;
                         Linearize_arrays.as_pass,     conf.linearize_arr
                       ]


let compile (prog:prog) (conf:config) : prog =

  let normalized = norm_prog true prog conf in
  (* Get_live_var.run normalized; *)

  optimize normalized conf
