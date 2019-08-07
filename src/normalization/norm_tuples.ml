open Usuba_AST
open Basic_utils
open Utils


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
  let expr_from_list (el:expr list) : expr =
    match el with
    | e :: [] -> e
    | el      -> Tuple el

  (* Returns a list of expression from an expression. The caller
     should then take care or rebuilding an expression from this list
     using expr_from_list.

     Note that in the spirit of "sticking to one job", this function
     doesn't perform any kind of expansion/unfolding: for instance, if
     a Not is applied to a Tuple, then let it be. Some other module
     will take care of distributing the Not on every elements of the
     Tuple.  *)
  let rec simpl_tuple (e:expr) : expr list =
    match e with
    | Tuple l -> flat_map simpl_tuple l
    | Not e   -> [ Not (expr_from_list (simpl_tuple e)) ]
    | Shift(op,e,n) -> [ Shift(op,expr_from_list (simpl_tuple e),n) ]
    | Log(op,x,y)   -> [ Log(op,expr_from_list (simpl_tuple x),
                             expr_from_list (simpl_tuple y)) ]
    | Arith(op,x,y) -> [ Arith(op, expr_from_list (simpl_tuple x),
                               expr_from_list (simpl_tuple y)) ]
    | Fun(f,l)     ->
       (* If |l| is a Tuple, then the reccursive call goes into Tuple,
          effectively removing the Tuple. *)
       [ Fun(f,flat_map simpl_tuple l) ]
    | Fun_v(f,n,l) -> [ Fun_v(f,n,flat_map simpl_tuple l) ]
    | _ -> [ e ]

  let rec simpl_deqs (deq:deq list) : deq list =
    List.map (function
        | Eqn(p,e,sync) -> Eqn(p,expr_from_list (simpl_tuple e),sync)
        | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,simpl_deqs dl,opts)) deq

  let simpl_tuples_def (def: def) : def =
    match def.node with
    | Single(p_var,body) ->
       { def with node  = Single(p_var, simpl_deqs body) }
    | _ -> def

  let simpl_tuples (prog: prog) : prog =
    { nodes = List.map simpl_tuples_def prog.nodes }

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
  let real_split_tuple env (p: var list) (l: expr list) (sync:bool) : deq list =
    (* TODO: don't expand here. probably. *)
    List.map2 (fun l r -> Eqn([l],r,sync)) (flat_map (expand_var env) p)
              (flat_map (Unfold_unnest.expand_expr env) l)

  let rec split_tuples_deq env (body: deq list) : deq list =
    flat_map
      (fun x ->
       match x with
                | Eqn (p,e,sync) -> (match e with
                                     | Tuple l -> real_split_tuple env p l sync
                                     | _ -> [ x ])
                | Loop(i,ei,ef,dl,opts) ->
                   Hashtbl.add env i Nat;
                   let res = [ Loop(i,ei,ef,split_tuples_deq env dl,opts) ] in
                   Hashtbl.remove env i;
                   res) body

  let split_tuples_def (def: def) : def =
    match def.node with
    | Single(p_var,body) ->
       let env = build_env_var def.p_in def.p_out p_var in
       { def with node  = Single(p_var, split_tuples_deq env body) }
    | _ -> def

  let split_tuples (prog: prog) : prog =
    { nodes = List.map split_tuples_def prog.nodes }
end

let rec norm_tuples_deq (def:def) : def =
  let def' =
    Simplify_tuples.simpl_tuples_def
      (Split_tuples.split_tuples_def
         (Simplify_tuples.simpl_tuples_def def)) in

  (* Fixpoint to make sure every tuples are complitely simplified. *)
  if def <> def' then norm_tuples_deq def'
  else def

let rec norm_tuples (prog:prog) (conf:config) : prog =
  let prog' =
    Simplify_tuples.simpl_tuples
      (Split_tuples.split_tuples
         (Simplify_tuples.simpl_tuples prog)) in

  (* Fixpoint to make sure every tuples are complitely simplified. *)
  if prog <> prog' then norm_tuples prog' conf
  else prog'
