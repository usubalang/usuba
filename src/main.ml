
open Lexer
open Lexing
open Usuba_AST
open Ocaml_gen_naive
open Printf
open Sol_AST
open Usuba_to_sol
       
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

let print_naive_ml (file_in: string) (prog: Usuba_AST.prog) =
  (* Generating OCaml code *)
  let full_name = match (String.split_on_char '.' file_in) with
    | []   -> file_in
    | x::_ ->  x in
  let path = String.split_on_char '/' full_name in
  let out_name = List.nth path (List.length path - 1) in
  let out = open_out ("tests/ocaml_run/" ^ out_name ^ "_naive.ml") in
  fprintf out "%s" (Ocaml_gen_naive.prog_to_str_ml prog);
  close_out out

let print_ortho_ml (file_in: string) (prog: Usuba_AST.prog) =
  (* Generating OCaml code *)
  let full_name = match (String.split_on_char '.' file_in) with
    | []   -> file_in
    | x::_ ->  x in
  let path = String.split_on_char '/' full_name in
  let out_name = List.nth path (List.length path - 1) in
  let out = open_out ("tests/ocaml_run/" ^ out_name ^ "_ortho.ml") in
  fprintf out "%s" (Ocaml_gen_ortho.prog_to_str_ml prog);
  close_out out

let print_c (file_in: string) (prog: Usuba_AST.prog) =
  (* Generating C code *)
  let full_name = match (String.split_on_char '.' file_in) with
    | []   -> file_in
    | x::_ ->  x in
  let path = String.split_on_char '/' full_name in
  let out_name = List.nth path (List.length path - 1) in
  let out = open_out ("tests/C/" ^ out_name ^ ".c") in
  let normalized = Normalize.norm_prog prog in
  fprintf out "%s" (Usuba_to_c.prog_to_c normalized);
  close_out out
            

let main () =
  Printexc.record_backtrace true;

  Arg.parse []
            (fun s ->
             let prog = parse_file s in
             print_naive_ml s prog; print_ortho_ml s prog;
            (*print_c s prog; *)
             (*let normalized = Normalize.norm_prog prog in
             let sol = Usuba_to_sol.usuba_to_sol normalized in
             Sol_print.print_prog sol*)) "Usage"
            
  (* let normalized = Normalize.norm_prog prog in *)
  (* Usuba_print.print_prog normalized; *)
  (* print_endline "\n#####################################\n"; *)
  (* let sol = Usuba_to_sol.usuba_to_sol normalized in *)
  (* Sol_print.print_prog sol; *)
  (* print_endline "\n#####################################\n"; *)
  (* print_endline (Sol_naive_to_ocaml.prog_to_str_ml sol); *)
                 

let () = main ()
