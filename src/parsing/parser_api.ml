open Lexer
open Lexing
open Usuba_AST
open Printf

let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
          pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_file (filename:string) : Usuba_AST.prog =
  let f = open_in filename in
  let lex = from_channel f in
  try
    lex.lex_curr_p <- { lex.lex_curr_p with pos_fname = filename; };
    Parser.prog Lexer.token lex
  with
  | SyntaxError msg ->
     fprintf stderr "%a: %s\n" print_position lex msg;
     exit (-1)
  | Parser.Error ->
     fprintf stderr "%a: syntax error\n" print_position lex;
     exit (-1)

let parse_generic (parse_fun:(Lexing.lexbuf -> Parser.token) -> Lexing.lexbuf -> 'a)
      (str:string) : 'a =
  let lex = from_string str in
  try
    parse_fun Lexer.token lex
  with
  | SyntaxError msg ->
     fprintf stderr "%a: %s\n" print_position lex msg;
     exit (-1)
  | Parser.Error ->
     fprintf stderr "%a: syntax error\n" print_position lex;
     exit (-1)

let parse_prog (str:string) : Usuba_AST.prog =
  parse_generic Parser.prog str

let parse_arith_expr (str:string) : Usuba_AST.arith_expr =
  parse_generic Parser.arith_exp_a str

let parse_var (str:string) : Usuba_AST.var =
  parse_generic Parser.var_a str

let parse_expr (str:string) : Usuba_AST.expr =
  parse_generic Parser.exp_a str

let parse_deq (str:string) : Usuba_AST.deq =
  parse_generic Parser.deq_a str

let parse_def (str:string) : Usuba_AST.def =
  parse_generic Parser.def_a str
