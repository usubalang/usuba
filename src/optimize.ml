open Utils
open Usuba_AST

let fix = ref false
       
module Constant_folding = struct

  let fold_norec (p:var list) (e:expr) : deq =
    Norec(
        p,(match e with
           | Log(And,Const 1,x) -> fix := false; x
           | Log(And,x,Const 1) -> fix := false; x
           | Log(And,Const 0,_) -> fix := false; Const 0
           | Log(And,_,Const 0) -> fix := false; Const 0
           | Log(Or,Const 1,_) -> fix := false; Const 1
           | Log(Or,_,Const 1) -> fix := false; Const 1
           | Log(Or,Const 0,x) -> fix := false; x
           | Log(Or,x,Const 0) -> fix := false; x
           | Log(Xor,Const 0,Const 0) -> fix := false; Const 0
           | Log(Xor,Const 0,Const 1) -> fix := false; Const 1
           | Log(Xor,Const 1,Const 0) -> fix := false; Const 1
           | Log(Xor,Const 1,Const 1) -> fix := false; Const 0
           (* | Log(Xor,Const 1,x) -> fix := false; Not(x) *)
           (* | Log(Xor,x,Const 1) -> fix := false; Not(x) *)
           | Log(Xor,Const 0,x) -> fix := false; x
           | Log(Xor,x,Const 0) -> fix := false; x
           | _ -> e))

  let fold_deq (deq:deq) : deq =
    match deq with
    | Norec(p,e) -> fold_norec p e
    | Rec _ -> raise (Invalid_AST (format_exn __LOC__
                                            "Illegal REC"))
                              
  let fold_def (def:def) : def =
    match def with
    | Single(name,p_in,p_out,p_var,body) ->
       Single(name, p_in, p_out, p_var, List.map fold_deq body)
    | _ -> raise (Invalid_AST (format_exn __LOC__
                                          "Illegal non-Single def"))
                 
  let fold_prog (prog:prog) : prog =
    List.map fold_def prog
end

(* Common Subexpression Elimination *)
module CSE = struct
  
  let is_dummy_assign (e:expr) : bool =
    match e with
    | ExpVar(Var _) | Const _ -> true
    | _ -> false

  let pat_to_expr (pat:var list) : expr =
    match pat with
    | x::[] -> ExpVar x
    | _ -> Tuple (List.map (function x -> ExpVar x) pat)

  let rec cse_expr env (e: expr) : expr =
    match env_fetch env e with
    | Some x -> x
    | None -> match e with
              | Log(op,x,y) -> Log(op,cse_expr env x,cse_expr env y)
              | Arith(op,x,y) -> Arith(op,cse_expr env x,cse_expr env y)
              | Not e -> Not (cse_expr env e)
              | Fun(f,l) -> Fun(f,List.map (cse_expr env) l)
              | _ -> e

  let cse_single_deq env ((p,e):(var list)*expr): ((var list)*expr) list =
    match env_fetch env e with
    | Some x -> env_add env (pat_to_expr p) x;
                fix := false;
                []
    | None -> if is_dummy_assign e then
                ( env_add env (pat_to_expr p) e;
                  fix := false;
                  [] )
              else
                ( let e' = cse_expr env e in
                  match env_fetch env e' with
                  | Some x -> env_add env (pat_to_expr p) x;
                              fix := false;
                              []
                  | None -> env_add env e' (pat_to_expr p);
                            [p,e'])

  let dont_opti (p:var list) (env:(var, int) Hashtbl.t) : bool =
    List.length (List.filter (fun x -> match env_fetch env x with
                                       | Some _ -> true
                                       | None -> false) p) > 0
                                                  
  let p_to_pat (p:p) : var list =
    List.map (fun (x,_,_) -> Var x) p
             
  let cse_deq (deq: deq list) no_opti : deq list =
    let env = Hashtbl.create 40 in
    let no_opt_env = Hashtbl.create 20 in
    let () = List.iter (fun x -> env_add no_opt_env x 1) (p_to_pat no_opti) in
    List.flatten
      (List.map
         (function
           | Norec (p,e) ->
              if dont_opti p no_opt_env then
                [Norec(p,cse_expr env e)]
              else
                ( let r = cse_single_deq env (p,e) in
                  List.map (fun (p,e) -> Norec(p,e)) r)
           | Rec _ -> raise (Invalid_AST (format_exn __LOC__ "Invalid Rec"))) deq)
                 

  let cse_def (def: def) : def =
    match def with
    | Single(name,p_in,p_out,p_var,body) ->
       Single(name, p_in, p_out, p_var, cse_deq body p_out)
    | _ -> raise (Invalid_AST (format_exn __LOC__
                                          "Illegal non-Single def"))

  let cse_prog (prog:prog) : prog =
    List.map cse_def prog
               
end
       
let opt_prog (prog: Usuba_AST.prog) : Usuba_AST.prog =
  let res = ref prog in
  fix := false;
  while not !fix do
    fix := true;
    let p' = CSE.cse_prog !res in
    res := Constant_folding.fold_prog p'
  done;
  !res
  (* prog *)
