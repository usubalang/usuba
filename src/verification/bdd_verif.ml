open Prelude
open Usuba_AST
open Basic_utils
open Utils
open MLBDD

(* Abstracting Hashtbl.
   This functions should replace the ones in Utils, one day. *)
let print_env env =
  ignore (Hashtbl.fold (fun k v _ -> print_endline k.name) env ())

let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_fetch env v = Hashtbl.find env v

let rec expr_to_bdd env man (e : expr) =
  match e with
  | ExpVar (Var v) -> env_fetch env v
  | Const 0 -> MLBDD.dfalse man
  | Const 1 -> MLBDD.dtrue man
  | Not e -> MLBDD.dnot (expr_to_bdd env man e)
  | Log (op, e1, e2) -> (
      let e1 = expr_to_bdd env man e1 in
      let e2 = expr_to_bdd env man e2 in
      match op with
      | And -> MLBDD.dand e1 e2
      | Or -> MLBDD.dor e1 e2
      | Xor -> MLBDD.xor e1 e2
      | Andn -> MLBDD.dand (MLBDD.dnot e1) e2)
  | _ ->
      Printf.printf "Can't convert '%s' to BDD.\n" (Usuba_print.expr_to_str e);
      assert false

let deqs_to_bdd (node1 : def) (deqs1 : deq list) (node2 : def)
    (deqs2 : deq list) =
  let man = MLBDD.init () in

  let env1 = make_env () in
  let env2 = make_env () in

  List.iteri
    (fun i ((id, _), _) -> env_add env1 id (MLBDD.ithvar man i))
    node1.p_in;
  List.iteri
    (fun i ((id, _), _) -> env_add env2 id (MLBDD.ithvar man i))
    node2.p_in;

  let build_bdd deqs env =
    List.iter
      (fun deq ->
        match deq with
        | Eqn ([ Var id ], e) -> env_add env id (expr_to_bdd env man e)
        | _ -> Printf.printf "Invalid expr: %s\n" (Usuba_print.deq_to_str deq))
      deqs
  in

  build_bdd deqs1 env1;
  build_bdd deqs2 env2;

  (*let ((id,_),_) = List.nth node1.p_out 3 in
    print_endline (MLBDD.to_string (env_fetch env1 id));
    print_endline (join "," (List.map string_of_int (MLBDD.list_of_support (MLBDD.support (env_fetch env1 id)))));*)
  (env1, env2)

let compare_defs (node1 : def) (node2 : def) : bool =
  match (node1.node, node2.node) with
  | Single (_, body1), Single (_, body2) ->
      if node1.p_in <> node2.p_in || node1.p_out <> node2.p_out then
        raise (Error "Nodes have different inputs or outputs.");
      let env1, env2 = deqs_to_bdd node1 body1 node2 body2 in
      print_endline "Verification starts";
      List.for_all
        (fun ((id, _), _) ->
          let x1 = env_fetch env1 id in
          let x2 = env_fetch env2 id in
          MLBDD.equal x1 x2)
        node1.p_out
  | _ -> assert false

let compare_prog (prog1 : prog) (prog2 : prog) : bool =
  compare_defs (last prog1.nodes) (last prog2.nodes)
