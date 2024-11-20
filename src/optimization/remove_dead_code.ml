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
open Prelude
open Basic_utils
open Utils
open Usuba_AST

module Find_used_variables = struct
  (* Because of loops, we need to iterate multiple time over the
     program. (see Test_remove_dead_code.test_loop_feedback for a
     simple example (and for a more complex example: without this,
     Usuba can't compile Skinny.)) *)
  let updated = ref false

  let rec find_used_in_deqs (used_vars : bool Ident.Hashtbl.t) (deqs : deq list)
      : unit =
    List.iter
      (fun d ->
        match d.content with
        | Eqn (lhs, e, _) ->
            (* Checking if any of the variables defined is used anywhere *)
            if
              List.exists
                (fun v -> Ident.Hashtbl.mem used_vars (get_base_name v))
                lhs
            then (
              (* First adding all |lhs| variables to |used_vars| that
                 are not in |used_vars| yet. *)
              List.iter
                (fun v ->
                  match Ident.Hashtbl.find_opt used_vars (get_base_name v) with
                  | Some _ -> ()
                  | None ->
                      updated := true;
                      Ident.Hashtbl.add used_vars (get_base_name v) true)
                lhs;
              (* The adding all variables of |e| to |used_vars|. *)
              List.iter
                (fun v ->
                  match Ident.Hashtbl.find_opt used_vars (get_base_name v) with
                  | Some _ -> ()
                  | None ->
                      updated := true;
                      Ident.Hashtbl.add used_vars (get_base_name v) true)
                (get_used_vars e))
        | Loop { body; _ } -> find_used_in_deqs used_vars (List.rev body))
      deqs

  let find_used_variables (def : def) : bool Ident.Hashtbl.t =
    updated := true;
    let used_vars = Ident.Hashtbl.create 100 in
    (match def.node with
    | Single (_, body) ->
        (* Adding outputs to used variables *)
        List.iter
          (fun vd -> Ident.Hashtbl.add used_vars vd.vd_id true)
          def.p_out;
        (* Iterating through the program to find used variables *)
        while !updated do
          updated := false;
          find_used_in_deqs used_vars (List.rev body)
        done
    | _ -> assert false);
    used_vars
end

let rec remove_dead_deqs (used_vars : bool Ident.Hashtbl.t) (deqs : deq list) :
    deq list =
  flat_map
    (fun d ->
      match d.content with
      | Eqn (lhs, e, sync) ->
          if
            List.exists
              (fun v -> Ident.Hashtbl.mem used_vars (get_base_name v))
              lhs
          then
            (* Useful equation, keeping it *)
            [ { d with content = Eqn (lhs, e, sync) } ]
          else (* Unused equation, removing it *)
            []
      | Loop t -> (
          match remove_dead_deqs used_vars t.body with
          (* if |body| is empty, removing the loop altogether. *)
          | [] -> []
          | body ->
              (* |dl'| not empty, keeping the loop *)
              [ { d with content = Loop { t with body } } ]))
    deqs

let remove_dead_code_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      let used_vars = Find_used_variables.find_used_variables def in
      let vars' =
        List.filter (fun vd -> Ident.Hashtbl.mem used_vars vd.vd_id) vars
      in
      let body' = remove_dead_deqs used_vars body in
      { def with node = Single (vars', body') }
  | _ -> def

let run _ prog _ = { nodes = List.map remove_dead_code_def prog.nodes }
let as_pass = (run, "Remove_dead_code", 0)

let%test_module "Remove Dead Code" =
  (module struct
    open Parser_api

    let ( =! ) dl1 dl2 = equal_def dl1 dl2

    let%test "simple" =
      let def =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a,b,c,d:u1\n\
           let\n\
          \    a = x ^ y;\n\
          \    b = 1;\n\
          \    c = a ^ b;\n\
          \    z = a;\n\
           tel"
      in
      let expected =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a:u1\n\
           let\n\
          \    a = x ^ y;\n\
          \    z = a;\n\
           tel"
      in
      remove_dead_code_def def =! expected

    let%test "loop_feedback" =
      let def =
        parse_def
          "node f(x,y:u1[2]) returns (z:u1[2])\n\
          \   vars zt:u1[2],t1:u1[3],t2:u1[3],u:u1\n\
           let\n\
          \    t1[0] = y[0];\n\
          \    t2[0] = y[1];\n\
          \    u = 1;\n\
          \    forall i in [0,1] {\n\
          \      zt[i] = t1[i] ^ x[i];\n\
          \      t1[i+1] = t1[i] ^ t2[i];\n\
          \      t2[i+1] = u ^ 1\n\
          \    }\n\
          \    z[0] = zt[1];\n\
          \    z[1] = zt[2];\n\
          \ tel"
      in
      let expected =
        parse_def
          "node f(x,y:u1[2]) returns (z:u1[2])\n\
          \   vars zt:u1[2],t1:u1[3],t2:u1[3],u:u1\n\
           let\n\
          \    t1[0]  = y[0];\n\
          \    t2[0] = y[1];\n\
          \    u = 1;\n\
          \    forall i in [0,1] {\n\
          \      zt[i] = t1[i] ^ x[i];\n\
          \      t1[i+1] = t1[i] ^ t2[i];\n\
          \      t2[i+1] = u ^ 1\n\
          \    }\n\
          \    z[0] = zt[1];\n\
          \    z[1] = zt[2];\n\
          \ tel"
      in
      remove_dead_code_def def =! expected
  end)
