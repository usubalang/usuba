
type log_op = And | Or | Xor

type arith_op = Add | Mul | Sub | Div | Mod

type shift_op = Lshift | Rshift | Lrotate | Rrotate

type expr =
  | ExpVar   of string
  | Const    of int
  | ConstAll of int
  | Refresh  of string
  | BitToReg of string * int (* useful for Pyjamask: -1 if string.int == 1; 0 otherwise *)
  | Not      of string
  | Log      of log_op * string * string
  | Shift    of shift_op * string * int

type asgn = { lhs : string; rhs : expr }

type def = {
  rs : int; (* register size *)
  inputs : string list;
  body : asgn list;
}
