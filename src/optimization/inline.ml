open Usuba_AST
open Utils

let max_pressure = 14

let get_body (node:def) : deq list =
  match node.node with
  | Single(_,body) -> body
  | _ -> raise (Error "Not a Single")
       
let reg_pressure (deqs: deq list) (p_out:p) : int =
  let live : (var,bool) Hashtbl.t = Hashtbl.create 100 in (* variables currently alive *)
  
  let p_out = List.map (fun ((x,_),_) -> Var x) p_out in
  
  List.iter (fun x -> Hashtbl.add live x true) p_out;
  let reg_pressure = ref (Hashtbl.length live) in

  List.iter (function
              | Norec(l,e) ->
                 List.iter (fun x -> Hashtbl.replace live x true) (get_used_vars e);
                 List.iter (fun x -> Hashtbl.remove live x) l;
                 reg_pressure := max !reg_pressure (Hashtbl.length live)
              | _ -> unreached()) (List.rev deqs);
  
  !reg_pressure
       
let rec has_no_inner_deps (vars:p) (body:deq list) : bool =
  let env = Hashtbl.create 100 in
  List.iter (fun ((id,_),_) -> env_add env id true) vars;
  not (List.exists (function
                     | Norec(_,e) -> List.exists
                                       (fun x ->
                                        match env_fetch env (get_var_name x) with
                                        | Some _ -> true
                                        | None -> false) (get_used_vars e)
                     | _ -> false) body)
       
let should_inline (dest:def) (def:def) : bool =
  match def.node with
  | Single(vars,body) ->
     if has_no_inner_deps vars body then true
     else
       let pressure_dst = reg_pressure (get_body dest) dest.p_out in
       let pressure_def = reg_pressure (get_body def) def.p_out in
       pressure_dst + pressure_def <= max_pressure
  | _ -> false
           
let is_call_free (def:def) : bool =
  match def.node with
  | Single(_,body) ->
     List.fold_left (&&) true
                    (List.map (function
                                | Norec(_, Fun _) | Norec(_, Fun_v _) -> false
                                | _ -> true) body)
  | _ -> false

let known_calls (env:(def*p*deq list) env) (deqs:deq list) : bool =
  List.fold_left (&&) true
                 (List.map (function
                             | Norec(_,Fun(f,_))
                             | Norec(_,Fun_v(f,_,_))-> (match env_fetch env f with
                                                     | Some _ -> true
                                                     | None -> false)
                             | _ -> true) deqs)
                    
let rec get_next_node (env:(def*p*deq list) env)
                      (todo:(def*p*deq list) env) :
  def*p*deq list =
  let next = ref "" in
  Hashtbl.iter (fun x (_,_,y) -> if known_calls env y then
                                     next := x) todo;
  let ret = Hashtbl.find todo !next in
  Hashtbl.remove todo !next;
  ret

let rec rename_var pref (var:var) : var =
  match var with
  | Var id -> Var (fresh_prefix pref id)
  | Field(v,e) -> Field(rename_var pref v,e)
  | Index(id,e) -> Index(fresh_prefix pref id,e)
  | Range(id,ei,ef) -> Range(fresh_prefix pref id,ei,ef)
  | Slice(id,l) -> Slice(fresh_prefix pref id,l)
                            
let rec rename_expr pref (e:expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar(v) -> ExpVar (rename_var pref v)
  | Tuple l -> Tuple (List.map (rename_expr pref) l)
  | Not e -> Not (rename_expr pref e)
  | Shift(op,e,n) -> Shift(op,rename_expr pref e,n)
  | Log(op,x,y) -> Log(op,rename_expr pref x,rename_expr pref y)
  | Arith(op,x,y) -> Arith(op,rename_expr pref x,rename_expr pref y)
  | Fun(id,l) -> Fun(id,List.map (rename_expr pref) l)
  | Fun_v(id,n,l) -> Fun_v(id,n,List.map (rename_expr pref) l)
  | _ -> e
    
let rec rename_deqs pref (deqs:deq list) : deq list =
  List.map (fun x -> match x with
                     | Norec(p,e) ->
                        Norec(List.map (rename_var pref) p,rename_expr pref e)
                     | Rec(id,ei,ef,d) ->
                        Rec(id,ei,ef,rename_deqs pref d)) deqs
           
let inline_deqs env (node:def) (deqs: deq list) (conf:config): p*deq list =
  let cpt = ref 0 in
  let add_vars  = ref [] in
  let body =
    List.flatten @@
      List.map
        (fun x ->
         match x with
         | Norec (pat,e) ->
            ( match e with
              | Fun(f,l) ->
                 let (def,vars,body) = Hashtbl.find env f.name in
                 let p_in = def.p_in in
                 let p_out = def.p_out in

                 if (not (is_noinline def)) ||  conf.inline_all
                   (* && (should_inline node def) *)then
                   begin
                     let pref = def.id.name ^ ((string_of_int !cpt) ^ "_") in
                     incr cpt;
                     
                     add_vars :=
                       !add_vars @
                         (List.map (fun ((id,typ),ck) -> (fresh_prefix pref id,typ),ck) p_in) @
                           (List.map (fun ((id,typ),ck) -> (fresh_prefix pref id,typ),ck) p_out) @
                             (List.map (fun ((id,typ),ck) -> (fresh_prefix pref id,typ),ck) vars);
                     
                     let pat_in  = List.map (fun ((id,typ),ck) -> Var(fresh_prefix pref id)) p_in in
                     let pat_out = Tuple(List.map (fun ((id,typ),ck) ->
                                                   ExpVar(Var (fresh_prefix pref id))) p_out) in
                     
                     let body = rename_deqs pref body in
                     
                     (Norec(pat_in,Tuple(l))) :: body @ [ Norec(pat,pat_out) ]
                   end
                 else
                   [ Norec (pat,e) ]
              | _ -> [Norec (pat,e)])
         | Rec _ -> raise (Not_implemented "inline Rec")) deqs in
  !add_vars,body


(* (\* Returns true if the node can be inlined now. ie: *)
(*     - is not already inlined *)
(*     - it doesn't have the attribute "no_inline" *)
(*     - it doesn't contain any function call, or *)
(*     - every function call it contains is to a node "no_inline" *\) *)
(* let can_inline env (node:def) : bool = *)
(*   (\* Is not already inlined *\) *)
(*   (not (Hashtbl.find env node.id.name)) && *)
(*     (\* Is not "no_inline" *\) *)
(*     (not is_noinline node) && *)
(*       (\* Doesn't contain any call, or calls to "no_inline" *\) *)
(*       (is_call_free env node) *)

      
(* let rec _inline (prog:prog) (conf:config) inlined : prog = *)
  
(*   let env = Hashtbl.create 20 in *)
(*   List.iter (fun x -> Hashtbl.add env x.ident.name x) prog.nodes; *)

(*   (\* If there is a node that can be inlined *\) *)
(*   if List.exists (can_inline env inlined) prog.nodes then *)
(*     (\* find the node to inline *\) *)
(*     let to_inline = List.find (can_inline env) prog.nodes in *)
(*     (\* inline it *\) *)
(*     let prog' = do_inline env prog to_inline in *)
(*     (\* add it to the hash of inlined nodes *\) *)
(*     Hashtbl.replace inlined to_inline.id.name true; *)
(*     (\* continue inlining *\) *)
(*     _inline prog' conf inlined *)
(*   else *)
(*     (\* inlining is done, return the prog *\) *)
(*     prog *)

(* let inline (prog:prog) (conf:config) : prog = *)
(*   (\* Hashtbl containing the inlining status of each node: *)
(*      false if it is not already inlined, true if it is *\) *)
(*   let inlined = Hashtbl.create 20 in *)
(*   List.iter (fun x -> Hashtbl.add inlined x.id.name false) prog.nodes; *)
(*   (\* The last node is the entry point, it wouldn't make sense to try inline it *\) *)
(*   Hashtbl.replace inlined (last prog.nodes).id.name true; *)

(*   (\* And now, perform the inlining *\) *)
(*   _inline prog conf inlined *)
  

let inline (prog:prog) (conf:config) : prog =
  
  let env  = Hashtbl.create 20 in
  List.iter (fun x -> match x.node with
                      | Single(vars,body) ->
                         env_add env x.id (x,vars,body)
                      | _ -> ())
            (List.filter is_call_free prog.nodes);
  let todo = Hashtbl.create 20 in
  List.iter (fun x -> match x.node with
              | Single(vars,body) ->
                 env_add todo x.id (x,vars,body)
              | _ -> ())
            (List.filter (fun x -> not @@ is_call_free x) prog.nodes);
  while Hashtbl.length todo <> 0  do
    let (node,vars,body) = get_next_node env todo in
    let (vars',body') = inline_deqs env node body conf in
    let new_vars =  vars @ vars' in
    env_add env node.id ({ node with node = Single(new_vars,body') } ,new_vars,body')
  done;
  let prog = List.map (fun x ->
                       match x.node with
                       | Single _ -> (
                         match env_fetch env x.id with
                         | Some (node,vars,body) -> node
                         | None -> raise (Error ("Not found: " ^ x.id.name)))
                       | _ -> x)
                      prog.nodes in
  let no_inlined = List.filter (fun x -> List.exists (function
                                                | No_inline -> true
                                                | Inline    -> false) x.opt) prog in
  let main = List.nth prog (List.length prog - 1) in
  if List.exists (fun x -> x = main) no_inlined then
    { nodes = no_inlined }
  else
    { nodes = no_inlined @ [ main ] }
                      
