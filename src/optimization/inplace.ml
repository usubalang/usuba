(***************************************************************************** )
                                inplace.ml

  /!\ WARNING: not functional because of loops. For instance,

        forall i in [1, 5] {
           y = f(x)
           x = g(y)
        }

    With only `g` in-place would be transformed into:

        forall i in [1, 5] {
           y = f(x)
           y = g(y)
        }

    Which is obviously wrong...

  Changes calls to nodes that modify their inputs in place to modify
  their inputs in place.

  /!\ This module must be called after Fix_dim and Expand_parameters /!\

( *****************************************************************************)

open Usuba_AST
open Utils
open Basic_utils

let rec rename_var (rename_env:(ident,ident) Hashtbl.t) (v:var) : var =
  match v with
  | Var id -> (match Hashtbl.find_opt rename_env id with
               | Some id' -> Var id'
               | None     -> Var id)
  | Index(v,idx) -> Index(rename_var rename_env v,idx)
  | _ -> assert false

let rec rename_expr (rename_env:(ident,ident) Hashtbl.t) (e:expr) : expr =
  match e with
  | Const _        -> e
  | ExpVar v       -> ExpVar(rename_var rename_env v)
  | Tuple l        -> Tuple (List.map (rename_expr rename_env) l)
  | Not e          -> Not (rename_expr rename_env e)
  | Log(op,x,y)    -> Log(op,rename_expr rename_env x,rename_expr rename_env y)
  | Arith(op,x,y)  -> Arith(op,rename_expr rename_env x,rename_expr rename_env y)
  | Shift(op,e,ae) -> Shift(op,rename_expr rename_env e,ae)
  | Shuffle(v,l)   -> Shuffle(rename_var rename_env v,l)
  | Mask(e,i)      -> Mask(rename_expr rename_env e,i)
  | Pack(l,t)      -> Pack(List.map (rename_expr rename_env) l,t)
  | Fun(f,l)       -> Fun(f,List.map (rename_expr rename_env) l)
  | _ -> assert false

let inplace_expr (env_fun:(ident,def) Hashtbl.t)
                 (rename_env:(ident,ident) Hashtbl.t)
                 (vs:var list) (e:expr) (imp:bool) : deq_i =
  let e = rename_expr rename_env e in
  match e with
  | Fun(f,l) when not (is_primitive f) ->
     let target = Hashtbl.find env_fun f in
     let in_place = List.filter (fun vd -> vd.vd_inplace) target.p_out in
     Printf.printf "%s --> inplace:%s\n" (Usuba_print.deq_i_to_str (Eqn(vs,e,imp)))
                   (join "," (List.map Usuba_print.vd_to_str in_place));
     (* note that the argument to modify in-place are always the first
        return values *)
     let olds = first_n vs (List.length in_place) in
     let news = first_n l  (List.length in_place) in
     List.iter2 (fun old_v new_v ->
                 Hashtbl.add rename_env (get_base_name old_v) (get_expr_base_name new_v))
                olds news;
     let vs = replace_start vs (List.map expr_to_var news) in
     Eqn(vs,e,imp)
  | _ -> Eqn(vs,e,imp)

let rec inplace_deqs (env_fun:(ident,def) Hashtbl.t)
                     (rename_env:(ident,ident) Hashtbl.t)
                     (deqs:deq list) : deq list =
  List.map (fun deq ->
            { deq with
              content =
                match deq.content with
                | Eqn(lhs,e,imp) ->
                   inplace_expr env_fun rename_env lhs e imp
                | Loop(i,ei,ef,dl,opts) ->
                   Loop(i,ei,ef,inplace_deqs env_fun rename_env dl,opts) }) deqs

let inplace_def (env_fun:(ident,def) Hashtbl.t) (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let rename_env = Hashtbl.create 100 in
     { def with node = Single(vars,inplace_deqs env_fun rename_env body) }
  | _ -> def

let run _ (prog:prog) _ : prog =
  let env_fun = Hashtbl.create 10 in
  List.iter (fun def -> Hashtbl.add env_fun def.id def) prog.nodes;
  { nodes = List.map (inplace_def env_fun) prog.nodes }

let as_pass = (run, "Inplace")
