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

open Usuba_AST
open Basic_utils
open Utils

(* Checks if an expression is 0 *)
let is_zero (e:expr) = match e with
  | Const(0,_) -> true
  | _ -> false

(* Checks if an expression is 1 *)
let is_one (e:expr) = match e with
  | Const(1,_) -> true
  | _ -> false

(* Checks if an expression is -1. Note that this depends on the
     expression's type: on a b1, -1 is 0b1; on a u8, -1 is
     0b11111111. *)
let is_full_ones (env_var:(ident,typ) Hashtbl.t) (e:expr) =
  match e with
  | Const(n,Some typ) ->
     let msize = match get_type_m typ with
       | Mint m -> m
       | _ -> Printf.eprintf "is_full_ones: need a fixed word size, got: %s:%s\n"
                (Usuba_print.expr_to_str e)
                (Usuba_print.typ_to_str (get_normed_expr_type env_var e));
              assert false in
     let minus_one = gen_minus_one msize in
     n land minus_one = minus_one
  | _ -> false


let fold_arith (env_var:(ident,typ) Hashtbl.t) (op:arith_op) (x:expr) (y:expr)
    : expr =
  (* Get the OCaml operator corresponding to the Usuba one. *)
  let ua_op_to_ml (op:arith_op) : int -> int -> int =
    match op with
    | Mul -> ( * )
    | Add -> ( + )
    | Sub -> ( - )
    | Div -> ( / )
    | Mod -> ( mod ) in
  (* If both |x| and |y| are constants, then computes |x op y|. *)
  let rec compute_const_arith (op:arith_op) (x:expr) (y:expr) : expr option =
    match x, y with
    | Const(xn,typ), Const(yn,_) -> Some(Const((ua_op_to_ml op) xn yn, typ))
    | _ -> None in

  (* First, try to fully compute |x op y|. *)
  match compute_const_arith op x y with
  | Some e -> e
  | None ->
     (* If |x op y| is not computable, then try to simplify it. *)
     let zero = Const(0, Some (get_normed_expr_type env_var x)) in
     match op with
     | Mul  -> if      is_zero x              then zero  (* 0 * _ = 0 *)
               else if is_zero y              then zero  (* _ * 0 = 0 *)
               else if is_one x               then y     (* 1 * y = y *)
               else if is_one y               then x     (* x * 1 = x *)
               else Arith(Mul,x,y)
     | Add  -> if      is_zero x              then y     (* 0 + y = y *)
               else if is_zero y              then x     (* x + 0 = x *)
               else Arith(Add,x,y)
     | Sub  -> if      is_zero y              then x     (* x - 0 = x *)
               else Arith(Sub,x,y)
     | Div  -> if      is_zero x              then zero  (* 0 / y = 0 *)
               else if is_one y               then x     (* x / 1 = x *)
               else Arith(Div,x,y)
     | Mod  -> if      is_zero x              then zero  (* 0 % y = 0 *)
               else if is_one y               then zero  (* _ % 1 = 0 *)
               else Arith(Mod,x,y)


let fold_log (env_var:(ident,typ) Hashtbl.t) (op:log_op) (x:expr) (y:expr)
    : expr =
  (* Get the OCaml operator corresponding to the Usuba one. *)
  let ua_op_to_ml (op:log_op) : int -> int -> int =
    match op with
    | And  -> ( land )
    | Or   -> ( lor  )
    | Xor  -> ( lxor )
    | Andn -> (fun x y -> (lnot x) land y) in
  (* If both |x| and |y| are constants, then computes |x op y|. *)
  let rec compute_const_log (op:log_op) (x:expr) (y:expr) : expr option =
    match x, y with
    | Const(xn,typ), Const(yn,_) -> Some (Const((ua_op_to_ml op) xn yn, typ))
    | _ -> None in

  (* First, try to fully compute |x op y|. *)
  match compute_const_log op x y with
  | Some e -> e
  | None ->
     (* If |x op y| is not computable, then try to simplify it. *)
     let zero = Const(0, Some(get_normed_expr_type env_var x)) in
     match op with
     | And  -> if      is_zero x              then zero  (* 0 & _ = 0 *)
               else if is_zero y              then zero  (* _ & 0 = 0 *)
               else if is_full_ones env_var x then y     (* 1 & y = y *)
               else if is_full_ones env_var y then x     (* x & 1 = x *)
               else Log(And,x,y)
     | Or   -> if      is_zero x              then y  (* 0 | y = y *)
               else if is_zero y              then x  (* x | 0 = x *)
               else if is_full_ones env_var x then x  (* 1 | y = 1 *)
               else if is_full_ones env_var y then y  (* x | 1 = 1 *)
               else Log(Or,x,y);
     | Xor  -> if      is_zero x              then y       (* 0 ^ y = y  *)
               else if is_zero y              then x       (* x ^ 0 = x  *)
               else if is_full_ones env_var x then Not(y)  (* 1 ^ y = ~y *)
               else if is_full_ones env_var y then Not(x)  (* x ^ 1 = ~x *)
               else Log(Xor,x,y)
     | Andn -> if      is_zero x              then y       (* ~0 & y = y  *)
               else if is_zero y              then zero    (* ~x & 0 = 0  *)
               else if is_full_ones env_var x then zero    (* ~1 & y = 0 *)
               else if is_full_ones env_var y then Not(x)  (* ~x & 1 = ~x *)
               else Log(Andn,x,y)

(* Common documentation for all functions bellow: straight-forwardly
   walks down the AST to finally call fold_log and fold_arith. *)

let rec fold_expr (env_var:(ident,typ) Hashtbl.t) (e:expr) : expr =
  match e with
  | Const _         -> e
  | ExpVar _        -> e
  | Shuffle _       -> e
  | Tuple l         -> Tuple (List.map (fold_expr env_var) l)
  | Not e'          -> Not (fold_expr env_var e')
  | Shift(op,e,ae)  -> Shift(op,fold_expr env_var e,ae)
  | Log(op,e1,e2)   -> fold_log env_var op (fold_expr env_var e1)
                         (fold_expr env_var e2)
  | Arith(op,e1,e2) -> fold_arith env_var op (fold_expr env_var e1)
                         (fold_expr env_var e2)
  | Fun(f,l)        -> Fun(f,List.map (fold_expr env_var) l)
  | _ -> Printf.eprintf "fold_expr: Cannot fold unnormalized expression: %s.\n"
           (Usuba_print.expr_to_str e);
         assert false


let rec fold_deqs (env_var:(ident,typ) Hashtbl.t) (deqs:deq list) : deq list =
  List.map (function
      | Eqn(lhs,e,sync) -> Eqn(lhs,fold_expr env_var e,sync)
      | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,fold_deqs env_var dl,opts)) deqs

let fold_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let env_var = build_env_var def.p_in def.p_out vars in
     { def with node = Single(vars,fold_deqs env_var body) }
  | _ -> def

let fold_prog (prog:prog) (conf:config) : prog =
  { nodes = List.map fold_def prog.nodes }
