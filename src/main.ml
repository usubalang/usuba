
open Usuba_AST
open Printf
open Basic_utils
open Utils

let warnings    = ref false
let verbose     = ref 1
let verif       = ref false
let type_check  = ref true
let clock_check = ref false
let check_tbl   = ref false

let inlining      = ref true
let inline_all    = ref false
let fold_const    = ref true
let cse           = ref true
let copy_prop     = ref true
let scheduling    = ref true
let schedule_n    = ref 10
let share_var     = ref false
let linearize_arr = ref true
let precal_tbl    = ref true
let no_arr        = ref false
let arr_entry     = ref true
let unroll        = ref false
let interleave    = ref 0

let arch         = ref Std
(* TODO: remove bits_per_reg (should be type-driven) *)
let bits_per_reg = ref 64
let ortho        = ref true
let output       = ref ""
let fdti         = ref ""
let lazylift     = ref false

let tightPROVE   = ref false
let shares       = ref 1

let slicing_type = ref B
let slicing_set  = ref false
let m_val        = ref 1
let m_set        = ref false

let keep_tables  = ref false

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

let gen_output_filename (file_in: string) : string =
  let full_name = List.hd (String.split_on_char '.' file_in) in
  let out_name = last (String.split_on_char '/' full_name) in
  out_name ^ ".c"

let print_c (file_in: string) (prog: Usuba_AST.prog) (conf:config) : unit =
  (* Generating C code *)
  let out = match !output with
    | ""  -> open_out (gen_output_filename file_in)
    | str -> open_out str in

  let normalized = Normalize.compile prog conf in

  let c_prog = Usuba_to_c.prog_to_c prog normalized conf file_in in

  fprintf out "%s" c_prog;
  close_out out

let run_tests () : unit =
  Test_constant_folding.test ();
  Test_CSE.test ();
  Test_copy_propagation.test ();
  Printf.printf "All tests ran.\n"

let main () =
  Printexc.record_backtrace true;

  let speclist =
    [ "-w", Arg.Set warnings, "Activate warnings";
      "-v", Arg.Set_int verbose, "Set verbosity level";
      "-verif", Arg.Set verif, "Activate verification";
      "-check-tbl", Arg.Set check_tbl, "Activate verification of tables";
      "-no-type-check", Arg.Clear type_check, "Deactivate type checking";
      "-no-clock-check", Arg.Clear clock_check, "Deactivate clock checking";
      "-no-checks", Arg.Unit (fun () -> type_check := false;
                                        clock_check := false),
                    "Deactivate both type and clock checking";
      "-no-inline", Arg.Clear inlining, "Deactivate inlining opti";
      "-inline-all", Arg.Set inline_all, "Force inlining of every node";
      "-no-fold-const", Arg.Clear fold_const, "Deactive Constant Folding";
      "-no-CSE", Arg.Clear cse, "Deactive CSE";
      "-no-copy-prop", Arg.Clear copy_prop, "Deactive Copy Propagation";
      "-no-CSE-CP-CF", Arg.Unit (fun () ->
                           fold_const := false;
                           cse := false;
                           copy_prop := false),
                       "Deactive CSE, Copy propagation and Constant folding";
      "-no-sched", Arg.Clear scheduling, "Deactivate scheduling opti";
      "-sched-n", Arg.Int (fun n -> schedule_n := n), "Set scheduling param";
      "-no-share", Arg.Clear share_var, "Deactivate variable sharing";
      "-no-linearize-arr", Arg.Clear linearize_arr, "Deactivate array linearization";
      "-no-precalc-tbl", Arg.Clear precal_tbl, "Don't use pre-computed tables";
      "-no-arr-tmp", Arg.Set no_arr, "Don't use arrays for temporaries";
      "-no-arr", Arg.Set no_arr, "Don't keep any array";
      "-no-arr-entry", Arg.Clear arr_entry, "Don't keep any arrays in the entry point";
      "-unroll", Arg.Set unroll, "Unroll all loops";
      "-interleave", Arg.Int (fun n -> interleave := n), "Interleave encryptions";
      "-arch", Arg.String (fun s -> arch := str_to_arch s), "Set architecture";
      "-bits-per-reg", Arg.Set_int bits_per_reg, "Set number of bits to use in the registers (with -arch std only, needs to be a multiple of 2)";
      "-fdti",Arg.Set_string fdti, "Specify the order of ti and fd (tifd or fdti)";
      "-lf", Arg.Set lazylift, "Enable lazy lifting";
      "-o", Arg.Set_string output, "Set the output filename";
      "-H", Arg.Unit (fun () -> slicing_set := true; slicing_type := H), "Horizontal slicing.";
      "-V", Arg.Unit (fun () -> slicing_set := true; slicing_type := V), "Vertical slicing.";
      "-B", Arg.Unit (fun () -> slicing_set := true; slicing_type := B), "Bit slicing.";
      "-m", Arg.Int (fun n -> m_set := true; m_val := n), "Set 'm value";
      "-tp", Arg.Set tightPROVE, "Generate tightPROVE circuits";
      "-shares", Arg.Set_int shares, "Set the number of shares";
      "-keep-tables", Arg.Set keep_tables, "Keep lookup tables (can't use SIMD)";
      "-tests", Arg.Unit (fun () -> run_tests ()), "Run tests";
    ] in
  let usage_msg = "Usage: usuba [switches] [files]" in

  let compile s =
    let prog = Parser_api.parse_file s in
    let bits_per_reg = if !bits_per_reg <> 64 then !bits_per_reg
                       else if !shares <> 1 then 32 else
                         bits_in_arch !arch in

    if !tightPROVE then (
      unroll     := true;
      inline_all := true;
      (* no_arr     := true;
       * arr_entry  := false *)
    );

    let conf = {
        warnings       =   !warnings;
        verbose        =   !verbose;
        verif          =   !verif;
        type_check     =   !type_check;
        clock_check    =   !clock_check;
        check_tbl      =   !check_tbl;
        inlining       =   !inlining;
        inline_all     =   !inline_all;
        fold_const     =   !fold_const;
        cse            =   !cse;
        copy_prop      =   !copy_prop;
        scheduling     =   !scheduling;
        schedule_n     =   !schedule_n;
        share_var      =   !share_var;
        linearize_arr  =   !linearize_arr;
        precal_tbl     =   !precal_tbl;
        archi          =   !arch;
        bits_per_reg   =   bits_per_reg; (* local var! *)
        no_arr         =   !no_arr;
        arr_entry      =   !arr_entry;
        unroll         =   !unroll;
        interleave     =   !interleave;
        fdti           =   !fdti;
        lazylift       =   !lazylift;
        slicing_set    =   !slicing_set;
        slicing_type   =   !slicing_type;
        m_set          =   !m_set;
        m_val          =   !m_val;
        tightPROVE     =   !tightPROVE;
        shares         =   !shares;
        keep_tables    =   !keep_tables;
      } in

    if conf.archi = Std && conf.bits_per_reg mod 2 <> 0 then
      raise (Error ("Invalid -fix-size " ^ (string_of_int conf.bits_per_reg)));

    let prog = Type_checker.type_prog prog in
    if !clock_check then
      if not (Clock_checker.is_clocked prog) then
        raise (Error "Unsound program: bad clocks");
    print_c s prog conf in


  Arg.parse speclist compile usage_msg


let () = main ()
