
open Lexer
open Lexing
open Abstract_syntax_tree
open Print_ast

let parse_file (filename:string) : prog =
  let f = open_in filename in
  let lex = from_channel f in
  try
    lex.lex_curr_p <- { lex.lex_curr_p with pos_fname = filename; };
    Parser.prog Lexer.token lex
  with
  | Parser.Error ->
      Printf.eprintf "Parse error (invalid syntax)\n";
      failwith "Parse error"
  | Failure "lexing: empty token" ->
      Printf.eprintf "Parse error (invalid token)\n";
      failwith "Parse error"

                   
let p = parse_file (Sys.argv.(1)) ;;
print_string (string_of_prog p)
  
