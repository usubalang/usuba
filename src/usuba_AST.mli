type ident = Ident.t
type log_op = And | Or | Xor | Andn | Masked of log_op
type arith_op = Add | Mul | Sub | Div | Mod

type shift_op =
  | Lshift
  | Rshift
  | RAshift
  (* arithmetic right shift *)
  | Lrotate
  | Rrotate

type arith_expr =
  | Const_e of int
  | Var_e of ident
  | Op_e of arith_op * arith_expr * arith_expr

type dir =
  | Hslice
  | Vslice
  | Bslice
  | Natdir (* Special direction for Nat *)
  | Varslice of ident (* variable *)
  | Mslice of int (* Generalized m-slicing *)

type mtyp =
  | Mint of int
  | Mnat (* Special m for Nat *)
  | Mvar of ident (* variable *)

type typ = Nat | Uint of dir * mtyp * int | Array of typ * arith_expr

type var =
  | Var of ident
  | Index of var * arith_expr
  | Range of var * arith_expr * arith_expr
  | Slice of var * arith_expr list

(* XXX: factorize operations in a single case *)
type expr =
  | Const of int * typ option
  | ExpVar of var
  | Tuple of expr list
  | Not of expr (* special case for bitwise not *)
  | Log of log_op * expr * expr
  | Arith of arith_op * expr * expr
  | Shift of shift_op * expr * arith_expr
  | Shuffle of var * int list
  | Bitmask of expr * arith_expr
  | Pack of expr * expr * typ option
  | Fun of ident * expr list
  | Fun_v of ident * arith_expr * expr list (* nodes arrays *)

type stmt_opt = Unroll | No_unroll | Pipelined | Safe_exit

type deq_i =
  | Eqn of var list * expr * bool
  | Loop of ident * arith_expr * arith_expr * deq list * stmt_opt list

and deq = {
  content : deq_i;
  orig : (ident * deq_i) list;
      (* A list of functions from which this deq was inlined (and
         the original deqs from those functions) *)
}

val pp_deq_i : Format.formatter -> deq_i -> unit
val sexp_of_deq_i : deq_i -> Sexplib.Sexp.t

type var_d_opt = Pconst | PlazyLift

type var_d = {
  vd_id : ident;
  vd_typ : typ;
  vd_opts : var_d_opt list;
  vd_orig : (ident * var_d) list;
      (* A list of functions from where this variable was inlined *)
}

type p = var_d list

type def_i =
  | Single of p * deq list (* regular node *)
  | Perm of int list (* permutation *)
  | Table of int list (* lookup table *)
  | Multiple of def_i list

type def_opt = Inline | No_inline | Interleave of int | No_opt | Is_table
type def = { id : ident; p_in : p; p_out : p; opt : def_opt list; node : def_i }

val pp_def : Format.formatter -> def -> unit
val sexp_of_def : def -> Sexplib.Sexp.t

type def_or_inc = Def of def | Inc of string

val pp_def_or_inc : Format.formatter -> def_or_inc -> unit
val sexp_of_def_or_inc : def_or_inc -> Sexplib.Sexp.t

type prog = { nodes : def list }

val pp_prog : Format.formatter -> prog -> unit
val sexp_of_prog : prog -> Sexplib.Sexp.t
