(***************************************************************************** )
                             expand_parameters.ml                              

( *****************************************************************************)

open Usuba_AST
open Basic_utils
open Utils
open Printf

let stable = ref false

exception Updated
                                           

let get_vars_body = function Single(vars,body) -> vars,body | _ -> assert false

let rec propagate_var env_var (v:var) : var list =
  match Hashtbl.find_opt env_var v with
  | Some v' -> v'
  | None -> [ v ]

let rec expand_expr env_var (e:expr) : expr list =
  match e with
  | Const _ -> [ e ]
  | ExpVar v -> List.map (fun x -> ExpVar x) (expand_var_partial env_var v)
  | _ -> Printf.fprintf stderr "Invalid expression: %s.\n"
                        (Usuba_print.expr_to_str_types e);
         assert false
              
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
  | Fun(x,es) -> let l = List.map (propagate_expr env_var) es in
                 (match l with
                  | [Tuple l'] -> Fun(x,l')
                  | _ -> Fun(x,l))
  | _ -> assert false
                
let rec propagate_deqs env_var (deqs:deq list) : deq list =
  List.map (function
             | Eqn(l,e,sync) -> Eqn(flat_map (propagate_var env_var) l,
                                    propagate_expr env_var e, sync)
             | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,propagate_deqs env_var dl,opts)) deqs

let replace l e e' = flat_map (fun x -> if x = e then e' else [x]) l
           
let expand_in_node env_fun (f:def) (id:ident) (ck:clock) (size:int) (old_typ:typ) (new_typ:typ) (in_out:bool)=
  let env_var = Hashtbl.create 100 in
  Hashtbl.replace env_var (Var id) (List.map (fun i -> Var(fresh_suffix id (sprintf "%d'" i))) (gen_list_0_int size));
  let new_p = List.map
                (fun i -> let id' = fresh_suffix id (sprintf "%d'" i) in
                          Hashtbl.replace env_var (Index(Var id,Const_e i)) [ Var id' ];
                          make_var_d id' new_typ ck [])
                (gen_list_0_int size) in
  let vars,body = get_vars_body f.node in
  let body = propagate_deqs env_var body in
  let new_node =
    if in_out then
      { f with p_in = replace f.p_in (make_var_d id old_typ ck []) new_p;
               node = Single(vars,body); }
    else
      { f with p_out = replace f.p_out (make_var_d id old_typ ck []) new_p;
               node = Single(vars,body); } in
  Hashtbl.replace env_fun new_node.id new_node


let expand_p env_fun (f:def) (vd:var_d) =  
  match vd.vtyp with
  | Bool -> assert false
  | Int(_,1) -> assert false
  | Int(n,m) ->
     expand_in_node env_fun f vd.vid vd.vck m vd.vtyp (Int(n,1))
  | Array(typ',ae) ->
     expand_in_node env_fun f vd.vid vd.vck (eval_arith_ne ae) vd.vtyp typ'
  | _ -> assert false
                                                   

let rec match_args env_fun env_var (f:def) (p:p) (el:expr list) :
          (var_d * expr) list =
  match p, el with
  | [], [] -> []
  | vd :: tl_p, e :: tl_e ->
     begin
       match compare (typ_size vd.vtyp) (get_expr_size env_var e) with
       | 0 -> (List.hd p, e)
              :: (match_args env_fun env_var f tl_p tl_e)
       | 1 -> expand_p env_fun f vd true;
              stable := false;
              raise Updated
       | -1 -> let e_start = expand_expr env_var e in
               stable := false;
               match_args env_fun env_var f p (e_start @ tl_e)
       | _ -> assert false
     end
  | _ -> assert false

let rec match_ret env_fun env_var (f:def) (p:p) (vars:var list) :
          (var_d * var) list =
  match p,vars with
  | [], [] -> []
  | (vd :: tl_p), (v :: tl_v) ->
     begin
       match compare (typ_size vd.vtyp) (get_var_size env_var v) with
       | 0 -> (List.hd p, v) :: (match_ret env_fun env_var f tl_p tl_v)
       | 1 -> expand_p env_fun f vd false;
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
  | Eqn(lhs,Fun(id,args),sync) ->
     if contains id.name "rand" then deq
     else
       let f = try Hashtbl.find env_fun id
               with Not_found -> Printf.fprintf stderr "Not_found(%s).\n" id.name;
                                 raise Not_found in
       let _,args = unzip (match_args env_fun env_var f f.p_in args) in
       let _,ret  = unzip (match_ret  env_fun env_var f f.p_out lhs) in
       Eqn(List.rev ret,Fun(id,List.rev args),sync)
  | Loop(i,ei,ef,dl,opts) ->
     Hashtbl.add env_var i Nat;
     let res = Loop(i,ei,ef,List.map (expand_deq env_fun env_var) dl,opts) in
     Hashtbl.remove env_var i;
     res
  | _ -> deq

                                              
let rec expand_def env_fun (def:def) : unit =
  try
    match def.node with
    | Single(vars,body) ->
       let env_var = build_env_var def.p_in def.p_out vars in
       Hashtbl.replace env_fun def.id 
                  { def with node = Single(vars,List.map (expand_deq env_fun env_var) body) }
    | _ -> assert false
  with Updated -> expand_def env_fun def
  

let expand_parameters (prog:prog) (conf:config) : prog =

  let env_fun = Hashtbl.create 100 in
  List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

  stable := false;
  while not !stable do
    stable := true;
    List.iter (fun node -> expand_def env_fun (Hashtbl.find env_fun node.id)) prog.nodes
  done;
  
  { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }
