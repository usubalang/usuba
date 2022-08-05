module String_Map = Map.Make (String)

(* Edit this list if you want to execute usuba on
 * different files or with different options *)

let absolute_dir dir =
  if String.starts_with ~prefix:"~" dir then
    Filename.concat (Unix.getenv "HOME")
      (String.sub dir 2 (String.length dir - 2))
  else if Filename.is_relative dir then Filename.concat (Sys.getcwd ()) dir
  else dir

let examples_dir = ref "~/usuba_benchs/examples/samples/usuba"

let specs =
  Arg.(
    align
      [ ("--path", Set_string examples_dir, " <path>  Path to the .ua files") ])

let usage =
  Printf.sprintf
    "%s [OPTION...] \n\n\
     Test that all files are parsed without errors.\n\n\
     Options:"
    Sys.argv.(0)

let pp_sep ppf () = Format.fprintf ppf " "

let flush_channel oc =
  let rec aux acc =
    match input_line oc with
    | l -> aux (l :: acc)
    | exception End_of_file -> String.concat "\n" (List.rev acc)
  in
  aux []

let () =
  Arg.parse specs (fun _ -> ()) usage;
  let dir = absolute_dir !examples_dir in
  Format.eprintf "Examples dir: %s@." dir;
  let files = Sys.readdir dir in
  Array.iter
    (fun file ->
      if Filename.check_suffix file ".ua" then
        let file = Filename.concat dir file in
        let cmd = Format.asprintf "dune exec -- usuba %s -parse-only" file in
        let cmd_out = Unix.open_process_in cmd in
        let e = flush_channel cmd_out in
        match Unix.close_process_in cmd_out with
        | Unix.WEXITED 0 -> ()
        | _ ->
            Format.eprintf "%s@." cmd;
            Format.eprintf "Something went wrong: %s@.@." e)
    files
