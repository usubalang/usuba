(** This module implements unique identifiers.

    When creating a new identifier it will either be:
    - A declaration:
    {[
    let f a b = (* ... *)
    ]}
    [f], [a] and [b] are free variables and must thus be created with {!create_free}
    - Bound to a declaration, for instance
    {[
    let f a b = a + b
    ]}
    In this case, [a] and [b] in [a + b] will be bound to the [a] and [b] parameters of the [f] declaration. If they can't be bound at this point of the program because you don't know which identifier they're bound to, use {!create_unbound}.
 *)

(** {1 Types} *)

type t
(** The type of identifiers.

 The type is hidden to prevent messing with unique identifiers. *)

type uid = int
(** The type of unique values associated to identifier. *)

(** {1 Getters} *)

val name : t -> string
(** [name t] returns the string associated to [t]. *)

val uid : t -> uid
(** [uid t] returns the unique identifier associated to [t]. *)

(** {1 Creation} *)

(** {2 New identifiers} *)

val create_unbound : string -> t
(** [create_unbound name] returns a new unbound {!t}. *)

val free_unbound : t -> t
(** [free_unbound t] returns a new {!t} with an unique identifier. *)

val create_free : string -> t
(** [create_free name] returns a free [t] with its unique identifier.

    {e For compatibility reasons, the current implementation gives [-1] as an identifier to all new free variables} *)

val create_constant : string -> t
(** [create_constant name] returns a constant [t] with its unique identifier.

    {e Don't use it unless you are declaring an identifier that will never be renamed, modified etc} *)

(** {2 From existing identifiers} *)

(** {3 Free identifiers} *)

val fresh_suffixed : t -> string -> t
(** [fresh_suffixed t suf] creates a fresh [t'] where [name t' = name t ^ suf]. *)

val fresh_prefixed : t -> string -> t
(** [fresh_prefixed t pre] creates a fresh [t'] where [name t' = pre ^ name t]. *)

val fresh_concat : t -> t -> t
(** [fresh_concat t1 t2] creates a fresh [t'] where [name t' = name t1 ^ name t2]. *)

val fresh_copy : t -> t
(** [fresh_copy t] creates a fresh [t'] where [name t' = name t]. *)

(** {3 Bound identifiers} *)

val bound_copy : t -> string -> t
(** [bound_copy t] creates a bound [t'] where [name t' = name t] and [uid t' = uid t]. *)

val bound_copy2 : t -> t
(** [bound_copy2 t] creates a bound [t'] where [name t' = name t ^ "__2"] and [uid t' = uid t]. *)

val bound_copy3 : t -> t
(** [bound_copy3 t] creates a bound [t'] where [name t' = name t ^ "__3"] and [uid t' = uid t]. *)

(** {1 Printers} *)

val pp : ?detailed:bool -> unit -> Format.formatter -> t -> unit
(** [pp ~detailed:(false|true) () ppf t] prints [t] to [ppf]. If [detailed = true] then the unique identifier of [t] will be printed too. Otherwise, only [t]'s name will be printed. *)

val pp_create : Format.formatter -> t -> unit
(** [pp_create ppf t] is used to generate unit tests. [t] will be printed as [Ident.create_unbound "<t.name>"]. *)

(** {1 Comparators} *)

val equal : t -> t -> bool
(** [equal t1 t2] returns [true] if [name t1 = name t2].

    {e Warning: [equal] is currently implemented on names to stay coherent with how it was done before. This is subject to change. If you need to check that two identifiers have the same name, please use [String.equal (name t1) (name t2)].} *)

val compare : t -> t -> int
(** [compare t1 t2] returns [0] if [t1] is equal to [t2], a (unspecified) negative integer if [t1] is less than [t2] and a (unspecified) integer if [t1] is greater than [t2].

    {e Warning: [compare] is currently implemented on names to stay coherent with how it was done before. This is subject to change. If you need to compare the names of two identifiers , please use [String.compare (name t1) (name t2)].} *)

(** {1 Collections} *)
val hash : t -> int
(** [hash t] returns the hash of [t]

    {e Warning: [hash] is currently implemented on names to stay coherent with how it was done before. This is subject to change..} *)

module NameMap : sig
  include Map.S with type key = string

  val pp :
    ?pp_sep:(Format.formatter -> unit -> unit) ->
    ?left:string ->
    ?right:string ->
    (Format.formatter -> 'a -> unit) ->
    Format.formatter ->
    'a t ->
    unit
end

(** See {!compare} for details about how identifiers are compared *)
module Map : sig
  include Map.S with type key = t

  val pp :
    ?pp_sep:(Format.formatter -> unit -> unit) ->
    ?left:string ->
    ?right:string ->
    (Format.formatter -> 'a -> unit) ->
    Format.formatter ->
    'a t ->
    unit
end

(** [hash] and [equal] are currently based on the name of the identifier *)
module Hashtbl : sig
  include Hashtbl.S with type key = t

  val keys : 'a t -> key list
  val values : 'a t -> 'a list
  val each : 'a t -> (key * 'a) list
  val keys_2nd_layer : 'a t t -> key -> key list
end

(** {1 Explicit binding} *)

val bind : backtrace:string list -> t NameMap.t -> t -> t
(** [bind ~backtrace map t] binds an unbound {!t} to its corresponding  *)

(** {1 S-expressions} *)

val t_of_sexp : Sexplib0.Sexp.t -> t
(** [t_of_sexp sexp] returns the identifier represented by [sexp]. *)

val sexp_of_t : t -> Sexplib0.Sexp.t
(** [sexp_of_t t] returns [t] converted as an s-expression. *)
