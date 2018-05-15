(***************************************************************************** )
                              expand_shift.ml                                 

   This module applies the "shift" and "rotate": in bitslice mode, it only 
   means renaming the registers.
    
    After this module has ran, there souldn't be any "Shift" expression left.

( *****************************************************************************)

open Usuba_AST
open Utils
               
let do_shift op l n =
  match op with
  | Lrotate -> let rec aux i l acc =
                 if i = 0 then l @ (List.rev acc)
                 else aux (i-1) (List.tl l) ((List.hd l)::acc)
               in aux n l []
  | Lshift  -> let rec aux i l acc =
                 if i = 0 then l @ acc
                 else aux (i-1) (List.tl l) ((Const 0)::acc)
               in aux n l []
  | Rrotate -> let rec aux i l acc =
                 if i = 0 then acc @ (List.rev l)
                 else aux (i-1) (List.tl l) ((List.hd l)::acc)
               in aux n (List.rev l) []
  | Rshift -> let rec aux i l acc =
                if i = 0 then acc @ (List.rev l)
                else aux (i-1) (List.tl l) ((Const 0)::acc)
              in aux n (List.rev l) []     

(* TODO: I'm pretty sure this doesn't cover every cases *)
let rec shift (op:shift_op) (e:expr) (n:int) =
  match e with
  | Const _ -> Shift(op,e,Const_e n)
  | ExpVar _ -> Shift(op,e,Const_e n)
  | Tuple l -> Tuple(do_shift op l n)
  | Not(e) -> Not(shift op e n)
  | Shift(op',e',Const_e n') ->
     let t = shift op' e' n' in
     if t = e then
       Shift(op,e,Const_e n)
     else
       shift op t n
  | _ -> raise (Error "I can't shift this")

let rec shift_expr (e:expr) : expr =
  match e with
  | ExpVar _ | Const _ -> e
  | Tuple l -> Tuple(List.map shift_expr l)
  | Not e' -> Not (shift_expr e')
  | Shift(op,e,Const_e n) -> shift op (shift_expr e) n
  | Log(op,x,y) -> Log(op,shift_expr x,shift_expr y)
  | Arith(op,x,y) -> Arith(op,shift_expr x,shift_expr y)
  | Fun(f,l) -> Fun(f,List.map shift_expr l)
  | Fun_v(f,ei,l) -> Fun_v(f,ei,List.map shift_expr l)
  | _ -> e
               
let rec shift_deq (deq:deq) : deq =
  match deq with
  | Norec(p,e) -> Norec(p,shift_expr e)
  | Rec(id,ei,ef,d,opts) -> Rec(id,ei,ef,List.map shift_deq d,opts)
                             
                            
let shift_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with node  = Single(vars,List.map shift_deq body) }
  | _ -> def
           
let expand_shifts (prog:prog) (conf:config) : prog =
  { nodes = List.map shift_def prog.nodes }
