
open Abstract_syntax_tree

exception Not_implemented of string
exception Invalid_ast
            
let indent tab =
  String.make (tab * 4) ' '
              
let join s l =
  let rec join_aux s l acc =
    match l with
    | [] -> acc
    | hd::tl -> join_aux s tl (hd ^ s ^ acc)
  in match l with
     | [] -> ""
     | hd::tl -> join_aux s tl hd

let ident_to_ml id = id
                       
let const_to_ml c = string_of_int c

let constructor_to_ml = function
  | "True"  -> "1"
  | "False" -> "0"
  | _ -> raise (Not_implemented "only constructor True and False are allowed for now.")
                                  
let rec expr_to_ml tab e =
  match e with
  | AST_const c -> const_to_ml c
  | AST_var v   -> ident_to_ml v
  | AST_tuple t -> "(" ^ (join "," (List.map (expr_to_ml tab) t)) ^ ")"
  | AST_op (op,a::b::[]) -> "(" ^ (expr_to_ml tab a) ^  ")" ^
                                ( match op with
                                  | AST_and -> " land "
                                  | AST_or  -> " lor "
                                  | AST_xor -> " lxor "
                                  | _ -> raise Invalid_ast )
                                ^ "(" ^ (expr_to_ml tab b) ^ ")"
  | AST_op (AST_not,x::[]) -> "lnot (" ^ (expr_to_ml tab x) ^ ")"
  | AST_fun (f, l) -> (ident_to_ml f) ^
                        (join " "
                              (List.map (fun x -> "(" ^ x ^ ")")
                                        (List.map (expr_to_ml tab) l)))
  | AST_mux (e,_,_) -> expr_to_ml tab e
  | AST_demux (id,l) -> "match " ^ (ident_to_ml id) ^ " with\n" ^
                          (join "\n"
                                (List.map (fun (c,e) ->
                                           (indent tab) ^ "  | " ^
                                             (constructor_to_ml c) ^ " -> " ^
                                               (expr_to_ml (tab+1) e)) l))
  | _ -> raise Invalid_ast
                       
let pat_to_ml tab pat =
  match pat with
  | e::[] -> ident_to_ml e
  | l -> "(" ^ (join "," (List.map ident_to_ml l)) ^ ")"

let deq_to_ml tab l =
  join "\n" (List.map (fun (p,e) -> (indent tab) ^ "let "
                                  ^ (pat_to_ml tab p) ^ " = "
                                  ^ (expr_to_ml tab e) ^ " in ") l)
                       
(* print a node *)
let def_to_ml tab (id, p_in, p_out, body) =
  "let " ^ (ident_to_ml id) ^ " "
  ^ (join " " (List.map (fun (id, _, _) -> (ident_to_ml id)) p_in)) ^ " = \n"
  ^ (deq_to_ml (tab+1) body) ^ "\n" ^ (indent (tab+1)) ^ "("
  ^ (join "," (List.map (fun (id,_,_) -> (ident_to_ml id)) p_out)) ^ ")\n"
                                                                      
let prog_to_ml p =
  join "\n\n" (List.map (def_to_ml 0) p)
       
