open Usuba_AST
open Utils

let rec rewrite_p p =
  match p with
  | [] -> []
  | (id,typ,ck)::tl ->
     (match typ with
      | Bool -> [ (id,Bool,ck) ]
      | Int n -> [ (id, Int n, ck) ]
      | Array (typ_in, size) -> List.map (fun x -> (x,typ_in,ck)) (gen_list id size)
     ) @ (rewrite_p tl)
                                                   
let rewrite_perm (id,p_in,p_out,body) : def =
  let p_in' = rewrite_p p_in in
  let (id_in,_,_) = List.nth p_in 0 in
  let p_out' = rewrite_p p_out in
  let (id_out,_,_) = List.nth p_out 0 in
  let cpt = ref 1 in
  let body' = List.map (fun x -> let tmp = ([Dotted(Ident id_out,!cpt)],
                                            Field(Var id_in, x)) in
                                 incr cpt;
                                 tmp) body in
  Single(id,p_in',p_out',[],body')

let expand_array (ident, p_in, p_out, nodes) =
  let rec aux i nodes =
    match nodes with
    | [] -> []
    | (vars,body)::tl -> (Single(ident^(string_of_int i),p_in,p_out,vars,body))
                         :: (aux (i+1) tl)
  in aux 1 nodes

let expand_array_perm (ident, p_in, p_out, perms) =
  let rec aux i perms =
    match perms with
    | [] -> []
    | perm::tl -> (ident^(string_of_int i),p_in,p_out,perm)
                  :: (aux (i+1) tl)
  in aux 1 perms
       
let rec rewrite_defs (l: def list) : def list =
  match l with
  | [] -> []
  | hd :: tl ->
     match hd with
     | Perm (id,p_in,p_out,body) ->
        let head = rewrite_perm (id,p_in,p_out,body) in
        head :: (rewrite_defs tl)
     | MultiplePerm(id,p_in,p_out,perms) ->
        (List.map rewrite_perm (expand_array_perm (id,p_in,p_out,perms)))
        @ (rewrite_defs tl)
     | _ -> hd :: (rewrite_defs tl)
                    
                    
let expand_permut (p: prog) : prog =
  rewrite_defs p
