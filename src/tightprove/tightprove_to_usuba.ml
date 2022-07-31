open Basic_utils
open Usuba_AST
open Tp_AST

(* More like "update envs" than "gen_var": given a TP variable (ie, a
   string), generates a Usuba variable, and updates |new_vars| and
   |vars_corres| accordingly. *)
let gen_var (new_vars : (Usuba_AST.var, Usuba_AST.var) Hashtbl.t)
    (vars_corres : (string, Usuba_AST.var) Hashtbl.t) (v : string) (rv : var) :
    unit =
  let new_v = Var (Ident.create_free v) in
  Hashtbl.add vars_corres v new_v;
  (* |rv| might be already a refresh-generated variable; in that case,
     we want to add the refreshed variable to |new_vars|, in order to
     be able to reconstruct deqs. *)
  match Hashtbl.find_opt new_vars rv with
  | Some old_v -> Hashtbl.add new_vars new_v old_v
  | None -> Hashtbl.add new_vars new_v rv

let var_to_ua (vars_corres : (string, Usuba_AST.var) Hashtbl.t) (v : string) :
    Usuba_AST.var =
  Hashtbl.find vars_corres v

let log_op_to_ua (op : Tp_AST.log_op) : Usuba_AST.log_op =
  match op with
  | Tp_AST.And -> Usuba_AST.And
  | Tp_AST.Or -> Usuba_AST.Or
  | Tp_AST.Xor -> Usuba_AST.Xor

let shift_op_to_ua (op : Tp_AST.shift_op) : Usuba_AST.shift_op =
  match op with
  | Tp_AST.Lshift -> Usuba_AST.Lshift
  | Tp_AST.Rshift -> Usuba_AST.Rshift
  | Tp_AST.Lrotate -> Usuba_AST.Lrotate
  | Tp_AST.Rrotate -> Usuba_AST.Rrotate

(* Finds |deq| inside |deqs_origins| and returns the associated origin
   list. We need |new_vars| because |deq| might contain variable that
   have been introduced by refreshes and therefore need to be
   replaced by the variables they refresh.

   This function also updates |deqs_corres| with a correspondance
   between the new deq_i and the old one. (eg, the one with refreshes
   and the one without) *)
let find_orig (new_vars : (Usuba_AST.var, Usuba_AST.var) Hashtbl.t)
    (deqs_origins :
      (Usuba_AST.deq_i, (Usuba_AST.ident * Usuba_AST.deq_i) list) Hashtbl.t)
    (deqs_corres : (Usuba_AST.deq_i, Usuba_AST.deq_i) Hashtbl.t)
    (deqi : Usuba_AST.deq_i) :
    (Usuba_AST.ident * Usuba_AST.deq_i) list * Usuba_AST.deq_i =
  let contains_refreshed = ref false in
  let replace_var (v : Usuba_AST.var) : Usuba_AST.var =
    match Hashtbl.find_opt new_vars v with
    | Some old_v ->
        contains_refreshed := true;
        old_v
    | None -> v
  in
  let rec replace_expr (e : Usuba_AST.expr) : Usuba_AST.expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (replace_var v)
    | Tuple l -> Tuple (List.map replace_expr l)
    | Not e' -> Not (replace_expr e')
    | Shift (op, e', ae) -> Shift (op, replace_expr e', ae)
    | Log (op, x, y) -> Log (op, replace_expr x, replace_expr y)
    | Shuffle (v, l) -> Shuffle (replace_var v, l)
    | Arith (op, x, y) -> Arith (op, replace_expr x, replace_expr y)
    | Fun (f, l) -> Fun (f, List.map replace_expr l)
    | _ -> assert false
  in
  let reverse_expr (e : Usuba_AST.expr) : Usuba_AST.expr =
    match e with
    | Log (op, a, b) -> Log (op, b, a)
    | Arith (op, a, b) -> Arith (op, b, a)
    | _ -> e
  in
  match deqi with
  | Eqn ([ v ], e, false) -> (
      let v' = replace_var v in
      let e' = replace_expr e in
      let old_deqi = Eqn ([ v' ], e', false) in
      let old_deqi_rev = Eqn ([ v' ], reverse_expr e', false) in
      let deqi_rev = Eqn ([ v ], reverse_expr e, false) in
      match Hashtbl.find_opt deqs_origins old_deqi with
      | Some origin ->
          Hashtbl.add deqs_corres old_deqi deqi;
          if !contains_refreshed then
            ((Ident.create_free "", old_deqi) :: origin, deqi)
          else (origin, deqi)
      | None -> (
          match Hashtbl.find_opt deqs_origins old_deqi_rev with
          | Some origin ->
              Hashtbl.add deqs_corres old_deqi_rev deqi_rev;
              if !contains_refreshed then
                ((Ident.create_free "", old_deqi_rev) :: origin, deqi_rev)
              else (origin, deqi_rev)
          | None -> (
              Hashtbl.add deqs_corres old_deqi deqi;
              match e' with
              | Fun (f, _) when Ident.name f = "refresh" || Ident.name f = "ref"
                ->
                  ([], deqi)
              | _ ->
                  Format.printf "%a@." (Usuba_print.pp_expr ()) e';
                  assert false)))
  | _ -> assert false

let asgn_to_ua (vars_corres : (string, Usuba_AST.var) Hashtbl.t)
    (new_vars : (Usuba_AST.var, Usuba_AST.var) Hashtbl.t)
    (deqs_origins :
      (Usuba_AST.deq_i, (Usuba_AST.ident * Usuba_AST.deq_i) list) Hashtbl.t)
    (deqs_corres : (Usuba_AST.deq_i, Usuba_AST.deq_i) Hashtbl.t)
    (base_type : Usuba_AST.typ) (asgn : Tp_AST.asgn) : deq =
  let ua_rhs =
    match asgn.rhs with
    | Tp_AST.ExpVar v -> Usuba_AST.ExpVar (var_to_ua vars_corres v)
    | Tp_AST.Const c -> Usuba_AST.Const (c, Some base_type)
    | Tp_AST.ConstAll c -> Usuba_AST.Const (c, Some base_type)
    | Tp_AST.Not v -> Usuba_AST.Not (Usuba_AST.ExpVar (var_to_ua vars_corres v))
    | Tp_AST.Log (op, x, y) ->
        let x = Usuba_AST.ExpVar (var_to_ua vars_corres x) in
        let y = Usuba_AST.ExpVar (var_to_ua vars_corres y) in
        Usuba_AST.Log (log_op_to_ua op, x, y)
    | Tp_AST.Shift (op, x, n) ->
        let x = Usuba_AST.ExpVar (var_to_ua vars_corres x) in
        Usuba_AST.Shift (shift_op_to_ua op, x, Usuba_AST.Const_e n)
    | Tp_AST.Refresh v ->
        if not (Hashtbl.mem vars_corres asgn.lhs) then
          (* This refresh introduces a new variable (by opposition to
             already being known) *)
          gen_var new_vars vars_corres asgn.lhs (var_to_ua vars_corres v);
        Usuba_AST.Fun
          ( Ident.create_free "refresh",
            [ Usuba_AST.ExpVar (var_to_ua vars_corres v) ] )
    | Tp_AST.BitToReg _ ->
        Printf.fprintf stderr "Not implemented: bit_to_reg.\n";
        assert false
  in
  let content =
    Usuba_AST.Eqn ([ var_to_ua vars_corres asgn.lhs ], ua_rhs, false)
  in
  let orig, content = find_orig new_vars deqs_origins deqs_corres content in
  { orig; content }

let body_to_ua (vars_corres : (string, Usuba_AST.var) Hashtbl.t)
    (new_vars : (Usuba_AST.var, Usuba_AST.var) Hashtbl.t)
    (deqs_origins :
      (Usuba_AST.deq_i, (Usuba_AST.ident * Usuba_AST.deq_i) list) Hashtbl.t)
    (deqs_corres : (Usuba_AST.deq_i, Usuba_AST.deq_i) Hashtbl.t)
    (base_type : Usuba_AST.typ) (body : Tp_AST.asgn list) : deq list =
  List.map
    (asgn_to_ua vars_corres new_vars deqs_origins deqs_corres base_type)
    body

(* |ua_def| is the initial Usuba def that produces |tp_def|. It's
   taken as parameters as it simplifies getting the
   input/output/variables with the right types for Usuba, as well as
   each deq's origin. *)
let tp_to_usuba (vars_corres : (string, Usuba_AST.var) Hashtbl.t)
    (ua_def : Usuba_AST.def) (tp_def : Tp_AST.def) :
    Usuba_AST.def * (Usuba_AST.deq_i, Usuba_AST.deq_i) Hashtbl.t =
  match ua_def.node with
  | Single (vars, body) ->
      let deqs_origins = Hashtbl.create 100 in
      List.iter (fun d -> Hashtbl.add deqs_origins d.content d.orig) body;
      let deqs_corres = Hashtbl.create 100 in
      let new_vars = Hashtbl.create 10 in
      let base_type = Utils.get_base_type (List.hd ua_def.p_in).vd_typ in
      let new_body =
        body_to_ua vars_corres new_vars deqs_origins deqs_corres base_type
          tp_def.body
      in
      let new_vars =
        vars
        @ List.map
            (fun v ->
              Utils.simple_typed_var_d (Utils.get_base_name v) base_type)
            (keys new_vars)
      in
      ({ ua_def with node = Single (new_vars, new_body) }, deqs_corres)
  | _ -> assert false
