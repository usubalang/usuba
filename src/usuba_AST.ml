
exception Invalid_AST of string

type ident = string
               
type clock = string

type log_op = And | Or | Xor | Andn
type arith_op = Add | Mul | Sub | Div | Mod
type shift_op = Lshift | Rshift | Lrotate | Rrotate
type intr_fun =  Pand | Por | Pxor | Pandn
                 | VPand | VPor | VPxor | VPandn
                 | VPandd | VPord | VPxord | VPandnd
                                            
type arith_expr =
  | Const_e of int
  | Var_e of ident
  | Op_e of arith_op * arith_expr * arith_expr
                                     
type typ =
    Bool
  | Int of int
  | Nat (* for recurrence variables. Not part of usuba0 normalized *)
  | Array of typ * arith_expr (* arrays *)

type var =
  | Var of ident
  | Field of var * arith_expr
  | Index of ident * arith_expr
  | Range of ident * arith_expr * arith_expr
                     
type expr = Const  of int
          | ExpVar of var
          | Tuple  of expr list
          | Not    of expr (* special case for bitwise not *)
          | Shift  of shift_op * expr * arith_expr
          | Log    of log_op * expr * expr
          | Arith  of arith_op * expr * expr 
          | Intr   of intr_fun * expr * expr
          | Fun    of ident * expr list
          | Fun_v  of ident * arith_expr * expr list (* nodes arrays *)
          | Fby    of expr * expr * ident option
          | Nop                           
                            
type deq =
  | Norec of (var list) * expr
  | Rec of ident * arith_expr * arith_expr * (var list) * expr

type p = (ident * typ * clock) list
                                
type def =
  | Single of ident * p * p * p * deq list
  | Multiple  of ident * p * p * (p * deq list) list (*array of nodes*)
  | Perm of ident * p * p * int list (* permutation *)
  | MultiplePerm of ident * p * p * (int list) list (* array of perm *)
  | Table of ident * p * p * int list (* lookup table *)
  | MultipleTable of ident * p * p * (int list) list (* array of lookup tables *)
                                
type prog = def list
