(******************************************************************* )
                            constant_folding.ml

     Constant folding is a very common optimization that consists in
     computing constant expressions at compile time. This module is
     quite uninteresting: it justs walks the AST down to the
     expressions, and there, it simplifies some epressions involving
     constants. Typically, simplified expressions look like:

     In Vslicing:
       x + 0   --->  0
       x * 0   --->  0
       ...

     In Bitslicing:
       x ^ 0   --->  x
       x & 1   --->  x
       ...

     Note that this module doesn't assume unnesting of expressions. This
     is to make it a little bit easier to run after other optimizations
     that may introduce nested expressions. And code-wise, having to
     handle nested expression doesn't complicate things too much.

  ( ***************************************************************** *)

open Prelude
open Usuba_AST
open Basic_utils
open Utils

(* Checks if an expression is 0 *)
let is_zero (e : expr) = match e with Const (0, _) -> true | _ -> false

(* Checks if an expression is 1 *)
let is_one (e : expr) = match e with Const (1, _) -> true | _ -> false

(* Checks if an expression is -1. Note that this depends on the
     expression's type: on a b1, -1 is 0b1; on a u8, -1 is
     0b11111111. *)
let is_full_ones (env_var : typ Ident.Hashtbl.t) (e : expr) =
  match e with
  | Const (n, Some typ) ->
      let msize =
        match get_type_m typ with
        | Mint m -> m
        | _ ->
            Format.eprintf "is_full_ones: need a fixed word size, got: %a:%a@."
              (Usuba_print.pp_expr ()) e (Usuba_print.pp_typ ())
              (get_normed_expr_type env_var e);
            assert false
      in
      let minus_one = gen_minus_one msize in
      n land minus_one = minus_one
  | _ -> false

let gen_full_ones (typ : typ) : int =
  let msize =
    match get_type_m typ with
    | Mint m -> m
    | _ ->
        Format.eprintf "gen_full_ones: need a fixed word size, got: %a@."
          (Usuba_print.pp_typ ()) typ;
        assert false
  in
  gen_minus_one msize

let fold_arith (env_var : typ Ident.Hashtbl.t) (op : arith_op) (x : expr)
    (y : expr) : expr =
  (* Get the OCaml operator corresponding to the Usuba one. *)
  let ua_op_to_ml (op : arith_op) : int -> int -> int =
    match op with
    | Mul -> ( * )
    | Add -> ( + )
    | Sub -> ( - )
    | Div -> ( / )
    | Mod -> ( mod )
  in
  (* If both |x| and |y| are constants, then computes |x op y|. *)
  let compute_const_arith (op : arith_op) (x : expr) (y : expr) : expr option =
    match (x, y) with
    | Const (xn, typ), Const (yn, _) ->
        Some (Const ((ua_op_to_ml op) xn yn, typ))
    | _ -> None
  in

  (* First, try to fully compute |x op y|. *)
  match compute_const_arith op x y with
  | Some e -> e
  | None -> (
      (* If |x op y| is not computable, then try to simplify it. *)
      let zero = Const (0, Some (get_normed_expr_type env_var x)) in
      match op with
      | Mul ->
          if is_zero x then zero (* 0 * _ = 0 *)
          else if is_zero y then zero (* _ * 0 = 0 *)
          else if is_one x then y (* 1 * y = y *)
          else if is_one y then x (* x * 1 = x *)
          else Arith (Mul, x, y)
      | Add ->
          if is_zero x then y (* 0 + y = y *)
          else if is_zero y then x (* x + 0 = x *)
          else Arith (Add, x, y)
      | Sub -> if is_zero y then x (* x - 0 = x *) else Arith (Sub, x, y)
      | Div ->
          if is_zero x then zero (* 0 / y = 0 *)
          else if is_one y then x (* x / 1 = x *)
          else Arith (Div, x, y)
      | Mod ->
          if is_zero x then zero (* 0 % y = 0 *)
          else if is_one y then zero (* _ % 1 = 0 *)
          else Arith (Mod, x, y))

let fold_log (env_var : typ Ident.Hashtbl.t) (op : log_op) (x : expr) (y : expr)
    : expr =
  (* Get the OCaml operator corresponding to the Usuba one. *)
  let ua_op_to_ml (op : log_op) : int -> int -> int =
    match op with
    | And -> ( land )
    | Or -> ( lor )
    | Xor -> ( lxor )
    | Andn -> fun x y -> lnot x land y
    | _ -> assert false
    (* Not dealing with masked operations here *)
  in
  (* If both |x| and |y| are constants, then computes |x op y|. *)
  let compute_const_log (op : log_op) (x : expr) (y : expr) : expr option =
    match (x, y) with
    | Const (xn, typ), Const (yn, _) ->
        Some (Const ((ua_op_to_ml op) xn yn, typ))
    | _ -> None
  in

  (* First, try to fully compute |x op y|. *)
  match compute_const_log op x y with
  | Some e -> e
  | None -> (
      (* If |x op y| is not computable, then try to simplify it. *)
      let zero = Const (0, Some (get_normed_expr_type env_var x)) in
      match op with
      | And ->
          if is_zero x then zero (* 0 & _ = 0 *)
          else if is_zero y then zero (* _ & 0 = 0 *)
          else if is_full_ones env_var x then y (* 1 & y = y *)
          else if is_full_ones env_var y then x (* x & 1 = x *)
          else if equal_expr x y then x (* x & x = x *)
          else Log (And, x, y)
      | Or ->
          if is_zero x then y (* 0 | y = y *)
          else if is_zero y then x (* x | 0 = x *)
          else if is_full_ones env_var x then x (* 1 | y = 1 *)
          else if is_full_ones env_var y then y (* x | 1 = 1 *)
          else if equal_expr x y then x (* x | x = x *)
          else Log (Or, x, y)
      | Xor ->
          if is_zero x then y (* 0 ^ y = y  *)
          else if is_zero y then x (* x ^ 0 = x  *)
          else if is_full_ones env_var x then Not y (* 1 ^ y = ~y *)
          else if is_full_ones env_var y then Not x (* x ^ 1 = ~x *)
          else if equal_expr x y then zero (* x ^ x = 0 *)
          else Log (Xor, x, y)
      | Andn ->
          if is_zero x then y (* ~0 & y = y  *)
          else if is_zero y then zero (* ~x & 0 = 0  *)
          else if is_full_ones env_var x then zero (* ~1 & y = 0 *)
          else if is_full_ones env_var y then Not x (* ~x & 1 = ~x *)
          else Log (Andn, x, y)
      | _ -> Log (op, x, y))

let fold_not (env_var : typ Ident.Hashtbl.t) (e : expr) : expr =
  match e with
  | Const (0, Some typ) -> Const (gen_full_ones typ, Some typ) (* ~1 = 0 *)
  | Const (_, typ) ->
      if is_full_ones env_var e then Const (0, typ) (* ~0 = 1 *) else Not e
  | _ -> Not e

(* Common documentation for all functions bellow: straight-forwardly
   walks down the AST to finally call fold_log and fold_arith. *)

let rec fold_expr (env_var : typ Ident.Hashtbl.t) (e : expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar _ -> e
  | Shuffle _ -> e
  | Tuple l -> Tuple (List.map (fold_expr env_var) l)
  | Not e' -> fold_not env_var (fold_expr env_var e')
  | Shift (op, e, ae) -> Shift (op, fold_expr env_var e, ae)
  | Log (op, e1, e2) ->
      fold_log env_var op (fold_expr env_var e1) (fold_expr env_var e2)
  | Arith (op, e1, e2) ->
      fold_arith env_var op (fold_expr env_var e1) (fold_expr env_var e2)
  | Bitmask (e', ae) -> Bitmask (fold_expr env_var e', ae)
  | Pack (e1, e2, t) -> Pack (fold_expr env_var e1, fold_expr env_var e2, t)
  | Fun (f, l) -> Fun (f, List.map (fold_expr env_var) l)
  | _ ->
      Format.eprintf "fold_expr: Cannot fold unnormalized expression: %a.@."
        (Usuba_print.pp_expr ()) e;
      assert false

let rec fold_deqs (env_var : typ Ident.Hashtbl.t) (deqs : deq list) : deq list =
  List.map
    (fun d ->
      match d.content with
      | Eqn (lhs, e, sync) ->
          { d with content = Eqn (lhs, fold_expr env_var e, sync) }
      | Loop t ->
          { d with content = Loop { t with body = fold_deqs env_var t.body } })
    deqs

let fold_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      let env_var = build_env_var def.p_in def.p_out vars in
      { def with node = Single (vars, fold_deqs env_var body) }
  | _ -> def

let run _ prog _ : prog = { nodes = List.map fold_def prog.nodes }
let as_pass = (run, "Constant_folding", 0)

let%test_module "Constant Folding" =
  (module struct
    open Parser_api

    let ( =! ) e1 e2 = equal_expr e1 e2

    (* Initialisation of the variables environment *)
    let env_var = Ident.Hashtbl.create 10

    let () =
      Ident.Hashtbl.add env_var (Ident.create_unbound "x")
        (Uint (Vslice, Mint 8, 1));
      Ident.Hashtbl.add env_var (Ident.create_unbound "y")
        (Uint (Vslice, Mint 8, 1))

    (*                            Arithmetics                       *)
    (* Multiplication *)
    let%test "test_vslice_arith_mul1" =
      fold_expr env_var (parse_expr "x * y") =! parse_expr "x * y"

    let%test "test_vslice_arith_mul2" =
      fold_expr env_var (parse_expr "x * 1:u<V>8") =! parse_expr "x"

    let%test "test_vslice_arith_mul3" =
      fold_expr env_var (parse_expr "1:u<V>8 * x") =! parse_expr "x"

    let%test "test_vslice_arith_mul4" =
      fold_expr env_var (parse_expr "x * 0xff:u<V>8")
      =! parse_expr "x * 0xff:u<V>8"

    let%test "test_vslice_arith_mul5" =
      fold_expr env_var (parse_expr "0xff:u<V>8 * x")
      =! parse_expr "0xff:u<V>8 * x"

    let%test "test_vslice_arith_mul6" =
      fold_expr env_var (parse_expr "x * 0:u<V>8") =! parse_expr "0:u<V>8"

    let%test "test_vslice_arith_mul7" =
      fold_expr env_var (parse_expr "0:u<V>8 * x") =! parse_expr "0:u<V>8"

    let%test "test_vslice_arith_mul8" =
      fold_expr env_var (parse_expr "2:u<V>8 * 3:u<V>8") =! parse_expr "6:u<V>8"

    (* Addition *)
    let%test "test_vslice_arith_add1" =
      fold_expr env_var (parse_expr "x + y") =! parse_expr "x + y"

    let%test "test_vslice_arith_add2" =
      fold_expr env_var (parse_expr "x + 0:u<V>8") =! parse_expr "x"

    let%test "test_vslice_arith_add3" =
      fold_expr env_var (parse_expr "0:u<V>8 + x") =! parse_expr "x"

    let%test "test_vslice_arith_add4" =
      fold_expr env_var (parse_expr "0:u<V>8 + 5:u<V>8") =! parse_expr "5:u<V>8"

    (* Subtraction *)
    let%test "test_vslice_arith_sub1" =
      fold_expr env_var (parse_expr "x - y") =! parse_expr "x - y"

    let%test "test_vslice_arith_sub2" =
      fold_expr env_var (parse_expr "x - 0:u<V>8") =! parse_expr "x"

    let%test "test_vslice_arith_sub3" =
      fold_expr env_var (parse_expr "0:u<V>8 - x") =! parse_expr "0:u<V>8 - x"

    let%test "test_vslice_arith_sub4" =
      fold_expr env_var (parse_expr "11:u<V>8 - 5:u<V>8")
      =! parse_expr "6:u<V>8"

    (* Division *)
    let%test "test_vslice_arith_div1" =
      fold_expr env_var (parse_expr "x / y") =! parse_expr "x / y"

    let%test "test_vslice_arith_div2" =
      fold_expr env_var (parse_expr "x / 1:u<V>8") =! parse_expr "x"

    let%test "test_vslice_arith_div3" =
      fold_expr env_var (parse_expr "0:u<V>8 / x") =! parse_expr "0:u<V>8"

    let%test "test_vslice_arith_div4" =
      fold_expr env_var (parse_expr "11:u<V>8 / 5:u<V>8")
      =! parse_expr "2:u<V>8"

    (* Modulo *)
    let%test "test_vslice_arith_mod1" =
      fold_expr env_var (parse_expr "x % y") =! parse_expr "x % y"

    let%test "test_vslice_arith_mod2" =
      fold_expr env_var (parse_expr "x % 1:u<V>8") =! parse_expr "0:u<V>8"

    let%test "test_vslice_arith_mod3" =
      fold_expr env_var (parse_expr "0:u<V>8 / x") =! parse_expr "0:u<V>8"

    let%test "test_vslice_arith_mod4" =
      fold_expr env_var (parse_expr "11:u<V>8 % 5:u<V>8")
      =! parse_expr "1:u<V>8"

    (*                              Logical                         *)
    (* And *)
    let%test "test_vslice_log_and1" =
      fold_expr env_var (parse_expr "x & y") =! parse_expr "x & y"

    let%test "test_vslice_log_and2" =
      fold_expr env_var (parse_expr "x & 0xff:u<V>8") =! parse_expr "x"

    let%test "test_vslice_log_and3" =
      fold_expr env_var (parse_expr "0xff:u<V>8 & x") =! parse_expr "x"

    let%test "test_vslice_log_and4" =
      fold_expr env_var (parse_expr "x & 0:u<V>8") =! parse_expr "0:u<V>8"

    let%test "test_vslice_log_and5" =
      fold_expr env_var (parse_expr "0:u<V>8 & x") =! parse_expr "0:u<V>8"

    let%test "test_vslice_log_and6" =
      fold_expr env_var (parse_expr "x & 1:u<V>8") =! parse_expr "x & 1:u<V>8"

    let%test "test_vslice_log_and7" =
      fold_expr env_var (parse_expr "1:u<V>8 & x") =! parse_expr "1:u<V>8 & x"

    let%test "test_vslice_log_and8" =
      fold_expr env_var (parse_expr "1:u<V>8 & 0x10:u<V>8")
      =! parse_expr "0:u<V>8"

    let%test "test_vslice_log_and9" =
      fold_expr env_var (parse_expr "1:u<V>8 & 0x11:u<V>8")
      =! parse_expr "1:u<V>8"

    let%test "test_vslice_log_and10" =
      fold_expr env_var (parse_expr "x & x") =! parse_expr "x"

    (* Or *)
    let%test "test_vslice_log_or1" =
      fold_expr env_var (parse_expr "x | y") =! parse_expr "x | y"

    let%test "test_vslice_log_or2" =
      fold_expr env_var (parse_expr "x | 0xff:u<V>8") =! parse_expr "0xff:u<V>8"

    let%test "test_vslice_log_or3" =
      fold_expr env_var (parse_expr "0xff:u<V>8 | x") =! parse_expr "0xff:u<V>8"

    let%test "test_vslice_log_or4" =
      fold_expr env_var (parse_expr "x | 0:u<V>8") =! parse_expr "x"

    let%test "test_vslice_log_or5" =
      fold_expr env_var (parse_expr "0:u<V>8 | x") =! parse_expr "x"

    let%test "test_vslice_log_or6" =
      fold_expr env_var (parse_expr "x | 1:u<V>8") =! parse_expr "x | 1:u<V>8"

    let%test "test_vslice_log_or7" =
      fold_expr env_var (parse_expr "1:u<V>8 | x") =! parse_expr "1:u<V>8 | x"

    let%test "test_vslice_log_or8" =
      fold_expr env_var (parse_expr "1:u<V>8 | 0x10:u<V>8")
      =! parse_expr "0x11:u<V>8"

    let%test "test_vslice_log_or9" =
      fold_expr env_var (parse_expr "1:u<V>8 | 0x11:u<V>8")
      =! parse_expr "0x11:u<V>8"

    let%test "test_vslice_log_or10" =
      fold_expr env_var (parse_expr "x | x") =! parse_expr "x"

    (* Xor *)
    let%test "test_vslice_log_xor1" =
      fold_expr env_var (parse_expr "x ^ y") =! parse_expr "x ^ y"

    let%test "test_vslice_log_xor2" =
      fold_expr env_var (parse_expr "x ^ 0xff:u<V>8") =! parse_expr "~x"

    let%test "test_vslice_log_xor3" =
      fold_expr env_var (parse_expr "0xff:u<V>8 ^ x") =! parse_expr "~x"

    let%test "test_vslice_log_xor4" =
      fold_expr env_var (parse_expr "x ^ 0:u<V>8") =! parse_expr "x"

    let%test "test_vslice_log_xor5" =
      fold_expr env_var (parse_expr "0:u<V>8 ^ x") =! parse_expr "x"

    let%test "test_vslice_log_xor6" =
      fold_expr env_var (parse_expr "x ^ 1:u<V>8") =! parse_expr "x ^ 1:u<V>8"

    let%test "test_vslice_log_xor7" =
      fold_expr env_var (parse_expr "1:u<V>8 ^ x") =! parse_expr "1:u<V>8 ^ x"

    let%test "test_vslice_log_xor8" =
      fold_expr env_var (parse_expr "1:u<V>8 ^ 0x10:u<V>8")
      =! parse_expr "0x11:u<V>8"

    let%test "test_vslice_log_xor9" =
      fold_expr env_var (parse_expr "1:u<V>8 ^ 0x11:u<V>8")
      =! parse_expr "0x10:u<V>8"

    let%test "test_vslice_log_xor10" =
      fold_expr env_var (parse_expr "x ^ x") =! parse_expr "0:u<V>8"

    (* Not *)
    let%test "test_vslice_log_not1" =
      fold_expr env_var (parse_expr "~(0xff:u<V>8)") =! parse_expr "0:u<V>8"

    let%test "test_vslice_log_not2" =
      fold_expr env_var (parse_expr "~(0x0:u<V>8)") =! parse_expr "0xff:u<V>8"

    let%test "test_vslice_log_not3" =
      fold_expr env_var (parse_expr "~x") =! parse_expr "~x"

    (* Skipping Andn tests because for now, I don't think Usuba ever
       generates Andn instructions... *)

    (* Setting up env *)
    let env_var = Ident.Hashtbl.create 10

    let () =
      Ident.Hashtbl.add env_var (Ident.create_unbound "x")
        (Uint (Bslice, Mint 1, 1));
      Ident.Hashtbl.add env_var (Ident.create_unbound "y")
        (Uint (Bslice, Mint 1, 1))

    (*                              Logical                         *)
    (* And *)
    let%test "test_bitslice_log_and1" =
      fold_expr env_var (parse_expr "x & x") =! parse_expr "x"

    let%test "test_bitslice_log_and2" =
      fold_expr env_var (parse_expr "x & y") =! parse_expr "x & y"

    let%test "test_bitslice_log_and3" =
      fold_expr env_var (parse_expr "x & 1:u<B>1") =! parse_expr "x"

    let%test "test_bitslice_log_and4" =
      fold_expr env_var (parse_expr "0x1:u<B>1 & x") =! parse_expr "x"

    let%test "test_bitslice_log_and5" =
      fold_expr env_var (parse_expr "x & 0:u<B>1") =! parse_expr "0:u<B>1"

    let%test "test_bitslice_log_and6" =
      fold_expr env_var (parse_expr "0:u<B>1 & x") =! parse_expr "0:u<B>1"

    let%test "test_bitslice_log_and7" =
      fold_expr env_var (parse_expr "1:u<B>1 & 0x0:u<B>1")
      =! parse_expr "0:u<B>1"

    let%test "test_bitslice_log_and8" =
      fold_expr env_var (parse_expr "1:u<B>1 & 0x1:u<B>1")
      =! parse_expr "1:u<B>1"

    (* Or *)
    let%test "test_bitslice_log_or1" =
      fold_expr env_var (parse_expr "x | y") =! parse_expr "x | y"

    let%test "test_bitslice_log_or2" =
      fold_expr env_var (parse_expr "x | 1:u<B>1") =! parse_expr "1:u<B>1"

    let%test "test_bitslice_log_or3" =
      fold_expr env_var (parse_expr "0x1:u<B>1 | x") =! parse_expr "1:u<B>1"

    let%test "test_bitslice_log_or4" =
      fold_expr env_var (parse_expr "x | 0:u<B>1") =! parse_expr "x"

    let%test "test_bitslice_log_or5" =
      fold_expr env_var (parse_expr "0:u<B>1 | x") =! parse_expr "x"

    let%test "test_bitslice_log_or6" =
      fold_expr env_var (parse_expr "1:u<B>1 | 0x0:u<B>1")
      =! parse_expr "1:u<B>1"

    let%test "test_bitslice_log_or7" =
      fold_expr env_var (parse_expr "1:u<B>1 | 0x1:u<B>1")
      =! parse_expr "1:u<B>1"

    let%test "test_bitslice_log_or8" =
      fold_expr env_var (parse_expr "0:u<B>1 | 0x0:u<B>1")
      =! parse_expr "0:u<B>1"

    let%test "test_bitslice_log_or9" =
      fold_expr env_var (parse_expr "x | x") =! parse_expr "x"

    (* Xor *)
    let%test "test_bitslice_log_xor1" =
      fold_expr env_var (parse_expr "x ^ y") =! parse_expr "x ^ y"

    let%test "test_bitslice_log_xor2" =
      fold_expr env_var (parse_expr "x ^ 1:u<B>1") =! parse_expr "~x"

    let%test "test_bitslice_log_xor3" =
      fold_expr env_var (parse_expr "0x1:u<B>1 ^ x") =! parse_expr "~x"

    let%test "test_bitslice_log_xor4" =
      fold_expr env_var (parse_expr "x ^ 0:u<B>1") =! parse_expr "x"

    let%test "test_bitslice_log_xor5" =
      fold_expr env_var (parse_expr "0:u<B>1 ^ x") =! parse_expr "x"

    let%test "test_bitslice_log_xor6" =
      fold_expr env_var (parse_expr "1:u<B>1 ^ 0x0:u<B>1")
      =! parse_expr "1:u<B>1"

    let%test "test_bitslice_log_xor7" =
      fold_expr env_var (parse_expr "1:u<B>1 ^ 0x1:u<B>1")
      =! parse_expr "0:u<B>1"

    let%test "test_bitslice_log_xor8" =
      fold_expr env_var (parse_expr "0:u<B>1 ^ 0x0:u<B>1")
      =! parse_expr "0:u<B>1"

    let%test "test_bitslice_log_xor9" =
      fold_expr env_var (parse_expr "x ^ x") =! parse_expr "0:u<B>1"

    (* Not *)
    let%test "test_bitslice_log_not1" =
      fold_expr env_var (parse_expr "~(1:u<B>1)") =! parse_expr "0:u<B>1"

    let%test "test_bitslice_log_not2" =
      fold_expr env_var (parse_expr "~(0:u<B>1)") =! parse_expr "1:u<B>1"

    let%test "test_bitslice_log_not3" =
      fold_expr env_var (parse_expr "~x") =! parse_expr "~x"
  end)
