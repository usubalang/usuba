module String_Map = Map.Make (String)

(* Edit this list if you want to execute usuba on
 * different files or with different options *)
let files_map =
  [
    ("ace.ua", "-V -interleave 2");
    ("aes_mslice.ua", "-H");
    ("aes_generic.ua", "-V");
    ("ascon.ua", "-V -interleave 2");
    ("rectangle.ua", "-H -interleave 2");
  ]
  |> List.fold_left
       (fun acc (file, options) -> String_Map.add file options acc)
       String_Map.empty

let absolute_dir dir =
  if String.starts_with ~prefix:"~" dir then
    Filename.concat (Unix.getenv "HOME")
      (String.sub dir 2 (String.length dir - 2))
  else if Filename.is_relative dir then Filename.concat (Sys.getcwd ()) dir
  else dir

let examples_dir = ref "~/usuba_benchs/examples/samples/usuba"
let usuba_args = ref []

let specs =
  Arg.(
    align
      [
        ("--path", Set_string examples_dir, " <path>  Path to the .ua files");
        ( "--",
          Rest_all (fun l -> usuba_args := l),
          " <list of args>  Options that will be given to usubac" );
      ])

let usage =
  Printf.sprintf
    "%s [OPTION...] \n\n\
     Dump an usuba file at each step of normalisation and optimisation.\n\n\
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
  let usuba_args = !usuba_args in
  let dir = absolute_dir !examples_dir in
  Format.eprintf "Examples dir: %s@." dir;
  let files = Sys.readdir dir in
  Array.iter
    (fun file ->
      match String_Map.find file files_map with
      | args -> (
          let file = Filename.concat dir file in
          Format.eprintf "File: %s@." file;
          let cmd =
            Format.asprintf "dune exec -- usuba %s %a %s" file
              Format.(
                pp_print_list ~pp_sep (fun ppf s -> Format.fprintf ppf "%s" s))
              usuba_args args
          in
          Format.eprintf "%s... @." cmd;
          let cmd_out = Unix.open_process_in cmd in

          let e = flush_channel cmd_out in
          match Unix.close_process_in cmd_out with
          | Unix.WEXITED 0 -> Format.eprintf "  ok@."
          | _ -> Format.eprintf "Something went wrong: %s@." e)
      | exception Not_found -> ())
    files
