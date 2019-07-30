(***************************************************************************** )
 *                             expand_array.ml                                 
 *
 *  Replace "arrays of arrays" by "arrays": 
 *     for instance u8x16[10] becomes u8x16
 *     (if possible)
 *
( *****************************************************************************)


open Usuba_AST
open Usuba_print
open Basic_utils
open Utils




exception Keep_it

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
          ?(env_it=Hashtbl.create 10)
          ?(defined:(var,var) Hashtbl.t = Hashtbl.create 100)
          (deqs:deq list)
          (id:ident)
          (env_var:(ident,typ) Hashtbl.t) =
  List.iter (
      function
      | Eqn(lhs,e,_) ->
      (* Making sure the right hand-side (e) doesn't use overriten variables *)
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
            varialbe *)
         let ei = eval_arith env_it ei in
         let ef = eval_arith env_it ef in
         List.iter (fun i -> Hashtbl.add env_it x i;
                             can_linearize ~env_it:env_it ~defined:defined dl id env_var;
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
let linearize_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     (* Building variable environment. It is only use to expand
        variables we wish to expand (p_in and p_out can therefore be
        omitted. *)
     let env_var = build_env_var [] [] vars in
     (* |to_linearize|: the set of variables to linearize *)
     let to_linearize = Hashtbl.create 100 in
     List.iter (fun vd ->
         try can_linearize body vd.vid env_var;
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
     { def with node = Single(vars,body) }
  | _ -> def

let linearize_arrays (prog:prog) (conf:config) : prog =
  { nodes = List.map linearize_def prog.nodes }
