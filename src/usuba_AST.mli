(** AST module

    Some types disappear along the compilation (mainly {!def_or_inc} and the [Multiple], [Perm] and [Table] constructors from {!def_i} that are all transformed in [Single].
 *)

(** {1 AST} *)

(** {2 Ident} *)

type ident = Ident.t
(** Import from {!Ident} module *)

(** {2 Operators} *)

type log_op = And | Or | Xor | Andn | Masked of log_op
type arith_op = Add | Mul | Sub | Div | Mod

type shift_op =
  | Lshift
  | Rshift
  | RAshift  (** arithmetic right shift *)
  | Lrotate
  | Rrotate

type arith_expr =
  | Const_e of int
  | Var_e of ident
  | Op_e of arith_op * arith_expr * arith_expr

(** {2 Types} *)

type dir =
  | Hslice
  | Vslice
  | Bslice
  | Natdir  (** Special direction for Nat *)
  | Varslice of ident  (** Variable *)
  | Mslice of int  (** Generalized m-slicing *)

type mtyp =
  | Mint of int
  | Mnat  (** Special m for Nat *)
  | Mvar of ident  (** variable *)

type typ = Nat | Uint of dir * mtyp * int | Array of typ * arith_expr

(** {2 Variables in expressions} *)

(** Use of variables in expressions
    - [Var id] a simple variable [id]
    - [Index a i] an array access [a.[i]]
    - [Range a b e] an array range [a.[b..e]]
    - [Slice a [i1; ...; ik]] slices of an array [a.[i1]; ...; a.[ik]]
 *)
type var =
  | Var of ident
  | Index of var * arith_expr
  | Range of var * arith_expr * arith_expr
  | Slice of var * arith_expr list

(** {2 Expressions} *)

(* XXX: factorize operations in a single case *)

(** The type of expressions *)
type expr =
  | Const of int * typ option
  | ExpVar of var
  | Tuple of expr list
  | Not of expr  (** special case for bitwise not *)
  | Log of log_op * expr * expr
  | Arith of arith_op * expr * expr
  | Shift of shift_op * expr * arith_expr
  | Shuffle of var * int list
  | Bitmask of expr * arith_expr
  | Pack of expr * expr * typ option
  | Fun of ident * expr list
  | Fun_v of ident * arith_expr * expr list  (** nodes arrays *)

type stmt_opt = Unroll | No_unroll | Pipelined | Safe_exit

(** {2 Equation} *)

(** The type of equations:
    - [Eqn] a simple equation ({i i.e. [x = a + b]})
    - [Loop _ start stop body _] a for loop from [start] to [stop] of [Eqn] or [Loop]
 *)
type deq_i =
  | Eqn of var list * expr * bool
  | Loop of {
      id : ident;
      start : arith_expr;
      stop : arith_expr;
      body : deq list;
      opts : stmt_opt list;
    }

and deq = {
  content : deq_i;
  orig : (ident * deq_i) list;
      (** A list of functions from which this deq was inlined (and
          the original deqs from those functions) *)
}
(** A wrapper around {!deq_i} to memorize its history if it has been inlined *)

(** {2 Variable declarations} *)

type var_d_opt = Pconst | PlazyLift

type var_d = {
  vd_id : ident;
  vd_typ : typ;
  vd_opts : var_d_opt list;
  vd_orig : (ident * var_d) list;
      (** A list of functions from where this variable was inlined *)
}

type p = var_d list

(** {2 Nodes} *)

type def_i =
  | Single of p * deq list  (** Regular node *)
  | Perm of int list  (** Permutation *)
  | Table of int list  (** Lookup table *)
  | Multiple of def_i list  (** Array of definitions *)

(** Type used to tell the compiler what to do with this node:
    - [Inline] will force the compiler to inline the node
    - [No_inline] will prevent the compiler from inlining the node
    - [Interleave d] will tell the compiler to interleave this node with a factor of [d]
    - [No_opt] unused option
    - [Is_table] unused option
 *)
type def_opt = Inline | No_inline | Interleave of int | No_opt | Is_table

type def = { id : ident; p_in : p; p_out : p; opt : def_opt list; node : def_i }
(** Representation of a node:

    - [id] is the identifier of the node
    - [p_in] is a list of {!var_d} representing the inputs of the node
    - [p_out] is a list of {!var_d} representing the outputs of the node
    - [opt] is a list of options that are used by the compiler to optimize/normalize the node
    - [node] is the content of the node represented as a {!def_i}
 *)

(** {2 Intermediate representation} *)

(** Type used as a temporary representation *)
type def_or_inc = Def of def | Inc of string

(** {2 Root} *)

type prog = { nodes : def list }

(** {1 Printing} *)

val pp_def : Format.formatter -> def -> unit
val pp_def_or_inc : Format.formatter -> def_or_inc -> unit
val pp_deq_i : Format.formatter -> deq_i -> unit
val pp_deq : Format.formatter -> deq -> unit
val pp_prog : Format.formatter -> prog -> unit
val show_prog : prog -> string

(** {1 S-expression} *)

val sexp_of_def : def -> Sexplib.Sexp.t
val sexp_of_def_or_inc : def_or_inc -> Sexplib.Sexp.t
val sexp_of_deq_i : deq_i -> Sexplib.Sexp.t
val sexp_of_prog : prog -> Sexplib.Sexp.t

(** {1 Builtin functions} *)

val refresh : ident
val print : ident
val refr : ident
val rand : ident

(** {1 Equality checks} *)

val alpha_equal_prog : prog -> prog -> bool
(** [alpha_equal_prog p1 p2] returns [true] if [p1] and [p2] are equal modulo alpha-renaming and [false] otherwise.

    This function should be used when you're checking the equality between two programs that haven't been generated from the same run. If you want to check the equality between two programs that were generated during the same run, you should use {!equal_prog}
 *)

val equal_prog : prog -> prog -> bool
(** [equal_prog p1 p2] returns [true] if [p1] and [p2] are equal and [false] otherwise.

    Alpha renaming is not considered here, meaning that if two identifiers are different where they are expected to be equal, this function will return [false]. The same is true for the rest of the [equal_] functions below. *)

val equal_arith_expr : arith_expr -> arith_expr -> bool
(** [equal_arith_expr e1 e2] will check that [e1] and [e2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_expr : expr -> expr -> bool
(** [equal_expr t1 t2] returns [true] if [t1] and [t2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_def : def -> def -> bool
(** [equal_def d1 d2] returns [true] if [d1] and [d2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_deq : deq -> deq -> bool
(** [equal_deq d1 d2] returns [true] if [d1] and [d2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_deq_i : deq_i -> deq_i -> bool
(** [equal_deq_i d1 d2] returns [true] if [d1] and [d2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_dir : dir -> dir -> bool
(** [equal_typ d1 d2] returns [true] if [d1] and [d2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_mtyp : mtyp -> mtyp -> bool
(** [equal_mtyp t1 t2] returns [true] if [t1] and [t2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_typ : typ -> typ -> bool
(** [equal_typ t1 t2] returns [true] if [t1] and [t2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_var : var -> var -> bool
(** [equal_var ~no_context:true/false v1 v2] returns [true] if [v1] and [v2] are equal and [false] otherwise. See {!equal_prog} for details. *)

val equal_var_d : var_d -> var_d -> bool
(** [equal_var v1 v2] returns [true] if [v1] and [v2] are equal and [false] otherwise. See {!equal_prog} for details. *)

(** {1 Custom comparators} *)

(** If you need to compare types declared in this module that contain (recursively) identifiers, define your custom comparator using in the end {!Ident.compare}. If you use {!Stdlib.compare} to overcome this limitation, we can't ensure the behaviour of usuba. *)

val compare_var_d : var_d -> var_d -> int

(** {1 Hash function} *)

(** Some types don't have a custom hash function because they are composed of simple types and can be hashed with the polymorphic [hash] function from {!Stdlib.Hashtbl} *)

val hash_prog : prog -> int
(** [hash_prog p] will compute the hash of [p]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

val hash_arith_expr : arith_expr -> int
(** [hash_arith_expr e] will compute the hash of [e]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

val hash_expr : expr -> int
(** [hash_expr t] will compute the hash of [t]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

val hash_def : def -> int
(** [hash_def d] will compute the hash of [d]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

val hash_deq : deq -> int
(** [hash_deq d] will compute the hash of [d]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

val hash_deq_i : deq_i -> int
(** [hash_deq_i d] will compute the hash of [d]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

val hash_var : var -> int
(** [hash_var ~no_context:true/false v1 v2] will compute the hash of [v]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

val hash_var_d : var_d -> int
(** [hash_var v] will compute the hash of [v]. This function should always be used because it takes into account the possibility of having equal identifiers that look different.*)

(** {1 Collections} *)

(** Useful hash tables for usuba *)

module ExprHashtbl : Hashtbl.S with type key = expr
module DeqHashtbl : Hashtbl.S with type key = deq
module Deq_iHashtbl : Hashtbl.S with type key = deq_i
module VarHashtbl : Hashtbl.S with type key = var
module Var_dHashtbl : Hashtbl.S with type key = var_d

module SpecializedHashtbl :
  Hashtbl.S with type key = ident * dir list * mtyp list

module DepHashtbl :
  Hashtbl.S with type key = var list * expr * (ident * deq_i) list
