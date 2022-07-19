(******************************************************************* )
                              remove_dead_code.ml

     Dead code elimination within nodes is done in two pass: the first
     one (Find_used_variables) iterates the program from the end to the
     start, keeping track of all variables needed to compute the
     output. The second one iterates the program from the start to the
     end: any variable that isn't needed to compute the outputs is
     removed.

     Note that this modules assumes that equations have already been
     scheduled.

     Note that we adopt a conservative approach with regards to loops
     and arrays: is any element of an array is needed to compute any
     element of the output, it is kept. Which means that, the following
     code:

        x[0] = 1;
        x[1] = 2;
        output = x[0];

     will be left as is, even though `x[1]` is not used. TODO: fix.

  ( ***************************************************************** *)
open Basic_utils
open Utils
open Usuba_AST

module Find_used_variables = struct
  (* Because of loops, we need to iterate multiple time over the
     program. (see Test_remove_dead_code.test_loop_feedback for a
     simple example (and for a more complex example: without this,
     Usuba can't compile Skinny.)) *)
  let updated = ref false

  let rec find_used_in_deqs (used_vars : (ident, bool) Hashtbl.t)
      (deqs : deq list) : unit =
    List.iter
      (fun d ->
        match d.content with
        | Eqn (lhs, e, _) ->
            (* Checking if any of the variables defined is used anywhere *)
            if
              List.exists (fun v -> Hashtbl.mem used_vars (get_base_name v)) lhs
            then (
              (* First adding all |lhs| variables to |used_vars| that
                 are not in |used_vars| yet. *)
              List.iter
                (fun v ->
                  match Hashtbl.find_opt used_vars (get_base_name v) with
                  | Some _ -> ()
                  | None ->
                      updated := true;
                      Hashtbl.replace used_vars (get_base_name v) true)
                lhs;
              (* The adding all variables of |e| to |used_vars|. *)
              List.iter
                (fun v ->
                  match Hashtbl.find_opt used_vars (get_base_name v) with
                  | Some _ -> ()
                  | None ->
                      updated := true;
                      Hashtbl.replace used_vars (get_base_name v) true)
                (get_used_vars e))
        | Loop (_, _, _, dl, _) -> find_used_in_deqs used_vars (List.rev dl))
      deqs

  let find_used_variables (def : def) : (ident, bool) Hashtbl.t =
    updated := true;
    let used_vars = Hashtbl.create 100 in
    (match def.node with
    | Single (_, body) ->
        (* Adding outputs to used variables *)
        List.iter (fun vd -> Hashtbl.add used_vars vd.vd_id true) def.p_out;
        (* Iterating through the program to find used variables *)
        while !updated do
          updated := false;
          find_used_in_deqs used_vars (List.rev body)
        done
    | _ -> ());
    used_vars
end

let rec remove_dead_deqs (used_vars : (ident, bool) Hashtbl.t) (deqs : deq list)
    : deq list =
  flat_map
    (fun d ->
      match d.content with
      | Eqn (lhs, e, sync) ->
          if List.exists (fun v -> Hashtbl.mem used_vars (get_base_name v)) lhs
          then
            (* Useful equation, keeping it *)
            [ { d with content = Eqn (lhs, e, sync) } ]
          else (* Unused equation, removing it *)
            []
      | Loop (i, ei, ef, dl, opts) ->
          let dl' = remove_dead_deqs used_vars dl in
          (* if |dl'| is empty, removing the loop altogether. *)
          if dl' = [] then []
          else
            (* |dl'| not empty, keeping the loop *)
            [ { d with content = Loop (i, ei, ef, dl', opts) } ])
    deqs

let remove_dead_code_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      let used_vars = Find_used_variables.find_used_variables def in
      let vars' = List.filter (fun vd -> Hashtbl.mem used_vars vd.vd_id) vars in
      let body' = remove_dead_deqs used_vars body in
      { def with node = Single (vars', body') }
  | _ -> def

let run _ prog _ = { nodes = List.map remove_dead_code_def prog.nodes }
let as_pass = (run, "Remove_dead_code", 0)
