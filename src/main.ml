
open Lexer
open Lexing
open Abstract_syntax_tree
open Print_ast
open Ocaml_gen_naive
open Printf
       
let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
          pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_file (filename:string) : prog =
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


let main () =
  let file_in = Sys.argv.(1) in
  let p = parse_file file_in in

  (* uncomment to print the program that was read*)
  (* print_string (string_of_prog p) ; *)

  (* Generating OCaml code *)
  let full_name = match (String.split_on_char '.' file_in) with
    | []   -> file_in
    | x::_ ->  x in
  let path = String.split_on_char '/' full_name in
  let out_name = List.nth path (List.length path - 1) in
  let out = open_out ("tests/ocaml_run/" ^ out_name ^ "_naive.ml") in
  fprintf out "open Ocaml_runtime\n";
  fprintf out "%s" (Ocaml_gen_naive.prog_to_ml p);
  (* naive_code p; *)
  close_out out

let () = main ()
