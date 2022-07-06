type t
type uid = int

module Map : Map.S with type key = string

val t_of_sexp : Sexplib0.Sexp.t -> t
val sexp_of_t : t -> Sexplib0.Sexp.t
val name : t -> string
val uid : t -> uid
val create_unbound : string -> t
val refresh : t -> t
val create_fresh : string -> t
val fresh_suffixed : t -> string -> t
val fresh_prefixed : t -> string -> t
val fresh_concat : t -> t -> t
val fresh_copy : t -> t
val bind : backtrace:string list -> uid Map.t -> t -> t
val copy : t -> string -> t
val copy2_id : t -> t
val copy3_id : t -> t
val pp : ?detailed:bool -> unit -> Format.formatter -> t -> unit
val show : t -> string
val equal : t -> t -> bool
val compare : t -> t -> int
val hash : t -> int
