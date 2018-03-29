Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

Require Import lib.
Require Import usuba_AST.
Require Import usuba_sem.
Require Import usuba0.

(** * Relational semantics *)

Section SemExpr.

Variable prog: PM.t def.

Definition sem_ident0 := @sem_ident atom.

Inductive sem_var0 (env: PM.t atom): var -> atom -> Prop :=
| sem_Var: forall x v,
    sem_ident0 env x v ->
    sem_var0 env (Var x) v.

Inductive sem_expr0: PM.t atom -> expr -> atom -> Prop :=
| sem_Const: forall env n,
    sem_expr0 env (Const 1 (Const_e n)) n
| sem_ExpVar: forall env v i,
    sem_var0 env v i ->
    sem_expr0 env (ExpVar v) i
| sem_Not: forall env e v v',
    sem_expr0 env e v ->
    N.lnot v (N.of_nat atom_size) = v' ->
    sem_expr0 env (Not e) v'
| sem_Log: forall env op e1 e2 v1 v2 v,
    sem_expr0 env e1 v1 ->
    sem_expr0 env e2 v2 ->
    sem_log_op op v1 v2 = v ->
    sem_expr0 env (Log op e1 e2) v
with sem_node0: def -> nat -> list atom -> list atom -> Prop :=
| sem_Node: forall d i ins outs env def var_ins var_outs,
    var_ins = vars_of d.(p_in) ->
    var_outs = vars_of d.(p_out) ->
    Forall2 (sem_ident0 env) var_ins ins ->
    Forall2 (sem_ident0 env) var_outs outs ->
    List.nth_error d.(node) i = Some def ->
    sem_def_i0 def env ->
    sem_node0 d i ins outs
with sem_def_i0 : def_i -> PM.t atom -> Prop :=
| sem_Single: forall locals eqs env,
    Forall (sem_deq0 env) eqs ->
    sem_def_i0 (Single locals eqs) env
with sem_deq0: PM.t atom -> deq -> Prop :=
| sem_NorecExpr: forall env x v eq,
    sem_expr0 env eq v ->
    sem_var0 env x v ->
    sem_deq0 env (Norec [x] eq)
| sem_NorecFun: forall env xs f es i node ins outs,
    PM.find (uid f) prog = Some node ->
    Forall2 (sem_expr0 env) es ins ->
    sem_node0 node (N.to_nat i) ins outs ->
    Forall2 (sem_var0 env) xs outs ->
    sem_deq0 env (Norec xs (Fun f (Const_e i) es)).

End SemExpr.

Section SemProg.

Variable (main: PM.key).

Definition sem_prog0 (p: prog)(ins: list atom)(outs: list atom) :=
  forall def, PM.find main p = Some def -> sem_node0 p def 0 ins outs.

End SemProg.

(** ** Conservativity *)

Definition lift (a: atom): val := [ a ].

Theorem semantics_embedding:
  forall p main ins outs insN outsN,
    Is_usuba0 p ->
    List.map lift insN = ins ->
    List.map lift outsN = outs ->
    sem_prog main p ins outs -> sem_prog0 main p insN outsN.
Admitted.

(** * Imperative semantics *)

Section ImpExpr.

Variable prog: PM.t def.

Fixpoint adds {A} (xs: list ident)(vs: list A)(e: PM.t A): PM.t A :=
  match xs, vs with
  | [], _ => e
  | _, [] => e
  | x :: xs, v :: vs => adds xs vs (PM.add (uid x) v e)
  end.

Definition get_ident (v: var): option ident :=
  match v with
  | Var x => Some x
  | _ => None
  end.

Fixpoint get_idents (vs: list var): option (list ident) :=
  match vs with
  | [] => ret! []
  | v :: vs => let! v' := get_ident v in
              let! vs' := get_idents vs in
              ret! (v' :: vs')
  end.

Inductive imp_node: def -> nat -> list atom -> list atom -> Prop :=
| imp_Node: forall d i ins outs env env' def var_ins var_outs,
    var_ins = vars_of d.(p_in) ->
    Forall2 (sem_ident0 env) var_ins ins ->
    List.nth_error d.(node) i = Some def ->
    imp_def_i def env env' ->
    Forall2 (sem_ident0 env') var_outs outs ->
    imp_node d i ins outs
with imp_def_i : def_i -> PM.t atom -> PM.t atom -> Prop :=
| imp_Single: forall locals eqs env env',
    imp_deqs env eqs env' ->
    imp_def_i (Single locals eqs) env env'
with imp_deqs: PM.t atom -> list deq -> PM.t atom -> Prop :=
| imp_Seq: forall env env' env'' eq eqs,
    imp_deq env eq env' ->
    imp_deqs env' eqs env'' ->
    imp_deqs env (eq :: eqs) env''
| imp_Eps: forall env,
    imp_deqs env [] env
with imp_deq: PM.t atom -> deq -> PM.t atom -> Prop :=
| imp_NorecExpr: forall env env' x x' v eq,
    sem_expr0 prog env eq v ->
    get_ident x = Some x' ->
    PM.add (uid x') v env = env' ->
    imp_deq env (Norec [x] eq) env'
| imp_NorecFun: forall env env' xs xs' f es i node ins outs,
    PM.find (uid f) prog = Some node ->
    Forall2 (sem_expr0 prog env) es ins ->
    imp_node node (N.to_nat i) ins outs ->
    get_idents xs = Some xs' ->
    adds xs' outs env = env' ->
    imp_deq env (Norec xs (Fun f (Const_e i) es)) env'.

End ImpExpr.

Section ImpProg.

Variable (main: PM.key).

Definition imp_prog0 (p: prog)(ins: list atom)(outs: list atom) :=
  forall def, PM.find main p = Some def -> imp_node p def 0 ins outs.

End ImpProg.

(** * Relational to imperative semantics *)

Require Import usuba_typing.
Require Import usuba0_scheduling.


Lemma refinement_semantics:
  forall p main ins outs,
    Is_usuba0 p ->
    imp_prog0 main p ins outs -> sem_prog0 main p ins outs.
Admitted.

Lemma constructive_semantics:
  forall p main ins outs,
    Is_usuba0 p -> ty_prog p -> Is_scheduled p ->
    imp_prog0 main p ins outs.
Admitted.


Theorem existence_semantics:
  forall p main ins outs,
    Is_usuba0 p -> ty_prog p -> Is_scheduled p ->
    sem_prog0 main p ins outs.
Proof.
intros.
apply refinement_semantics; auto.
apply constructive_semantics; auto.
Qed.