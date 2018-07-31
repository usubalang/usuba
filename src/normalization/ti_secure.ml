open Usuba_AST
open Basic_utils
open Utils

let ti_and = fresh_ident "_andTI"
let ti_not = fresh_ident "_notTI"
let ti_or  = fresh_ident "_orTI"


let rec ti_expr (ti:int) (e:expr) : expr =
  match e with
  | Const _ | ExpVar _ | Shuffle _ -> e
  | Not e    -> Fun(ti_not,[ti_expr ti e])
  | Shift(op,e,ae) -> Shift(op,ti_expr ti e,ae)
  | Log(op,x,y) -> (match op with
                    | And -> Fun(ti_and,[ti_expr ti x; ti_expr ti y;Fun(fresh_ident "RAND",[])]
                                        @ ( if ti = 8 then [Fun(fresh_ident "RAND",[])] else []))
                    | Or  -> Fun(ti_or,[ti_expr ti x; ti_expr ti y;Fun(fresh_ident "RAND",[])]
                                       @ ( if ti = 8 then [Fun(fresh_ident "RAND",[])] else []))
                    | Xor -> Log(Xor,ti_expr ti x,ti_expr ti y)
                    | Andn -> assert false)
  | Fun(f,l) -> Fun(f,List.map (ti_expr ti) l)
  | _ -> Printf.printf "Unsuported ti expression: %s\n" (Usuba_print.expr_to_str e);
         assert false
                
let rec ti_deqs (ti:int) (deqs:deq list) : deq list =
  List.map (function
             | Norec(vars,e) -> Norec(vars,ti_expr ti e)
             | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,ti_deqs ti dl,opts) ) deqs

let rec ti_typ (ti:int) (t:typ) : typ =
  match t with
  | Bool         -> Int(ti,1)
  | Int(n,m)     -> Int(n*ti,m)
  | Array(t',ae) -> Array(ti_typ ti t',ae)
  | Nat          -> Nat
  
let ti_p (ti:int) (p:p) : p =
  List.map (fun ((id,typ),ck) -> ((id,ti_typ ti typ),ck)) p
   
let secure_def (ti:int) (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with p_in  = ti_p ti def.p_in;
                p_out = ti_p ti def.p_out;
                node  = Single(ti_p ti vars,ti_deqs ti body) }
  | _ -> def
   
let ti_secure ti_nodes (prog:prog) (conf:config) : prog =
  { nodes = ti_nodes.nodes @ (List.map (secure_def conf.ti) prog.nodes) } 
