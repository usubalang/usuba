open Usuba_AST
open Basic_utils
open Utils
open Pass_runner

(* Simplify (ie, remove) every tuples that can be simplified:
     - Remove Tuples from function call arguments:
         f(a,(b,c)) == f(a,b,c)
     - Flatten Tuples of Tuples:
         (a,(b,c)) == (a,b,c)
     - Remove Tuples of one element
         (e) == e
*)
module Simplify_tuples = struct
  (* Builds an expression from an list of expression: if the list
     contains a single element, then return it, otherwise, wrap the
     list in a Tuple. *)
  let expr_from_list (el : expr list) : expr =
    match el with [ e ] -> e | el -> Tuple el

  (* Returns a list of expression from an expression. The caller
     should then take care or rebuilding an expression from this list
     using expr_from_list.

     Note that in the spirit of "sticking to one job", this function
     doesn't perform any kind of expansion/unfolding: for instance, if
     a Not is applied to a Tuple, then let it be. Some other module
     will take care of distributing the Not on every elements of the
     Tuple. *)
  let rec simpl_tuple (e : expr) : expr list =
    match e with
    | Tuple l -> flat_map simpl_tuple l
    | Not e -> [ Not (expr_from_list (simpl_tuple e)) ]
    | Log (op, x, y) ->
        [
          Log
            (op, expr_from_list (simpl_tuple x), expr_from_list (simpl_tuple y));
        ]
    | Arith (op, x, y) ->
        [
          Arith
            (op, expr_from_list (simpl_tuple x), expr_from_list (simpl_tuple y));
        ]
    | Shift (op, e, n) -> [ Shift (op, expr_from_list (simpl_tuple e), n) ]
    | Bitmask (e, ae) -> [ Bitmask (expr_from_list (simpl_tuple e), ae) ]
    | Pack (e1, e2, t) ->
        [
          Pack
            (expr_from_list (simpl_tuple e1), expr_from_list (simpl_tuple e2), t);
        ]
    | Fun (f, l) ->
        (* If |l| is a Tuple, then the reccursive call goes into Tuple,
           effectively removing the Tuple. *)
        [ Fun (f, flat_map simpl_tuple l) ]
    | Fun_v (f, n, l) -> [ Fun_v (f, n, flat_map simpl_tuple l) ]
    | _ -> [ e ]

  let rec simpl_deqs (deq : deq list) : deq list =
    List.map
      (fun d ->
        {
          d with
          content =
            (match d.content with
            | Eqn (p, e, sync) -> Eqn (p, expr_from_list (simpl_tuple e), sync)
            | Loop (i, ei, ef, dl, opts) -> Loop (i, ei, ef, simpl_deqs dl, opts));
        })
      deq

  let simpl_tuples_def (def : def) : def =
    match def.node with
    | Single (p_var, body) ->
        { def with node = Single (p_var, simpl_deqs body) }
    | _ -> def

  let run _ (prog : prog) (_ : Config.config) : prog =
    { nodes = List.map simpl_tuples_def prog.nodes }

  let as_pass = (run, "Simplify_tuples", 0)
end

(* Split of tuples into assignements of non-tuples:
       (x1,x2,x3) = (a,b,c)
     becomes
       x1 = a;
       x2 = b;
       x3 = c;
   This also works for assigments like
       x = (a,b,c)
     which becomes
       x[0] = a;
       x[1] = b;
       x[2] = c;
*)
module Split_tuples = struct
  let real_split_tuple env (orig : (ident * deq_i) list) (p : var list)
      (e : expr) (sync : bool) : deq list =
    let el = Unfold_unnest.expand_expr env e in
    let pl = flat_map (expand_var env) p in
    (* Need to make sure that |el| and |pl| have the same size. Since
       monomorphization hasn't occured yet, it could happen that |p|
       and |e| don't have the same size yet, in particular because
       Const haven't been expanded. *)
    if List.length el = List.length pl then
      List.map2 (fun l r -> { content = Eqn ([ l ], r, sync); orig }) pl el
    else [ { content = Eqn (p, e, sync); orig } ]

  let rec split_tuples_deq env (body : deq list) : deq list =
    flat_map
      (fun d ->
        match d.content with
        | Eqn (p, e, sync) ->
            if contains_fun e then [ d ]
            else real_split_tuple env d.orig p e sync
        | Loop (i, ei, ef, dl, opts) ->
            Hashtbl.add env i Nat;
            let res =
              [
                {
                  d with
                  content = Loop (i, ei, ef, split_tuples_deq env dl, opts);
                };
              ]
            in
            Hashtbl.remove env i;
            res)
      body

  let split_tuples_def (def : def) : def =
    match def.node with
    | Single (p_var, body) ->
        let env = build_env_var def.p_in def.p_out p_var in
        { def with node = Single (p_var, split_tuples_deq env body) }
    | _ -> def

  let run _ prog _ = { nodes = List.map split_tuples_def prog.nodes }
  let as_pass = (run, "Split_tuples", 0)
end

let rec norm_tuples_def (def : def) : def =
  let def' =
    Simplify_tuples.simpl_tuples_def
      (Split_tuples.split_tuples_def (Simplify_tuples.simpl_tuples_def def))
  in

  (* Fixpoint to make sure every tuples are complitely simplified. *)
  if def <> def' then norm_tuples_def def' else def

let rec run (runner : pass_runner) (prog : prog) (conf : Config.config) : prog =
  let prog' =
    runner#run_modules
      [ Simplify_tuples.as_pass; Split_tuples.as_pass; Simplify_tuples.as_pass ]
      prog
  in

  (* Fixpoint to make sure every tuples are complitely simplified. *)
  if prog <> prog' then run runner prog' conf else prog'

let as_pass = (run, "Norm_tuples", 1)
