Require Import Recdef.
Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.NArith.NArith.
Require Import Bool.
Require Import List.
Import ListNotations.

Require Import usuba_AST.
Require Import lib.

(** * Extensional characterisation *)

Inductive dependency (eqs: list deq): expr -> expr -> Prop :=.
(* XXX: [list deq] is a bad representation, I cannot do a lookup *)

Inductive immdep (q: list deq): expr -> expr -> Prop :=.

(*
Inductive immdep (q: equations): expr -> expr -> Prop :=
  | immdep_var_def: forall v,
      immdep q (q v) (Var v)
  | immdep_add_left: forall e1 e2,
      immdep q e1 (Add e1 e2)
  | immdep_add_right: forall e1 e2,
      immdep q e2 (Add e1 e2).
*)

(* A set of equations is schedulable if the immdep ordering is well-founded,
   meaning that there are no cyclic immediate dependencies,
   meaning that all dependency cycles must go through at least one FBY. *)

Definition schedulable_deqs (q: list deq) : Prop := well_founded (immdep q).

Definition schedulable (p: prog): Prop. Admitted.

(** * Syntactic criteria *)

Definition Is_scheduled: prog -> Prop.
Admitted.

(** ** Conservativity *)

Theorem soundness: forall p, Is_scheduled p -> schedulable p.
Admitted.

(** * Decision procedure *)

Definition is_scheduled: prog -> bool.
Admitted.

(** ** Soundness & completeness *)

Lemma is_scheduledP: forall p, reflect (Is_scheduled p) (is_scheduled p).
Admitted.
