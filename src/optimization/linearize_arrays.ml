(***************************************************************************** )
                              expand_array.ml

   Replace "arrays of arrays" by "arrays":
      for instance u8x16[10] becomes u8x16
      (if possible)

( *****************************************************************************)


open Usuba_AST
open Usuba_print
open Basic_utils
open Utils


exception Keep_it


(* Using this rather than eval_arith, to give a value to MASKING_ORDER
   if it appears. *)
let rec eval_loop_bound (env_it:(ident,int) Hashtbl.t) (ae:arith_expr) : int =
  match ae with
  | Const_e n -> n
  | Var_e id  -> if id.name = "MASKING_ORDER" then 2 else Hashtbl.find env_it id
  | Op_e(op,x,y) -> let x' = eval_loop_bound env_it x in
                    let y' = eval_loop_bound env_it y in
                    match op with
                    | Add -> x' + y'
                    | Mul -> x' * y'
                    | Sub -> x' - y'
                    | Div -> x' / y'
                    | Mod -> if x' >= 0 then x' mod y' else y' + (x' mod y')



(* Simplifies the array indices in the variable |v|.

   Used typically to simplify a variable like x[i] inside a loop: the
   value of i should be known, and x[i] should be simplifiable to
   something like x[cst]. *)
let rec simpl_var env_it (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v',ae) -> Index(simpl_var env_it v',Const_e(eval_arith env_it ae))
  | _ -> (* Ranges and Slices should have been removed at that point *)
     Printf.fprintf stderr "simpl_var: invalide variable %s.\n"
       (Usuba_print.var_to_str v);
     assert false

(* linearize the variables of |p| that are contained in |to_linearize|. *)
let update_vars to_linearize (vars:p) : p =
  let rec simpl_type (typ:typ) : typ =
    match typ with
    | Array(Uint(dir,m,n),_)   -> Uint(dir,m,n)
    | Array(Array(typ',s),_)   -> Array(typ',s)
    | Uint(dir,m,n) when n > 1 -> Uint(dir,m,1)
    | _ ->
       Printf.fprintf stderr "update_vars: unexcpected type: %s\n" (Usuba_print.typ_to_str typ);
       assert false in

  List.map (fun vd -> match Hashtbl.find_opt to_linearize vd.vid with
                      | Some _ -> { vd with vtyp = simpl_type vd.vtyp }
                      | None -> vd) vars

(* Update a variable: linearize it if is contained in |to_linearize|;
   leave it unchanged otherwise. *)
let rec replace_var to_linearize (v:var) : var =
  match v with
  | Var _ -> v
  | Index(Var id,_) ->
     begin match Hashtbl.find_opt to_linearize id with
     | Some _ -> Var id
     | None -> v end
  | Index(v',i) -> Index(replace_var to_linearize v',i)
  | _ -> assert false

(* Linearize variables inside an expression *)
let rec replace_expr to_linearize (e:expr) : expr =
  match e with
  | Const _        -> e
  | ExpVar v       -> ExpVar (replace_var to_linearize v)
  | Tuple l        -> Tuple (List.map (replace_expr to_linearize) l)
  | Not e          -> Not (replace_expr to_linearize e)
  | Shift(op,e,ae) -> Shift(op,replace_expr to_linearize e,ae)
  | Log(op,x,y)    -> Log(op,replace_expr to_linearize x,
                          replace_expr to_linearize y)
  | Arith(op,x,y)  -> Arith(op,replace_expr to_linearize x,
                            replace_expr to_linearize y)
  | Shuffle(v,pat) -> Shuffle(replace_var to_linearize v,pat)
  | Fun(f,l)       -> Fun(f,List.map (replace_expr to_linearize) l)
  | _ -> assert false

(* Linearize each equation/loop of |deqs|. *)
let rec linearize to_linearize (deqs:deq list) : deq list =
  List.map (function
      | Eqn(v,e,sync) -> Eqn(List.map (replace_var to_linearize) v,
                             replace_expr to_linearize e, sync)
      | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,linearize to_linearize dl,opts)) deqs

(* |v| must be an Index(...). This function will remove the innermost
   Index(...) (which is therefore an Index(Var _, ...)). *)
let rec remove_deepest_index (v:var) : var =
  match v with
  | Index(v', n) ->
     (match v' with
      | Index _ -> Index(remove_deepest_index v',n)
      | _ -> v')
  | _ -> Printf.fprintf stderr "remove_deepest_index: unexpected var %s.\n"
           (Usuba_print.var_to_str v);
         assert false


(* The function can_linearize_def that takes a def and a variable
   that's part of both its p_in and p_out, and makes sure that
   those two variable can the same. For instance, if f is:

     node f(a:b2) return (b:b2) let b[0,1] = a[1,0] tel

   Then a and b must be different (otherwise you'd be doing actually
   a[0,1] = a[1,0] without temporary variable, which is wrong.
   On the other and, if you have:

     node f(a:b2) return (b:b2) let b = a ^ (0,1) tel

   Then a and b can be the same variable. *)
(* TODO: this code is pretty much the same as can_linearize. Would be
   cleaner to merge the 2.  *)
let rec can_linearize_def (env_fun:(ident,def) Hashtbl.t)
                          (env_it:(ident,int) Hashtbl.t)
                          (def:def) (v_in:var_d) (v_out:var_d) : unit =
  match def.node with
  | Single(vars,body) ->
     let env_var = build_env_var def.p_in def.p_out vars in
     (* |defined| is a hash table that contains, for each index and
        such of |v_in|, it's current value: either |v_in|, or
        |v_out|. Accessing |v_in| while defined{v_in} == v_out means
        that |v_in| and |v_out| can't be merged. |defined| is updated
        whenever |v_out| is written to.
        Note that |v_in| and |v_out| are kept fully expanded in
        |defined|. *)
     let defined = Hashtbl.create 10 in
     (* Initialize |defined|: |v_in| points to |v_in|. *)
     List.iter (fun v -> Hashtbl.add defined v v)
               (expand_var env_var ~env_it:env_it (Var v_in.vid));
     can_linearize_def_body env_fun env_it env_var defined body v_in v_out
  | _ -> (* The only case we can get here is if there is a |Table|
            that wasn't expanded due to --keep-tables flag. Nothing to
            do in that case. *)
     ()

and can_linearize_def_body
      (env_fun:(ident,def) Hashtbl.t)
      (env_it:(ident,int) Hashtbl.t)
      (env_var:(ident,typ) Hashtbl.t)
      (defined:(var,var) Hashtbl.t)
      (deqs:deq list) (v_in:var_d) (v_out:var_d) : unit =
  List.iter (
      function
      | Eqn(lhs,e,_) ->
         (* First, if |e| is a funcall, the we must check that if
            |v_in| and |v_out| are respectively in the parameters and
            returns of the function called. If yes, then we need to
            make sure that merging them will not be an issue. *)
         (match e with
          | Fun(f,l) ->
             (try
                let def_called = Hashtbl.find env_fun f in
                let param_idx =
                  find_get_i (fun e -> match e with
                                       | ExpVar v -> get_base_name v = v_in.vid
                                       | _ -> false) l in
                let v_in' = List.nth def_called.p_in param_idx in
                let return_idx =
                  find_get_i (fun v -> get_base_name v = v_out.vid) lhs in
                let v_out' = List.nth def_called.p_out return_idx in
                can_linearize_def env_fun env_it def_called v_in' v_out'
              with Not_found ->
                (* Means that |id| is either not in p_in, or not in
                      p_out -> do nothing. *)
                ())
          | _ -> () (* Not a funcall -> ignoring *));

         (* Regarless of what |e| is, making sure the right hand-side
            (e) doesn't use overriten variables *)
         List.iter (
             fun v ->
             match get_base_name v = v_in.vid with
             | true -> (* This expression uses |v_in| -> need to make
                          sure that |v_in| is available. *)
                List.iter (fun v ->
                           if Hashtbl.find defined v <> v then
                             raise Keep_it)
                          (expand_var env_var ~env_it:env_it v)
             | false -> () (* Does not use |v_in| -> do nothing *)
           )
           (List.map (simpl_var env_it) (get_used_vars e));

         (* Updating |defined| variables *)
         List.iter (
             fun v ->
             match get_base_name v = v_out.vid with
             | true -> (* Writes to v_out -> need to update |defined| *)
                List.iter (fun v ->
                    let v' = replace_base v v_in.vid in
                    Hashtbl.replace defined v' v)
                  (expand_var env_var ~env_it:env_it v)
             | false -> () (* Does not write to |v_out| -> do nothing *)
           )
           (List.map (simpl_var env_it) lhs)

      | Loop(x,ei,ef,dl,_) ->
         (* A loop: gonna look at every iterations (it is easier that
            trying to do some symbolic reasoning with the loop
            variable) *)
         let ei = eval_arith env_it ei in
         let ef = eval_arith env_it ef in
         List.iter (fun i -> Hashtbl.add env_it x i;
                             can_linearize_def_body env_fun env_it env_var
                                                    defined dl v_in v_out;
                             Hashtbl.remove env_it x) (gen_list_bounds ei ef)

    ) deqs

(* can_linearize returns nothing if the array defined by |id| can be
   linearized and raises an exception (Keep_it) otherwise.  (not super
   "functional ocaml spirit", but it does the job...)

   The way this function work is the folowing: the hash |defined|
   contains as keys the variables that the linearization of |id| would
   produce. When a variable v of |id| is read, we make sure that the
   v-after-linearization in |defined| contains indeed v. When a
   variable v of |id| is written to, we update v-after-linearization
   in |defined| to contain v.
   (v-after-linearization == remove_deepest_index v)

   |env_it|: the environment containing loop variables
   |id|: the ident of the array we would like to linearize
   |env_var|: an environment used to expand the array we want to linearize
   |defined|: see paragraph above *)
let rec can_linearize
          (env_fun:(ident,def) Hashtbl.t)
          ?(env_it:(ident,int) Hashtbl.t=Hashtbl.create 10)
          ?(defined:(var,var) Hashtbl.t = Hashtbl.create 100)
          (deqs:deq list)
          (id:ident)
          (env_var:(ident,typ) Hashtbl.t) =

  List.iter (
      function
      | Eqn(lhs,e,_) ->
         (* First, if |e| is a funcall, the we must check that if |id|
            is in both the params and returns of the function
            called. If yes, then we need to make sure that linearizing
            |id| will not introduce any error there. *)
         (match e with
          | Fun(f,l) ->
             (try
                let def = Hashtbl.find env_fun f in
                let param_idx =
                  find_get_i (fun e -> match e with
                                       | ExpVar v -> get_base_name v = id
                                       | _ -> false) l in
                let v_in = List.nth def.p_in param_idx in
                let return_idx =
                  find_get_i (fun v -> get_base_name v = id) lhs in
                let v_out = List.nth def.p_out return_idx in
                can_linearize_def env_fun env_it def v_in v_out
              with Not_found ->
                    (* Means that |id| is either not in p_in, or not in
                      p_out -> do nothing. *)
                ())
          | _ -> () (* Not a funcall -> ignoring *));

         (* Regarless of what |e| is, making sure the right hand-side
            (e) doesn't use overriten variables *)
         List.iter (
             fun v ->
             match get_base_name v = id with
             | true -> (* Need to make sure the index accessed are accessible *)
                List.iter (fun v ->
                           let v' = remove_deepest_index v in
                             if Hashtbl.find defined v' <> v then
                               raise Keep_it
                  )
                  (expand_var env_var ~env_it:env_it v)
             | false -> () (* not the variable we are interested into -> do nothing *)
           )
           (List.map (simpl_var env_it) (get_used_vars e));

         (* Updating |defined| variables *)
         List.iter (
             fun v ->
             match get_base_name v = id with
             | true -> (* Need to update |defined| *)
                List.iter (fun v ->
                    let v' = remove_deepest_index v in
                    Hashtbl.replace defined v' v)
                  (expand_var env_var ~env_it:env_it v)
             | false -> () (* not the variable we are interested into -> do nothing *)
           )
           (List.map (simpl_var env_it) lhs)

      | Loop(x,ei,ef,dl,_) ->
         (* A loop: gonna look at every iterations (it is easier that
            trying to do some symbolic reasoning with the loop
            variable) *)
         let ei = eval_arith env_it ei in
         let ef = eval_arith env_it ef in
         List.iter (fun i -> Hashtbl.add env_it x i;
                             can_linearize env_fun ~env_it:env_it
                               ~defined:defined dl id env_var;
                             Hashtbl.remove env_it x) (gen_list_bounds ei ef)

    ) deqs

(* Returns variables that are arrays *)
let get_arrays (vars:p) : p =
    List.filter (fun vd ->
      match vd.vtyp with
      | Array _ -> true
      | Uint(_,_,n) when n > 1 -> true
      | _ -> false) vars

(* To determine if an array can be linearized, we kinda simulate what
   would happen after linearization, thanks to the function
   "can_linearize". Refer to its comments to see how this is done. *)
let linearize_def (conf:config) (env_fun:(ident,def) Hashtbl.t) (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     (* Building variable environment. It is only use to expand
        variables we wish to expand (p_in and p_out can therefore be
        omitted. *)
     let env_var = build_env_var [] [] vars in
     let env_it  = Hashtbl.create 10 in
     if conf.ua_masked then Hashtbl.add env_it Mask.masking_order 2;
     (* |to_linearize|: the set of variables to linearize *)
     let to_linearize = Hashtbl.create 100 in
     List.iter (fun vd ->
         try can_linearize env_fun ~env_it:env_it body vd.vid env_var;
             (* Succeeded -> array can be linearized *)
             Hashtbl.replace to_linearize vd.vid true
         with
           (* Failed -> do not linearize this array *)
           Keep_it -> ())
       (get_arrays vars);
     (* Update variables with linearized ones *)
     let vars = update_vars to_linearize vars in
     (* Update body with linearized variables *)
     let body = linearize to_linearize body in
     let def = { def with node = Single(vars,body) } in
     Hashtbl.replace env_fun def.id def;
     def
  | _ -> def

let linearize_arrays (prog:prog) (conf:config) : prog =
  let env_fun = build_env_fun prog.nodes in
  if conf.linearize_arr then
    { nodes = List.map (linearize_def conf env_fun) prog.nodes }
  else prog
