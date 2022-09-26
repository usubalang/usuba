open Usuba_lib
open Config

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
  let input_files = ref [] in
  let anon_fun filename = input_files := filename :: !input_files in
  let conf = Parse_opt.generate_conf ~anon_fun Arg.parse in
  Array.iter (fun s -> Format.eprintf "%s@." s) Sys.argv;
  List.iter
    (fun file ->
      let path = Filename.dirname file :: List.rev conf.path in
      let base_file = Filename.(basename @@ chop_suffix file ".ua") in
      let dump_steps_dir = Filename.(concat conf.dump_steps_dir base_file) in
      (if conf.dump_steps <> None then
       try Sys.mkdir dump_steps_dir 0o777 with Sys_error _ -> ());
      let dump_steps_base_file = Filename.(concat dump_steps_dir base_file) in
      let conf = { conf with path; dump_steps_base_file; dump_steps_dir } in
      compile file conf)
    !input_files

let () = main ()
