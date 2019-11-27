(***************************************************************************** )
                              expand_permut.ml

    This module first converts permutation tables list into permutation tables.
    Then, it converts permutation tables into regular nodes.

    This is actually a temporary solution, as we'd rather like the permutation
    tables to just rename registers.

    After this module has ran, there souldn't be any "MultiplePerm" left.

( *****************************************************************************)

open Usuba_AST
open Basic_utils
open Utils

let list_from_perm env_var (perm:int list) (l:expr list) : expr list =
  let args = Array.of_list (flat_map (Unfold_unnest.expand_expr env_var) l) in
  List.map (fun i -> args.(i-1)) perm

let rec apply_perm_e env_fun env_var (e:expr) : expr =
  match e with
  | Const _ | ExpVar _ | Shuffle _ -> e
  | Tuple l -> Tuple (List.map (apply_perm_e env_fun env_var) l)
  | Not e -> Not (apply_perm_e env_fun env_var e)
  | Shift(op,e,n) -> Shift(op,apply_perm_e env_fun env_var e,n)
  | Log(op,x,y) -> Log(op,apply_perm_e env_fun env_var x,apply_perm_e env_fun env_var y)
  | Arith(op,x,y) -> Arith(op,apply_perm_e env_fun env_var x,apply_perm_e env_fun env_var y)
  | Fun(f,l) -> let l' = List.map (apply_perm_e env_fun env_var) l in
                (match env_fetch env_fun f with
                 | Some perm -> Tuple (list_from_perm env_var perm l')
                 | None -> Fun(f,l'))
  | Fby(ei,ef,f) -> Fby(apply_perm_e env_fun env_var ei,apply_perm_e env_fun env_var ef,f)
  | When(e,c,x)  -> When(apply_perm_e env_fun env_var e, c, x)
  | Merge(x,l)   -> Merge(x,List.map (fun (c,e) -> c,apply_perm_e env_fun env_var e) l)
  | Fun_v(_,_,_) -> assert false


let apply_perm env_fun env_var (deqs: deq list) : deq list =
  List.map (fun d -> match d.content with
                     | Eqn(p,e,sync) ->
                        { d with content=Eqn(p,apply_perm_e env_fun env_var e,sync) }
                     | _ -> d) deqs

let rec rewrite_defs (l: def list) : def list =
  let env_fun = Hashtbl.create 10 in
  List.iter (fun x -> match x.node with
                      | Perm l -> env_add env_fun x.id l
                      | _ -> ()) l;
  List.map (fun x -> match x.node with
                     | Single(vars,body) ->
                        let env_var = build_env_var x.p_in x.p_out vars in
                        { x with node = Single(vars,apply_perm env_fun env_var body) }
                     | _ -> x) l


let expand_permut (p: prog) (conf:config) : prog =
  { nodes = List.filter (fun x -> match x.node with
                                  | Perm _ -> false
                                  | _ -> true) (rewrite_defs p.nodes) }
