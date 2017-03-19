open Utils
open Usuba_AST

let fix = ref false
       
module Constant_folding = struct

  let fold_deq ((p,e):pat*expr) : pat*expr =
    p,(match e with
       | Op(And,[Const 1;x]) -> fix := false; x
       | Op(And,[x;Const 1]) -> fix := false; x
       | Op(And,[Const 0;_]) -> fix := false; Const 0
       | Op(And,[_;Const 0]) -> fix := false; Const 0
       | Op(Or,[Const 1;_]) -> fix := false; Const 1
       | Op(Or,[_;Const 1]) -> fix := false; Const 1
       | Op(Or,[Const 0;x]) -> fix := false; x
       | Op(Or,[x;Const 0]) -> fix := false; x
       | _ -> e)
                              
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
    | Var _ | Const _ -> true
    | _ -> false

  let pat_to_expr (pat:pat) : expr =
    match pat with
    | (Ident v)::[] -> Var v
    | _ -> Tuple (List.map (function Ident id -> Var id
                                   | _ -> unreached () ) pat)

  let rec cse_expr env (e: expr) : expr =
    match env_fetch env e with
    | Some x -> x
    | None -> match e with
              | Op(op,l) -> Op(op,List.map (cse_expr env) l)
              | Fun(f,l) -> Fun(f,List.map (cse_expr env) l)
              | _ -> e

  let cse_single_deq env ((p,e):pat*expr): (pat*expr) list =
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

  let dont_opti (p:pat) (env:(left_asgn, int) Hashtbl.t) : bool =
    List.length (List.filter (fun x -> match env_fetch env x with
                                       | Some _ -> true
                                       | None -> false) p) > 0

  let p_to_pat (p:p) : pat =
    List.map (fun (x,_,_) -> Ident x) p
             
  let cse_deq (deq: deq) no_opti : deq =
    let env = Hashtbl.create 40 in
    let no_opt_env = Hashtbl.create 20 in
    let _ = List.map (fun x -> env_add no_opt_env x 1) (p_to_pat no_opti) in
    List.flatten (List.map
                    (fun (p,e) -> if dont_opti p no_opt_env then
                                    [(p,cse_expr env e)]
                                  else
                                    cse_single_deq env (p,e)) deq)
                 

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
  while not !fix do
    fix := true;
    let p' = CSE.cse_prog !res in
    res := Constant_folding.fold_prog p'
  done;
  !res
  (* prog *)
