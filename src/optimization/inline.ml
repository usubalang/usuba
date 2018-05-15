(* ************************************************************************** *)
(*                                  INLINING                                  *)
(*                                                                            *)
(* I see two ways of doing inlining:                                          *)
(*   - iterating through the nodes' bodies, and inlining functions calls as   *)
(*      they appear.                                                          *)
(*   - iterating through the nodes, and for each nodes, inline every call     *)
(*      made to it by parcouring the other nodes' bodies.                     *)
(* I chose the latter; not sure what more efficient though.                   *)
(* ************************************************************************** *)


open Usuba_AST
open Basic_utils
open Utils

     

let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error (__LOC__ ^ ":Not found: " ^ v.name))  

let rec update_var_to_var var_env v =
  match Hashtbl.find_opt var_env v with
  | Some v' -> v'
  | None -> match v with
            | Var _ -> Printf.fprintf stderr "Fail: %s\n" (Usuba_print.var_to_str v);
                       assert false
            | Index(v',ae) -> Index(update_var_to_var var_env v',ae)
            | _ -> assert false
                                    
let rec update_var_to_expr var_env expr_env v =
  match Hashtbl.find_opt expr_env v with
  | Some e -> e
  | None ->  match Hashtbl.find_opt var_env v with
            | Some v' -> ExpVar v'
            | None -> match v with
                      | Var _ -> assert false
                      | Index(v',ae) ->
                         begin
                           match update_var_to_expr var_env expr_env v' with
                           | ExpVar v'' -> ExpVar(Index(v'',ae))
                           | _ -> assert false
                         end
                      | _ -> assert false
                                              
(* Convert variables names inside an expression *)
let rec update_expr var_env expr_env (e:expr) : expr =
  let rec_call = update_expr var_env expr_env in
  match e with
  | Const _ -> e
  | ExpVar v -> update_var_to_expr var_env expr_env v
  | Shuffle(v,l) -> begin match update_var_to_expr var_env expr_env v with
                          | ExpVar v' -> Shuffle(v',l)
                          | _ -> assert false end

     (*( match Hashtbl.find_opt expr_env v with
                      | Some (ExpVar v) -> Shuffle(v,l)
                      | None -> Shuffle(Hashtbl.find var_env v,l)
                      | _ -> assert false)*)
  | Tuple l -> Tuple (List.map rec_call l)
  | Not e -> Not (rec_call e)
  (* TODO: Should do something with 'ae' *)
  | Shift(op,e,ae) -> Shift(op,rec_call e,ae)
  | Log(op,x,y) -> Log(op,rec_call x,rec_call y)
  | Arith(op,x,y) -> Arith(op,rec_call x,rec_call y)
  | Fun(f,l) -> Fun(f,List.map rec_call l)
  | _ -> print_endline (Usuba_print.expr_to_str e);
         assert false

(* Convert the variable names *)
let rec update_vars (var_env : (var,var) Hashtbl.t)
                    (expr_env: (var,expr) Hashtbl.t)
                    (body:deq list) : deq list =
  List.map (function
      | Norec(lhs,e) -> Norec( List.map (update_var_to_var var_env) lhs,
                               update_expr var_env expr_env e )
      | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,update_vars var_env expr_env dl,opts)) body

           
(* Inline a specific call (defined by lhs & args) *)
let inline_call (to_inl:def) (args:expr list) (lhs:var list) (cpt:int) :
      p * deq list =
  (* Define a name conversion function *)
  let conv_name (id:ident) : ident =
    { id with name = Printf.sprintf "%s_%d_%s" to_inl.id.name cpt id.name } in
  
  (* Extract body, vars, params and name of the node to inline *)
  let (vars_inl,body_inl) = match to_inl.node with
    | Single(vars,body) -> vars, body
    | _ -> assert false in
  let p_in  = to_inl.p_in  in
  let p_out = to_inl.p_out in

  (* alpha-conversion environments *)
  let var_env = Hashtbl.create 100 in
  let expr_env = Hashtbl.create 100 in
  (* p_out replaced by the lhs *)
  List.iter2 ( fun ((id,_),_) v -> Hashtbl.add var_env (Var id) v ) p_out lhs;
  (* p_in replaced by the expressions of arguments *)
  List.iter2 ( fun ((id,_),_) e -> Hashtbl.add expr_env (Var id) e) p_in args;
  (* Create a list containing the new variables names *)
  let vars = List.map (fun ((id,typ),ck) -> ((conv_name id,typ),ck)) vars_inl in
  (* nodes variables alpha-converted *)
  List.iter2 ( fun ((id,_),_) ((id',_),_) ->
               Hashtbl.add var_env (Var id) (Var id')) vars_inl vars;
  
  vars, update_vars var_env expr_env body_inl  
  
  
(* Inline all the calls to "to_inl" in a given node 
   (desribed by its variables and body "vars,body") *)
let rec inline_in_node (deqs:deq list) (to_inl:def) : p * deq list =
  let f_inl = to_inl.id.name in
  (* maintain a counter for variables alpha-conversion *)
  let cpt   = ref 0 in
  
  let (vars,deqs) =
    (* Unpack the list bellow into a single list of vars and 
       a list of deqs *)
    List.split      
      (* Find the calls to f_inl, and inline them. 
       This will introduce new variables, which is 
       why maps returns a (p * deq list) list. *)
      ( List.map (
            fun eqn -> match eqn with
                       | Norec(lhs,Fun(f,l)) when f.name = f_inl ->
                          incr cpt;
                          inline_call to_inl l lhs !cpt
                       | Norec _ -> [], [eqn]
                       | Rec(i,ei,ef,dl,opts) ->
                          let (vars, deqs) = inline_in_node dl to_inl in
                          vars, [ Rec(i,ei,ef,deqs,opts) ]
          ) deqs ) in
  List.flatten vars, List.flatten deqs
    

(* Perform the inlining of node "to_inline" at every call point *)
(* And removes the node from the program *)
let do_inline (prog:prog) (to_inline:def) : prog =

  { nodes =
      List.filter (fun def -> def.id <> to_inline.id) @@
        List.map (fun def ->
                  match def.node with
                  | Single(vars,body) ->
                     let (vars',body') = inline_in_node body to_inline in
                     { def with node = Single(vars @ vars',body') }
                  | _ -> def) prog.nodes }
  
  
(* Returns true if def doesn't contain any function call,
   or if those calls are to functions that are not going 
   to be inlined *)
let is_call_free env (def:def) : bool =
  let rec deq_call_free (deq:deq) : bool =
    match deq with
    | Norec(_,Fun(f,_)) -> is_noinline (Hashtbl.find env f.name)
                           || is_perm (Hashtbl.find env f.name)
    | Norec _ -> true
    | Rec(_,_,_,dl,_) -> List.for_all deq_call_free dl in
  match def.node with
  | Single(_,body) ->
     List.for_all deq_call_free body
  | _ -> false
  
(* Returns true if the node can be inlined now. ie:
    - is not already inlined
    - it doesn't have the attribute "no_inline"
       (and "inline_all" isn't set to true)
    - it doesn't contain any function call, or
    - every function call it contains is to a node "no_inline" *)
let can_inline env inlined conf (node:def) : bool =
  (* Is not already inlined *)
  (not (Hashtbl.find inlined node.id.name)) &&
    (* Is not "no_inline" or inlining is forced *)
    ( (not (is_noinline node)) || conf.inline_all ) &&
      (* Doesn't contain any call, or calls to "no_inline" *)
      (is_call_free env node)

        
(* Inline every node that should be and hasn't already been
   (inlined contains the status of each node: inlined or not) *)
let rec _inline (prog:prog) (conf:config) inlined : prog =

  (* A list of every node, needed for "is_call_free" *)
  let env = Hashtbl.create 20 in
  List.iter (fun x -> Hashtbl.add env x.id.name x) prog.nodes;

  (* If there is a node that can be inlined *)
  if List.exists (can_inline env inlined conf) prog.nodes then
    (* find the node to inline *)
    let to_inline = List.find (can_inline env inlined conf) prog.nodes in
    (* inline it *)
    let prog' = do_inline prog to_inline in
    (* add it to the hash of inlined nodes *)
    Hashtbl.replace inlined to_inline.id.name true;
    (* continue inlining *)
    _inline prog' conf inlined
  else
    (* inlining is done, return the prog *)
    prog

(* Main inlining function. _inline actually does most of the job *)
let inline (prog:prog) (conf:config) : prog =
  if conf.inlining then
    (* Hashtbl containing the inlining status of each node:
     false if it is not already inlined, true if it is *)
    let inlined = Hashtbl.create 20 in
    List.iter (fun x -> Hashtbl.add inlined x.id.name false) prog.nodes;
    (* The last node is the entry point, it wouldn't make sense to try inline it *)
    Hashtbl.replace inlined (last prog.nodes).id.name true;

    (* And now, perform the inlining *)
    _inline prog conf inlined
  else prog
