open Usuba_AST
open Parser_api
open Pass_runner

let test_simple () =
  let prog = parse_prog "node f(x:b1) returns (y:b1) let y = x tel" in
  let expected = parse_prog "node f_a_b(x:b1) returns (y:b1) let y = x tel" in
  let runner = new pass_runner Utils.default_conf in
  let result =
    runner#run_modules
      [
        ( (fun _ p _ ->
            {
              nodes =
                List.map
                  (fun n -> { n with id = Ident.fresh_suffixed n.id "_a" })
                  p.nodes;
            }),
          "a",
          0 );
        ( (fun _ p _ ->
            {
              nodes =
                List.map
                  (fun n -> { n with id = Ident.fresh_suffixed n.id "_b" })
                  p.nodes;
            }),
          "b",
          0 );
      ]
      prog
  in
  if equal_prog result expected then ()
  else (
    Format.eprintf "%a@." Usuba_print.(pp_prog ()) result;
    raise Exit)

let test () = test_simple ()
