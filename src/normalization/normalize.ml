open Usuba_AST
open Utils
               
       
let print title body conf =
  if conf.verbose >= 5 then
    begin
      print_endline title;
      if conf.verbose >= 100 then print_endline (Usuba_print.prog_to_str body)
    end

let run_pass title func conf prog =
  if conf.verbose >= 5 then
    Printf.printf "Running %s...\n" title;

  let res = func prog conf in

  if conf.verbose >= 5 then
    Printf.printf "%s done.\n" title;

  if conf.verbose >= 100 then
    Printf.printf "%s\n" (Usuba_print.prog_to_str res);

  res
      

(* Note: the print actually print if the booleans in the function "print" above 
         are set to true (or at least the first one) *)
let norm_prog (prog: prog) (conf:config) : prog  =
  print "INPUT:" prog conf;

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in

  let sched_fun prog conf =
    if conf.scheduling then
      if conf.cse_cp then Optimize.CSE_CF.cse_prog prog else prog
    else prog in
  
  let normalized =
    prog |>
      (run_pass "Rename" Rename.rename_prog)                          |>
      (run_pass "Expand_multiples" Expand_multiples.expand_multiples) |>
      (run_pass "Convert_tables" Convert_tables.convert_tables)       |>
      (run_pass "Expand_array" Expand_array.expand_array) |>
      (run_pass "Remove_ctrl" Remove_ctrl.remove_ctrl) |>
      (run_pass "Norm_bitslice 1" Norm_bitslice.norm_prog) |>
      (run_pass "Init_scheduler" Init_scheduler.schedule_prog) |>
      (run_pass "Pre_schedule" sched_fun) |>
      (run_pass "Inline" Inline.inline) |>
      (run_pass "Norm_bitslice 2" Norm_bitslice.norm_prog) in
      
  
  assert (Assert_lang.Usuba_norm.is_usuba_normalized normalized);

  let optimized   = run_pass "Optimize" Optimize.opt_prog normalized in
  let clock_fixed = run_pass "Fix_clocks" Fix_clocks.fix_prog optimized in
  let norm_ok     = run_pass "Norm_bitslice 3" Norm_bitslice.norm_prog clock_fixed in

  if conf.check_tbl then
    Soundness.tables_sound (Rename.rename_prog prog conf) norm_ok;

  norm_ok
