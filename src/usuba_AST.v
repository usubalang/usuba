Require Import String.
Require Import Coq.extraction.ExtrOcamlBasic.
Require Import Coq.extraction.ExtrOcamlIntConv.
Require Import Coq.extraction.ExtrOcamlString.

(* XXX: this won't work for actual extraction*)
Extract Inductive string => "string"  [ """" "^" ].

Definition ident := string.
Definition clock := string.

Inductive log_op := And | Or | Xor | Andn.
Inductive arith_op := Add | Mul | Sub | Div | Mod.
Inductive shift_op := Lshift | Rshift | Lrotate | Rrotate.
Inductive intr_fun :=
    (* General purpose registers *)
    | And64 | Or64 | Xor64 | Not64
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
    | VPandd512 | VPord512 | VPxord512 | VPandnd512.

Inductive arith_expr :=
  | Const_e (i: int)
  | Var_e (x: ident)
  | Op_e (op: arith_op)(e1 e2: arith_expr).

Inductive typ :=
  | Bool
  | Int (i: int)
  | Nat (* for recurrence variables. Not part of usuba0 normalized *)
  | Array (t: typ)(ae: arith_expr). (* arrays *)

Inductive constr :=
  | True
  | False.

Inductive var :=
  | Var (i: ident)
  | Field (v: var)(ae: arith_expr)
  | Index (x: ident)(ae: arith_expr)
  | Range (x: ident)(ae1 ae2: arith_expr)
  | Slice (x: ident)(aes: list arith_expr).

(* XXX: factorize operations in a single case *)
Inductive expr :=
  | Const (i: int)
  | ExpVar (v: var)
  | Tuple (es: list expr)
  | Not (e: expr) (* special case for bitwise not *)
  | Shift (op: shift_op)(e: expr)(ae: arith_expr)
  | Log  (op: log_op)(e1 e2: expr)
  | Arith (op: arith_op)(e1 e2: expr)
  | Intr (i: intr_fun)(e1 e2: expr)
  | Fun (x: ident)(es: list expr)
  | Fun_v (x: ident)(ae: arith_expr)(es: list expr) (* nodes arrays *)
  | Fby (e1 e2: expr)(mx: option ident)
  | When (e: expr)(x: constr) (y: ident)
  | Merge (x: ident)(xs: list (constr * expr))
  | Nop.

Inductive deq :=
  | Norec (vs: list var)(e: expr)
  | Rec (x: ident)(ae1 ae2: arith_expr)(dl: list deq).

(* XXX: define a record for [ident * typ * clock] *)
Definition p := list (ident * typ * clock).

Inductive def_i :=
  | Single        (n: p)(ds: list deq) (* regular node *)
  | Multiple      (an: list (p * list deq)) (*array of nodes*)
  | Perm          (pi: list int) (* permutation *)
  | MultiplePerm  (pis: list (list int)) (* array of perm *)
  | Table         (t: list int) (* lookup table *)
  | MultipleTable (ts: list (list int)). (* array of lookup tables *)

Inductive def_opt := Inline | No_inline.

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

(* The compiler's configuration *)
Record config := {
  block_size : int;
  key_size   : int;
  warnings   : bool;
  verbose    : int;
  verif      : bool;
  type_check : bool;
  check_tbl  : bool;
  inlining   : bool;
  inline_all : bool;
  cse_cp     : bool;
  scheduling : bool;
  array_opti : bool;
  share_var  : bool;
  precal_tbl : bool;
  archi      : arch;
  bench      : bool;
  ortho      : bool;
  openmp     : int;
}.

Set Extraction KeepSingleton.
Extraction "usuba_AST.ml" 
           config prog def def_opt def_i p deq
           expr var typ arith_expr intr_fun shift_op
           arith_op log_op clock ident arch.