open Usuba_AST
open Basic_utils
open Utils
open Printf

(* WARNING: this module contains some old code, poorly written and
   documented, kept around just in case. Interleave_generic is reasonably
   well written and documented, and is the current implementation of the
   interleaver -> look at it if you need to, and ignore everything else
   in this file. *)

(* Interleave_generic is a fully parametric interleaving module. It is
    parametrized (not in the sense "functor", but rather in the sense
    "its functions takes some parameters") by:

      - |inter_factor|: how many instances of the cipher should be
        interleaved

      - |grain|: at which granularity should the interleaving be done.

    All instructions are duplicated |inter_factor| times, except for
    function calls, where we just duplicate parameters, and loops,
    where only the body of the loop is duplicated.

    This implies that function calls and loops act as synchronization
    barriers and disregard |grain|. For instance, consider the
    following code:

       a = x;
       b = y;
       forall i in [1, 2] { ... }

    With a |grain| of 3, it becomes:

       a = x;
       b = y;
       a__2 = x__2;
       b__2 = y__2;
       forall i in [1, 2] { ... }

    (note how |a__2| and |b__2| come before forall)


   TODO:

     - think about whether there should be a special case to not
       interleave the body of functions that are less than |grain|
       instructions long. Pro: it would make smaller code, and probably
       should be as fast, or maybe faster (less register pressure
       within the function). Cons: interleaving should happen when
       register pressure is low, and inlining a small function should
       always be useful, or at least not hurt the performances. Cons2:
       interleaving works tightly with scheduling, and this would
       prevent the scheduler from optimizing the interleaving.
 *)

module Interleave_generic = struct
  (* Adds the suffix |suffix| at the end of a var *)
  let rec update_var (env_var : (ident, var_d) Hashtbl.t) (suffix : int)
      (v : var) : var =
    if List.mem Pconst (Hashtbl.find env_var (get_base_name v)).vd_opts then v
    else
      match v with
      | Var v -> Var { v with name = sprintf "%s__%d" v.name suffix }
      | Index (v, ae) -> Index (update_var env_var suffix v, ae)
      | _ -> assert false

  (* Adds the suffix |suffix| at the end of the vars contained in |e| *)
  let rec update_expr (env_var : (ident, var_d) Hashtbl.t) (suffix : int)
      (e : expr) : expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (update_var env_var suffix v)
    | Tuple l -> Tuple (List.map (update_expr env_var suffix) l)
    | Not e -> Not (update_expr env_var suffix e)
    | Shift (op, e, ae) -> Shift (op, update_expr env_var suffix e, ae)
    | Log (op, x, y) ->
        Log (op, update_expr env_var suffix x, update_expr env_var suffix y)
    | Arith (op, x, y) ->
        Arith (op, update_expr env_var suffix x, update_expr env_var suffix y)
    | Shuffle (v, l) -> Shuffle (update_var env_var suffix v, l)
    | _ -> assert false

  (* Duplicates variables in |lhs| (return values of |f|) and
     expressions of |l| (input arguments of |f|). *)
  let update_funcall (inter_factor : int) (env_var : (ident, var_d) Hashtbl.t)
      (lhs : var list) (f : ident) (l : expr list) (sync : bool) : deq_i =
    let lhs =
      flat_map
        (fun v ->
          v
          :: List.map
               (fun suffix -> update_var env_var suffix v)
               (gen_list_bounds 2 inter_factor))
        lhs
    in
    let e_fun =
      Fun
        ( f,
          flat_map
            (fun e ->
              e
              :: List.map
                   (fun suffix -> update_expr env_var suffix e)
                   (gen_list_bounds 2 inter_factor))
            l )
    in
    Eqn (lhs, e_fun, sync)

  (* Returns |deqs| with the suffix |suffix| added at the end of each
     of the variables in each of the expression of |deqs|. *)
  let schedule_deqs (env_var : (ident, var_d) Hashtbl.t) (suffix : int)
      (deqs : deq list) : deq list =
    List.map
      (fun deq ->
        {
          deq with
          content =
            (match deq.content with
            | Eqn (lhs, rhs, sync) ->
                Eqn
                  ( List.map (update_var env_var suffix) lhs,
                    update_expr env_var suffix rhs,
                    sync )
            | _ ->
                (* Loops should not reach this point *)
                assert false);
        })
      deqs

  (* Returns |deqs| duplicated |inter_factor| times by calling
     |schedule_deqs| |inter_factor| times. *)
  let schedule_now (inter_factor : int) (env_var : (ident, var_d) Hashtbl.t)
      (deqs : deq list) : deq list =
    flat_map
      (fun suffix -> schedule_deqs env_var suffix deqs)
      (gen_list_bounds 2 inter_factor)

  (* The function that actually does the interleaving. *)
  let interleave_deqs (inter_factor : int) (grain : int)
      (env_var : (ident, var_d) Hashtbl.t) (deqs : deq list) : deq list =
    (* aux iterates |deqs| while constructing a list of |grain|
       instructions that need to be scheduled once after |grain|
       instructions have been seen.
       Parameters:
           |remain|: how many instructions remain to be added to the
                     current batch
           |ready|: the current batch of instructions
           |nexts|: the remaining instructions (ie, the end of the
                   function)
    *)
    let rec aux (remain : int) (ready : deq list) (nexts : deq list) =
      match nexts with
      | [] -> schedule_now inter_factor env_var (List.rev ready)
      | nexts_hd :: nexts_tl -> (
          match remain with
          | 0 ->
              (* |ready| contains |grain| instructions and they need
                 to be duplicated |inter_factor| times *)
              schedule_now inter_factor env_var (List.rev ready)
              @ (* continue on with the next batch (|remain| set to
                   |grain|, and |ready| set to []) *)
              aux grain [] nexts
          | _ -> (
              (* |ready| contains less than |grain| instructions, keep
                 going on except if the current instruction is a
                 function call or a loop. *)
              match nexts_hd.content with
              | Eqn (lhs, Fun (f, l), sync) ->
                  (* A function call -> need to schedule |ready| now,
                     duplicate the inputs/outputs of the function call,
                     and continue with the next instructions. *)
                  schedule_now inter_factor env_var (List.rev ready)
                  @ [
                      {
                        nexts_hd with
                        content =
                          update_funcall inter_factor env_var lhs f l sync;
                      };
                    ]
                  @ aux grain [] nexts_tl
              | Loop (i, ei, ef, dls, opts) ->
                  (* A loop -> need to schedule |ready| now, duplicate
                     the loops body, and continue with the next
                     instructions. *)
                  schedule_now inter_factor env_var (List.rev ready)
                  @ [
                      {
                        nexts_hd with
                        content = Loop (i, ei, ef, aux grain [] dls, opts);
                      };
                    ]
                  @ aux grain [] nexts_tl
              | Eqn _ ->
                  (* A standard instruction, add it to |ready|, decrement
                     |remain|, and continue with the next instructions. *)
                  nexts_hd :: aux (remain - 1) (nexts_hd :: ready) nexts_tl))
    in
    aux grain [] deqs

  (* Duplicate |inter_factor| times each var_d of |vdl| *)
  let update_vds (inter_factor : int) (vdl : var_d list) : var_d list =
    flat_map
      (fun vd ->
        vd
        ::
        (if List.mem Pconst vd.vd_opts then []
        else
          List.map
            (fun i ->
              {
                vd with
                vd_id =
                  { vd.vd_id with name = sprintf "%s__%d" vd.vd_id.name i };
              })
            (gen_list_bounds 2 inter_factor)))
      vdl

  (* Using a custom build_env_var to have opts and not just types in it. *)
  (* Note that local variables (|vars|) can't be const, but it's
     easier it the environment contains all variables (no need to
     find_opt, find is enough). *)
  let build_env_var (p_in : p) (p_out : p) (vars : p) : (ident, var_d) Hashtbl.t
      =
    let env_var = Hashtbl.create 100 in
    List.iter (fun vd -> Hashtbl.add env_var vd.vd_id vd) p_in;
    List.iter (fun vd -> Hashtbl.add env_var vd.vd_id vd) p_out;
    List.iter (fun vd -> Hashtbl.add env_var vd.vd_id vd) vars;
    env_var

  let interleave_def ~(inter_factor : int) ~(grain : int) (def : def) : def =
    let p_in = update_vds inter_factor def.p_in in
    let p_out = update_vds inter_factor def.p_out in
    {
      def with
      p_in;
      p_out;
      node =
        (match def.node with
        | Single (vars, body) ->
            let env_var = build_env_var p_in p_out vars in
            Single
              ( update_vds inter_factor vars,
                interleave_deqs inter_factor grain env_var body )
        | _ -> failwith "Def.node should be Single");
    }

  let interleave (prog : prog) (conf : config) : prog =
    (* Using 2 as default inter_factor; that's a safe bet *)
    let inter_factor = if conf.inter_factor = 0 then 2 else conf.inter_factor in
    (* Using 1 as default grain; that's reasonable given the CPU
       architecture to maximize parallelism *)
    let grain = if conf.interleave = 0 then 1 else conf.interleave in
    if inter_factor > 1 then
      { nodes = List.map (interleave_def ~inter_factor ~grain) prog.nodes }
    else (* Nothing to do if inter_factor is less than 2 *)
      prog
end

let run _ (prog : prog) (conf : config) =
  Interleave_generic.interleave prog conf
(* Dup2_nofunc_param.interleave conf.interleave prog conf *)
(*Dup2.interleave prog conf*)

let as_pass = (run, "Interleave")
