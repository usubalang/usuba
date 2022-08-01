open Usuba_AST
open Constant_folding
open Parser_api

let ( =! ) e1 e2 = equal_expr e1 e2

let test_vslice () =
  (* Setting up env *)
  let env_var = Ident.Hashtbl.create 10 in
  Ident.Hashtbl.add env_var (Ident.create_unbound "x")
    (Uint (Vslice, Mint 8, 1));
  Ident.Hashtbl.add env_var (Ident.create_unbound "y")
    (Uint (Vslice, Mint 8, 1));

  (*                            Arithmetics                       *)
  (* Multiplication *)
  assert (fold_expr env_var (parse_expr "x * y") =! parse_expr "x * y");
  assert (fold_expr env_var (parse_expr "x * 1:u<V>8") =! parse_expr "x");

  assert (fold_expr env_var (parse_expr "1:u<V>8 * x") =! parse_expr "x");

  assert (
    fold_expr env_var (parse_expr "x * 0xff:u<V>8")
    =! parse_expr "x * 0xff:u<V>8");

  assert (
    fold_expr env_var (parse_expr "0xff:u<V>8 * x")
    =! parse_expr "0xff:u<V>8 * x");
  assert (fold_expr env_var (parse_expr "x * 0:u<V>8") =! parse_expr "0:u<V>8");
  assert (fold_expr env_var (parse_expr "0:u<V>8 * x") =! parse_expr "0:u<V>8");

  assert (
    fold_expr env_var (parse_expr "2:u<V>8 * 3:u<V>8") =! parse_expr "6:u<V>8");

  (* Addition *)
  assert (fold_expr env_var (parse_expr "x + y") =! parse_expr "x + y");
  assert (fold_expr env_var (parse_expr "x + 0:u<V>8") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0:u<V>8 + x") =! parse_expr "x");

  assert (
    fold_expr env_var (parse_expr "0:u<V>8 + 5:u<V>8") =! parse_expr "5:u<V>8");

  (* Subtraction *)
  assert (fold_expr env_var (parse_expr "x - y") =! parse_expr "x - y");
  assert (fold_expr env_var (parse_expr "x - 0:u<V>8") =! parse_expr "x");

  assert (
    fold_expr env_var (parse_expr "0:u<V>8 - x") =! parse_expr "0:u<V>8 - x");

  assert (
    fold_expr env_var (parse_expr "11:u<V>8 - 5:u<V>8") =! parse_expr "6:u<V>8");

  (* Division *)
  assert (fold_expr env_var (parse_expr "x / y") =! parse_expr "x / y");
  assert (fold_expr env_var (parse_expr "x / 1:u<V>8") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0:u<V>8 / x") =! parse_expr "0:u<V>8");

  assert (
    fold_expr env_var (parse_expr "11:u<V>8 / 5:u<V>8") =! parse_expr "2:u<V>8");

  (* Modulo *)
  assert (fold_expr env_var (parse_expr "x % y") =! parse_expr "x % y");
  assert (fold_expr env_var (parse_expr "x % 1:u<V>8") =! parse_expr "0:u<V>8");
  assert (fold_expr env_var (parse_expr "0:u<V>8 / x") =! parse_expr "0:u<V>8");

  assert (
    fold_expr env_var (parse_expr "11:u<V>8 % 5:u<V>8") =! parse_expr "1:u<V>8");

  (*                              Logical                         *)
  (* And *)
  assert (fold_expr env_var (parse_expr "x & y") =! parse_expr "x & y");
  assert (fold_expr env_var (parse_expr "x & 0xff:u<V>8") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0xff:u<V>8 & x") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "x & 0:u<V>8") =! parse_expr "0:u<V>8");
  assert (fold_expr env_var (parse_expr "0:u<V>8 & x") =! parse_expr "0:u<V>8");

  assert (
    fold_expr env_var (parse_expr "x & 1:u<V>8") =! parse_expr "x & 1:u<V>8");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 & x") =! parse_expr "1:u<V>8 & x");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 & 0x10:u<V>8")
    =! parse_expr "0:u<V>8");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 & 0x11:u<V>8")
    =! parse_expr "1:u<V>8");
  assert (fold_expr env_var (parse_expr "x & x") =! parse_expr "x");

  (* Or *)
  assert (fold_expr env_var (parse_expr "x | y") =! parse_expr "x | y");

  assert (
    fold_expr env_var (parse_expr "x | 0xff:u<V>8") =! parse_expr "0xff:u<V>8");

  assert (
    fold_expr env_var (parse_expr "0xff:u<V>8 | x") =! parse_expr "0xff:u<V>8");
  assert (fold_expr env_var (parse_expr "x | 0:u<V>8") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0:u<V>8 | x") =! parse_expr "x");

  assert (
    fold_expr env_var (parse_expr "x | 1:u<V>8") =! parse_expr "x | 1:u<V>8");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 | x") =! parse_expr "1:u<V>8 | x");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 | 0x10:u<V>8")
    =! parse_expr "0x11:u<V>8");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 | 0x11:u<V>8")
    =! parse_expr "0x11:u<V>8");
  assert (fold_expr env_var (parse_expr "x | x") =! parse_expr "x");

  (* Xor *)
  assert (fold_expr env_var (parse_expr "x ^ y") =! parse_expr "x ^ y");
  assert (fold_expr env_var (parse_expr "x ^ 0xff:u<V>8") =! parse_expr "~x");
  assert (fold_expr env_var (parse_expr "0xff:u<V>8 ^ x") =! parse_expr "~x");
  assert (fold_expr env_var (parse_expr "x ^ 0:u<V>8") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0:u<V>8 ^ x") =! parse_expr "x");

  assert (
    fold_expr env_var (parse_expr "x ^ 1:u<V>8") =! parse_expr "x ^ 1:u<V>8");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 ^ x") =! parse_expr "1:u<V>8 ^ x");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 ^ 0x10:u<V>8")
    =! parse_expr "0x11:u<V>8");

  assert (
    fold_expr env_var (parse_expr "1:u<V>8 ^ 0x11:u<V>8")
    =! parse_expr "0x10:u<V>8");
  assert (fold_expr env_var (parse_expr "x ^ x") =! parse_expr "0:u<V>8");

  (* Not *)
  assert (fold_expr env_var (parse_expr "~(0xff:u<V>8)") =! parse_expr "0:u<V>8");

  assert (
    fold_expr env_var (parse_expr "~(0x0:u<V>8)") =! parse_expr "0xff:u<V>8");
  assert (fold_expr env_var (parse_expr "~x") =! parse_expr "~x")

(* Skipping Andn tests because for now, I don't think Usuba ever
   generates Andn instructions... *)

let test_bitslice () =
  (* Setting up env *)
  let env_var = Ident.Hashtbl.create 10 in
  Ident.Hashtbl.add env_var (Ident.create_unbound "x")
    (Uint (Bslice, Mint 1, 1));
  Ident.Hashtbl.add env_var (Ident.create_unbound "y")
    (Uint (Bslice, Mint 1, 1));

  assert (fold_expr env_var (parse_expr "x & x") =! parse_expr "x");
  (*                              Logical                         *)
  (* And *)
  assert (fold_expr env_var (parse_expr "x & y") =! parse_expr "x & y");
  assert (fold_expr env_var (parse_expr "x & 1:u<B>1") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0x1:u<B>1 & x") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "x & 0:u<B>1") =! parse_expr "0:u<B>1");
  assert (fold_expr env_var (parse_expr "0:u<B>1 & x") =! parse_expr "0:u<B>1");

  assert (
    fold_expr env_var (parse_expr "1:u<B>1 & 0x0:u<B>1") =! parse_expr "0:u<B>1");

  assert (
    fold_expr env_var (parse_expr "1:u<B>1 & 0x1:u<B>1") =! parse_expr "1:u<B>1");

  (* Or *)
  assert (fold_expr env_var (parse_expr "x | y") =! parse_expr "x | y");
  assert (fold_expr env_var (parse_expr "x | 1:u<B>1") =! parse_expr "1:u<B>1");
  assert (fold_expr env_var (parse_expr "0x1:u<B>1 | x") =! parse_expr "1:u<B>1");
  assert (fold_expr env_var (parse_expr "x | 0:u<B>1") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0:u<B>1 | x") =! parse_expr "x");

  assert (
    fold_expr env_var (parse_expr "1:u<B>1 | 0x0:u<B>1") =! parse_expr "1:u<B>1");

  assert (
    fold_expr env_var (parse_expr "1:u<B>1 | 0x1:u<B>1") =! parse_expr "1:u<B>1");

  assert (
    fold_expr env_var (parse_expr "0:u<B>1 | 0x0:u<B>1") =! parse_expr "0:u<B>1");
  assert (fold_expr env_var (parse_expr "x | x") =! parse_expr "x");

  (* Xor *)
  assert (fold_expr env_var (parse_expr "x ^ y") =! parse_expr "x ^ y");
  assert (fold_expr env_var (parse_expr "x ^ 1:u<B>1") =! parse_expr "~x");
  assert (fold_expr env_var (parse_expr "0x1:u<B>1 ^ x") =! parse_expr "~x");
  assert (fold_expr env_var (parse_expr "x ^ 0:u<B>1") =! parse_expr "x");
  assert (fold_expr env_var (parse_expr "0:u<B>1 ^ x") =! parse_expr "x");

  assert (
    fold_expr env_var (parse_expr "1:u<B>1 ^ 0x0:u<B>1") =! parse_expr "1:u<B>1");

  assert (
    fold_expr env_var (parse_expr "1:u<B>1 ^ 0x1:u<B>1") =! parse_expr "0:u<B>1");

  assert (
    fold_expr env_var (parse_expr "0:u<B>1 ^ 0x0:u<B>1") =! parse_expr "0:u<B>1");
  assert (fold_expr env_var (parse_expr "x ^ x") =! parse_expr "0:u<B>1");

  (* Not *)
  assert (fold_expr env_var (parse_expr "~(1:u<B>1)") =! parse_expr "0:u<B>1");
  assert (fold_expr env_var (parse_expr "~(0:u<B>1)") =! parse_expr "1:u<B>1");
  assert (fold_expr env_var (parse_expr "~x") =! parse_expr "~x")

(* Skipping Andn tests because for now, I don't think Usuba ever
   generates Andn instructions... *)

let test () =
  test_vslice ();
  test_bitslice ()
