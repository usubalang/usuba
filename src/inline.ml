open Usuba_AST
open Utils

let rec has_no_inner_deps (vars:p) (body:deq list) : bool =
  let env = Hashtbl.create 100 in
  List.iter (fun (id,_,_) -> env_add env id true) vars;
  not (List.exists (function
                     | Norec(_,e) -> List.exists
                                       (fun x ->
                                        match env_fetch env (get_var_name x) with
                                        | Some _ -> true
                                        | None -> false) (get_used_vars e)
                     | _ -> false) body)
       
let should_inline (def:def) : bool =
  match def.node with
  | Single(vars,body) ->
     has_no_inner_deps vars body
  | _ -> false
           
let is_call_free (def:def) : bool =
  match def.node with
  | Single(_,body) ->
     List.fold_left (&&) true
                    (List.map (function
                                | Norec(_, Fun _) | Norec(_, Fun_v _) -> false
                                | _ -> true) body)
  | _ -> false

let known_calls (env:(ident,def*p*deq list) Hashtbl.t) (deqs:deq list) : bool =
  List.fold_left (&&) true
                 (List.map (function
                             | Norec(_,Fun(f,_))
                             | Norec(_,Fun_v(f,_,_))-> (match env_fetch env f with
                                                     | Some _ -> true
                                                     | None -> false)
                             | _ -> true) deqs)
                    
let rec get_next_node (env:(ident,def*p*deq list) Hashtbl.t)
                      (todo:(ident,def*p*deq list) Hashtbl.t) :
  def*p*deq list =
  let next = ref "" in
  Hashtbl.iter (fun x (_,_,y) -> if known_calls env y then
                                     next := x) todo;
  let ret = Hashtbl.find todo !next in
  Hashtbl.remove todo !next;
  ret

let rec rename_var pref (var:var) : var =
  match var with
  | Var id -> Var (pref ^ id)
  | Field(v,e) -> Field(rename_var pref v,e)
  | Index(id,e) -> Index(pref ^ id,e)
  | Range(id,ei,ef) -> Range(pref ^ id,ei,ef)
  | Slice(id,l) -> Slice(pref ^ id,l)
                            
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
    
let rename_deqs pref (deqs:deq list) : deq list =
  List.map (fun x -> match x with
                     | Norec(p,e) ->
                        Norec(List.map (rename_var pref) p,rename_expr pref e)
                     | Rec(id,ei,ef,p,e) ->
                        Rec(id,ei,ef,List.map (rename_var pref) p,
                            rename_expr pref e)) deqs
           
let inline_deqs env (deqs: deq list) : p*deq list =
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
                 let (def,vars,body) = Hashtbl.find env f in
                 let p_in = def.p_in in
                 let p_out = def.p_out in

                 if not (is_noinline def) then
                   begin
                     let pref = def.id ^ (string_of_int !cpt) ^ "_" in
                     incr cpt;
                     
                     add_vars :=
                       !add_vars @
                         (List.map (fun (id,typ,ck) -> pref^id,typ,ck) p_in) @
                           (List.map (fun (id,typ,ck) -> pref^id,typ,ck) p_out) @
                             (List.map (fun (id,typ,ck) -> pref^id,typ,ck) vars);
                     
                     let pat_in  = List.map (fun (id,typ,ck) -> Var(pref ^ id)) p_in in
                     let pat_out = Tuple(List.map (fun (id,typ,ck) ->
                                                   ExpVar(Var (pref ^ id))) p_out) in
                     
                     let body = rename_deqs pref body in
                     
                     (Norec(pat_in,Tuple(l))) :: body @ [ Norec(pat,pat_out) ]
                   end
                 else
                   [ Norec (pat,e) ]
              | _ -> [Norec (pat,e)])
         | Rec _ -> raise (Not_implemented "inline Rec")) deqs in
  !add_vars,body


let inline (prog:prog) : prog =

  (* List.iter (fun x -> if should_inline x then *)
  (*                       print_endline ("Should inline: " ^ x.id) *)
  (*                     else print_endline ("Souldn't inline: " ^ x.id)) prog.nodes; *)
  
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
    let (vars',body') = inline_deqs env body in
    let new_vars =  vars @ vars' in
    env_add env node.id ({ node with node = Single(new_vars,body') } ,new_vars,body')
  done;
  let prog = List.map (fun x ->
                       match x.node with
                       | Single _ -> (
                         match env_fetch env x.id with
                         | Some (node,vars,body) -> node
                         | None -> raise (Error ("Not found: " ^ x.id)))
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
                      
