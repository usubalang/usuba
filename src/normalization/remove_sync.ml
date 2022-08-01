(*********************************************************************
                             remove_sync.ml

  Removes the `:=` throughout the program.

  Reminder of how `:=` works:

    x := x ^ y;
    z = x ^ a;

  is transformed into:

    _shadow_x1_ = x ^ y;
    z = _shadow_x1_ ^ a;

  Basically, we introduce a new variable every time.


  TODO: this does not really work on arrays for now, and produces
  wrong code (ie not within Usuba) semantics for scalars in loops
  since it produces a single variable. For instance:

     forall i in [1, 5] {
       x := x * 2;
       y[i] = ~x
     }

  will produce:

     forall i in [1, 5] {
         _shadow_x1_ = x * 2;
         y[i] = ~_shadow_x1_;
     }

  which is wrong for two reasons:

    - the result is wrong: `x` is not multiplied by 2 every iteration

    - _shadow_x1_ is assigned multiple time, which is not allowed in
      Usuba.

  Instead, we should generate something like:

      _shadow_x1_[0] = x;
      forall i in [i, 5] {
         _shadow_x1_[i+1] = _shadow_x1_[i] * 2;
         y[i] = ~_shadow_x1_[i+1];
      }


 ********************************************************************)

open Prelude
open Utils
open Usuba_AST

let new_vars = ref []

let gen_tmp =
  let cpt = ref 0 in
  fun env_var typ id ->
    incr cpt;
    let var = Ident.create_free (Printf.sprintf "_shadow_%s%d_" id !cpt) in
    Ident.Hashtbl.add env_var var typ;
    new_vars := simple_typed_var_d var typ :: !new_vars;
    Var var

let clean_var (env_var : typ Ident.Hashtbl.t) (env_replace : var VarHashtbl.t)
    (v : var) : var list =
  match VarHashtbl.find_opt env_replace v with
  | Some r -> [ r ]
  | None -> (
      match v with
      | Index (v', ae) -> (
          match VarHashtbl.find_opt env_replace v' with
          | Some r -> [ Index (r, ae) ]
          | None -> [ v ])
      | Var _ -> (
          match get_var_type env_var v with
          | Uint (_, _, 1) -> [ v ]
          | Uint (_, _, n) ->
              let subv =
                List.map (fun i -> Index (v, Const_e i)) (gen_list_0_int n)
              in
              let change =
                List.exists
                  (fun x ->
                    match VarHashtbl.find_opt env_replace x with
                    | Some _ -> true
                    | None -> false)
                  subv
              in
              if change then
                List.map
                  (fun x ->
                    match VarHashtbl.find_opt env_replace x with
                    | Some x' -> x'
                    | None -> x)
                  subv
              else [ v ]
          | Array (_, n) ->
              let subv =
                List.map
                  (fun i -> Index (v, Const_e i))
                  (gen_list_0_int (eval_arith_ne n))
              in
              let change =
                List.exists
                  (fun x ->
                    match VarHashtbl.find_opt env_replace x with
                    | Some _ -> true
                    | None -> false)
                  subv
              in
              if change then
                List.map
                  (fun x ->
                    match VarHashtbl.find_opt env_replace x with
                    | Some x' -> x'
                    | None -> x)
                  subv
              else [ v ]
          | Nat -> [ v ])
      | _ -> assert false)

let rec clean_expr (env_var : typ Ident.Hashtbl.t)
    (env_replace : var VarHashtbl.t) (e : expr) : expr =
  let rec_call = clean_expr env_var env_replace in
  match e with
  | Const _ -> e
  | ExpVar v -> (
      match clean_var env_var env_replace v with
      | [ x ] -> ExpVar x
      | l -> Tuple (List.map (fun x -> ExpVar x) l))
  | Tuple l -> Tuple (List.map rec_call l)
  | Not e -> Not (rec_call e)
  | Log (op, e1, e2) -> Log (op, rec_call e1, rec_call e2)
  | Arith (op, e1, e2) -> Arith (op, rec_call e1, rec_call e2)
  | Shift (op, e, ae) -> Shift (op, rec_call e, ae)
  | Shuffle (v, l) -> (
      match clean_var env_var env_replace v with
      | [ x ] -> Shuffle (x, l)
      | xs -> Tuple (List.map (fun x -> Shuffle (x, l)) xs))
  | Bitmask (e, ae) -> Bitmask (rec_call e, ae)
  | Pack (e1, e2, t) -> Pack (rec_call e1, rec_call e2, t)
  | Fun (f, l) -> Fun (f, List.map rec_call l)
  | _ -> assert false

let rec clean_deqs (env_var : typ Ident.Hashtbl.t)
    (env_replace : var VarHashtbl.t) (deqs : deq list) : deq list =
  List.map
    (fun d ->
      {
        d with
        content =
          (match d.content with
          | Loop (x, ei, ef, dl, opts) ->
              Ident.Hashtbl.add env_var x Nat;
              let res =
                Loop (x, ei, ef, clean_deqs env_var env_replace dl, opts)
              in
              Ident.Hashtbl.remove env_var x;
              res
          | Eqn (lhs, e, sync) -> (
              let e' = clean_expr env_var env_replace e in
              match sync with
              | false -> Eqn (lhs, e', false)
              | true ->
                  let tmps =
                    List.map
                      (fun v ->
                        let typ = get_var_type env_var v in
                        let v' =
                          gen_tmp env_var typ (Ident.name (get_base_name v))
                        in
                        VarHashtbl.add env_replace v v';
                        v')
                      lhs
                  in
                  Eqn (tmps, e', false)));
      })
    deqs

let clean_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      new_vars := [];
      let env_var = build_env_var def.p_in def.p_out vars in
      let env_replace = VarHashtbl.create 100 in
      let new_body = clean_deqs env_var env_replace body in
      { def with node = Single (vars @ !new_vars, new_body) }
  | _ -> def

let run _ (prog : prog) _ : prog = { nodes = List.map clean_def prog.nodes }
let as_pass = (run, "Remove_sync", 0)
