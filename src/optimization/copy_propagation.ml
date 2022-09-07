(******************************************************************* )
                            copy_propagation.ml

     Copy propagation (abreviated CP throughout Usubac) is yet another
     very common optimization, which consists in eliminating unnecessary
     assignments. Typically,

        x = a + b;
        y = x;
        z = y + c;

     Becomes:

        x = a + b;
        z = x + c;

     Note that when this module runs, the only copy-assignments in the
     code are of primitive types (ie Uint(_,_,1)) since we are in
     Usuba0. (only function calls return multiple arguments, and are
     by definition not "copy-assignments")
     Assignments of Const to variables are also removed by this module
     whenever possible.

     A few things are slightly tricky:

     1\ Not eliminate copies to outputs.
     For instance:

        node f(a:b1) returns (b:b2)
        let
            x = a ^ b;
            b[0] = x;
            y = b[0] ^ 1
            b[1] = y;
        tel

     Should (obisouly) not become:

        node f(a:b1) returns (b:b2)
        let
            x = a ^ b;
            y = x ^ 1;
        tel

     But rather:

        node f(a:b1) returns (b:b2)
        let
            b[0] = a ^ b;
            b[1] = x ^ 1;
        tel


     2\ Not eliminate variables that are going to be used in loops.
     For instance, in the following code,

        x[0] = y;
        forall i in [1, 5] {
          x[i] = a + x[i-1];
        }

     `x[0] = y` should not be removed.


     3\ Not eliminate assignments to arrays that later used in function
     calls. For instance:

        x[0] = a;
        x[1] = b;
        ... = f(x);

     If the first two assignments are optimized away, things gets
     complicated in the call to |f|...


     All of those issues (1,2,3) are dealt with by computing a set
     (called |env_keep| throughout this module) of variables that must
     not be optimized away. This is an overapproximation, because in a
     case like:

       a:u2,b:u2
       b[0] = a[0];
       b[1] = a[1];
       ... = f(b)

     We will not optimized out `b` even though it could be an `f` could
     be called with `a` instead of `b`. TODO: fix.

     Furthermore, within loops, no arrays whatsoever are optimized out:

       node f(x,y:u2[2]) returns (z:u2[2])
          vars a,b,c,d,e:u2[2]
       let
           forall i in [0,1] {
             a[i] = x[i] ^ y[i];
             b[i] = a[i];
             c[i] = b[i];
             d[i] = f(c[i]);
             e[i] = d[i];
             z[i] = e[i]
           }
       tel

     Would not be optimized at all. TODO: fix.


  ( ***************************************************************** *)

open Prelude
open Usuba_AST
open Basic_utils
open Utils

(* Given a list of deqs, this module computes the variables that must
   not be optimized away. Those are array variables used in loops or
   in function calls. *)
module Compute_keeps = struct
  let compute_keep_var (env_keep : bool Ident.Hashtbl.t)
      (env_var : typ Ident.Hashtbl.t) (v : var) : unit =
    match get_var_type env_var (get_var_base v) with
    | Nat -> () (* do not keep *)
    | Uint (_, _, 1) -> () (* do not keep *)
    | Uint (_, _, _) | Array (_, _) ->
        (* keep! *)
        (* Using .replace rather than .add because we might add
           multiple times the same variable; and we'd rather see it
           appear only once in |env_keep|. *)
        Ident.Hashtbl.replace env_keep (get_base_name v) true

  let rec compute_keep_expr (env_keep : bool Ident.Hashtbl.t)
      (env_var : typ Ident.Hashtbl.t) (e : expr) : unit =
    match e with
    | Const _ -> ()
    | ExpVar v -> compute_keep_var env_keep env_var v
    | Shuffle (v, _) -> compute_keep_var env_keep env_var v
    | Not e' -> compute_keep_expr env_keep env_var e'
    | Shift (_, e', _) -> compute_keep_expr env_keep env_var e'
    | Log (_, x, y) ->
        compute_keep_expr env_keep env_var x;
        compute_keep_expr env_keep env_var y
    | Arith (_, x, y) ->
        compute_keep_expr env_keep env_var x;
        compute_keep_expr env_keep env_var y
    | Bitmask (e', _) -> compute_keep_expr env_keep env_var e'
    | Pack (e1, e2, _) ->
        compute_keep_expr env_keep env_var e1;
        compute_keep_expr env_keep env_var e2
    | _ ->
        Format.eprintf "compute_keep_expr: invalid expr: %a.@."
          (Usuba_print.pp_expr ()) e;
        assert false

  (* |in_loop|: true if in a loop, false otherwise. It's used because
     in a loop, any read/write to an array must be performed, whereas
     outside loops (and funcall), those can be optimized away. *)
  let rec compute_keep_deqs (backward : bool) (env_keep : bool Ident.Hashtbl.t)
      (env_var : typ Ident.Hashtbl.t) ?(in_loop : bool = false)
      (deqs : deq list) : unit =
    List.iter
      (fun d ->
        match d.content with
        | Eqn (lhs, Fun (_, l), _) ->
            (* keep arrays in |l| *)
            List.iter (compute_keep_expr env_keep env_var) l;
            (* lhs must be kept only if within a loop *)
            List.iter (compute_keep_var env_keep env_var) lhs
        | Eqn (lhs, e, _) ->
            (* If in loop, keep everything, otherwise, keep nothing. *)
            if in_loop then (
              compute_keep_expr env_keep env_var e;
              List.iter (compute_keep_var env_keep env_var) lhs)
        | Loop { id; body; _ } ->
            (* Just reccursive call with |in_loop|=true *)
            Ident.Hashtbl.add env_var id Nat;
            compute_keep_deqs backward env_keep env_var ~in_loop:true body;
            Ident.Hashtbl.remove env_var id)
      deqs

  (* If |backward| is true, then this function is called for the
     backward copy propagation. See |backward_cp| for more. *)
  let compute_keeps ?(backward : bool = false) (def : def) :
      bool Ident.Hashtbl.t =
    match def.node with
    | Single (vars, body) ->
        let env_var = build_env_var def.p_in def.p_out vars in
        (* |env_keep|: the environment of variables that must not be
           optimized away (ie, the return variables).
           Using a bool Ident.Hashtbl, but you should see this like a
           Set. *)
        let env_keep = Ident.Hashtbl.create 10 in
        if backward then (
          List.iter
            (fun vd -> Ident.Hashtbl.add env_keep vd.vd_id true)
            def.p_in;
          compute_keep_deqs backward env_keep env_var (List.rev body))
        else (
          List.iter
            (fun vd -> Ident.Hashtbl.add env_keep vd.vd_id true)
            def.p_out;
          compute_keep_deqs backward env_keep env_var body);
        (* Calling compute_keep_deqs, which will add stuffs to env_keep *)
        (* And return env_keep *)
        env_keep
    | _ -> assert false
end

(* Copy propagation doesn't work with return values:

    node f(x,y:b1) returns (z:b1)
      vars t1, t2:b1
    let
      t1 = x ^ y;
      t2 = t1;
      z = t2;
    tel

   Becomes (after the regular copy propagation):

    node f(x,y:b1) returns (z:b1)
      vars t1:b1
    let
      t1 = x ^ y;
      z = t1;
    tel

   The module Backwards_propagate will then transform it into:

    node f(x,y:b1) returns (z:b1)
      vars t1:b1
    let
      z = x ^ y;
    tel

   I'm pretty sure that GCC/Clang are pretty good at optimizing
   that. However, this would be better for the heuristic inlining: the
   node f above would be recognized as being 50% assignment without
   backward copy propagation, which is obviously wrong: it's actually
   0% assignments...
*)
module Backwards_cp = struct
  (* This function is a bit weird because |optimized_away| contains Var
     but |ae| contains Var_e, so... Maybe we should consider removing
     arith_expr and keeping only expr. *)
  let rec propagate_in_aexpr (optimized_away : var VarHashtbl.t)
      (ae : arith_expr) : arith_expr =
    match ae with
    | Const_e _ -> ae
    | Var_e x -> (
        match VarHashtbl.find_opt optimized_away (Var x) with
        | Some (Var v) -> Var_e v
        | _ -> Var_e x)
    | Op_e (op, x, y) ->
        Op_e
          ( op,
            propagate_in_aexpr optimized_away x,
            propagate_in_aexpr optimized_away y )

  (* Propagates optimized away variables: if |v| has been optimized
     away, it's replaced. *)
  let propagate_in_var (optimized_away : var VarHashtbl.t) (v : var) : var =
    match VarHashtbl.find_opt optimized_away v with Some v' -> v' | None -> v

  (* Basically does nothing besides recursively calling itself until
     it reaches an ExpVar, on which it calls propagate_in_var *)
  let rec propagate_in_expr (optimized_away : var VarHashtbl.t) (e : expr) :
      expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (propagate_in_var optimized_away v)
    | Tuple l -> Tuple (List.map (propagate_in_expr optimized_away) l)
    | Shuffle (v, l) -> Shuffle (propagate_in_var optimized_away v, l)
    | Not e' -> Not (propagate_in_expr optimized_away e')
    | Shift (op, e', ae) ->
        Shift
          ( op,
            propagate_in_expr optimized_away e',
            propagate_in_aexpr optimized_away ae )
    | Log (op, x, y) ->
        Log
          ( op,
            propagate_in_expr optimized_away x,
            propagate_in_expr optimized_away y )
    | Arith (op, x, y) ->
        Arith
          ( op,
            propagate_in_expr optimized_away x,
            propagate_in_expr optimized_away y )
    | Bitmask (e', ae) ->
        Bitmask
          ( propagate_in_expr optimized_away e',
            propagate_in_aexpr optimized_away ae )
    | Pack (e1, e2, t) ->
        Pack
          ( propagate_in_expr optimized_away e1,
            propagate_in_expr optimized_away e2,
            t )
    | Fun (f, l) -> Fun (f, List.map (propagate_in_expr optimized_away) l)
    | _ ->
        Format.eprintf "propagate_in_expr: invalid expr: %a.@."
          (Usuba_print.pp_expr ()) e;
        assert false

  let cp_assign (keep_env : bool Ident.Hashtbl.t)
      (out_env : bool Ident.Hashtbl.t) (optimized_away : var VarHashtbl.t)
      (orig : (ident * deq_i) list) (v : var) (ve : var) (sync : bool) :
      deq list =
    match Ident.Hashtbl.find_opt keep_env (get_base_name ve) with
    | Some _ ->
        (* Need to keep this assignment *)
        (* No need to propagate: |ve| is in |keep_env|. *)
        [ { orig; content = Eqn ([ v ], ExpVar ve, sync) } ]
    | None -> (
        (* Can remove this assignment *)
        match Ident.Hashtbl.find_opt out_env (get_base_name v) with
        | Some _ -> (
            match VarHashtbl.find_opt optimized_away ve with
            | Some ve' ->
                (* |ve| has already been optimized out ->
                      keeping this assignment, with |ve'|
                      instead of |ve| *)
                [ { orig; content = Eqn ([ v ], ExpVar ve', sync) } ]
            | None ->
                (* Optimizing this assignment away *)
                VarHashtbl.add optimized_away ve v;
                [])
        | None ->
            (* Not a variable we are interested in optimizing away. *)
            [ { orig; content = Eqn ([ v ], ExpVar ve, sync) } ])

  let rec cp_deqs (env_var : typ Ident.Hashtbl.t)
      (keep_env : bool Ident.Hashtbl.t) (out_env : bool Ident.Hashtbl.t)
      (optimized_away : var VarHashtbl.t) (deqs : deq list) : deq list =
    flat_map
      (fun deq ->
        match deq.content with
        | Eqn ([ v ], ExpVar ve, sync) ->
            (* A Var copy -> will be removed if |v| isn't in |keep_env| *)
            cp_assign keep_env out_env optimized_away deq.orig v ve sync
        | Eqn (lhs, e, sync) ->
            (* A non-copy expression -> propagate copies inside *)
            [
              {
                deq with
                content =
                  Eqn
                    ( List.map (propagate_in_var optimized_away) lhs,
                      propagate_in_expr optimized_away e,
                      sync );
              };
            ]
        | Loop t ->
            (* A loop -> reccursive call *)
            Ident.Hashtbl.add env_var t.id Nat;
            let body =
              List.rev
                (cp_deqs env_var keep_env out_env optimized_away
                   (List.rev t.body))
            in
            let deq' = { deq with content = Loop { t with body } } in
            Ident.Hashtbl.remove env_var t.id;
            [ deq' ])
      deqs

  let cp_def (def : def) : def =
    match def.node with
    | Single (vars, body) ->
        let env_var = build_env_var def.p_in def.p_out vars in
        let keep_env = Compute_keeps.compute_keeps ~backward:true def in
        let out_env = Ident.Hashtbl.create 100 in
        List.iter (fun vd -> Ident.Hashtbl.add out_env vd.vd_id true) def.p_out;
        let optimized_away = VarHashtbl.create 100 in
        let body =
          List.rev
            (cp_deqs env_var keep_env out_env optimized_away (List.rev body))
        in
        { def with node = Single (vars, body) }
    | _ -> def
end

(* This function is a bit weird because |optimized_away| contains Var
   but |ae| contains Var_e, so... Maybe we should consider removing
   arith_expr and keeping only expr. *)
let rec propagate_in_aexpr
    (optimized_away : (expr * (ident * deq_i) list) VarHashtbl.t)
    (ae : arith_expr) =
  match ae with
  | Const_e _ -> ae
  | Var_e x -> (
      match VarHashtbl.find_opt optimized_away (Var x) with
      | Some (Const (c, _), _) -> Const_e c
      | Some (ExpVar (Var v), _) -> Var_e v
      | _ -> Var_e x)
  | Op_e (op, x, y) ->
      Op_e
        ( op,
          propagate_in_aexpr optimized_away x,
          propagate_in_aexpr optimized_away y )

(* Propagates optimized away variables: if |v| has been optimized
   away, it's replaced. *)
let propagate_in_var
    (optimized_away : (expr * (ident * deq_i) list) VarHashtbl.t) (v : var) :
    expr * (ident * deq_i) list =
  match VarHashtbl.find_opt optimized_away v with
  | Some (v', orig) -> (v', orig)
  | None -> (ExpVar v, [])

(* Need to propagate optimized out variables in expression. *)
(* Returns a `deq list` as well as an `expr`, because if a variable
   used in a Shuffle has been optimized out and is supposed to be
   replaced by a Const, it needs to be un-optmized-out. *)
(* Note that since expressions are normalized at that point, we can
   safely assume that no reccursive call within propagate_in_expr can
   end up in a Shuffle. Therefore, we use propagate_in_expr_rec for
   reccursive calls, thus avoiding us to need discarding an empty deq
   list for each reccursive call. *)
let rec propagate_in_expr
    (optimized_away : (expr * (ident * deq_i) list) VarHashtbl.t) (e : expr) :
    deq list * expr =
  match e with
  | Const _ -> ([], e)
  | ExpVar v -> ([], fst (propagate_in_var optimized_away v))
  | Shuffle (v, l) -> (
      match propagate_in_var optimized_away v with
      | ExpVar v', _ -> ([], Shuffle (v', l))
      | Const (n, typ), orig ->
          (* Need to add |v|'s declaration that will contain this Const *)
          ( [ { content = Eqn ([ v ], Const (n, typ), false); orig } ],
            Shuffle (v, l) )
      | _ -> assert false)
  | Not e' -> ([], Not (propagate_in_expr_rec optimized_away e'))
  | Shift (op, e', ae) ->
      ( [],
        Shift
          ( op,
            propagate_in_expr_rec optimized_away e',
            propagate_in_aexpr optimized_away ae ) )
  | Log (op, x, y) ->
      ( [],
        Log
          ( op,
            propagate_in_expr_rec optimized_away x,
            propagate_in_expr_rec optimized_away y ) )
  | Arith (op, x, y) ->
      ( [],
        Arith
          ( op,
            propagate_in_expr_rec optimized_away x,
            propagate_in_expr_rec optimized_away y ) )
  | Bitmask (e', ae) ->
      ( [],
        Bitmask
          ( propagate_in_expr_rec optimized_away e',
            propagate_in_aexpr optimized_away ae ) )
  | Pack (e1, e2, t) ->
      ( [],
        Pack
          ( propagate_in_expr_rec optimized_away e1,
            propagate_in_expr_rec optimized_away e2,
            t ) )
  | Fun (f, l) ->
      ([], Fun (f, List.map (propagate_in_expr_rec optimized_away) l))
  | _ ->
      Format.eprintf "propagate_in_expr: invalid expr: %a.@."
        (Usuba_print.pp_expr ()) e;
      assert false

and propagate_in_expr_rec
    (optimized_away : (expr * (ident * deq_i) list) VarHashtbl.t) (e : expr) :
    expr =
  match e with
  | Const _ -> e
  | ExpVar v -> fst (propagate_in_var optimized_away v)
  | Tuple l -> Tuple (List.map (propagate_in_expr_rec optimized_away) l)
  | _ ->
      Format.eprintf "propagate_in_expr_rec: invalid expr: %a.@."
        (Usuba_print.pp_expr ()) e;
      assert false

let cp_assign (keep_env : bool Ident.Hashtbl.t)
    (optimized_away : (expr * (ident * deq_i) list) VarHashtbl.t)
    (orig : (ident * deq_i) list) (v : var) (e : expr) (sync : bool) : deq list
    =
  match Ident.Hashtbl.find_opt keep_env (get_base_name v) with
  | Some _ ->
      (* Need to keep this assignment *)
      (* Can discard the `deq` result of propagate_in_expr as |e| can
         only be an ExpVar or a Const here. *)
      let _, e' = propagate_in_expr optimized_away e in
      (* Don't forget to propagate previous optimized away in |ve|! *)
      [ { orig; content = Eqn ([ v ], e', sync) } ]
  | None ->
      (* No need to keep this assigment -> remove it *)
      (* Looking if |e| is a variable that has been optimized away
         itself. If so, fetching the variable to use instead. *)
      let replace_e =
        match e with
        | ExpVar ve -> (
            match VarHashtbl.find_opt optimized_away ve with
            | Some (v', _) -> v'
            | None -> ExpVar ve)
        | Const _ -> e
        | _ -> assert false
      in
      (* Adding to |optimized_away| to be able to propagate to
         subsequent expressions. *)
      VarHashtbl.add optimized_away v (replace_e, orig);
      (* Adding to |hanging| to be able to re-commit if needed. *)
      []

let rec cp_deqs (env_var : typ Ident.Hashtbl.t)
    (keep_env : bool Ident.Hashtbl.t)
    (optimized_away : (expr * (ident * deq_i) list) VarHashtbl.t)
    (deqs : deq list) : deq list =
  flat_map
    (fun deq ->
      match deq.content with
      | Eqn ([ v ], ExpVar ve, sync) ->
          (* A Var copy -> will be removed if |v| isn't in |keep_env| *)
          cp_assign keep_env optimized_away deq.orig v (ExpVar ve) sync
      | Eqn ([ v ], Const (n, typ), sync) ->
          (* A Const copy -> will be removed if |v| isn't in |keep_env| *)
          cp_assign keep_env optimized_away deq.orig v (Const (n, typ)) sync
      | Eqn (lhs, e, sync) ->
          (* A non-copy expression -> propagate copies inside *)
          let deq', e' = propagate_in_expr optimized_away e in
          deq' @ [ { deq with content = Eqn (lhs, e', sync) } ]
      | Loop t ->
          (* A loop -> reccursive call *)
          Ident.Hashtbl.add env_var t.id Nat;
          let deq' =
            {
              deq with
              content =
                Loop
                  {
                    t with
                    body = cp_deqs env_var keep_env optimized_away t.body;
                  };
            }
          in
          Ident.Hashtbl.remove env_var t.id;
          [ deq' ])
    deqs

let cp_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      let env_var = build_env_var def.p_in def.p_out vars in
      (* |env_keep|: the environment of variables that must not be
         optimized away (ie, the return variables, and arrays used in
         loops and funcalls).
         Using a bool Ident.Hashtbl, but you should see this like a
         Set. *)
      let env_keep = Compute_keeps.compute_keeps def in
      (* Environment of optimized away variables. *)
      let optimized_away = VarHashtbl.create 100 in
      Backwards_cp.cp_def
        {
          def with
          node = Single (vars, cp_deqs env_var env_keep optimized_away body);
        }
  | _ -> def

let run _ prog _ = { nodes = List.map cp_def prog.nodes }
let as_pass = (run, "Copy_propagation", 0)

let%test_module "Copy Propagation" =
  (module struct
    open Parser_api

    let ( =! ) dl1 dl2 = equal_def dl1 dl2

    (* Just a bunch of equations; no loops; no arrays; no functions calls. *)
    let%test "simple" =
      let def =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a,b,c:u1\n\
           let\n\
          \    a = x ^ y;\n\
          \    b = a;\n\
          \    c = b;\n\
          \    z = c;\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a,b,c:u1\n\
           let\n\
          \    z = x ^ y;\n\
           tel"
      in
      result =! expected

    (* Still no funcalls and no loops, but some arrays *)
    let%test "arrays" =
      let def =
        parse_def
          "node f(x,y:u1[2]) returns (z:u1[2])\n\
          \   vars a,b,c:u1[2]\n\
           let\n\
          \    a[0] = x[0] ^ y[0];\n\
          \    a[1] = x[1] ^ y[1];\n\
          \    b[0] = a[0];\n\
          \    b[1] = a[1];\n\
          \    c[0] = b[0];\n\
          \    c[1] = b[1];\n\
          \    z[0] = c[0];\n\
          \    z[1] = c[1];\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u1[2]) returns (z:u1[2])\n\
          \   vars a,b,c:u1[2]\n\
           let\n\
          \    z[0] = x[0] ^ y[0];\n\
          \    z[1] = x[1] ^ y[1];\n\
           tel"
      in
      result =! expected

    (* With a loop (but no funcalls) *)
    let%test "loop_nofun" =
      let def =
        parse_def
          "node f(x,y:u1[2]) returns (z:u1[2])\n\
          \   vars a,b,c:u1[2]\n\
           let\n\
          \    forall i in [1,2] {\n\
          \      a[i] = x[i] ^ y[i];\n\
          \    }\n\
          \    b[0] = a[0];\n\
          \    b[1] = a[1];\n\
          \    c[0] = b[0];\n\
          \    c[1] = b[1];\n\
          \    z[0] = c[0];\n\
          \    z[1] = c[1];\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u1[2]) returns (z:u1[2])\n\
          \   vars a,b,c:u1[2]\n\
           let\n\
          \    forall i in [1,2] {\n\
          \      a[i] = x[i] ^ y[i];\n\
          \    }\n\
          \    z[0] = a[0];\n\
          \    z[1] = a[1];\n\
          \ tel"
      in
      result =! expected

    (* With a funcall (but no loops, no arr) *)
    let%test "funcall_noarr" =
      let def =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a,b,c,d:u1\n\
           let\n\
          \    a = x ^ y;\n\
          \    b = a;\n\
          \    c = f(b);\n\
          \    d = c;\n\
          \    z = d;\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a,b,c,d:u1\n\
           let\n\
          \    a = x ^ y;\n\
          \    z = f(a);\n\
           tel"
      in
      result =! expected

    (* With a funcall and arrays (but no loops) *)
    let%test "funcall_arr" =
      let def =
        parse_def
          "node f(x,y:u2[2]) returns (z:u2[2])\n\
          \   vars a,b,c,d:u2[2]\n\
           let\n\
          \    a[0] = x[0] ^ y[0];\n\
          \    a[1] = x[1] ^ y[1];\n\
          \    b[0] = a[0];\n\
          \    b[1] = a[1];\n\
          \    c = f(b);\n\
          \    d[0] = c[0];\n\
          \    d[1] = c[1];\n\
          \    z[0] = d[0];\n\
          \    z[1] = d[1];\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u2[2]) returns (z:u2[2])\n\
          \   vars a,b,c,d:u2[2]\n\
           let\n\
          \    a[0] = x[0] ^ y[0];\n\
          \    a[1] = x[1] ^ y[1];\n\
          \    b[0] = a[0];\n\
          \    b[1] = a[1];\n\
          \    c = f(b);\n\
          \    z[0] = c[0];\n\
          \    z[1] = c[1];\n\
           tel"
      in
      result =! expected

    (* With a funcall, arrays and loop. Funcall is outside the loop. *)
    let%test "funcall_loop1" =
      let def =
        parse_def
          "node f(x,y:u2[2]) returns (z:u2[2])\n\
          \   vars a,b,c,d,e:u2[2]\n\
           let\n\
          \    forall i in [0,1] {\n\
          \      a[i] = x[i] ^ y[i];\n\
          \    }\n\
          \    b[0] = a[0];\n\
          \    b[1] = a[1];\n\
          \    c[0] = b[0];\n\
          \    c[1] = b[1];\n\
          \    d = f(c);\n\
          \    e[0] = d[0];\n\
          \    e[1] = d[1];\n\
          \    z[0] = e[0];\n\
          \    z[1] = e[1];\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u2[2]) returns (z:u2[2])\n\
          \   vars a,b,c,d,e:u2[2]\n\
           let\n\
          \    forall i in [0,1] {\n\
          \      a[i] = x[i] ^ y[i];\n\
          \    }\n\
          \    c[0] = a[0];\n\
          \    c[1] = a[1];\n\
          \    d = f(c);\n\
          \    z[0] = d[0];\n\
          \    z[1] = d[1];\n\
           tel"
      in
      result =! expected

    (* With a funcall, arrays and loop. Funcall is inside the loop. *)
    let%test "funcall_loop2" =
      let def =
        parse_def
          "node f(x,y:u2[2]) returns (z:u2[2])\n\
          \   vars a,b,c,d,e:u2[2]\n\
           let\n\
          \    forall i in [0,1] {\n\
          \      a[i] = x[i] ^ y[i];\n\
          \      b[i] = a[i];\n\
          \      c[i] = b[i];\n\
          \      d[i] = f(c[i]);\n\
          \      e[i] = d[i];\n\
          \      z[i] = e[i]\n\
          \    }\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u2[2]) returns (z:u2[2])\n\
          \   vars a,b,c,d,e:u2[2]\n\
           let\n\
          \    forall i in [0,1] {\n\
          \      a[i] = x[i] ^ y[i];\n\
          \      b[i] = a[i];\n\
          \      c[i] = b[i];\n\
          \      d[i] = f(c[i]);\n\
          \      e[i] = d[i];\n\
          \      z[i] = e[i]\n\
          \    }\n\
           tel"
      in
      result =! expected

    (* Just makes sure that assignments of Consts are indeed removed. *)
    let%test "simple_const" =
      let def =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a,b,c:u1\n\
           let\n\
          \    a = 5;\n\
          \    b = a;\n\
          \    c = b;\n\
          \    z = c;\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u1) returns (z:u1)\n\
          \   vars a,b,c:u1\n\
           let\n\
          \    z = 5;\n\
           tel"
      in
      result =! expected

    (* Shuffle are a bit special because they only work on Vars. Making
       sure that no Shuffle will use a variable that was optimized away or
       something like that. *)
    let%test "shuffle" =
      let def =
        parse_def
          "node f(x,y:u4) returns (z:u4)\n\
          \   vars a,b,c,d,e:u4\n\
           let\n\
          \    a = 5;\n\
          \    b = a{1,0,3,2};\n\
          \    c = b ^ x;\n\
          \    d = c ^ y;\n\
          \    e = d;\n\
          \    z = e;\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:u4) returns (z:u4)\n\
          \   vars a,b,c,d,e:u4\n\
           let\n\
          \    a = 5;\n\
          \    b = a{1,0,3,2};\n\
          \    c = b ^ x;\n\
          \    z = c ^ y;\n\
           tel"
      in
      result =! expected

    (* Make sure that Consts assignments are optimized away as well *)
    let%test "const" =
      let def =
        parse_def
          "node f(x,y:b1) returns (z:b1)\n\
          \    vars a,b:b1\n\
           let\n\
          \    a = 0;\n\
          \    b = a ^ x;\n\
          \    z = b ^ y;\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:b1) returns (z:b1)\n\
          \    vars a,b:b1\n\
           let\n\
          \    b = 0 ^ x;\n\
          \    z = b ^ y;\n\
           tel"
      in
      result =! expected

    (* Make sure that Consts assignments are optimized away as well *)
    let%test "const_advanced" =
      let def =
        parse_def
          "node f(x,y:b1) returns (z:b1)\n\
          \    vars a,b,c:b1\n\
           let\n\
          \    a = 0;\n\
          \    b = a;\n\
          \    c = b ^ x;\n\
          \    z = c ^ y;\n\
           tel"
      in
      let result = cp_def def in
      (* Note that local variables are not optimized away by this module. *)
      let expected =
        parse_def
          "node f(x,y:b1) returns (z:b1)\n\
          \    vars a,b,c:b1\n\
           let\n\
          \    c = 0 ^ x;\n\
          \    z = c ^ y;\n\
           tel"
      in
      result =! expected
  end)
