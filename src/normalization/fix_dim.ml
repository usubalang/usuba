(*********************************************************************
   fix_dim.ml

   Usuba thinks that arrays like u1x8[16] and u1x128 are the same
   thing, but they really aren't. This module fixes that.

   The main reason why this transformation is inlining will fail
   without it. For instance:
     node f(x:u1[2][3]) ...
      let ... x[0][1] ... tel
     node g(a:u1[6]) ...
      let ... f(a) ... tel
   When inlining f in g, we'd end with a[0][1], but a has type u1[6]...


   Note that changing the dimension of a parameter of a node f can
   cause functions calls inside f to have too many parameters. For
   instance:

     f (a1:b3,a2:b3) returns (b:b6) let b = (a1,a2)       tel
     g (a:b3[2]) returns (b:b6)     let b = f(a[0],a[1])  tel
     h (a:b6) returns (b:b6)        let b = g(a)          tel

   The call `b = g(a)` inside `h` requires `g` to have its parameter
   `a` expanded. We then get

     g (a:b6) returns (b:b6) let b = f(a[0],a[1],a[2],a[3],a[4],a[5]) tel

   And as you can see, `f` is now called with 6 parameters instead
   of 2. Expand_parameters must therefore be called before going any
   further (ie, before trying to match the call to `f` in `g`.
   (this happend in real life on AES bitslice for instance)


 ********************************************************************)

open Usuba_AST
open Utils
open Pass_runner

(* Returns the "nested" level of a type: it corresponds to how many
   nested arrays there are in the type.
   For instance:
       get_nested_level( Array(Array(Uint(_,_,1))) ) == 2
       get_nested_level( Uint(_,_,5) ) == 1 get_nested_level(
       Uint(_,_,1) ) == 0 *)
let rec get_nested_level (t : typ) : int =
  match t with
  | Nat -> 0
  | Uint (_, _, 1) -> 0
  | Uint (_, _, _) -> 1
  | Array (t', _) -> 1 + get_nested_level t'

(* Returns true if |t1| and |t2| have the same nested level, but
   different dimensions. Since the type-checker accepted the program,
   it means that we are in case where we have for instance b1[2][3] vs
   b1[3][2]. But this coud be more nested as well: b1[2][3][4] vs
   b1[6][2][2].
*)
let rec not_same_dim (t1 : typ) (t2 : typ) : bool =
  if get_nested_level t1 <> get_nested_level t2 then false
  else
    match (t1, t2) with
    | Array (t1', s1), Array (t2', s2) -> s1 <> s2 || not_same_dim t1' t2'
    | _, _ ->
        (* Here, both t1 and t2 have to be Uint(_,_,_). There
           is not need to check the size of the Uint, because
           if they differ, then the size of a previous array
           must have differ as well. *)
        false

(* Returns the number of nested Index in |v|. *)
let rec get_index_level (v : var) : int =
  match v with
  | Var _ -> 0
  | Index (v', _) -> 1 + get_index_level v'
  | _ ->
      (* Usuba0, can't have Slice/Range *)
      assert false

(* Collapses the last two Index of |v|.
   Need to be careful that they actually need to be collapsed. For
   instance, consider x:u1[2][3][4]:
       (1) x[1] should not be changed,
       (2) x[1][2] should be come x[1][8..11],
       (3) x[1][2][3] should become x[1][11].
*)
let dim_var (v_tgt : var) (dim : int) (size : int) (v : var) : var =
  if get_var_base v = v_tgt then (
    let index_lvl = get_index_level v in
    (* Depending on |dim|-|index_lvl|, a different transformation
         must be done (see the function's comment above) *)
    assert (dim >= index_lvl);
    match dim - index_lvl with
    | 0 -> (
        (* case (3) in the comment above *)
        match v with
        | Index (Index (v', i1), i2) ->
            Index
              (v', simpl_arith_ne (Op_e (Add, Op_e (Mul, i1, Const_e size), i2)))
        | _ -> assert false)
    | 1 -> (
        (* case (2) in the comment above *)
        match v with
        | Index (v', i1) ->
            Range
              ( v',
                simpl_arith_ne (Op_e (Mul, i1, Const_e size)),
                simpl_arith_ne
                  (Op_e (Add, Op_e (Mul, i1, Const_e size), Const_e (size - 1)))
              )
        | _ -> assert false)
    | _ -> v
    (* case (1) in the comment above *))
  else (* v != v_tgt *) v

let rec dim_expr (v_tgt : var) (dim : int) (size : int) (e : expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> ExpVar (dim_var v_tgt dim size v)
  | Tuple l -> Tuple (List.map (dim_expr v_tgt dim size) l)
  | Not e -> Not (dim_expr v_tgt dim size e)
  | Log (op, x, y) ->
      Log (op, dim_expr v_tgt dim size x, dim_expr v_tgt dim size y)
  | Arith (op, x, y) ->
      Arith (op, dim_expr v_tgt dim size x, dim_expr v_tgt dim size y)
  | Shift (op, e, ae) -> Shift (op, dim_expr v_tgt dim size e, ae)
  | Shuffle (v, l) -> Shuffle (dim_var v_tgt dim size v, l)
  | Bitmask (e, ae) -> Bitmask (dim_expr v_tgt dim size e, ae)
  | Pack (e1, e2, t) ->
      Pack (dim_expr v_tgt dim size e1, dim_expr v_tgt dim size e2, t)
  | Fun (f, l) -> Fun (f, List.map (dim_expr v_tgt dim size) l)
  | Fun_v _ -> assert false

(* Updates |v_tgt| (for 'var_target') by merging its two innermost arrays *)
let rec dim_deq (v_tgt : var) (dim : int) (size : int) (deq : deq) : deq =
  {
    deq with
    content =
      (match deq.content with
      | Eqn (vs, e, sync) ->
          Eqn
            ( List.map (dim_var v_tgt dim size) vs,
              dim_expr v_tgt dim size e,
              sync )
      | Loop (i, ei, ef, dl, opts) ->
          Loop (i, ei, ef, List.map (dim_deq v_tgt dim size) dl, opts));
  }

(* Merges the two innermost dimensions of |t|. For instance:
      u1[2][3]    -> u1[6]
      u1[2][3][4] -> u1[2][12]
      b8[2]       -> b1[16] (b16 would also work)
      b8[2][3]    -> b1[2][24] (b24|2] would also work)
*)
let rec collapse_inner_arrays (t : typ) : typ * int =
  match t with
  (* End found: Array of Array of bool *)
  | Array (Array (Uint (d, m, 1), es2), es1) ->
      let es1 = eval_arith_ne es1 in
      let es2 = eval_arith_ne es2 in
      (Array (Uint (d, m, 1), Const_e (es2 * es1)), es2)
  (* End found: Array of bm *)
  | Array (Uint (d, m, n), es1) when n > 1 ->
      let es1 = eval_arith_ne es1 in
      (Array (Uint (d, m, 1), Const_e (es1 * n)), n)
  (* Not the end, going deeper *)
  | Array (t', es1) ->
      let t', size = collapse_inner_arrays t' in
      (Array (t', es1), size)
  (* Can't be a Uint or a Nat *)
  | _ -> assert false

(* |v| is an array with dimension > 1.
   unnest_var will collapse its last 2 dimensions.
   For instance, u1[2][3][4] would become u1[2][12].
*)
let unnest_var (def : def) (var : var) : def =
  let var_base = get_var_base var in
  match def.node with
  | Single (vars, body) ->
      (* |size|: the size of the arrays being collapsed. For instance,
             b1[3][5] -> size = 5
           (used to compute indices in the new array:
             x[a][b] becomes x[a*size+b]) *)
      let size = ref (-1) in
      (* |new_type|: the type of |var| after  this transformation *)
      let new_type = ref Nat in
      (* |old_type|: the type of |var| before this transformation *)
      let old_type = ref Nat in

      (* find_interest_var go through |p| to find the variable we want
         to update, updates it, and updates |size|, |new_type| and
         |old_type|. *)
      let find_interest_var (p : p) : p =
        List.map
          (fun v ->
            if Var v.vd_id = var_base then (
              let t', s = collapse_inner_arrays v.vd_typ in
              old_type := v.vd_typ;
              new_type := t';
              size := s;
              { v with vd_typ = t' })
            else v)
          p
      in
      let vars = find_interest_var vars in
      let p_in = find_interest_var def.p_in in
      let p_out = find_interest_var def.p_out in

      (* just in case; to make sure we found the variable we want to
         expand. *)
      assert (!size <> -1);

      (* Updating body with new variable *)
      let body =
        List.map (dim_deq var_base (get_nested_level !old_type) !size) body
      in
      (* Returning the updated node*)
      { def with p_in; p_out; node = Single (vars, body) }
  | _ -> assert false

(* Go through each function call, and, if needed, updates the
   variables (in p_in or p_out) of the callee. *)
module Dir_params = struct
  (* |ident|: the id of the updated node *)
  exception Updated

  let rec fix_deqs env_fun env_var (def : def) (deqs : deq list) : deq list =
    List.map
      (fun deq ->
        {
          deq with
          content =
            (match deq.content with
            | Eqn (ret_vars, Fun (f, args), _) when not (is_builtin f) ->
                (* A funcall -> need to:
                    - iterate over arguments to make sure they have the correct types
                    - iterate over return values to make sure they have the correct types
                   (only nested arrays need to be considered) *)
                (* Note that at this point, expand_parameters has ran, so we are
                   assured that a call has exactly has many args as the function expects *)

                (* Retrieving f's parameters, and checking arguments' types *)
                let p_in = (Hashtbl.find env_fun f).p_in in
                List.iteri
                  (fun i arg ->
                    match arg with
                    (* A parameter can be either a Const or an ExpVar
                                       (since we are in Usuba0) *)
                    | Const _ -> ()
                    | ExpVar v ->
                        (* type of the i-th argument *)
                        let arg_type = get_var_type env_var v in
                        (* type of the i-th expected parameter *)
                        let exp_type = (List.nth p_in i).vd_typ in

                        if
                          get_nested_level exp_type > get_nested_level arg_type
                          || not_same_dim exp_type arg_type
                        then (
                          (* Different sizes, need convert arg to a non-nested array *)
                          Hashtbl.replace env_fun f
                            (unnest_var (Hashtbl.find env_fun f)
                               (Var (List.nth p_in i).vd_id));
                          raise Updated
                          (* < isn't checked here: if dim is < than function
                             expects, then the function must be adapted
                             (we can always reduce dimension, but not expand) *))
                        else ()
                    (* Not a Const/ExpVar -> not possible *)
                    | _ -> assert false)
                  args;

                (* Retrieveing f's returns param, and checking return values' types *)
                let p_out = (Hashtbl.find env_fun f).p_out in
                List.iteri
                  (fun i v ->
                    (* type of the i-th lhs variable *)
                    let ret_type = get_var_type env_var v in
                    (* type of the i-th returned variable *)
                    let exp_type = (List.nth p_out i).vd_typ in

                    if
                      get_nested_level exp_type > get_nested_level ret_type
                      || not_same_dim exp_type ret_type
                    then (
                      (* Different sizes, need convert arg to a non-nested array *)
                      Hashtbl.replace env_fun f
                        (unnest_var (Hashtbl.find env_fun f)
                           (Var (List.nth p_out i).vd_id));
                      raise Updated)
                    else ())
                  ret_vars;
                deq.content
            (* A simple equation can't contain funcall -> ignore *)
            | Eqn (_, _, _) -> deq.content
            (* Reccursive call on loops *)
            | Loop (i, ei, ef, dl, opts) ->
                Hashtbl.add env_var i Nat;
                let res =
                  Loop (i, ei, ef, fix_deqs env_fun env_var def dl, opts)
                in
                Hashtbl.remove env_var i;
                res);
        })
      deqs

  let fix_def env_fun (def : def) : unit =
    match def.node with
    | Single (vars, body) ->
        let env_var = build_env_var def.p_in def.p_out vars in
        let body = fix_deqs env_fun env_var def body in
        Hashtbl.replace env_fun def.id { def with node = Single (vars, body) }
    | _ -> ()

  let rec run _ (prog : prog) (conf : config) : prog =
    (* Build a hash containing all nodes *)
    let env_fun = Hashtbl.create 100 in
    List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

    try
      (* Fix dimensions within each node *)
      List.iter
        (fun node -> fix_def env_fun (Hashtbl.find env_fun node.id))
        prog.nodes;
      (* Collect fixed nodes *)
      { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }
    with Updated ->
      (* Could have introduce unbalancing between parameters/arguments
         and new unwanted arrays/tuples -> need to re-run a bunch of
         normalization *)
      let runner = new pass_runner conf in
      let prog =
        {
          nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes;
        }
      in
      run runner
        (runner#run_modules
           [
             Expand_array.as_pass;
             Norm_tuples.as_pass;
             Expand_parameters.as_pass;
             Expand_array.as_pass;
             Norm_tuples.as_pass;
           ]
           prog)
        conf

  let as_pass = (run, "Fix_dim.Dir_params")
end

(* Go through each function call, and, if needed, updates the
   variables (from vars) of the caller. *)
module Dir_inner = struct
  exception Updated

  let rec fix_deqs env_fun env_var (def : def) (deqs : deq list) : deq list =
    List.map
      (fun deq ->
        {
          deq with
          content =
            (match deq.content with
            | Eqn (ret_vars, Fun (f, args), _) when not (is_builtin f) ->
                (* A funcall -> need to:
                    - iterate over arguments to make sure they have the correct types
                    - iterate over return values to make sure they have the correct types
                   (only nested arrays need to be considered) *)
                (* Note that at this point, expand_parameters has ran, so we are
                   assured that a call has exactly has many args as the function expects *)

                (* Retrieving f's parameters, and checking arguments' types *)
                let p_in = (Hashtbl.find env_fun f).p_in in
                List.iteri
                  (fun i arg ->
                    match arg with
                    (* A parameter can be either a Const or an ExpVar
                                       (since we are in Usuba0) *)
                    | Const _ -> ()
                    | ExpVar v ->
                        (* type of the i-th argument *)
                        let arg_type = get_var_type env_var v in
                        (* type of the i-th expected parameter *)
                        let exp_type = (List.nth p_in i).vd_typ in

                        if
                          get_nested_level arg_type > get_nested_level exp_type
                          || not_same_dim arg_type exp_type
                        then (
                          (* Different sizes, need convert arg to a non-nested array *)
                          Hashtbl.replace env_fun def.id (unnest_var def v);
                          raise Updated
                          (* < isn't checked here: if dim is < than function
                             expects, then the function must be adapted
                             (we can always reduce dimension, but not expand) *))
                        else ()
                    (* Not a Const/ExpVar -> not possible *)
                    | _ ->
                        Printf.printf "Error: %s\n"
                          (Usuba_print.expr_to_str arg);
                        assert false)
                  args;

                (* Retrieveing f's returns param, and checking return values' types *)
                let p_out = (Hashtbl.find env_fun f).p_out in
                List.iteri
                  (fun i v ->
                    (* type of the i-th lhs variable *)
                    let ret_type = get_var_type env_var v in
                    (* type of the i-th returned variable *)
                    let exp_type = (List.nth p_out i).vd_typ in
                    if
                      get_nested_level ret_type > get_nested_level exp_type
                      || not_same_dim ret_type exp_type
                    then (
                      (* Different sizes, need convert arg to a non-nested array *)
                      Hashtbl.replace env_fun def.id (unnest_var def v);
                      raise Updated)
                    else ())
                  ret_vars;
                deq.content
            (* A simple equation can't contain funcall -> ignore *)
            | Eqn (_, _, _) -> deq.content
            (* Reccursive call on loops *)
            | Loop (i, ei, ef, dl, opts) ->
                Hashtbl.add env_var i Nat;
                let res =
                  Loop (i, ei, ef, fix_deqs env_fun env_var def dl, opts)
                in
                Hashtbl.remove env_var i;
                res);
        })
      deqs

  let fix_def env_fun (def : def) : unit =
    match def.node with
    | Single (vars, body) ->
        let env_var = build_env_var def.p_in def.p_out vars in
        let body = fix_deqs env_fun env_var def body in
        Hashtbl.replace env_fun def.id { def with node = Single (vars, body) }
    | _ -> ()

  let rec run (runner : pass_runner) (prog : prog) (conf : config) : prog =
    (* Build a hash containing all nodes *)
    let env_fun = Hashtbl.create 100 in
    List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

    try
      (* Fix dimensions within each node *)
      List.iter
        (fun node -> fix_def env_fun (Hashtbl.find env_fun node.id))
        prog.nodes;
      (* Collect fixed nodes *)
      { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }
    with Updated ->
      (* Could have introduce unbalancing between parameters/arguments
         and new unwanted arrays/tuples -> need to re-run a bunch of
         normalization *)
      let prog =
        {
          nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes;
        }
      in
      run runner
        (runner#run_modules
           [
             Expand_array.as_pass;
             Norm_tuples.as_pass;
             Expand_parameters.as_pass;
             Expand_array.as_pass;
             Norm_tuples.as_pass;
           ]
           prog)
        conf

  let as_pass = (run, "Fix_dim.Dir_inner")
end
