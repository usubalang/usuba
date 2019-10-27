
type ident = string

type log_op = And | Or | Xor

type arith_op = Add | Mul | Sub | Div | Mod

type shift_op = Lshift | Rshift | Lrotate | Rrotate

type expr =
  | ExpVar of ident
  | Const of int
  | ConstAll of int
  | Not of ident
  | Log of log_op * ident * ident
  | Arith of arith_op * ident * ident
  | Shift of shift_op * ident * int

type asgn = { lhs : ident; rhs : expr }

type prog = {
  rs : int; (* register size *)
  inputs : ident list;
  body : asgn list;
}
