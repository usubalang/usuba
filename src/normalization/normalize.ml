open Usuba_AST
open Basic_utils
open Utils
open Pass_runner

let print title body conf =
  if conf.verbose >= 5 then
    begin
      Printf.fprintf stderr "%s\n" title;
      if conf.verbose >= 100 then
        Printf.fprintf stderr "%s\n" (Usuba_print.prog_to_str body)
    end


let run_pass title func conf prog =
  if conf.verbose >= 5 then
    Printf.fprintf stderr "\n\nRunning %s...\n%!" title;
  let res = func prog conf in
  if conf.verbose >= 5 then
    Printf.fprintf stderr "\n%s done.\n%!" title;
  if conf.verbose >= 100 then
    Printf.fprintf stderr "%s\n%!" (Usuba_print.prog_to_str res);
  res


let register_norm_bitslice (runner:pass_runner) : unit =
  runner#register_pass Unfold_unnest.norm_prog  "Norm_bitslice.Unfold_unnest";
  runner#register_pass Expand_array.expand_array "Norm_bitslice.Expand_array";
  runner#register_pass Expand_permut.expand_permut "Norm_bitslice.Expand_permut";
  runner#register_pass Norm_tuples.norm_tuples "Norm_bitslice.Norm_tuples 1";
  runner#register_pass Shift_tuples.expand_shifts "Norm_bitslice.Shift_tuples";
  runner#register_pass Norm_tuples.norm_tuples "Norm_bitslice.Norm_tuples 2"

let register_normalize_core (runner:pass_runner) : unit =
  (* Remove slices/ranges (and forall and arrays in some cases) *)
  runner#register_pass Expand_array.expand_array "Expand_array";

  register_norm_bitslice runner;

  (* Remove arrays from parameters when needed *)
  runner#register_pass  Expand_parameters.expand_parameters "Expand_parameters";

  (* Make sure the number of parameters for each function call is right *)
  runner#register_pass Fix_dim.Dir_params.fix_dim "Fix_dim params";

  (* Remove slices/ranges (and forall and arrays in some cases) *)
  runner#register_pass Expand_array.expand_array "Expand_array 2";

  register_norm_bitslice runner;

  (* Remove arrays from parameters when needed *)
  runner#register_pass Expand_parameters.expand_parameters "Expand_parameters 2";

  (* Make sure the number of parameters for each function call is right *)
  runner#register_pass Fix_dim.Dir_inner.fix_dim "Fix_dim inner";

  (* Remove slices/ranges (and forall and arrays in some cases) *)
  runner#register_pass Expand_array.expand_array "Expand_array 3";

  register_norm_bitslice runner

let register_pre_schedule (runner:pass_runner) : unit =
  (* Scheduling is a bit tricky: need to apply CSE_CF_CP before
  scheduling *)
  if (runner#get_conf ()).pre_schedule then
    runner#register_pass (fun prog conf ->
                          Pre_schedule.schedule
                            (Simple_opts.opt_prog prog conf)) "Pre_schedule"


let norm_prog (rename:bool) (prog:prog) (conf:config) : prog =
  let runner = new pass_runner conf in

  if rename then runner#register_pass Rename.rename_prog "rename";

  (* Remove arrays of nodes *)
  runner#register_pass Expand_multiples.expand_multiples "Expand_multiples";

  (* Convert tables to circuits *)
  runner#register_pass Convert_tables.convert_tables "Convert_tables";

  (* Remove slices/ranges (and forall and arrays in some cases) *)
  runner#register_pass Expand_array.expand_array "Expand_array";

  (* Converts ':=' to SSA *)
  runner#register_pass Remove_sync.remove_sync "Remove_sync";

  (* Schedules instructions according to their dependencies *)
  runner#register_pass Init_scheduler.schedule_prog "Init_scheduler 1";

  (* Remove when/merge *)
  runner#register_pass Remove_ctrl.remove_ctrl "Remove_ctrl";

  register_normalize_core runner;

  (* Monomorphize to H/V/B-slice *)
  runner#register_pass Monomorphize.monomorphize "Monomorphize";

  register_normalize_core runner;

  (* Schedules instructions according to their dependencies *)
  runner#register_pass Init_scheduler.schedule_prog "Init_scheduler 2";

  (* Optimized scheduling *)
  register_pre_schedule runner;

  register_normalize_core runner;

  (* Inlining *)
  runner#register_pass Inline.inline "Inline";

  (* Re-optimized scheduling (inlining could have introduced some
         oportunities for a better scheduling *)
  register_pre_schedule runner;

  register_norm_bitslice runner;

  (* CSE-CP + Scheduling *)
  runner#register_pass Optimize.opt_prog "Optimize";

  register_norm_bitslice runner;

  let prog' = runner#run_all_passes prog in

  if conf.check_tbl then
    Soundness.tables_sound (Rename.rename_prog prog conf) prog';

  let prog' = if conf.tightPROVE then Tightprove.process_prog prog' conf else prog' in

  if conf.maskVerif then
    Usuba_to_maskverif.print_prog prog';

  let prog' = if conf.ua_masked then Mask.mask_prog prog' else prog' in
  (* Printf.eprintf "\n\nMASKED:%s\n\n" (Usuba_print.prog_to_str prog'); *)
  let prog' = if conf.loop_fusion then Fuse_loops.fuse_loops prog' conf else prog' in

  (* Array linearization leaves the dataflow world (as it reuses variables),
    so putting it at the end
    (might be more correct to put it in the C generation) *)
  runner#register_pass Linearize_arrays.linearize_arrays "Linearize_arrays";

  runner#run_all_passes prog'


let compile (prog:prog) (conf:config) : prog =
  print "INPUT:" prog conf;

  let normalized = norm_prog true prog conf in
  (* Get_live_var.get_live_var normalized; *)

  normalized
