From mathcomp Require Import all_ssreflect all_algebra zmodp.
Set Implicit Arguments.
Unset Strict Implicit.
Unset Printing Implicit Defensive.
Import GRing.Theory.
Local Open Scope ring_scope.


(* Machine word of size k: *)
Definition uint k : Type := 'rV[ bool ]_k.

(* n-sliced format: *)
Record Format := { B : nat ;
                   m : nat ;
                   n : nat ;
                   _ : (0 < B)%N ;
                   _ : (0 < m)%N ;
                   _ : (0 < n)%N ;
                   _ : (B <= m)%N }.

Notation "'u' '<' B '>' m" :=
  (@Build_Format B m 1 (eqxx _) (eqxx _) (eqxx _) (eqxx _))
    (at level 0, B, m at next level).

Notation "'u' '<' B '>' m '[' n ']'" :=
  (@Build_Format B m n (eqxx _) (eqxx _) (eqxx _) (eqxx _))
    (B, m, n at next level).

(*
Notation "'u' '<' B '>' m '[' n1 '][' .. '][' n ']'" :=
  (Build_Format B m  (cons n1 .. (cons n nil) ..))
    (B, m, n1, n at next level).
*)

(* DES takes 64 boolean values: *)
Example des : Format := u < 1 > 1 [ 64 ].
(* AES takes 8 values of 16-bits words manipulated as 16 blocks: *)
Example aes : Format := u < 16 > 16 [ 8 ].
(* Serpent takes 4 values of 32-bits words manipulated as a single block: *)
Example serpent : Format := u < 1 > 32 [ 4 ].

(* SIMD architecture: *)

Record arch := { word_size : nat ;
                 units : nat ;
                 _ : word_size == 0 %[mod units ] ;
                 _ : (0 < units)%N }.

(* AVX256 can vectorize 32 bits operations: *)
Example AVX256_32: arch := @Build_arch 256 (256 %/ 32)%N (eqxx _) (eqxx _).

(* AVX256 can vectorize 8 bits operations: *)
Example AVX256_8: arch := @Build_arch 256 (256 %/ 8)%N (eqxx _) (eqxx _).


Section M.

Variable (machine : arch).
Variable (f: Format).

(* The number of blocks must be compatible with the SIMD architecture *)
Hypothesis compat: (exists k, k > 0 /\ machine.(units) = k * f.(B))%N.

(* Size of an atomic value *)
Definition atom_size : nat := (f.(m) %/ f.(B)).
(* Number of horizontal values *)
Definition row_size : nat := f.(n).
(* Number of vertical values *)
Definition col_size : nat := f.(B).
(* Number of distinct values processed in parallel *)
Definition parallelism : nat := machine.(word_size) %/ (atom_size * row_size).


Hypothesis non_trivial: (0 < parallelism)%N.

(* Source form:

                  +-----------------------------------------------------+     _
                  |                                                     |     /\
          +-----------------------------------------------------+       |    /
       ^  |                                                     |       |   /
     1 !  |                                                     |-------+  / parallelism
       v  |                                                     |         /
          +-----------------------------------------------------+       |/_
           <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>
                           f.(m) * f.(n)
*)

Definition src : Type :=
  'rV[ 'rV[ bool ]_(f.(m) * f.(n)) ]_(parallelism).

(* blocked form:
              +---------------------------------------------------------+       _
              | x_(1,1)^(p)                                             |       /\
              |                                                         +      /
          +---------------+-------------------+-----------------+       |     /
       ^  | x_(1,1)^(1)   |                   | x_(1,B)^(1)     |-------+    /
       !  +---------------+-------------------+-----------------|       |   /
       !  |               |                   |                 |-------+  /
 f.(n) !  +---------------+-------------------+-----------------+         / parallelism
       !  |               |                   |                 |        /
       !  +---------------+-------------------+-----------------+       /
       v  | x_(n,B)^(1)   |                   | x_(n,B)^(1)     |      /
          +---------------+-------------------+-----------------+    |/_
           <~~~~~~~~~~~~~>
              atom_size
           <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>
                             B * atom_size
*)

Definition inter : Type :=
  'rV[ 'M[ uint atom_size ]_(row_size, col_size) ]_(parallelism).

(* bitsliced form:
          +---------------+--+----------------+-----------------+---------------+
       ^  | x_(1,1)^(1)   |..| x_(1,1)^(p)    |                 | x_(n,1)^p     |
       !  +---------------+--+----------------+-----------------+---------------+
     B !  |               |  |                |                 |               |
       !  +---------------+--+----------------+-----------------+---------------+
       v  | x_(1,B)^(1)   |  | x_(1,B)^(p)    |                 | x_(n,B)^p     |
          +---------------+--+----------------+-----------------+---------------+

           <~~~~~~~~~~~~~>
              atom_size
           <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>
                  atom_size * parallelism
           <~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>
                              atom_size * parallelism * f(n)
*)

Definition final : Type := 'M[ uint atom_size ]_(col_size, row_size * parallelism).

Lemma full_throughput : (machine.(word_size) = atom_size * parallelism * f.(n))%N.
unfold parallelism,  atom_size, row_size.
case compat=> [k [H1 H2]].
Search (_ %/ (_ %/ _))%N.
Search (_ %/ _ * _)%N.
rewrite divn_mulAC.
rewrite divnA.

(*Set Printing All.*)

Definition in_bound (i: 'I_row_size)(j: 'I_col_size)(k: 'I_atom_size):
  (i * f.(m) + j * atom_size + k < f.(m) * f.(n))%N.
Proof.
unfold row_size, col_size, word_size, atom_size in *.
Admitted.

Definition to_block (s : 'rV[ bool ]_(f.(m) * f.(n))): 'M[ uint atom_size ]_(row_size, col_size)
  := \matrix_(i , j) \row_k (s ord0 (Ordinal (in_bound i j k))).


Definition split (s : src): inter := map_mx to_block s.

Definition of_block (s : 'M[ uint atom_size ]_(row_size, col_size)): 'rV[ bool ]_(f.(m) * f.(n)).
refine (\row_i (s _ _) ord0 _)%N;
  unfold row_size, col_size, atom_size.
- apply Ordinal with (m := (i %% f.(n))%N);
  apply ltn_pmod;
  destruct f; simpl; assumption.
- apply Ordinal with (m := (i %% f.(B))%N);
  apply ltn_pmod;
  destruct f; simpl; assumption.
- apply Ordinal with (m := (i %% (f.(m) %/ f.(B)))%N);
  apply ltn_pmod;
  destruct f; simpl; rewrite divn_gt0 //.
Defined.

Definition join (i: inter): src := map_mx of_block i.

Lemma split_bij: bijective split.
split with (g := join).
Admitted.

Definition ortho (s : inter): final.
refine (\matrix_(i, j) s ord0 _ _ i).
- apply Ordinal with (m := (j %% parallelism)%N).
  apply ltn_pmod. assumption.
- apply Ordinal with (m := (j %% row_size)%N).
  apply ltn_pmod. unfold row_size.
  destruct f; simpl; assumption.
Defined.

Definition unortho (s: final): inter := \row_k \matrix_(i, j) s j (mxvec_index i k).

Lemma ortho_bij: bijective ortho.
split with (g := unortho).
- move=> x. unfold unortho, ortho.
  apply matrixP=> i j.
  rewrite mxE.
  apply matrixP=> i' j'.
  rewrite mxE.

  apply matrixP=> i'' j''.
  rewrite mxE.
  rewrite !ord1.
  simpl.
Admitted.




End M.

