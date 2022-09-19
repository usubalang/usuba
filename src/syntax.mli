(** Syntax module

    Combinators to create AST values that are type checked without requiring a parser - typer pass.

*)

open Usuba_AST

(** {2 Static Expressions} *)

module S : sig
  val c : int -> arith_expr
  (** Creates a {!Usuba_AST.Const_e} *)

  val v : ident -> arith_expr
  (** Creates a {!Usuba_AST.Var_e} *)

  val ( + ) : arith_expr -> arith_expr -> arith_expr
  (** Adds two {!Usuba_AST.arith_expr} *)

  val ( * ) : arith_expr -> arith_expr -> arith_expr
  (** Multiplies two {!Usuba_AST.arith_expr} *)

  val ( - ) : arith_expr -> arith_expr -> arith_expr
  (** Substracts two {!Usuba_AST.arith_expr} *)

  val ( / ) : arith_expr -> arith_expr -> arith_expr
  (** Divides two {!Usuba_AST.arith_expr} *)

  val ( % ) : arith_expr -> arith_expr -> arith_expr
  (** Modulo of two {!Usuba_AST.arith_expr} *)
end

(** {2 Types} *)

val nat : typ
(** {!Usuba_AST.Nat} *)

val array : typ -> arith_expr -> typ
(** [array t e] is {!Usuba_AST.Array}[(t, e)] *)

val _D : dir
(** {!Usuba_AST.Varslice}[ "D"] *)

val _m : mtyp
(** {!Usuba_AST.Mvar}[ "m"] *)

val u : dir -> mtyp -> int -> typ
(** [u d m n] is {!Usuba_AST.Uint}[(d m n)] *)

val u1 : dir -> mtyp -> typ
(** [u1 d m] is {!Usuba_AST.Uint}[(d, m, 1)] *)

val d : int -> typ
(** [v i] is {!Usuba_AST.Uint}[(]{!_D}[, ]{!_m}[, i)] *)

val b : int -> typ
(** [b i] is {!Usuba_AST.Uint}[(]{!_D}[, ]{!Usuba_AST.Mint}[1, i)] *)

(** {2 Expressions} *)

val c : ?typ:typ -> int -> expr
(** [c ~typ i] is {!Usuba_AST.Const}[(typ, i)] *)

val v : string -> expr
(** Creates a {!Usuba_AST.ExpVar} *)

val proj : arith_expr -> ?k2:arith_expr -> expr -> expr
(** [proj k1 ~k2 e] is:
    - {!Usuba_AST.ExpVar}[(]{!Usuba_AST.Index}[(e, k1)] if [k2] is [None] and
    - {!Usuba_AST.ExpVar}[(]{!Usuba_AST.Range}[(e, k1, k2)] otherwise *)

val proj_slice : arith_expr list -> expr -> expr
(** [proj_slice k e] is {!Usuba_AST.ExpVar}[(]{!Usuba_AST.Slice}[(e, k)] *)

val t : expr list -> expr
(** [t el] is {!Usuba_AST.Tuple}[el] *)

val not : expr -> expr
(** [not e] is {!Usuba_AST.Not}[e] *)

val ( land ) : expr -> expr -> expr
(** [land e1 e2] is {!Usuba_AST.Log}[(]{!Usuba_AST.And}[, e1, e2)] *)

val ( lor ) : expr -> expr -> expr
(** [lor e1 e2] is {!Usuba_AST.Log}[(]{!Usuba_AST.Or}[, e1, e2)] *)

val ( lxor ) : expr -> expr -> expr
(** [lxor e1 e2] is {!Usuba_AST.Log}[(]{!Usuba_AST.Xor}[, e1, e2)] *)

val ( &&~ ) : expr -> expr -> expr
(** [&&~ e1 e2] is {!Usuba_AST.Log}[(]{!Usuba_AST.Andn}[, e1, e2)] *)

val masked : expr -> expr
(** [maxked e] transforms a {!Usuba_AST.Log}[(op, e1, e2)] in {!Usuba_AST.Log}[(]{!Usuba_AST.Masked}[ op, e1, e2)] *)

val ( + ) : expr -> expr -> expr
(** [e1 + e2] is {!Usuba_AST.Arith}[(]{!Usuba_AST.Add}[, e1, e2)] *)

val ( * ) : expr -> expr -> expr
(** [e1 * e2] is {!Usuba_AST.Arith}[(]{!Usuba_AST.Mul}[, e1, e2)] *)

val ( - ) : expr -> expr -> expr
(** [e1 - e2] is {!Usuba_AST.Arith}[(]{!Usuba_AST.Sub}[, e1, e2)] *)

val ( / ) : expr -> expr -> expr
(** [e1 / e2] is {!Usuba_AST.Arith}[(]{!Usuba_AST.Div}[, e1, e2)] *)

val ( % ) : expr -> expr -> expr
(** [e1 % e2] is {!Usuba_AST.Arith}[(]{!Usuba_AST.Mod}[, e1, e2)] *)

val ( lsl ) : expr -> arith_expr -> expr
(** [lsl e k] is {!Usuba_AST.Shift}[(]{!Usuba_AST.Lshift}[, e, k)] *)

val ( lsr ) : expr -> arith_expr -> expr
(** [lsr e k] is {!Usuba_AST.Shift}[(]{!Usuba_AST.Rshift}[, e, k)] *)

val ( asr ) : expr -> arith_expr -> expr
(** [asr e k] is {!Usuba_AST.Shift}[(]{!Usuba_AST.RAshift}[, e, k)] *)

val ( <<< ) : expr -> arith_expr -> expr
(** [e <<< k] is {!Usuba_AST.Shift}[(]{!Usuba_AST.Lrotate}[, e, k)] *)

val ( >>> ) : expr -> arith_expr -> expr
(** [e >>> k] is {!Usuba_AST.Shift}[(]{!Usuba_AST.Rrotate}[, e, k)] *)

val shuffle : var -> int list -> expr
(** [shuffle v is] is {!Usuba_AST.Shuffle}[(v, is)] *)

val bitmask : expr -> arith_expr -> expr
(** [bitmask e k] is {!Usuba_AST.Bitmask}[(e, k)] *)

val pack : ?typ:typ -> expr -> expr -> expr
(** [pack ~typ e1 e2] is {!Usuba_AST.Pack}[(e1, e2, type)] *)

val call : ?k:arith_expr -> ident -> expr list -> expr
(** [call ?k f args] is:
    - {!Usuba_AST.Fun}[(f, args)] if [k] is [None]
    - {!Usuba_AST.Fun_v}[(f, k, args)] otherwise *)

(** {2 Nodes} *)

val ( = ) : expr list -> expr -> deq_i
(** [el = e] is an {!Usuba_AST.Eqn}[(vars of el, e, false)]

    [el] must only be composed of {!Usuba_AST.ExpVar}
*)

val mk_deq_i : deq_i list -> deq list
(** [mk_deq_i] transforms a {!Usuba_AST.deq_i}[ list] into a {!Usuba_AST.deq}[ list] *)

val forall :
  ?opts:stmt_opt list ->
  string ->
  arith_expr ->
  arith_expr ->
  (arith_expr -> deq_i list) ->
  deq_i
(** [forall ?opts i start stop eqs] will do the following:
    - create [id = ]{!Ident}[ i]
    - replace [id] in all the declarations stored in [eqs] and store it in [body]
    - create {!Usuba_AST.Loop}[{id; start; stop; body; opts}] *)

val mk_var_d : string -> typ -> var_d
(** [mk_var_d s vd_typ] is {{!Usuba_AST.var_d} Ident s; vd_typ; vd_opts = []; vd_orig = []} *)

val main : (('a -> 'b list) -> 'c) -> 'c

val node :
  ?def_opt:def_opt list ->
  string ->
  (string * typ) list ->
  (string * typ) list ->
  ?locals:(string * typ) list ->
  (expr list -> expr list -> expr list -> deq_i list) ->
  ((expr list -> expr) -> def list) ->
  def list
(** [node ?(def_opt = []) s in_vars out_vars ?(locals = []) is k] takes:
    - [s] as the [node]'s name
    - [in_vars] as input variables
    - [out_vars] as output variables
    - [~locals] as local variables
    - [is] is an expression using the previously defined variables

    An example node is:

    {[node "foo"
         [ ("a", Nat); ("b", Nat); ("c", Nat) ]
         [ ("x", Nat); ("y", Nat) ]
         ~locals:[ ("l1", Nat) ]
         (fun [ a; b; c ] [ x; y ] [ l1 ] ->
           [ [ y ] = x + a; [ b; c ] = b * y; [ l1 ] = x * a ])]}
*)

val table :
  ?def_opt:def_opt list ->
  string ->
  string * typ ->
  string * typ ->
  int list ->
  ((expr list -> expr) -> def list) ->
  def list
(** See {!node} *)

val perm :
  ?def_opt:def_opt list ->
  string ->
  string * typ ->
  string * typ ->
  int list ->
  ((expr list -> expr) -> def list) ->
  def list
(** See {!node} *)

val multi_table :
  ?def_opt:def_opt list ->
  string ->
  string * typ ->
  string * typ ->
  int list list ->
  ((expr list -> expr) -> def list) ->
  def list
(** See {!node} *)

val multi_perm :
  ?def_opt:def_opt list ->
  string ->
  string * typ ->
  string * typ ->
  int list list ->
  ((expr list -> expr) -> def list) ->
  def list
(** See {!node} *)

val ( let* ) : ('a -> 'b) -> 'a -> 'b
val eof : 'a list

module Examples : sig
  val f : def
  val aes : def list
end
