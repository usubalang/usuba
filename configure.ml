#!/usr/bin/env -S ocaml unix.cma

let config_file = Filename.concat "src" "config.ml"
let cwd = Sys.getcwd ()

(* Default data_dir is ../examples/data *)
let data_dir =
  ref Filename.(concat cwd @@ concat ".." @@ Filename.concat "examples" "data")

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

let args =
  [
    ( "--quiet",
      Arg.Set quiet,
      "Configure quietly. No output means everything went well" );
    ( "--nocolor",
      Arg.Set nocolor,
      "Configure in black&white. You don't want fancy colors" );
    ( "--datadir",
      Arg.String (set_dir data_dir),
      "DIR where the examples are stored for testing" );
    ( "--mandir",
      Arg.String (set_dir arch_dir),
      "DIR where to find the C headers for each architecture." );
    ( "--docdir",
      Arg.String (set_dir tightprove_cache),
      "DIR to use as a cache for tightprove when compiling Usuba files with \
       `-tp`. If you do not already have a cache from a previous installation \
       of Usuba, you can probably leave it as is" );
    ( "--sage",
      Arg.String (set_dir sage),
      "BIN the command to invoke to run SageMath. If you have a system-wide \
       installation of SageMath, then setting it as 'sage' should work. \
       Otherwise, specify the full path of you sage installation." );
    ( "--tightprove",
      Arg.String (set_dir tightprove),
      "BIN the full path of the tightPROVE+ binary" );
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

type style = Normal | FG_Black | FG_Red | FG_Green | FG_Default | BG_Default

let close_tag = function
  | FG_Black | FG_Red | FG_Green | FG_Default -> FG_Default
  | BG_Default -> BG_Default
  | _ -> Normal

let style_of_tag = function
  | Format.String_tag s -> (
      match s with
      | "n" -> Normal
      | "fg_black" -> FG_Black
      | "fg_red" -> FG_Red
      | "fg_green" -> FG_Green
      | "fg_default" -> FG_Default
      | "bg_default" -> BG_Default
      | _ -> raise Not_found)
  | _ -> raise Not_found

(* See https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters for some values *)
let to_ansi_value = function
  | Normal -> "0"
  | FG_Black -> "30"
  | FG_Red -> "31"
  | FG_Green -> "32"
  | FG_Default -> "39"
  | BG_Default -> "49"

let ansi_tag = Printf.sprintf "\x1B[%sm"
let start_mark_ansi_stag t = ansi_tag @@ to_ansi_value @@ style_of_tag t

let stop_mark_ansi_stag t =
  ansi_tag @@ to_ansi_value @@ close_tag @@ style_of_tag t

let add_ansi_marking formatter =
  let open Format in
  pp_set_mark_tags formatter true;
  let old_fs = pp_get_formatter_stag_functions formatter () in
  pp_set_formatter_stag_functions formatter
    {
      old_fs with
      mark_open_stag = start_mark_ansi_stag;
      mark_close_stag = stop_mark_ansi_stag;
    }

let _ =
  if not nocolor then (
    add_ansi_marking Format.std_formatter;
    add_ansi_marking Format.err_formatter)

let printf fmt =
  if quiet then Format.(ifprintf std_formatter fmt) else Format.printf fmt

let print_good fmt = printf ("@{<fg_green>" ^^ fmt ^^ "@}")
let print_bad fmt = printf ("@{<fg_red>" ^^ fmt ^^ "@}")

let flush_channel oc =
  let rec aux acc =
    match input_line oc with
    | l -> aux (l :: acc)
    | exception End_of_file -> String.concat "\n" (List.rev acc)
  in
  aux []

let check_exec e =
  printf "Checking for %s... " e;
  let cmd_out = Unix.open_process_in (Format.sprintf "which %s" e) in
  let e = flush_channel cmd_out in
  match Unix.close_process_in cmd_out with
  | Unix.WEXITED 0 -> print_good "%s@," e
  | _ -> print_bad "no@,"

let ocaml_version () =
  printf "Checking OCaml version (>= 4.05.0)... ";
  let e = Sys.ocaml_version in
  match String.split_on_char '.' e with
  | major :: minor :: patchlevel :: _
    when int_of_string major >= 4
         && int_of_string minor >= 5
         && int_of_string patchlevel >= 0 ->
      print_good "%s@," e
  | _ -> print_bad "< 4.05.0"

let dependencies () =
  printf "Checking for dependencies... ";
  let cmd_out =
    Unix.open_process_in "dune external-lib-deps --missing @@default 2>&1"
  in
  let e = flush_channel cmd_out in
  match Unix.close_process_in cmd_out with
  | Unix.WEXITED 0 -> print_good "ok %s@," e
  | _ -> print_bad "no:@,%s@," e

let check_env () =
  check_exec "opam";
  check_exec "dune";
  check_exec "icc";
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
  print_good "done";
  printf "@.";
  close_out co

let () =
  printf "@[<v 2>Generating files@,";
  gen_config ();
  printf "@.@[<v 2>Checking env@,";
  check_env ();
  printf "@."
