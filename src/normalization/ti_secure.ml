open Usuba_AST
open Basic_utils
open Utils

let ti_and = fresh_ident "_andTI"
let ti_not = fresh_ident "_notTI"
let ti_or  = fresh_ident "_orTI"


let rec trip_expr (e:expr) : expr =
  match e with
  | Const _ | ExpVar _ | Shuffle _ -> e
  | Not e    -> Fun(ti_not,[trip_expr e])
  | Shift(op,e,ae) -> Shift(op,trip_expr e,ae)
  | Log(op,x,y) -> (match op with
                    | And -> Fun(ti_and,[trip_expr x; trip_expr y;Fun(fresh_ident "rand",[])])
                    | Or  -> Fun(ti_or,[trip_expr x; trip_expr y;Fun(fresh_ident "rand",[])])
                    | Xor -> Log(Xor,trip_expr x,trip_expr y)
                    | Andn -> assert false)
  | Arith _ -> assert false
  | Fun(f,l) -> Fun(f,List.map trip_expr l)
  | _ -> Printf.printf "Unsuported ti expression: %s\n" (Usuba_print.expr_to_str e);
         assert false
                
let rec trip_deqs (deqs:deq list) : deq list =
  List.map (function
             | Norec(vars,e) -> Norec(vars,trip_expr e)
             | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,trip_deqs dl,opts) ) deqs

let rec trip_typ (t:typ) : typ =
  match t with
  | Bool         -> Int(3,1)
  | Int(n,m)     -> Int(n*3,m)
  | Array(t',ae) -> Array(trip_typ t',ae)
  | Nat          -> Nat
  
let trip_p (p:p) : p =
  List.map (fun vd -> { vd with vtyp = trip_typ vd.vtyp }) p
   
let secure_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with p_in  = trip_p def.p_in;
                p_out = trip_p def.p_out;
                node  = Single(trip_p vars,trip_deqs body) }
  | _ -> def
   
let ti_secure ti_nodes (prog:prog) (conf:config) : prog =
  { nodes = ti_nodes.nodes @ (List.map secure_def prog.nodes) } 
