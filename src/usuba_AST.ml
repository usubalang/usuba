
exception Invalid_AST of string

type ident = string
               
type clock = string

type log_op = And | Or | Xor | Andn
type arith_op = Add | Mul | Sub | Div | Mod
type shift_op = Lshift | Rshift | Lrotate | Rrotate
type intr_fun =
    (* General purpose registers *)
    And64 | Or64 | Xor64 | Not64
    | Add64 | Sub64 | Mul64 | Div64 | Mod64
    (* MMX *)
    | Pand64 | Por64 | Pxor64 | Pandn64
    | Paddb64 | Paddw64 | Paddd64
    | Psubb64 | Psubw64 | Psubd64
    (* SSE *)
    | Pand128 | Por128 | Pxor128 | Pandn128
    | Paddb128 | Paddw128 | Paddd128 | Paddq128
    | Psubb128 | Psubw128 | Psubd128 | Psubq128
    (* AVX *) 
    | VPand256 | VPor256 | VPxor256 | VPandn256
    | VPaddb256 | VPaddw256 | VPaddd256 | VPaddq256
    | VPsubb256 | VPsubw256 | VPsubd256 | VPsubq256
    (* AVX-512 *)
    | VPandd512 | VPord512 | VPxord512 | VPandnd512 

type slice_type =
    Std (* 64-bit *)
    | MMX of int
    | SSE of int
    | AVX of int
    | AVX512
                                            
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
