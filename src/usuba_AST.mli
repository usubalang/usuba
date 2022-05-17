type ident = { uid : int; name : string }
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

type arch = Std | MMX | SSE | AVX | AVX512 | Neon | AltiVec
type slicing = H | V | B

(* The compiler's configuration *)
type config = {
  warnings : bool; (* Doesn't do anything... I think *)
  verbose : int;
  (* 5 = prints which passes are getting executed,
   * 100 = prints the Usuba program after each pass *)
  path : string list; (* Path to search for "include" directives *)
  type_check : bool; (* Enables type-checking *)
  check_tbl : bool; (* Enables verification of tables to circuit conversion *)
  auto_inline : bool; (* Lets Usuba chose which nodes to inline or not *)
  light_inline : bool; (* Inlines only nodes marked with _inline *)
  inline_all : bool; (* Inlines all nodes *)
  heavy_inline : bool; (* Inline every nodes except for _no_inline ones *)
  no_inline : bool; (* Disables all inlining *)
  compact_mono : bool; (* Enables compact monomorphization *)
  fold_const : bool; (* Enables constant folding *)
  cse : bool; (* Enables CSE *)
  copy_prop : bool; (* Enables Copy propagation *)
  loop_fusion : bool; (* Enables loop fusion *)
  pre_schedule : bool; (* Enables bistlice scheduling *)
  scheduling : bool; (* Enables mslice scheduling *)
  schedule_n : int; (* Look-behind window for mslice scheduling *)
  share_var : bool; (* Enables variable reuse *)
  linearize_arr : bool; (* Enables array linearization *)
  precal_tbl : bool; (* Enables the use of precomputed lookup tables *)
  archi : arch; (* Selects the architecture to target *)
  bits_per_reg : int; (* Number of bits per register *)
  no_arr : bool; (* Removes all arrays (except in parameters) *)
  arr_entry : bool; (* Removes arrays from parameters *)
  unroll : bool; (* Unrolls all loops *)
  interleave : int; (* Interleaving granularity *)
  inter_factor : int; (* Interleaving factor *)
  fdti : string; (* *)
  lazylift : bool; (* Enables lazy lifting *)
  slicing_set : bool;
      (* If true, it means a slicing direction is selected,
         and slicing_type (below) contains it *)
  slicing_type : slicing; (* Slicing direction *)
  m_set : bool;
      (* If true, it means a word size is selected,
         and m_val (below) contains it *)
  m_val : int; (* word size *)
  tightPROVE : bool; (* Enables tightPROVE masking verification *)
  tightprove_dir : string; (* Tightprove's output directory *)
  maskVerif : bool; (* Enables maskVerif code generation *)
  masked : bool; (* Enables masking by using special AND/OR/NOT/XOR macros *)
  ua_masked : bool;
      (* Enables masking within Usuba; only a custom
         AND macro is needed *)
  shares : int; (* Number of shares for masking *)
  gen_bench : bool; (* Generates a benchmarking function *)
  keep_tables : bool;
      (* Keeps tables as tables rather than converting
         them into circuits *)
  compact : bool;
  (* (broken) Generates loops when unfolding
     operators instead of a list of equations. *)
  (* Benchmarking flags (for automatic selection of best opti to use or not) *)
  bench_inline : bool; (* Inlining: inline_all vs auto_inline vs _no_inline *)
  bench_inter : bool; (* Interleaving: which factor? (0, 2, 3) *)
  bench_bitsched : bool; (* Bitslice schedule: yes or no *)
  bench_msched : bool; (* Mslice schedule: yes or no *)
  bench_sharevar : bool; (* Share var: yes or no *)
  dump_sexp : bool;
      (* Dump a s-expression corresponding to the compiled usuba program *)
}

val pp_config : Format.formatter -> config -> unit
