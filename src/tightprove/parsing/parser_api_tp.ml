open Lexer_tp
open Lexing
open Tp_AST
open Printf

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
          pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_file (filename:string) : Tp_AST.prog =
  let f = open_in filename in
  let lex = from_channel f in
  try
    lex.lex_curr_p <- { lex.lex_curr_p with pos_fname = filename; };
    Parser_tp.prog Lexer_tp.token lex
  with
  | SyntaxError msg ->
     fprintf stderr "%a: %s\n" print_position lex msg;
     exit (-1)
  | Parser_tp.Error ->
     fprintf stderr "%a: syntax error\n" print_position lex;
     exit (-1)

let parse_generic (parse_fun:(Lexing.lexbuf -> Parser_tp.token) -> Lexing.lexbuf -> 'a)
      (str:string) : 'a =
  let lex = from_string str in
  try
    parse_fun Lexer_tp.token lex
  with
  | SyntaxError msg ->
     fprintf stderr "%a: %s\n" print_position lex msg;
     exit (-1)
  | Parser_tp.Error ->
     fprintf stderr "%a: syntax error\n" print_position lex;
     exit (-1)

let parse_prog (str:string) : Tp_AST.prog =
  parse_generic Parser_tp.prog str

let parse_expr (str:string) : Tp_AST.expr =
  parse_generic Parser_tp.expr_a str
