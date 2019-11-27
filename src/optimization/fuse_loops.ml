(*********************************************************************
                          fuse_loops.ml

 ********************************************************************)

open Usuba_AST
open Basic_utils
open Utils


(* **************************************************************** *)
(*                      Helper datastructures                       *)

(* Since we are manipulating loops quite a lot, it's easier to have a
   type that allows to easily access loop's members. *)
type loop = { id : ident;
              ei: arith_expr;
              ef : arith_expr;
              mutable dl : deq list;
              opts: stmt_opt list }
let loop_rec_of_sum (loop:deq) : loop =
  match loop.content with
  | Eqn _ -> assert false
  | Loop(i,ei,ef,dl,opts) -> { id=i; ei=ei; ef=ef; dl=dl; opts=opts }


(* **************************************************************** *)
(*                          Main functions                          *)

(* Returns true if |deqs| doesn't use variables that were skipped. *)
let rec is_mergeable (skipped:(ident,bool) Hashtbl.t)
                     (deqs:deq list) : bool =
  List.for_all (fun d -> match d.content with
                 | Eqn(_,e,_) -> List.for_all (fun id -> not (Hashtbl.mem skipped id))
                                              (List.map get_base_name (get_used_vars e))
                 | Loop(_,_,_,dl,_) -> is_mergeable skipped dl)
               deqs


(* Marks all variables defined by |deq| as 'skipped'. *)
let rec add_to_skipped (skipped:(ident,bool) Hashtbl.t)
                       (deq:deq) : unit =
  match deq.content with
  | Eqn(lhs,_,_) ->
     List.iter (fun v -> Hashtbl.replace skipped (get_base_name v) true) lhs
  | Loop(i,ei,ef,dl,_) ->
     List.iter (add_to_skipped skipped) dl


(* |skipped|: the variables definitions that are not going to be fused
   in |outer|. *)
let rec partition_deqs ?(skipped:(ident,bool) Hashtbl.t=Hashtbl.create 10)
                       (outer:loop) (nexts:deq list) :
          deq list  =
  if false then
    (* This first version is less aggressive when fusing loops: it
       only fuses that are right next to each others. *)
  match nexts with
  | [] -> []
  | hd :: tl ->
     match hd.content with
     | Eqn _ -> nexts
     | Loop(i,ei,ef,dl,_) ->
     if (* For now, ignoring any loop that doesn't use
                          the same iterator. An improvement would be
                          to check the size of the loop instead, and
                          if two loops have the same size, fuse
                          them. TODO! *)
       ((outer.id = i) && (outer.ei = ei) && (outer.ef = ef)) &&
         (* This loop has the same iterator as the
                           current loop. We need to make sure that:
                             - it doesn't rely on variables that are not
                               ready
                             - there is no conficts with current loop.
                           If both conditions are satisfied, merge it. *)
         (* (is_ready_loop env_var env_it env_ready loop) && *)
         (is_mergeable skipped dl) then
       ((* Quadratic insertion; OK for now. *)
         outer.dl <- outer.dl @ dl;
         partition_deqs ~skipped:skipped outer tl)
     else
       nexts
  else
    flat_map (fun deq ->
              match deq.content with
              | Eqn(lhs,_,_) ->
                 add_to_skipped skipped deq;
                 [ deq ]
              | Loop(i,ei,ef,dl,_) ->
                 if (* For now, ignoring any loop that doesn't use
                          the same iterator. An improvement would be
                          to check the size of the loop instead, and
                          if two loops have the same size, fuse
                          them. TODO! *)
                   ((outer.id = i) && (outer.ei = ei) && (outer.ef = ef)) &&
                     (* This loop has the same iterator as the
                           current loop. We need to make sure that:
                             - it doesn't rely on variables that are not
                               ready
                             - there is no conficts with current loop.
                           If both conditions are satisfied, merge it. *)
                     (* (is_ready_loop env_var env_it env_ready loop) && *)
                     (is_mergeable skipped dl) then
                   ((* Quadratic insertion; OK for now. *)
                     outer.dl <- outer.dl @ dl;
                     [])
                 else
                   (add_to_skipped skipped deq;
                    [ deq ])
             ) nexts


let rec fuse_loops_deqs (deqs:deq list) : deq list =
  match deqs with
  | [] -> []
  | hd :: nexts ->
     match hd.content with
     | Eqn _ ->
        hd :: (fuse_loops_deqs nexts)
     | Loop(i,ei,ef,dl,opts) ->
        if i = Mask.loop_idx then
          let loop = loop_rec_of_sum hd in
          let after = partition_deqs loop nexts in
          ({ hd with content=Loop(i,ei,ef,loop.dl,opts)})
            :: (fuse_loops_deqs after)
        else
          ({ hd with content=Loop(i,ei,ef,fuse_loops_deqs dl,opts)})
            :: (fuse_loops_deqs nexts)


let fuse_loops_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     (* Doing the fusion *)
     { def with node = Single(vars,fuse_loops_deqs body) }
  | _ -> def

let fuse_loops (prog:prog) (conf:config) : prog =
  let prog = { nodes = List.map fuse_loops_def prog.nodes } in
  { nodes = List.map fuse_loops_def prog.nodes }
