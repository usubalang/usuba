
open Usuba_AST
open Utils
open Printf

let log_op_to_str = function
  | And -> "&"
  | Or  -> "|"
  | Xor -> "^"
  | Andn -> "&~"
             
let arith_op_to_str = function
  | Add -> "+"
  | Mul -> "*"
  | Sub -> "-"
  | Div -> "/"
  | Mod -> "%"

let shift_op_to_str = function
  | Lshift -> "<<"
  | Rshift -> ">>"
  | Lrotate -> "<<<"
  | Rrotate -> ">>>"

let rec arith_to_str = function
  | Const_e i -> string_of_int i
  | Var_e v   -> v.name
  | Op_e(op,x,y) -> sprintf "(%s %s %s)" (arith_to_str x) (arith_op_to_str op)
                            (arith_to_str y)
                                                 
let rec arith_to_str_types = function
  | Const_e i -> "Const_e: " ^ (string_of_int i)
  | Var_e v   -> "Var_e: " ^ v.name
  | Op_e(op,x,y) -> "Op_e(" ^ (arith_to_str_types x) ^ " " ^ (arith_op_to_str op) ^
                      " " ^ (arith_to_str_types y) ^ ")"

let rec var_to_str = function
  | Var v -> v.name
  | Field(v,e) -> sprintf "%s.%s" (var_to_str v) (arith_to_str e)
  | Index(v,e) -> sprintf "%s[%s]" v.name (arith_to_str e)
  | Range(v,ei,ef) -> sprintf "%s[%s .. %s]" v.name (arith_to_str ei) (arith_to_str ef)
  | Slice(v,l) -> sprintf "%s[%s]" v.name (join "," (List.map arith_to_str l))
                                              
let rec var_to_str_types = function
  | Var v -> "Var: " ^ v.name
  | Field(v,e) -> "Field: " ^ (var_to_str_types v) ^ "." ^ (arith_to_str_types e)
  | Index(v,e) -> "Index: " ^ v.name ^ "[" ^ (arith_to_str_types e) ^ "]"
  | Range(v,ei,ef) -> "Range: " ^ v.name ^ "[" ^ (arith_to_str_types ei) ^ " .. "
                      ^ (arith_to_str_types ef) ^ "]"
  | Slice(v,l) -> "Splice: " ^ v.name ^ "[" ^
                     (join "," (List.map arith_to_str_types l)) ^ "]"

let constr_to_str = function
  | True  -> "True"
  | False -> "False"
                                                                    
let rec expr_to_str_types = function
  | Const c -> "Const: " ^ (string_of_int c)
  | ExpVar v -> "ExpVar: " ^ (var_to_str v)
  | Tuple t -> "Tuple: (" ^ (join "," (List.map expr_to_str_types t)) ^ ")"
  | Log(Andn,x,y) -> "Andn: " ^ (expr_to_str_types (unfold_andn (Log(Andn,x,y))))
  | Log(o,x,y) -> "Log: " ^ "(" ^ (expr_to_str_types x) ^ (log_op_to_str o)
                  ^ (expr_to_str_types y) ^ ")"
  | Arith(o,x,y) -> "Arith: " ^ "(" ^ (expr_to_str_types x) ^ (arith_op_to_str o)
                    ^ (expr_to_str_types y) ^ ")"
  | Shift(o,x,y) -> "Shift: " ^ "(" ^ (expr_to_str_types x) ^ (shift_op_to_str o)
                    ^ (arith_to_str y) ^ ")"
  | Not e -> "Not: ~" ^ (expr_to_str_types e)
  | Fun(f,l) -> "Fun: " ^ f.name ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun_v(f,e,l) -> "Fun_v: " ^ f.name ^ "[" ^ (arith_to_str e) ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fby(ei,ef,id) -> "Fby: " ^ (expr_to_str_types ei) ^ " fby " ^ (expr_to_str_types ef)
  | When(e,c,x)  -> sprintf "When: %s when %s(%s)" (expr_to_str_types e) (constr_to_str c) x.name
  | Merge(ck,c)   -> sprintf "Merge: merge %s %s"
                             ck.name (join " "
                                      (List.map (fun (c,y) ->
                                                 sprintf "| %s -> %s "
                                                         (constr_to_str c)
                                                         (expr_to_str_types y)) c))

let rec expr_to_str = function
  | Const c -> (string_of_int c)
  | ExpVar v   -> var_to_str v
  | Tuple t -> sprintf "(%s)" (join "," (List.map expr_to_str t))
  | Log(o,x,y) -> sprintf "(%s %s %s)" (expr_to_str x)
                          (log_op_to_str o) (expr_to_str y)
  | Arith(o,x,y) -> sprintf "(%s %s %s)" (expr_to_str x)
                            (arith_op_to_str o) (expr_to_str y)
  | Shift(o,x,y) -> sprintf "(%s %s %s)" (expr_to_str_types x)
                            (shift_op_to_str o) (arith_to_str y)
  | Not e -> sprintf "(~ %s)" (expr_to_str e)
  | Fun(f,l) -> sprintf "%s(%s)" f.name (join "," (List.map expr_to_str l))
  | Fun_v(f,e,l) -> sprintf "%s[%s](%s)" f.name (arith_to_str e)
                            (join "," (List.map expr_to_str l))
  | Fby(ei,ef,id) -> sprintf "%s fby %s" (expr_to_str ei) (expr_to_str ef)
  | When(e,c,x)  -> sprintf "%s when %s(%s)" (expr_to_str e) (constr_to_str c) x.name
  | Merge(ck,c)   -> sprintf "merge %s %s"
                             ck.name (join " "
                                      (List.map (fun (c,y) ->
                                                 sprintf "| %s -> %s "
                                                         (constr_to_str c)
                                                         (expr_to_str y)) c))

let pat_to_str pat =
  "(" ^ (join "," (List.map var_to_str pat)) ^ ")"
let pat_to_str_types pat =
  "(" ^ (join "," (List.map var_to_str_types pat)) ^ ")"

let rec typ_to_str typ =
  match typ with
  | Bool -> "bool"
  | Int(n,m) -> sprintf "u%dx%d" n m
  | Nat -> "nat"
  | Array(typ,e) -> (typ_to_str typ) ^ "[" ^ (arith_to_str e) ^ "]"

let rec clock_to_str ck =
  match ck with
  | Defclock -> "_"
  | Base -> "base"
  | On(ck,x) -> (clock_to_str ck) ^ " on " ^ x.name
  | Onot(ck,x) -> (clock_to_str ck) ^ " onot " ^ x.name
                                                                  
let p_to_str ((id,typ),ck) =
  id.name ^ ":" ^ (typ_to_str typ) ^  "::" ^ (clock_to_str ck)

let rec deq_to_str = function
  | Norec(pat,e) -> (pat_to_str pat) ^ " = " ^ (expr_to_str e)
  | Rec(id,ei,ef,d) -> "forall " ^ id.name ^ " in [" ^
                         (arith_to_str ei) ^ "," ^ (arith_to_str ef)
                         ^ "] {\n" ^ (join "\n    " (List.map deq_to_str d)) ^ "\n  }"
                                                                                 
let rec deq_to_str_types = function
  | Norec(pat,e) -> (pat_to_str_types pat) ^ " = " ^ (expr_to_str_types e)
  | Rec(id,ei,ef,d) -> "forall " ^ id.name ^ " in [" ^
                         (arith_to_str_types ei) ^ "," ^ (arith_to_str_types ef)
                         ^ "] {\n" ^ (join "\n    " (List.map deq_to_str_types d)) ^ "\n  }"
                                                                
let single_node_to_str id p_in p_out vars deq =
  "node " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in)) ^ ")\n  returns "
  ^ (join "," (List.map p_to_str p_out)) ^ "\nvars\n"
  ^ (join ",\n" (List.map (fun x -> "  " ^ (p_to_str x)) vars)) ^ "\nlet\n"
  ^ (join ";\n" (List.map (fun x -> "  " ^ x) (List.map deq_to_str deq)))
  ^ "\ntel"

let optdef_to_str = function
  | Inline -> "_inline"
  | No_inline -> "_no_inline"
      
let def_to_str def =
  let (id,p_in,p_out) = (def.id,def.p_in,def.p_out) in
  (join " " (List.map optdef_to_str def.opt)) ^ " " ^ 
    (match def.node with
     | Single(vars,deq) ->
        single_node_to_str id p_in p_out vars deq
     | Multiple l ->
        "node " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
        ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[\n"
        ^  (join "\n;\n"
                 (List.map
                    (fun (v,d) -> "vars\n"
                                  ^ (join ",\n"
                                          (List.map
                                             (fun x -> "  " ^ (p_to_str x)) v))
                                  ^ "\nlet\n" 
                                  ^ (join ";\n"
                                          (List.map deq_to_str d))
                                  ^ "\ntel\n") l))
        ^ "\n]\n"
     | Perm l ->
        "perm " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
        ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
        ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
     | MultiplePerm l ->
        "perm[] " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
        ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[ "
        ^ (join "\n;\n"
                (List.map
                   (fun l -> "["
                             ^ (join ", " (List.map string_of_int l))
                             ^ "]") l))
        ^ "\n]\n"
     | Table l ->
        "table " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
        ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
        ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
     | MultipleTable l ->
        "table[] " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
        ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[ "
        ^ (join "\n;\n"
                (List.map
                   (fun l -> "{"
                             ^ (join ", " (List.map string_of_int l))
                             ^ "}") l))
        ^ "\n]\n")
                                                       
let prog_to_str (prog:prog) : string=
  join "\n\n" (List.map def_to_str prog.nodes)

let print_prog (prog:prog) : unit =
  print_endline (prog_to_str prog)
