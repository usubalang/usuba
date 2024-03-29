(*********************************************************************
                             unroll.ml

   About the |force| param pretty much everywhere: by default, this
   module unrolls only loops marked with _unroll. If |force| is true
   however, all loops are unrolled.
   |force| could be true mainly for 2 reasons:
      - either unroll_prog was called with a config where unroll = true.
      - unroll_prog was called with a param force = true.


 ********************************************************************)

open Prelude
open Usuba_AST
open Basic_utils
open Utils

let pass_name = "Unroll"

let rec unroll_in_var (env_it : int Ident.Hashtbl.t) (v : var) : var =
  match v with
  | Var _ -> v
  | Index (v', ae) -> Index (unroll_in_var env_it v', simpl_arith env_it ae)
  | Range (v', ae1, ae2) ->
      Range
        (unroll_in_var env_it v', simpl_arith env_it ae1, simpl_arith env_it ae2)
  | Slice (v', aes) ->
      Slice (unroll_in_var env_it v', List.map (simpl_arith env_it) aes)

let rec unroll_in_expr (env_it : int Ident.Hashtbl.t) (e : expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> ExpVar (unroll_in_var env_it v)
  | Tuple l -> Tuple (List.map (unroll_in_expr env_it) l)
  | Not e' -> Not (unroll_in_expr env_it e')
  | Log (op, x, y) -> Log (op, unroll_in_expr env_it x, unroll_in_expr env_it y)
  | Arith (op, x, y) ->
      Arith (op, unroll_in_expr env_it x, unroll_in_expr env_it y)
  | Shift (op, e', ae) ->
      Shift (op, unroll_in_expr env_it e', simpl_arith env_it ae)
  | Shuffle (v, l) -> Shuffle (unroll_in_var env_it v, l)
  | Bitmask (e, ae) -> Bitmask (unroll_in_expr env_it e, simpl_arith env_it ae)
  | Pack (e1, e2, t) ->
      Pack (unroll_in_expr env_it e1, unroll_in_expr env_it e2, t)
  | Fun (f, l) -> Fun (f, List.map (unroll_in_expr env_it) l)
  | Fun_v (f, x, l) ->
      Fun_v (f, simpl_arith env_it x, List.map (unroll_in_expr env_it) l)

let rec unroll_deqs (env_it : int Ident.Hashtbl.t) (force : bool) (f : ident)
    (deqs : deq list) : deq list =
  flat_map
    (fun deq ->
      match deq.content with
      | Eqn (lhs, e, sync) ->
          let new_lhs = List.map (unroll_in_var env_it) lhs in
          let new_e = unroll_in_expr env_it e in
          let new_eqn = Eqn (new_lhs, new_e, sync) in
          let new_orig =
            if equal_deq_i new_eqn deq.content then deq.orig
            else (f, deq.content) :: deq.orig
          in

          [ { orig = new_orig; content = new_eqn } ]
      | Loop t ->
          if force || is_unroll t.opts then
            let start = eval_arith env_it t.start in
            let stop = eval_arith env_it t.stop in
            flat_map
              (fun n ->
                Ident.Hashtbl.add env_it t.id n;
                let res = unroll_deqs env_it force f t.body in
                Ident.Hashtbl.remove env_it t.id;
                res)
              (gen_list_bounds start stop)
          else
            [
              {
                orig = deq.orig;
                content =
                  Loop { t with body = unroll_deqs env_it force f t.body };
              };
            ])
    deqs

let unroll_def (force : bool) (def : def) : def =
  {
    def with
    node =
      (match def.node with
      | Single (vars, body) ->
          let env_it = Ident.Hashtbl.create 10 in
          Single (vars, unroll_deqs env_it force def.id body)
      | _ -> def.node);
  }

let force_run (prog : prog) _ : prog =
  { nodes = List.map (fun d -> unroll_def true d) prog.nodes }

let run _ (prog : prog) (conf : Config.config) : prog =
  { nodes = List.map (fun d -> unroll_def conf.unroll d) prog.nodes }
