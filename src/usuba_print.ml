
open Usuba_AST
open Utils
open Printf

let log_op_to_str = function
  | And -> "&"
  | Or  -> "|"
  | Xor -> "^"
  | _ -> unreached ()
             
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
                 
let intr_op_to_str = function
    And64 -> "&"
  | Or64  -> "|"
  | Xor64 -> "^"
  | Add64 -> "+"
  | Sub64 -> "-"
  | Mul64 -> "*"
  | Div64 -> "/"
  | Mod64 -> "%"
  | Not64 -> "~"
  (* MMX *)
  | Pand64 -> "pand64"
  | Por64 -> "por64"
  | Pxor64 -> "pxor64"
  | Pandn64 -> "pandn64"
  | Paddb64 -> "paddb64"
  | Paddw64 -> "paddw64"
  | Paddd64 -> "paddd64"
  | Psubb64 -> "psubb64"
  | Psubw64 -> "psubw64"
  | Psubd64 -> "psubd64"
  (* SSE *)
  | Pand128 -> "pand128"
  | Por128 -> "por128"
  | Pxor128 -> "pxor128"
  | Pandn128 -> "pandn128"
  | Paddb128 -> "paddb128"
  | Paddw128 -> "paddw128"
  | Paddd128 -> "paddd128"
  | Paddq128 -> "paddq128"
  | Psubb128 -> "psubb128"
  | Psubw128 -> "psubw128"
  | Psubd128 -> "psubd128"
  | Psubq128 -> "psubq128"
  (* AVX *)          
  | VPand256 -> "vpand256"
  | VPor256 -> "vpor256"
  | VPxor256 -> "vpxor256"
  | VPandn256 -> "vpandn256"
  | VPaddb256 -> "vpaddb256"
  | VPaddw256 -> "vpaddw256"
  | VPaddd256 -> "vpaddd256"
  | VPaddq256 -> "vpaddq256"
  | VPsubb256 -> "vpsubb256"
  | VPsubw256 -> "vpsubw256"
  | VPsubd256 -> "vpsubd256"
  | VPsubq256 -> "vpsubq256"
  (* AVX-512 *)       
  | VPandd512 -> "vpandd512"
  | VPord512 -> "vpord512"
  | VPxord512 -> "vpxord512"
  | VPandnd512 -> "vpandnd512"

let rec arith_to_str = function
  | Const_e i -> string_of_int i
  | Var_e v   -> v
  | Op_e(op,x,y) -> sprintf "(%s %s %s)" (arith_to_str x) (arith_op_to_str op)
                            (arith_to_str y)
                                                 
let rec arith_to_str_types = function
  | Const_e i -> "Const_e: " ^ (string_of_int i)
  | Var_e v   -> "Var_e: " ^ v
  | Op_e(op,x,y) -> "Op_e(" ^ (arith_to_str_types x) ^ " " ^ (arith_op_to_str op) ^
                      " " ^ (arith_to_str_types y) ^ ")"

let rec var_to_str = function
  | Var v -> v
  | Field(v,e) -> sprintf "%s.%s" (var_to_str v) (arith_to_str e)
  | Index(v,e) -> sprintf "[%s]" (arith_to_str e)
  | Range(v,ei,ef) -> sprintf "[%s .. %s]" (arith_to_str ei) (arith_to_str ef)
  | Slice(v,l) -> sprintf "[%s]" (join "," (List.map arith_to_str l))
                                              
let rec var_to_str_types = function
  | Var v -> "Var: " ^ v
  | Field(v,e) -> "Field: " ^ (var_to_str_types v) ^ "." ^ (arith_to_str_types e)
  | Index(v,e) -> "Index: " ^ v ^ "[" ^ (arith_to_str_types e) ^ "]"
  | Range(v,ei,ef) -> "Range: " ^ v ^ "[" ^ (arith_to_str_types ei) ^ " .. "
                      ^ (arith_to_str_types ef) ^ "]"
  | Slice(v,l) -> "Splice: " ^ v ^ "[" ^
                     (join "," (List.map arith_to_str_types l)) ^ "]"
         
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
  | Intr(o,x,y) -> "Log: " ^ "(" ^ (expr_to_str_types x) ^ (intr_op_to_str o)
                  ^ (expr_to_str_types y) ^ ")"
  | Not e -> "Not: ~" ^ (expr_to_str_types e)
  | Fun(f,l) -> "Fun: " ^ f ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun_v(f,e,l) -> "Fun_v: " ^ f ^ "[" ^ (arith_to_str e) ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fby(ei,ef,id) -> "Fby: " ^ (expr_to_str_types ei) ^ " fby " ^ (expr_to_str_types ef)
  | Nop -> "Nop"

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
  | Intr(o,x,y) -> sprintf "(%s %s %s)" (expr_to_str x)
                           (intr_op_to_str o) (expr_to_str y)
  | Not e -> sprintf "(~ %s)" (expr_to_str e)
  | Fun(f,l) -> sprintf "%s(%s)" f (join "," (List.map expr_to_str l))
  | Fun_v(f,e,l) -> sprintf "%s[%s](%s)" f (arith_to_str e)
                            (join "," (List.map expr_to_str l))
  | Fby(ei,ef,id) -> sprintf "%s fby %s" (expr_to_str ei) (expr_to_str ef)
  | Nop -> "Nop"

let pat_to_str pat =
  "(" ^ (join "," (List.map var_to_str pat)) ^ ")"

let rec typ_to_str typ =
  match typ with
  | Bool -> "bool"
  | Int n -> "uint_"^(string_of_int n)
  | Nat -> "nat"
  | Array(typ,e) -> (typ_to_str typ) ^ "[" ^ (arith_to_str e) ^ "]"
            
let p_to_str (id,typ,ck) =
  id ^ ":" ^ (typ_to_str typ) ^  "::" ^ ck

let deq_to_str = function
  | Norec(pat,e) -> (pat_to_str pat) ^ " = " ^ (expr_to_str e)
  | Rec(id,ei,ef,pat,e) -> "forall " ^ id ^ " in [" ^
                             (arith_to_str ei) ^ "," ^ (arith_to_str ef)
                             ^ "], " ^ (pat_to_str pat) ^ " = " ^ (expr_to_str e)
                                          
let single_node_to_str id p_in p_out vars deq =
  "node " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in)) ^ ")\n  returns "
  ^ (join "," (List.map p_to_str p_out)) ^ "\nvars\n"
  ^ (join ",\n" (List.map (fun x -> "  " ^ (p_to_str x)) vars)) ^ "\nlet\n"
  ^ (join ";\n" (List.map (fun x -> "  " ^ x) (List.map deq_to_str deq)))
  ^ "\ntel"
      
let def_to_str def =
  let (id,p_in,p_out) = (def.id,def.p_in,def.p_out) in
  match def.node with
  | Single(vars,deq) ->
     single_node_to_str id p_in p_out vars deq
  | Multiple l ->
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
                                       (List.map deq_to_str d))
                               ^ "\ntel\n") l))
     ^ "\n]\n"
  | Perm l ->
     "perm " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
     ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
  | MultiplePerm l ->
     "perm[] " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n[ "
     ^ (join "\n;\n"
             (List.map
                (fun l -> "["
                          ^ (join ", " (List.map string_of_int l))
                          ^ "]") l))
     ^ "\n]\n"
  | Table l ->
     "table " ^ id ^ "(" ^ (join "," (List.map p_to_str p_in))
     ^ ")\n  returns " ^ (join "," (List.map p_to_str p_out)) ^ "\n{\n  "
     ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
  | MultipleTable l ->
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
