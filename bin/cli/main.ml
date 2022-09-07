open Usuba_lib
open Config

let str_to_arch = function
  | "std" -> Std
  | "mmx" -> MMX
  | "sse" -> SSE
  | "avx" -> AVX
  | "avx512" -> AVX512
  | "neon" -> Neon
  | "altivec" -> AltiVec
  | x -> raise (Errors.Error ("Invalid archi: " ^ x))

let bits_in_arch = function
  | Std -> 64
  | MMX -> 64
  | SSE -> 128
  | AVX -> 256
  | AVX512 -> 512
  | Neon -> 128
  | AltiVec -> 128

let gen_output_filename ?(ext = ".c") file_in =
  match Filename.chop_suffix_opt ~suffix:".ua" Filename.(basename file_in) with
  | None -> failwith "You didn't provide a file suffixed with '.ua'"
  | Some base -> base ^ ext

let compile file conf =
  (* Parsing *)
  let prog =
    Errors.exec_with_print_and_fail
      (Parser_api.parse_file conf.path)
      (fun prog -> if conf.parse_only then exit 0 else prog)
      file
  in

  (* Variables binding *)
  let prog =
    Errors.exec_with_print_and_fail
      (Variable_binding.bind_prog ~conf)
      (fun prog -> prog)
      prog
  in

  (* Format.eprintf "--------BINDING--------@.@.%a@."
   *   (Usuba_print.pp_prog ~detailed:(conf.verbose > 10) ())
   *   prog; *)

  (* Type-checking *)
  let prog =
    if conf.type_check then
      Errors.exec_with_print_and_fail
        (Type_checker.type_prog ~conf)
        (fun prog -> if conf.type_only then exit 0 else prog)
        prog
    else prog
  in

  (* Normalizing AND optimizing *)
  let normed_prog = Normalize.compile prog conf in
  match conf.dump_sexp with
  | true ->
      let out =
        match conf.output with
        | "" -> open_out (gen_output_filename ~ext:".ua0" file)
        | str -> open_out str
      in
      let ppf = Format.formatter_of_out_channel out in
      Format.fprintf ppf "%a" Sexplib.Sexp.pp_hum
        (Usuba_AST.sexp_of_prog normed_prog);
      close_out out
  | false ->
      (* Generating a string of C code *)
      let c_prog_str = Usuba_to_c.prog_to_c prog normed_prog conf file in

      (* Opening out file *)
      let out =
        match conf.output with
        | "" -> open_out (gen_output_filename file)
        | str -> open_out str
      in
      (* Printing the C code *)
      Printf.fprintf out "%s" c_prog_str;
      close_out out

let main () =
  Printexc.record_backtrace true;

  let warning_as_error = ref false in
  let nocolor = ref false in
  let verbose = ref 1 in
  let path = ref [ "." ] in
  let parse_only = ref false in
  let type_only = ref false in
  let type_check = ref true in
  let check_tbl = ref false in
  let no_inline = ref false in
  let auto_inline = ref true in
  let inline_all = ref false in
  let heavy_inline = ref false in
  let light_inline = ref false in
  let compact_mono = ref true in
  let fold_const = ref true in
  let cse = ref true in
  let copy_prop = ref true in
  let loop_fusion = ref true in
  let pre_schedule = ref true in
  let scheduling = ref true in
  let schedule_n = ref 10 in
  let share_var = ref false in
  let linearize_arr = ref true in
  let precal_tbl = ref true in
  let no_arr = ref false in
  let arr_entry = ref true in
  let unroll = ref false in
  let interleave = ref 0 in
  let inter_factor = ref 0 in
  let arch = ref Std in
  let bits_per_reg = ref 64 in
  let output = ref "" in
  let fdti = ref "" in
  let lazylift = ref false in
  let tightPROVE = ref false in
  let tightprove_dir = ref tightprove_cache in
  let maskVerif = ref false in
  let masked = ref false in
  let ua_masked = ref false in
  let shares = ref 1 in
  let gen_bench = ref false in
  let compact = ref false in
  let slicing_type = ref Config.B in
  let slicing_set = ref false in
  let m_val = ref 1 in
  let m_set = ref false in
  let bench_all = ref false in
  let bench_inline = ref false in
  let bench_inter = ref false in
  let bench_bitsched = ref false in
  let bench_msched = ref false in
  let bench_sharevar = ref false in
  let keep_tables = ref false in
  let dump_sexp = ref false in

  let dump_steps = ref None in
  let dump_steps_dir = ref (Utils.absolute_dir "~/usuba/steps") in

  let set_dump_steps = function
    | "usuba" -> dump_steps := Some Usuba
    | "sexp" -> dump_steps := Some Sexp
    | "ast" -> dump_steps := Some AST
    | s -> failwith (Format.sprintf "%s is not a proper dump type" s)
  in

  let speclist =
    [
      ("-w", Arg.Set warning_as_error, "Activate warning as error");
      ("--no-color", Arg.Set nocolor, "Disable ansi colors for messages");
      ("-v", Arg.Set_int verbose, "Set verbosity level");
      ( "-I",
        Arg.String (fun s -> path := s :: !path),
        "Add the directory to the list of directories to be searched for \
         includes." );
      ("-check-tbl", Arg.Set check_tbl, "Activate verification of tables");
      ("-no-type-check", Arg.Clear type_check, "Deactivate type checking");
      ("-no-inline", Arg.Set no_inline, "Deactivate inlining opti");
      ("-inline-all", Arg.Set inline_all, "Force inlining of every node");
      ("-light-inline", Arg.Set light_inline, "Inline only _inline functions");
      ( "-heavy-inline",
        Arg.Set heavy_inline,
        "Inline every node, except for _no_inline" );
      ( "-no-compact-mono",
        Arg.Clear compact_mono,
        "Disables compact bitslice monomorphization" );
      ("-no-fold-const", Arg.Clear fold_const, "Deactive Constant Folding");
      ("-no-CSE", Arg.Clear cse, "Deactive CSE");
      ("-no-copy-prop", Arg.Clear copy_prop, "Deactive Copy Propagation");
      ("-no-loop-fusion", Arg.Clear loop_fusion, "Deactivate Loop Fusion");
      ("-loop-fusion", Arg.Set loop_fusion, "Enables Loop Fusion");
      ( "-no-CSE-CP-CF",
        Arg.Unit
          (fun () ->
            fold_const := false;
            cse := false;
            copy_prop := false),
        "Deactive CSE, Copy propagation and Constant folding" );
      ("-no-pre-sched", Arg.Clear pre_schedule, "Deactivate pre-scheduling opti");
      ("-no-sched", Arg.Clear scheduling, "Deactivate scheduling opti");
      ("-sched-n", Arg.Int (fun n -> schedule_n := n), "Set scheduling param");
      ("-no-share", Arg.Clear share_var, "Deactivate variable sharing");
      ( "-no-linearize-arr",
        Arg.Clear linearize_arr,
        "Deactivate array linearization" );
      ("-no-precalc-tbl", Arg.Clear precal_tbl, "Don't use pre-computed tables");
      ("-no-arr-tmp", Arg.Set no_arr, "Don't use arrays for temporaries");
      ("-no-arr", Arg.Set no_arr, "Don't keep any array");
      ( "-no-arr-entry",
        Arg.Clear arr_entry,
        "Don't keep any arrays in the entry point" );
      ("-unroll", Arg.Set unroll, "Unroll all loops");
      ( "-interleave",
        Arg.Int (fun n -> interleave := n),
        "Sets the interleaving granularity (1 => 'a=b;c=d' becomes \
         'a=b;a2=b2;c=d;c2=d', 2 => 'a=b;c=d' becomes 'a=b;c=d;a2=b2;c2=d2')" );
      ( "-inter-factor",
        Arg.Int (fun n -> inter_factor := n),
        "Set the interleaving factor (how many instances of the cipher should \
         be interleaved)" );
      ("-arch", Arg.String (fun s -> arch := str_to_arch s), "Set architecture");
      ( "-bits-per-reg",
        Arg.Set_int bits_per_reg,
        "Set number of bits to use in the registers (with -arch std only, \
         needs to be a multiple of 2)" );
      ( "-bench-all",
        Arg.Set bench_all,
        "Enable all benchmark-guided optimizations" );
      ("-bench-inline", Arg.Set bench_inline, "Enable benchmark-guided inlining");
      ( "-bench-inter",
        Arg.Set bench_inter,
        "Enable benchmark-guided interleaving" );
      ( "-bench-bitsched",
        Arg.Set bench_bitsched,
        "Enable benchmark-guided bitslice scheduling" );
      ( "-bench-msched",
        Arg.Set bench_msched,
        "Enable benchmark-guided mslice scheduling" );
      ( "-bench-sharevar",
        Arg.Set bench_sharevar,
        "Enable benchmark-guided variable sharing" );
      ( "-fdti",
        Arg.Set_string fdti,
        "Specify the order of ti and fd (tifd or fdti)" );
      ("-lf", Arg.Set lazylift, "Enable lazy lifting");
      ("-o", Arg.Set_string output, "Set the output filename");
      ( "-dump-sexp",
        Arg.Set dump_sexp,
        "Dump a s-expression of the compiled file to file.ua0" );
      ( "-dump-steps",
        Arg.String set_dump_steps,
        "Dump the modified Usuba files at each step" );
      ( "-dump-steps-dir",
        Arg.Set_string dump_steps_dir,
        "<dir>  Directory in which each step should be dumped" );
      ( "-H",
        Arg.Unit
          (fun () ->
            slicing_set := true;
            slicing_type := H),
        "Horizontal slicing." );
      ( "-V",
        Arg.Unit
          (fun () ->
            slicing_set := true;
            slicing_type := V),
        "Vertical slicing." );
      ( "-B",
        Arg.Unit
          (fun () ->
            slicing_set := true;
            slicing_type := B),
        "Bit slicing." );
      ( "-m",
        Arg.Int
          (fun n ->
            m_set := true;
            m_val := n),
        "Set 'm value" );
      ("-tp", Arg.Set tightPROVE, "Generate tightPROVE circuits");
      ( "-tp-dir",
        Arg.String (fun s -> tightprove_dir := s),
        "Set directory output for tightPROVE" );
      ("-mv", Arg.Set maskVerif, "Generate maskVerif circuits");
      ("-masked", Arg.Set masked, "Generate masked implementation");
      ( "-ua-masked",
        Arg.Unit (fun () -> ua_masked := true (* linearize_arr := false *)),
        "Generate masked implementation, where masking is done is Usuba rather \
         than solely with C macros. This allows for some optimizations, like \
         loop fusion." );
      ( "-shares",
        Arg.Int
          (fun n ->
            shares := n;
            masked := true),
        "Set the number of shares" );
      ("-gen-bench", Arg.Set gen_bench, "Generate speed benchmark");
      ( "-keep-tables",
        Arg.Set keep_tables,
        "Keep lookup tables (can't use SIMD)" );
      ( "-compact",
        Arg.Set compact,
        "Generates more compact code (for bitslicing only)" );
      ("-parse-only", Arg.Set parse_only, "Only parse files");
      ("-type-only", Arg.Set type_only, "Only parse and type files");
    ]
  in
  let usage_msg = "Usage: usuba [switches] [files]" in

  let generate_conf_and_compile file =
    let path = Filename.dirname file :: List.rev !path in

    let bits_per_reg =
      if !bits_per_reg <> 64 then !bits_per_reg
      else if !shares <> 1 then 32
      else bits_in_arch !arch
    in

    let pre_sched = !pre_schedule (* && !scheduling *) in

    if !maskVerif then (
      unroll := true;
      no_arr := true;
      arr_entry := false);

    if !no_arr then
      (* When -no-arr is combined with -ua-masked, the linearization
         could take forever, and is obviously not necessary. *)
      linearize_arr := false;
    let base_file = Filename.(basename @@ chop_suffix file ".ua") in
    let dump_steps_dir = Filename.(concat !dump_steps_dir base_file) in
    (if !dump_steps <> None then
     try Sys.mkdir dump_steps_dir 0o777 with Sys_error _ -> ());
    let dump_steps_base_file = Filename.(concat dump_steps_dir base_file) in

    let conf =
      {
        output = !output;
        warning_as_error = !warning_as_error;
        verbose = !verbose;
        path;
        (* local var *)
        parse_only = !parse_only;
        type_only = !type_only;
        type_check = !type_check;
        check_tbl = !check_tbl;
        auto_inline = !auto_inline;
        light_inline = !light_inline;
        heavy_inline = !heavy_inline;
        no_inline = !no_inline;
        inline_all = !inline_all;
        compact_mono = !compact_mono;
        fold_const = !fold_const;
        cse = !cse;
        copy_prop = !copy_prop;
        loop_fusion = !loop_fusion;
        pre_schedule = pre_sched;
        (* local var *)
        scheduling = !scheduling;
        schedule_n = !schedule_n;
        share_var = !share_var;
        linearize_arr = !linearize_arr;
        precal_tbl = !precal_tbl;
        archi = !arch;
        bits_per_reg;
        (* local var *)
        no_arr = !no_arr;
        arr_entry = !arr_entry;
        unroll = !unroll;
        interleave = !interleave;
        inter_factor = !inter_factor;
        fdti = !fdti;
        lazylift = !lazylift;
        slicing_set = !slicing_set;
        slicing_type = !slicing_type;
        m_set = !m_set;
        m_val = !m_val;
        tightPROVE = !tightPROVE;
        tightprove_dir = !tightprove_dir;
        maskVerif = !maskVerif;
        masked = !masked;
        ua_masked = !ua_masked;
        shares = !shares;
        gen_bench = !gen_bench;
        keep_tables = !keep_tables;
        compact = !compact;
        step_counter = ref 0;
        dump_sexp = !dump_sexp;
        dump_steps = !dump_steps;
        dump_steps_base_file;
        bench_inline = !bench_inline || !bench_all;
        bench_inter = !bench_inter || !bench_all;
        bench_bitsched = !bench_bitsched || !bench_all;
        bench_msched = !bench_msched || !bench_all;
        bench_sharevar = !bench_sharevar || !bench_all;
      }
    in
    compile file conf
  in

  let input_files = ref [] in
  let anon_fun filename = input_files := filename :: !input_files in
  Arg.parse speclist anon_fun usage_msg;

  List.iter (fun file -> generate_conf_and_compile file) !input_files

let () = main ()
