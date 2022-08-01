(** This module is included in all files to prevent using polymorphic comparators and specific functions from the Stdlib (currently [List.mem])

    If you {b really} need to use a polymorphic comparator and you know what you're doing, use [Stdlib.<comparator>] and add a comment starting with [(* STDLIB_IMPORT: ...*)] justifying its use (see, for example, perfs.ml) *)

(** {1 Utility} *)

(** Don't allow the polymorphic comparators to be used anywhere in the program *)

val ( = ) : int -> int -> bool
val ( <> ) : int -> int -> bool
val ( < ) : int -> int -> bool
val ( > ) : int -> int -> bool
val ( <= ) : int -> int -> bool
val ( >= ) : int -> int -> bool
val compare : int -> int -> int

module List : sig
  include module type of Stdlib.List
end
