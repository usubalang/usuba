Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

Require Import usuba_AST.

Definition context := PM.t typ.

Inductive ty_var: context -> var -> typ -> Prop :=
  | ty_Var: forall ctxt i ty,
      PM.find (uid i) ctxt = Some ty ->
      ty_var ctxt (Var i) ty.
  (* XXX: TODO *)
(*
  | ty_Slice: forall ctxt v aes ty,
      False -> ty_var ctxt (Slice v aes) ty
  | ty_Range: forall ctxt v ae1 ae2 ty,
      False -> ty_var ctxt (Range v ae1 ae2) ty
*)

Section TypeExpr.

Variable prog: list (ident * def).

Definition get_def : ident -> option def.
Admitted.

Inductive ty_val: val -> typ -> Prop :=
  | ty_Tup: forall vs tys,
      Forall2 ty_val vs tys ->
      ty_val (Tup vs) (TUP tys)
  | ty_Atom: forall k n,
      N.size_nat n < k ->
      ty_val (Atom k n) (ATOM k).

Inductive ty_expr: context -> expr -> typ -> Prop :=
  | ty_Const: forall ctxt v ty,
      ty_val v ty ->
      ty_expr ctxt (Const v) ty
  | ty_ExpVar: forall ctxt v ty,
      ty_var ctxt v ty ->
      ty_expr ctxt (ExpVar v) ty
  | ty_Tuple: forall ctxt es tys,
      Forall2 (ty_expr ctxt) es tys ->
      ty_expr ctxt (Tuple es) (TUP tys)
  | ty_Not: forall ctxt e ty,
      (* XXX: Not applies to anything, pointwise *)
      ty_expr ctxt e ty ->
      ty_expr ctxt (Not e) ty
  | ty_Shift: forall ctxt op e ae tys tys',
      ty_expr ctxt e (TUP tys) ->
      (* XXX: apply shift on tys, gives tys' *)
      ty_expr ctxt (Shift op e ae) (TUP tys')
  | ty_Log: forall ctxt op e1 e2 ty,
      ty_expr ctxt e1 ty ->
      ty_expr ctxt e2 ty ->
      (* XXX: Logical operations apply to anything, pointwise *)
      ty_expr ctxt (Log op e1 e2) ty
  | ty_Fun: forall ctxt x es def,
      get_def x = Some def ->
      Forall2 (ty_expr ctxt) es (typs_of def.(p_in)) ->
      ty_expr ctxt (Fun x es) (TUP (typs_of def.(p_out))).
(*
  | ty_Arith: forall ctxt op e1 e2 ty,
      ty_expr ctxt e1 ty ->
      ty_expr ctxt e2 ty ->
      (* XXX: only a few types support arithmetic operations *)
      ty_expr ctxt (Arith_op e1 e2) ty.
*)

Fixpoint ctxt_of (x: formals): PM.t typ :=
  match x with
  | [] => PM.empty _
  | (x, formal) :: xs => PM.add (uid x) formal.(t) (ctxt_of xs)
  end.

Inductive ty_deq: context -> deq -> Prop :=
  | ty_Norec : forall ctxt vs e tys,
      Forall2 (ty_var ctxt) vs tys ->
      ty_expr ctxt e (TUP tys) ->
      ty_deq ctxt (Norec vs e).

Definition ty_node (d: def): Prop :=
  match d.(node) with
  | Single n ds =>
    let ctxt := ctxt_of (d.(p_in) ++ d.(p_out) ++ n) in
    Forall (ty_deq ctxt) ds
  | _ => False
  end.

End TypeExpr.

Definition ty_prog (p: prog): Prop :=
  (* XXX: this does not forbid self-definition *)
  forall x d, In (x, d) p -> ty_node p d.
