(*********************************************************************
                          fuse_loops.ml

 ********************************************************************)

open Prelude
open Usuba_AST
open Basic_utils
open Utils

let bitslice = ref false

(* **************************************************************** *)
(*                      Helper datastructures                       *)

(* Since we are manipulating loops quite a lot, it's easier to have a
   type that allows to easily access loop's members. *)
type loop = {
  id : ident;
  start : arith_expr;
  stop : arith_expr;
  mutable body : deq list;
  opts : stmt_opt list;
}

let loop_rec_of_sum (loop : deq) : loop =
  match loop.content with
  | Eqn _ -> assert false
  | Loop { id; start; stop; body; opts } -> { id; start; stop; body; opts }

(* **************************************************************** *)
(*                          Main functions                          *)

(* Returns true if |deqs| doesn't use variables that were skipped. *)
let rec is_mergeable (skipped : bool Ident.Hashtbl.t) (deqs : deq list) : bool =
  List.for_all
    (fun d ->
      match d.content with
      | Eqn (_, e, _) ->
          List.for_all
            (fun id -> not (Ident.Hashtbl.mem skipped id))
            (List.map get_base_name (get_used_vars e))
      | Loop { body; _ } -> is_mergeable skipped body)
    deqs

(* Marks all variables defined by |deq| as 'skipped'. *)
let rec add_to_skipped (skipped : bool Ident.Hashtbl.t) (deq : deq) : unit =
  match deq.content with
  | Eqn (lhs, _, _) ->
      List.iter
        (fun v -> Ident.Hashtbl.replace skipped (get_base_name v) true)
        lhs
  | Loop { body; _ } -> List.iter (add_to_skipped skipped) body

(* |skipped|: the variables definitions that are not going to be fused
   in |outer|. *)
let rec partition_deqs
    ?(skipped : bool Ident.Hashtbl.t = Ident.Hashtbl.create 10) (outer : loop)
    (nexts : deq list) : deq list =
  if !bitslice then
    (* This first version is less aggressive when fusing loops: it
       only fuses that are right next to each others. *)
    match nexts with
    | [] -> []
    | hd :: tl -> (
        match hd.content with
        | Eqn _ -> nexts
        | Loop { id; start; stop; body; _ } ->
            if
              (* For now, ignoring any loop that doesn't use
                                the same iterator. An improvement would be
                                to check the size of the loop instead, and
                                if two loops have the same size, fuse
                                them. TODO! *)
              (Ident.equal outer.id id
              && equal_arith_expr outer.start start
              && equal_arith_expr outer.stop stop)
              && (* This loop has the same iterator as the
                                   current loop. We need to make sure that:
                                     - it doesn't rely on variables that are not
                                       ready
                                     - there is no conficts with current loop.
                                   If both conditions are satisfied, merge it. *)
                 (* (is_ready_loop env_var env_it env_ready loop) && *)
              is_mergeable skipped body
            then (
              (* Quadratic insertion; OK for now. *)
              outer.body <- outer.body @ body;
              partition_deqs ~skipped outer tl)
            else nexts)
  else
    flat_map
      (fun deq ->
        match deq.content with
        | Eqn (_, _, _) ->
            add_to_skipped skipped deq;
            [ deq ]
        | Loop { id; start; stop; body; _ } ->
            if
              (* For now, ignoring any loop that doesn't use
                    the same iterator. An improvement would be
                    to check the size of the loop instead, and
                    if two loops have the same size, fuse
                    them. TODO! *)
              (Ident.equal outer.id id
              && equal_arith_expr outer.start start
              && equal_arith_expr outer.stop stop)
              && (* This loop has the same iterator as the
                       current loop. We need to make sure that:
                         - it doesn't rely on variables that are not
                           ready
                         - there is no conficts with current loop.
                       If both conditions are satisfied, merge it. *)
                 (* (is_ready_loop env_var env_it env_ready loop) && *)
              is_mergeable skipped body
            then (
              (* Quadratic insertion; OK for now. *)
              outer.body <- outer.body @ body;
              [])
            else (
              add_to_skipped skipped deq;
              [ deq ]))
      nexts

let rec fuse_loops_deqs (deqs : deq list) : deq list =
  match deqs with
  | [] -> []
  | hd :: nexts -> (
      match hd.content with
      | Eqn _ -> hd :: fuse_loops_deqs nexts
      | Loop t ->
          if Ident.equal t.id Mask.loop_idx then
            let loop = loop_rec_of_sum hd in
            let after = partition_deqs loop nexts in
            { hd with content = Loop { t with body = loop.body } }
            :: fuse_loops_deqs after
          else
            { hd with content = Loop { t with body = fuse_loops_deqs t.body } }
            :: fuse_loops_deqs nexts)

let fuse_loops_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      (* Doing the fusion *)
      { def with node = Single (vars, fuse_loops_deqs body) }
  | _ -> def

let run _ (prog : prog) (conf : Config.config) : prog =
  bitslice := Config.equal_slicing conf.slicing_type B;
  let prog = { nodes = List.map fuse_loops_def prog.nodes } in
  { nodes = List.map fuse_loops_def prog.nodes }

let as_pass = (run, "Fuse_loops", 0)
