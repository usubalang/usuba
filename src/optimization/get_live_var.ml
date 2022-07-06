open Usuba_AST

let rec add_right env_var live e =
  match e with
  | Const _ -> ()
  | ExpVar v ->
      List.iter
        (fun v -> Hashtbl.replace live (Utils.get_var_base v) true)
        (Utils.expand_var env_var v)
  | Tuple l -> List.iter (add_right env_var live) l
  | Not e -> add_right env_var live e
  | Shift (_, e, _) -> add_right env_var live e
  | Log (_, x, y) ->
      add_right env_var live x;
      add_right env_var live y
  | Shuffle (v, _) ->
      List.iter
        (fun v -> Hashtbl.replace live (Utils.get_var_base v) true)
        (Utils.expand_var env_var v)
  | Arith (_, x, y) ->
      add_right env_var live x;
      add_right env_var live y
  | Bitmask (e', _) -> add_right env_var live e'
  | Pack (e1, e2, _) ->
      add_right env_var live e1;
      add_right env_var live e2
  | Fun (_, l) -> List.iter (add_right env_var live) l
  | _ -> assert false

let remove_left env_var live lhs =
  List.iter
    (fun v ->
      List.iter
        (fun v -> Hashtbl.remove live (Utils.get_var_base v))
        (Utils.expand_var env_var v))
    lhs

let live_deq env_var live (deq : deq) : int =
  let nb_live = Hashtbl.length live in
  (match deq.content with
  | Eqn (lhs, rhs, _) ->
      add_right env_var live rhs;
      remove_left env_var live lhs
  | Loop _ -> raise (Errors.Not_implemented "live_deq(Loop ...)"));
  (* Printf.printf "[%3d -> %3d]  %s\n" nb_live (Hashtbl.length live) (Usuba_print.deq_to_str deq); *)
  nb_live

let live_deqs env_var (p_out : p) (deqs : deq list) : int =
  let live = Hashtbl.create 50 in
  List.iter
    (fun x ->
      List.iter
        (fun x -> Hashtbl.add live x true)
        (Utils.expand_var env_var (Var x.vd_id)))
    p_out;

  Basic_utils.max_l (List.map (live_deq env_var live) (List.rev deqs))

let live_def (def : def) : int =
  match def.node with
  | Single (vars, body) -> (
      let env_var = Utils.build_env_var def.p_in def.p_out vars in
      try live_deqs env_var def.p_out body with Errors.Not_implemented _ -> -1)
  | _ -> -1

let get_live_var (prog : prog) : int =
  Basic_utils.max_l (List.map live_def prog.nodes)
