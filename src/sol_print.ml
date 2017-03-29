open Sol_AST
open Usuba_AST
open Utils

let op_to_str (op: Sol_AST.op) : string =
  match op with
  | Not -> "not"
  | And -> "and"
  | Or  -> "or"
  | Xor -> "xor"
  | Add -> "add"
  | Mul -> "mul"
  | Sub -> "sub"
  | Div -> "div"
  | Mod -> "mod"
  | Lshift -> "lshift"
  | Rshift -> "rshift"
  | Lrotate -> "lrotate"
  | Rrotate -> "rrotate"


let rec c_to_str (c: Sol_AST.c) : string =
  match c with
  | Var v -> v
  | Const n -> (string_of_int n)
  | Tuple l -> "(" ^ (join "," (List.map c_to_str l)) ^ ")"
  | State_var sv -> "state(" ^ sv ^ ")"
  | Op(op,l) -> (op_to_str op) ^ "(" ^ (join "," (List.map c_to_str l)) ^ ")"

let s_to_str (s: Sol_AST.s) : string =
  match s with
  | Asgn(l,c) -> "(" ^ (join "," l) ^ ") = " ^ (c_to_str c)
  | State_asgn(l,c) -> "(" ^ (join "," l) ^ ") = " ^ (c_to_str c)
  | Skip -> "skip"
  | Reset o -> o ^ ".reset"
  | Step(ll,o,lr) -> "(" ^ (join "," ll) ^ ") = " ^ o ^ ".step" ^
                       "(" ^ (join "," (List.map c_to_str lr)) ^ ")"
       
let slist_to_str (s: Sol_AST.s list) (tab: string): string =
  join ";\n" (List.map (fun x -> tab ^ (s_to_str x)) s)
       
let j_to_str (j: Sol_AST.j) : string =
  join ",\n" (List.map (fun x -> "    " ^ x)
                       (List.map (fun (x,y) -> x ^ ":" ^ y) j))
 
let typ_to_str (typ: Sol_AST.typ) : string =
  match typ with
  | Bool -> "bool"
  | Int64 -> "int64"
  | Int128 -> "int128"
  | Int256 -> "int256"
                
let p_to_str (p: Sol_AST.p) : string =
  join "," (List.map (fun (x,y) -> x ^ ":" ^ (typ_to_str y)) p)
       
let m_to_str (p: Sol_AST.m) (tab: string) : string =
  join ",\n" (List.map (fun x -> tab ^ x)
                       (List.map (fun (x,y) -> x ^ ":" ^ (typ_to_str y)) p))
       
let machine_to_str ((id,mem,inst,reset,p_in,p_out,vars,body):machine) : string =
  "machine " ^ id ^ " =\n"
  ^ "  memory\n" ^ (m_to_str mem "    ") ^ "\n"
  ^ "  instances\n" ^ (j_to_str inst) ^ "\n"
  ^ "  reset() = \n" ^ (slist_to_str reset "    ") ^ " \n"
  ^ "  step (" ^ (p_to_str p_in) ^ ") \n    returns (" ^ (p_to_str p_out) ^ ")\n"
  ^ "    vars\n" ^ (m_to_str vars "      ") ^ " \n"
  ^ "    let\n" ^ (slist_to_str body "      ") ^ "\n    tel\n"
       
let prog_to_str (prog: Sol_AST.prog) : string =
  join "\n\n" (List.map machine_to_str prog)

let print_prog (prog: Sol_AST.prog) : unit =
  print_endline (prog_to_str prog)
