(*********************************************************************
                          mask.ml

  Masks a program: each variable becomes an array of size
  MASKING_ORDER. Linear operators (xors) become loops. Non-linear
  operators (and, or) are left as-is (the generated C will use the
  appropriate macros).

 ********************************************************************)

open Prelude
open Usuba_AST

(* A hashtable to store the possible parameter constness for each
   function. It is updated everytime Get_consts.get_consts_def is
   called. TODO: it would be cleaner to initialize it only once at the
   begining, and not have a global variable for that. *)
let fun_params : bool list list Ident.Hashtbl.t = Ident.Hashtbl.create 100

(* This modules finds out which variables in a function are
   constants. This is useful because non-linear operations (and/or)
   are expensive to mask if they are between variables, but don't
   require special care if one of their operands is a constant. *)
(* This module works in the following way: initially, variables marked
   const are added to a constant set, and non-const inputs are added
   to a non-constant set. Then, every time a variable is set, if its
   operands are all consts, then it's added to the const set, else
   it's added to the non-const set (and remove from the const set;
   where it could be it is an array and a previous assignment in one
   of its index was const). *)
module Get_consts = struct
  let rec var_is_const (env_const : bool Ident.Hashtbl.t)
      (env_not_const : bool Ident.Hashtbl.t) (v : var) : bool =
    let id = Utils.get_base_name v in
    (* Not that a variable _cannot_ be in both |env_const| and
          |env_not_const|. The following 2 asserts make sure of that,
          even though it shouldn't be necessary to check it. *)
    if Ident.Hashtbl.mem env_const id then (
      if Ident.Hashtbl.mem env_not_const id then
        Format.printf "%a is both const and not const\n" (Ident.pp ()) id;
      assert (not (Ident.Hashtbl.mem env_not_const id));
      true)
    else (
      assert (Ident.Hashtbl.mem env_not_const id);
      false)

  and expr_is_const (env_fun : def Ident.Hashtbl.t)
      (env_const : bool Ident.Hashtbl.t) (env_not_const : bool Ident.Hashtbl.t)
      (e : expr) : bool list =
    let rec_call = expr_is_const env_fun env_const env_not_const in
    match e with
    | Const _ -> [ true ]
    | ExpVar v -> [ var_is_const env_const env_not_const v ]
    | Tuple l -> Basic_utils.flat_map rec_call l
    | Not e' -> rec_call e'
    | Log (_, x, y) -> List.map2 (fun a b -> a && b) (rec_call x) (rec_call y)
    | Arith (_, x, y) -> List.map2 (fun a b -> a && b) (rec_call x) (rec_call y)
    | Shift (_, e', _) -> rec_call e'
    | Shuffle (v, _) -> [ var_is_const env_const env_not_const v ]
    | Bitmask (e', _) -> rec_call e'
    | Pack (e1, e2, _) ->
        List.map2 (fun a b -> a && b) (rec_call e1) (rec_call e2)
    | Fun (f, l) ->
        let params_consts = Basic_utils.flat_map rec_call l in
        if String.equal (Ident.name f) "refresh" then params_consts
        else get_consts_inner_def env_fun params_consts f
    | Fun_v _ ->
        Format.eprintf "expr_is_const: not supported expression: %a.@."
          (Usuba_print.pp_expr ()) e;
        assert false

  and get_consts_deqs (env_fun : def Ident.Hashtbl.t)
      (env_const : bool Ident.Hashtbl.t) (env_not_const : bool Ident.Hashtbl.t)
      (deqs : deq list) : unit =
    List.iter
      (fun d ->
        match d.content with
        | Eqn (lhs, e, _) ->
            List.iter2
              (fun v is_const ->
                let id = Utils.get_base_name v in
                if is_const then
                  match Ident.Hashtbl.find_opt env_not_const id with
                  | Some _ -> ()
                  | None -> Ident.Hashtbl.replace env_const id true
                else (
                  Ident.Hashtbl.replace env_not_const id true;
                  match Ident.Hashtbl.find_opt env_const id with
                  | Some _ -> Ident.Hashtbl.remove env_const id
                  | None -> ()))
              lhs
              (expr_is_const env_fun env_const env_not_const e)
        | Loop (_, _, _, _, _) -> assert false
        (* Loops have been unrolled *))
      deqs

  (* This function is used on node calls: it returns the constness of
     the return values of |def| rather than an environment with the
     constness of all variables of |def|. *)
  and get_consts_inner_def (env_fun : def Ident.Hashtbl.t)
      (consts_in : bool list) (f : ident) : bool list =
    (* Updating |fun_params| *)
    (* STDLIB_IMPORT: Comparing to an empty list *)
    (if Stdlib.(consts_in <> []) then
     match Ident.Hashtbl.find_opt fun_params f with
     | Some l -> Ident.Hashtbl.replace fun_params f (consts_in :: l)
     | None -> Ident.Hashtbl.add fun_params f [ consts_in ]);

    let def = Ident.Hashtbl.find env_fun f in

    let env_const = get_consts_def env_fun ~consts_in def in

    List.map (fun vd -> Ident.Hashtbl.mem env_const vd.vd_id) def.p_out

  (* Returns a hash containing the constness of all variables of |def|. *)
  and get_consts_def (env_fun : def Ident.Hashtbl.t)
      ?(consts_in : bool list = []) (def : def) : bool Ident.Hashtbl.t =
    match def.node with
    | Single (_, body) ->
        let env_const = Ident.Hashtbl.create 10 in
        let env_not_const = Ident.Hashtbl.create 10 in
        (* Setting up |env_const|. *)
        if List.length consts_in <> 0 then
          List.iter2
            (fun vd b ->
              if b then Ident.Hashtbl.add env_const vd.vd_id true
              else Ident.Hashtbl.add env_not_const vd.vd_id true)
            def.p_in consts_in
        else
          (* Parameters are assumed not const by default, while nothing
             is assumed for local variables, nor for output variables. *)
          List.iter
            (fun vd -> Ident.Hashtbl.add env_not_const vd.vd_id true)
            def.p_in;

        (* Note: we need to unroll the loops before trying to find the
            constants, since an iteration could change a constant into
            a non-constant. For instance:

                x[0] = 0;
                forall i in [0, 4] {
                  y[i] = x[i] ^ 0xf0f0;
                  x[i+1] = x[i] ^ secret_input[i];
                }

            When stumbling upon `y[i] = x[i] ^ 0xf0f0` for the first time,
            `x[i]` is thought to be constant (since `x` was set const when
            doing `x[0] = 0`), but in the end of the iteration it turns
            out than `x` is actually no constant.
        *)
        let body =
          Unroll.unroll_deqs (Ident.Hashtbl.create 10) true def.id body
        in

        (*                            ^^^^^^^^^^^^^^^^^^  ^^^^             *)
        (*                                   env_it       force            *)
        get_consts_deqs env_fun env_const env_not_const body;

        (* Removing non-constant variables from |env_const|. It could
           happen because for instance the first cell of an array is
           constant but not the next ones. In that case, we remove the
           whole array. This is a bit approximative: ideally we would
           like a finer analysis. TODO! *)
        Ident.Hashtbl.iter
          (fun id _ -> Ident.Hashtbl.remove env_const id)
          env_not_const;

        env_const
    | _ ->
        (* This case should be catched somewhere else (eg, on the caller's side) *)
        assert false
end

let masking_order = Ident.create_constant "MASKING_ORDER"
let loop_end = Op_e (Sub, Var_e masking_order, Const_e 1)
let loop_idx = Ident.create_constant "_mask_idx"
let make_loop_indexed (v : var) : var = Index (v, Var_e loop_idx)

let mask_var (env_var : typ Ident.Hashtbl.t) (env_const : bool Ident.Hashtbl.t)
    (orig : (ident * deq_i) list) (vl : var) (ve : var) : deq list =
  match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
  | true -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name ve) with
      | true ->
          (* const = const *)
          [ { orig; content = Eqn ([ vl ], ExpVar ve, false) } ]
      | false ->
          (* const = var *)
          Printf.eprintf "Cannot convert non-constant into constant.\n";
          assert false)
  | false -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name ve) with
      | true ->
          (* var = const *)
          let typ = Utils.get_var_type env_var vl in
          [
            {
              orig;
              content = Eqn ([ Index (vl, Const_e 0) ], ExpVar ve, false);
            };
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 1,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Const (0, Some typ),
                              false );
                      };
                    ],
                    [] );
            };
          ]
      | false ->
          (* var = var *)
          [
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 0,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              ExpVar (make_loop_indexed ve),
                              false );
                      };
                    ],
                    [] );
            };
          ])
(*                                                            ^^^^^    ^^ *)
(*                                                   (eqn's sync)  (loop's opts)   *)

let mask_cst (env_const : bool Ident.Hashtbl.t) (orig : (ident * deq_i) list)
    (vl : var) (c : int) (typ : typ option) : deq list =
  match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
  | true ->
      (* const = const *)
      [ { orig; content = Eqn ([ vl ], Const (c, typ), false) } ]
  | false ->
      (* var = const *)
      if c = 0 then
        [
          {
            orig;
            content =
              Loop
                ( loop_idx,
                  Const_e 0,
                  loop_end,
                  [
                    {
                      orig;
                      content =
                        Eqn ([ make_loop_indexed vl ], Const (0, typ), false);
                    };
                  ],
                  [] );
          };
        ]
      else
        [
          {
            orig;
            content = Eqn ([ Index (vl, Const_e 0) ], Const (c, typ), false);
          };
          {
            orig;
            content =
              Loop
                ( loop_idx,
                  Const_e 1,
                  loop_end,
                  [
                    {
                      orig;
                      content =
                        Eqn ([ make_loop_indexed vl ], Const (0, typ), false);
                    };
                  ],
                  [] );
          };
        ]

let mask_shift (env_var : typ Ident.Hashtbl.t)
    (env_const : bool Ident.Hashtbl.t) (orig : (ident * deq_i) list) (vl : var)
    (op : shift_op) (ve : var) (ae : arith_expr) : deq list =
  match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
  | true -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name ve) with
      | true ->
          (* const = const *)
          [ { orig; content = Eqn ([ vl ], Shift (op, ExpVar ve, ae), false) } ]
      | false ->
          (* const = var *)
          Printf.eprintf "Cannot convert non-constant into constant.\n";
          assert false)
  | false -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name ve) with
      | true ->
          (* var = const *)
          let typ = Utils.get_var_type env_var vl in
          [
            { orig; content = Eqn ([ vl ], Shift (op, ExpVar ve, ae), false) };
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 1,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Const (0, Some typ),
                              false );
                      };
                    ],
                    [] );
            };
          ]
      | false ->
          (* var = var *)
          [
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 0,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Shift (op, ExpVar (make_loop_indexed ve), ae),
                              false );
                      };
                    ],
                    [] );
            };
          ])

let mask_not (env_var : typ Ident.Hashtbl.t) (env_const : bool Ident.Hashtbl.t)
    (orig : (ident * deq_i) list) (vl : var) (ve : var) : deq list =
  match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
  | true -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name ve) with
      | true ->
          (* const = const *)
          [ { orig; content = Eqn ([ vl ], Not (ExpVar ve), false) } ]
      | false ->
          (* const = var *)
          Printf.eprintf "Cannot convert non-constant into constant.\n";
          assert false)
  | false -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name ve) with
      | true ->
          (* var = const *)
          let typ = Utils.get_var_type env_var vl in
          [
            {
              orig;
              content = Eqn ([ Index (vl, Const_e 0) ], Not (ExpVar ve), false);
            };
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 1,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Const (0, Some typ),
                              false );
                      };
                    ],
                    [] );
            };
          ]
      | false ->
          (* var = var *)
          [
            {
              orig;
              content =
                Eqn
                  ( [ Index (vl, Const_e 0) ],
                    Not (ExpVar (Index (ve, Const_e 0))),
                    false );
            };
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 1,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              ExpVar (make_loop_indexed ve),
                              false );
                      };
                    ],
                    [] );
            };
          ])

type is_const = Zero | One | Two

let mask_xor (env_var : typ Ident.Hashtbl.t) (env_const : bool Ident.Hashtbl.t)
    (orig : (ident * deq_i) list) (vl : var) (x : var) (y : var) : deq list =
  let cst, x, y =
    if
      Ident.Hashtbl.mem env_const (Utils.get_base_name x)
      && Ident.Hashtbl.mem env_const (Utils.get_base_name y)
    then (Two, x, y)
    else if Ident.Hashtbl.mem env_const (Utils.get_base_name x) then (One, y, x)
    else if Ident.Hashtbl.mem env_const (Utils.get_base_name y) then (One, x, y)
    else (Zero, x, y)
  in
  let typ = Utils.get_var_type env_var x in
  match cst with
  | Zero -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
      | true ->
          (* const = var ^ var *)
          Printf.eprintf "Cannot convert non-constant into constant.\n";
          assert false
      | false ->
          (* var = var ^ var *)
          (* Xoring share by share *)
          [
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 0,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Log
                                ( Xor,
                                  ExpVar (make_loop_indexed x),
                                  ExpVar (make_loop_indexed y) ),
                              false );
                      };
                    ],
                    [] );
            };
          ])
  | One -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
      | true ->
          (* const = var ^ const *)
          Printf.eprintf "Cannot convert non-constant into constant.\n";
          assert false
      | false ->
          (* var = var ^ const *)
          (* Xoring first share with the constant and the next ones with 0 *)
          [
            {
              orig;
              content =
                Eqn
                  ( [ Index (vl, Const_e 0) ],
                    Log (Xor, ExpVar (Index (x, Const_e 0)), ExpVar y),
                    false );
            };
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 1,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Log
                                ( Xor,
                                  ExpVar (make_loop_indexed x),
                                  Const (0, Some typ) ),
                              false );
                      };
                    ],
                    [] );
            };
          ])
  | Two -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
      | true ->
          (* const = const ^ const *)
          (* Straightforward Xor *)
          [
            {
              orig;
              content = Eqn ([ vl ], Log (Xor, ExpVar x, ExpVar y), false);
            };
          ]
      | false ->
          (* var = const ^ const *)
          [
            {
              orig;
              content =
                Eqn
                  ( [ Index (vl, Const_e 0) ],
                    Log (Xor, ExpVar x, ExpVar y),
                    false );
            };
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 1,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Const (0, Some typ),
                              false );
                      };
                    ],
                    [] );
            };
          ])

let mask_and_or (env_var : typ Ident.Hashtbl.t)
    (env_const : bool Ident.Hashtbl.t) (orig : (ident * deq_i) list) (vl : var)
    (op : log_op) (x : var) (y : var) : deq list =
  let cst, x, y =
    if
      Ident.Hashtbl.mem env_const (Utils.get_base_name x)
      && Ident.Hashtbl.mem env_const (Utils.get_base_name y)
    then (Two, x, y)
    else if Ident.Hashtbl.mem env_const (Utils.get_base_name x) then (One, y, x)
    else if Ident.Hashtbl.mem env_const (Utils.get_base_name y) then (One, x, y)
    else (Zero, x, y)
  in
  let typ = Utils.get_var_type env_var x in
  match cst with
  | Zero -> (
      match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
      | true ->
          (* const = var & var *)
          Printf.eprintf "Cannot convert non-constant into constant.\n";
          assert false
      | false ->
          (* var = var & var *)
          [
            {
              orig;
              content = Eqn ([ vl ], Log (Masked op, ExpVar x, ExpVar y), false);
            };
          ])
  | One -> (
      (* The second operand is a constant *)
      match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
      | true ->
          (* const = var & const *)
          Printf.eprintf "Cannot convert non-constant into constant.\n";
          assert false
      | false ->
          (* var = var & const *)
          [
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 0,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Log (op, ExpVar (make_loop_indexed x), ExpVar y),
                              false );
                      };
                    ],
                    [] );
            };
          ])
  | Two -> (
      (* both operands are constant *)
      match Ident.Hashtbl.mem env_const (Utils.get_base_name vl) with
      | true ->
          (* const = const & const *)
          [
            {
              orig;
              content = Eqn ([ vl ], Log (op, ExpVar x, ExpVar y), false);
            };
          ]
      | false ->
          (* var = const & const *)
          [
            {
              orig;
              content =
                Eqn
                  ( [ Index (vl, Const_e 0) ],
                    Log (op, ExpVar x, ExpVar y),
                    false );
            };
            {
              orig;
              content =
                Loop
                  ( loop_idx,
                    Const_e 1,
                    loop_end,
                    [
                      {
                        orig;
                        content =
                          Eqn
                            ( [ make_loop_indexed vl ],
                              Const (0, Some typ),
                              false );
                      };
                    ],
                    [] );
            };
          ])

let mask_eqn (env_var : typ Ident.Hashtbl.t) (env_const : bool Ident.Hashtbl.t)
    (orig : (ident * deq_i) list) (vl : var) (e : expr) : deq list =
  match Utils.get_var_m env_var vl with
  | Mnat ->
      (* not masking nats *) [ { orig; content = Eqn ([ vl ], e, false) } ]
  | _ -> (
      match e with
      | Const (c, typ) -> mask_cst env_const orig vl c typ
      | ExpVar v -> mask_var env_var env_const orig vl v
      | Shift (op, ExpVar v, ae) -> mask_shift env_var env_const orig vl op v ae
      | Not (ExpVar v) -> mask_not env_var env_const orig vl v
      | Log (Xor, ExpVar x, ExpVar y) -> mask_xor env_var env_const orig vl x y
      | Log ((And as op), ExpVar x, ExpVar y)
      | Log ((Or as op), ExpVar x, ExpVar y) ->
          mask_and_or env_var env_const orig vl op x y
      | Bitmask (ExpVar _, _) -> (* TODO(Mask) *) assert false
      | Pack (_, _, _) -> (* TODO(Pack) *) assert false
      | _ ->
          Format.eprintf "Cannot mask expression: %a.@."
            (Usuba_print.pp_expr ()) e;
          assert false)

let rec mask_deqs (env_var : typ Ident.Hashtbl.t)
    (env_const : bool Ident.Hashtbl.t) (deqs : deq list) : deq list =
  Basic_utils.flat_map
    (fun d ->
      match d.content with
      | Eqn (lhs, Fun (f, l), sync) ->
          [ { d with content = Eqn (lhs, Fun (f, l), sync) } ]
      | Eqn ([ lv ], e, _) -> mask_eqn env_var env_const d.orig lv e
      | Eqn _ -> assert false (* Not normalized *)
      | Loop (i, ei, ef, dl, sync) ->
          [
            {
              d with
              content = Loop (i, ei, ef, mask_deqs env_var env_const dl, sync);
            };
          ])
    deqs

let rec mask_typ (typ : typ) : typ =
  match typ with
  | Nat -> Nat
  | Uint (_, _, 1) -> Array (typ, Var_e masking_order)
  | Uint (d, m, n) ->
      Array (Array (Uint (d, m, 1), Var_e masking_order), Const_e n)
  | Array (typ', s) -> Array (mask_typ typ', s)

let mask_p (env_const : bool Ident.Hashtbl.t) (p : p) : p =
  List.map
    (fun vd ->
      {
        vd with
        vd_typ =
          (match Ident.Hashtbl.find_opt env_const vd.vd_id with
          | Some _ -> vd.vd_typ
          | None -> mask_typ vd.vd_typ);
      })
    p

let mask_def (env_fun : def Ident.Hashtbl.t) (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      let consts_params =
        match Ident.Hashtbl.find_opt fun_params def.id with
        | Some (hd :: tl) ->
            if List.for_all (fun x -> List.equal Bool.equal x hd) (hd :: tl)
            then hd
            else (
              Format.eprintf
                "Node %a is called with constness-varying parameters. Usubac \
                 does not handle that for now. Overaproximating for now, which \
                 may produce too many ISW multiplications that needed.\n"
                (Ident.pp ()) def.id;
              [])
        | _ -> []
        (* Node not called *)
      in

      (* |env_var| is just used to type some (Const 0) introduced in mask_and_or *)
      let env_var = Utils.build_env_var def.p_in def.p_out vars in
      let env_const =
        Get_consts.get_consts_def env_fun ~consts_in:consts_params def
      in

      {
        def with
        p_in = mask_p env_const def.p_in;
        p_out = mask_p env_const def.p_out;
        node = Single (mask_p env_const vars, mask_deqs env_var env_const body);
      }
  | _ ->
      Format.eprintf "Cannot mask something else that a def (%a). Exiting.@."
        (Ident.pp ()) def.id;
      assert false

let run _ (prog : prog) (_ : Config.config) : prog =
  let env_fun = Ident.Hashtbl.create 10 in
  List.iter (fun def -> Ident.Hashtbl.add env_fun def.id def) prog.nodes;
  (* Note that we need to iter nodes in reverse order in order to know
     the constness of the parameters of each node. *)
  { nodes = List.rev_map (mask_def env_fun) (List.rev prog.nodes) }

let as_pass = (run, "Mask", 0)
