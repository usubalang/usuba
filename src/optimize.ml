open Utils
open Usuba_AST
open Usuba_print

(* Common Subexpression Elimination and Constant Folding*)
module CSE_CF = struct

  let rec fold_expr (e:expr) : expr =
    match e with
    | Log(op,x,y) ->
       let x' = fold_expr x in
       let y' = fold_expr y in
       ( match x',y' with
         | Const _, _ | _, Const _ -> (
           match Log(op,x',y') with
           | Log(And,Const 1,x) -> fold_expr x
           | Log(And,x,Const 1) -> fold_expr x
           | Log(And,Const 0,_) -> Const 0
           | Log(And,_,Const 0) -> Const 0
           | Log(Or,Const 1,_) -> Const 1
           | Log(Or,_,Const 1) -> Const 1
           | Log(Or,Const 0,x) -> fold_expr x
           | Log(Or,x,Const 0) -> fold_expr x
           | Log(Xor,Const 0,Const 0) -> Const 0
           | Log(Xor,Const 0,Const 1) -> Const 1
           | Log(Xor,Const 1,Const 0) -> Const 1
           | Log(Xor,Const 1,Const 1) -> Const 0
           (* | Log(Xor,Const 1,x) -> Not(x) *)
           (* | Log(Xor,x,Const 1) -> Not(x) *)
           | Log(Xor,Const 0,x) -> fold_expr x
           | Log(Xor,x,Const 0) -> fold_expr x
           | _ -> Log(op,x',y'))
         | _, _ -> Log(op,x',y') )
    | Fun(f,l) -> Fun(f,List.map fold_expr l)
    | Tuple l -> Tuple(List.map fold_expr l)
    | _ -> e
             
  let is_dummy_assign (e:expr) : bool =
    match e with
    | ExpVar(Var _) | Const _ -> true
    | _ -> false

  let pat_to_expr (pat:var list) : expr =
    match pat with
    | x::[] -> ExpVar x
    | _ -> Tuple (List.map (function x -> ExpVar x) pat)

  let rec cse_expr env (e: expr) : expr =
    let e' = fold_expr (
                match e with
                | Log(op,x,y) -> Log(op,cse_expr env x,cse_expr env y)
                | Arith(op,x,y) -> Arith(op,cse_expr env x,cse_expr env y)
                | Not e -> Not (cse_expr env e)
                | Fun(f,l) -> Fun(f,List.map (cse_expr env) l)
                | Tuple l -> Tuple(List.map (cse_expr env) l)
                | _ -> e ) in
    match env_fetch env e' with
    | Some x -> x
    | None ->
       let e' = fold_expr (
                    match e with
                    | Log(op,x,y) -> Log(op,cse_expr env y,cse_expr env x)
                    | Arith(Add,x,y) -> Arith(Add,cse_expr env y,cse_expr env x)
                    | Arith(Mul,x,y) -> Arith(Mul,cse_expr env y,cse_expr env x)
                    | _ -> e' ) in
       match env_fetch env e' with
       | Some x -> x
       | None -> e'
              
  let cse_single_deq env ((p,e):(var list)*expr): ((var list)*expr) list =
    let e = cse_expr env e in
    match env_fetch env e with
    | Some x -> env_add env (pat_to_expr p) x;
                []
    | None -> if is_dummy_assign e then
                ( env_add env (pat_to_expr p) e;
                  [] )
              else
                ( env_add env e (pat_to_expr p);
                  [p,e] )

  let dont_opti (p:var list) (env:(var, int) Hashtbl.t) : bool =
    List.length (List.filter (fun x -> match env_fetch env x with
                                       | Some _ -> true
                                       | None -> false) p) > 0
                                                  
  let p_to_pat (p:p) : var list =
    List.map (fun (x,_,_) -> Var x) p
             
  let cse_deq (deq: deq list) no_opti : deq list =
    let env = Hashtbl.create 40 in
    let no_opt_env = Hashtbl.create 20 in
    List.iter (fun x -> env_add no_opt_env x 1) (p_to_pat no_opti);
    List.flatten @@
      List.map
        (function
          | Norec (p,e) ->
             if dont_opti p no_opt_env then
                 [Norec(p,cse_expr env e)]
             else
               ( let r = cse_single_deq env (p,e) in
                 List.map (fun (p,e) -> Norec(p,e)) r)
          | Rec _ -> raise (Invalid_AST "Invalid Rec")) deq
           
                 

  let cse_def (def: def) : def =
    match def with
    | Single(name,p_in,p_out,p_var,body) ->
       Single(name, p_in, p_out, p_var, cse_deq body p_out)
    | _ -> def

  let cse_prog (prog:prog) : prog =
    List.map cse_def prog
               
end
       
let opt_prog (prog: Usuba_AST.prog) : Usuba_AST.prog =
  CSE_CF.cse_prog prog
  
