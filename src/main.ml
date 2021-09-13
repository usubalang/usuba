
open Usuba_AST
open Printf
open Basic_utils
open Utils
open Tightprove_to_usuba

open Config


let warnings    = ref false
let verbose     = ref 1
let path        = ref [ "." ]
let type_check  = ref true
let check_tbl   = ref false

let no_inline     = ref false
let auto_inline   = ref true
let inline_all    = ref false
let heavy_inline  = ref false
let light_inline  = ref false
let compact_mono  = ref true
let fold_const    = ref true
let cse           = ref true
let copy_prop     = ref true
let loop_fusion   = ref true
let pre_schedule  = ref true
let scheduling    = ref true
let schedule_n    = ref 10
let share_var     = ref false
let linearize_arr = ref true
let precal_tbl    = ref true
let no_arr        = ref false
let arr_entry     = ref true
let unroll        = ref false
let interleave    = ref 0
let inter_factor  = ref 0

let arch         = ref Std
let bits_per_reg = ref 64
let ortho        = ref true
let output       = ref ""
let fdti         = ref ""
let lazylift     = ref false

let tightPROVE   = ref false
let tightprove_dir = ref Config.tightprove_cache
let maskVerif    = ref false
let masked       = ref false
let ua_masked    = ref false
let shares       = ref 1
let gen_bench    = ref false
let compact      = ref false

let slicing_type = ref B
let slicing_set  = ref false
let m_val        = ref 1
let m_set        = ref false

let bench_all      = ref false
let bench_inline   = ref false
let bench_inter    = ref false
let bench_bitsched = ref false
let bench_msched   = ref false
let bench_sharevar = ref false

let keep_tables  = ref false

let arm_asm = ref false

let str_to_arch = function
  | "std"     -> Std
  | "mmx"     -> MMX
  | "sse"     -> SSE
  | "avx"     -> AVX
  | "avx512"  -> AVX512
  | "neon"    -> Neon
  | "altivec" -> AltiVec
  | x -> raise (Error ("Invalid archi: " ^ x))

let bits_in_arch = function
  | Std      -> 64
  | MMX      -> 64
  | SSE      -> 128
  | AVX      -> 256
  | AVX512   -> 512
  | Neon     -> 128
  | AltiVec  -> 128

let gen_output_filename (file_in: string) (gen_asm: bool) : string =
  let full_name = List.hd (String.split_on_char '.' file_in) in
  let out_name = last (String.split_on_char '/' full_name) in
  match gen_asm with
  | true -> out_name ^ ".s"
  | false -> out_name ^ ".c"



let compile (file_in: string) (prog: Usuba_AST.prog) (conf:config) : unit =
  (* Type-checking *)
  let prog = if conf.type_check then Type_checker.type_prog prog conf else prog in

  (* Normalizing AND optimizing *)
  let normed_prog = Normalize.compile prog conf in

  (* Compiled to C or ASM *)
  let compiled_prog = match conf.arm_asm with
    | true  -> Armv7.prog_to_asm prog normed_prog conf file_in
    | false -> Usuba_to_c.prog_to_c prog normed_prog conf file_in in

  (* Opening out file *)
  let out = match !output with
    | ""  -> open_out (gen_output_filename file_in conf.arm_asm)
    | str -> open_out str in

  (* Printing the compiled code code *)
  fprintf out "%s" compiled_prog;
  close_out out


let run_tests () : unit =
  Test_constant_folding.test ();
  Test_CSE.test ();
  Test_copy_propagation.test ();
  Test_remove_dead_code.test ();
  Test_pass_runner.test ();
  Test_monomorphize.test ();
  Printf.printf "All tests ran.\n"


let main () =
  Printexc.record_backtrace true;

  let speclist =
    [ "-w", Arg.Set warnings, "Activate warnings";
      "-v", Arg.Set_int verbose, "Set verbosity level";
      "-I", Arg.String (fun s -> path := s :: !path), "Add the directory to the list of directories to be searched for includes.";
      "-check-tbl", Arg.Set check_tbl, "Activate verification of tables";
      "-no-type-check", Arg.Clear type_check, "Deactivate type checking";
      "-no-inline", Arg.Set no_inline, "Deactivate inlining opti";
      "-inline-all", Arg.Set inline_all, "Force inlining of every node";
      "-light-inline", Arg.Set light_inline, "Inline only _inline functions";
      "-heavy-inline", Arg.Set heavy_inline, "Inline every node, except for _no_inline";
      "-no-compact-mono", Arg.Clear compact_mono, "Disables compact bitslice monomorphization";
      "-no-fold-const", Arg.Clear fold_const, "Deactive Constant Folding";
      "-no-CSE", Arg.Clear cse, "Deactive CSE";
      "-no-copy-prop", Arg.Clear copy_prop, "Deactive Copy Propagation";
      "-no-loop-fusion", Arg.Clear loop_fusion, "Deactivate Loop Fusion";
      "-loop-fusion", Arg.Set loop_fusion, "Enables Loop Fusion";
      "-no-CSE-CP-CF", Arg.Unit (fun () ->
                           fold_const := false;
                           cse := false;
                           copy_prop := false),
                       "Deactive CSE, Copy propagation and Constant folding";
      "-no-pre-sched", Arg.Clear pre_schedule, "Deactivate pre-scheduling opti";
      "-no-sched", Arg.Clear scheduling, "Deactivate scheduling opti";
      "-sched-n", Arg.Int (fun n -> schedule_n := n), "Set scheduling param";
      "-no-share", Arg.Clear share_var, "Deactivate variable sharing";
      "-no-linearize-arr", Arg.Clear linearize_arr, "Deactivate array linearization";
      "-no-precalc-tbl", Arg.Clear precal_tbl, "Don't use pre-computed tables";
      "-no-arr-tmp", Arg.Set no_arr, "Don't use arrays for temporaries";
      "-no-arr", Arg.Set no_arr, "Don't keep any array";
      "-no-arr-entry", Arg.Clear arr_entry, "Don't keep any arrays in the entry point";
      "-unroll", Arg.Set unroll, "Unroll all loops";
      "-interleave", Arg.Int (fun n -> interleave := n), "Sets the interleaving granularity (1 => 'a=b;c=d' becomes 'a=b;a2=b2;c=d;c2=d', 2 => 'a=b;c=d' becomes 'a=b;c=d;a2=b2;c2=d2')";
      "-inter-factor", Arg.Int (fun n -> inter_factor := n), "Set the interleaving factor (how many instances of the cipher should be interleaved)";
      "-arch", Arg.String (fun s -> arch := str_to_arch s), "Set architecture";
      "-bits-per-reg", Arg.Set_int bits_per_reg, "Set number of bits to use in the registers (with -arch std only, needs to be a multiple of 2)";
      "-bench-all", Arg.Set bench_all, "Enable all benchmark-guided optimizations";
      "-bench-inline", Arg.Set bench_inline, "Enable benchmark-guided inlining";
      "-bench-inter", Arg.Set bench_inter, "Enable benchmark-guided interleaving";
      "-bench-bitsched", Arg.Set bench_bitsched, "Enable benchmark-guided bitslice scheduling";
      "-bench-msched", Arg.Set bench_msched, "Enable benchmark-guided mslice scheduling";
      "-bench-sharevar", Arg.Set bench_sharevar, "Enable benchmark-guided variable sharing";
      "-fdti",Arg.Set_string fdti, "Specify the order of ti and fd (tifd or fdti)";
      "-lf", Arg.Set lazylift, "Enable lazy lifting";
      "-o", Arg.Set_string output, "Set the output filename";
      "-H", Arg.Unit (fun () -> slicing_set := true; slicing_type := H), "Horizontal slicing.";
      "-V", Arg.Unit (fun () -> slicing_set := true; slicing_type := V), "Vertical slicing.";
      "-B", Arg.Unit (fun () -> slicing_set := true; slicing_type := B), "Bit slicing.";
      "-m", Arg.Int (fun n -> m_set := true; m_val := n), "Set 'm value";
      "-tp", Arg.Set tightPROVE, "Generate tightPROVE circuits";
      "-tp-dir", Arg.String (fun s -> tightprove_dir := s), "Set directory output for tightPROVE";
      "-mv", Arg.Set maskVerif, "Generate maskVerif circuits";
      "-masked", Arg.Set masked, "Generate masked implementation";
      "-ua-masked", Arg.Unit (fun () -> ua_masked := true; (* linearize_arr := false *)), "Generate masked implementation, where masking is done is Usuba rather than solely with C macros. This allows for some optimizations, like loop fusion.";
      "-shares", Arg.Int (fun n -> shares := n; masked := true), "Set the number of shares";
      "-gen-bench", Arg.Set gen_bench, "Generate speed benchmark";
      "-keep-tables", Arg.Set keep_tables, "Keep lookup tables (can't use SIMD)";
      "-compact", Arg.Set compact, "Generates more compact code (for bitslicing only)";
      "-tests", Arg.Unit (fun () -> run_tests ()), "Run tests";
      "-arm-asm", Arg.Set arm_asm, "Generate assembly for ARM v8";
    ] in
  let usage_msg = "Usage: usuba [switches] [files]" in

  let compile s =
    let bits_per_reg = if !bits_per_reg <> 64 then !bits_per_reg
                       else if !shares <> 1 then 32 else
                         bits_in_arch !arch in

    let pre_sched = !pre_schedule (* && !scheduling *) in

    let path = (Filename.dirname s) :: (List.rev !path) in

    if !maskVerif then (
      unroll    := true;
      no_arr    := true;
      arr_entry := false;
    );

    if !no_arr then (
      (* When -no-arr is combined with -ua-masked, the linearization
         could take forever, and is obviously not necessary. *)
      linearize_arr := false;
    );

    let conf = {
        warnings       =   !warnings;
        verbose        =   !verbose;
        path           =   path; (* local var *)
        type_check     =   !type_check;
        check_tbl      =   !check_tbl;
        auto_inline    =   !auto_inline;
        light_inline   =   !light_inline;
        heavy_inline   =   !heavy_inline;
        no_inline      =   !no_inline;
        inline_all     =   !inline_all;
        compact_mono   =   !compact_mono;
        fold_const     =   !fold_const;
        cse            =   !cse;
        copy_prop      =   !copy_prop;
        loop_fusion    =   !loop_fusion;
        pre_schedule   =   pre_sched; (* local var *)
        scheduling     =   !scheduling;
        schedule_n     =   !schedule_n;
        share_var      =   !share_var;
        linearize_arr  =   !linearize_arr;
        precal_tbl     =   !precal_tbl;
        archi          =   !arch;
        bits_per_reg   =   bits_per_reg; (* local var *)
        no_arr         =   !no_arr;
        arr_entry      =   !arr_entry;
        unroll         =   !unroll;
        interleave     =   !interleave;
        inter_factor   =   !inter_factor;
        fdti           =   !fdti;
        lazylift       =   !lazylift;
        slicing_set    =   !slicing_set;
        slicing_type   =   !slicing_type;
        m_set          =   !m_set;
        m_val          =   !m_val;
        tightPROVE     =   !tightPROVE;
        tightprove_dir =   !tightprove_dir;
        maskVerif      =   !maskVerif;
        masked         =   !masked;
        ua_masked      =   !ua_masked;
        shares         =   !shares;
        gen_bench      =   !gen_bench;
        keep_tables    =   !keep_tables;
        compact        =   !compact;
        arm_asm        =   !arm_asm;
        bench_inline   =   !bench_inline   || !bench_all;
        bench_inter    =   !bench_inter    || !bench_all;
        bench_bitsched =   !bench_bitsched || !bench_all;
        bench_msched   =   !bench_msched   || !bench_all;
        bench_sharevar =   !bench_sharevar || !bench_all;
    } in

    let prog = Parser_api.parse_file conf.path s in

    compile s prog conf in


  Arg.parse speclist compile usage_msg


let () = main ()
