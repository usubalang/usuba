open Usuba_AST
open Utils

let rec clean_expr (e:expr) : expr =
  match e with
  | Const _ | ExpVar _ -> e
  | Tuple l -> Tuple(List.map clean_expr l)
  | Not e   -> Not (clean_expr e)
  | Shift(op,e,ae)  -> Shift(op,clean_expr e,ae)
  | Log(op,e1,e2)   -> Log(op,e1,e2)
  | Arith(op,e1,e2) -> Arith(op,e1,e2)
  | Fun(f,l)        -> Fun(f,List.map clean_expr l)
  (* Removing When and Merge*)
  | When(e,_,_)     -> e
  | Merge(id,l)     -> List.fold_left
                         (fun x y -> Log(Or,x,y))
                         (Const 0)
                         (List.map (fun (c,e) ->
                                    match c with
                                    | True  -> Log(And,(clean_expr e), ExpVar(Var id))
                                    | False -> Log(And,(clean_expr e), Not (ExpVar(Var id)))) l)
                                                               
  | _ -> assert false
       
let clean_deq (deq:deq) : deq = 
  match deq with
  | Norec(lhs,e) -> Norec(lhs,clean_expr e)
  | _ -> assert false
  
let clean_def (def:def) : def =
  match def.node with
  | Single(vars,body) -> {def with node = Single(vars,List.map clean_deq body) }
  | _ -> def

let remove_ctrl (prog:prog) : prog =
  { nodes = List.map clean_def prog.nodes }
