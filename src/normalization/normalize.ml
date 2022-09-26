open Pass_runner

let norm_prog _ prog conf =
  let runner = new pass_runner conf in
  if conf.dump_steps = Some AST then (
    let filename = Format.sprintf "%s.callers" conf.dump_steps_base_file in
    let co = open_out filename in
    close_out co;
    let base = Format.sprintf "%s_000" conf.dump_steps_base_file in
    let filename = base ^ ".ml" in
    let co = open_out filename in

    let pp msg = Format.fprintf (Format.formatter_of_out_channel co) msg in

    pp "open Usuba_lib@.open Usuba_AST@.@.let %s = %a@."
      (Filename.basename base) Usuba_AST.pp_prog prog;
    close_out co;
    let filename = conf.dump_steps_base_file ^ "_config.ml" in
    let co = open_out filename in

    let pp msg = Format.fprintf (Format.formatter_of_out_channel co) msg in
    pp "open Usuba_lib@.@.let conf = %a@." Config.pp_config
      Config.
        {
          conf with
          dump_steps = None;
          path = [ "." ];
          dump_steps_base_file = "";
          tightprove_dir = "";
        };
    close_out co);

  let normed_prog =
    runner#run_modules
      [
        Rename.as_pass;
        Expand_multiples.as_pass;
        Convert_tables.as_pass;
        Expand_array.as_pass;
        Remove_sync.as_pass;
        Init_scheduler.as_pass;
        Normalize_core.as_pass;
        Monomorphize.as_pass;
        Normalize_core.as_pass;
        Init_scheduler.as_pass;
      ]
      prog
  in

  if conf.check_tbl then
    Soundness.tables_sound runner
      (runner#run_module Rename.as_pass prog)
      normed_prog;

  normed_prog

let optimize prog conf =
  let runner = new pass_runner conf in
  let guard_pre_inline =
    conf.pre_schedule && Inline.is_more_aggressive_than_auto conf
  in

  let prog =
    runner#run_modules_guard
      ~conf:{ conf with simple_opts = false }
      [
        (Inline.as_pass_pre, guard_pre_inline);
        (Inline.as_pass, true);
        (Simple_opts.as_pass, true);
        (Pre_schedule.as_pass, conf.pre_schedule);
        (Normalize_core.as_pass, true);
      ]
      prog
  in

  runner#run_modules_bench
    [
      (Simple_opts.as_pass, true, Pass_runner.Always);
      ( Inline.as_pass_pre,
        guard_pre_inline,
        Pass_runner.Toggle conf.bench_bitsched );
      (Normalize_core.as_pass, guard_pre_inline, Pass_runner.Always);
      ( Pre_schedule.as_pass,
        guard_pre_inline,
        Pass_runner.Toggle conf.bench_bitsched );
      (Normalize_core.as_pass, guard_pre_inline, Pass_runner.Always);
      (Simple_opts.as_pass, true, Pass_runner.Always);
      (Inline.as_pass, true, Pass_runner.Custom conf.bench_inline);
      (Simple_opts.as_pass, true, Pass_runner.Always);
      ( Pre_schedule.as_pass,
        conf.pre_schedule,
        Pass_runner.Toggle conf.bench_bitsched );
      (Normalize_inner_core.as_pass, true, Pass_runner.Always);
      ( Interleave.as_pass,
        conf.interleave > 0,
        Pass_runner.Custom conf.bench_inter );
      (Simple_opts.as_pass, true, Pass_runner.Always);
      (Fuse_loop_general.as_pass, conf.loop_fusion, Pass_runner.Always);
      (Simple_opts.as_pass, true, Pass_runner.Always);
      (Scheduler.as_pass, conf.scheduling, Pass_runner.Toggle conf.bench_msched);
      (Share_var.as_pass, conf.share_var, Pass_runner.Toggle conf.bench_sharevar);
      (Clean.as_pass, true, Pass_runner.Always);
      (Remove_dead_code.as_pass, true, Pass_runner.Always);
      (Normalize_inner_core.as_pass, true, Pass_runner.Always);
      (Tightprove.as_pass, conf.tightPROVE, Pass_runner.Always);
      (Usuba_to_maskverif.as_pass, conf.maskVerif, Pass_runner.Always);
      (Mask.as_pass, conf.ua_masked, Pass_runner.Always);
      (Fuse_loops.as_pass, conf.loop_fusion, Pass_runner.Always);
      (Linearize_arrays.as_pass, conf.linearize_arr, Pass_runner.Always);
    ]
    prog

let compile prog (conf : Config.config) =
  let normalized = norm_prog true prog conf in
  (* Get_live_var.run normalized; *)
  optimize normalized conf
