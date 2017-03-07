
open Abstract_syntax_tree
open Utils


let op_to_string = function
  | And -> "and"
  | Or  -> "or"
  | Xor -> "xor"
  | Not -> "not"
         
let rec expr_to_str_types = function
  | Const c -> "Const: " ^ (string_of_int c)
  | Var v   -> "Var: " ^ v
  | Access(id,n) -> "Access: " ^ id ^ " " ^ (string_of_int n)
  | Field(e,i) -> "Field: (" ^ (expr_to_str_types e) ^ ", " ^ (string_of_int i) ^ ")"
  | Tuple t -> "Tuple: (" ^ (join "," (List.map expr_to_str_types t)) ^ ")"
  | Op(o,l) -> "Op: " ^ (op_to_string o)
                             ^ "(" ^  (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun(f,l) -> "Fun: " ^ f ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun_i(f,i,l) -> "Fun_i: " ^ f ^ "[" ^ (string_of_int i) ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun_v(f,v,l) -> "Fun_v: " ^ f ^ "[" ^ v ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Mux _ -> "Mux"
  | Demux _ -> "Demux"
  | Fby(ei,ef,id) -> "Fby: " ^ (expr_to_str_types ei) ^ " fby " ^ (expr_to_str_types ef)
  | Fill_i(id,i,e) -> "Fill: " ^ "fill<" ^ id ^ ";" ^ (string_of_int i)
                                    ^ ">(" ^ (expr_to_str_types e) ^ ")"
  | Nop -> "Nop"

let rec expr_to_str = function
  | Const c -> (string_of_int c)
  | Var v   -> v
  | Access(id,n) -> id ^ "[" ^ (string_of_int n) ^ "]"
  | Field(e,i) -> (expr_to_str e) ^ "." ^ (string_of_int i)
  | Tuple t -> "(" ^ (join "," (List.map expr_to_str t)) ^ ")"
  | Op(o,l) -> (op_to_string o) ^ "(" ^  (join "," (List.map expr_to_str l)) ^ ")"
  | Fun(f,l) -> f ^ "(" ^ (join "," (List.map expr_to_str l)) ^ ")"
  | Fun_i(f,i,l) -> f ^ "[" ^ (string_of_int i) ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str l)) ^ ")"
  | Fun_v(f,v,l) -> f ^ "[" ^ v ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str l)) ^ ")"
  | Mux _ -> "Mux"
  | Demux _ -> "Demux"
  | Fby(ei,ef,id) -> (expr_to_str ei) ^ " fby " ^ (expr_to_str ef)
  | Fill_i(id,i,e) -> "fill<" ^ id ^ ";" ^ (string_of_int i)
                      ^ ">(" ^ (expr_to_str e) ^ ")"
  | Nop -> "Nop"

let rec pat_to_str pat =
  let rec left_asgn_to_str = function
    | Ident id -> id
    | Dotted (l,i) -> (left_asgn_to_str l) ^ "." ^ (string_of_int i)
    | Index(id,i) -> id ^ "[" ^ (string_of_int i) ^ "]" in
  "(" ^ (join "," (List.map left_asgn_to_str pat)) ^ ")"


       
(* let indent tab = *)
(*   String.make (tab * 4) ' ' *)

(* let join s l = *)
(*   let rec join_aux s l acc = *)
(*     match l with *)
(*     | [] -> acc *)
(*     | hd::tl -> join_aux s tl (hd ^ s ^ acc) *)
(*   in match l with *)
(*      | [] -> "" *)
(*      | hd::tl -> join_aux s tl hd *)
    
(* let string_of_undef () = "_" *)

(* let string_of_typ = function *)
(*   | Int _ -> "int64" *)
(*   | Bool  -> "bool" *)

(* let string_of_ident x = x *)

(* let string_of_clock ck = ck *)

(* let string_of_op = function *)
(*   | And -> "and" *)
(*   | Or  -> "or" *)
(*   | Xor -> "xor" *)
(*   | Not -> "not" *)
                 
(* let rec string_of_expr tab = function *)
(*   | Const(i) -> string_of_int i *)
(*   | Var(x)   -> string_of_ident x *)
(*   | Tuple(l) -> join "," (List.map (string_of_expr tab) l) *)
(*   | Op(o,l)  -> (string_of_op o) ^ "(" ^ *)
(*                       (join "," (List.map (string_of_expr tab) l)) *)
(*                       ^ ")" *)
(*   | Fun(f,l) -> (string_of_ident f) ^ "(" ^ *)
(*                       (join "," (List.map (string_of_expr tab) l)) *)
(*                       ^ ")" *)
(*   | Mux(e,c,x) -> (string_of_expr tab e) ^ " when " ^ (string_of_ident c) *)
(*                       ^ "(" ^ (string_of_ident x) ^ ")" *)
(*   | Demux(x,l) -> "merge " ^ (string_of_ident x) ^ "\n" ^ *)
(*                         (join "\n" (List.map (fun (cstr, e) -> *)
(*                                               (indent (tab+1)) ^ "| " ^ *)
(*                                                 (string_of_ident cstr) ^ " -> " ^ *)
(*                                                   (string_of_expr (tab+1) e)) l)) *)
(*   | _ -> raise (Failure "print_ast is only partial") *)
                                                                   
(* let string_of_pat l = join ", " (List.map string_of_ident l) *)

(* let string_of_deq tab l = *)
(*   join ";\n" (List.map (fun (p,e) -> (indent tab) ^ *)
(*                                        (string_of_pat p) ^ "=" ^ (string_of_expr tab e)) l) *)
                                        
(* let string_of_p l = *)
(*   join ", " (List.map (fun (i,t,ck) -> (string_of_ident i) *)
(*                                       ^ ":" ^ (string_of_typ t) ^ "::" *)
(*                                       ^ (string_of_clock ck)) l) *)

(* let string_of_def (i,p_in,p_out,vars,body) = *)
(*   "node " ^ (string_of_ident i) ^ "(" ^ *)
(*     (string_of_p p_in) ^ ")\n" ^ (indent 1) ^ *)
(*       "returns " ^ (string_of_p p_out) ^ "\n" *)
(*       ^ "let\n" ^ (string_of_deq 1 body) ^ "\ntel\n" *)

(* let string_of_prog p = *)
(*   join "" (List.map string_of_def p) *)
