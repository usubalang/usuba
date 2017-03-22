open Usuba_AST
open Utils
       
exception Error of string

let prev_node : def list ref = ref []
let add_vars : p ref = ref []
                     
let rec rewrite_expr env_var (e: expr) : expr =
  match e with
  | Var v -> (match env_fetch env_var v with
              | Some x -> Tuple(expand_intn_expr v x)
              | _ -> Var v)
  | Fun_i(f,i,l) -> Fun(f^(string_of_int i),List.map (rewrite_expr env_var) l)
  | Access(id,i) -> Var(id^(string_of_int i))
  | Field(e,i)   -> Field(rewrite_expr env_var e,i)
  | Tuple l -> Tuple(List.map (rewrite_expr env_var) l)
  | Log(o,x,y) -> Log(o,rewrite_expr env_var x, rewrite_expr env_var y)
  | Arith(o,x,y) -> Arith(o,rewrite_expr env_var x, rewrite_expr env_var y)
  | Not e -> Not(rewrite_expr env_var e)
  | Fun(f,l) -> Fun(f,List.map (rewrite_expr env_var) l)
  | Mux(e,c,i) -> Mux(rewrite_expr env_var e,c,i)
  | Fby(ei,ef,i) -> Fby(rewrite_expr env_var ei, rewrite_expr env_var ef, i)
  | _ -> e

           
let rec rewrite_pat (pat:pat) env_var : pat =
  let rec no_arr = function
    | Ident id -> Ident id
    | Dotted(l,n) -> Dotted(no_arr l,n)
    | Index(id,n) -> Ident(id ^ (string_of_int n)) in
  let rec aux = function
    | Ident id -> (match env_fetch env_var id with
                   | Some n -> expand_intn_pat id n
                   | _ -> [ Ident id ] )
    | Dotted(left_asgn,n) -> [ Dotted(no_arr left_asgn,n) ]
    | Index(id,n) -> [ Ident (id ^ (string_of_int n)) ]
  in
  List.flatten (List.map aux pat)

let make_node_i (node: def) (i: int) env_var : def * ident =
  let rec replace_i (e: expr) : expr =
    match e with 
    | Fun_v(f,v,l) -> rewrite_expr env_var (Fun_i(f,i,List.map replace_i l))
    | Fun_i(f,i,l) -> rewrite_expr env_var (Fun_i(f,i,List.map replace_i l))
    | Fun(f,l) -> rewrite_expr env_var (Fun(f,List.map replace_i l))
    | Tuple l -> rewrite_expr env_var (Tuple (List.map replace_i l))
    | Log(o,x,y) -> rewrite_expr env_var (Log(o,replace_i x,replace_i y))
    | Arith(o,x,y) -> rewrite_expr env_var (Arith(o,replace_i x,replace_i y))
    | Not e -> rewrite_expr env_var (Not (replace_i e))
    | Mux(e,c,i) -> rewrite_expr env_var (Mux(replace_i e,c,i))
    | Fby(ei,ef,i) -> rewrite_expr env_var (Fby(replace_i ei,replace_i ef,i))
    | _ -> rewrite_expr env_var e in
  match node with
  | Multiple _ -> raise ( Error ("Illegal node array."))
  | MultiplePerm _ -> raise ( Error ("Illegal node array."))
  | Perm _ -> raise ( Error ("Illegal permutation."))
  | Table _ -> raise ( Error ("Illegal table."))
  | MultipleTable _ -> raise ( Error ("Illegal multiple tables."))
  | Single(id,p_in,p_out,vars,body) ->
     let id = id ^ (string_of_int i) in
     let body = List.map (fun (x,y) -> (x,replace_i y)) body in
     (Single(id,p_in,p_out,vars,body),id)
  | Temporary(id,p_in,p_out,vars,body) ->
     let id = id ^ (string_of_int i) in
     let body = List.map (fun (x,y) -> (x,replace_i y)) body in
     (Single(id,p_in,p_out,vars,body),id)
       
       
let rewrite_fill_i (pat:pat) ((id:ident),(n:int),(l:expr)) env env_var : deq =
  let node = (match env_fetch env id with
              | Some x -> x
              | None -> raise (Error ("Undeclared node " ^ id))) in
  let return : deq ref = ref [(List.map
                                 (fun x ->
                                  match x with
                                  | Ident id -> Ident (id ^ "1")
                                  | _ -> raise (Error "")) pat,
                               rewrite_expr env_var l)] in
  for i = 2 to n do
    let (node_i,id_i) = make_node_i node (i-1) env_var in
    prev_node := !prev_node @ [node_i];
    return := !return @ [(List.map (fun x -> match x with
                                             | Ident id -> Ident (id^(string_of_int i))
                                             | _ -> x) pat,
                          Fun(id_i,(List.map
                                      (fun x -> match x with
                                                | Ident v -> Var (v ^ (string_of_int (i-1)))
                                                | _ -> raise (Error "")) pat)))]
  done;
  !return

let rewrite_fill (pat:pat) ((id:ident),(n:int),(l:expr)) env env_var : deq =
  let return : deq ref = ref [(List.map
                                 (fun x ->
                                  match x with
                                  | Ident id -> Ident (id ^ "1")
                                  | _ -> raise (Error "")) pat,
                               rewrite_expr env_var l)] in
  for i = 2 to n do
    return := !return @ [(List.map (fun x -> match x with
                                             | Ident id -> Ident (id^(string_of_int i))
                                             | _ -> x) pat,
                          Fun(id,(List.map
                                    (fun x -> match x with
                                              | Ident v -> Var (v ^ (string_of_int (i-1)))
                                              | _ -> raise (Error "")) pat)))]
  done;
  !return
   
   
let rec rewrite_deq (deq: deq) env env_var : deq =
  match deq with
  | [] -> []
  | (pat,expr)::tl -> (match expr with
                       | Fill_i(id,n,l) -> rewrite_fill_i (rewrite_pat pat (Hashtbl.create 1))
                                                          (id,n,l) env env_var
                       | Fill(id,n,l) -> rewrite_fill (rewrite_pat pat (Hashtbl.create 1))
                                                      (id,n,l) env env_var
                       | _ -> [(rewrite_pat pat env_var,rewrite_expr env_var expr)])
                      @ (rewrite_deq tl env env_var)

let rec rewrite_p p =
  match p with
  | [] -> []
  | (id,typ,ck)::tl ->
     (match typ with
      | Bool -> [ (id,Bool,ck) ]
      | Int n -> [ (id, Int n, ck) ]
      | Array (typ_in, size) -> List.map (fun x -> (x,typ_in,ck)) (gen_list id size)
     ) @ (rewrite_p tl)

let add_env_p env p =
  let _ = List.map (fun (x,typ,_) -> match typ with
                                     | Array(typ',n) -> env_add env x n
                                     | _ -> ()) p in
  ()
           
let rewrite_def env (def: def) : def list =
  prev_node := [];
  let env_var = Hashtbl.create 10 in
  let ret = (
    match def with
    | Single(id,p_in,p_out,vars,body) ->
       let p_in' = rewrite_p p_in in
       let p_out' = rewrite_p p_out in
       let vars' = rewrite_p vars in
       add_env_p env_var p_in;
       add_env_p env_var p_out;
       add_env_p env_var vars;
       let body = rewrite_deq body env env_var in
       let return =  Single(id,p_in', p_out', vars' @ !add_vars,body) in
       env_add env id return;
       return
    | Temporary(id,p_in,p_out,vars,body) ->
       let p_in' = rewrite_p p_in in
       let p_out' = rewrite_p p_out in
       let vars' = rewrite_p vars in
       add_env_p env_var p_in;
       add_env_p env_var p_out;
       add_env_p env_var vars;
       let body = rewrite_deq body env env_var in
       let return =  Single(id,p_in', p_out', vars' @ !add_vars,body) in
       env_add env id return;
       return
    | Perm _ -> raise (Error "I have no idea how we ended up in that case")
    | Multiple _ -> raise (Invalid_AST "Arrays should have been cleaned by now")
    | Table _ -> raise (Invalid_AST "Tables should have been cleaned by now")
    | MultipleTable _ -> raise ( Invalid_AST "Illegal multiple tables.")
    | MultiplePerm _ -> raise (Invalid_AST "Perm Arrays should have been cleaned by now")) in
  !prev_node @ [ret]

let expand_array (ident, p_in, p_out, nodes) =
  let rec aux i nodes =
    match nodes with
    | [] -> []
    | (vars,body)::tl -> (Single(ident^(string_of_int i),p_in,p_out,vars,body))
                         :: (aux (i+1) tl)
  in aux 1 nodes

       
let rec rewrite_defs (l: def list) env : def list =
  match l with
  | [] -> []
  | hd :: tl ->
     match hd with
     | Single _ -> let head = rewrite_def env hd in
                   head @ (rewrite_defs tl env)
     | Temporary _ -> let _ = rewrite_def env hd in
                    rewrite_defs tl env
     | Multiple(id,p_in,p_out,nodes) -> (List.flatten
                                           (List.map (rewrite_def env)
                                                     (expand_array (id,p_in,p_out,nodes))))
                                        @ (rewrite_defs tl env)
     | Perm _ -> hd :: (rewrite_defs tl env)
     | MultiplePerm _ -> hd :: (rewrite_defs tl env)
     | Table _ -> hd :: (rewrite_defs tl env)
     | MultipleTable _ -> hd :: (rewrite_defs tl env)
            
                       
let expand_array (p: prog) : prog =
  let env = Hashtbl.create 10 in
  rewrite_defs p env
               
