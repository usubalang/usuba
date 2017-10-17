Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.ZArith.ZArith.

(*****************************************************************)

(* XXX: lengthy prelude *)

Axiom Zrotl: Z -> Z -> Z.
Axiom Zrotr: Z -> Z -> Z.


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

Inductive val := 
| Base: bool -> val
| Tup: list val -> val.

Definition value := option val.
Definition Env := PM.t value.

(*****************************************************************)

Require Import usuba_AST.


Definition sem_log_op (op: log_op) :=
  match op with
  | And => andb
  | Or => orb
  | Xor => xorb
  | Andn => (fun x y => negb (andb x y))
  end.

Definition sem_arith_op (op: arith_op) :=
   match op with
   | Add => Z.add
   | Mul => Z.mul
   | Sub => Z.sub
   | Div => Z.div
   | Mod => Z.modulo
   end.

Definition sem_shift_op (op: shift_op) := 
  match op with
  | Lshift => Z.shiftl
  | Rshift => Z.shiftr
  | Lrotate => Zrotl
  | Rrotate => Zrotr
  end.

(* Arithmetic expressions, fully-reduced at compile-time *)
Fixpoint sem_arith_expr (ae: arith_expr)(env: PM.t Z): option Z :=
  match ae with
  | Const_e i => Some i
  | Var_e x => PM.find x env
  | Op_e op e1 e2 => let! x := sem_arith_expr e1 env in
                    let! y := sem_arith_expr e2 env in
                    Some (sem_arith_op op x y)
  end.

Inductive sem_var (env: PM.t value): var -> value -> Prop :=.

Inductive sem_expr (env: PM.t value): expr -> value -> Prop :=
(* XXX: problem with const: to which tuple do we compile to? *)
(*| sem_Const: forall i,
    sem_expr (Const i) (Some ?).
*)
| sem_ExpVar: forall v i,
    sem_var env v i ->
    sem_expr env (ExpVar v) i
| sem_Tuple: forall es vs,
    (* XXX: need a suitable definition, taking care of absences *)
    List.Forall2 (sem_expr env) es (List.map Some vs) ->
    sem_expr env (Tuple es) (Some (Tup vs))
(*
| sem_Not: forall e b v,
    sem_expr env e (Base b) ->
    sem_expr env (Not e) (Base (negb b)). (* special case for bitwise not *)
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

*)