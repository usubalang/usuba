Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

Require Import usuba_AST.
Require Import lib.



Definition BOTTOM : atom := 0%N.

Definition sem_log_op (op: log_op): N -> N -> N :=
  match op with
  | And => N.land
  | Or => N.lor
  | Xor => N.lxor
  | Andn => lnand atom_size
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

Definition val_lookup (v: val)(k: N)(a: atom): Prop :=
  List.nth_error v (N.to_nat k) = Some a.

Section SemExpr.

Variable prog: PM.t def.

Definition sem_ident (env: PM.t val)(x: ident)(v: val): Prop :=
  PM.find (uid x) env = Some v.

Definition val_mask (v: val)(k1 k2: N): option val :=
  mask v (N.to_nat k1) (N.to_nat k2).

Inductive sem_var (env: PM.t val)(senv: PM.t N): var -> val -> Prop :=
| sem_Var: forall x v,
    sem_ident env x v ->
    sem_var env senv (Var x) v
| sem_Slice: forall x aes ks vx vs,
    sem_var env senv x vx ->
    Forall2 (fun ae k => sem_arith_expr ae senv = Some k) aes ks ->
    Forall2 (fun k v => val_lookup vx k v) ks vs ->
    sem_var env senv (Slice x aes) vs
| sem_Range: forall x ae1 ae2 k1 k2 vx v,
    sem_var env senv x vx ->
    sem_arith_expr ae1 senv = Some k1 ->
    sem_arith_expr ae2 senv = Some k2 ->
    val_mask vx k1 k2 = Some v ->
    sem_var env senv (Range x ae1 ae2) v.

Inductive sem_expr: PM.t val -> PM.t N -> expr -> val -> Prop :=
| sem_Const: forall env senv k ae n v,
    sem_arith_expr ae senv = Some n ->
    val_of_nat k n = v ->
    sem_expr env senv (Const k ae) v
| sem_ExpVar: forall env senv v i,
    sem_var env senv v i ->
    sem_expr env senv (ExpVar v) i
| sem_Tuple: forall env senv es vs v,
    List.Forall2 (sem_expr env senv) es vs ->
    List.concat vs = v ->
    sem_expr env senv (Tuple es) v
| sem_Not: forall env senv e v v',
    sem_expr env senv e v ->
    List.map (fun n => N.lnot n (N.of_nat atom_size)) v = v' ->
    sem_expr env senv (Not e) v'
| sem_Shift: forall env senv op e ae ve k v,
    (* Zero-cost shifts & rotations *)
    sem_expr env senv e ve ->
    sem_arith_expr ae senv = Some k ->
    sem_shift_op op BOTTOM ve (N.to_nat k) = v ->
    sem_expr env senv (Shift op e ae) v
| sem_Log: forall env senv op e1 e2 v1 v2 v,
    sem_expr env senv e1 v1 ->
    sem_expr env senv e2 v2 ->
    map2 (sem_log_op op) v1 v2 = v ->
    sem_expr env senv (Log op e1 e2) v
| sem_Fun: forall env senv f ae es i node ins outs v,
    PM.find (uid f) prog = Some node ->
    sem_arith_expr ae senv = Some i ->
    Forall2 (sem_expr env senv) es ins ->
    sem_node node senv (N.to_nat i) ins outs ->
    List.concat outs = v ->
    sem_expr env senv (Fun f ae es) v
with sem_node: def -> PM.t N -> nat -> list val -> list val -> Prop :=
| sem_Node: forall d senv i ins outs env def var_ins var_outs,
    var_ins = vars_of d.(p_in) ->
    var_outs = vars_of d.(p_out) ->
    Forall2 (sem_ident env) var_ins ins ->
    Forall2 (sem_ident env) var_outs outs ->
    List.nth_error d.(node) i = Some def ->
    sem_def_i def env senv var_ins var_outs ->
    sem_node d senv i ins outs
with sem_def_i : def_i -> PM.t val -> PM.t N -> list ident -> list ident -> Prop :=
| sem_Single: forall senv locals eqs env var_ins var_outs,
    Forall (sem_deq env senv) eqs ->
    sem_def_i (Single locals eqs) env senv var_ins var_outs
| sem_Perm: forall xs env senv tmps tmps' var_ins var_outs,
    Forall2 (sem_ident env) var_ins tmps ->
    Rename tmps (List.map N.to_nat xs) tmps' ->
    Forall2 (sem_ident env) var_outs tmps' ->
    sem_def_i (Perm xs) env senv var_ins var_outs
| sem_Table: forall k xs env senv var_ins v_in n v v_out v_outs var_outs,
    Forall2 (sem_ident env) var_ins v_in ->
    val_to_nat (List.concat v_in) = n ->
    nth_error xs (N.to_nat n) = Some v ->
    val_of_nat k v = v_out ->
    (* XXX: unpleasantly non-constructive spec: *)
    List.concat v_outs = v_out ->
    Forall2 (sem_ident env) var_outs v_outs ->
    sem_def_i (Table k xs) env senv var_ins var_outs
with sem_deq: PM.t val -> PM.t N -> deq -> Prop :=
| sem_Norec: forall env senv xs vs v eq,
    sem_expr env senv eq v ->
    Forall2 (sem_var env senv) xs vs ->
    List.concat vs = v ->
    sem_deq env senv (Norec xs eq)
| sem_Rec: forall x env senv ae1 ae2 eqs i j ij,
    sem_arith_expr ae1 senv = Some i ->
    sem_arith_expr ae2 senv = Some j ->
    seq (N.to_nat i) (N.to_nat j) = ij ->
    List.Forall (fun k =>
      List.Forall (sem_deq env (PM.add (uid x) (N.of_nat k) senv)) eqs) ij ->
    sem_deq env senv (Rec x ae1 ae2 eqs).


End SemExpr.
