open Usuba_AST
open Utils


let op_to_intr (op:arith_op) : intr_fun =
  match op with
  | And -> Pand
  | Or  -> Por
  | Xor -> Pxor

let norm_deq (deq:deq) : deq =
  match deq with
  | Norec(p,e) -> begin
                  match e with
                  | Arith(op,x,y) -> Intr(op_to_intr op,x,y)
                  | Not x -> Intr(Pandn,x,Const 1)
                  | _ -> e
                end
  | _ -> raise (Invalid_AST "Rec")
       
let norm_def (def:def) : def =
  match def with
  | Single(id,p_in,p_out,vars,body) ->
     Single(id,p_in,p_out,vars,List.map norm_deq body)
  | _ -> raise (Invalid_AST "Non-Single node")
       
let choose_instr (prog:prog) : prog =
  List.map norm_def prog
