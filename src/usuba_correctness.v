Require Import Coq.FSets.FMapPositive.
Module PM := Coq.FSets.FMapPositive.PositiveMap.

Require Import Coq.NArith.NArith.
Require Import List.
Import ListNotations.

Require Import usuba_AST.
Require Import usuba_sem.
Require Import usuba_typing.

Lemma sem_exists0: forall prog f fnode ins,
    (* the graph of nodes is well-founded: *)
(*    dependency prog -> *)
    (* the graph of equations in each nodes is well-founded: *)
(*    sch_prog prog -> *)
    (* the program is well-typed: *)
    ty_prog prog ->
    In (f, fnode) prog ->
    (* the input values are well-typed: *)
    Forall2 ty_val ins (typs_of fnode.(p_in)) ->
    exists outs,
        Forall2 ty_val outs (typs_of fnode.(p_out))
     /\ sem_node prog fnode ins outs.
Admitted.

Theorem sem_exists: forall prog f fnode ins,
    ty_prog prog ->
    In (f, fnode) prog ->
    Forall2 ty_val ins (typs_of fnode.(p_in)) ->
    exists outs,
      sem_node prog fnode ins outs.
Proof.
(* By generalization sem_exists0 *)
Admitted.