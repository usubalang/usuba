Require Import usuba_AST.
Require Import List.

Fixpoint is_usuba0_var (v:var) : bool :=
  match v with
  | Var _ => true
  | _     => false
  end.

Fixpoint is_usuba0_expr (e:expr) : bool :=
  match e with
  | Const 0 | Const 1 => true
  | ExpVar v => is_usuba0_var v
  | Not e => is_usuba0_expr e
  | Log _ e1 e2 => andb (is_usuba0_expr e1) (is_usuba0_expr e2)
  (* "forall" instead of "fold_left && map" ? *)
  | Fun _ l => fold_left andb (map is_usuba0_expr l) true
  | _ => false
  end.

Fixpoint is_usuba0_deq (d:deq) : bool :=
  match d with
  | Norec vs e => andb (fold_left andb (map is_usuba0_var vs) true)
                       (is_usuba0_expr e)
  | _ => false
  end.

Fixpoint is_usuba0_p (p:p) : bool :=
  fold_left andb (map (fun x => match x with
                                | (_,Bool,_) => true
                                | _    => false
                                end) p) true.

Fixpoint is_usuba0_defi (d:def_i) : bool :=
  match d with
  | Single p ds => andb (is_usuba0_p p)
                        (fold_left andb (map is_usuba0_deq ds) true)
  | _ => false
  end.

Fixpoint is_usuba0_def (d:def) : bool :=
  andb (is_usuba0_defi (node d))
       (andb (is_usuba0_p (p_in d))
             (is_usuba0_p (p_out d))).

Fixpoint is_usuba0_prog (p:prog) : bool :=
  fold_left andb (map is_usuba0_def (nodes p)) true.