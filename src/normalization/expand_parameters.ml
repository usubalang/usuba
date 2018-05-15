(***************************************************************************** )
                             expand_parameters.ml                              

( *****************************************************************************)

open Usuba_AST
open Utils
open Printf
       
       
(* Abstracting Hashtbl.
   This functions should replace the ones in Utils, one day. *)
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error ("Not found: " ^ v.name))
let env_fetch_opt env v = Hashtbl.find_opt env v


let stable = ref false

exception Updated
                                           

let get_vars_body = function Single(vars,body) -> vars,body | _ -> assert false

let rec propagate_var env_var (v:var) : var list =
  match env_fetch_opt env_var v with
  | Some v' -> v'
  | None -> [ v ]

let rec expand_expr env_var (e:expr) : expr list =
  match e with
  | Const _ -> [ e ]
  | ExpVar v -> List.map (fun x -> ExpVar x) (expand_var_partial env_var v)
  | _ -> assert false
              
let rec propagate_expr env_var (e:expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> begin match propagate_var env_var v with
                      | [ v ] -> ExpVar v
                      | l -> Tuple(List.map (fun x -> ExpVar x) l) end
  | Tuple l -> Tuple(List.map (propagate_expr env_var) l)
  | Not e -> Not (propagate_expr env_var e)
  | Shift(op,e,ae) -> Shift(op,propagate_expr env_var e,ae)
  | Log(op,e1,e2) -> Log(op,propagate_expr env_var e1,propagate_expr env_var e2)
  (* Note that Shuffle **have** necessarily already been expanded *)
  | Shuffle(v,pat) -> Shuffle(List.hd (propagate_var env_var v),pat)
  | Arith(op,e1,e2) -> Arith(op,propagate_expr env_var e1,propagate_expr env_var e2)
  | Fun(x,es) -> Fun(x,List.map (propagate_expr env_var) es)
  | _ -> assert false
                
let rec propagate_deqs env_var (deqs:deq list) : deq list =
  List.map (function
             | Norec(l,e) -> Norec(flat_map (propagate_var env_var) l,
                                   propagate_expr env_var e)
             | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,propagate_deqs env_var dl,opts)) deqs

let replace l e e' = flat_map (fun x -> if x = e then e' else [x]) l
           
let expand_in_node env_fun (f:def) (id:ident) (ck:clock) (size:int) (old_typ:typ) (new_typ:typ) (in_out:bool)=
  let env_var = make_env () in
  env_add env_var (Var id) (List.map (fun i -> Var(fresh_suffix id (sprintf "%d'" i))) (gen_list_0_int size));
  let new_p = List.map
                (fun i -> let id' = fresh_suffix id (sprintf "%d'" i) in
                          env_add env_var (Index(Var id,Const_e i)) [ Var id' ];
                          ((id',new_typ),ck))
                (gen_list_0_int size) in
  let vars,body = get_vars_body f.node in
  let body = propagate_deqs env_var body in
  let new_node =
    if in_out then
      { f with p_in = replace f.p_in ((id,old_typ),ck) new_p;
               node = Single(vars,body); }
    else
      { f with p_out = replace f.p_out ((id,old_typ),ck) new_p;
               node = Single(vars,body); } in
  env_add env_fun new_node.id new_node


let expand_p env_fun (f:def) ((id,typ),ck) =  
  match typ with
  | Bool -> assert false
  | Int(_,1) -> assert false
  | Int(n,m) ->
     expand_in_node env_fun f id ck m typ (Int(n,1))
  | Array(typ',ae) ->
     expand_in_node env_fun f id ck (eval_arith_ne ae) typ typ'
  | _ -> assert false
     
                                              

let rec match_args env_fun env_var (f:def) (p:p) (el:expr list) :
          (((ident * typ) * clock) * expr) list =
  match p, el with
  | [], [] -> []
  | ((id,typ),ck) :: tl_p, e :: tl_e ->
     begin
       match compare (typ_size typ) (get_expr_size env_var e) with
       | 0 -> (List.hd p, e)
              :: (match_args env_fun env_var f tl_p tl_e)
       | 1 -> expand_p env_fun f ((id,typ),ck) true;
              stable := false;
              raise Updated
       | -1 -> let e_start = expand_expr env_var e in
               stable := false;
               match_args env_fun env_var f p (e_start @ tl_e)
       | _ -> assert false
     end
  | _ -> assert false

let rec match_ret env_fun env_var (f:def) (p:p) (vars:var list) :
          (((ident * typ) * clock) * var) list =
  match p,vars with
  | [], [] -> []
  | (((id,typ),ck) :: tl_p), (v :: tl_v) ->
     begin
       match compare (typ_size typ) (get_var_size env_var v) with
       | 0 -> (List.hd p, v) :: (match_ret env_fun env_var f tl_p tl_v)
       | 1 -> expand_p env_fun f ((id,typ),ck) false;
              stable := false;
              raise Updated
       | -1 -> let vars_start = expand_var_partial env_var v in
               stable := false;
               match_ret env_fun env_var f p (vars_start @ tl_v)
       | _ -> assert false
     end
  | _ -> assert false
                
                
let unzip l =
  List.fold_left (fun (l1,l2) (e1,e2) -> e1::l1,e2::l2) ([],[]) l 
                 
let rec expand_deq env_fun env_var (deq:deq) : deq =
  match deq with
  | Norec(lhs,Fun(id,args)) ->
     let f = Hashtbl.find env_fun id in
     let _,args = unzip (match_args env_fun env_var f f.p_in args) in
     let _,ret  = unzip (match_ret  env_fun env_var f f.p_out lhs) in
     Norec(List.rev ret,Fun(id,List.rev args))
  | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,List.map (expand_deq env_fun env_var) dl,opts)
  | _ -> deq

                                              
let rec expand_def env_fun (def:def) : unit =
  try
    match def.node with
    | Single(vars,body) ->
       let env_var = build_env_var def.p_in def.p_out vars in
       env_update env_fun def.id 
                  { def with node = Single(vars,List.map (expand_deq env_fun env_var) body) }
    | _ -> assert false
  with Updated -> expand_def env_fun def
  

let expand_parameters (prog:prog) (conf:config) : prog =

  let env_fun = make_env () in
  List.iter (fun node -> env_add env_fun node.id node) prog.nodes;

  stable := false;
  while not !stable do
    stable := true;
    List.iter (fun node -> expand_def env_fun (env_fetch env_fun node.id)) prog.nodes
  done;
  
  { nodes = List.map (fun node -> env_fetch env_fun node.id) prog.nodes }
