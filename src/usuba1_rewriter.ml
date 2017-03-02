open Abstract_syntax_tree
open Utils

let expand_array (ident, p_in, p_out, nodes) =
  let rec aux i nodes =
    match nodes with
    | [] -> []
    | (vars,body)::tl -> (Single(ident^(string_of_int i),p_in,p_out,vars,body))
                         :: (aux (i+1) tl)
  in aux 1 nodes
       
let rec rewrite_defs (l: def list) : def list =
  match l with
  | [] -> []
  | hd :: tl ->
     match hd with
     | Single _ -> hd :: (rewrite_defs tl)
     | Array(id,p_in,p_out,nodes) -> (expand_array (id,p_in,p_out,nodes)) @ (rewrite_defs tl)
                       
                       
let rewrite_prog (p: prog) : prog =
  rewrite_defs p
