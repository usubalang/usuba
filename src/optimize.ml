open Utils
open Usuba_AST
open Usuba_print

(* Common Subexpression Elimination and Constant Folding*)
module CSE_CF = struct

  let rec fold_expr not_env (e:expr) : expr =
    match e with
    | Log(op,x,y) ->
       let x' = fold_expr not_env x in
       let y' = fold_expr not_env y in
       ( match x',y' with
         | Const _, _ | _, Const _ -> (
           match Log(op,x',y') with
           | Log(And,Const 1,x) -> x
           | Log(And,x,Const 1) -> x
           | Log(And,Const 0,_) -> Const 0
           | Log(And,_,Const 0) -> Const 0

           | Log(And,x,y) ->
              ( match x with
                | ExpVar(Var v) ->
                   ( match env_fetch not_env v with
                     | Some x -> Log(Andn,x,y)
                     | None ->
                        match y with
                        | ExpVar(Var v) ->
                           (match env_fetch not_env v with
                            | Some y -> Log(Andn,y,x)
                            | None -> Log(And,x,y))
                        | _ -> Log(And,x,y))
                | _ -> Log(And,x,y))
                                         
           | Log(Or,Const 1,_) -> Const 1
           | Log(Or,_,Const 1) -> Const 1
           | Log(Or,Const 0,x) -> x
           | Log(Or,x,Const 0) -> x
                                    
           | Log(Xor,Const 0,x) -> x    
           | Log(Xor,x,Const 0) -> x
           | Log(Xor,Const 1,x) -> Not x
           | Log(Xor,x,Const 1) -> Not x
                                             
           | Log(Andn,Const 0,x) -> x
           | Log(Andn,x,Const 0) -> Const 0
           | Log(Andn,Const 1,x) -> Const 0
           | Log(Andn,x,Const 1) -> Not x
                  
                                        
           | _ -> Log(op,x',y'))
         | _, _ -> Log(op,x',y') )
    | Fun(f,l) -> Fun(f,List.map (fold_expr not_env) l)
    | Tuple l -> Tuple(List.map (fold_expr not_env) l)
    | Not x -> let x' = fold_expr not_env x in
               ( match x with
                 | Const 1 -> Const 0
                 | Const 0 -> Const 1
                 | _ -> Not x')
    | _ -> e
             
  let is_dummy_assign (e:expr) : bool =
    match e with
    | ExpVar(Var _) | Const _ -> true
    | _ -> false

  let pat_to_expr (pat:var list) : expr =
    match pat with
    | x::[] -> ExpVar x
    | _ -> Tuple (List.map (function x -> ExpVar x) pat)

  let rec cse_expr env not_env (e: expr) : expr =
    let e' = fold_expr not_env (
                 match e with
                 | Log(op,x,y) -> Log(op,cse_expr env not_env x,
                                      cse_expr env not_env y)
                 | Arith(op,x,y) -> Arith(op,cse_expr env not_env x,
                                          cse_expr env not_env y)
                 | Not e -> Not (cse_expr env not_env e)
                 | Fun(f,l) -> Fun(f,List.map (cse_expr env not_env) l)
                 | Tuple l -> Tuple(List.map (cse_expr env not_env) l)
                 | _ -> e ) in
    match env_fetch env e' with
    | Some x -> x
    | None ->
       let e' = fold_expr not_env (
                    match e' with
                    | Log(op,x,y) ->
                       (match op with
                        | And | Or | Xor -> Log(op,cse_expr env not_env y,
                                                cse_expr env not_env x)
                        | Andn -> e')
                    | Arith(Add,x,y) -> Arith(Add,cse_expr env not_env y,
                                              cse_expr env not_env x)
                    | Arith(Mul,x,y) -> Arith(Mul,cse_expr env not_env y,
                                              cse_expr env not_env x)
                    | _ -> e' ) in
       match env_fetch env e' with
       | Some x -> x
       | None -> e'
              
  let cse_single_deq env not_env ((p,e):(var list)*expr): ((var list)*expr) list =
    let e' = cse_expr env not_env e in
    (match e',p with
     | Not x,[Var v] -> env_add not_env v x
     | _ -> ());
    let p' = pat_to_expr p in
    match env_fetch env e' with
    | Some x -> env_add env p' x;
                []
    | None -> if is_dummy_assign e' then
                ( env_add env p' e';
                  [] )
              else
                ( env_add env e' p';
                  [p,e'] )

  let dont_opti (p:var list) (env:(var, int) Hashtbl.t) : bool =
    List.length (List.filter (fun x -> match env_fetch env x with
                                       | Some _ -> true
                                       | None -> false) p) > 0
                                                  
  let p_to_pat (p:p) : var list =
    List.map (fun (x,_,_) -> Var x) p
             
  let cse_deq (deq: deq list) no_opti : deq list =
    let env = Hashtbl.create 40 in
    let not_env = Hashtbl.create 40 in
    let no_opt_env = Hashtbl.create 20 in
    List.iter (fun x -> env_add no_opt_env x 1) (p_to_pat no_opti);
    List.flatten @@
      List.map
        (function
          | Norec (p,e) ->
             if dont_opti p no_opt_env then
                 [Norec(p,cse_expr env not_env e)]
             else
               ( let r = cse_single_deq env not_env (p,e) in
                 List.map (fun (p,e) -> Norec(p,e)) r)
          | Rec _ -> raise (Invalid_AST "Invalid Rec")) deq           
                 
  let cse_def (def: def) : def =
    match def.node with
    | Single(p_var,body) ->
       { def with node = Single(p_var, cse_deq body def.p_out) }
    | _ -> def

  let cse_prog (prog:prog) : prog =
    { nodes = List.map cse_def prog.nodes }
               
end

module Clean = struct

  let rec clean_var env (var:var) : unit =
    match var with
    | Var id -> Hashtbl.replace env id 1
    | Field(v,_) -> clean_var env v
    | Index(id,_) -> Hashtbl.replace env id 1
    | Range(id,_,_) -> Hashtbl.replace env id 1
    | Slice(id,_) -> Hashtbl.replace env id 1

  let rec clean_expr env (e:expr) : unit =
    match e with
    | ExpVar(v) -> clean_var env v
    | Tuple l -> List.iter (clean_expr env) l
    | Not e -> clean_expr env e
    | Shift(_,x,_) -> clean_expr env x
    | Log(_,x,y) -> clean_expr env x; clean_expr env y
    | Arith(_,x,y) -> clean_expr env x; clean_expr env y
    | Intr(_,x,y) -> clean_expr env x; clean_expr env y
    | Fun(_,l) -> List.iter (clean_expr env) l
    | Fun_v(_,_,l) -> List.iter (clean_expr env) l
    | Fby(ei,ef,_) -> clean_expr env ei; clean_expr env ef
    | _ -> ()
  
  let clean_in_deqs (vars:p) (deqs:deq list) : p =
    let env = Hashtbl.create 100 in
    List.iter
      (function
        | Norec(l,e) -> List.iter (clean_var env) l;
                        clean_expr env e
        | Rec(_,_,_,l,e) -> List.iter (clean_var env) l;
                            clean_expr env e) deqs;
    List.sort_uniq (fun a b -> compare a b)
                   ( List.filter (fun (id,_,_) -> match env_fetch env id with
                                                  | Some _ -> true
                                                  | None -> false) vars)

  let clean_def (def:def) : def =
    match def.node with
    | Single(vars,body) ->
       let vars = clean_in_deqs vars body in
       { def with node = Single(vars,body) }
    | _ -> def
  
  let clean_vars_decl (prog:prog) : prog =
    { nodes = List.map clean_def prog.nodes }
end
       
let opt_prog (prog: Usuba_AST.prog) (share:bool) : Usuba_AST.prog =
  let optimized = CSE_CF.cse_prog prog in
  let vars_shared = if share then Share_var.share_prog optimized else optimized in
  let cleaned = Clean.clean_vars_decl vars_shared in
  Scheduler.schedule cleaned
