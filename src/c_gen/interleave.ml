open Usuba_AST
open Basic_utils
open Utils


let dup_id id = { id with name = id.name ^ "__2" }
       
let rec dup_var (v:var) : var =
  match v with
  | Var id -> Var (dup_id id)
  | Index(v,i) -> Index(dup_var v,i)
  | _ -> assert false
       
let rec dup_expr (e:expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> ExpVar(dup_var v)
  | Tuple l -> Tuple(List.map dup_expr l)
  | Shift(op,e,ae) -> Shift(op,dup_expr e,ae)
  | Log(op,x,y)    -> Log(op,dup_expr x,dup_expr y)
  | Shuffle(v,p)   -> Shuffle(dup_var v,p)
  | Arith(op,x,y)  -> Arith(op,dup_expr x,dup_expr y)
  | Fun(f,l)       -> Fun(f,List.map dup_expr l)
  | _ -> assert false

let rec interleave_deqs (deqs:deq list) : deq list =
  flat_map (fun d ->
            match d with
            | Norec(lhs,e) -> [ d ; Norec(List.map dup_var lhs,dup_expr e) ]
            | Rec(i,ei,ef,l,opts) -> [ Rec(i,ei,ef,interleave_deqs l,opts) ]) deqs

let dup_p (p:p) : p =
  flat_map (fun ((id,typ),ck) -> [ (id,typ), ck;
                                   (dup_id id,typ),ck ]) p
           
let interleave_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with p_in  = dup_p def.p_in;
                p_out = dup_p def.p_out;
                node  = Single(dup_p vars,interleave_deqs body) }     
  | _ -> assert false 
       
let interleave (prog:prog) (conf:config) : prog =
  { nodes = apply_last prog.nodes interleave_def }
