open Usuba_AST
open Utils
       
exception Error of string

let prev_node : def list ref = ref []
let add_vars : p ref = ref []
                     
let rec rewrite_expr (e: expr) : expr =
  match e with
  | Fun_i(f,i,l) -> Fun(f^(string_of_int i),List.map rewrite_expr l)
  | Access(id,i) -> Var(id^(string_of_int i))
  | Field(e,i)   -> Field(rewrite_expr e,i)
  | Tuple l -> Tuple(List.map rewrite_expr l)
  | Op(o,l) -> Op(o,List.map rewrite_expr l)
  | Fun(f,l) -> Fun(f,List.map rewrite_expr l)
  | Mux(e,c,i) -> Mux(rewrite_expr e,c,i)
  | Fby(ei,ef,i) -> Fby(rewrite_expr ei, rewrite_expr ef, i)
  | _ -> e

           
let rec rewrite_pat (pat:pat) : pat =
  let rec aux = function
    | Ident id -> Ident id
    | Dotted(left_asgn,n) -> Dotted(aux left_asgn,n)
    | Index(id,n) -> Ident (id ^ (string_of_int n))
  in
  match pat with
  | [] -> []
  | hd :: tl -> (aux hd) :: (rewrite_pat tl)

let make_node_i (node: def) (i: int) : def * ident =
  let rec replace_i (e: expr) : expr =
    match e with 
    | Fun_v(f,v,l) -> rewrite_expr(Fun_i(f,i,List.map replace_i l))
    | Fun_i(f,i,l) -> rewrite_expr(Fun_i(f,i,List.map replace_i l))
    | Tuple l -> rewrite_expr(Tuple (List.map replace_i l))
    | Op(o,l) -> rewrite_expr(Op(o,List.map replace_i l))
    | Mux(e,c,i) -> rewrite_expr(Mux(replace_i e,c,i))
    | Fby(ei,ef,i) -> rewrite_expr(Fby(replace_i ei,replace_i ef,i))
    | _ -> rewrite_expr e in
  match node with
  | Multiple _ -> raise ( Error ("Illegal node array."))
  | MultiplePerm _ -> raise ( Error ("Illegal node array."))
  | Perm _ -> raise ( Error ("Illegal permutation."))
  | Table _ -> raise ( Error ("Illegal table."))
  | Single(id,p_in,p_out,vars,body) ->
     let id = id ^ (string_of_int i) in
     let body = List.map (fun (x,y) -> (x,replace_i y)) body in
     (Single(id,p_in,p_out,vars,body),id)
  | Temporary(id,p_in,p_out,vars,body) ->
     let id = id ^ (string_of_int i) in
     let body = List.map (fun (x,y) -> (x,replace_i y)) body in
     (Single(id,p_in,p_out,vars,body),id)
       
       
let rewrite_fill (pat:pat) ((id:ident),(n:int),(l:expr)) env : deq =
  let node = (match env_fetch env id with
              | Some x -> x
              | None -> raise (Error ("Undeclared node " ^ id))) in
  let return : deq ref = ref [(List.map
                                 (fun x ->
                                  match x with
                                  | Ident id -> Ident (id ^ "1")
                                  | _ -> raise (Error "")) pat,
                               rewrite_expr l)] in
  for i = 2 to n do
    let (node_i,id_i) = make_node_i node (i-1) in
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
   
   
let rec rewrite_deq (deq: deq) env : deq =
  match deq with
  | [] -> []
  | (pat,expr)::tl -> (match expr with
                       | Fill_i(id,n,l) -> rewrite_fill (rewrite_pat pat) (id,n,l) env
                       | _ -> [(rewrite_pat pat,rewrite_expr expr)]) @ (rewrite_deq tl env)

let rec rewrite_p p =
  match p with
  | [] -> []
  | (id,typ,ck)::tl ->
     (match typ with
      | Bool -> [ (id,Bool,ck) ]
      | Int n -> [ (id, Int n, ck) ]
      | Array (typ_in, size) -> List.map (fun x -> (x,typ_in,ck)) (gen_list id size)
     ) @ (rewrite_p tl)
                                                   
let rewrite_def env (def: def) : def list =
  prev_node := [];
  let ret = (
    match def with
    | Single(id,p_in,p_out,vars,body) ->
       let p_in' = rewrite_p p_in in
       let p_out' = rewrite_p p_out in
       let vars' = rewrite_p vars in
       let body = rewrite_deq body env in
       let return =  Single(id,p_in', p_out', vars' @ !add_vars,body) in
       env_add env id return;
       return
    | Temporary(id,p_in,p_out,vars,body) ->
       let p_in' = rewrite_p p_in in
       let p_out' = rewrite_p p_out in
       let vars' = rewrite_p vars in
       let body = rewrite_deq body env in
       let return =  Single(id,p_in', p_out', vars' @ !add_vars,body) in
       env_add env id return;
       return
    | Perm _ -> raise (Error "I have no idea how we ended up in that case")
    | Multiple _ -> raise (Invalid_AST "Arrays should have been cleaned by now")
    | Table _ -> raise (Invalid_AST "Tables should have been cleaned by now")
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
     | MultiplePerm(id,p_in,p_out,perms) -> hd :: (rewrite_defs tl env)
     | Table _ -> hd :: (rewrite_defs tl env)
            
                       
let expand_array (p: prog) : prog =
  let env = Hashtbl.create 10 in
  rewrite_defs p env
