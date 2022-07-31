open Sexplib.Std

type ident = Ident.t

(** This doesn't print the ident but a way to create it since it's
   used in unit tests. See {!Ident.pp_create} *)
let pp_ident = Ident.pp_create

let idents_table = Hashtbl.create 32

(** id1 : id2 binding must exist in the idents_table *)
let equal_ident_unfill id1 id2 =
  match Hashtbl.find idents_table (Ident.name id1) with
  | name -> String.equal (Ident.name id2) name
  | exception Not_found ->
      (* We encountered an ident that has not been declared. This should not happen *)
      Format.eprintf "%s : %s never seen@." (Ident.name id1) (Ident.name id2);
      false

(** id1 : id2 binding must NOT exist in the idents_table *)
let equal_ident_fill id1 id2 =
  Hashtbl.add idents_table (Ident.name id1) (Ident.name id2);
  true

let equal_ident ~orig id1 id2 =
  equal_ident_unfill id1 id2 || (orig && equal_ident_fill id1 id2)

(** Types may contain ident that are not really identifiers but
    rather constants. This representation should change but right now
    we'll just need to check that they're equal by name *)
let equal_ident_unchanged id1 id2 = Ident.equal id1 id2

let ident_of_sexp = Ident.t_of_sexp
let sexp_of_ident = Ident.sexp_of_t

type log_op = And | Or | Xor | Andn | Masked of log_op
[@@deriving show { with_path = false }, eq, sexp]

type arith_op = Add | Mul | Sub | Div | Mod
[@@deriving show { with_path = false }, eq, sexp]

type shift_op = Lshift | Rshift | RAshift | Lrotate | Rrotate
[@@deriving show { with_path = false }, eq, sexp]

type arith_expr =
  | Const_e of int
  | Var_e of ident
  | Op_e of arith_op * arith_expr * arith_expr
[@@deriving show { with_path = false }, sexp]

let rec equal_arith_expr ?(orig = false) ae1 ae2 =
  match (ae1, ae2) with
  | Const_e i1, Const_e i2 -> Int.equal i1 i2
  | Var_e id1, Var_e id2 -> equal_ident ~orig id1 id2
  | Op_e (op1, ae11, ae12), Op_e (op2, ae21, ae22) ->
      equal_arith_op op1 op2
      && equal_arith_expr ~orig ae11 ae21
      && equal_arith_expr ~orig ae12 ae22
  | _ -> false

type dir =
  | Hslice
  | Vslice
  | Bslice
  | Natdir
  | Varslice of (ident[@equal equal_ident_unchanged])
  | Mslice of int
[@@deriving show { with_path = false }, eq, sexp]

type mtyp = Mint of int | Mnat | Mvar of (ident[@equal equal_ident_unchanged])
[@@deriving show { with_path = false }, eq, sexp]

type typ = Nat | Uint of dir * mtyp * int | Array of typ * arith_expr
[@@deriving show { with_path = false }, eq, sexp]

type var =
  | Var of ident
  | Index of var * arith_expr
  | Range of var * arith_expr * arith_expr
  | Slice of var * arith_expr list
[@@deriving show { with_path = false }, sexp]

let rec equal_var ?(orig = false) v1 v2 =
  let rec_call = equal_var ~orig in
  match (v1, v2) with
  | Var id1, Var id2 -> equal_ident ~orig id1 id2
  | Index (v1, ae1), Index (v2, ae2) ->
      rec_call v1 v2 && equal_arith_expr ~orig ae1 ae2
  | Range (v1, ae11, ae12), Range (v2, ae21, ae22) ->
      rec_call v1 v2
      && equal_arith_expr ~orig ae11 ae21
      && equal_arith_expr ~orig ae12 ae22
  | Slice (v1, ael1), Slice (v2, ael2) ->
      rec_call v1 v2 && List.equal (equal_arith_expr ~orig) ael1 ael2
  | _ -> false

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
[@@deriving show { with_path = false }, sexp]

let rec equal_expr ?(orig = false) e1 e2 =
  let rec_call = equal_expr ~orig in
  match (e1, e2) with
  | Const (i1, t1), Const (i2, t2) ->
      Int.equal i1 i2 && Option.equal equal_typ t1 t2
  | ExpVar v1, ExpVar v2 -> equal_var ~orig v1 v2
  | Tuple el1, Tuple el2 -> List.equal rec_call el1 el2
  | Not e1, Not e2 -> equal_expr ~orig e1 e2
  | Log (op1, e11, e12), Log (op2, e21, e22) ->
      equal_log_op op1 op2 && rec_call e11 e21 && rec_call e12 e22
  | Arith (op1, e11, e12), Arith (op2, e21, e22) ->
      equal_arith_op op1 op2 && rec_call e11 e21 && rec_call e12 e22
  | Shift (op1, e1, ae1), Shift (op2, e2, ae2) ->
      equal_shift_op op1 op2 && rec_call e1 e2 && equal_arith_expr ~orig ae1 ae2
  | Shuffle (v1, il1), Shuffle (v2, il2) ->
      equal_var ~orig v1 v2 && List.equal Int.equal il1 il2
  | Bitmask (e1, ae1), Bitmask (e2, ae2) ->
      rec_call e1 e2 && equal_arith_expr ~orig ae1 ae2
  | Pack (e11, e12, t1), Pack (e21, e22, t2) ->
      rec_call e11 e21 && rec_call e12 e22 && Option.equal equal_typ t1 t2
  | Fun (id1, el1), Fun (id2, el2) ->
      equal_ident ~orig id1 id2 && List.equal rec_call el1 el2
  | Fun_v (id1, ae1, el1), Fun_v (id2, ae2, el2) ->
      equal_ident ~orig id1 id2
      && equal_arith_expr ~orig ae1 ae2
      && List.equal rec_call el1 el2
  | _ -> false

type stmt_opt = Unroll | No_unroll | Pipelined | Safe_exit
[@@deriving show { with_path = false }, eq, sexp]

type deq_i =
  | Eqn of var list * expr * bool
  | Loop of
      (ident[@equal equal_ident ~orig:true])
      * arith_expr
      * arith_expr
      * deq list
      * stmt_opt list
[@@deriving show { with_path = false }, sexp]

(* orig is debug info *)
and deq = { content : deq_i; orig : (ident * deq_i) list }
[@@deriving show { with_path = false }, sexp]

let rec equal_deq_i ?(orig = false) d1 d2 =
  match (d1, d2) with
  | Eqn (vl1, e1, b1), Eqn (vl2, e2, b2) ->
      List.equal (equal_var ~orig) vl1 vl2
      && equal_expr ~orig e1 e2 && Bool.equal b1 b2
  | Loop (id1, ae11, ae12, dl1, sl1), Loop (id2, ae21, ae22, dl2, sl2) ->
      equal_ident ~orig:true id1 id2
      && equal_arith_expr ~orig ae11 ae21
      && equal_arith_expr ~orig ae12 ae22
      && List.equal (equal_deq ~orig) dl1 dl2
      && List.equal equal_stmt_opt sl1 sl2
  | _ -> false

and equal_deq ?(orig = false) (d1 : deq) d2 =
  equal_deq_i ~orig d1.content d2.content
  && List.equal
       (fun (id1, d1) (id2, d2) ->
         equal_ident ~orig:true id1 id2 && equal_deq_i ~orig:true d1 d2)
       d1.orig d2.orig

type var_d_opt = Pconst | PlazyLift
[@@deriving show { with_path = false }, eq, sexp]

(* See comment about `orig` above *)
type var_d = {
  vd_id : ident; [@equal equal_ident ~orig:true]
  vd_typ : typ;
  vd_opts : var_d_opt list;
  vd_orig : ((ident[@equal equal_ident ~orig:true]) * var_d) list;
}
[@@deriving show { with_path = false }, eq, sexp]

type p = var_d list [@@deriving show { with_path = false }, eq, sexp]

type def_i =
  | Single of p * deq list
  | Perm of int list
  | Table of int list
  | Multiple of def_i list
[@@deriving show { with_path = false }, eq, sexp]

type def_opt = Inline | No_inline | Interleave of int | No_opt | Is_table
[@@deriving show { with_path = false }, eq, sexp]

type def = { id : ident; p_in : p; p_out : p; opt : def_opt list; node : def_i }
[@@deriving show { with_path = false }, sexp]

let nodes_table = Hashtbl.create 32

let equal_def d1 d2 =
  Hashtbl.add nodes_table (Ident.name d1.id) (Ident.name d2.id);
  Hashtbl.clear idents_table;
  Hashtbl.iter (fun k v -> Hashtbl.add idents_table k v) nodes_table;
  equal_p d1.p_in d2.p_in && equal_p d1.p_out d2.p_out
  && List.equal equal_def_opt d1.opt d2.opt
  && equal_def_i d1.node d2.node

type def_or_inc = Def of def | Inc of string
[@@deriving show { with_path = false }, sexp]

type prog = { nodes : def list }
[@@deriving show { with_path = false }, eq, sexp]

let equal_prog p1 p2 =
  Hashtbl.clear nodes_table;
  (* Add the two stdlib functions, `refresh` and `rand` *)
  Hashtbl.add nodes_table "refresh" "refresh";
  (* TODO: There are currently no files that use rand in the test benchmark *)
  Hashtbl.add nodes_table "rand" "rand";
  Hashtbl.clear idents_table;
  equal_prog p1 p2
