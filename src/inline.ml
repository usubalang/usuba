open Usuba_AST
open Utils

       
let is_call_free (def:def) : bool =
  match def.node with
  | Single(_,body) ->
     List.fold_left (&&) true
                    (List.map (function
                                | Norec(_, Fun _) | Norec(_, Fun_v _) -> false
                                | _ -> true) body)
  | _ -> false

let known_calls (env:(ident,ident*p*p*p*deq list) Hashtbl.t) (deqs:deq list) : bool =
  List.fold_left (&&) true
                 (List.map (function
                             | Norec(_,Fun(f,_))
                             | Norec(_,Fun_v(f,_,_))-> (match env_fetch env f with
                                                     | Some _ -> true
                                                     | None -> false)
                             | _ -> true) deqs)
                    
let rec get_next_node (env:(ident,ident*p*p*p*deq list) Hashtbl.t)
                      (todo:(ident,ident*p*p*p*deq list) Hashtbl.t) :
  ident*p*p*p*deq list =
  let next = ref "" in
  Hashtbl.iter (fun x (_,_,_,_,y) -> if known_calls env y then
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
                 let (id,p_in,p_out,vars,body) = Hashtbl.find env f in
                 let pref = id ^ (string_of_int !cpt) ^ "_" in
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
              | _ -> [Norec (pat,e)])
         | Rec _ -> raise (Not_implemented "inline Rec")) deqs in
  !add_vars,body


let inline (prog:prog) : prog =
  let env  = Hashtbl.create 20 in
  List.iter (function
              | { id=id;p_in=p_in;p_out=p_out;opt=_;
                  node=Single(vars,body) } ->
                 env_add env id (id,p_in,p_out,vars,body)
              | _ -> ())
            (List.filter is_call_free prog.nodes);
  let todo = Hashtbl.create 20 in
  List.iter (function 
              | { id=id;p_in=p_in;p_out=p_out;opt=_;
                  node=Single(vars,body) } ->
                 env_add todo id (id,p_in,p_out,vars,body)
              | _ -> ())
            (List.filter (fun x -> not @@ is_call_free x) prog.nodes);
  while Hashtbl.length todo <> 0  do
    let (id,p_in,p_out,vars,body) = get_next_node env todo in
    let (vars',body') = inline_deqs env body in
    env_add env id (id,p_in,p_out,vars@vars',body')
  done;
  let prog = List.map (fun x ->
                       match x.node with
                       | Single _ -> (
                         match env_fetch env x.id with
                         | Some (id,p_in,p_out,vars,body) ->
                            { x with id=id;p_in=p_in;p_out=p_out;
                                     node=Single(vars,body) }
                         | None -> raise (Error ("Not found: " ^ x.id)))
                       | _ -> x)
                      prog.nodes in
  { nodes = [List.nth prog (List.length prog - 1) ] }
                      
