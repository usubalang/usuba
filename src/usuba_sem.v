Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

Require Import usuba_AST.
Require Import lib.



Definition BOTTOM : val := Tup [].

Definition sem_log_op (op: log_op)(k: nat): N -> N -> N :=
  match op with
  | And => N.land
  | Or => N.lor
  | Xor => N.lxor
  | Andn => lnand k
  end.

Definition sem_arith_op (op: arith_op): N -> N -> N :=
   match op with
   | Add => N.add
   | Mul => N.mul
   | Sub => N.sub
   | Div => N.div
   | Mod => N.modulo
   end.

(* identity for [n >= length l] *)
Definition sem_shift_op {A}(op: shift_op)(d : A)(l: list A)(n: nat): list A :=
  match op with
  | Lshift => shl n d l
  | Rshift => shr n d l
  | Lrotate => rotl n l
  | Rrotate => rotr n l
  end.

(* Arithmetic expressions, fully-reduced at compile-time *)
Fixpoint sem_arith_expr (ae: arith_expr)(env: PM.t N): option N :=
  match ae with
  | Const_e i => ret! i
  | Var_e x => PM.find (uid x) env
  | Op_e op e1 e2 => let! x := sem_arith_expr e1 env in
                     let! y := sem_arith_expr e2 env in
                     ret! (sem_arith_op op x y)
  end.

Definition val_lookup (v: val)(k: N): val :=
  match v with
  | Atom _ _ => BOTTOM
  | Tup xs => List.nth (N.to_nat k) xs BOTTOM
  end.

Section SemExpr.

Variable prog: list (ident * def).
(* XXX: restore static environment for code expansions *)
(*Variable senv: PM.t N. *)

Definition get_def : ident -> option def.
Admitted.

Definition sem_ident (env: PM.t val)(x: ident)(v: val): Prop :=
  PM.find (uid x) env = Some v.

Definition val_mask (v: val)(k1 k2: N): option val :=
  match v with
  | Atom _ _ => None
  | Tup xs => fmap Tup (mask xs (N.to_nat k1) (N.to_nat k2))
  end.

Inductive sem_var (env: PM.t val): var -> val -> Prop :=
| sem_Var: forall x v,
    sem_ident env x v ->
    sem_var env (Var x) v.
(*
| sem_Slice: forall x aes ks vx vs,
    sem_var env x vx ->
    Forall2 (fun ae k => sem_arith_expr ae senv = Some k) aes ks ->
    Forall2 (fun k v => val_lookup vx k = Some v) ks vs ->
    sem_var env (Slice x aes) (Tup vs)
| sem_Range: forall x ae1 ae2 k1 k2 vx v,
    sem_var env x vx ->
    sem_arith_expr ae1 senv = Some k1 ->
    sem_arith_expr ae2 senv = Some k2 ->
    val_mask vx k1 k2 = Some v ->
    sem_var env (Range x ae1 ae2) v.*)

Inductive lift1 (f : nat -> N -> N): val -> val -> Prop :=
| lift1_Atom: forall k n n',
    f k n = n' ->
    lift1 f (Atom k n) (Atom k n')
| lift1_Tup: forall ns ns',
    Forall2 (lift1 f) ns ns' ->
    lift1 f (Tup ns) (Tup ns').

Inductive lift2 (f : nat -> N -> N -> N): val -> val -> val -> Prop :=
| lift2_Atom: forall k n1 n2 n3,
    f k n1 n2 = n3 ->
    lift2 f (Atom k n1) (Atom k n2) (Atom k n3)
| lift2_Tup: forall ns1 ns2 ns3,
    Forall3 (lift2 f) ns1 ns2 ns3 ->
    lift2 f (Tup ns1) (Tup ns2) (Tup ns3).

Inductive sem_expr: PM.t val -> expr -> val -> Prop :=
| sem_Const: forall env v,
    sem_expr env (Const v) v
| sem_ExpVar: forall env v i,
    sem_var env v i ->
    sem_expr env (ExpVar v) i
| sem_Tuple: forall env es vs,
    List.Forall2 (sem_expr env) es vs ->
    sem_expr env (Tuple es) (Tup vs)
| sem_Not: forall env e v v',
    sem_expr env e v ->
    lift1 (fun k n => N.lnot n (N.of_nat k)) v v' ->
    sem_expr env (Not e) v'
| sem_Shift: forall env op e ae k ve v,
    (* Zero-cost shifts & rotations *)
    sem_expr env e (Tup ve) ->
(* XXX: restore   sem_arith_expr ae senv = Some k -> *)
    sem_shift_op op BOTTOM ve (N.to_nat k) = v ->
    sem_expr env (Shift op e ae) (Tup v)
| sem_Log: forall env op e1 e2 v1 v2 v,
    sem_expr env e1 v1 ->
    sem_expr env e2 v2 ->
    lift2 (sem_log_op op) v1 v2 v ->
    sem_expr env (Log op e1 e2) v
| sem_Fun: forall env f es node ins outs,
    get_def f = Some node ->
    Forall2 (sem_expr env) es ins ->
    sem_node node ins outs ->
    sem_expr env (Fun f es) (Tup outs)
with sem_node: def -> list val -> list val -> Prop :=
| sem_Single: forall d locals eqs ins outs env,
    d.(node) = Single locals eqs ->
    Forall2 (sem_ident env) (vars_of d.(p_in)) ins ->
    Forall2 (sem_ident env) (vars_of d.(p_out)) outs ->
    Forall (sem_deq env) eqs ->
    sem_node d ins outs
with sem_deq: PM.t val -> deq -> Prop :=
| sem_Norec: forall env xs vs eq,
    (* XXX: perform eta-expansion instead, to handle singletons *)
    sem_expr env eq (Tup vs) ->
    Forall2 (sem_var env) xs vs ->
    sem_deq env (Norec xs eq).

End SemExpr.
