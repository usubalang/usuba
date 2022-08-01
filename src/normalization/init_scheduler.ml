(***************************************************************************** )
                                init_scheduler.ml

    /!\ Currently disabled!
    (I don't remember why, but I'd guess "because it's buggy". And if I were to
     guess further, I'd say "probably because of arrays")
    /!\

    Schedule the equations of each nodes according to their dependencies.
    (basically, it "imperativize" the code)

    This algorithm is not an optimization: each equation is considered as it comes:
    if its dependencies are ready, then it is scheduled, otherwise it will be scheduled
    later.

  ( *****************************************************************************)

open Prelude
open Usuba_AST

(* Expands a variable, keeping it's intermediary expensions.
   For instance, if x:bool[2][3], then we'll get:
     (x, x[0], x[1], x[0][0], x[0][1], ...)
*)
let rec expand_var_w_inter env_var (v : var) : var list =
  match Utils.get_var_type env_var v with
  | Nat -> [ v ]
  | Uint (_, _, 1) -> [ v ]
  | _ ->
      v
      :: Basic_utils.flat_map
           (expand_var_w_inter env_var)
           (Utils.expand_var_partial env_var v)

(* Expands each var of 'vars' and adds it to the table 'ready' *)
let update_ready (ready : bool VarHashtbl.t) (env_var : typ Ident.Hashtbl.t)
    (vars : var list) : unit =
  List.iter
    (fun v ->
      List.iter
        (fun v' -> VarHashtbl.add ready v' true)
        (expand_var_w_inter env_var v))
    vars

(* Updates to_sched, which is a hash of hash (see comment in schedule_deqs) *)
let update_to_sched (to_sched : bool DeqHashtbl.t VarHashtbl.t) (v : var)
    (deq : deq) : unit =
  match VarHashtbl.find_opt to_sched v with
  | Some h -> DeqHashtbl.replace h deq true
  | None ->
      let h = DeqHashtbl.create 10 in
      DeqHashtbl.replace h deq true;
      VarHashtbl.replace to_sched v h

(* Returns true if 'v' is ready (ie, its definition has been scheduled).
   It's a bit tricky in the case of array.
   For instance, if x:bool[2][3], then x[2] is ready if
     - 'x' has been scheduled
     - x[0], and x[1] has been scheduled.
       And reccursively on x[0] and x[1]
       (x[0] has been scheduled, or x[0][0],x[0][1],x[0][2]...)
*)
let is_ready (env_var : typ Ident.Hashtbl.t) (ready : bool VarHashtbl.t)
    (v : var) : bool =
  (* Looks if sub-variables of v have been scheduled
     ie. (x[0], x[1]) instead of x *)
  let rec is_ready_bot (v : var) : bool =
    match VarHashtbl.mem ready v with
    | true -> true
    | false -> (
        let expanded = Utils.expand_var_partial env_var v in
        match expanded with
        | [ v' ] when equal_var v' v -> false
        | _ -> List.for_all is_ready_bot expanded)
  in

  (* Looks if parent-variable have been scheduled
     ie. x instead of x[0] *)
  let rec is_ready_top (v : var) : bool =
    match VarHashtbl.mem ready v with
    | true -> true
    | false -> (
        match v with
        | Var _ -> false
        | Index (v', _) -> is_ready_top v'
        | _ -> assert false)
  in

  is_ready_bot v || is_ready_top v

let schedule_deqs (env_var : typ Ident.Hashtbl.t) (def : def) (deqs : deq list)
    : deq list =
  let ready = VarHashtbl.create 100 in
  update_ready ready env_var (Utils.p_to_vars def.p_in);

  (* The list of instruction scheduled *)
  let body : deq list ref = ref [] in
  (* The instructions to schedule: a hash of hash:
      { x => { deq1 => true, deq2 => true }}
     means that deq1 and deq2 need to be scheduled once x has been computed
     (because deq1 and deq2 use x) *)
  let to_sched : bool DeqHashtbl.t VarHashtbl.t = VarHashtbl.create 100 in
  (* A hash of the instructions already scheduled *)
  let sched : bool DeqHashtbl.t = DeqHashtbl.create 100 in

  (* 'v' have been scheduled; 'propagate' will try to schedule equations that
     were depending on 'v' *)
  let rec propagate (v : var) : unit =
    (* try to schedule v[0], v[1], etc. *)
    let rec propagate_bot (v : var) =
      if not (VarHashtbl.mem ready v) then (
        if VarHashtbl.mem to_sched v then
          DeqHashtbl.filter_map_inplace
            (fun deq' _ ->
              match sched_it deq' with true -> None | false -> Some true)
            (VarHashtbl.find to_sched v);
        let expanded = Utils.expand_var_partial env_var v in
        match expanded with
        | [ v' ] when equal_var v' v -> ()
        | _ -> List.iter propagate_bot expanded)
    in

    (* if v is actually v'[x], tries to schedule v', iff all of it's components are ready *)
    let rec propagate_top (v : var) =
      if not (VarHashtbl.mem ready v) then (
        if VarHashtbl.mem to_sched v then
          DeqHashtbl.filter_map_inplace
            (fun deq' _ ->
              match sched_it deq' with true -> None | false -> Some true)
            (VarHashtbl.find to_sched v);
        match v with
        | Var _ -> ()
        | Index (v', _) ->
            if
              List.for_all
                (fun x -> VarHashtbl.mem ready x)
                (Utils.expand_var_partial env_var v')
            then propagate_top v'
        | _ -> assert false)
    in

    propagate_bot v;
    propagate_top v
  (* Tries to schedule an instruction.
     Returns true if the instruction was scheduled,
     false otherwise (ie, it's dependencies aren't scheduled yet) *)
  and sched_it (deq : deq) : bool =
    match DeqHashtbl.find_opt sched deq with
    | Some _ -> true
    | None -> (
        match deq.content with
        | Eqn (lhs, e, _) ->
            let used_vars : var list = Utils.get_used_vars e in
            if List.for_all (is_ready env_var ready) used_vars then (
              body := deq :: !body;
              update_ready ready env_var lhs;
              DeqHashtbl.replace sched deq true;
              List.iter propagate lhs;
              List.iter
                (fun v ->
                  match VarHashtbl.find_opt to_sched v with
                  | Some h ->
                      DeqHashtbl.filter_map_inplace
                        (fun deq' _ ->
                          match sched_it deq' with
                          | true -> None
                          | false -> Some true)
                        h
                  | None -> ())
                (Basic_utils.flat_map (expand_var_w_inter env_var) lhs);
              true)
            else (
              (* dependencies not ready *)
              List.iter (fun v -> update_to_sched to_sched v deq) used_vars;
              false)
        | Loop _ ->
            Format.printf "Unexpected loop when scheduling %a.@." (Ident.pp ())
              def.id;
            assert false)
  in

  ignore (List.map sched_it deqs);

  if List.length !body <> List.length deqs then (
    let hash = DeqHashtbl.create 1000 in
    List.iter (fun x -> DeqHashtbl.add hash x true) !body;
    List.iter
      (fun x ->
        match DeqHashtbl.find_opt hash x with
        | Some _ -> ()
        | None -> Format.printf "Didn't schedule %a@." (Usuba_print.pp_deq ()) x)
      deqs;
    raise
      (Errors.Error
         (Format.asprintf "Couldn't find a valid scheduling. (%a)" (Ident.pp ())
            def.id)))
  else List.rev !body

let schedule_def (def : def) : def =
  {
    def with
    node =
      (match def.node with
      | Single (vars, body) ->
          let env_var = Utils.build_env_var def.p_in def.p_out vars in
          Single (vars, schedule_deqs env_var def body)
      | _ -> def.node);
  }

(* Must be called once arrays (and thus Loop) have been removed. *)
let run _ prog _ =
  (* Format.fprintf stderr "Scheduler (simple) disabled.@."; *)
  (* if conf.unroll then *)
  (* { nodes = List.map schedule_def prog.nodes } *)
  (* else *)
  prog

let as_pass = (run, "Init_scheduler", 0)
