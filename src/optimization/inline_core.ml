open Prelude
open Usuba_AST

let gen_iterator =
  let cpt = ref 0 in
  fun id ->
    incr cpt;
    Ident.create_free (Format.sprintf "%s%d" (Ident.name id) !cpt)

let rec update_aexpr_idx (it_env : var VarHashtbl.t) (ae : arith_expr) :
    arith_expr =
  match ae with
  | Const_e _ -> ae
  | Var_e id -> (
      match VarHashtbl.find_opt it_env (Var id) with
      | Some (Var v) -> Var_e v
      | _ -> Var_e id)
  | Op_e (op, x, y) ->
      Op_e (op, update_aexpr_idx it_env x, update_aexpr_idx it_env y)

let add_iterators (its : (ident * int) list) (v : var) : var =
  let rec create_new_base (its : (ident * int) list) (v : var) : var =
    match its with
    | [] -> v
    | (i, _) :: tl -> Index (create_new_base tl v, Var_e i)
  in
  let rec replace_base (v : var) (new_base : var) : var =
    match v with
    | Var _ -> new_base
    | Index (v', ae) -> Index (replace_base v' new_base, ae)
    | _ -> assert false
  in
  let base = Utils.get_var_base v in
  replace_base v (create_new_base its base)

let rec update_in_var (it_env : var VarHashtbl.t) (v : var) : var =
  match v with
  | Var _ -> v
  | Index (v', ae) -> Index (update_in_var it_env v', update_aexpr_idx it_env ae)
  | _ -> assert false

let rec update_var_to_var (it_env : var VarHashtbl.t)
    (var_env : var VarHashtbl.t) (v : var) : var =
  let v = update_in_var it_env v in
  match VarHashtbl.find_opt it_env v with
  | Some v' -> v'
  | None -> (
      match VarHashtbl.find_opt var_env v with
      | Some v' -> v'
      | None -> (
          match v with
          | Var _ ->
              Format.eprintf "Fail: %a\n" (Usuba_print.pp_var ()) v;
              assert false
          | Index (v', ae) -> Index (update_var_to_var it_env var_env v', ae)
          | _ -> assert false))

(* /!\ Shadowing definition above *)
let update_var_to_var (its : (ident * int) list) (it_env : var VarHashtbl.t)
    (var_env : var VarHashtbl.t) (extern_vars : bool Ident.Hashtbl.t) (v : var)
    : var =
  let v = update_var_to_var it_env var_env v in
  match Ident.Hashtbl.find_opt extern_vars (Utils.get_base_name v) with
  | Some _ ->
      v (* Variable comes from "outside" (ie, parameter/return values) *)
  | None -> add_iterators its v

let rec update_var_to_expr (it_env : var VarHashtbl.t)
    (var_env : var VarHashtbl.t) (expr_env : expr VarHashtbl.t) (v : var) : expr
    =
  match VarHashtbl.find_opt it_env v with
  | Some v' -> ExpVar v'
  | None -> (
      match VarHashtbl.find_opt expr_env v with
      | Some e -> e
      | None -> (
          match VarHashtbl.find_opt var_env v with
          | Some v' -> ExpVar v'
          | None -> (
              match v with
              | Var _ -> assert false
              | Index (v', ae) -> (
                  match update_var_to_expr it_env var_env expr_env v' with
                  | ExpVar v'' ->
                      ExpVar
                        (Index (v'', update_aexpr it_env var_env expr_env ae))
                  | _ -> assert false)
              | _ -> assert false)))

and expr_to_aexpr (e : expr) : arith_expr =
  match e with
  | Const (c, _) -> Const_e c
  | ExpVar (Var v) -> Var_e v
  | Arith (op, x, y) -> Op_e (op, expr_to_aexpr x, expr_to_aexpr y)
  | _ -> assert false

(* TODO: this is quite messy, as we are mixing aexpr and expr ... *)
and update_aexpr (it_env : var VarHashtbl.t) (var_env : var VarHashtbl.t)
    (expr_env : expr VarHashtbl.t) (ae : arith_expr) : arith_expr =
  let rec_call = update_aexpr it_env var_env expr_env in
  match ae with
  | Const_e _ -> ae
  | Var_e v ->
      expr_to_aexpr (update_var_to_expr it_env var_env expr_env (Var v))
  | Op_e (op, x, y) -> Op_e (op, rec_call x, rec_call y)

(* /!\ Shadowing definition above *)
let update_var_to_expr (its : (ident * int) list) (it_env : var VarHashtbl.t)
    (var_env : var VarHashtbl.t) (expr_env : expr VarHashtbl.t)
    (extern_vars : bool Ident.Hashtbl.t) (v : var) : expr =
  let e = update_var_to_expr it_env var_env expr_env v in
  match e with
  | ExpVar v -> (
      match Ident.Hashtbl.find_opt extern_vars (Utils.get_base_name v) with
      | Some _ ->
          e (* Variable comes from "outside" (ie, parameter/return values) *)
      | None -> ExpVar (add_iterators its v))
  | _ -> e

(* Convert variables names inside an expression *)
let rec update_expr (its : (ident * int) list) (it_env : var VarHashtbl.t)
    (var_env : var VarHashtbl.t) (expr_env : expr VarHashtbl.t)
    (extern_vars : bool Ident.Hashtbl.t) (e : expr) : expr =
  let rec_call = update_expr its it_env var_env expr_env extern_vars in
  match e with
  | Const _ -> e
  | ExpVar v -> update_var_to_expr its it_env var_env expr_env extern_vars v
  | Shuffle (v, l) -> (
      match update_var_to_expr its it_env var_env expr_env extern_vars v with
      | ExpVar v' -> Shuffle (v', l)
      | _ -> assert false)
  | Tuple l -> Tuple (List.map rec_call l)
  | Not e -> Not (rec_call e)
  (* TODO: Should do something with 'ae' *)
  | Shift (op, e, ae) ->
      Shift (op, rec_call e, update_aexpr it_env var_env expr_env ae)
  | Log (op, x, y) -> Log (op, rec_call x, rec_call y)
  | Arith (op, x, y) -> Arith (op, rec_call x, rec_call y)
  | Fun (f, l) -> Fun (f, List.map rec_call l)
  | _ ->
      Format.printf "%a@." (Usuba_print.pp_expr ()) e;
      assert false

(* Convert the variable names, and update deq's orig with |f| (since
   those deqs are being inlined from |f| into another node). *)
let rec update_vars_and_deqs (its : (ident * int) list)
    (it_env : var VarHashtbl.t) (var_env : var VarHashtbl.t)
    (expr_env : expr VarHashtbl.t) (extern_vars : bool Ident.Hashtbl.t)
    (f : ident) (body : deq list) : deq list =
  List.map
    (fun d ->
      {
        orig = (f, d.content) :: d.orig;
        content =
          (match d.content with
          | Eqn (lhs, e, sync) ->
              Eqn
                ( List.map (update_var_to_var its it_env var_env extern_vars) lhs,
                  update_expr its it_env var_env expr_env extern_vars e,
                  sync )
          | Loop t ->
              let id = gen_iterator t.id in
              VarHashtbl.add it_env (Var t.id) (Var id);
              let updated =
                Loop
                  {
                    t with
                    id;
                    body =
                      update_vars_and_deqs its it_env var_env expr_env
                        extern_vars f t.body;
                  }
              in
              VarHashtbl.remove it_env (Var id);
              updated);
      })
    body

(* Changes the variables of |vars| into arrays of dimensions
   corresponding to the iterators in |its| *)
let update_vars (its : (ident * int) list) (vars : var_d list) : var_d list =
  let rec update_typ (its : (ident * int) list) (typ : typ) : typ =
    match its with
    | [] -> typ
    | (_, s) :: tl -> Array (update_typ tl typ, Const_e s)
  in
  let its = List.rev its in
  List.map (fun vd -> { vd with vd_typ = update_typ its vd.vd_typ }) vars

(* Inline a specific call (defined by lhs & args) *)
let inline_call (its : (ident * int) list) (to_inl : def) (args : expr list)
    (lhs : var list) (cnt : int) : p * deq list =
  (* Define a name conversion function *)
  let conv_name (id : ident) : ident =
    Ident.bound_copy id
      (Format.asprintf "%a_%d_%a" (Ident.pp ()) to_inl.id cnt (Ident.pp ()) id)
  in

  (* Extract body, vars, params and name of the node to inline *)
  let vars_inl, body_inl =
    match to_inl.node with
    | Single (vars, body) -> (vars, body)
    | _ -> assert false
  in
  let p_in = to_inl.p_in in
  let p_out = to_inl.p_out in

  (* alpha-conversion environments *)
  let var_env = VarHashtbl.create 100 in
  let extern_vars = Ident.Hashtbl.create 100 in
  let expr_env = VarHashtbl.create 100 in
  (* p_out replaced by the lhs *)
  List.iter2
    (fun vd v ->
      VarHashtbl.add var_env (Var vd.vd_id) v;
      Ident.Hashtbl.add extern_vars (Utils.get_base_name v) true)
    p_out lhs;
  (* p_in replaced by the expressions of arguments *)
  List.iter2
    (fun vd e ->
      VarHashtbl.add expr_env (Var vd.vd_id) e;
      List.iter
        (fun v -> Ident.Hashtbl.add extern_vars (Utils.get_base_name v) true)
        (Utils.get_used_vars e))
    p_in args;
  (* Create a list containing the new variables names *)
  let vars =
    List.map
      (fun vd ->
        {
          vd with
          vd_id = conv_name vd.vd_id;
          vd_orig = (to_inl.id, vd) :: vd.vd_orig;
        })
      vars_inl
  in
  (* nodes variables alpha-converted *)
  List.iter2
    (fun vd vd' -> VarHashtbl.add var_env (Var vd.vd_id) (Var vd'.vd_id))
    vars_inl vars;

  ( update_vars its vars,
    update_vars_and_deqs its (VarHashtbl.create 10) var_env expr_env extern_vars
      to_inl.id body_inl )

(* Inline all the calls to "to_inl" in a given node
   (desribed by its variables and body "vars,body") *)
(* |cnt| is used as a counter for alpha-conversion *)
let rec inline_in_node ?(its : (ident * int) list = []) ?(cnt : int ref = ref 0)
    (deqs : deq list) (to_inl : def) : p * deq list =
  let f_inl = Ident.name to_inl.id in

  let vars, deqs =
    (* Unpack the list bellow into a single list of vars and
       a list of deqs *)
    List.split
      (* Find the calls to f_inl, and inline them.
         This will introduce new variables, which is
         why maps returns a (p * deq list) list. *)
      (List.map
         (fun eqn ->
           match eqn.content with
           | Eqn (lhs, Fun (f, l), _) when String.equal (Ident.name f) f_inl ->
               incr cnt;
               inline_call its to_inl l lhs !cnt
           | Eqn _ -> ([], [ eqn ])
           | Loop t ->
               let size =
                 abs (Utils.eval_arith_ne t.start - Utils.eval_arith_ne t.stop)
                 + 1
               in
               let vars, body =
                 inline_in_node ~its:((t.id, size) :: its) ~cnt t.body to_inl
               in
               (vars, [ { eqn with content = Loop { t with body } } ]))
         deqs)
  in
  (List.flatten vars, List.flatten deqs)

(* Perform the inlining of node "to_inline" at every call point *)
(* And removes the node from the program *)
let do_inline (prog : prog) (to_inline : def) : prog =
  {
    nodes =
      List.filter (fun def -> not (Ident.equal def.id to_inline.id))
      @@ List.map
           (fun def ->
             match def.node with
             | Single (vars, body) ->
                 let vars', body' = inline_in_node body to_inline in
                 { def with node = Single (vars @ vars', body') }
             | _ -> def)
           prog.nodes;
  }
