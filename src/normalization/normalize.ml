open Pass_runner

let norm_prog _ prog conf =
  let runner = new pass_runner conf in

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

  let prog =
    runner#run_modules_guard
      [
        (Simple_opts.as_pass, true);
        (Pre_schedule.as_pass, conf.pre_schedule);
        (Normalize_core.as_pass, true);
      ]
      prog
  in

  let guard_pre_inline =
    conf.pre_schedule && Inline.is_more_aggressive_than_auto conf
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

let compile prog conf =
  let normalized = norm_prog true prog conf in

  (* Get_live_var.run normalized; *)
  optimize normalized conf
