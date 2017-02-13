
open Abstract_syntax_tree
open Lexing


let string_of_undef () = "_"

let string_of_typ () = "int"

let string_of_ident = function
  | AST_ident (x) -> x

let string_of_op = function
  | AST_and -> "and"
  | AST_or  -> "or"
  | AST_xor -> "xor"
  | AST_not -> "not"
                 
let rec string_of_e = function
  | AST_const(i) -> string_of_int i
  | AST_var(x)   -> string_of_ident x
  | AST_tuple(l) -> List.fold_left (fun x y -> x ^ "," ^ y) "" (List.map string_of_e l)
  | AST_op(o,l)  -> (string_of_op o) ^ "(" ^
                      (List.fold_left (fun x y -> x ^ "," ^ y) "" (List.map string_of_e l))
                      ^ ")"
  | AST_fun(f,l) -> (string_of_ident f) ^ "(" ^
                      (List.fold_left (fun x y -> x ^ "," ^ y) "" (List.map string_of_e l))
                      ^ ")"
  | AST_mux(e,c,x) -> (string_of_e e) ^ " when " ^ (string_of_ident c)
                      ^ "(" ^ (string_of_ident x) ^ ")"
  | AST_demux(x,l) -> "demux(...)"

let string_of_pat = function
  | AST_pat(l) -> List.fold_left (fun x y -> x ^ "," ^ y) "" (List.map string_of_ident l)

let string_of_deq = function
  | AST_deq(l) -> List.fold_left (fun x y -> x ^ ";" ^ y) ""
                                 (List.map (fun (p,e) ->
                                      (string_of_pat p) ^ "=" ^ (string_of_e e)) l)

let string_of_p = function
  | AST_p(l) -> List.fold_left (fun x y -> x ^ "," ^ y) ""
                                   (List.map (fun (i,_,_) -> (string_of_ident i) ^ ":_::_") l)

let string_of_def = function
  | AST_def(i,p_in,p_out,body) -> "node " ^ (string_of_ident i) ^ "(" ^
                                    (string_of_p p_in) ^ ") returns " ^ (string_of_p p_out) ^ "\n"
                                    ^ "let\n" ^ (string_of_deq body) ^ "\ntel\n"

let string_of_prog p =
  List.fold_left (^) "" (List.map string_of_def p)
