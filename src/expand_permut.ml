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

let rec rewrite_p p =
  List.flatten @@
    List.map
      (fun (id,typ,ck) ->
       match typ with
       | Bool -> [ (id,Bool,ck) ]
       | Int n -> [ (id, Int n, ck) ]
       | Nat -> [ (id, Nat, ck) ]
       | Array (typ_in, Const_e size) ->
          List.map (fun x -> (x,typ_in,ck)) (gen_list_0 id size)
       | _ -> raise (Error "bad index")) p
      
let rewrite_perm (id,p_in,p_out,body) : def =
  let p_in' = rewrite_p p_in in
  let (id_in,_,_) = List.nth p_in 0 in
  let p_out' = rewrite_p p_out in
  let (id_out,_,_) = List.nth p_out 0 in
  let cpt = ref 1 in
  let body' = List.map (fun x -> let tmp = (Norec([Field(Var id_out,Const_e !cpt)],
                                                  ExpVar(Field(Var id_in, Const_e x)))) in
                                 incr cpt;
                                 tmp) body in
  Single(id,p_in',p_out',[],body')

let expand_array (ident, p_in, p_out, nodes) =
  List.mapi
    (fun i (vars,body) ->
     Single(ident^(string_of_int i),p_in,p_out,vars,body))
    nodes

let expand_array_perm (ident, p_in, p_out, perms) =
  List.mapi (fun i x -> (ident^(string_of_int i),p_in,p_out,x)) perms
            
let rec rewrite_defs (l: def list) : def list =
  List.flatten @@
    List.map
      (fun x ->
       match x with
       | Perm (id,p_in,p_out,body) -> [ rewrite_perm (id,p_in,p_out,body) ]
       | MultiplePerm(id,p_in,p_out,perms) ->
          (List.map rewrite_perm (expand_array_perm (id,p_in,p_out,perms)))
       | _ -> [ x ])
      l
      
      
let expand_permut (p: prog) : prog =
  rewrite_defs p
