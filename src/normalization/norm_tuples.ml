open Usuba_AST
open Basic_utils
open Utils

(* Removes tuples of 1 element *)
module Simplify_tuples = struct

  let rec simpl_tuple (t:expr) : expr =
    match t with
    | Tuple l -> if List.length l = 1 then List.nth l 0
                 else (match List.map simpl_tuple l with
                       | x::[] -> x
                       | l -> Tuple(l))
    | Not e -> Not (simpl_tuple e)
    | Shift(op,e,n) -> Shift(op,simpl_tuple e,n)
    | Log(op,x,y) -> Log(op,simpl_tuple x,simpl_tuple y)
    | Arith(op,x,y) -> Arith(op,simpl_tuple x,simpl_tuple y)
    | Fun(f,l) -> Fun(f,List.map simpl_tuple l)
    | Fun_v(f,n,l) -> Fun_v(f,n,List.map simpl_tuple l)
    | _ -> t

  let rec simpl_deqs (deq:deq list) : deq list =
    List.map (function
               | Norec(p,e) -> Norec(p,simpl_tuple e)
               | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,simpl_deqs dl,opts)) deq
             
  let simpl_tuples_def (def: def) : def =
    match def.node with
    | Single(p_var,body) ->
       { id    = def.id;
         p_in  = def.p_in;
         p_out = def.p_out;
         opt   = def.opt;
         node  = Single(p_var, simpl_deqs body) }
    | _ -> def
                     
  let simplify_tuples (p: prog) : prog =
    { nodes = List.map simpl_tuples_def p.nodes }
end

(* Split tuples into atomic operations, if possible *)
module Split_tuples = struct
  let real_split_tuple env (p: var list) (l: expr list) : deq list =
    List.map2 (fun l r -> Norec([l],r)) (flat_map (expand_var env) p)
              (flat_map (Unfold_unnest.expand_expr env) l)
               
  let rec split_tuples_deq env (body: deq list) : deq list =
    flat_map
      (fun x -> match x with
                | Norec (p,e) -> (match e with
                                  | Tuple l -> real_split_tuple env p l
                                  | _ -> [ x ])
                | Rec(i,ei,ef,dl,opts) -> [ Rec(i,ei,ef,split_tuples_deq env dl,opts) ]) body

  let split_tuples_def (def: def) : def =
    match def.node with
    | Single(p_var,body) ->
       let env = build_env_var def.p_in def.p_out p_var in
       { def with node  = Single(p_var, split_tuples_deq env body) }
    | _ -> def
                 
  let split_tuples (p: prog) : prog =
    { nodes = List.map split_tuples_def p.nodes }
end


(* Flatten tuples == removes nested tuples
    ((a,b),c) ==> (a,b,c) *)
module Flatten_tuples = struct

  let rec flatten_tuples_expr (e:expr) : expr =
    let rec rec_call_list (l:expr list) : expr list =
      flat_map (fun x -> match flatten_tuples_expr x with
                         | Tuple l' -> l'
                         | x -> [ x ]) l in
    match e with
    | Const _ | ExpVar _ | Shuffle _ -> e
    | Tuple l -> Tuple (rec_call_list l)
    | Not e' -> Not (flatten_tuples_expr e')
    | Shift(op,e',ae) -> Shift(op,flatten_tuples_expr e',ae)
    | Log(op,x,y) -> Log(op,flatten_tuples_expr x,flatten_tuples_expr y)
    | Arith(op,x,y) -> Arith(op,flatten_tuples_expr x,flatten_tuples_expr y)
    | Fun(f,l) -> Fun(f,rec_call_list l)
    | Fun_v(f,ae,l) -> Fun_v(f,ae,rec_call_list l)
    | _ -> assert false
  
  let rec flatten_tuples_deq (body:deq list) : deq list =
    List.map (function
               | Norec(p,e) -> Norec(p,flatten_tuples_expr e)
               | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,flatten_tuples_deq dl,opts)) body
  
  let flatten_tuples_def (def:def) : def =
    match def.node with
    | Single(p_var,body) ->
       { def with node = Single(p_var,flatten_tuples_deq body) }
    | _ -> def
  
  let flatten_tuples (p:prog) : prog =
    { nodes = List.map flatten_tuples_def p.nodes }
end

let norm_tuples (prog:prog) (conf:config) : prog =
  (* Dunno if I should loop for a fixpoint or not... 
     For now, this should be sufficient. *)
  prog |>
    Simplify_tuples.simplify_tuples |>
    Split_tuples.split_tuples |>
    Flatten_tuples.flatten_tuples |>
    Simplify_tuples.simplify_tuples |>
    Split_tuples.split_tuples
  
