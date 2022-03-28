type ident = { uid : int; name : string } [@@deriving show]
type log_op = And | Or | Xor | Andn | Masked of log_op [@@deriving show]
type arith_op = Add | Mul | Sub | Div | Mod [@@deriving show]

type shift_op = Lshift | Rshift | RAshift | Lrotate | Rrotate
[@@deriving show]

type arith_expr =
  | Const_e of int
  | Var_e of ident
  | Op_e of arith_op * arith_expr * arith_expr
[@@deriving show]

type dir =
  | Hslice
  | Vslice
  | Bslice
  | Natdir
  | Varslice of ident
  | Mslice of int
[@@deriving show]

type mtyp = Mint of int | Mnat | Mvar of ident [@@deriving show]

type typ = Nat | Uint of dir * mtyp * int | Array of typ * arith_expr
[@@deriving show]

type var =
  | Var of ident
  | Index of var * arith_expr
  | Range of var * arith_expr * arith_expr
  | Slice of var * arith_expr list
[@@deriving show]

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
[@@deriving show]

type stmt_opt = Unroll | No_unroll | Pipelined | Safe_exit [@@deriving show]

type 'a _deq_i =
  | Eqn of var list * expr * bool
  | Loop of ident * arith_expr * arith_expr * 'a list * stmt_opt list
[@@deriving show]

type deq = { content : deq _deq_i; orig : (ident * deq _deq_i) list }
[@@deriving show]

type deq_i = deq _deq_i [@@deriving show]
type var_d_opt = Pconst | PlazyLift [@@deriving show]

type var_d = {
  vd_id : ident;
  vd_typ : typ;
  vd_opts : var_d_opt list;
  vd_orig : (ident * var_d) list;
}
[@@deriving show]

type p = var_d list [@@deriving show]

type def_i =
  | Single of p * deq list
  | Perm of int list
  | Table of int list
  | Multiple of def_i list
[@@deriving show]

type def_opt = Inline | No_inline | Interleave of int | No_opt | Is_table
[@@deriving show]

type def = { id : ident; p_in : p; p_out : p; opt : def_opt list; node : def_i }
[@@deriving show]

type def_or_inc = Def of def | Inc of string [@@deriving show]
type prog = { nodes : def list } [@@deriving show]
type arch = Std | MMX | SSE | AVX | AVX512 | Neon | AltiVec [@@deriving show]
type slicing = H | V | B [@@deriving show]

type config = {
  warnings : bool;
  verbose : int;
  path : string list;
  type_check : bool;
  check_tbl : bool;
  auto_inline : bool;
  light_inline : bool;
  inline_all : bool;
  heavy_inline : bool;
  no_inline : bool;
  compact_mono : bool;
  fold_const : bool;
  cse : bool;
  copy_prop : bool;
  loop_fusion : bool;
  pre_schedule : bool;
  scheduling : bool;
  schedule_n : int;
  share_var : bool;
  linearize_arr : bool;
  precal_tbl : bool;
  archi : arch;
  bits_per_reg : int;
  no_arr : bool;
  arr_entry : bool;
  unroll : bool;
  interleave : int;
  inter_factor : int;
  fdti : string;
  lazylift : bool;
  slicing_set : bool;
  slicing_type : slicing;
  m_set : bool;
  m_val : int;
  tightPROVE : bool;
  tightprove_dir : string;
  maskVerif : bool;
  masked : bool;
  ua_masked : bool;
  shares : int;
  gen_bench : bool;
  keep_tables : bool;
  compact : bool;
  bench_inline : bool;
  bench_inter : bool;
  bench_bitsched : bool;
  bench_msched : bool;
  bench_sharevar : bool;
}
[@@deriving show]
