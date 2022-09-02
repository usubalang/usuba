open Prelude
open Lexing
open Usuba_AST
module I = Parser.MenhirInterpreter

let get_include_filename (path : string list) (filename : string) : string =
  if Sys.file_exists filename then filename
  else
    try
      Filename.concat
        (List.find
           (fun dir -> Sys.file_exists (Filename.concat dir filename))
           path)
        filename
    with Not_found ->
      Format.eprintf "File '%s' not found in path. Path contains: [%s].@."
        filename
        (Basic_utils.join "; " (List.map (fun s -> "\"" ^ s ^ "\"") path));
      assert false

let succeed prog =
  (* The parser has succeeded and produced a semantic value. Return it. *)
  prog

let fail lexbuf (cp : _ I.checkpoint) =
  let infos = Errors.get_infos lexbuf in
  match cp with
  | HandlingError env ->
      let err = Parser_helper.get_parse_error env in
      raise (Errors.Syntax_error (Some infos, Errors.s_to_msg err))
  | _ -> assert false

let loop lexbuf result =
  let supplier = I.lexer_lexbuf_to_supplier Lexer.token lexbuf in
  I.loop_handle succeed (fail lexbuf) supplier result

let rec parse_file (path : string list) (filename : string) : Usuba_AST.prog =
  let ci = open_in filename in
  let lexbuf = Lexing.from_channel ci in
  Lexing.set_filename lexbuf filename;
  try
    let prog = loop lexbuf (Parser.Incremental.prog lexbuf.lex_curr_p) in
    close_in ci;
    { nodes = resolve_includes path prog }
  with e -> (
    close_in ci;
    let infos = Errors.get_infos lexbuf in
    (* Format.eprintf "LEXBUF: %s@." (Bytes.to_string lexbuf.Lexing.lex_buffer); *)
    match e with
    | Errors.Malformed_type t ->
        let err ppf () = Format.fprintf ppf "Malformed type: '%s'" t in
        raise
          (Errors.Syntax_error
             ( Some
                 {
                   infos with
                   col_end = infos.col_start;
                   col_start = infos.col_start - String.length t;
                 },
               err ))
    | Errors.Single_of_table ((start_pos, end_pos), s) ->
        let err ppf () =
          Format.fprintf ppf
            "@[<v 2>Declaration of a single %s containing an array of \
             declarations.@,\
             Write %s[] if you want to use an array." s s
        in
        raise
          (Errors.Syntax_error
             ( Some
                 {
                   infos with
                   line = start_pos.Lexing.pos_lnum;
                   col_start = start_pos.pos_cnum;
                   col_end = end_pos.pos_cnum;
                 },
               err ))
    | Errors.Table_of_single ((start_pos, end_pos), s) ->
        let err ppf () =
          Format.fprintf ppf
            "@[<v 2>Declaration of an array %s containing a single \
             declaration.@,\
             Write '%s' if you want to use a single declaration." s s
        in
        raise
          (Errors.Syntax_error
             ( Some
                 {
                   infos with
                   line = start_pos.Lexing.pos_lnum;
                   col_start = start_pos.pos_cnum;
                   col_end = end_pos.pos_cnum;
                 },
               err ))
    | _ -> raise e)

and resolve_includes (path : string list) (l : def_or_inc list) : def list =
  Basic_utils.flat_map
    (fun x ->
      match x with
      | Def d -> [ d ]
      | Inc s ->
          let filename = get_include_filename path s in
          let dirname = Filename.dirname filename in
          (* SMTLIB_IMPORT: List.mem of string is authorized *)
          let path =
            if Stdlib.List.mem dirname path then path else dirname :: path
          in
          (parse_file path filename).nodes)
    l

let parse_generic (parse_fun : Lexing.position -> 'a I.checkpoint)
    (str : string) : 'a =
  let lexbuf = Lexing.from_string str in
  loop lexbuf (parse_fun lexbuf.lex_curr_p)

let parse_prog (str : string) : Usuba_AST.prog =
  {
    nodes = resolve_includes [ "" ] (parse_generic Parser.Incremental.prog str);
  }

let parse_arith_expr (_str : string) : Usuba_AST.arith_expr = raise Exit
(* parse_generic Parser.Incremental.test_arith_exp_a str *)

let parse_var (_str : string) : Usuba_AST.var = raise Exit
(* parse_generic Parser.Incremental.test_var_a str *)

let parse_expr (_str : string) : Usuba_AST.expr = raise Exit
(* parse_generic Parser.Incremental.test_exp_a str *)

let parse_deq (_str : string) : Usuba_AST.deq = raise Exit
(* parse_generic Parser.Incremental.test_deq_a str *)

let parse_def (_str : string) : Usuba_AST.def = raise Exit
(* parse_generic Parser.Incremental.test_def_a str *)
