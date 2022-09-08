open Prelude
open Usuba_AST
open Basic_utils
open Utils

let rec simpl_var env_it (v : var) : var =
  match v with
  | Var _ -> v
  | Index (v', ae) -> Index (simpl_var env_it v', Const_e (eval_arith env_it ae))
  | _ -> assert false

let rec replace_var (env : var VarHashtbl.t) (v : var) : var =
  match VarHashtbl.find_opt env v with
  | Some v' -> v'
  | None -> (
      match v with
      | Var _ -> v
      | Index (v', ae) -> Index (replace_var env v', ae)
      | _ -> assert false)

let rec replace_expr (env : var VarHashtbl.t) (e : expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> ExpVar (replace_var env v)
  | Shuffle (v, l) -> Shuffle (replace_var env v, l)
  | Tuple l -> Tuple (List.map (replace_expr env) l)
  | Not e -> Not (replace_expr env e)
  | Shift (op, x, y) -> Shift (op, replace_expr env x, y)
  | Log (op, x, y) -> Log (op, replace_expr env x, replace_expr env y)
  | Arith (op, x, y) -> Arith (op, replace_expr env x, replace_expr env y)
  | Fun (f, l) -> Fun (f, List.map (replace_expr env) l)
  | _ -> assert false

let rec get_last_used (env_var : typ Ident.Hashtbl.t)
    ?(env_it = Ident.Hashtbl.create 100) (last_used : int VarHashtbl.t)
    ?(cpt_start = 0) (deqs : deq list) (no_arr : bool) : unit =
  let cpt = ref cpt_start in

  let rec update_used_bellow env_it last_used (v : var) : unit =
    let v = simpl_var env_it v in
    VarHashtbl.replace last_used v !cpt;
    if not no_arr then
      match v with
      | Var _ -> ()
      | Index (v', _) -> update_used_bellow env_it last_used v'
      | _ -> assert false
  in

  let rec update_used_above env_var env_it last_used (v : var) : unit =
    let v = simpl_var env_it v in
    VarHashtbl.replace last_used v !cpt;
    if not no_arr then
      match get_var_type env_var v with
      | Uint (_, _, 1) -> ()
      | Uint _ | Array _ ->
          List.iter
            (update_used_above env_var env_it last_used)
            (expand_var_partial env_var v)
      | _ -> assert false
  in

  let update_used env_var env_it last_used (v : var) : unit =
    update_used_bellow env_it last_used v;
    update_used_above env_var env_it last_used v
  in

  List.iter
    (fun d ->
      match d.content with
      | Eqn (_, e, _) ->
          incr cpt;
          List.iter (update_used env_var env_it last_used) (get_used_vars e)
      | Loop { id; start; stop; body; _ } ->
          let start = eval_arith env_it start in
          let stop = eval_arith env_it stop in
          List.iter
            (fun i ->
              Ident.Hashtbl.add env_it id i;
              get_last_used env_var ~env_it ~cpt_start:!cpt last_used body
                no_arr;
              Ident.Hashtbl.remove env_it id)
            (gen_list_bounds start stop);
          cpt := !cpt + List.length body)
    deqs

let share_deqs (p_in : p) (p_out : p) (vars : p) (deqs : deq list)
    (no_arr : bool) : deq list =
  (* variables and their types *)
  let env_var = build_env_var p_in p_out vars in
  (* last line at which a variable is used *)
  let last_used = VarHashtbl.create 1000 in
  get_last_used env_var last_used deqs no_arr;
  (* The inputs (that shouldn't be overused I think) *)
  let env_in = VarHashtbl.create 100 in
  List.iter (fun vd -> VarHashtbl.replace env_in (Var vd.vd_id) true) p_in;
  (* out variables, should be kept *)
  let env_out = VarHashtbl.create 100 in
  List.iter (fun vd -> VarHashtbl.replace env_out (Var vd.vd_id) true) p_out;
  (* replacement env for variables that have been replaced *)
  let env_replace = VarHashtbl.create 1000 in

  let rec do_it ?(cpt_start = 0) (deqs : deq list) : deq list =
    let cpt = ref cpt_start in
    List.map
      (fun deq ->
        {
          deq with
          content =
            (match deq.content with
            | Eqn (lhs, e, sync) ->
                let e = replace_expr env_replace e in
                let lhs = List.map (replace_var env_replace) lhs in
                incr cpt;
                let avail =
                  List.filter
                    (fun v ->
                      match VarHashtbl.find_opt env_in (get_var_base v) with
                      | Some _ -> false
                      | None -> (
                          match VarHashtbl.find_opt last_used v with
                          | Some n -> n <= !cpt
                          | None -> false))
                    (get_used_vars e)
                in
                let used = VarHashtbl.create 10 in
                Eqn
                  ( List.map
                      (fun v ->
                        match VarHashtbl.find_opt env_out (get_var_base v) with
                        | Some _ -> v
                        | None -> (
                            let typ = get_var_type env_var (get_var_base v) in
                            match
                              List.find_opt
                                (fun v ->
                                  (not (VarHashtbl.mem used v))
                                  && equal_typ typ
                                       (get_var_type env_var (get_var_base v)))
                                avail
                            with
                            | Some v' ->
                                VarHashtbl.add used v' true;
                                VarHashtbl.replace env_replace (get_var_base v)
                                  (get_var_base v');
                                (try
                                   VarHashtbl.replace last_used v'
                                     (VarHashtbl.find last_used v)
                                 with Not_found ->
                                   Format.eprintf "Not_found: %a.@."
                                     (Usuba_print.pp_var ()) v';
                                   raise Not_found);
                                v'
                            | None -> v))
                      lhs,
                    e,
                    sync )
            | Loop t ->
                let r = Loop { t with body = do_it ~cpt_start:!cpt t.body } in
                cpt := !cpt + List.length t.body;
                r);
        })
      deqs
  in

  do_it deqs

let share_def (def : def) (no_arr : bool) : def =
  match def.node with
  | Single (vars, body) ->
      let body = share_deqs def.p_in def.p_out vars body no_arr in
      { def with node = Single (vars, body) }
  | _ -> assert false

let run _ (prog : prog) (conf : Config.config) : prog =
  { nodes = apply_last prog.nodes (fun x -> share_def x conf.no_arr) }

let as_pass = (run, "Share_var", 0)
