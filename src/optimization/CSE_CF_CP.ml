open Usuba_AST
open Basic_utils
open Utils

(* TODO: improve how Loop are dealt with *)

(* Abstracting Hashtbl.
   This functions should replace the ones in Utils, one day. *)
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error ("Not found: " ^ v.name))
let env_fetch_opt env v = Hashtbl.find_opt env v


let rec fold_expr (e:expr) : expr =
  match e with
  | Log(op,x,y) ->
     let x' = fold_expr x in
     let y' = fold_expr y in
     ( match x',y' with
       | Const _, _ | _, Const _ -> (
         match Log(op,x',y') with
         | Log(And,Const 1,x) | Log(And,x,Const 1) -> x
         | Log(And,Const 0,_) | Log(And,_,Const 0) -> Const 0
              
         | Log(Or,Const 1,_)  | Log(Or,_,Const 1)  -> Const 1
         | Log(Or,Const 0,x)  | Log(Or,x,Const 0)  -> x
                                  
         | Log(Xor,Const 0,x) | Log(Xor,x,Const 0) -> x    
         | Log(Xor,Const 1,x) | Log(Xor,x,Const 1) -> Not x
                                     
         | Log(Andn,Const 0,x) -> x
         | Log(Andn,x,Const 0) -> Const 0
         | Log(Andn,Const 1,x) -> Const 0
         | Log(Andn,x,Const 1) -> Not x
                                      
         | _ -> Log(op,x',y') )
       | _, _ -> Log(op,x',y') )
  | Fun(f,l) -> Fun(f,List.map (fold_expr) l)
  | Tuple l -> Tuple(List.map (fold_expr) l)
  | Shift(op,e,ae) -> Shift(op,fold_expr e,ae)
  | Arith(op,x,y)  -> Arith(op,fold_expr x, fold_expr y)
  | Not x -> let x' = fold_expr x in
             ( match x with
               | Const 1 -> Const 0
               | Const 0 -> Const 1
               | _ -> Not x')
  | _ -> e

let rec fold_deq (deq:deq) : deq =
  match deq with
  | Eqn(v,e,sync)      -> Eqn(v,fold_expr e,sync)
  | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,List.map fold_deq dl,opts)
           
let rec cse_expr env_expr ?(invert=true) (e:expr) : expr =
  let e = fold_expr e in
  let e = 
    fold_expr 
      (match e with
       | Log(op,x,y)    -> Log(op,   cse_expr env_expr x, cse_expr env_expr y)
       | Arith(op,x,y)  -> Arith(op, cse_expr env_expr x, cse_expr env_expr y)
       | Not e          -> Not(cse_expr env_expr e)
       | Fun(f,l)       -> Fun(f, List.map (cse_expr env_expr) l)
       | Tuple l        -> Tuple(List.map (cse_expr env_expr) l)
       | Shift(op,e,ae) -> Shift(op, cse_expr env_expr e, ae)
       | Shuffle(v,l)   -> (match env_fetch_opt env_expr (ExpVar v) with
                            | Some (ExpVar v') -> Shuffle(v',l)
                            | _ -> e)
       | _ -> e) in
  match env_fetch_opt env_expr e with
  | Some x -> x
  | None -> if invert then
              (* Inverting parameters in associative operations *)
              match e with
              | Log(op,x,y)    -> let e' = cse_expr env_expr ~invert:false (Log(op,y,x)) in
                                  if e' = Log(op,y,x) then Log(op,x,y) else e'
              | Arith(Mul,x,y) -> let e' = cse_expr env_expr ~invert:false (Arith(Mul,y,x)) in
                                  if e' = Arith(Mul,y,x) then Arith(Mul,x,y) else e'
              | Arith(Add,x,y) -> let e' = cse_expr env_expr ~invert:false (Arith(Add,y,x)) in
                                  if e' = Arith(Add,y,x) then Arith(Add,x,y) else e'
              | _ -> e
            else e

(* Should only be called for function parameters -> ExpVars or Consts *)
let rec expand_vars env_var opt_out_vars (e:expr) : expr list =
  match e with
  | ExpVar v -> ( match env_fetch_opt opt_out_vars v with
                  | Some _ -> List.map (fun x -> ExpVar x) (expand_var_partial env_var v)
                  | None -> [ e ] )
  | Const _ -> [ e ]
  | _ -> assert false
                   
let opt_expr env_expr env_var opt_out_vars (e:expr) : expr =
  match e with
  | Fun(f,[]) when f.name = "rand" -> Fun(f,[])
  | Fun(f,l) -> cse_expr env_expr
                         (Fun (f,flat_map (expand_vars env_var opt_out_vars) l))
  | _ -> cse_expr env_expr e

let rec update_opt_out opt_out_vars (v:var) : unit =
  env_update opt_out_vars v true;
  match v with
  | Index(v,_) -> update_opt_out opt_out_vars v
  | _ -> ()
           
let opt_deq ret_env env_expr env_var opt_out_vars (p:var) (e:expr) (sync:bool) : deq list =
  let e = opt_expr env_expr env_var opt_out_vars e in
  match e with
  | ExpVar v -> (match env_fetch_opt ret_env (get_var_base p) with
                 | Some _ -> [ Eqn([p],e,sync) ]
                 | None -> env_update env_expr (ExpVar p) (ExpVar v);
                           update_opt_out opt_out_vars p;
                           [])
  | Const _  -> (match env_fetch_opt ret_env (get_var_base p) with
                 | Some _ -> [ Eqn([p],e,sync) ]
                 | None   -> env_update env_expr (ExpVar p) e;
                             update_opt_out opt_out_vars p;
                             [])
  | _        -> env_update env_expr e (ExpVar p);
                [ Eqn([p],e,sync) ]

(* To be called before a Loop: it adds the assignments that have been optimized
   out but will be needed insigned the Loop.
   For instance, consider:
     x[0][0] = in[0];
     x[0][1] = in[1];
     for i in [0, 3] { f(x[i],x[i+1]) }
   The 1st assignments will be optimized out; this functions re-inserts them *)
let rec commit_asgns ?(env_it=(Hashtbl.create 10))
                     (env_expr:(expr,expr) Hashtbl.t)
                     (env_var:(ident,typ) Hashtbl.t)
                     (i,ei,ef,dl) :
          deq list =

  let rec compute_index (env_it:(ident,int) Hashtbl.t) (v:var) : var =
    match v with
    | Var _ -> v
    | Index(v,ae) -> Index(compute_index env_it v,simpl_arith env_it ae)
    | _ -> assert false in
  
  let rec find_usage
            (env_it:(ident,int) Hashtbl.t)
            (env_expr:(expr,expr) Hashtbl.t)
            (env_var:(ident,typ) Hashtbl.t)
            (v:var)
          : deq list =
    let v = compute_index env_it v in
    match Hashtbl.find_opt env_expr (ExpVar v) with
    | Some e -> env_remove env_expr (ExpVar v);
                [ Eqn([v],e, false) ]
    | None -> match get_var_type env_var v with
              | Uint(_,_,1) -> []
              | _ -> flat_map (find_usage env_it env_expr env_var)
                              (expand_var_partial env_var v) in
  

  let rec commit_deq (env_it:(ident,int) Hashtbl.t)
                     (env_expr:(expr,expr) Hashtbl.t)
                     (env_var:(ident,typ) Hashtbl.t)
                     (deq:deq)
          : deq list =
    match deq with
    | Eqn(l,e,_) -> flat_map (find_usage env_it env_expr env_var) (get_used_vars e)
    | Loop(i,ei,ef,dl,_) ->
       Hashtbl.add env_var i Nat;
       let res = commit_asgns ~env_it:env_it env_expr env_var (i,ei,ef,dl) in
       Hashtbl.remove env_var i;
       res in

  
  let ei = eval_arith env_it ei in
  let ef = eval_arith env_it ef in
  let eqs =
    flat_map
      (fun idx -> env_update env_it i idx;
                  flat_map (commit_deq env_it env_expr env_var) dl)
      (gen_list_bounds ei ef) in
  env_remove env_it i;

  eqs
        
                  
            
let rec opt_deqs env_var (deqs:deq list) (out:p) : deq list =
  (* The expressions already available *)
  let env_expr : (expr,expr) Hashtbl.t = make_env () in
  (* The return values, that shouldn't be optimized out *)
  let ret_env : (var,bool) Hashtbl.t = make_env () in
  List.iter (fun vd -> env_add ret_env (Var vd.vid) true) out;
  (* Array assignments that have been optimized out and use of those arrays 
     must therefore be expanded *)
  let opt_out_vars : (var,bool) Hashtbl.t = make_env () in

  flat_map
    (function
      (* A simple assignment *)
      | Eqn([v],e,sync) -> opt_deq ret_env env_expr env_var opt_out_vars v e sync
      (* A function call (it's the only way to have a list as lhs *)
      | Eqn(l,e,sync) -> [ Eqn(l,opt_expr env_expr env_var opt_out_vars e,sync) ]
      (* A loop *)
      | Loop(i,ei,ef,dl,opts) ->
         (commit_asgns env_expr env_var (i,ei,ef,dl)) @
           [ Loop(i,ei,ef,List.map fold_deq dl,opts) ]) deqs
      

let opt_def (def: def) : def =
  match def.node with
  | Single(p_var,body) ->
     let env_var = build_env_var def.p_in def.p_out p_var in
     if is_noopt def then def else
       { def with node = Single(p_var, opt_deqs env_var body def.p_out) }
  | _ -> def

let opt_prog (prog:prog) (conf:config) : prog =
  (* Expand_parameters.expand_parameters { nodes = List.map opt_def prog.nodes } conf *)
  { nodes = List.map opt_def prog.nodes }
    
