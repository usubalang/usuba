#!/usr/bin/env -S ocaml unix.cma

open Ansi_terminal

let config_file = Filename.concat "src" "config.ml"
let cwd = Sys.getcwd ()

(* Default data_dir is ../benchmarks/examples/data *)
let data_dir =
  let home = try Sys.getenv "HOME" with Not_found -> "" in
  ref Filename.(concat home @@ concat "benchmarks" @@ concat "examples" "data")

(* Default arch_dir is ./arch *)
let arch_dir = ref (Filename.concat cwd "arch")

(* Default tightprove_cache is ./tightprove_cache *)
let tightprove_cache = ref (Filename.concat cwd "tightprove_cache")

(* Default sage binary path is ../SageMath/sage *)
let sage = ref Filename.(concat cwd @@ concat ".." @@ concat "SageMath" "sage")

(* Default tightprove-exec.sage binary path is ../tightPROVEp/tightprove-exec.sage *)
let tightprove =
  ref
    Filename.(
      concat cwd @@ concat ".." @@ concat "tightPROVEp" "tightprove-exec.sage")

let set_dir r dir =
  let dir = if Filename.is_relative dir then Filename.concat cwd dir else dir in
  r := dir

let quiet = ref false
let nocolor = ref false
let nodeps = ref false

let args =
  [
    ( "--quiet",
      Arg.Set quiet,
      "Configure quietly. No output means everything went well" );
    ( "--nocolor",
      Arg.Set nocolor,
      "Configure in black&white. You don't want fancy colors" );
    ("--nodeps", Arg.Set nodeps, "Configure without checking for dependencies");
    ( "--datadir",
      Arg.String (set_dir data_dir),
      "DIR where the examples are stored for testing (not mandatory)" );
    ( "--mandir",
      Arg.String (set_dir arch_dir),
      "DIR where to find the C headers for each architecture." );
    ( "--docdir",
      Arg.String (set_dir tightprove_cache),
      "DIR to use as a cache for tightprove when compiling Usuba files with \
       `-tp`. If you do not already have a cache from a previous installation \
       of Usuba, you can probably leave it as is (not mandatory)" );
    ( "--sage",
      Arg.String (set_dir sage),
      "BIN the command to invoke to run SageMath. If you have a system-wide \
       installation of SageMath, then setting it as 'sage' should work. \
       Otherwise, specify the full path of you sage installation. (not \
       mandatory)" );
    ( "--tightprove",
      Arg.String (set_dir tightprove),
      "BIN the full path of the tightPROVE+ binary (not mandatory)" );
  ]

let () =
  Arg.parse (Arg.align args)
    (Format.ksprintf
       (fun s -> raise (Arg.Bad s))
       "Don't know what to do with %s")
    "Usage: ./configure [OPTIONS]\nOPTIONS are:"

(* open Format *)
let data_dir = !data_dir
let arch_dir = !arch_dir
let tightprove_cache = !tightprove_cache
let sage = !sage
let tightprove = !tightprove
let quiet = !quiet
let nocolor = !nocolor

let printf fmt =
  if quiet then Format.(ifprintf std_formatter fmt) else Format.printf fmt

let _ =
  if not nocolor then (
    add_ansi_marking Format.std_formatter;
    add_ansi_marking Format.err_formatter)

let print_good fmt = printf ("@{<fg_green>" ^^ fmt ^^ "@}@.")
let print_absent fmt = printf ("@{<fg_yellow>" ^^ fmt ^^ "@}@.")
let print_bad fmt = printf ("@{<fg_red>" ^^ fmt ^^ "@}@.")

let flush_channel oc =
  let rec aux acc =
    match input_line oc with
    | l -> aux (l :: acc)
    | exception End_of_file -> String.concat "\n" (List.rev acc)
  in
  aux []

let check_exec ?(mandatory = true) e =
  printf "  Checking for %s... @?" e;
  let cmd_out = Unix.open_process_in (Format.sprintf "which %s" e) in
  let e = flush_channel cmd_out in
  match Unix.close_process_in cmd_out with
  | Unix.WEXITED 0 -> print_good "%s" e
  | _ ->
      if mandatory then print_bad "no"
      else print_absent "absent but not mandatory"

let ocaml_version () =
  printf "  Checking OCaml version (>= 4.05.0)... @?";
  let e = Sys.ocaml_version in
  match String.split_on_char '.' e with
  | major :: minor :: patchlevel :: _
    when int_of_string major >= 4
         && int_of_string minor >= 5
         && int_of_string patchlevel >= 0 ->
      print_good "%s" e
  | _ -> print_bad "< 4.05.0"

let dependencies () =
  if not !nodeps then (
    printf "  Checking for dependencies... @?";

    let cmd_out = Unix.open_process_in "opam install --deps-only -y . 2>&1" in
    let e = flush_channel cmd_out in
    match Unix.close_process_in cmd_out with
    | Unix.WEXITED 0 -> print_good "ok: %s" e
    | _ ->
        print_absent "Could not install dependencies, try do it manually:@,%s" e)

let check_env () =
  check_exec "opam";
  check_exec "dune";
  check_exec ~mandatory:false "icc";
  check_exec ~mandatory:false "clang";
  check_exec ~mandatory:false "gcc";
  dependencies ();
  ocaml_version ()

let gen_config () =
  let co = open_out config_file in
  let ppo = Format.formatter_of_out_channel co in
  printf
    "@[<v 2>Generating %s with:@,\
     data_dir         : %s@,\
     arch_dir         : %s@,\
     tightprove_cache : %s@,\
     sage             : %s@,\
     tightprove       : %s@]@,\
     ... " config_file data_dir arch_dir tightprove_cache sage tightprove;
  Format.fprintf ppo
    "@[<v 0>(* This file was automatically generated. Manual edits might be \
     overriten whenever the configure script is ran again. *)@,";
  Format.fprintf ppo {|let data_dir = "%s"@,|} data_dir;
  Format.fprintf ppo {|let arch_dir = "%s"@,|} arch_dir;
  Format.fprintf ppo {|let tightprove_cache = "%s"@,|} tightprove_cache;
  Format.fprintf ppo {|let sage = "%s"@,|} sage;
  Format.fprintf ppo {|let tightprove = "%s"@.|} tightprove;
  Format.fprintf ppo
    {|
type arch = Std | MMX | SSE | AVX | AVX512 | Neon | AltiVec
[@@@deriving show, sexp]

type slicing = H | V | B [@@@deriving show, sexp]

type config = {
  output : string;
  warning_as_error : bool;
  verbose : int;
  path : string list;
  type_check : bool;
  check_tbl : bool;
  auto_inline : bool;
  light_inline : bool;
  inline_all : bool;
  heavy_inline : bool;
  no_inline : bool;
  compact_mono : bool;
  fold_const : bool;
  cse : bool;
  copy_prop : bool;
  loop_fusion : bool;
  pre_schedule : bool;
  scheduling : bool;
  schedule_n : int;
  share_var : bool;
  linearize_arr : bool;
  precal_tbl : bool;
  archi : arch;
  bits_per_reg : int;
  no_arr : bool;
  arr_entry : bool;
  unroll : bool;
  interleave : int;
  inter_factor : int;
  fdti : string;
  lazylift : bool;
  slicing_set : bool;
  slicing_type : slicing;
  m_set : bool;
  m_val : int;
  tightPROVE : bool;
  tightprove_dir : string;
  maskVerif : bool;
  masked : bool;
  ua_masked : bool;
  shares : int;
  gen_bench : bool;
  keep_tables : bool;
  compact : bool;
  bench_inline : bool;
  bench_inter : bool;
  bench_bitsched : bool;
  bench_msched : bool;
  bench_sharevar : bool;
  dump_sexp : bool;
}
[@@@deriving show]
|};
  print_good "done";
  printf "@.";
  close_out co

let () =
  printf "@[<v 2>Generating files@,";
  gen_config ();
  printf "@.Checking env@.";
  check_env ();
  printf "@."
