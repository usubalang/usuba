open Usuba_AST

(* Binding *)
module Bindings = struct
  open Ident.NameMap

  let add conf backtrace k v t =
    update (Ident.name k)
      (function
        | None -> Some v
        | Some _ ->
            Errors.warning_or_error
              (fun () -> Some v)
              (fun ppf () ->
                Format.fprintf ppf
                  "'%a' is already defined and will be overridden by this \
                   definition"
                  Ident.(pp ())
                  k)
              backtrace conf)
      t

  let refresh_id_and_store ~conf ~backtrace ~id t =
    let id = Ident.free_unbound id in
    (add conf backtrace id id t, id)

  let fresh_vars ~conf ~backtrace ~extract ~create al t =
    List.fold_left_map
      (fun t a ->
        let id = extract a in
        let t, id = refresh_id_and_store ~conf ~backtrace ~id t in
        (t, create a id))
      t al
end

let bind_arith ~backtrace ~vars_env ae =
  let backtrace =
    Format.asprintf "bind_arith(%a)" (Usuba_print.pp_arith ()) ae :: backtrace
  in
  let rec aux ae =
    match ae with
    | Const_e _ -> ae
    | Var_e i -> Var_e (Ident.bind ~backtrace vars_env i)
    | Op_e (op, ae1, ae2) -> Op_e (op, aux ae1, aux ae2)
  in
  aux ae

let bind_var ~backtrace vars_env v =
  let backtrace =
    Format.asprintf "bind_var(%a)" (Usuba_print.pp_var ()) v :: backtrace
  in
  let rec aux = function
    | Var i -> Var (Ident.bind ~backtrace vars_env i)
    | Index (v, ae) ->
        let v = aux v in
        let ae = bind_arith ~backtrace ~vars_env ae in
        Index (v, ae)
    | Range (v, ae1, ae2) ->
        let v = aux v in
        let ae1 = bind_arith ~backtrace ~vars_env ae1 in
        let ae2 = bind_arith ~backtrace ~vars_env ae2 in
        Range (v, ae1, ae2)
    | Slice (v, ael) ->
        let v = aux v in
        let ael = List.map (bind_arith ~backtrace ~vars_env) ael in
        Slice (v, ael)
  in
  aux v

(* Checks that the type of |e| is |lhs_types|. |lhs_types| has been
   obtained by typing the lhs that |e| is being assigned to.
   It returns a typed version of |e|. *)
(* |lhs_types| is mutable in order to facilitate typing of
   subexpressions *)
let rec bind_expr ~conf ~backtrace ~vars_env ~fun_env e =
  let backtrace =
    Format.asprintf "bind_expr(%a)" (Usuba_print.pp_expr ()) e :: backtrace
  in
  let rec_call e = bind_expr ~conf ~backtrace ~vars_env ~fun_env e in
  match e with
  | Const _ -> e
  | ExpVar v -> ExpVar (bind_var ~backtrace vars_env v)
  | Tuple l -> Tuple (List.map rec_call l)
  | Not e -> Not (rec_call e)
  | Shift (op, e, ae) ->
      let e = rec_call e in
      let ae = bind_arith ~backtrace ~vars_env ae in
      Shift (op, e, ae)
  | Log (op, x, y) ->
      let x = rec_call x in
      let y = rec_call y in
      Log (op, x, y)
  | Arith (op, x, y) ->
      let x = rec_call x in
      let y = rec_call y in
      Arith (op, x, y)
  | Shuffle (v, l) -> Shuffle (bind_var ~backtrace vars_env v, l)
  | Bitmask (e, ae) ->
      let e = rec_call e in
      let ae = bind_arith ~backtrace ~vars_env ae in
      Bitmask (e, ae)
  | Pack (e1, e2, t) -> Pack (e1, e2, t)
  | Fun (f, l) ->
      let f = Ident.bind ~backtrace fun_env f in
      let l = List.map rec_call l in
      Fun (f, l)
  | Fun_v (f, ae, l) ->
      let f = Ident.bind ~backtrace fun_env f in
      let ae = bind_arith ~backtrace ~vars_env ae in
      let l = List.map rec_call l in
      Fun_v (f, ae, l)

(* A regular node; iterating over each deq; but most of the work is
   done by type_eqn above. *)
let rec bind_deqs ~conf ~backtrace ~vars_env ~fun_env body =
  let backtrace = "bind_deqs()" :: backtrace in
  List.map
    (fun deq ->
      match deq.content with
      | Eqn (vs, e, sync) ->
          let vs = List.map (bind_var ~backtrace vars_env) vs in
          let e = bind_expr ~conf ~backtrace ~vars_env ~fun_env e in
          { deq with content = Eqn (vs, e, sync) }
      | Loop (id, ei, ef, dl, opts) ->
          let backtrace =
            Format.asprintf "  deq = forall %a in [%a, %a] { ... }"
              (Ident.pp ()) id (Usuba_print.pp_arith ()) ei
              (Usuba_print.pp_arith ()) ef
            :: backtrace
          in
          let vars_env, id =
            Bindings.refresh_id_and_store ~conf ~backtrace ~id vars_env
          in
          let ei = bind_arith ~backtrace ~vars_env ei in
          let ef = bind_arith ~backtrace ~vars_env ef in
          let dl = bind_deqs ~conf ~backtrace ~vars_env ~fun_env dl in
          { deq with content = Loop (id, ei, ef, dl, opts) })
    body

module Var_d = struct
  type t = Usuba_AST.var_d

  let extract { vd_id; _ } = vd_id
  let create t vd_id = { t with vd_id }
end

(* It's easier to split type_def into type_def+type_defi because of
   Multiple (reccursion happens over a def_i and not a def in that
   case). *)
let rec bind_defi ~conf ~backtrace ~vars_env ~fun_env defi =
  let open Var_d in
  match defi with
  | Single (vars, body) ->
      let backtrace = Backtrace.append "bind_defi(Single ...)" backtrace in
      let vars_env, vars =
        Bindings.fresh_vars ~conf ~backtrace ~extract ~create vars vars_env
      in
      let body = bind_deqs ~conf ~backtrace ~vars_env ~fun_env body in
      Single (vars, body)
  | Perm l -> Perm l
  | Table l -> Table l
  | Multiple l ->
      let backtrace = "bind_defi(Multiple ...)" :: backtrace in
      Multiple (List.map (bind_defi ~conf ~backtrace ~vars_env ~fun_env) l)

let bind_def ~conf ~backtrace ~fun_env def =
  let backtrace =
    Backtrace.(
      append (Format.asprintf "bind_def(%a)" (Ident.pp ()) def.id) backtrace)
  in
  let vars_env, p_in =
    Bindings.fresh_vars ~conf ~backtrace ~extract:Var_d.extract
      ~create:Var_d.create def.p_in Ident.NameMap.empty
  in
  let vars_env, p_out =
    Bindings.fresh_vars ~conf ~backtrace ~extract:Var_d.extract
      ~create:Var_d.create def.p_out vars_env
  in
  {
    def with
    p_in;
    p_out;
    node = bind_defi ~conf ~backtrace ~vars_env ~fun_env def.node;
  }

let bind_prog ~conf prog =
  let backtrace = Backtrace.(append "bind_prog()" empty) in

  let fun_env =
    List.fold_left
      (fun fun_env id ->
        fst (Bindings.refresh_id_and_store ~conf ~backtrace ~id fun_env))
      Ident.NameMap.empty
      [ refresh; print; refr; rand ]
  in

  let _, binded_nodes =
    List.fold_left_map
      (fun fun_env node ->
        let node = bind_def ~conf ~backtrace ~fun_env node in
        let fun_env, id =
          Bindings.refresh_id_and_store ~conf ~backtrace ~id:node.id fun_env
        in
        (fun_env, { node with id }))
      fun_env prog.nodes
  in
  { nodes = binded_nodes }
