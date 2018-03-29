Require Import usuba_AST.
Require Import Bool.
Require Import List.
Import ListNotations.

(** * Specification *)

Inductive Is_usuba0_var : var -> Prop :=
  Iuv_Var: forall x,
    Is_usuba0_var (Var x).

Inductive Is_usuba0_expr : expr -> Prop :=
  (* XXX: complete *)
  .

Inductive Is_usuba0_deq : deq -> Prop :=
  (* XXX: complete *)
  .

Inductive Is_usuba0_formal : ident * formal -> Prop :=
  (* XXX: complete *)
  .

Definition Is_usuba0_formals (p:formals) : Prop :=
  Forall Is_usuba0_formal p.

Inductive Is_usuba0_defi : def_i -> Prop :=
  (* XXX: complete *)
  .

Inductive Is_usuba0_def : def -> Prop :=
  (* XXX: complete *)
  .

Definition Is_usuba0 (p : prog) : Prop :=
  forall x d, PM.MapsTo x d p -> Is_usuba0_def d.

(** * Decision procedure *)

Fixpoint is_usuba0_var (v:var) : bool :=
  match v with
  | Var _ => true
  | _     => false
  end.

Fixpoint is_usuba0_expr (e:expr) : bool :=
  match e with
  | Const 1 (Const_e _) => true
  | ExpVar v => is_usuba0_var v
  | Not e => is_usuba0_expr e
  | Log _ e1 e2 => andb (is_usuba0_expr e1) (is_usuba0_expr e2)
  | Const _ _ => (* forbid non-atomic constants *) false
  | Fun _ _ _ => (* forbid nested function calls *) false
  | Tuple _ => (* tuples must have been inlined *) false
  | Shift _ _ _ => (* shifts must have been expanded *) false
  end.

Fixpoint is_usuba0_deq (d:deq) : bool :=
  match d with
  | Norec vs (Fun f (Const_e i) l) =>
    (* XXX: make sure that [length vs] is exactly equal to output type of [f]? *)
    andb (forallb is_usuba0_var vs)
         (forallb is_usuba0_expr l)
  | Norec [v] e => andb (is_usuba0_var v)
                       (is_usuba0_expr e)
  | Norec _ _ => false
  | Rec _ _ _ _ => false
  end.

Fixpoint is_usuba0_formal (p: (ident * formal)): bool :=
  match (snd p).(t) with
  | 1 => true
  | _ => false
  end.

Fixpoint is_usuba0_formals (p:formals) : bool :=
  forallb is_usuba0_formal p.

Fixpoint is_usuba0_defi (d:def_i) : bool :=
  match d with
  | Single p ds => andb (is_usuba0_formals p)
                       (forallb is_usuba0_deq ds)
  | Table _ _ => false
  | Perm _ => false
  end.

Fixpoint is_usuba0_def (d:def) : bool :=
  andb (forallb is_usuba0_defi d.(node))
       (andb (is_usuba0_formals d.(p_in))
             (is_usuba0_formals d.(p_out))).

Fixpoint is_usuba0 (p:prog) : bool :=
  forallb (fun ip => is_usuba0_def (snd ip)) (PM.elements p).

(** * Soundness & completeness of decision procedure *)

Lemma is_usuba0_varP: forall v, reflect (Is_usuba0_var v) (is_usuba0_var v).
Admitted.

Lemma is_usuba0_exprP: forall e, reflect (Is_usuba0_expr e) (is_usuba0_expr e).
Admitted.

Lemma is_usuba0_deqP: forall d, reflect (Is_usuba0_deq d) (is_usuba0_deq d).
Admitted.

Lemma is_usuba0_formalP: forall p, reflect (Is_usuba0_formal p) (is_usuba0_formal p).
Admitted.

Lemma is_usuba0_formalsP: forall p, reflect (Is_usuba0_formals p) (is_usuba0_formals p).
Admitted.

Lemma is_usuba0_defiP: forall d, reflect (Is_usuba0_defi d) (is_usuba0_defi d).
Admitted.

Lemma is_usuba0_defP: forall d, reflect (Is_usuba0_def d) (is_usuba0_def d).
Admitted.

Theorem is_usuba0P: forall p, reflect (Is_usuba0 p) (is_usuba0 p).
Admitted.