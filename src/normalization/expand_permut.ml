(***************************************************************************** )
                              expand_permut.ml                                 

    This module first converts permutation tables list into permutation tables.
    Then, it converts permutation tables into regular nodes.
   
    This is actually a temporary solution, as we'd rather like the permutation
    tables to just rename registers.
    
    After this module has ran, there souldn't be any "Perm" nor "MultiplePerm" 
    left.

( *****************************************************************************)

open Usuba_AST
open Utils

let list_from_perm (perm:int list) (l:expr list) : expr list =
  let args = Array.of_list l in
  List.map (fun i -> args.(i-1)) perm
            
let rec apply_perm_e env (e:expr) : expr =
  match e with
  | Const _ | ExpVar _ -> e
  | Tuple l -> Tuple (List.map (apply_perm_e env) l)
  | Not e -> Not (apply_perm_e env e)
  | Shift(op,e,n) -> Shift(op,apply_perm_e env e,n)
  | Log(op,x,y) -> Log(op,apply_perm_e env x,apply_perm_e env y)
  | Arith(op,x,y) -> Arith(op,apply_perm_e env x,apply_perm_e env y)
  | Fun(f,l) -> let l' = List.map (apply_perm_e env) l in
                (match env_fetch env f with
                 | Some perm -> Tuple (list_from_perm perm l')
                 | None -> Fun(f,l'))
  | Fby(ei,ef,f) -> Fby(apply_perm_e env ei,apply_perm_e env ef,f)
  | When(e,c,x)  -> When(apply_perm_e env e, c, x)
  | Merge(x,l)   -> Merge(x,List.map (fun (c,e) -> c,apply_perm_e env e) l)
  | Fun_v(_,_,_) -> assert false
                        
            
let apply_perm env (deqs: deq list) : deq list =
  List.map (fun x -> match x with
                     | Norec(p,e) -> Norec(p,apply_perm_e env e)
                     | _ -> x) deqs
            
let rec rewrite_defs (l: def list) : def list =
  let env = Hashtbl.create 10 in
  List.iter (fun x -> match x.node with
                      | Perm l -> env_add env x.id l
                      | MultiplePerm l ->
                         List.iteri (fun i p -> env_add env (fresh_suffix x.id (string_of_int i)) p) l
                      | _ -> ()) l;
  List.map (fun x -> match x.node with
                     | Single(vars,body) ->
                        { x with node = Single(vars,apply_perm env body) }
                     | _ -> x) l
      
let expand_permut (p: prog) : prog =
  { nodes = List.filter (fun x -> match x.node with
                                  | Perm _ | MultiplePerm _ -> false
                                  | _ -> true) (rewrite_defs p.nodes) }
