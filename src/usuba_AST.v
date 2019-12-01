Require Import String.
Require Import Coq.ZArith.ZArith.

Require Import Coq.extraction.ExtrOcamlBasic.
Require Import Coq.extraction.ExtrOcamlZInt.
Require Import Coq.extraction.ExtrOcamlString.


(* XXX: this won't work for actual extraction*)
Extract Inductive string => "string"  [ """" "^" ].

Record ident := { uid: positive;
                  name: string }.
Inductive clock :=
| Defclock (* Temporary, for clocks we don't know *)
| Base
| On (ck:clock) (x:ident)
| Onot (ck:clock) (x:ident).

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

Inductive constr :=
  | True
  | False.

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
  | Fby (e1 e2: expr)(mx: option ident)
  | When (e: expr)(x: constr) (y: ident)
  | Merge (x: ident)(xs: list (constr * expr)).

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
  vd_ck   : clock;
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
  warnings     : bool;
  verbose      : N;
  verif        : bool;
  type_check   : bool;
  clock_check  : bool;
  check_tbl    : bool;
  inlining     : bool;
  inline_all   : bool;
  light_inline : bool;
  fold_const   : bool;
  cse          : bool;
  copy_prop    : bool;
  loop_fusion  : bool;
  scheduling   : bool;
  schedule_n   : N;
  share_var    : bool;
  linearize_arr: bool;
  precal_tbl   : bool;
  archi        : arch;
  bits_per_reg : N;
  no_arr       : bool;
  arr_entry    : bool;
  unroll       : bool;
  interleave   : N;
  fdti         : string;
  lazylift     : bool;
  slicing_set  : bool;
  slicing_type : slicing;
  m_set        : bool;
  m_val        : N;
  tightPROVE   : bool;
  tightprove_dir : string;
  maskVerif    : bool;
  masked       : bool;
  ua_masked    : bool;
  shares       : N;
  gen_bench    : bool;
  keep_tables  : bool;
  compact      : bool;
}.

Set Extraction KeepSingleton.
Extraction "usuba_AST.ml"
           config prog def def_opt def_i p var_d var_d_opt
           deq deq_i expr var typ arith_expr shift_op
           arith_op log_op clock ident arch.