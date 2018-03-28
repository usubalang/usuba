Require Import Coq.NArith.NArith.

Require Import List.
Import ListNotations.


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


Fixpoint pos_to_list (k: nat)(p: positive): list bool :=
  match k with
  | 0 => []
  | S k =>
    match p with
    | xI p => true :: pos_to_list k p
    | xO p => false :: pos_to_list k p
    | xH => true :: repeat false k
    end
  end.

Definition to_list (k: nat)(n: N): list bool :=
  match n with
  | N0 => repeat false k
  | Npos p => pos_to_list k p
  end.

Lemma test__to_list15: to_list 8 12 =
                       [false; false; true; true; false; false; false; false].
Proof. trivial. Qed.

Definition lnand (k: nat) (x y: N): N := N.lnot (N.land x y) (N.of_nat k).

Definition rotl {A}(n: nat)(l: list A) :=
  skipn n l ++ firstn n l.

Definition rotr {A}(n: nat)(l: list A) :=
  rotl (length l - n) l.

Definition shl {A}(n: nat)(d: A)(l: list A): list A :=
  skipn n l ++ repeat d (min n (length l)).

Definition shr {A}(n: nat)(d: A)(l: list A): list A :=
  repeat d (min n (length l)) ++ firstn (length l - n) l.

Lemma test__Lshift0: shl 0 0 [1; 2; 3; 4; 5] = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Lshift1: shl 1 0 [1; 2; 3; 4; 5] = [2; 3; 4; 5; 0].
Proof. trivial. Qed.

Lemma test__Lshift5: shl 5 0 [1; 2; 3; 4; 5] = [0; 0; 0; 0; 0].
Proof. trivial. Qed.

Lemma test__Lshift6: shl 6 0 [1; 2; 3; 4; 5] = [0; 0; 0; 0; 0].
Proof. trivial. Qed.

Lemma test__Rshift1: shr 1 0 [1; 2; 3; 4; 5] = [0; 1; 2; 3; 4].
Proof. trivial. Qed.

Lemma test__Rshift5: shr 5 0 [1; 2; 3; 4; 5] = [0; 0; 0; 0; 0].
Proof. trivial. Qed.

Lemma test__Rshift6: shr 6 0 [1; 2; 3; 4; 5] = [0; 0; 0; 0; 0].
Proof. trivial. Qed.


Lemma test__Lrotate0: rotl 0 [1; 2; 3; 4; 5] = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Lrotate1: rotl 1 [1; 2; 3; 4; 5] = [2; 3; 4; 5; 1].
Proof. trivial. Qed.

Lemma test__Lrotate4: rotl 4 [1; 2; 3; 4; 5] = [5; 1; 2; 3; 4].
Proof. trivial. Qed.

Lemma test__Lrotate5: rotl 5 [1; 2; 3; 4; 5] = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Lrotate6: rotl 6 [1; 2; 3; 4; 5] = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Rrotate1: rotr 1 [1; 2; 3; 4; 5] = [5; 1; 2; 3; 4].
Proof. trivial. Qed.

Lemma test__Rrotate4: rotr 4 [1; 2; 3; 4; 5] = [2; 3; 4; 5; 1].
Proof. trivial. Qed.

Lemma test__Rrotate5: rotr 5 [1; 2; 3; 4; 5] = [1; 2; 3; 4; 5].
Proof. trivial. Qed.

Lemma test__Rrotate6: rotr 6 [1; 2; 3; 4; 5] = [1; 2; 3; 4; 5].
Proof. trivial. Qed.


Fixpoint mask_up {A}(l: list A)(k1 k2: nat): option (list A) :=
  match k2 with
  | 0 =>
    match l with
    | [] => fail!
    | x :: _ => ret! (x :: [])
    end
  | S k2 =>
    match k1 with
    | S k1 => match l with
             | [] => fail!
             | x :: xs => mask_up xs k1 k2
             end
    | 0 => match l with
          | [] => fail!
          | x :: xs =>
            let! xs := mask_up xs 0 k2 in
            ret! (x :: xs)
          end
    end
  end.

Fixpoint mask_down {A}(l: list A)(k1 k2: nat): option (list A) :=
  let n := List.length l - 1 in
  let! r := mask_up (List.rev l) (n - k1) (n - k2) in
  ret! r.

Definition mask {A}(l: list A)(k1 k2: nat): option (list A) :=
  if Nat.ltb k1 k2 then mask_up l k1 k2
  else mask_down l k1 k2.

Lemma test__mask_up: mask_up [0; 1; 2; 3; 4; 5; 6; 7] 2 5 = Some [2; 3; 4; 5].
Proof. auto. Qed.

Lemma test__mask_down: mask_down [0; 1; 2; 3; 4; 5; 6; 7] 5 2 = Some [5; 4; 3; 2].
Proof. auto. Qed.

Lemma test__mask_down2: mask_down [0] 0 0 = Some [0].
Proof. auto. Qed.

Lemma test__mask1: mask [0; 1; 2; 3; 4; 5; 6; 7] 2 5 = Some [2; 3; 4; 5].
Proof. auto. Qed.

Lemma test__mask2: mask [0; 1; 2; 3; 4; 5; 6; 7] 5 2 = Some [5; 4; 3; 2].
Proof. auto. Qed.

Inductive Forall3 {A B C : Type} (R : A -> B -> C -> Prop) : list A -> list B -> list C -> Prop :=
    Forall3_nil : Forall3 R [] [] []
  | Forall3_cons : forall (x : A) (y : B)(z : C) (l : list A) (l' : list B)(l'' : list C),
                   R x y z -> Forall3 R l l' l'' -> Forall3 R (x :: l) (y :: l') (z :: l'').


Definition map2 {X Y Z} (f : X -> Y -> Z) : list X -> list Y -> list Z.
Admitted.

Inductive Rename {A} (xs : list A) : list nat -> list A -> Prop :=
| Rename_nil: Rename xs [] []
| Rename_cons: forall n ns y ys,
    Some y = nth_error xs n ->
    Rename xs ns ys ->
    Rename xs (n :: ns) (y :: ys).
