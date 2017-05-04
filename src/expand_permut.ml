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
      
let rewrite_perm (id,p_in,p_out,opt,body) : def =
  let p_in' = rewrite_p p_in in
  let (id_in,_,_) = List.nth p_in 0 in
  let p_out' = rewrite_p p_out in
  let (id_out,_,_) = List.nth p_out 0 in
  let body' = List.mapi (fun i x -> Norec([Field(Var id_out,Const_e (i+1))],
                                          ExpVar(Field(Var id_in, Const_e x)))) body in
  { id=id; p_in=p_in'; p_out=p_out'; opt=opt;
    node = Single([],body') }

let expand_array_perm (ident, p_in, p_out, opt, perms) =
  List.mapi (fun i x -> (ident^(string_of_int i),p_in,p_out,opt,x)) perms
            
let rec rewrite_defs (l: def list) : def list =
  List.flatten @@
    List.map
      (fun x ->
       let id    = x.id in
       let p_in  = x.p_in in
       let p_out = x.p_out in
       let opt   = x.opt in       
       match x.node with
       | Perm l -> [ rewrite_perm (id,p_in,p_out,opt,l) ]
       | MultiplePerm perms ->
          (List.map rewrite_perm (expand_array_perm (id,p_in,p_out,opt,perms)))
       | _ -> [ x ])
      l
      
      
let expand_permut (p: prog) : prog =
  { nodes = rewrite_defs p.nodes }
