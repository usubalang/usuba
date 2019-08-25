(***************************************************************************** )
                              expand_shift.ml

   This module applies the "shift" and "rotate": in bitslice mode, it only
   means renaming the registers.

    After this module has ran, there souldn't be any "Shift" expression left.

( *****************************************************************************)

open Usuba_AST
open Basic_utils
open Utils

let do_shift (env_var:(ident,typ) Hashtbl.t) (op:shift_op)
      (l:expr list) (n:int) : expr list =
  (* Empty env_fun since unfold_unnest must already have been called *)
  (*                               vvvvvvvvvvvvvvvvvv                *)
  let typ = List.hd (get_expr_type (Hashtbl.create 1) env_var (List.hd l)) in
  match op with
  | Lrotate -> let rec aux i l acc =
                 if i = 0 then l @ (List.rev acc)
                 else aux (i-1) (List.tl l) ((List.hd l)::acc)
               in aux n l []
  | Lshift  -> let rec aux i l acc =
                 if i = 0 then l @ acc
                 else aux (i-1) (List.tl l) ((Const(0,Some typ))::acc)
               in aux n l []
  | Rrotate -> let rec aux i l acc =
                 if i = 0 then acc @ (List.rev l)
                 else aux (i-1) (List.tl l) ((List.hd l)::acc)
               in aux n (List.rev l) []
  | Rshift -> let rec aux i l acc =
                if i = 0 then acc @ (List.rev l)
                else aux (i-1) (List.tl l) ((Const(0,Some typ))::acc)
              in aux n (List.rev l) []

(* TODO: I'm pretty sure this doesn't cover every cases *)
let rec shift (env_var:(ident,typ) Hashtbl.t) (op:shift_op) (e:expr) (n:int) : expr =
  match e with
  | Const _ -> Shift(op,e,Const_e n)
  | ExpVar _ -> Shift(op,e,Const_e n)
  | Tuple l -> Tuple(do_shift env_var op l n)
  | Not(e) -> Not(shift env_var op e n)
  | Shift(op',e',Const_e n') ->
     let t = shift env_var op' e' n' in
     if t = e then
       Shift(op,e,Const_e n)
     else
       shift env_var op t n
  | _ -> raise (Error "I can't shift this")

let rec shift_expr (env_var:(ident,typ) Hashtbl.t) (e:expr) : expr =
  match e with
  | ExpVar _ | Const _ -> e
  | Tuple l -> Tuple(List.map (shift_expr env_var) l)
  | Not e' -> Not (shift_expr env_var e')
  | Shift(op,e,n) ->
     (try
        let n = eval_arith_ne n in
        shift env_var op (shift_expr env_var e) n
      with Not_found -> Shift(op,shift_expr env_var e,n))
  | Log(op,x,y) -> Log(op,shift_expr env_var x,shift_expr env_var y)
  | Arith(op,x,y) -> Arith(op,shift_expr env_var x,shift_expr env_var y)
  | Fun(f,l) -> Fun(f,List.map (shift_expr env_var) l)
  | Fun_v(f,ei,l) -> Fun_v(f,ei,List.map (shift_expr env_var) l)
  | _ -> e

let rec shift_deq (env_var:(ident,typ) Hashtbl.t) (deq:deq) : deq =
  match deq with
  | Eqn(p,e,sync) -> Eqn(p,shift_expr env_var e,sync)
  | Loop(id,ei,ef,d,opts) -> Loop(id,ei,ef,List.map (shift_deq env_var) d,opts)


let shift_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let env_var = build_env_var def.p_in def.p_out vars in
     { def with node  = Single(vars,List.map (shift_deq env_var) body) }
  | _ -> def

let expand_shifts (prog:prog) (conf:config) : prog =
  { nodes = List.map shift_def prog.nodes }
