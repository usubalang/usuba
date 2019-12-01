(*********************************************************************
                             unroll.ml

   About the |force| param pretty much everywhere: by default, this
   module unrolls only loops marked with _unroll. If |force| is true
   however, all loops are unrolled.
   |force| could be true mainly for 2 reasons:
      - either unroll_prog was called with a config where unroll = true.
      - unroll_prog was called with a param force = true.


 ********************************************************************)


open Usuba_AST
open Basic_utils
open Utils


let rec unroll_in_var (env_it:(ident,int) Hashtbl.t) (v:var) : var =
  match v with
  | Var _        -> v
  | Index(v',ae) -> Index(unroll_in_var env_it v',simpl_arith env_it ae)
  | _ -> assert false

let rec unroll_in_expr (env_it:(ident,int) Hashtbl.t) (e:expr) : expr =
  match e with
  | Const _         -> e
  | ExpVar v        -> ExpVar (unroll_in_var env_it v)
  | Tuple l         -> Tuple (List.map (unroll_in_expr env_it) l)
  | Not e'          -> Not (unroll_in_expr env_it e')
  | Shift(op,e',ae) -> Shift(op,unroll_in_expr env_it e',ae)
  | Log(op,x,y)     -> Log(op,unroll_in_expr env_it x,unroll_in_expr env_it y)
  | Shuffle(v,l)    -> Shuffle(unroll_in_var env_it v,l)
  | Arith(op,x,y)   -> Arith(op,unroll_in_expr env_it x,unroll_in_expr env_it y)
  | Fun(f,l)        -> Fun(f,List.map (unroll_in_expr env_it) l)
  | _ -> assert false


let rec unroll_deqs (env_it:(ident,int) Hashtbl.t)
                    (force:bool) (f:ident) (deqs:deq list)
    : deq list =
  flat_map (fun deq ->
            match deq.content with
            | Eqn(lhs,e,sync) ->
               let new_lhs = List.map (unroll_in_var env_it) lhs  in
               let new_e   = unroll_in_expr env_it e in
               let new_eqn = Eqn(new_lhs, new_e, sync) in
               let new_orig = if new_eqn = deq.content then deq.orig
                              else (f, deq.content) :: deq.orig in
               [ { orig = new_orig; content = new_eqn } ]
            | Loop(i,ei,ef,dl,opts) ->
               if force || is_unroll opts then
                 let ei = eval_arith env_it ei in
                 let ef = eval_arith env_it ef in
                 flat_map (fun n ->
                           Hashtbl.add env_it i n;
                           let res = unroll_deqs env_it force f dl in
                           Hashtbl.remove env_it i;
                           res)
                          (gen_list_bounds ei ef)
               else
                 [ { orig = deq.orig;
                     content = Loop(i,ei,ef,unroll_deqs env_it force f dl,opts) } ]
    ) deqs

let unroll_def (force:bool) (def:def) : def =
  { def with
    node =
      match def.node with
      | Single(vars,body) ->
         let env_it = Hashtbl.create 10 in
         Single(vars,unroll_deqs env_it force def.id body)
      | _ -> def.node }


let unroll_prog ?(force:bool=false) (prog:prog) (conf:config) : prog =
  (* if |conf|.unroll is true, then setting |force| to true. *)
  let force = if conf.unroll then true else force in
  { nodes = List.map (fun d -> unroll_def force d) prog.nodes }
