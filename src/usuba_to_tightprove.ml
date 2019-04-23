open Usuba_AST
open Basic_utils
open Printf

let ident_to_str id = 
  Str.global_replace (Str.regexp "'") "_" id.name

let arith_op_to_str = function
  | Add -> "+"
  | Mul -> "*"
  | Sub -> "-"
  | Div -> "/"
  | Mod -> "%"

let rec arith_to_str = function
  | Const_e i -> string_of_int i
  | Var_e v   -> v.name
  | Op_e(op,x,y) -> sprintf "(%s %s %s)" (arith_to_str x) (arith_op_to_str op)
                            (arith_to_str y)
                            
let log_op_to_str = function
  | And -> "and"
  | Or  -> "or"
  | Xor -> "xor"
  | Andn -> assert false
                            
let rec var_to_str = function
  | Var v -> ident_to_str v
  | Index(v,e) -> sprintf "%s[%s]" (var_to_str v) (arith_to_str e)
  | Range(v,ei,ef) -> sprintf "%s[%s .. %s]" (var_to_str v) (arith_to_str ei) (arith_to_str ef)
  | Slice(v,l) -> sprintf "%s[%s]" (var_to_str v) (join "," (List.map arith_to_str l))
                              
let rec expr_to_str = function
  | ExpVar v   -> var_to_str v
  | Log(o,x,y) -> sprintf "%s %s %s" 
                          (log_op_to_str o) (expr_to_str x) (expr_to_str y)
  | Not e -> sprintf "not %s" (expr_to_str e)
  | Fun(f,l) -> sprintf "%s(%s)" f.name (join "," (List.map expr_to_str l))
  | _ -> assert false

let pat_to_str pat =
  match pat with
  | [] -> assert false
  | x :: [] -> var_to_str x
  | l -> "(" ^ (join "," (List.map var_to_str pat)) ^ ")"
    
let rec deq_to_str = function
  | Eqn(pat,e,_) -> sprintf "%s = %s\n"
                            (pat_to_str pat)
                            (expr_to_str e)
  | _ -> assert false
                                                                
let single_node_to_str (id:ident) (p_in:p) (p_out:p) (vars:p) (deq:deq list) =
  (join "" (List.map (fun vd -> sprintf "in %s\n" (ident_to_str vd.vid)) p_in)) ^
    (join "" (List.map deq_to_str deq))
      
let def_to_str (def:def) =
  match def.node with
  | Single(vars,deq) ->
     single_node_to_str def.id def.p_in def.p_out vars deq
  | _ -> assert false
                                                       
let prog_to_str (prog:prog) : string=
  join "\n\n" (List.map def_to_str prog.nodes)

let print_prog (prog:prog) : unit =
  Printf.printf "%s" (prog_to_str prog)
