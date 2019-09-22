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

open Usuba_AST
open Basic_utils
open Utils


(* Given a list of deqs, this module computes the variables that must
   not be optimized away. Those are array variables used in loops or
   in function calls. *)
module Compute_keeps = struct

  let compute_keep_var (env_keep:(ident,bool) Hashtbl.t)
        (env_var:(ident,typ) Hashtbl.t) (v:var) : unit =
    match get_var_type env_var (get_var_base v) with
    | Nat                      -> () (* do not keep *)
    | Uint(_,_,1)              -> () (* do not keep *)
    | Uint(_,_,_) | Array(_,_) -> (* keep! *)
       (* Using .replace rather than .add because we might add
          multiple times the same variable; and we'd rather see it
          appear only once in |env_keep|. *)
       Hashtbl.replace env_keep (get_base_name v) true

  let rec compute_keep_expr (env_keep:(ident,bool) Hashtbl.t)
            (env_var:(ident,typ) Hashtbl.t) (e:expr) : unit =
    match e with
    | Const _        -> ()
    | ExpVar v       -> compute_keep_var env_keep env_var v
    | Shuffle(v,_)   -> compute_keep_var env_keep env_var v
    | Not e'         -> compute_keep_expr env_keep env_var e'
    | Shift(_,e',_)  -> compute_keep_expr env_keep env_var e'
    | Log(_,x,y)     -> compute_keep_expr env_keep env_var x;
                        compute_keep_expr env_keep env_var y
    | Arith(_,x,y)   -> compute_keep_expr env_keep env_var x;
                        compute_keep_expr env_keep env_var y
    | _ -> Printf.eprintf "compute_keep_expr: invalid expr: %s.\n"
             (Usuba_print.expr_to_str e);
           assert false

  (* |in_loop|: true if in a loop, false otherwise. It's used because
     in a loop, any read/write to an array must be performed, whereas
     outside loops (and funcall), those can be optimized away. *)
  let rec compute_keep_deqs (env_keep:(ident,bool) Hashtbl.t)
            (env_var:(ident,typ) Hashtbl.t)
            ?(in_loop:bool = false)
            (deqs:deq list) : unit =
    List.iter (function
        | Eqn(lhs,Fun(f,l),_) ->
           (* keep arrays in |l| *)
           List.iter (compute_keep_expr env_keep env_var) l;
           (* lhs must be kept only if within a loop *)
           if in_loop then
             List.iter (compute_keep_var env_keep env_var) lhs;
        | Eqn([v],e,_) ->
           (* If in loop, keep everything, otherwise, keep nothing. *)
           if in_loop then (
             compute_keep_expr env_keep env_var e;
             compute_keep_var  env_keep env_var v
           )
        | Loop(i,_,_,dl,_) ->
           (* Just reccursive call with |in_loop|=true *)
           Hashtbl.add env_var i Nat;
           compute_keep_deqs env_keep env_var ~in_loop:true dl;
           Hashtbl.remove env_var i
        | deq -> Printf.eprintf "compute_keep_deqs: invalid deq: %s.\n"
                   (Usuba_print.deq_to_str deq);
                 assert false)
      deqs

  let compute_keeps (def:def) : (ident,bool) Hashtbl.t =
    match def.node with
    | Single(vars,body) ->
       let env_var = build_env_var def.p_in def.p_out vars in
       (* |env_keep|: the environment of variables that must not be
        optimized away (ie, the return variables).
        Using a (ident,bool) Hashtbl, but you should see this like a
        Set. *)
       let env_keep = Hashtbl.create 10 in
       List.iter (fun vd -> Hashtbl.add env_keep vd.vid true) def.p_out;
       (* Calling compute_keep_deqs, which will add stuffs to env_keep *)
       compute_keep_deqs env_keep env_var body;
       (* And return env_keep *)
       env_keep
    | _ -> assert false

end

(* This function is a bit weird because |optimized_away| contains Var
   but |ae| contains Var_e, so... Maybe we should consider removing
   arith_expr and keeping only expr. *)
let rec propagate_in_aexpr (optimized_away:(var,expr) Hashtbl.t) (ae:arith_expr) =
  match ae with
  | Const_e _    -> ae
  | Var_e x      -> (match Hashtbl.find_opt optimized_away (Var x) with
                     | Some (Const(c,_)) -> Const_e c
                     | _                 -> Var_e x)
  | Op_e(op,x,y) -> Op_e(op,propagate_in_aexpr optimized_away x,
                         propagate_in_aexpr optimized_away y)

(* Propagates optimized away variables: if |v| has been optimized
   away, it's replaced. *)
let propagate_in_var (optimized_away:(var,expr) Hashtbl.t) (v:var)
    : expr =
  match Hashtbl.find_opt optimized_away v with
  | Some v' -> v'
  | None    -> ExpVar v

(* Need to propagate optimized out variables in expression. *)
(* Returns a `deq list` as well as an `expr`, because if a variable
   used in a Shuffle has been optimized out and is supposed to be
   replaced by a Const, it needs to be un-optmized-out. *)
(* Note that since expressions are normalized at that point, we can
   safely assume that no reccursive call within propagate_in_expr can
   end up in a Shuffle. Therefore, we use propagate_in_expr_rec for
   reccursive calls, thus avoiding us to need discarding an empty deq
   list for each reccursive call. *)
let rec propagate_in_expr  (optimized_away:(var,expr) Hashtbl.t) (e:expr)
        : (deq list) * expr =
  match e with
  | Const _         -> [], e
  | ExpVar v        -> [], propagate_in_var optimized_away v
  | Shuffle(v,l)    ->
     (match propagate_in_var optimized_away v with
      | ExpVar v'    -> [], Shuffle(v', l)
      | Const(n,typ) ->
         (* Need to add |v|'s declaration that will contain this Const *)
         [ Eqn([v],Const(n,typ),false) ],
         Shuffle(v,l)
      | _ -> assert false)
  | Not e'          -> [], Not (propagate_in_expr_rec optimized_away e')
  | Shift(op,e',ae) -> [], Shift(op,propagate_in_expr_rec optimized_away e',
                                 propagate_in_aexpr optimized_away ae)
  | Log(op,x,y)     -> [], Log(op,propagate_in_expr_rec optimized_away x,
                                 propagate_in_expr_rec optimized_away y)
  | Arith(op,x,y)   -> [], Arith(op,propagate_in_expr_rec optimized_away x,
                                   propagate_in_expr_rec optimized_away y)
  | Fun(f,l)        -> [], Fun(f,(List.map (propagate_in_expr_rec optimized_away) l))
  | _ -> Printf.eprintf "propagate_in_expr: invalid expr: %s.\n"
           (Usuba_print.expr_to_str e);
         assert false
and propagate_in_expr_rec (optimized_away:(var,expr) Hashtbl.t) (e:expr)
    : expr =
  match e with
  | Const _  -> e
  | ExpVar v -> propagate_in_var optimized_away v
  | Tuple l -> Tuple (List.map (propagate_in_expr_rec optimized_away) l)
  | _ -> Printf.eprintf "propagate_in_expr_rec: invalid expr: %s.\n"
           (Usuba_print.expr_to_str e);
         assert false


let cp_assign (keep_env:(ident,bool) Hashtbl.t)
      (optimized_away:(var,expr) Hashtbl.t)
      (v:var) (e:expr) (sync:bool) : deq list =
  match Hashtbl.find_opt keep_env (get_base_name v) with
  | Some _ -> (* Need to keep this assignment *)
     (* Can discard the `deq` result of propagate_in_expr as |e| can
        only be an ExpVar or a Const here. *)
     let _,e' = propagate_in_expr optimized_away e in
     (* Don't forget to propagate previous optimized away in |ve|! *)
     [ Eqn([v],e',sync) ]
  | None -> (* No need to keep this assigment -> remove it *)
     (* Looking if |e| is a variable that has been optimized away
        itself. If so, fetching the variable to use instead. *)
     let replace_e = match e with
       | ExpVar ve -> (match Hashtbl.find_opt optimized_away ve with
                       | Some v' -> v'
                       | None    -> ExpVar ve)
       | Const _ -> e
       | _ -> assert false in
     (* Adding to |optimized_away| to be able to propagate to
        subsequent expressions. *)
     Hashtbl.add optimized_away v replace_e;
     (* Adding to |hanging| to be able to re-commit if needed. *)
     []

let rec cp_deqs (env_var:(ident,typ) Hashtbl.t)
          (keep_env:(ident,bool) Hashtbl.t)
          (optimized_away:(var,expr) Hashtbl.t)
          (deqs:deq list) : deq list =
  flat_map (fun deq ->
      match deq with
      | Eqn([v],ExpVar ve,sync) ->
         (* A Var copy -> will be removed if |v| isn't in |keep_env| *)
         cp_assign keep_env optimized_away v (ExpVar ve) sync
      | Eqn([v],Const(n,typ),sync) ->
         (* A Const copy -> will be removed if |v| isn't in |keep_env| *)
         cp_assign keep_env optimized_away v (Const(n,typ)) sync
      | Eqn(lhs,e,sync) ->
         (* A non-copy expression -> propagate copies inside *)
         let (deq,e') = propagate_in_expr optimized_away e in
         deq @ [ Eqn(lhs,e',sync) ]
      | Loop(i,ei,ef,dl,opts)  ->
         (* A loop -> reccursive call *)
         Hashtbl.add env_var i Nat;
         let deq' = Loop(i,ei,ef, cp_deqs env_var keep_env optimized_away dl,opts) in
         Hashtbl.remove env_var i;
         [ deq' ])
    deqs

let cp_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let env_var = build_env_var def.p_in def.p_out vars in
     (* |env_keep|: the environment of variables that must not be
        optimized away (ie, the return variables, and arrays used in
        loops and funcalls).
        Using a (ident,bool) Hashtbl, but you should see this like a
        Set. *)
     let env_keep = Compute_keeps.compute_keeps def in
     (* Environment of optimized away variables. *)
     let optimized_away = Hashtbl.create 100 in
     { def with node = Single(vars,cp_deqs env_var env_keep optimized_away body) }
  | _ -> def

let cp_prog (prog:prog) (conf:config) : prog =
  { nodes = List.map cp_def prog.nodes }
