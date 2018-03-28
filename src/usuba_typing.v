Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

Require Import usuba_AST.
Require Import lib.

Definition context := PM.t typ.
Definition scontext := PM.t N.

(*
Definition scontext := PM.t (N * N).

Definition bounds_arith_op (op: arith_op)(xmM: N * N)(ymM: N * N): N * N :=
   match op with
   | Add => (N.add (fst xmM) (fst ymM), N.add (snd ymM) (snd ymM))
   | Mul => (N.mul (fst xmM) (fst ymM), N.mul (snd ymM) (snd ymM))
   | Sub => (N.sub (fst xmM) (snd ymM), N.sub (snd xmM) (fst ymM))
   | Div => (N.div (fst xmM) (snd ymM), N.div (snd xmM) (fst ymM))
   | Mod => (0%N, snd ymM)
   end.

Fixpoint bounds_arith_expr (ae: arith_expr)(sctxt: scontext): option (N * N) :=
  match ae with
  | Const_e i => ret! (i, i)
  | Var_e x => PM.find (uid x) sctxt
  | Op_e op e1 e2 => let! xmM := bounds_arith_expr e1 sctxt in
                     let! ymM := bounds_arith_expr e2 sctxt in
                     ret! (bounds_arith_op op xmM ymM)
  end.
*)

Inductive ty_var: context -> scontext -> var -> typ -> Prop :=
  | ty_Var: forall ctxt sctxt i ty,
      PM.find (uid i) ctxt = Some ty ->
      ty_var ctxt sctxt (Var i) ty
  | ty_Slice: forall ctxt sctxt v aes ty ty_v,
      ty_var ctxt sctxt v ty_v ->
      Forall (fun ae =>
                exists n,
                  sem_arith_expr ae sctxt = Some n
                  /\ N.to_nat n < ty_v) aes ->
      List.length aes = ty ->
      ty_var ctxt sctxt (Slice v aes) ty
  | ty_Range: forall ctxt sctxt v ae1 ae2 ty ty_v v1 v2 lower upper,
      ty_var ctxt sctxt v ty_v ->
      sem_arith_expr ae1 sctxt = Some v1 ->
      sem_arith_expr ae2 sctxt = Some v2 ->
      N.min v1 v2 = lower ->
      N.max v1 v2 = upper ->
      N.to_nat upper < ty_v ->
      1 + N.to_nat (N.sub upper lower) = ty ->
      ty_var ctxt sctxt (Range v ae1 ae2) ty.

(* Prove: ty_FOO _ _ x ty -> ty > 0 *)

Section TypeExpr.

Variable prog: PM.t def.

Inductive ty_atom (n: atom): Prop :=
| ty_at:
    N.size_nat n < atom_size ->
    ty_atom n.

Inductive ty_val: val -> typ -> Prop :=
  | ty_Tup: forall vs n,
      Forall ty_atom vs  ->
      List.length vs = n ->
      ty_val vs n.

Definition sum (ks: list nat): nat := fold_right plus 0 ks.

Inductive ty_expr: context -> scontext -> expr -> typ -> Prop :=
  | ty_Const: forall ctxt sctxt k ty ae,
      k = ty ->
      ty_expr ctxt sctxt (Const k ae) ty
  | ty_ExpVar: forall ctxt sctxt v ty,
      ty_var ctxt sctxt v ty ->
      ty_expr ctxt sctxt (ExpVar v) ty
  | ty_Tuple: forall ctxt sctxt es tys ty,
      Forall2 (ty_expr ctxt sctxt) es tys ->
      sum tys = ty ->
      ty_expr ctxt sctxt (Tuple es) ty
  | ty_Not: forall ctxt sctxt e ty,
      ty_expr ctxt sctxt e ty ->
      ty_expr ctxt sctxt (Not e) ty
  | ty_Shift: forall ctxt sctxt op e ae tys,
      ty_expr ctxt sctxt e tys ->
      ty_expr ctxt sctxt (Shift op e ae) tys
  | ty_Log: forall ctxt sctxt op e1 e2 ty,
      ty_expr ctxt sctxt e1 ty ->
      ty_expr ctxt sctxt e2 ty ->
      ty_expr ctxt sctxt (Log op e1 e2) ty
  | ty_Fun: forall ctxt sctxt x ae es def k ix,
      PM.find (uid x) prog = Some def ->
      Forall2 (ty_expr ctxt sctxt) es (typs_of def.(p_in)) ->
      sum (typs_of def.(p_out)) = k ->
      sem_arith_expr ae sctxt = Some ix ->
      N.to_nat ix < List.length def.(node) ->
      ty_expr ctxt sctxt (Fun x ae es) k.

Fixpoint append (x: formals)(ctxt: PM.t typ): PM.t typ :=
  match x with
  | [] => ctxt
  | (x, formal) :: xs => append xs (PM.add (uid x) formal.(t) ctxt)
  end.

Definition ctxt_of x  := append x (PM.empty _).

Inductive ty_deq: context -> scontext -> deq -> Prop :=
  | ty_Norec : forall ctxt sctxt vs e tys ty,
      Forall2 (ty_var ctxt sctxt) vs tys ->
      ty_expr ctxt sctxt e ty ->
      sum tys = ty ->
      ty_deq ctxt sctxt (Norec vs e)
  | ty_Rec: forall ctxt sctxt x ae1 ae2 dl v1 v2 lower upper ks,
      sem_arith_expr ae1 sctxt = Some v1 ->
      sem_arith_expr ae2 sctxt = Some v2 ->
      N.min v1 v2 = lower ->
      N.max v1 v2 = upper ->
      seq (N.to_nat lower) (N.to_nat upper) = ks ->
      Forall (fun k => Forall (ty_deq ctxt (PM.add (uid x) (N.of_nat k) sctxt)) dl) ks ->
      ty_deq ctxt sctxt (Rec x ae1 ae2 dl).

Inductive ty_def_i: context -> scontext -> typ -> typ -> def_i -> Prop :=
  | ty_Single: forall ctxt sctxt locals ds lctxt ty_in ty_out,
      append locals ctxt = lctxt ->
      Forall (ty_deq lctxt sctxt) ds ->
      ty_def_i ctxt sctxt ty_in ty_out (Single locals ds)
  | ty_Perm: forall ctxt sctxt p ty_in ty_out,
      Forall (fun k => N.lt k (N.of_nat ty_in)) p ->
      List.length p = ty_out ->
      ty_def_i ctxt sctxt ty_in ty_out (Perm p)
  | ty_Table: forall ctxt sctxt k xs ty_in ty_out,
      k = ty_out ->
      ty_def_i ctxt sctxt ty_in ty_out (Table k xs).

Definition ty_node (d: def): Prop :=
  let ctxt := ctxt_of (d.(p_in) ++ d.(p_out)) in
  let ty_in := sum (typs_of d.(p_in)) in
  let ty_out := sum (typs_of d.(p_out)) in
  Forall (ty_def_i ctxt (PM.empty _) ty_in ty_out) d.(node).

End TypeExpr.

Definition ty_prog (p: prog): Prop :=
  (* XXX: this does not forbid self-definition *)
  forall x d, PM.MapsTo x d p -> ty_node p d.
