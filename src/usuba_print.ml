
open Usuba_AST
open Utils

let log_op_to_string = function
  | And -> "&"
  | Or  -> "|"
  | Xor -> "^"
             
let arith_op_to_string = function
  | Add -> "+"
  | Mul  -> "*"
  | Sub -> "-"
  | Div -> "/"
         
let rec expr_to_str_types = function
  | Const c -> "Const: " ^ (string_of_int c)
  | Var v   -> "Var: " ^ v
  | Access(id,n) -> "Access: " ^ id ^ " " ^ (string_of_int n)
  | Field(e,i) -> "Field: (" ^ (expr_to_str_types e) ^ ", " ^ (string_of_int i) ^ ")"
  | Tuple t -> "Tuple: (" ^ (join "," (List.map expr_to_str_types t)) ^ ")"
  | Log(o,x,y) -> "Log: " ^ "(" ^ (expr_to_str_types x) ^ (log_op_to_string o)
                  ^ (expr_to_str_types y) ^ ")"
  | Arith(o,x,y) -> "Arith: " ^ "(" ^ (expr_to_str_types x) ^ (arith_op_to_string o)
                    ^ (expr_to_str_types y) ^ ")"
  | Not e -> "Not: !" ^ (expr_to_str_types e)
  | Fun(f,l) -> "Fun: " ^ f ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun_i(f,i,l) -> "Fun_i: " ^ f ^ "[" ^ (string_of_int i) ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun_v(f,v,l) -> "Fun_v: " ^ f ^ "[" ^ v ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fby(ei,ef,id) -> "Fby: " ^ (expr_to_str_types ei) ^ " fby " ^ (expr_to_str_types ef)
  | Fill_i(id,i,e) -> "Fill_i: " ^ "fill_i<" ^ id ^ ";" ^ (string_of_int i)
                      ^ ">(" ^ (expr_to_str_types e) ^ ")"
  | Fill(id,i,e) -> "Fill: " ^ "fill<" ^ id ^ ";" ^ (string_of_int i)
                    ^ ">(" ^ (expr_to_str_types e) ^ ")"
  | Nop -> "Nop"

let rec expr_to_str = function
  | Const c -> (string_of_int c)
  | Var v   -> v
  | Access(id,n) -> id ^ "[" ^ (string_of_int n) ^ "]"
  | Field(e,i) -> (expr_to_str e) ^ "." ^ (string_of_int i)
  | Tuple t -> "(" ^ (join "," (List.map expr_to_str t)) ^ ")"
  | Log(o,x,y) -> "(" ^ (expr_to_str x) ^ (log_op_to_string o)
                  ^ (expr_to_str y) ^ ")"
  | Arith(o,x,y) -> "(" ^ (expr_to_str x) ^ (arith_op_to_string o)
                  ^ (expr_to_str y) ^ ")"
  | Not e -> "!(" ^ (expr_to_str e) ^ ")"
  | Fun(f,l) -> f ^ "(" ^ (join "," (List.map expr_to_str l)) ^ ")"
  | Fun_i(f,i,l) -> f ^ "[" ^ (string_of_int i) ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str l)) ^ ")"
  | Fun_v(f,v,l) -> f ^ "[" ^ v ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str l)) ^ ")"
  | Fby(ei,ef,id) -> (expr_to_str ei) ^ " fby " ^ (expr_to_str ef)
  | Fill_i(id,i,e) -> "fill_i<" ^ id ^ ";" ^ (string_of_int i)
                      ^ ">(" ^ (expr_to_str e) ^ ")"
  | Fill(id,i,e) -> "fill<" ^ id ^ ";" ^ (string_of_int i)
                    ^ ">(" ^ (expr_to_str e) ^ ")"
  | Nop -> "Nop"

let rec pat_to_str pat =
  let rec left_asgn_to_str = function
    | Ident id -> id
    | Dotted (l,i) -> (left_asgn_to_str l) ^ "." ^ (string_of_int i)
    | Index(id,i) -> id ^ "[" ^ (string_of_int i) ^ "]" in
  "(" ^ (join "," (List.map left_asgn_to_str pat)) ^ ")"

let rec typ_to_str typ =
  match typ with
  | Bool -> "bool"
  | Int n -> "uint_"^(string_of_int n)
  | Array(typ,n) -> (typ_to_str typ) ^ "[" ^ (string_of_int n) ^ "]"
            
let p_to_str (id,typ,ck) =
  id ^ ":" ^ (typ_to_str typ) ^  "::" ^ ck

let single_node_to_str id p_in p_out vars deq =
  "node " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in)) ^ ")\n  returns "
  ^ (join "," (List.map p_to_str p_out)) ^ "\nvars\n"
  ^ (join ",\n" (List.map (fun x -> "  " ^ (p_to_str x)) vars)) ^ "\nlet\n"
  ^ (join ";\n" (List.map (fun (l,r) -> "  " ^ (pat_to_str l) ^ " = "
                                        ^ (expr_to_str r)) deq))
  ^ "\ntel"
      
let def_to_str def =
  match def with
  | Single(id,p_in,p_out,vars,deq) ->
     single_node_to_str id p_in p_out vars deq
  | Temporary(id,p_in,p_out,vars,deq) ->
     single_node_to_str ("<i> "^id) p_in p_out vars deq
  | Multiple(id,p_in,p_out,l) ->
     "node " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[\n"
     ^  (join "\n;\n"
              (List.map
                 (fun (v,d) -> "vars\n"
                               ^ (join ",\n"
                                       (List.map
                                          (fun x -> "  " ^ (p_to_str x)) v))
                               ^ "\nlet\n" 
                               ^ (join ";\n"
                                       (List.map
                                          (fun (l,r) ->
                                           "  " ^ (pat_to_str l) ^ " = "
                                           ^ (expr_to_str r)) d))
                               ^ "\ntel\n") l))
     ^ "\n]\n"
  | Perm(id,p_in,p_out,l) ->
     "perm " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
     ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
  | MultiplePerm(id,p_in,p_out,l) ->
     "perm[] " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[ "
     ^ (join "\n;\n"
             (List.map
                (fun l -> "["
                          ^ (join ", " (List.map string_of_int l))
                          ^ "]") l))
     ^ "\n]\n"
  | Table(id,p_in,p_out,l) ->
     "table " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
     ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
  | MultipleTable(id,p_in,p_out,l) ->
     "table[] " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[ "
     ^ (join "\n;\n"
             (List.map
                (fun l -> "{"
                          ^ (join ", " (List.map string_of_int l))
                          ^ "}") l))
     ^ "\n]\n"
                                                       
let prog_to_str prog =
  join "\n\n" (List.map def_to_str prog)

let print_prog prog =
  print_endline (prog_to_str prog)
