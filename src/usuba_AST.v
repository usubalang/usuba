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

Inductive log_op := And | Or | Xor | Andn.
Inductive arith_op := Add | Mul | Sub | Div | Mod.
Inductive shift_op := Lshift | Rshift | Lrotate | Rrotate.

Inductive arith_expr :=
  | Const_e (i: Z)
  | Var_e (x: ident)
  | Op_e (op: arith_op)(e1 e2: arith_expr).

Inductive dir :=
  | Hslice
  | Vslice
  | Bslice
  | Varslice (id:ident) (* variable *)
  | Mslice (i:N). (* Generalized m-slicing *)

Inductive mtyp :=
  | Mint (i:N)
  | Mvar (id:ident). (* variable *)

Inductive typ :=
  | Nat
  | Uint (d:dir) (m: mtyp) (n:N)
  | Array (t: typ) (n:N).

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

Inductive deq :=
  | Eqn (vs: list var)(e: expr)(sync:bool)
  | Loop (x: ident)(ae1 ae2: arith_expr)(dl: list deq) (opts:list stmt_opt).

Inductive var_d_opt := Pconst | PlazyLift.

Record var_d := {
  vid   : ident;
  vtyp  : typ;
  vck   : clock;
  vopts : list var_d_opt;
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
  cse_cp       : bool;
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
  shares       : N;
  keep_tables  : bool;
}.

Set Extraction KeepSingleton.
Extraction "usuba_AST.ml"
           config prog def def_opt def_i p var_d var_d_opt
           deq expr var typ arith_expr shift_op
           arith_op log_op clock ident arch.