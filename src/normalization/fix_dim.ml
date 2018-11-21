(***************************************************************************** )
                             fix_dim.ml                              

( *****************************************************************************)

open Usuba_AST
open Basic_utils
open Utils
open Printf


module Dir_params = struct

  let rec dim_var (vd:var_d) (s:arith_expr) (v:var) : var =
    let vb = get_var_base v in
    if vb = Var vd.vid then
      match v with
      | Index(Index(v',i1),i2) -> Index(v',simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,s),i2)))
      | Index(v',i1) -> Range(v',simpl_arith_ne (Op_e(Mul,i1,s)),simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,s),Op_e(Sub,s,Const_e 1))))
      | _ -> v
    else v

  let rec dim_expr (vd:var_d) (s:arith_expr) (e:expr) : expr =
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

  let rec dim_deq (vd:var_d) (s:arith_expr) (deq:deq) : deq =
    match deq with
    | Eqn(vs,e,sync) -> Eqn(List.map (dim_var vd s) vs, dim_expr vd s e,sync)
    | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,List.map (dim_deq vd s) dl,opts)
                                   
  let dim_size (def:def) (vd:var_d) (s:arith_expr) : def =
    let p_in' =
      List.map (fun v ->
                if v = vd then
                  match v.vtyp with
                  | Array(Array(et',es2),es1) ->
                     { v with vtyp = Array(et',simpl_arith_ne (Op_e(Mul,es1,es2))) }
                  | Array(Int(n,m),es1) ->
                     { v with vtyp = Array(Int(n,1),simpl_arith_ne (Op_e(Mul,es1,Const_e m))) }
                  | _ -> assert false
                else v) def.p_in in
    let p_out' =
      List.map (fun v ->
                if v = vd then
                  match v.vtyp with
                  | Array(Array(et',es2),es1) ->
                     { v with vtyp = Array(et',simpl_arith_ne (Op_e(Mul,es1,es2))) }
                  | Array(Int(n,m),es1) ->
                     { v with vtyp = Array(Int(n,1),simpl_arith_ne (Op_e(Mul,es1,Const_e m))) }
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
              | Eqn(vs,Fun(f,l),sync) when f.name <> "rand" ->
                 List.iteri (fun i e ->
                             let etyp = get_expr_type env_fun env_var e in
                             let fn   = Hashtbl.find env_fun f          in
                             let vd   = List.nth fn.p_in i              in
                             let vtyp = vd.vtyp                         in
                             match vtyp with
                             | Array(Array(_,es1),_) ->
                                (match etyp with
                                 | [ Array _ ] | [ Int _ ]->
                                                  let fn' = dim_size fn vd es1 in
                                                  Hashtbl.replace env_fun f fn'                                
                                 | _ -> ())
                             | Array(Int(_,m),_) when m > 1 ->
                                (match etyp with
                                 | [ Array _ ] | [ Int _ ]->
                                                  let fn' = dim_size fn vd (Const_e m) in
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
                                 | Array _ | Int _ ->
                                              let fn' = dim_size fn vd es1 in
                                              Hashtbl.replace env_fun f fn'                              
                                 | _ -> ())
                             | Array(Int(_,m),_) when m > 1 ->
                                (match etyp with
                                 | Array _ | Int _ ->
                                              let fn' = dim_size fn vd (Const_e m) in
                                              Hashtbl.replace env_fun f fn'                               
                                 | _ -> ())                              
                             | _ -> ()
                            ) vs;
                 deq
              | Eqn(vs,e,sync)        -> deq (* Eqn(expand_vars vs, expand_expr e, sync) *)
              | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,fix_deqs env_fun env_var dl,opts)) deqs

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


module Dir_inner = struct

  exception Updated

  let rec dim_var (vd:var) (s:arith_expr) (v:var) : var =
    let vb = get_var_base v in
    if vb = vd then
      match v with
      | Index(Index(v',i1),i2) -> Index(v',simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,s),i2)))
      | Index(v',i1) -> Range(v',simpl_arith_ne (Op_e(Mul,i1,s)),simpl_arith_ne (Op_e(Add,Op_e(Mul,i1,s),Op_e(Sub,s,Const_e 1))))
      | _ -> v
    else v

  let rec dim_expr (vd:var) (s:arith_expr) (e:expr) : expr =
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

  let rec dim_deq (vd:var) (s:arith_expr) (deq:deq) : deq =
    match deq with
    | Eqn(vs,e,sync) -> Eqn(List.map (dim_var vd s) vs, dim_expr vd s e,sync)
    | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,List.map (dim_deq vd s) dl,opts)
                                   
  let dim_size (def:def) (vd:var) (s:arith_expr) : def =
    let vd = get_var_base vd in
    match def.node with
    | Single(vars,body) ->
       let vars =
         List.map (
             fun v ->
             if (Var v.vid) = vd then
               match v.vtyp with
               | Array(Array(et',es2),es1) ->
                  { v with vtyp = Array(et',simpl_arith_ne (Op_e(Mul,es1,es2))) }
               | Array(Int(n,m),es1) ->
                  { v with vtyp = Array(Int(n,1),simpl_arith_ne (Op_e(Mul,es1,Const_e m))) }
               | _ -> assert false
             else v) vars in
       { def with node = Single(vars,List.map (dim_deq vd s) body) }
    | _ -> def
      
  let rec fix_deqs env_fun env_var (def:def) (deqs:deq list) : deq list =
    List.map (fun deq ->
              match deq with
              | Eqn(vs,Fun(f,l),sync) when f.name <> "rand" ->
                 List.iteri (fun i e ->
                             match e with
                             | Const _ -> ()
                             | ExpVar v ->
                                let etyp = get_var_type env_var v  in
                                let fn   =  Hashtbl.find env_fun f in
                                let vd   = List.nth fn.p_in i      in
                                let vtyp = vd.vtyp                 in
                                (match etyp with
                                 | Array(Array(_,es1),_) ->
                                    (match vtyp with
                                     | Array _
                                     | Int _ ->
                                        let deq' = dim_size def v es1 in
                                        Hashtbl.replace env_fun def.id deq';
                                        raise Updated
                                     | _ -> ())
                                 | Array(Int(_,m),_) when m > 1 ->
                                    (match vtyp with
                                     | Array _
                                     | Int _->
                                        let deq' = dim_size def v (Const_e m) in
                                        Hashtbl.replace env_fun def.id deq';
                                        raise Updated
                                     | _ -> ())
                                 | _ -> ())
                             | _ -> assert false
                            ) l;
                 List.iteri (fun i v ->
                             let etyp  =  get_var_type env_var v  in
                             let fn    =  Hashtbl.find env_fun f  in
                             let vd    =  List.nth fn.p_out i     in
                             let vtyp  =  vd.vtyp                 in
                             match etyp with
                             | Array(Array(_,es1),_) ->
                                (match vtyp with
                                 | Array _
                                 | Int _ ->
                                    let deq' = dim_size def v es1 in
                                    Hashtbl.replace env_fun def.id deq';
                                    raise Updated
                                 | _ -> ())
                             | Array(Int(_,m),_) when m > 1 ->
                                (match vtyp with
                                 | Array _
                                 | Int _ ->
                                    let deq' = dim_size def v (Const_e m) in
                                    Hashtbl.replace env_fun def.id deq';
                                    raise Updated
                                 | _ -> ())                              
                             | _ -> ()
                            ) vs;
                 deq
              | Eqn(vs,e,sync)        -> deq (* Eqn(expand_vars vs, expand_expr e, sync) *)
              | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,fix_deqs env_fun env_var def dl,opts)) deqs

  let rec fix_def env_fun (def:def) : unit =
    try
      match def.node with
      | Single(vars,body) ->
         let env_var     =  build_env_var def.p_in def.p_out vars  in
         let body        =  fix_deqs env_fun env_var def body      in
         Hashtbl.replace env_fun def.id
                         { def with node = Single(vars, body) }
      | _ -> ()
    with Updated -> fix_def env_fun (Hashtbl.find env_fun def.id)
             
             
  let fix_dim (prog:prog) (conf:config) : prog =
  let env_fun = Hashtbl.create 100 in
  List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

  List.iter (fun node -> fix_def env_fun (Hashtbl.find env_fun node.id)) prog.nodes;
    
  { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }
  
  
end
                    
