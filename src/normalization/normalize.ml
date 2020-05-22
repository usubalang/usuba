open Usuba_AST
open Basic_utils
open Utils
open Pass_runner

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

  let guard_for_pre_inlining =
    conf.pre_schedule && (Inline.is_more_aggressive_than_auto conf) in
  let prog = runner#run_modules_guard
                      [ Inline.as_pass_pre,     guard_for_pre_inlining;
                        Normalize_core.as_pass, guard_for_pre_inlining;
                        Pre_schedule.as_pass,   guard_for_pre_inlining;
                        Normalize_core.as_pass, guard_for_pre_inlining ] prog in


  Inline.run_with_cont runner prog conf
                       [ Simple_opts.as_pass,          true;
                         Pre_schedule.as_pass,         conf.pre_schedule;
                         Normalize_inner_core.as_pass, true;
                         Optimize.as_pass,             true;
                         Normalize_inner_core.as_pass, true;
                         Tightprove.as_pass,           conf.tightPROVE;
                         Usuba_to_maskverif.as_pass,   conf.maskVerif;
                         Mask.as_pass,                 conf.ua_masked;
                         Fuse_loops.as_pass,           conf.loop_fusion;
                         Linearize_arrays.as_pass,     conf.linearize_arr(* ; *)
                         (* Inplace_nodes.as_pass,        conf.inplace_nodes; *)
                       ]


let compile (prog:prog) (conf:config) : prog =

  let normalized = norm_prog true prog conf in
  (* Get_live_var.run normalized; *)

  optimize normalized conf
