open Usuba_AST

(* Static expressions *)

module S = struct
  let c i = Const_e i
  let v x = Var_e x
  let ( + ) e1 e2 = Op_e (Add, e1, e2)
  let ( * ) e1 e2 = Op_e (Mul, e1, e2)
  let ( - ) e1 e2 = Op_e (Sub, e1, e2)
  let ( / ) e1 e2 = Op_e (Div, e1, e2)
  let ( % ) e1 e2 = Op_e (Mod, e1, e2)
end

(* Types *)

let nat = Nat
let array typ k = Array (typ, k)
let _D = Varslice (Ident.create_unbound "D")
let _m = Mvar (Ident.create_unbound "m")
let u dir m n = Uint (dir, m, n)
let u1 dir m = Uint (dir, m, 1)
let d i = u _D _m i
let b i = u _D (Mint 1) i

(* Expressions *)

let c ?typ i = Const (i, typ)
let v s = ExpVar (Var (Ident.create_unbound s))

let proj k1 ?k2 v =
  match v with
  | ExpVar v -> (
      match k2 with
      | None -> ExpVar (Index (v, k1))
      | Some k2 -> ExpVar (Range (v, k1, k2)))
  | _ -> failwith "proj: expects a variable"

let proj_slice ks v =
  match v with
  | ExpVar v -> ExpVar (Slice (v, ks))
  | _ -> failwith "proj_slice: expects a variable"

let t es = Tuple es
let not e = Not e
let ( land ) e1 e2 = Log (And, e1, e2)
let ( lor ) e1 e2 = Log (Or, e1, e2)
let ( lxor ) e1 e2 = Log (Xor, e1, e2)
let ( &&~ ) e1 e2 = Log (Andn, e1, e2)

let masked e =
  match e with
  | Log (((And | Or | Xor | Andn) as op), e1, e2) -> Log (Masked op, e1, e2)
  | _ -> failwith "masked: invalid input expression"

let ( + ) e1 e2 = Arith (Add, e1, e2)
let ( * ) e1 e2 = Arith (Mul, e1, e2)
let ( - ) e1 e2 = Arith (Sub, e1, e2)
let ( / ) e1 e2 = Arith (Div, e1, e2)
let ( % ) e1 e2 = Arith (Mod, e1, e2)
let ( lsl ) e k = Shift (Lshift, e, k)
let ( lsr ) e k = Shift (Rshift, e, k)
let ( asr ) e k = Shift (RAshift, e, k)
let ( <<< ) e k = Shift (Lrotate, e, k)
let ( >>> ) e k = Shift (Rrotate, e, k)
let shuffle v is = Shuffle (v, is)
let bitmask e k = Bitmask (e, k)
let pack ?typ e1 e2 = Pack (e1, e2, typ)

let call ?k f args =
  match k with None -> Fun (f, args) | Some k -> Fun_v (f, k, args)

(* Nodes *)

let ( = ) vs e =
  let force = function
    | ExpVar v -> v
    | _ -> failwith "(=): lhs of equation is not a variable"
  in
  Eqn (List.map force vs, e, false)

let mk_deq_i = List.map (fun eqs -> { content = eqs; orig = [] })

let forall ?(opts = []) i start stop eqs =
  let id = Ident.create_unbound i in
  let body = mk_deq_i (eqs (Var_e id)) in
  Loop { id; start; stop; body; opts }

let mk_var_d s vd_typ =
  { vd_id = Ident.create_unbound s; vd_typ; vd_opts = []; vd_orig = [] }

let define s def k =
  let id = Ident.create_unbound s in
  let t = def id in
  t :: k (call id)

let main def = def (fun _ -> [])

let node ?(def_opt = []) s in_vars out_vars ?(locals = []) is k =
  let mk_vars = List.map (fun (x, t) -> mk_var_d x t) in
  let mk_exp = List.map (fun v -> ExpVar (Var v.vd_id)) in
  let p_in = mk_vars in_vars in
  let p_out = mk_vars out_vars in
  let p_loc = mk_vars locals in
  let def id =
    {
      id;
      p_in;
      p_out;
      opt = def_opt;
      node =
        Single (p_loc, mk_deq_i (is (mk_exp p_in) (mk_exp p_out) (mk_exp p_loc)));
    }
  in
  define s def k

let table ?(def_opt = []) s (in_var, in_typ) (out_var, out_typ) is k =
  let def id =
    {
      id;
      p_in = [ mk_var_d in_var in_typ ];
      p_out = [ mk_var_d out_var out_typ ];
      opt = def_opt;
      node = Table is;
    }
  in
  define s def k

let perm ?(def_opt = []) s (in_var, in_typ) (out_var, out_typ) is k =
  let def id =
    {
      id;
      p_in = [ mk_var_d in_var in_typ ];
      p_out = [ mk_var_d out_var out_typ ];
      opt = def_opt;
      node = Perm is;
    }
  in
  define s def k

let multi_table ?(def_opt = []) s (in_var, in_typ) (out_var, out_typ) iss k =
  let def id =
    {
      id;
      p_in = [ mk_var_d in_var in_typ ];
      p_out = [ mk_var_d out_var out_typ ];
      opt = def_opt;
      node = Multiple (List.map (fun x -> Table x) iss);
    }
  in
  define s def k

let multi_perm ?(def_opt = []) s (in_var, in_typ) (out_var, out_typ) iss k =
  let def id =
    {
      id;
      p_in = [ mk_var_d in_var in_typ ];
      p_out = [ mk_var_d out_var out_typ ];
      opt = def_opt;
      node = Multiple (List.map (fun x -> Perm x) iss);
    }
  in
  define s def k

(* Chaining definitions *)

let ( let* ) k n = k n
let eof = []

(* Example *)

module Examples = struct
  let[@warning "-8"] [ f ] =
    main
      (node "foo"
         [ ("a", Nat); ("b", Nat); ("c", Nat) ]
         [ ("x", Nat); ("y", Nat) ]
         ~locals:[ ("l1", Nat) ]
         (fun [ a; b; c ] [ x; y ] [ l1 ] ->
           [ [ y ] = x + a; [ b; c ] = b * y; [ l1 ] = x * a ]))

  let%test "foo_test" =
    let res = Format.asprintf "%a" pp_def f in
    let expect =
      {|{ id = (Ident.create_unbound "foo");
  p_in =
  [{ vd_id = (Ident.create_unbound "a"); vd_typ = Nat; vd_opts = [];
     vd_orig = [] };
    { vd_id = (Ident.create_unbound "b"); vd_typ = Nat; vd_opts = [];
      vd_orig = [] };
    { vd_id = (Ident.create_unbound "c"); vd_typ = Nat; vd_opts = [];
      vd_orig = [] }
    ];
  p_out =
  [{ vd_id = (Ident.create_unbound "x"); vd_typ = Nat; vd_opts = [];
     vd_orig = [] };
    { vd_id = (Ident.create_unbound "y"); vd_typ = Nat; vd_opts = [];
      vd_orig = [] }
    ];
  opt = [];
  node =
  (Single (
     [{ vd_id = (Ident.create_unbound "l1"); vd_typ = Nat; vd_opts = [];
        vd_orig = [] }
       ],
     [{ content =
        (Eqn ([(Var (Ident.create_unbound "y"))],
           (Arith (Add, (ExpVar (Var (Ident.create_unbound "x"))),
              (ExpVar (Var (Ident.create_unbound "a"))))),
           false));
        orig = [] };
       { content =
         (Eqn (
            [(Var (Ident.create_unbound "b"));
              (Var (Ident.create_unbound "c"))],
            (Arith (Mul, (ExpVar (Var (Ident.create_unbound "b"))),
               (ExpVar (Var (Ident.create_unbound "y"))))),
            false));
         orig = [] };
       { content =
         (Eqn ([(Var (Ident.create_unbound "l1"))],
            (Arith (Mul, (ExpVar (Var (Ident.create_unbound "x"))),
               (ExpVar (Var (Ident.create_unbound "a"))))),
            false));
         orig = [] }
       ]
     ))
  }|}
    in
    Stdlib.(res = expect)

  let[@warning "-8"] aes =
    let* _SubBytes_single =
      table ~def_opt:[ Is_table ] "SubBytes_single"
        ("input", d 8)
        ("output", d 8)
        [99; 124; 119; 123; 242; 107; 111; 197; 48; 1; 103; 43; 254; 215; 171; 118;
         202; 130; 201; 125; 250; 89; 71; 240; 173; 212; 162; 175; 156; 164; 114; 192;
         183; 253; 147; 38; 54; 63; 247; 204; 52; 165; 229; 241; 113; 216; 49; 21;
         4; 199; 35; 195; 24; 150; 5; 154; 7; 18; 128; 226; 235; 39; 178; 117;
         9; 131; 44; 26; 27; 110; 90; 160; 82; 59; 214; 179; 41; 227; 47; 132;
         83; 209; 0; 237; 32; 252; 177; 91; 106; 203; 190; 57; 74; 76; 88; 207;
         208; 239; 170; 251; 67; 77; 51; 133; 69; 249; 2; 127; 80; 60; 159; 168;
         81; 163; 64; 143; 146; 157; 56; 245; 188; 182; 218; 33; 16; 255; 243; 210;
         205; 12; 19; 236; 95; 151; 68; 23; 196; 167; 126; 61; 100; 93; 25; 115;
         96; 129; 79; 220; 34; 42; 144; 136; 70; 238; 184; 20; 222; 94; 11; 219;
         224; 50; 58; 10; 73; 6; 36; 92; 194; 211; 172; 98; 145; 149; 228; 121;
         231; 200; 55; 109; 141; 213; 78; 169; 108; 86; 244; 234; 101; 122; 174; 8;
         186; 120; 37; 46; 28; 166; 180; 198; 232; 221; 116; 31; 75; 189; 139; 138;
         112; 62; 181; 102; 72; 3; 246; 14; 97; 53; 87; 185; 134; 193; 29; 158;
         225; 248; 152; 17; 105; 217; 142; 148; 155; 30; 135; 233; 206; 85; 40; 223;
         140; 161; 137; 13; 191; 230; 66; 104; 65; 153; 45; 15; 176; 84; 187; 22] [@ocamlformat "disable"]
    in

    let* _SubBytes =
      node "SubBytes"
        [ ("inputSB", array (b 8) (S.c 16)) ]
        [ ("out", array (b 8) (S.c 16)) ]
        (fun [ inputSB ] [ out ] [] ->
          [
            forall "i" (S.c 0) (S.c 15) (fun i ->
                [ [ proj i out ] = _SubBytes_single [ proj i inputSB ] ]);
          ])
    in

    let* _ShiftRows =
      node "ShiftRows"
        [ ("inputSR", array (b 8) (S.c 16)) ]
        [ ("output", array (b 1) (S.c 128)) ]
        (fun [ inputSR ] [ output ] [] ->
          [
            [ output ]
            = proj_slice
                (List.map S.c
                   [ 0; 5; 10; 15; 4; 9; 14; 3; 8; 13; 2; 7; 12; 1; 6; 11 ])
                inputSR;
          ])
    in

    let* times2 =
      node "times2"
        [ ("i", array (b 1) (S.c 8)) ]
        [ ("o", array (b 1) (S.c 8)) ]
        (fun [ i ] [ o ] [] ->
          [
            [ o ]
            = (i lsl S.c 1)
              lxor t
                     [
                       c 0;
                       c 0;
                       c 0;
                       proj (S.c 0) i;
                       proj (S.c 0) i;
                       c 0;
                       proj (S.c 0) i;
                       proj (S.c 0) i;
                     ];
          ])
    in

    let* times3 =
      node "times3"
        [ ("i", array (b 1) (S.c 8)) ]
        [ ("o", array (b 1) (S.c 8)) ]
        (fun [ i ] [ o ] [] -> [ [ o ] = times2 [ i ] lxor i ])
    in

    let* _MixColumn_single =
      node "MixColumn_single"
        [ ("inp", array (b 8) (S.c 4)) ]
        [ ("out", array (b 8) (S.c 4)) ]
        (fun [ inp ] [ out ] [] ->
          let times2 i = times2 [ i ] in
          let times3 i = times3 [ i ] in
          let out0 = proj (S.c 0) out in
          let out1 = proj (S.c 1) out in
          let out2 = proj (S.c 2) out in
          let out3 = proj (S.c 3) out in
          let inp0 = proj (S.c 0) inp in
          let inp1 = proj (S.c 1) inp in
          let inp2 = proj (S.c 2) inp in
          let inp3 = proj (S.c 3) inp in
          [
            [ out0 ] = times2 inp0 lxor times3 inp1 lxor inp2 lxor inp3;
            [ out1 ] = inp0 lxor times2 inp1 lxor times3 inp2 lxor inp3;
            [ out2 ] = inp0 lxor inp1 lxor times2 inp2 lxor times3 inp3;
            [ out3 ] = times3 inp0 lxor inp1 lxor inp2 lxor times2 inp3;
          ])
    in

    let* _MixColumn =
      node "MixColumn"
        [ ("inp", array (b 32) (S.c 4)) ]
        [ ("out", array (b 32) (S.c 4)) ]
        (fun [ inp ] [ out ] [] ->
          [
            forall "i" (S.c 0) (S.c 3) (fun i ->
                [ [ proj i out ] = _MixColumn_single [ proj i inp ] ]);
          ])
    in

    let* _AddRoundKey =
      node "AddRoundKey"
        [ ("i", b 128); ("key", b 128) ]
        [ ("r", b 128) ]
        (fun [ i; key ] [ r ] [] -> [ [ r ] = i lxor key ])
    in

    main
      (node "AES"
         [ ("plain", b 128); ("key", array (b 128) (S.c 11)) ]
         [ ("cipher", array (b 1) (S.c 128)) ]
         ~locals:[ ("tmp", array (b 128) (S.c 10)) ]
         (fun [ plain; key ] [ cipher ] [ tmp ] ->
           let _AddRoundKey plain key = _AddRoundKey [ plain; key ] in
           let _MixColumn inp = _MixColumn [ inp ] in
           let _ShiftRows inp = _ShiftRows [ inp ] in
           let _SubBytes inp = _SubBytes [ inp ] in
           [
             [ proj (S.c 0) tmp ] = _AddRoundKey plain (proj (S.c 0) key);
             forall "i" (S.c 1) (S.c 9) (fun i ->
                 [
                   [ proj i tmp ]
                   = _AddRoundKey
                       (_MixColumn
                          (_ShiftRows (_SubBytes (proj S.(i - c 1) tmp))))
                       (proj i key);
                 ]);
             [ cipher ]
             = _AddRoundKey
                 (_ShiftRows (_SubBytes (proj (S.c 9) tmp)))
                 (proj (S.c 10) key);
           ]))

  (* let%test "internal_aes" = *)
  (*   let res = { nodes = aes } in *)
  (*   let expect = *)
  (*     Parser_api.parse_file [] "../../../../examples/samples/usuba/aes.ua" *)
  (*   in *)
  (*   Usuba_AST.equal_prog res expect *)
end
