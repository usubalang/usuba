open Prelude
open Sexplib.Std

type ident = Ident.t

let hash_list hash_v l = List.fold_left (fun acc v -> acc + hash_v v) 0 l
let equal_ident = Ident.equal

(** This doesn't print the ident but a way to create it since it's
   used in unit tests. See {!Ident.pp_create} *)
let pp_ident = Ident.pp_create

let idents_table = Ident.Hashtbl.create 32

(** id1 : id2 binding must exist in the idents_table *)
let alpha_equal_ident_unfill id1 id2 =
  match Ident.Hashtbl.find idents_table id1 with
  | id -> Ident.equal id2 id
  | exception Not_found ->
      (* We encountered an ident that has not been declared.
         This should not happen unless we're using this function in unit tests *)
      false

(** id1 : id2 binding must NOT exist in the idents_table *)
let alpha_equal_ident_fill id1 id2 =
  Ident.Hashtbl.add idents_table id1 id2;
  true

let alpha_equal_ident ~no_context id1 id2 =
  alpha_equal_ident_unfill id1 id2
  || (no_context && alpha_equal_ident_fill id1 id2)

(** Types may contain ident that are not really identifiers but
    rather constants. This representation should change but right now
    we'll just need to check that they're equal by name *)
let equal_ident_unchanged id1 id2 =
  String.equal (Ident.name id1) (Ident.name id2)

let ident_of_sexp = Ident.t_of_sexp
let sexp_of_ident = Ident.sexp_of_t

(** OPERATORS *)

(** No alpha_equal function since there are no idents in this type *)
type log_op = And | Or | Xor | Andn | Masked of log_op
[@@deriving show { with_path = false }, eq, sexp]

(** No alpha_equal function since there are no idents in this type *)
type arith_op = Add | Mul | Sub | Div | Mod
[@@deriving show { with_path = false }, eq, sexp]

(** No alpha_equal function since there are no idents in this type *)
type shift_op = Lshift | Rshift | RAshift | Lrotate | Rrotate
[@@deriving show { with_path = false }, eq, sexp]

(** ARITHMETIC EXPRESSIONS *)

type arith_expr =
  | Const_e of int
  | Var_e of ident
  | Op_e of arith_op * arith_expr * arith_expr
[@@deriving show { with_path = false }, eq, sexp]

let rec hash_arith_expr = function
  | Const_e i -> Hashtbl.(hash (1 + hash i))
  | Var_e id -> Hashtbl.hash (2 + Ident.hash id)
  | Op_e (op, ae1, ae2) ->
      Hashtbl.hash
        (3 + Hashtbl.hash op + hash_arith_expr ae1 + hash_arith_expr ae2)

let rec alpha_equal_arith_expr ?(no_context = false) ae1 ae2 =
  match (ae1, ae2) with
  | Const_e i1, Const_e i2 -> Int.equal i1 i2
  | Var_e id1, Var_e id2 -> alpha_equal_ident ~no_context id1 id2
  | Op_e (op1, ae11, ae12), Op_e (op2, ae21, ae22) ->
      equal_arith_op op1 op2
      && alpha_equal_arith_expr ~no_context ae11 ae21
      && alpha_equal_arith_expr ~no_context ae12 ae22
  | _ -> false

(** TYPES *)

type dir =
  | Hslice
  | Vslice
  | Bslice
  | Natdir
  | Varslice of (ident[@eq equal_ident_unchanged])
  | Mslice of int
[@@deriving show { with_path = false }, eq, sexp]

type mtyp = Mint of int | Mnat | Mvar of (ident[@equal equal_ident_unchanged])
[@@deriving show { with_path = false }, eq, sexp]

type typ = Nat | Uint of dir * mtyp * int | Array of typ * arith_expr
[@@deriving show { with_path = false }, eq, sexp]

(** VARIABLES *)

type var =
  | Var of ident
  | Index of var * arith_expr
  | Range of var * arith_expr * arith_expr
  | Slice of var * arith_expr list
[@@deriving show { with_path = false }, eq, sexp]

let rec hash_var = function
  | Var id -> Ident.hash id
  | Index (v, ae) -> Hashtbl.hash (11 + hash_var v + hash_arith_expr ae)
  | Range (v, ae1, ae2) ->
      Hashtbl.hash (12 + hash_var v + hash_arith_expr ae1 + hash_arith_expr ae2)
  | Slice (v, ael) ->
      Hashtbl.hash (13 + hash_var v + hash_list hash_arith_expr ael)

let rec alpha_equal_var ?(no_context = false) v1 v2 =
  let rec_call = alpha_equal_var ~no_context in
  match (v1, v2) with
  | Var id1, Var id2 -> alpha_equal_ident ~no_context id1 id2
  | Index (v1, ae1), Index (v2, ae2) ->
      rec_call v1 v2 && alpha_equal_arith_expr ~no_context ae1 ae2
  | Range (v1, ae11, ae12), Range (v2, ae21, ae22) ->
      rec_call v1 v2
      && alpha_equal_arith_expr ~no_context ae11 ae21
      && alpha_equal_arith_expr ~no_context ae12 ae22
  | Slice (v1, ael1), Slice (v2, ael2) ->
      rec_call v1 v2
      && List.equal (alpha_equal_arith_expr ~no_context) ael1 ael2
  | _ -> false

(** EXPRESSIONS *)

type expr =
  | Const of int * typ option
  | ExpVar of var
  | Tuple of expr list
  | Not of expr
  | Log of log_op * expr * expr
  | Arith of arith_op * expr * expr
  | Shift of shift_op * expr * arith_expr
  | Shuffle of var * int list
  | Bitmask of expr * arith_expr
  | Pack of expr * expr * typ option
  | Fun of ident * expr list
  | Fun_v of ident * arith_expr * expr list
[@@deriving show { with_path = false }, eq, sexp]

let rec hash_expr = function
  | Const (i, t) -> Hashtbl.hash (21 + Hashtbl.hash i + Hashtbl.hash t)
  | ExpVar v -> Hashtbl.hash (22 + hash_var v)
  | Tuple el -> Hashtbl.hash (23 + hash_list hash_expr el)
  | Not e -> Hashtbl.hash (24 + hash_expr e)
  | Log (op, e1, e2) ->
      Hashtbl.hash (25 + Hashtbl.hash op + hash_expr e1 + hash_expr e2)
  | Arith (op, e1, e2) ->
      Hashtbl.hash (26 + Hashtbl.hash op + hash_expr e1 + hash_expr e2)
  | Shift (op, e, ae) ->
      Hashtbl.hash (27 + Hashtbl.hash op + hash_expr e + hash_arith_expr ae)
  | Shuffle (var, il) -> Hashtbl.hash (28 + hash_var var + Hashtbl.hash il)
  | Bitmask (e, ae) -> Hashtbl.hash (29 + hash_expr e + hash_arith_expr ae)
  | Pack (e1, e2, o) ->
      Hashtbl.hash (30 + hash_expr e1 + hash_expr e2 + Hashtbl.hash o)
  | Fun (id, el) -> Hashtbl.hash (31 + Ident.hash id + hash_list hash_expr el)
  | Fun_v (id, ae, el) ->
      Hashtbl.hash
        (31 + Ident.hash id + hash_arith_expr ae + hash_list hash_expr el)

let rec alpha_equal_expr ?(no_context = false) e1 e2 =
  let rec_call = alpha_equal_expr ~no_context in
  match (e1, e2) with
  | Const (i1, t1), Const (i2, t2) ->
      Int.equal i1 i2 && Option.equal equal_typ t1 t2
  | ExpVar v1, ExpVar v2 -> alpha_equal_var ~no_context v1 v2
  | Tuple el1, Tuple el2 -> List.equal rec_call el1 el2
  | Not e1, Not e2 -> alpha_equal_expr ~no_context e1 e2
  | Log (op1, e11, e12), Log (op2, e21, e22) ->
      equal_log_op op1 op2 && rec_call e11 e21 && rec_call e12 e22
  | Arith (op1, e11, e12), Arith (op2, e21, e22) ->
      equal_arith_op op1 op2 && rec_call e11 e21 && rec_call e12 e22
  | Shift (op1, e1, ae1), Shift (op2, e2, ae2) ->
      equal_shift_op op1 op2 && rec_call e1 e2
      && alpha_equal_arith_expr ~no_context ae1 ae2
  | Shuffle (v1, il1), Shuffle (v2, il2) ->
      alpha_equal_var ~no_context v1 v2 && List.equal Int.equal il1 il2
  | Bitmask (e1, ae1), Bitmask (e2, ae2) ->
      rec_call e1 e2 && alpha_equal_arith_expr ~no_context ae1 ae2
  | Pack (e11, e12, t1), Pack (e21, e22, t2) ->
      rec_call e11 e21 && rec_call e12 e22 && Option.equal equal_typ t1 t2
  | Fun (id1, el1), Fun (id2, el2) ->
      alpha_equal_ident ~no_context id1 id2 && List.equal rec_call el1 el2
  | Fun_v (id1, ae1, el1), Fun_v (id2, ae2, el2) ->
      alpha_equal_ident ~no_context id1 id2
      && alpha_equal_arith_expr ~no_context ae1 ae2
      && List.equal rec_call el1 el2
  | _ -> false

type stmt_opt = Unroll | No_unroll | Pipelined | Safe_exit
[@@deriving show { with_path = false }, eq, sexp]

(** EQUATIONS *)

type deq_i =
  | Eqn of var list * expr * bool
  | Loop of {
      id : ident;
      start : arith_expr;
      stop : arith_expr;
      body : deq list;
      opts : stmt_opt list;
    }
[@@deriving show { with_path = false }, eq, sexp]

(* orig is debug info *)
and deq = { content : deq_i; orig : (ident * deq_i) list }
[@@deriving show { with_path = false }, sexp]

let rec alpha_equal_deq_i ?(no_context = false) d1 d2 =
  match (d1, d2) with
  | Eqn (vl1, e1, b1), Eqn (vl2, e2, b2) ->
      List.equal (alpha_equal_var ~no_context) vl1 vl2
      && alpha_equal_expr ~no_context e1 e2
      && Bool.equal b1 b2
  | ( Loop { id = id1; start = start1; stop = stop1; body = body1; opts = opts1 },
      Loop
        { id = id2; start = start2; stop = stop2; body = body2; opts = opts2 } )
    ->
      alpha_equal_ident ~no_context:true id1 id2
      && alpha_equal_arith_expr ~no_context start1 start2
      && alpha_equal_arith_expr ~no_context stop1 stop2
      && List.equal (alpha_equal_deq ~no_context) body1 body2
      && List.equal equal_stmt_opt opts1 opts2
  | _ -> false

and alpha_equal_deq ?(no_context = false) (d1 : deq) d2 =
  alpha_equal_deq_i ~no_context d1.content d2.content
  && List.equal
       (fun (id1, d1) (id2, d2) ->
         alpha_equal_ident ~no_context:true id1 id2
         && alpha_equal_deq_i ~no_context:true d1 d2)
       d1.orig d2.orig

let rec hash_deq_i = function
  | Eqn (vl, e, b) ->
      Hashtbl.hash (50 + hash_list hash_var vl + hash_expr e + Hashtbl.hash b)
  | Loop { id; start; stop; body; opts } ->
      Hashtbl.hash
        (51 + Ident.hash id + hash_arith_expr start + hash_arith_expr stop
       + hash_list hash_deq body + Hashtbl.hash opts)

and hash_deq { content; _ } = Hashtbl.hash (52 + hash_deq_i content)

(** VARIABLE DECLARATIONS *)

type var_d_opt = Pconst | PlazyLift
[@@deriving show { with_path = false }, eq, sexp]

(* See comment about `orig` above *)
type var_d = {
  vd_id : ident;
  vd_typ : typ;
  vd_opts : var_d_opt list;
  vd_orig : (ident * var_d) list;
}
[@@deriving show { with_path = false }, eq, sexp]

let compare_var_d v1 v2 = Ident.compare v1.vd_id v2.vd_id

let rec alpha_equal_var_d ?(no_context = false) v1 v2 =
  alpha_equal_ident ~no_context v1.vd_id v2.vd_id
  && equal_typ v1.vd_typ v2.vd_typ
  && List.equal equal_var_d_opt v1.vd_opts v2.vd_opts
  && List.equal
       (fun (id1, d1) (id2, d2) ->
         alpha_equal_ident ~no_context:true id1 id2
         && alpha_equal_var_d ~no_context:true d1 d2)
       v1.vd_orig v2.vd_orig

let hash_var_d { vd_id; _ } = Hashtbl.hash (4 + Ident.hash vd_id)

type p = var_d list [@@deriving show { with_path = false }, eq, sexp]

let alpha_equal_p ?(no_context = true) p1 p2 =
  List.equal (alpha_equal_var_d ~no_context) p1 p2

(** NODE DECLARATIONS *)

type def_i =
  | Single of p * deq list
  | Perm of int list
  | Table of int list
  | Multiple of def_i list
[@@deriving show { with_path = false }, eq, sexp]

let rec hash_def_i = function
  | Single (p, dl) ->
      Hashtbl.hash (60 + hash_list hash_var_d p + hash_list hash_deq dl)
  | Perm il -> Hashtbl.hash (61 + Hashtbl.hash il)
  | Table il -> Hashtbl.hash (62 + Hashtbl.hash il)
  | Multiple dl -> Hashtbl.hash (63 + hash_list hash_def_i dl)

let rec alpha_equal_def_i d1 d2 =
  match (d1, d2) with
  | Single (p1, dl1), Single (p2, dl2) ->
      alpha_equal_p ~no_context:true p1 p2 && List.equal alpha_equal_deq dl1 dl2
  | Perm il1, Perm il2 | Table il1, Table il2 -> List.equal Int.equal il1 il2
  | Multiple dl1, Multiple dl2 -> List.equal alpha_equal_def_i dl1 dl2
  | _ -> false

type def_opt = Inline | No_inline | Interleave of int | No_opt | Is_table
[@@deriving show { with_path = false }, eq, sexp]

type def = { id : ident; p_in : p; p_out : p; opt : def_opt list; node : def_i }
[@@deriving show { with_path = false }, eq, sexp]

let hash_def { id; p_in; p_out; opt; node } =
  Hashtbl.hash
    (70 + Ident.hash id + hash_list hash_var_d p_in + hash_list hash_var_d p_out
   + Hashtbl.hash opt + hash_def_i node)

let nodes_table = Ident.Hashtbl.create 32

let alpha_equal_def d1 d2 =
  Ident.Hashtbl.add nodes_table d1.id d2.id;
  Ident.Hashtbl.clear idents_table;
  Ident.Hashtbl.iter (fun k v -> Ident.Hashtbl.add idents_table k v) nodes_table;
  alpha_equal_p ~no_context:true d1.p_in d2.p_in
  && alpha_equal_p ~no_context:true d1.p_out d2.p_out
  && List.equal equal_def_opt d1.opt d2.opt
  && alpha_equal_def_i d1.node d2.node

type def_or_inc = Def of def | Inc of string
[@@deriving show { with_path = false }, sexp]

type prog = { nodes : def list }
[@@deriving show { with_path = false }, eq, sexp]

let hash_prog { nodes } = hash_list hash_def nodes
let refresh = Ident.create_constant "refresh"
let refr = Ident.create_constant "ref"
let print = Ident.create_constant "print"
let rand = Ident.create_constant "rand"

let new_context () =
  (* Add the two stdlib functions, `refresh` and `rand` *)
  Ident.Hashtbl.add nodes_table refresh refresh;
  (* TODO: There are currently no files that use ref in the test benchmark *)
  Ident.Hashtbl.add nodes_table refr refr;
  (* TODO: There are currently no files that use rand in the test benchmark *)
  Ident.Hashtbl.add nodes_table rand rand;
  Ident.Hashtbl.clear idents_table

let alpha_equal_prog p1 p2 =
  new_context ();
  List.equal alpha_equal_def p1.nodes p2.nodes

module VarHashtbl = Hashtbl.Make (struct
  type t = var

  let equal = equal_var
  let hash = hash_var
end)

module Var_dHashtbl = Hashtbl.Make (struct
  type t = var_d

  let equal = equal_var_d
  let hash = hash_var_d
end)

module ExprHashtbl = Hashtbl.Make (struct
  type t = expr

  let equal = equal_expr
  let hash = hash_expr
end)

module DeqHashtbl = Hashtbl.Make (struct
  type t = deq

  let equal = equal_deq
  let hash = hash_deq
end)

module Deq_iHashtbl = Hashtbl.Make (struct
  type t = deq_i

  let equal = equal_deq_i
  let hash = hash_deq_i
end)

module SpecializedHashtbl = Hashtbl.Make (struct
  type t = ident * dir list * mtyp list

  let equal (id1, dl1, mtl1) (id2, dl2, mtl2) =
    equal_ident id1 id2
    && List.equal equal_dir dl1 dl2
    && List.equal equal_mtyp mtl1 mtl2

  let hash (id, dl, mtl) =
    Hashtbl.hash (80 + Ident.hash id + Hashtbl.hash dl + Hashtbl.hash mtl)
end)

module DepHashtbl = Hashtbl.Make (struct
  type t = var list * expr * (ident * deq_i) list

  let equal (vl1, e1, idl1) (vl2, e2, idl2) =
    List.equal equal_var vl1 vl2
    && equal_expr e1 e2
    && List.equal
         (fun (id1, d1) (id2, d2) -> equal_ident id1 id2 && equal_deq_i d1 d2)
         idl1 idl2

  let hash (vl, e, idl) =
    Hashtbl.hash
      (90 + hash_list hash_var vl + hash_expr e
      + hash_list
          (fun (id, di) -> Hashtbl.hash (Ident.hash id + hash_deq_i di))
          idl)
end)
