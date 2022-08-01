open Prelude
open Lexer
open Lexing
open Usuba_AST

let print_position ppf lexbuf =
  let pos = lexbuf.lex_curr_p in
  Format.fprintf ppf "%s:%d:%d" pos.pos_fname pos.pos_lnum
    (pos.pos_cnum - pos.pos_bol + 1)

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

let rec parse_file (path : string list) (filename : string) : Usuba_AST.prog =
  let f = open_in filename in
  let lex = from_channel f in
  try
    lex.lex_curr_p <- { lex.lex_curr_p with pos_fname = filename };
    { nodes = resolve_includes path (Parser.prog Lexer.token lex) }
  with
  | SyntaxError msg ->
      Format.eprintf "%a: %s\n" print_position lex msg;
      exit (-1)
  | Parser.Error ->
      Format.eprintf "%a: syntax error\n" print_position lex;
      exit (-1)

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

let parse_generic
    (parse_fun : (Lexing.lexbuf -> Parser.token) -> Lexing.lexbuf -> 'a)
    (str : string) : 'a =
  let lex = from_string str in
  try parse_fun Lexer.token lex with
  | SyntaxError msg ->
      Format.eprintf "%a: %s\n" print_position lex msg;
      exit (-1)
  | Parser.Error ->
      Format.eprintf "%a: syntax error\n" print_position lex;
      exit (-1)

let parse_prog (str : string) : Usuba_AST.prog =
  { nodes = resolve_includes [ "" ] (parse_generic Parser.prog str) }

let parse_arith_expr (str : string) : Usuba_AST.arith_expr =
  parse_generic Parser.arith_exp_a str

let parse_var (str : string) : Usuba_AST.var = parse_generic Parser.var_a str
let parse_expr (str : string) : Usuba_AST.expr = parse_generic Parser.exp_a str
let parse_deq (str : string) : Usuba_AST.deq = parse_generic Parser.deq_a str
let parse_def (str : string) : Usuba_AST.def = parse_generic Parser.def_a str
