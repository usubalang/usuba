Require Import String.
Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.


Require Import Coq.extraction.ExtrOcamlBasic.
Require Import Coq.extraction.ExtrOcamlZInt.
Require Import Coq.extraction.ExtrOcamlString.


(* XXX: this won't work for actual extraction*)
Extract Inductive string => "string"  [ """" "^" ].

(*################################################################*)
(* Identifiers *)

Record ident := { uid: positive;
                  name: string }.

(*################################################################*)
(* Types *)

Inductive typ :=
  (* [[Atom k]] is a machine word of size [[k]] *)
  | ATOM: nat -> typ
  (* [[TUP tys]] is an heterogeneous list *)
  | TUP (t: list typ).
  (* XXX: I don't understand these: *)
  (* | Int (i: N) (j :N) *)
  (* | Nat (* for recurrence variables. Not part of usuba0 normalized *) *)
  (* | Array (t: typ)(ae: arith_expr) (* arrays *) *)

(*################################################################*)
(* Clocks *)

Inductive clock :=
| Defclock (* Temporary, for clocks we don't know *)
| Base
| On (ck:clock) (x:ident)
| Onot (ck:clock) (x:ident).

(*################################################################*)
(* Values *)

Inductive val :=
| Atom: nat -> N -> val (* N.size_nat n < k *)
| Tup: list val -> val.

Definition Ttrue := Atom 1 1%N.
Definition Tfalse := Atom 1 0%N.

(*################################################################*)
(* Compile-time expressions *)

Inductive arith_op := Add | Mul | Sub | Div | Mod.

Inductive arith_expr :=
  | Const_e (i: N)
  | Var_e (x: ident)
  | Op_e (op: arith_op)(e1 e2: arith_expr).

(*################################################################*)
(* Run-time expressions *)

Inductive var :=
  | Var (i: ident)
  (* XXX: update the rest of the code so that it takes a [var] and not an [ident]  *)
  | Slice (v: var)(aes: list arith_expr)
  | Range (v: var)(ae1 ae2: arith_expr).

Definition Field (v: var)(ae: arith_expr) := Slice v [ae].
Definition Index (x: ident)(ae: arith_expr) := Slice (Var x) [ae].


Inductive log_op := And | Or | Xor | Andn.
Inductive shift_op := Lshift | Rshift | Lrotate | Rrotate.

(* XXX: factorize operations in a single case *)
Inductive expr :=
  | Const (v: val)
  | ExpVar (v: var)
  | Tuple (es: list expr)
  | Not (e: expr) (* special case for bitwise not *)
  | Shift (op: shift_op)(e: expr)(ae: arith_expr)
  | Log  (op: log_op)(e1 e2: expr)
  | Fun (x: ident)(es: list expr)
  (* XXX: not yet supported by the semantics *)
(*  | Fun_v (x: ident)(ae: arith_expr)(es: list expr) (* nodes arrays *) *)
  (* XXX: not yet supported by the semantics *)
(*  | When (e: expr)(x: constr) (y: ident) *)
  (* XXX: not yet supported by the semantics *)
(*  | Merge (x: ident)(xs: list (constr * expr)) *)
  (* XXX: how could we bitslice an arithmetic operation (efficiently)? *)
(*  | Arith (op: arith_op)(e1 e2: expr) *)
  (* XXX: we do not actually support fby *)
(*  | Fby (e1 e2: expr)(mx: option ident) *).

Inductive deq :=
  | Norec (vs: list var)(e: expr)
  (* XXX: what is the meaning of [x]? *)
  | Rec (x: ident)(ae1 ae2: arith_expr)(dl: list deq).

Record formal := { t : typ ;
                   c : clock }.
Definition formals := list (ident * formal).

Definition vars_of (p: formals): list ident := map fst p.
Definition typs_of (p: formals): list typ := map (fun x => (snd x).(t)) p.


Inductive def_i :=
  | Single        (locals: formals)(ds: list deq) (* regular node *)
  | Multiple      (an: list (formals * list deq)) (*array of nodes*)
  | Perm          (pi: list N) (* permutation *)
  | MultiplePerm  (pis: list (list N)) (* array of perm *)
  | Table         (t: list N) (* lookup table *)
  | MultipleTable (ts: list (list N)). (* array of lookup tables *)

Inductive def_opt := Inline | No_inline.

Record def := {
  d_name: string;
  p_in  : formals;
  p_out : formals;
  opt   : list def_opt;
  node  : def_i;
}.

Definition prog := list (ident * def).


Inductive arch :=
  | Std
  | MMX
  | SSE
  | AVX
  | AVX512
  | Neon
  | AltiVec.

(* The compiler's configuration *)
Record config := {
  block_size  : N;
  key_size    : N;
  warnings    : bool;
  verbose     : N;
  verif       : bool;
  type_check  : bool;
  clock_check : bool;
  check_tbl   : bool;
  inlining    : bool;
  inline_all  : bool;
  cse_cp      : bool;
  scheduling  : bool;
  array_opti  : bool;
  share_var   : bool;
  precal_tbl  : bool;
  archi       : arch;
  bit_per_reg : N;
  bench       : bool;
  rand_input  : bool;
  runtime     : bool;
  ortho       : bool;
  openmp      : N;
}.

Set Extraction KeepSingleton.
Extraction "usuba_AST.ml" 
           config prog def def_opt def_i formals deq
           expr var typ arith_expr shift_op
           arith_op log_op clock ident arch.