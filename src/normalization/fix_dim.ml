(***************************************************************************** )
                             fix_dim.ml                              

  Usuba thinks that arrays like u8x16 and u1x128 are the same thing, but they 
  really aren't. This module fixes that.

( *****************************************************************************)

open Usuba_AST
open Basic_utils
open Utils
open Printf


module Dir_params = struct

  let rec dim_var (vd:var_d) (s:int) (v:var) : var =
    let vb = get_var_base v in
    if vb = Var vd.vid then
      match v with
      | Index(Index(v',i1),i2) -> Index(v',simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,Const_e s),i2)))
      | Index(v',i1) ->
         (try
             Slice(v',List.map (fun n -> Op_e(Add,Op_e(Mul,i1,Const_e s),Const_e n)) (gen_list_bounds 0 (s-1)))
           with Not_found ->
             Range(v',simpl_arith_ne (Op_e(Mul,i1,Const_e s)),simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,Const_e s),Const_e (s-1)))))
      | _ -> v
    else v

  let rec dim_expr (vd:var_d) (s:int) (e:expr) : expr =
    match e with
    | Const _        -> e
    | ExpVar v       -> ExpVar(dim_var vd s v)
    | Tuple l        -> Tuple(List.map (dim_expr vd s) l)
    | Not e          -> Not(dim_expr vd s e)
    | Shift(op,e,ae) -> Shift(op,dim_expr vd s e,ae)
    | Log(op,x,y)    -> Log(op,dim_expr vd s x,dim_expr vd s y)
    | Shuffle(v,l)   -> Shuffle(dim_var vd s v,l)
    | Arith(op,x,y)  -> Arith(op,dim_expr vd s x,dim_expr vd s y)
    | Fun(f,l)       -> Fun(f,List.map (dim_expr vd s) l)
    | _              -> assert false

  let rec dim_deq (vd:var_d) (s:int) (deq:deq) : deq =
    match deq with
    | Eqn(vs,e,sync) -> Eqn(List.map (dim_var vd s) vs, dim_expr vd s e,sync)
    | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,List.map (dim_deq vd s) dl,opts)
                                   
  let dim_size (def:def) (vd:var_d) (s:int) : def =
    let p_in' =
      List.map (fun v ->
                if v = vd then
                  match v.vtyp with
                  | Array(Array(et',es2),es1) ->
                     { v with vtyp = Array(et',es1 * es2) }
                  | Array(Uint(dir,m,n),es1) ->
                     { v with vtyp = Array(Uint(dir,m,1),es1 * n) }
                  | _ -> assert false
                else v) def.p_in in
    let p_out' =
      List.map (fun v ->
                if v = vd then
                  match v.vtyp with
                  | Array(Array(et',es2),es1) ->
                     { v with vtyp = Array(et',es1 * es2) }
                  | Array(Uint(dir,m,n),es1) ->
                     { v with vtyp = Array(Uint(dir,m,1),es1 * n) }
                  | _ -> assert false
                else v) def.p_out in
    { def with p_in  = p_in';
               p_out = p_out';
               node = match def.node with
                      | Single(vars,body) -> Single(vars,List.map (dim_deq vd s) body)
                      | _ -> def.node }
      
  let rec fix_deqs env_fun env_var (deqs:deq list) : deq list =
    List.map (fun deq ->
              match deq with
              | Eqn(vs,Fun(f,l),_) when f.name <> "rand" ->
                 List.iteri (fun i e ->
                             let etyp = get_expr_type env_fun env_var e in
                             let fn   = Hashtbl.find env_fun f          in
                             let vd   = List.nth fn.p_in i              in
                             let vtyp = vd.vtyp                         in
                             match vtyp with
                             | Array(Array(_,es1),_) ->
                                (match etyp with
                                 | [ Array _ ] | [ Uint _ ]->
                                                  let fn' = dim_size fn vd es1 in
                                                  Hashtbl.replace env_fun f fn'
                                 | _ -> ())
                             | Array(Uint(_,_,n),_) when n > 1 ->
                                (match etyp with
                                 | [ Array _ ] | [ Uint _ ] ->
                                                  let fn' = dim_size fn vd n in
                                                  Hashtbl.replace env_fun f fn'
                                 | _ -> ())                              
                             | _ -> ()
                            ) l;
                 List.iteri (fun i v ->
                             let etyp  =  get_var_type env_var v  in
                             let fn    =  Hashtbl.find env_fun f  in
                             let vd    =  List.nth fn.p_out i     in
                             let vtyp  =  vd.vtyp                 in
                             match vtyp with
                             | Array(Array(_,es1),_) ->
                                (match etyp with
                                 | Array _ | Uint _ ->
                                              let fn' = dim_size fn vd es1 in
                                              Hashtbl.replace env_fun f fn'
                                 | _ -> ())
                             | Array(Uint(_,_,n),_) when n > 1 ->
                                (match etyp with
                                 | Array _ | Uint _ ->
                                              let fn' = dim_size fn vd n in
                                              Hashtbl.replace env_fun f fn'
                                 | _ -> ())                              
                             | _ -> ()
                            ) vs;
                 deq
              | Eqn _ -> deq (* Not a funcall, ignoring *)
              | Loop(i,ei,ef,dl,opts) ->
                 Hashtbl.add env_var i Nat;
                 let res = Loop(i,ei,ef,fix_deqs env_fun env_var dl,opts) in
                 Hashtbl.remove env_var i;
                 res) deqs

  let fix_def env_fun (def:def) : unit =
    match def.node with
    | Single(vars,body) ->
       let env_var     =  build_env_var def.p_in def.p_out vars  in
       let body        =  fix_deqs env_fun env_var body          in
       Hashtbl.replace env_fun def.id
                       { def with node = Single(vars, body) }
    | _ -> ()
             
             
  let fix_dim (prog:prog) (conf:config) : prog =
    let env_fun = Hashtbl.create 100 in
    List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

    List.iter (fun node -> fix_def env_fun (Hashtbl.find env_fun node.id)) prog.nodes;
    
    { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }

end

(* *)
module Dir_inner = struct

  exception Updated

  let rec dim_var (vd:var) (s:int) (v:var) : var =
    let vb = get_var_base v in
    if vb = vd then
      match v with
      | Index(Index(v',i1),i2) -> Index(v',simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,Const_e s),i2)))
      | Index(v',i1) -> 
         Range(v',simpl_arith_ne (Op_e(Mul,i1,Const_e s)),simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,Const_e s),Const_e (s-1))))
      | _ -> v
    else v

  let rec dim_expr (vd:var) (s:int) (e:expr) : expr =
    match e with
    | Const _        -> e
    | ExpVar v       -> ExpVar(dim_var vd s v)
    | Tuple l        -> Tuple(List.map (dim_expr vd s) l)
    | Not e          -> Not(dim_expr vd s e)
    | Shift(op,e,ae) -> Shift(op,dim_expr vd s e,ae)
    | Log(op,x,y)    -> Log(op,dim_expr vd s x,dim_expr vd s y)
    | Shuffle(v,l)   -> Shuffle(dim_var vd s v,l)
    | Arith(op,x,y)  -> Arith(op,dim_expr vd s x,dim_expr vd s y)
    | Fun(f,l)       -> Fun(f,List.map (dim_expr vd s) l)
    | _              -> assert false

  let rec dim_deq (vd:var) (s:int) (deq:deq) : deq =
    match deq with
    | Eqn(vs,e,sync) -> Eqn(List.map (dim_var vd s) vs, dim_expr vd s e,sync)
    | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,List.map (dim_deq vd s) dl,opts)
                                   
  (* let dim_size (def:def) (vd:var) (s:int) : def = *)
  (*   let vd = get_var_base vd in *)
  (*   match def.node with *)
  (*   | Single(vars,body) -> *)
  (*      let vars = *)
  (*        List.map ( *)
  (*            fun v -> *)
  (*            if (Var v.vid) = vd then *)
  (*              match v.vtyp with *)
  (*              | Array(Array(et',es2),es1) -> *)
  (*                 { v with vtyp = Array(et',es1 * es2) } *)
  (*              | Array(Uint(dir,m,n),es1) -> *)
  (*                 { v with vtyp = Array(Uint(dir,m,1),es1 * n) } *)
  (*              | _ -> assert false *)
  (*            else v) vars in *)
  (*      { def with node = Single(vars,List.map (dim_deq vd s) body) } *)
  (*   | _ -> def *)

  let rec collapse_inner_arrays (t:typ) : typ * int =
    match t with
    (* End found: Array of Array of bool *)
    | Array( Array( Uint(d,m,1), es2 ), es1 ) ->
       Array( Uint(d,m,1), es2 * es1 ), es1
    (* End found: Array of bm *)
    | Array( Uint(d,m,n), es1 ) ->
       Array( Uint(d,m,1), es1 * n ), es1
    (* Not the end, going deeper *)
    | Array(t',es1) ->
       let (t',size) = collapse_inner_arrays t' in
       Array(t',es1), size
    (* Can't be a Uint or a Nat *)
    | _ -> assert false

  let rec unnest_var (def:def) (var:var) : def =
    Printf.printf "Unnest_var %s\n" (Usuba_print.var_to_str var);
    let var_base = get_var_base var in
    match def.node with
    | Single(vars,body) ->
       (* size: the size of the arrays being collapsed. For instance,
            b1[3][5] -> size = 5 *)
       let size = ref (-1) in
       (* new_type: the type of 'var' after this transformation *)
       let new_type = ref Nat in

       (* Updating 'var' type in 'vars' *)
       let vars = List.map (fun v ->
                            if (Var v.vid) = var_base then
                              (Printf.printf "Found it: %s\n" (Usuba_print.vd_to_str v);
                               let (t',s) = collapse_inner_arrays v.vtyp in
                               new_type := t';
                               size     := s;
                               { v with vtyp = t' })
                               (* match v.vtyp with *)
                               (* | Array(Array(t, es2), es1) -> *)
                               (*    new_type := Array(t, es1 * es2); *)
                               (*    size     := es1; *)
                               (*    { v with vtyp = !new_type } *)
                               (* | Array(Uint(dir,m,n), es1) -> *)
                               (*    new_type := Array(Uint(dir,m,1), es1 * n); *)
                               (*    size     := es1; *)
                               (*    { v with vtyp = !new_type } *)
                               (* (\* 'v' isn't an array -> Not possible *\) *)
                               (* | _ -> assert false) *)
                            else v) vars in
       { def with node = Single(vars, List.map (dim_deq var_base !size) body) }
    | _ -> assert false
    (*    (\* Updating body by expanding 'var' within *\) *)
    (*    let def = { def with node = Single(vars, List.map (dim_deq var_base !size) body) } in *)
    (*    (\* Checking if need to unnest further *\) *)
    (*    (match !new_type with *)
    (*     | Uint(_,_,1) -> def *)
    (*     (\* If not a u1, then need to unnest further *\) *)
    (*     | Array _ | Uint _ -> unnest_var def var *)
    (*     (\* Can't be a Nat -> we wouldn't be expanding it *\) *)
    (*     | Nat -> assert false) *)
    (* (\* Not a 'Single'. Shouldn't happend. *\) *)
    (* | _ -> assert false *)
       
    

  (* Returns the "nested" level of a type: it corresponds to how many nested arrays there
     are in the type. For instance:
      get_nested_level( Array(Array(Uint(_,_,1))) ) == 2
      get_nested_level( Uint(_,_,5) ) == 1
      get_nested_level( Uint(_,_,1) ) == 0
   *)
  let rec get_nested_level (t:typ) : int =
    match t with
    | Nat         -> 0
    | Uint(_,_,1) -> 0
    | Uint(_,_,n) -> 1
    | Array(t',_) -> 1 + (get_nested_level t')

             
  (* *)
  let rec fix_deqs env_fun env_var (def:def) (deqs:deq list) : deq list =
    List.map
      (fun deq ->
       match deq with
       | Eqn(ret_vars,Fun(f,args),sync) when f.name <> "rand" ->
          (* Printf.printf "Considering: %s\n" (Usuba_print.deq_to_str deq); *)
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
                                (since we are in Usuba0)                        *)
             | Const _ -> ()
             | ExpVar v ->
                (* type of the i-th argument *)
                let arg_type  = get_var_type env_var v  in
                (* type of the i-th expected parameter *)
                let exp_type  = (List.nth p_in i).vtyp  in

                (* Printf.printf "fixing %s: %s-%s\n" def.id.name *)
                (*               (Usuba_print.typ_to_str arg_type) *)
                (*               (Usuba_print.typ_to_str exp_type); *)
                
                if (get_nested_level arg_type) > (get_nested_level exp_type) then (
                  (* Different sizes, need convert arg to a non-nested array *)
                  Hashtbl.replace env_fun def.id (unnest_var def v);
                  raise Updated
                                  
                  (* match arg_type with *)
                  (* | Array(Array(_,es1),_) -> *)
                  (*    (match exp_type with *)
                  (*     | Array _ *)
                  (*     | Uint _ -> *)
                  (*        let deq' = dim_size def v es1 in *)
                  (*        Hashtbl.replace env_fun def.id deq'; *)
                  (*        raise Updated *)
                  (*     | _ -> ()) *)
                  (* | Array(Uint(_,_,n),_) when n > 1 -> *)
                  (*    (match vtyp with *)
                  (*     | Array _ *)
                  (*     | Uint _-> *)
                  (*        let deq' = dim_size def v n in *)
                  (*        Hashtbl.replace env_fun def.id deq'; *)
                  (*        raise Updated *)
                  (*     | _ -> ()) *)
                  (* (\* arg type isn't an array -> nothing to do *\) *)
                  (* | _ -> () *)
                ) else ()
             (* Not a Const/ExpVar -> not possible *)
             | _ -> assert false
            ) args;

          (* Retrieveing f's returns param, and checking return values' types *)
          let p_out = (Hashtbl.find env_fun f).p_out in
          List.iteri (fun i v ->
                      let ret_type = get_var_type env_var v  in
                      let exp_type = (List.nth p_out i).vtyp in
                      if (get_nested_level ret_type) > (get_nested_level exp_type) then (
                        (* Different sizes, need convert arg to a non-nested array *)
                        Hashtbl.replace env_fun def.id (unnest_var def v);
                        raise Updated
                      ) else ()
                      (* match arg_type with *)
                      (*        | Array(Array(_,es1),_) -> *)
                      (*           (match vtyp with *)
                      (*            | Array _ *)
                      (*            | Uint _ -> *)
                      (*               let deq' = dim_size def v es1 in *)
                      (*               Hashtbl.replace env_fun def.id deq'; *)
                      (*               raise Updated *)
                      (*            | _ -> ()) *)
                      (*        | Array(Uint(_,_,n),_) when n > 1 -> *)
                      (*           (match vtyp with *)
                      (*            | Array _ *)
                      (*            | Uint _ -> *)
                      (*               let deq' = dim_size def v n in *)
                      (*               Hashtbl.replace env_fun def.id deq'; *)
                      (*               raise Updated *)
                      (*            | _ -> ())                               *)
                      (*        | _ -> () *)
                            ) ret_vars;
                 deq
              (* A simple equation can't contain funcall -> ignore *)
              | Eqn(vs,e,sync)        -> deq
              (* Reccursive call on loops *)
              | Loop(i,ei,ef,dl,opts) ->
                 Hashtbl.add env_var i Nat;
                 let res = Loop(i,ei,ef,fix_deqs env_fun env_var def dl,opts) in
                 Hashtbl.remove env_var i;
                 res) deqs

  let rec fix_def env_fun (def:def) : unit =
    try
      match def.node with
      | Single(vars,body) ->
         let env_var     =  build_env_var def.p_in def.p_out vars  in
         let body        =  fix_deqs env_fun env_var def body      in
         Hashtbl.replace env_fun def.id
                         { def with node = Single(vars, body) }
      | _ -> ()
    with Updated ->
      fix_def env_fun
              (Norm_tuples.norm_tuples_deq
                 (Expand_array.expand_def false 0 false true (Hashtbl.find env_fun def.id)))
              (*  0     = keep arrays
                  false = keep loops
                  true  = keep arrays in parameters
                  So basically, this combination of (0,false,true) means
                  "just expand ranges", and anything only if _needed_. *)
    
                            
             
  let fix_dim (prog:prog) (conf:config) : prog =

    (* Build a hash containing all nodes *)
    let env_fun = Hashtbl.create 100 in
    List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

    (* Fix dimensions within each node *)
    List.iter (fun node -> fix_def env_fun (Hashtbl.find env_fun node.id)) prog.nodes;

    (* Collect fixed nodes *)
    { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }
  
  
end
                    
