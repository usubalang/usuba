open Basic_utils
open Utils
open Usuba_AST
open Usuba_print
open Pass_runner

let optimize (runner : pass_runner) (prog : Usuba_AST.prog) (conf : config) :
    Usuba_AST.prog =
  runner#run_modules_bench
    [
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
    ]
    prog

let as_pass = ((optimize, "Optimize"), 1)
