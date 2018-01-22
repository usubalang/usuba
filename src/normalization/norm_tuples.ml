open Usuba_AST
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
                 
  let simpl_tuples_def (def: def) : def =
    match def.node with
    | Single(p_var,body) ->
       { id    = def.id;
         p_in  = def.p_in;
         p_out = def.p_out;
         opt   = def.opt;
         node  = Single(p_var,
                        List.map (function
                                   | Norec(p,e) -> Norec(p,simpl_tuple e)
                                   | Rec _ -> raise (Error "REC")) body) }
    | _ -> def
                     
  let simplify_tuples (p: prog) : prog =
    { nodes = List.map simpl_tuples_def p.nodes }
end

(* Split tuples into atomic operations, if possible *)
module Split_tuples = struct
  let real_split_tuple (p: var list) (l: expr list) : deq list =
    List.map2 (fun l r -> Norec([l],r)) p l
               
  let split_tuples_deq (body: deq list) : deq list =
    List.flatten
      (List.map
         (fun x -> match x with
                   | Norec (p,e) -> (match e with
                                     | Tuple l -> real_split_tuple p l
                                     | _ -> [ x ])
                   | Rec _ -> raise (Error "REC")) body)

  let split_tuples_def (def: def) : def =
    match def.node with
    | Single(p_var,body) ->
       { def with node  = Single(p_var, split_tuples_deq body) }
    | _ -> def
                 
  let split_tuples (p: prog) : prog =
    { nodes = List.map split_tuples_def p.nodes }
end
