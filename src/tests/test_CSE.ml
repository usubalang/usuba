open Usuba_AST
open Utils
open CSE
open Parser_api

let test_simple () =
  let deqs = List.map parse_deq [ "x = a + b"; "y = a + b"; "z = a + b" ] in
  let deqs' = cse_deqs (Hashtbl.create 10) deqs in
  assert (deqs' = List.map parse_deq [ "x = a + b"; "y = x"; "z = x" ])

(* Make sure that consts aren't getting replaced by variables *)
let test_const () =
  let deqs  = List.map parse_deq [ "x = 0"; "y = 0" ] in
  let deqs' = cse_deqs (Hashtbl.create 10) deqs in
  assert (deqs' <> List.map parse_deq [ "x = 0"; "y = x" ]);
  assert (deqs' =  List.map parse_deq [ "x = 0"; "y = 0" ])

let test_loop () =
  (* Making sure loops aren't uncorrectly optimized *)
  let deqs = List.map parse_deq [
                 "forall i in [1,2] { x[i] = y[i] ^ z[i] }";
                 "forall i in [3,4] { x[i] = y[i] ^ z[i] }"
               ] in
  let deqs' = cse_deqs (Hashtbl.create 10) deqs in
  assert (deqs' = deqs)


let test () =
  test_simple ();
  test_const ();
  test_loop ()
