Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

(*****************************************************************)

(* XXX: lengthy prelude *)

Definition fmap {A B} (f: A -> B)(x: option A) : option B :=
  match x with
  | None => None
  | Some i => Some (f i)
  end.

Definition bind {A B} (x: option A)(f : A -> option B): option B :=
  match x with
  | None => None
  | Some i => f i
  end.

Notation "'let!' x ':=' ma 'in' f" := 
  (bind ma (fun x => f)) 
    (at level 200, right associativity).

Notation "'ret!' x" := (Some x)
                         (at level 200).

Notation "'fail!'" := (None)
                         (at level 200).

Inductive val := 
| Atom: bool -> val
| Tup: list val -> val.

Definition value := (*option*) val.
Definition Env := PM.t value.

(*****************************************************************)

Require Import usuba_AST.


Definition sem_log_op (op: log_op): bool -> bool -> bool :=
  match op with
  | And => andb
  | Or => orb
  | Xor => xorb
  | Andn => (fun x y => negb (andb x y))
  end.

Definition sem_arith_op (op: arith_op): N -> N -> N :=
   match op with
   | Add => N.add
   | Mul => N.mul
   | Sub => N.sub
   | Div => N.div
   | Mod => N.modulo
   end.

Definition sem_shift_op {A}(op: shift_op)(d : A)(l: list A)(n: nat): list A :=
  match op with
  | Lshift => let r := skipn n l in
              r ++ repeat d (min n (length l))
  | Rshift => let r := firstn (length l - n) l in
              repeat d (min n (length l)) ++ r
  | Lrotate => let n := Nat.modulo n (length l) in
               let e := firstn n l in
               let r := skipn n l in
               r ++ e
  | Rrotate => let n := Nat.modulo n (length l) in
               let e := firstn (length l - n) l in
               let r := skipn (length l - n) l in
               r ++ e
  end.

Lemma test__Lshift0: sem_shift_op Lshift 0 [1; 2; 3; 4; 5] 0 = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Lshift1: sem_shift_op Lshift 0 [1; 2; 3; 4; 5] 1 = [2; 3; 4; 5; 0].
Proof. trivial. Qed.

Lemma test__Lshift5: sem_shift_op Lshift 0 [1; 2; 3; 4; 5] 5 = [0; 0; 0; 0; 0].
Proof. trivial. Qed.

Lemma test__Lshift6: sem_shift_op Lshift 0 [1; 2; 3; 4; 5] 6 = [0; 0; 0; 0; 0].
Proof. trivial. Qed.

Lemma test__Rshift1: sem_shift_op Rshift 0 [1; 2; 3; 4; 5] 1 = [0; 1; 2; 3; 4].
Proof. trivial. Qed.

Lemma test__Rshift5: sem_shift_op Rshift 0 [1; 2; 3; 4; 5] 5 = [0; 0; 0; 0; 0].
Proof. trivial. Qed.

Lemma test__Rshift6: sem_shift_op Rshift 0 [1; 2; 3; 4; 5] 6 = [0; 0; 0; 0; 0].
Proof. trivial. Qed.


Lemma test__Lrotate0: sem_shift_op Lrotate 0 [1; 2; 3; 4; 5] 0 = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Lrotate1: sem_shift_op Lrotate 0 [1; 2; 3; 4; 5] 1 = [2; 3; 4; 5; 1].
Proof. trivial. Qed.

Lemma test__Lrotate4: sem_shift_op Lrotate 0 [1; 2; 3; 4; 5] 4 = [5; 1; 2; 3; 4].
Proof. trivial. Qed.

Lemma test__Lrotate5: sem_shift_op Lrotate 0 [1; 2; 3; 4; 5] 5 = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Lrotate6: sem_shift_op Lrotate 0 [1; 2; 3; 4; 5] 6 = [2; 3; 4; 5; 1].
Proof. trivial. Qed.

Lemma test__Rrotate1: sem_shift_op Rrotate 0 [1; 2; 3; 4; 5] 1 = [5; 1; 2; 3; 4].
Proof. trivial. Qed.

Lemma test__Rrotate4: sem_shift_op Rrotate 0 [1; 2; 3; 4; 5] 4 = [2; 3; 4; 5; 1].
Proof. trivial. Qed.

Lemma test__Rrotate5: sem_shift_op Rrotate 0 [1; 2; 3; 4; 5] 5 = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Rrotate6: sem_shift_op Rrotate 0 [1; 2; 3; 4; 5] 6 = [5; 1; 2; 3; 4].
Proof. trivial. Qed.


(* Arithmetic expressions, fully-reduced at compile-time *)
Fixpoint sem_arith_expr (ae: arith_expr)(env: PM.t N): option N :=
  match ae with
  | Const_e i => ret! i
  | Var_e x => PM.find (uid x) env
  | Op_e op e1 e2 => let! x := sem_arith_expr e1 env in
                    let! y := sem_arith_expr e2 env in
                    ret! (sem_arith_op op x y)
  end.

Print var.

Definition val_lookup (v: val)(k: N): option val :=
  match v with
  | Atom _ => None
  | Tup xs => List.nth_error xs (N.to_nat k)
  end.

Fixpoint mask {A}(l: list A)(k1 k2: nat): option (list A) :=
  match k2 with
  | 0 => ret! []
  | S k2 => 
    match k1 with
    | S k1 => match l with
             | [] => fail!
             | x :: xs => mask xs k1 k2
             end
    | 0 => match l with
          | [] => fail!
          | x :: xs => 
            let! xs := mask xs 0 k2 in
            ret! (x :: xs)
          end
    end
  end.

Lemma test__mask: mask [0; 1; 2; 3; 4; 5; 6; 7] 2 5 = Some [2; 3; 4].
Proof. auto. Qed.

Definition val_mask (v: val)(k1 k2: N): option val :=
  match v with
  | Atom _ => None
  | Tup xs => fmap Tup (mask xs (N.to_nat k1) (N.to_nat k2))
  end.

Section SemExpr.

Variable prog: PM.t def.
Variable senv: PM.t N.

Inductive sem_var (env: PM.t value): var -> value -> Prop :=
| sem_Var: forall x v,
    PM.find (uid x) env = Some v ->
    sem_var env (Var x) v
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
    sem_var env (Range x ae1 ae2) v.

Inductive sem_expr: PM.t value -> expr -> value -> Prop :=
(* XXX: problem with const: to which tuple do we compile to? *)
(*| sem_Const: forall i,
    sem_expr (Const i) (Some ?).
*)
| sem_ExpVar: forall env v i,
    sem_var env v i ->
    sem_expr env (ExpVar v) i
| sem_Tuple: forall env es vs,
    List.Forall2 (sem_expr env) es vs ->
    sem_expr env (Tuple es) (Tup vs)
| sem_Not: forall env e b,
    sem_expr env e (Atom b) ->
    sem_expr env (Not e) (Atom (negb b))
| sem_Shift: forall env op e ae k ve v,
    sem_expr env e (Tup ve) ->
    sem_arith_expr ae senv = Some k ->
    sem_shift_op op (Atom false) ve (N.to_nat k) = v ->
    sem_expr env (Shift op e ae) (Tup v)
| sem_Log: forall env op e1 e2 b1 b2 v,
    sem_expr env e1 (Atom b1) ->
    sem_expr env e2 (Atom b2) ->
    sem_log_op op b1 b2 = v ->
    sem_expr env (Log op e1 e2) (Atom v)
| sem_Fun: forall env f es node vs v,
    PM.find (uid f) prog = Some node ->
    Forall2 (sem_expr env) es vs ->
    sem_node node vs v ->
    sem_expr env (Fun f es) v
with sem_node: def -> list value -> value -> Prop :=
 (* XXX: stopped here *).