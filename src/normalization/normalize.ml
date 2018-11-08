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
  
  let normalized =
    prog |>
      (run_pass "Rename" rename)                                         |>
      (run_pass "Expand_multiples" Expand_multiples.expand_multiples)    |>
      (run_pass "Slice" Slice.slice)                                     |>
      (run_pass "Convert_tables" Convert_tables.convert_tables)          |>
      (run_pass "Expand_array" Expand_array.expand_array)                |>
      (run_pass "Remove_sync" Remove_sync.remove_sync)                   |>
      (run_pass "Remove_ctrl" Remove_ctrl.remove_ctrl)                   |>
      (run_pass "Norm_bitslice 1" Norm_bitslice.norm_prog)               |>
      (run_pass "Expand_parameters" Expand_parameters.expand_parameters) |>
      (run_pass "Init_scheduler" Init_scheduler.schedule_prog)           |>
      (run_pass "Pre_schedule" sched_fun)                                |>
      (run_pass "Inline" Inline.inline)                                  |>
      (run_pass "Norm_bitslice 2" Norm_bitslice.norm_prog) in

  let optimized   = run_pass "Optimize" Optimize.opt_prog normalized in
  let clock_fixed = run_pass "Fix_clocks" Fix_clocks.fix_prog optimized in
  let norm_ok     = run_pass "Norm_bitslice 3" Norm_bitslice.norm_prog clock_fixed in

  if conf.check_tbl then
    Soundness.tables_sound (Rename.rename_prog prog conf) norm_ok;

  norm_ok
    

let specialize (prog:prog) (conf:config) : prog =

  let ti_file  = Printf.sprintf "data/nodes/ti%d.ua" conf.ti in

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in


  let specialized = 
  if conf.fdti = "fdti" then
    let ti_nodes = norm_prog false
                             (Parse_file.parse_file ti_file)
                             { conf with inlining = false } in
    prog |>
      run_pass "Fault detection" Fault_detection.fault_detection  |>
      run_pass "Re-normalize" (norm_prog false) |>
      run_pass "TI securisation" (Ti_secure.ti_secure ti_nodes)
  else if conf.fdti = "tifd" then
    let ti_nodes = norm_prog false
                             (Parse_file.parse_file ti_file)
                             { conf with inlining = false } in
    prog |> 
      run_pass "TI securisation" (Ti_secure.ti_secure ti_nodes) |>
      run_pass "Re-normalize" (norm_prog false) |>
      run_pass "Fault detection" Fault_detection.fault_detection
  else if conf.fd then
    prog |> run_pass "Fault detection" Fault_detection.fault_detection
  else if conf.ti > 1 then
    let ti_nodes = norm_prog false
                             (Parse_file.parse_file ti_file)
                             { conf with inlining = false } in
    prog |>run_pass "TI securisation" (Ti_secure.ti_secure ti_nodes)
  else
    prog in

  norm_prog false specialized conf
      

let compile (prog:prog) (conf:config) : prog =
  print "INPUT:" prog conf;

  let normalized = norm_prog true prog conf in
  (* Get_live_var.get_live_var normalized; *)

  if conf.fd || conf.ti > 1 then
    specialize normalized conf
  else
    normalized
