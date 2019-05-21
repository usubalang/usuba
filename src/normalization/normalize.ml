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
    Printf.fprintf stderr "Running %s...\n%!" title;
  let res = func prog conf in
  if conf.verbose >= 5 then
    Printf.fprintf stderr "%s done.\n%!" title;
  if conf.verbose >= 100 then
    Printf.fprintf stderr "%s\n%!" (Usuba_print.prog_to_str res);
  res

    
let norm_prog (rename:bool) (prog: prog) (conf:config) : prog  =

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in

  (* Scheduling is a bit tricky: need to apply CSE_CF_CP before scheduling *)
  let sched_fun prog conf =
    if conf.scheduling then
      Pre_schedule.schedule
        (if conf.cse_cp then CSE_CF_CP.opt_prog prog conf else prog)
    else prog in

  (* Rename only if param rename is true *)
  let rename = if rename then Rename.rename_prog else (fun x _ -> x) in

  let norm_bitslice x _ =
    x |>
      (run_pass "Unfold_unnest" Unfold_unnest.norm_prog) |>
      (run_pass "Expand_array (bitslice)" Expand_array.expand_array) |>
      (run_pass "Expand_permut" Expand_permut.expand_permut) |>
      (run_pass "Norm_tuples.norm_tuples 1" Norm_tuples.norm_tuples) |>
      (run_pass "Bitslice_shift" Bitslice_shift.expand_shifts) |>
      (run_pass "Norm_tuples.norm_tuples 2" Norm_tuples.norm_tuples) in

  
  let normalize_core x _ =
    x |>
      (run_pass "Expand_array 1.5" Expand_array.expand_array)              |>
      (run_pass "Norm_bitslice 1" norm_bitslice)                 |>
      (run_pass "Expand_parameters" Expand_parameters.expand_parameters)   |>
      (run_pass "Fix_dim params" Fix_dim.Dir_params.fix_dim)               |>
      (run_pass "Expand_array 2" Expand_array.expand_array)                |>
      (run_pass "Norm_bitslice 2" norm_bitslice)                 |>
      (run_pass "Expand_parameters 2" Expand_parameters.expand_parameters) |>
      (run_pass "Fix_dim inner" Fix_dim.Dir_inner.fix_dim)                 |>
      (run_pass "Expand_array 3" Expand_array.expand_array)                |>
      (run_pass "Norm_bitslice 3" norm_bitslice) in
    
  
  let normalized =
    prog |>
      (run_pass "Rename" rename)                                           |>
      (run_pass "Expand_multiples" Expand_multiples.expand_multiples)      |>
      (run_pass "Convert_tables" Convert_tables.convert_tables)            |>
      (run_pass "Expand_array" Expand_array.expand_array)                  |>
      (run_pass "Expand_const" Expand_const.expand_const)                  |>
      (run_pass "Init_scheduler 1" Init_scheduler.schedule_prog)           |>
      (run_pass "Remove_sync" Remove_sync.remove_sync)                     |>
      (run_pass "Remove_ctrl" Remove_ctrl.remove_ctrl)                     |>
      (run_pass "Core normalize 1" normalize_core)                         |>
      (run_pass "Monomorphize" Monomorphize.monomorphize)                  |>
      (run_pass "Core normalize 2" normalize_core)                         |>
      (run_pass "Init_scheduler 2" Init_scheduler.schedule_prog)           |>
      (run_pass "Pre_schedule" sched_fun)                                  |>
      (run_pass "Core normalize 3" normalize_core)                         |>      
      (run_pass "Inline" Inline.inline)                                    |>
      (run_pass "Pre_schedule 2" sched_fun)                                |>
      (run_pass "Norm_bitslice 4" Norm_bitslice.norm_prog) in

  let optimized   = run_pass "Optimize" Optimize.opt_prog normalized in
  let clock_fixed = run_pass "Fix_clocks" Fix_clocks.fix_prog optimized in
  let norm_ok     = run_pass "Norm_bitslice 3" Norm_bitslice.norm_prog clock_fixed in

  if conf.check_tbl then
    Soundness.tables_sound (Rename.rename_prog prog conf) norm_ok;

  if conf.tightPROVE then
    Usuba_to_tightprove.print_prog norm_ok;
  
  norm_ok
  

let compile (prog:prog) (conf:config) : prog =
  print "INPUT:" prog conf;

  let normalized = norm_prog true prog conf in
  (* Get_live_var.get_live_var normalized; *)

  normalized
