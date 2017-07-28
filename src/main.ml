
open Usuba_AST
open Ocaml_gen_naive
open Printf
open Parse_file
open Interp

let print_naive_ml (file_in: string) (prog: Usuba_AST.prog) =
  (* Generating OCaml code *)
  let full_name = match (String.split_on_char '.' file_in) with
    | []     -> file_in
    | x :: _ ->  x in
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

  let c_prog = Usuba_to_c.prog_to_c prog normalized in

  (* Check_soundness.check_soundness prog normalized c_prog; *)
  print_endline (Gen_z3.Usuba.gen_z3 prog);
  
  fprintf out "%s" c_prog;
  fprintf out "\n\nint main() { return 0; }";
  close_out out
            
let main () =
  Printexc.record_backtrace true;

  Arg.parse []
            (fun s ->
             let prog = parse_file s in
             (* print_naive_ml s prog; print_ortho_ml s prog; *)
             print_c s prog ) "Usage"
                 

let () = main ()
