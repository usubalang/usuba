
open Lexer
open Lexing
open Abstract_syntax_tree
open Print_ast
open Ocaml_gen
       
let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  Printf.fprintf outx "%s:%d:%d" pos.pos_fname
          pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_file (filename:string) : prog =
  let f = open_in filename in
  let lex = from_channel f in
  try
    lex.lex_curr_p <- { lex.lex_curr_p with pos_fname = filename; };
    Parser.prog Lexer.token lex
  with
  | SyntaxError msg ->
     Printf.fprintf stderr "%a: %s\n" print_position lex msg;
     exit (-1)
  | Parser.Error ->
     Printf.fprintf stderr "%a: syntax error\n" print_position lex;
     exit (-1)
                   
let p = parse_file (Sys.argv.(1)) ;;
  
  print_string (string_of_prog p) ;
  print_string "\n\n************************************\n";
  print_string "Ocaml code:\n\n";
  print_string (prog_to_ml p) 
               
