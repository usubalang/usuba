
open Abstract_syntax_tree
open Lexing

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
    
let string_of_undef () = "_"

let string_of_typ = function
  | AST_int -> "int"
  | AST_bool -> "bool"

let string_of_ident x = x

let string_of_clock ck = ck

let string_of_op = function
  | AST_and -> "and"
  | AST_or  -> "or"
  | AST_xor -> "xor"
  | AST_not -> "not"
                 
let rec string_of_expr tab = function
  | AST_const(i) -> string_of_int i
  | AST_var(x)   -> string_of_ident x
  | AST_tuple(l) -> join "," (List.map (string_of_expr tab) l)
  | AST_op(o,l)  -> (string_of_op o) ^ "(" ^
                      (join "," (List.map (string_of_expr tab) l))
                      ^ ")"
  | AST_fun(f,l) -> (string_of_ident f) ^ "(" ^
                      (join "," (List.map (string_of_expr tab) l))
                      ^ ")"
  | AST_mux(e,c,x) -> (string_of_expr tab e) ^ " when " ^ (string_of_ident c)
                      ^ "(" ^ (string_of_ident x) ^ ")"
  | AST_demux(x,l) -> "merge " ^ (string_of_ident x) ^ "\n" ^
                        (join "\n" (List.map (fun (cstr, e) ->
                                              (indent (tab+1)) ^ "| " ^
                                                (string_of_ident cstr) ^ " -> " ^
                                                  (string_of_expr (tab+1) e)) l))
                                                                   
let string_of_pat l = join ", " (List.map string_of_ident l)

let string_of_deq tab l =
  join ";\n" (List.map (fun (p,e) -> (indent tab) ^
                                       (string_of_pat p) ^ "=" ^ (string_of_expr tab e)) l)
       
                                 
let string_of_p l =
  join ", " (List.map (fun (i,t,ck) -> (string_of_ident i)
                                      ^ ":" ^ (string_of_typ t) ^ "::"
                                      ^ (string_of_clock ck)) l)

let string_of_def (i,p_in,p_out,body) =
  "node " ^ (string_of_ident i) ^ "(" ^
    (string_of_p p_in) ^ ")\n" ^ (indent 1) ^
      "returns " ^ (string_of_p p_out) ^ "\n"
      ^ "let\n" ^ (string_of_deq 1 body) ^ "\ntel\n"

let string_of_prog p =
  join "" (List.map string_of_def p)
