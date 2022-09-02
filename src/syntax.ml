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

let mk_var_d s typ =
  { vd_id = { (* TODO: fresh *) uid = 0; name = s };
    vd_typ = typ;
    vd_opts = [];
    vd_orig = [] }

let node ?(def_opt = []) s in_vars out_vars loc_vars k =
  let mk_vars = List.map (fun (x, t) -> mk_var_d x t) in
  let mk_exp = List.map (fun v -> ExpVar (Var v.vd_id)) in
  let p_in = mk_vars in_vars in
  let p_out = mk_vars out_vars in
  let p_loc = mk_vars loc_vars in
  { (* TODO: use fresh *)
    id = { uid = 0; name = s };
    p_in = p_in;
    p_out = p_out;
    opt = def_opt;
    node = Single (p_loc ,
                   List.map (fun eqs -> { content = eqs; orig = [] })
                     (k (mk_exp p_in)
                        (mk_exp p_out)
                        (mk_exp p_loc))) }

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

let [@warning "-8"] f =
  node "foo"
    ["a", Nat; "b", Nat; "c", Nat]
    ["x", Nat; "y", Nat]
    ["l1", Nat]
    (fun [a; b; c] [x; y] [l1] ->
      [[y] = x + a;
       [b; c] = b * y;
       [l1] = x * a])

let _ = Format.printf "%a\n" pp_def f
