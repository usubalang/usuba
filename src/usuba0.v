Require Import usuba_AST.
Require Import List.

Fixpoint is_usuba0_var (v:var) : bool :=
  match v with
  | Var _ => true
  | _     => false
  end.

Fixpoint is_usuba0_expr (e:expr) : bool :=
  match e with
  | Const 1 _ => true
  | Const _ _ => false
  | ExpVar v => is_usuba0_var v
  | Not e => is_usuba0_expr e
  | Log _ e1 e2 => andb (is_usuba0_expr e1) (is_usuba0_expr e2)
  | Fun _ _ l => forallb is_usuba0_expr l
  | Tuple _ => false
  | Shift _ _ _ => false
  end.

Fixpoint is_usuba0_deq (d:deq) : bool :=
  match d with
  | Norec vs e => andb (forallb is_usuba0_var vs)
                      (is_usuba0_expr e)
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