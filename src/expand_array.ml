open Usuba_AST
open Utils
       
let expand_var_array id size =
  List.map (fun x -> Var x) (gen_list_0 id size)
                    
let rec rewrite_expr loc_env env_var (i:int) (e:expr) : expr =
  let rec_call = rewrite_expr loc_env env_var i in
  match e with
  | Const _ -> e
  | ExpVar(Field _) -> e
  | ExpVar(Var v) -> ( match env_fetch loc_env v with
                       | Some n -> Const n
                       | None ->
                          match env_fetch env_var v with
                          | Some size -> Tuple(List.map
                                                 (fun x -> ExpVar x)
                                                 (expand_var_array v size))
                          | None -> ExpVar(Var v))
  | ExpVar(Index(v,idx)) -> let n = eval_arith loc_env idx in
                            ExpVar(Var(v ^ (string_of_int n)))
  | ExpVar(Range(v,ei,ef)) ->
     ExpVar(Range(v, Const_e(eval_arith loc_env ei),
                  Const_e(eval_arith loc_env ef)))
  | Tuple l -> Tuple (List.map rec_call l)
  | Not e -> Not (rec_call e)
  | Log(op,x,y) -> Log(op,rec_call x,rec_call y)
  | Arith(op,x,y) -> let x' = rec_call x in
                     let y' = rec_call y in
                     ( match x',y' with
                       | Const a, Const b ->
                          (match op with
                           | Add -> Const (a + b)
                           | Mul -> Const (a * b)
                           | Sub -> Const (a - b)
                           | Div -> Const (a / b)
                           | Mod -> Const (a mod b))
                       | _ -> Arith(op,rec_call x,rec_call y) )
  | Shift(op,e,n) -> Shift(op,rec_call e, Const_e(eval_arith loc_env n))
  | Fun(f,l) -> Fun(f,List.map rec_call l)
  | Fun_v(f,e,l) -> let idx = eval_arith loc_env e in
                    let f' = f ^ "'" ^ (string_of_int idx) in
                    rec_call (Fun(f',l))
  | Fby _ -> raise (Not_implemented (format_exn __LOC__ "FBY"))
  | Nop -> Nop
             

let rewrite_pat env env_var (pat:var list) : var list =
  let rec aux x = match x with
    | Var v -> (match env_fetch env_var v with
                | Some size -> expand_var_array v size
                | None -> [ Var v ])
    | Field(lasgn,i) -> [ Field(List.nth (aux lasgn) 0,i) ]
    | Index(id,e) -> let n = eval_arith env e in
                     [ Var(id ^ (string_of_int n)) ] 
    | Range(id,ei,ef) -> [ Range(id,Const_e(eval_arith env ei),
                                 Const_e(eval_arith env ef))] in
  List.flatten @@ List.map aux pat
           
let rewrite_rec env_var (iterator:ident) (startr:arith_expr) (endr:arith_expr)
                (pat:var list) (e:expr) : deq list =
  let env = Hashtbl.create 10 in
  let i_init = eval_arith env startr in
  let i_end  = eval_arith env endr in
  let body = ref [] in
  for i = i_init to i_end do
    env_add env iterator i;
    let pat_i  = rewrite_pat env env_var pat in
    let expr_i = rewrite_expr env env_var i e in
    body := !body @ [ Norec(pat_i, expr_i) ]
  done;
  !body

let rec rewrite_p p =
  List.flatten @@
    List.map
      (fun (id,typ,ck) ->
        match typ with
        | Bool -> [ (id,Bool,ck) ]
        | Int n -> [ (id, Int n, ck) ]
        | Nat -> [ (id, Nat, ck) ]
        | Array (typ_in, Const_e size) ->
           List.map (fun x -> (x,typ_in,ck)) (gen_list_0 id size)
        | _ -> raise (Error (format_exn __LOC__ "Invalid array size"))) p

let make_env p_in p_out vars =
  let env = Hashtbl.create 10 in
  let f = List.map (fun (id,typ,ck) ->
               match typ with
               | Array(in_typ,Const_e size) -> env_add env id size
               | _ -> ()) in
  let _ = f p_in in
  let _ = f p_out in
  let _ = f vars in
  env
  
      
let rewrite_deqs p_in p_out vars (deqs:deq list) : deq list =
  let env_var = make_env p_in p_out vars in
  List.flatten @@
    List.map (fun x -> match x with
                       | Rec(i,startr,endr,pat,expr) ->
                          rewrite_rec env_var i startr endr pat expr
                       | Norec(vars,e) ->
                          [ Norec(rewrite_pat (Hashtbl.create 1) env_var vars,
                                  rewrite_expr (Hashtbl.create 1) env_var 0 e) ]) deqs

let expand_array (prog: prog) : prog =
  let prog' = (* expansion of the arrays of nodes *)
    List.flatten @@
      List.map (fun x -> match x with
                         | Multiple(id,p_in,p_out,nodes) ->
                            List.mapi (fun i (vars,body) ->
                                       Single(id ^ "'" ^ (string_of_int i),
                                              p_in,p_out,vars,body)) nodes
                         | _ -> [ x ] ) prog in
  List.map (fun def -> match def with
                       | Single(id,p_in,p_out,vars,body) ->
                          Single(id,rewrite_p p_in,rewrite_p p_out,
                                 rewrite_p vars,rewrite_deqs p_in p_out vars body)
                       | _ -> def) prog'
           
