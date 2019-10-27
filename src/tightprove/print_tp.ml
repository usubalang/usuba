open Tp_AST
open Basic_utils
open Printf

let log_op_to_str = function
  | And -> "and"
  | Or  -> "or"
  | Xor -> "xor"

let shift_op_to_str = function
  | Lshift  -> "<<"
  | Rshift  -> ">>"
  | Lrotate -> "<<<"
  | Rrotate -> ">>>"

let rec expr_to_str (e:expr) : string =
  match e with
  | ExpVar id      -> id
  | Const c        -> sprintf "setcst(0x%x)" c
  | ConstAll c     -> sprintf "setcstall(0x%x)" c
  | BitToReg(id,n) -> sprintf "bit_to_reg(%s,%d)" id n
  | Refresh id     -> sprintf "refresh(%s)" id
  | Not id         -> sprintf "not %s" id
  | Log(o,x,y)     -> sprintf "%s %s %s" (log_op_to_str o) x y
  | Shift(op,e,n)  -> sprintf "%s %s %d" e (shift_op_to_str op) n

let asgn_to_str (asgn:asgn) : string =
  sprintf "%s = %s\n" asgn.lhs (expr_to_str asgn.rhs)

let def_to_str (def:def) : string =
  sprintf
"rs=%d

in %s

%s
"
(* m *)
def.rs
(* inputs *)
(join " " def.inputs)
(* body *)
(join "" (List.map asgn_to_str def.body))


let print_def (def:def) : unit =
  Printf.printf "%s" (def_to_str def)
