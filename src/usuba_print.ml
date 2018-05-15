
open Usuba_AST
open Basic_utils
open Printf

let lift f = fun l -> join "," (List.map f l)
                           
let unfold_andn e =
  match e with
  | Log(Andn,x,y) -> Log(And,Not x,y)
  | _ -> e         

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
  | Index(v,e) -> sprintf "%s[%s]" (var_to_str v) (arith_to_str e)
  | Range(v,ei,ef) -> sprintf "%s[%s .. %s]" (var_to_str v) (arith_to_str ei) (arith_to_str ef)
  | Slice(v,l) -> sprintf "%s[%s]" (var_to_str v) (join "," (List.map arith_to_str l))
let var_to_str_l = lift var_to_str
                                              
let rec var_to_str_types = function
  | Var v -> sprintf "Var: %s" v.name
  | Index(v,e) -> sprintf "Index: %s[%s]" (var_to_str_types v) (arith_to_str_types e)
  | Range(v,ei,ef) -> sprintf "Range: %s[%s..%s] " (var_to_str_types v) (arith_to_str_types ei)
                              (arith_to_str_types ef)
  | Slice(v,l) -> sprintf "Splice: %s[%s]" (var_to_str_types v)
                          (join "," (List.map arith_to_str_types l))

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
  | Shuffle(v,l) -> sprintf "Shuffle: Shuffle(%s,[%s])" (var_to_str v)
                            (join "," (List.map string_of_int l))
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
  | Shuffle(v,l) -> sprintf "Shuffle(%s,[%s])" (var_to_str v)
                            (join "," (List.map string_of_int l))
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
let expr_to_str_l = lift expr_to_str

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
let p_to_str_l = lift p_to_str

let optstmt_to_str = function
  | Unroll    -> "_unroll"
  | No_unroll -> "_no_unroll"
                   
let rec deq_to_str = function
  | Norec(pat,e) -> sprintf "%s = %s" (pat_to_str pat) (expr_to_str e)
  | Rec(id,ei,ef,d,opts) ->
     sprintf "%s forall %s in [%s,%s] {\n    %s\n  }"
             (join " " (List.map optstmt_to_str opts))
             id.name  (arith_to_str ei) (arith_to_str ef)
             (join "\n    " (List.map deq_to_str d))
let deq_to_str_l = lift deq_to_str
                                                                                 
let rec deq_to_str_types = function
  | Norec(pat,e) -> sprintf "%s = %s" (pat_to_str_types pat) (expr_to_str_types e)
  | Rec(id,ei,ef,d,opts) ->
     sprintf "%s forall %s in [%s,%s] {\n    %s\n  }"
             (join " " (List.map optstmt_to_str opts))
             id.name  (arith_to_str_types ei) (arith_to_str_types ef)
             (join "\n    " (List.map deq_to_str_types d))
     
                                                                
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
     | Perm l ->
        "perm " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
        ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
        ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
     | Table l ->
        "table " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
        ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
        ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
                                                     
     | Multiple l ->
        match List.nth l 0 with
        | Single _ ->
           "node " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
           ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[\n"
           ^  (join "\n;\n"
                    (List.map
                       (fun x -> match x with
                                 | Single (v,d) -> "vars\n"
                                                   ^ (join ",\n"
                                                           (List.map
                                                              (fun x -> "  " ^ (p_to_str x)) v))
                                                   ^ "\nlet\n" 
                                                   ^ (join ";\n"
                                                           (List.map deq_to_str d))
                                                   ^ "\ntel\n"
                                 | _ -> assert false) l))
           ^ "\n]\n"
        | Perm _   ->
           "perm[] " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
           ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[ "
           ^ (join "\n;\n"
                   (List.map
                      (fun x -> match x with
                                | Perm l -> "["
                                            ^ (join ", " (List.map string_of_int l))
                                            ^ "]"
                                | _ -> assert false) l))
           ^ "\n]\n"
        | Table _  ->
           "table[] " ^ id.name ^ "(" ^ (join "," (List.map p_to_str p_in))
           ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[ "
           ^ (join "\n;\n"
                   (List.map
                      (fun x -> match x with
                                | Table l -> "{"
                                             ^ (join ", " (List.map string_of_int l))
                                             ^ "}"
                                | _ -> assert false) l))
           ^ "\n]\n"
        | _ -> assert false)
let def_to_str_l = lift def_to_str
                                                       
let prog_to_str (prog:prog) : string=
  join "\n\n" (List.map def_to_str prog.nodes)

let print_prog (prog:prog) : unit =
  print_endline (prog_to_str prog)
