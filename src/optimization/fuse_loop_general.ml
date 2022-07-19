(*********************************************************************
                          fuse_loops.ml

 This module is supposed to fuse loops that have the same iterator and
 the same bounds. It could fairly easily be adapted to fuse any two
 loops that have the same bounds.

 However, it doesn't work well with nested loops. Fixing it would be
 slightly tricky (but probably doable).

 Also, I _think_ it's introducing some bugs in the code.

 This two things would need to be fixed before using it.

 ********************************************************************)

open Usuba_AST
open Basic_utils
open Utils

let rec instanciate_var (env_it : (ident, int) Hashtbl.t) (v : var) : var =
  match v with
  | Var _ -> v
  | Index (v', idx) ->
      Index (instanciate_var env_it v', Const_e (eval_arith env_it idx))
  | _ -> assert false

(* **************************************************************** *)
(*                      Helper datastructures                       *)

(* The iterator environment is a list of ident and their min/max
   value. The idea being that iterators can be given concrete values
   by evaluating this list from end to begining. *)
type iterator = { id : ident; ei : arith_expr; ef : arith_expr }
type it_env_t = iterator list ref

(* Adds an iterator in an environment *)
let push_it_env (env_it : it_env_t) (id : ident) (ei : arith_expr)
    (ef : arith_expr) : unit =
  env_it := { id; ei; ef } :: !env_it

(* Removes the first iterator from the environment *)
let pop_it_env (env_it : it_env_t) : unit = env_it := List.tl !env_it

(* Applies |f| on all concrete instanciations of |env_it|. *)
let iter_env_it (env_it : it_env_t) (f : (ident, int) Hashtbl.t -> unit) : unit
    =
  let concrete_env = Hashtbl.create 10 in
  (* Needs to be reversed since computing the bounds of the newest
     iterators could require knowing the values of older ones. *)
  let rec aux (env_it : iterator list) : unit =
    match env_it with
    | [] -> f concrete_env
    | it :: its ->
        let ei = eval_arith concrete_env it.ei in
        let ef = eval_arith concrete_env it.ef in
        List.iter
          (fun i_val ->
            Hashtbl.replace concrete_env it.id i_val;
            aux its;
            Hashtbl.remove concrete_env it.id)
          (gen_list_bounds ei ef)
  in
  aux (List.rev !env_it)

(* let _ = *)
(*   let env_it = ref [] in *)
(*   push_it_env env_it (fresh_ident "i") (Const_e 0) (Const_e 2); *)
(*   push_it_env env_it (fresh_ident "y") (Const_e 3) (Const_e 5); *)
(*   iter_env_it env_it *)
(*    (fun env_it -> *)
(*     Printf.eprintf "{%s}" *)
(*                    (join ", " *)
(*                          (Hashtbl.fold *)
(*                             (fun k v acc -> *)
(*                              (Printf.sprintf "%s:%d" k.name v) :: acc) env_it []))); *)
(*   assert false *)

(* Since we are manipulating loops quite a lot, it's easier to have a
   type that allows to easily access loop's members. *)
type loop = {
  id : ident;
  ei : arith_expr;
  ef : arith_expr;
  mutable dl : deq list;
  opts : stmt_opt list;
}

let loop_rec_of_sum (loop : deq) : loop =
  match loop.content with
  | Eqn _ -> assert false
  | Loop (i, ei, ef, dl, opts) -> { id = i; ei; ef; dl; opts }

(* **************************************************************** *)
(*                          Main functions                          *)

let is_ready_expr (env_var : (ident, typ) Hashtbl.t) (env_it : it_env_t)
    (env_ready : (var, bool) Hashtbl.t) (e : expr) : bool =
  let is_ready = ref true in
  let used_vars = get_used_vars e in
  iter_env_it env_it (fun env_it ->
      List.iter
        (fun v ->
          List.iter
            (fun v ->
              if not (Hashtbl.mem env_ready (instanciate_var env_it v)) then
                is_ready := false)
            (expand_var env_var ~env_it v))
        used_vars);
  !is_ready

let rec is_ready_deq (env_var : (ident, typ) Hashtbl.t) (env_it : it_env_t)
    (env_ready : (var, bool) Hashtbl.t) (deq : deq) : bool =
  (* Since we only have iter_env_it to iterates |env_it|, we are using
     a ref to keep track of whether this deq is ready or not (a
     List.map would have been cleaner otherwise). *)
  let is_ready = ref true in
  (match deq.content with
  | Eqn (_, e, _) ->
      is_ready := !is_ready && is_ready_expr env_var env_it env_ready e
  | Loop (i, ei, ef, dl, _) ->
      push_it_env env_it i ei ef;
      is_ready :=
        !is_ready && List.for_all (is_ready_deq env_var env_it env_ready) dl;
      pop_it_env env_it);
  !is_ready

let is_ready_loop (env_var : (ident, typ) Hashtbl.t) (env_it : it_env_t)
    (env_ready : (var, bool) Hashtbl.t) (loop : loop) : bool =
  push_it_env env_it loop.id loop.ei loop.ef;
  let is_ready = List.for_all (is_ready_deq env_var env_it env_ready) loop.dl in
  pop_it_env env_it;
  is_ready

let is_mergeable (env_var : (ident, typ) Hashtbl.t) (env_it : it_env_t)
    (env_ready : (var, bool) Hashtbl.t) (loop1 : loop) (loop2 : loop) : bool =
  let res = ref true in
  let rec iter_loop (env_it : (ident, int) Hashtbl.t) (check_ready : bool)
      (deqs : deq list) : unit =
    List.iter
      (fun d ->
        match d.content with
        | Eqn (lhs, e, _) ->
            if check_ready then
              List.iter
                (fun v ->
                  if not (Hashtbl.mem env_ready (instanciate_var env_it v)) then
                    res := false)
                (flat_map (expand_var env_var ~env_it) (get_used_vars e));
            List.iter
              (fun v ->
                Hashtbl.replace env_ready (instanciate_var env_it v) true)
              (flat_map (expand_var env_var ~env_it) lhs)
        | Loop (i, ei, ef, dl, _) ->
            let ei = eval_arith env_it ei in
            let ef = eval_arith env_it ef in
            List.iter
              (fun i_val ->
                Hashtbl.add env_it i i_val;
                iter_loop env_it check_ready dl;
                Hashtbl.remove env_it i)
              (gen_list_bounds ei ef))
      deqs
  in
  push_it_env env_it loop1.id loop1.ei loop1.ef;
  iter_env_it env_it (fun env_it ->
      iter_loop env_it false loop1.dl;
      iter_loop env_it true loop2.dl);
  pop_it_env env_it;
  !res

(* Marks all variables defined by |deq| as 'ready'. *)
let rec update_env_ready (env_var : (ident, typ) Hashtbl.t) (env_it : it_env_t)
    (env_ready : (var, bool) Hashtbl.t) (deq : deq) : unit =
  match deq.content with
  | Eqn (lhs, _, _) ->
      iter_env_it env_it (fun env_it ->
          List.iter
            (fun v ->
              List.iter
                (fun v ->
                  Hashtbl.replace env_ready (instanciate_var env_it v) true)
                (expand_var env_var ~env_it v))
            lhs)
  | Loop (i, ei, ef, dl, _) ->
      push_it_env env_it i ei ef;
      List.iter (update_env_ready env_var env_it env_ready) dl;
      pop_it_env env_it

let partition_deqs (env_var : (ident, typ) Hashtbl.t) (env_it : it_env_t)
    (env_ready : (var, bool) Hashtbl.t) (outer : loop) (nexts : deq list) :
    deq list =
  flat_map
    (fun deq ->
      match deq.content with
      | Eqn (_, _, _) -> [ deq ]
      | Loop (i', ei', ef', dl, _) ->
          let loop = loop_rec_of_sum deq in
          if
            (* For now, ignoring any loop that doesn't use
               the same iterator. An improvement would be
               to check the size of the loop instead, and
               if two loops have the same size, fuse
               them. TODO! *)
            (outer.id = loop.id && outer.ei = loop.ei && outer.ef = loop.ef)
            && (* This loop has the same iterator as the
                  current loop. We need to make sure that:
                    - it doesn't rely on variables that are not
                      ready
                    - there is no conficts with current loop.
                  If both conditions are satisfied, merge it. *)
               (* (is_ready_loop env_var env_it env_ready loop) && *)
            is_mergeable env_var env_it (Hashtbl.copy env_ready) outer loop
          then (
            push_it_env env_it i' ei' ef';
            update_env_ready env_var env_it env_ready deq;
            pop_it_env env_it;
            (* Quadratic insertion; OK for now. *)
            outer.dl <- outer.dl @ dl;
            [])
          else [ deq ])
    nexts

let rec fuse_loops_deqs (env_var : (ident, typ) Hashtbl.t) (env_it : it_env_t)
    (env_ready : (var, bool) Hashtbl.t) (deqs : deq list) : deq list =
  match deqs with
  | [] -> []
  | hd :: nexts -> (
      match hd.content with
      | Eqn _ ->
          update_env_ready env_var env_it env_ready hd;
          hd :: fuse_loops_deqs env_var env_it env_ready nexts
      | Loop (i, ei, ef, dl, opts) ->
          push_it_env env_it i ei ef;
          (* Reccursive call with a copy of |env_ready|: we don't want
             to mark this loop's body as ready just yet... *)
          let dl = fuse_loops_deqs env_var env_it (Hashtbl.copy env_ready) dl in
          pop_it_env env_it;
          let loop = { (loop_rec_of_sum hd) with dl } in
          let after = partition_deqs env_var env_it env_ready loop nexts in
          push_it_env env_it i ei ef;
          List.iter (update_env_ready env_var env_it env_ready) loop.dl;
          pop_it_env env_it;
          { hd with content = Loop (i, ei, ef, loop.dl, opts) }
          :: fuse_loops_deqs env_var env_it env_ready after)

let fuse_loops_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      (* Setting up |env_var| *)
      let env_var = build_env_var def.p_in def.p_out vars in
      (* Setting up |env_it| *)
      let env_it = ref [] in
      push_it_env env_it Mask.masking_order (Const_e 2) (Const_e 2);
      (* Setting up |env_ready| (only inputs are ready at first) *)
      let env_ready = Hashtbl.create 1000 in
      iter_env_it env_it (fun env_it ->
          List.iter
            (fun vd ->
              List.iter
                (fun v -> Hashtbl.add env_ready v true)
                (expand_var env_var ~env_it (Var vd.vd_id)))
            def.p_in);
      (* Doing the fusion *)
      {
        def with
        node = Single (vars, fuse_loops_deqs env_var env_it env_ready body);
      }
  | _ -> def

let run _ prog _ =
  let prog = { nodes = List.map fuse_loops_def prog.nodes } in
  { nodes = List.map fuse_loops_def prog.nodes }

let as_pass = (run, "Fuse_loop_general", 0)
