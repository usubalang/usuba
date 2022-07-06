open Sexplib.Std

type ident = Ident.t

let pp_ident = Ident.pp ()
let ident_of_sexp = Ident.t_of_sexp
let sexp_of_ident = Ident.sexp_of_t

type log_op = And | Or | Xor | Andn | Masked of log_op [@@deriving show, sexp]
type arith_op = Add | Mul | Sub | Div | Mod [@@deriving show, sexp]

type shift_op = Lshift | Rshift | RAshift | Lrotate | Rrotate
[@@deriving show, sexp]

type arith_expr =
  | Const_e of int
  | Var_e of ident
  | Op_e of arith_op * arith_expr * arith_expr
[@@deriving show, sexp]

type dir =
  | Hslice
  | Vslice
  | Bslice
  | Natdir
  | Varslice of ident
  | Mslice of int
[@@deriving show, sexp]

type mtyp = Mint of int | Mnat | Mvar of ident [@@deriving show, sexp]

type typ = Nat | Uint of dir * mtyp * int | Array of typ * arith_expr
[@@deriving show, sexp]

type var =
  | Var of ident
  | Index of var * arith_expr
  | Range of var * arith_expr * arith_expr
  | Slice of var * arith_expr list
[@@deriving show, sexp]

type expr =
  | Const of int * typ option
  | ExpVar of var
  | Tuple of expr list
  | Not of expr
  | Log of log_op * expr * expr
  | Arith of arith_op * expr * expr
  | Shift of shift_op * expr * arith_expr
  | Shuffle of var * int list
  | Bitmask of expr * arith_expr
  | Pack of expr * expr * typ option
  | Fun of ident * expr list
  | Fun_v of ident * arith_expr * expr list
[@@deriving show, sexp]

type stmt_opt = Unroll | No_unroll | Pipelined | Safe_exit
[@@deriving show, sexp]

type deq_i =
  | Eqn of var list * expr * bool
  | Loop of ident * arith_expr * arith_expr * deq list * stmt_opt list
[@@deriving show, sexp]

and deq = { content : deq_i; orig : (ident * deq_i) list }
[@@deriving show, sexp]

type var_d_opt = Pconst | PlazyLift [@@deriving show, sexp]

type var_d = {
  vd_id : ident;
  vd_typ : typ;
  vd_opts : var_d_opt list;
  vd_orig : (ident * var_d) list;
}
[@@deriving show, sexp]

type p = var_d list [@@deriving show, sexp]

type def_i =
  | Single of p * deq list
  | Perm of int list
  | Table of int list
  | Multiple of def_i list
[@@deriving show, sexp]

type def_opt = Inline | No_inline | Interleave of int | No_opt | Is_table
[@@deriving show, sexp]

type def = { id : ident; p_in : p; p_out : p; opt : def_opt list; node : def_i }
[@@deriving show, sexp]

type def_or_inc = Def of def | Inc of string [@@deriving show, sexp]
type prog = { nodes : def list } [@@deriving show, sexp]
