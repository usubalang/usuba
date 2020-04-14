Require Import String.
Require Import Coq.ZArith.ZArith.

Require Import Coq.extraction.ExtrOcamlBasic.
Require Import Coq.extraction.ExtrOcamlZInt.
Require Import Coq.extraction.ExtrOcamlString.


(* XXX: this won't work for actual extraction*)
Extract Inductive string => "string"  [ """" "^" ].

Record ident := { uid: positive;
                  name: string }.

Inductive log_op := And | Or | Xor | Andn | Masked (op:log_op).
Inductive arith_op := Add | Mul | Sub | Div | Mod.
Inductive shift_op := Lshift | Rshift | RAshift (* arithmetic right shift *)
                      | Lrotate | Rrotate.

Inductive arith_expr :=
  | Const_e (i: Z)
  | Var_e (x: ident)
  | Op_e (op: arith_op)(e1 e2: arith_expr).

Inductive dir :=
  | Hslice
  | Vslice
  | Bslice
  | Natdir (* Special direction for Nat *)
  | Varslice (id:ident) (* variable *)
  | Mslice (i:N). (* Generalized m-slicing *)

Inductive mtyp :=
  | Mint (i:N)
  | Mnat (* Special m for Nat *)
  | Mvar (id:ident). (* variable *)

Inductive typ :=
  | Nat
  | Uint (d:dir) (m: mtyp) (n:N)
  | Array (t: typ) (n:arith_expr).

Inductive var :=
  | Var (i: ident)
  | Index (x: var)(ae: arith_expr)
  | Range (x: var)(ae1 ae2: arith_expr)
  | Slice (x: var)(aes: list arith_expr).

(* XXX: factorize operations in a single case *)
Inductive expr :=
  | Const (i: N) (t:option typ)
  | ExpVar (v: var)
  | Tuple (es: list expr)
  | Not (e: expr) (* special case for bitwise not *)
  | Shift (op: shift_op)(e: expr)(ae: arith_expr)
  | Log  (op: log_op)(e1 e2: expr)
  | Shuffle (v:var) (pat: list N)
  | Arith (op: arith_op)(e1 e2: expr)
  | Fun (x: ident)(es: list expr)
  | Fun_v (x: ident)(ae: arith_expr)(es: list expr) (* nodes arrays *)
.

Inductive stmt_opt := Unroll | No_unroll | Pipelined | Safe_exit.

Inductive _deq_i (X:Type) : Type :=
  | Eqn (vs: list var)(e: expr)(sync:bool)
  | Loop (x: ident)(ae1 ae2: arith_expr)(dl: list X) (opts:list stmt_opt).

Inductive deq := {
  content : _deq_i deq;
  orig : list (ident * (_deq_i deq))
        (* A list of functions from which this deq was inlined (and
           the original deqs from those functions) *)
}.

Definition deq_i := _deq_i deq.

Inductive var_d_opt := Pconst | PlazyLift.

Inductive var_d := {
  vd_id   : ident;
  vd_typ  : typ;
  vd_opts : list var_d_opt;
  vd_orig : list (ident * var_d); (* A list of functions from where this variable was inlined *)
}.

Definition p := list var_d.

Inductive def_i :=
  | Single        (n: p)(ds: list deq) (* regular node *)
  | Perm          (pi: list N) (* permutation *)
  | Table         (t: list N) (* lookup table *)
  | Multiple      (l: list def_i).

Inductive def_opt := Inline | No_inline | Interleave (n:N) | No_opt | Is_table.

Record def := {
  id    : ident;
  p_in  : p;
  p_out : p;
  opt   : list def_opt;
  node  : def_i;
}.

Record prog := {
  nodes : list def;
}.


Inductive arch :=
  | Std
  | MMX
  | SSE
  | AVX
  | AVX512
  | Neon
  | AltiVec.

Inductive slicing := H | V | B.

(* The compiler's configuration *)
Record config := {
  warnings     : bool; (* Doesn't do anything... I think *)
  verbose      : N;    (* 5   = prints which passes are getting executed,
                          100 = prints the Usuba program after each pass *)
  type_check   : bool; (* Enables type-checking *)
  check_tbl    : bool; (* Enables verification of tables to circuit conversion *)
  no_inline    : bool; (* Disables all inlining *)
  auto_inline  : bool; (* Lets Usuba chose which nodes to inline or not *)
  inline_all   : bool; (* Inlines all nodes *)
  light_inline : bool; (* Inlines only nodes marked with _inline *)
  fold_const   : bool; (* Enables constant folding *)
  cse          : bool; (* Enables CSE *)
  copy_prop    : bool; (* Enables Copy propagation *)
  loop_fusion  : bool; (* Enables loop fusion *)
  pre_schedule : bool; (* Enables bistlice scheduling *)
  scheduling   : bool; (* Enables mslice scheduling *)
  schedule_n   : N;    (* Look-behind window for mslice scheduling *)
  share_var    : bool; (* Enables variable reuse *)
  linearize_arr: bool; (* Enables array linearization *)
  precal_tbl   : bool; (* Enables the use of precomputed lookup tables *)
  archi        : arch; (* Selects the architecture to target *)
  bits_per_reg : N;    (* Number of bits per register *)
  no_arr       : bool; (* Removes all arrays (except in parameters) *)
  arr_entry    : bool; (* Removes arrays from parameters *)
  unroll       : bool; (* Unrolls all loops *)
  interleave   : N;    (* Interleaving granularity *)
  inter_factor : N;    (* Interleaving factor *)
  auto_inter   : bool; (* Automatically interleave *)
  fdti         : string; (* *)
  lazylift     : bool; (* Enables lazy lifting *)
  slicing_set  : bool; (* If true, it means a slicing direction is selected,
                          and slicing_type (below) contains it *)
  slicing_type : slicing; (* Slicing direction *)
  m_set        : bool; (* If true, it means a word size is selected,
                          and m_val (below) contains it *)
  m_val        : N;    (* word size *)
  tightPROVE   : bool; (* Enables tightPROVE masking verification *)
  tightprove_dir : string; (* Tightprove's output directory *)
  maskVerif    : bool; (* Enables maskVerif code generation *)
  masked       : bool; (* Enables masking by using special AND/OR/NOT/XOR macros *)
  ua_masked    : bool; (* Enables masking within Usuba; only a custom
                          AND macro is needed *)
  shares       : N;    (* Number of shares for masking *)
  gen_bench    : bool; (* Generates a benchmarking function *)
  keep_tables  : bool; (* Keeps tables as tables rather than converting
                          them into circuits *)
  compact      : bool; (* (broken) Generates loops when unfolding
                          operators instead of a list of equations. *)
}.

Set Extraction KeepSingleton.
Extraction "usuba_AST.ml"
           config prog def def_opt def_i p var_d var_d_opt
           deq deq_i expr var typ arith_expr shift_op
           arith_op log_op ident arch.