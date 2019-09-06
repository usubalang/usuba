open Usuba_AST
open Utils
open Parser_api
open Pass_runner
       
let test_simple () =
  let runner = new pass_runner default_conf in
  runner#register_pass
           (fun p _ ->
            { nodes = List.map (fun n -> { n with id = fresh_suffix n.id "_a"}) p.nodes}) "a";
  runner#register_pass
           (fun p _ ->
            { nodes = List.map (fun n -> { n with id = fresh_suffix n.id "_b"}) p.nodes}) "b";
  let prog     = parse_prog "node f(x:b1) returns (y:b1) let y = x tel" in
  let expected = parse_prog "node f_a_b(x:b1) returns (y:b1) let y = x tel" in
  let result   = runner#run_all_passes prog in
  assert (result = expected)
       
let test () =
  test_simple ()
