open Usuba_AST

module Static = struct
  let c i = Const_e i
  let v x = Var_e x
  let (+) e1 e2 = Op_e (Add, e1, e2)
  let ( * ) e1 e2 = Op_e (Mul, e1, e2)
  let (-) e1 e2 = Op_e (Sub, e1, e2)
  let (/) e1 e2 = Op_e (Div, e1, e2)
  let (%) e1 e2 = Op_e (Mod, e1, e2)
end

let c ?typ i = Const (i, typ)

(* let v x = var x *)

let proj k1 ?k2 v =
  match v with
  | ExpVar v ->
     begin match k2 with
     | None -> Index (v, k1)
     | Some k2 -> Range (v, k1, k2)
     end
  | _ -> failwith "proj: expects a variable"

let proj_slice v ks =
  match v with
  | ExpVar v -> Slice (v, ks)
  | _ -> failwith "proj_slice: expects a variable"

let t es = Tuple es
let not e = Not e

let (&&) e1 e2 = Log (And, e1, e2)
let (||) e1 e2 = Log (Or, e1, e2)
let (^) e1 e2 = Log (Xor, e1, e2)
let (&&!) e1 e2 = Log (Andn, e1, e2)
let masked e =
  match e with
  | Log (And, e1, e2) -> Log (Masked And, e1, e2)
  | Log (Or, e1, e2) -> Log (Masked Or, e1, e2)
  | Log (Xor, e1, e2) -> Log (Masked Xor, e1, e2)
  | Log (Andn, e1, e2) -> Log (Masked Andn, e1, e2)
  | _ -> failwith "masked: invalid input expression"

let (+) e1 e2 = Arith (Add, e1, e2)
let ( * ) e1 e2 = Arith (Mul, e1, e2)
let (-) e1 e2 = Arith (Sub, e1, e2)
let (/) e1 e2 = Arith (Div, e1, e2)
let (%) e1 e2 = Arith (Mod, e1, e2)

let (lsl) e k = Shift (Lshift, e, k)
let (lsr) e k = Shift (Rshift, e, k)
let (asr) e k = Shift (RAshift, e, k)
let (<<<) e k = Shift (Lrotate, e, k)
let (>>>) e k = Shift (Rrotate, e, k)

let shuffle v is = Shuffle (v, is)
let bitmask e k = Bitmask (e, k)

let pack ?typ e1 e2 = Pack (e1, e2, typ)

let call f args = Fun (f, args)
let call_at f k args = Fun_v (f, k, args)

type z = ZZ
type 'a s = SS

type _ vars =
  | Z : z vars
  | S : string * typ * 'n vars -> ('n s) vars

type ('a, _) tup =
  | T0 : ('a, z) tup
  | T1 : 'a -> ('a, z s) tup
  | T2 : 'a * 'a -> ('a, z s s) tup
  | T3 : 'a * 'a * 'a -> ('a, z s s s) tup

let mk_var_d s typ =
  { vd_id = { (* TODO: fresh *) uid = 0; name = s };
    vd_typ = typ;
    vd_opts = [];
    vd_orig = [] }

let mk_tup : type k. k vars -> (var_d, k) tup =
  fun k ->
  match k with
  | Z -> T0
  | S (ident, typ, Z) ->
     T1 (mk_var_d ident typ)
  | S (ident1, typ1, S (ident2, typ2, Z)) ->
     T2 (mk_var_d ident1 typ1, mk_var_d ident2 typ2)
  | S (ident1, typ1, S (ident2, typ2, S (ident3, typ3, Z))) ->
     T3 (mk_var_d ident1 typ1, mk_var_d ident2 typ2, mk_var_d ident3 typ3)
  | _ -> failwith "tup: unsupported beyond 3"

let map_tup: type k. ('a -> 'b) -> ('a, k) tup -> ('b, k) tup =
  fun f -> function
        | T0 -> T0
        | T1 a -> T1 (f a)
        | T2 (a1, a2) -> T2 (f a1, f a2)
        | T3 (a1, a2, a3) -> T3 (f a1, f a2, f a3)

let to_list : type n. ('a, n) tup -> 'a list  = function
    | T0 -> []
    | T1 a -> [a]
    | T2 (a, b) -> [a; b]
    | T3 (a, b, c) -> [a; b; c]

let node : type i o l. ?def_opt: def_opt list -> string -> i vars -> o vars -> l vars -> ((expr, i) tup -> (expr, o) tup -> (expr, l) tup -> deq_i list) -> def =
  fun ?(def_opt = []) s i o l k ->
  let p_in = mk_tup i in
  let p_out = mk_tup o in
  let p_loc = mk_tup l in
  { (* TODO: use fresh *)
    id = { uid = 0; name = s };
    p_in = to_list p_in;
    p_out = to_list p_out;
    opt = def_opt;
    node = Single (to_list p_loc , List.map (fun eqs -> { content = eqs; orig = [] }) (k (map_tup (fun v -> ExpVar (Var v.vd_id)) p_in) (map_tup (fun v -> ExpVar (Var v.vd_id)) p_out) (map_tup (fun v -> ExpVar (Var v.vd_id)) p_loc))) }

let (=) vs e =
  let force = function
    | ExpVar v -> v
    | _ -> failwith "(=): lhs of equation is not a variable"
  in
  Eqn (List.map force vs, e, false)

let loop ?(opts = []) ki ke eqs =
  (* TODO: use fresh *)
  let x = { uid = 0; name = "foo" } in
  Loop (x, ki, ke, eqs x, opts)

let f = node "foo"
          (S ("a", Nat,
              S ("b", Nat,
                 S ("c", Nat, Z))))
          (S ("x", Nat,
              S ("y", Nat, Z)))
          (S ("l1", Nat, Z))
          (fun (T3 (a, b, c)) (T2 (x, y)) (T1 l1) ->
            [[y] = x + a;
             [b; c] = b * y;
             [l1] = x * a])

let _ = Format.printf "%a\n" pp_def f
