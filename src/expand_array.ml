open Usuba_AST
open Utils
       

let rec rewrite_expr loc_env (i:int) (e:expr) : expr =
  let rec_call = rewrite_expr loc_env i in
  match e with
  | Const _ -> e
  | Field _ -> e
  | Var v -> ( match env_fetch loc_env v with
               | Some n -> Const n
               | None -> e )
  | Access(v,idx) -> Access (v, Const_e(eval_arith loc_env idx))
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
             

let rewrite_pat env (pat:pat) : pat =
  let rec aux x = match x with
    | Ident _ -> x
    | Dotted(lasgn,i) -> Dotted(aux lasgn,i)
    | Index(id,e) -> Index(id,Const_e(eval_arith env e)) in
  List.map aux pat
           
let rewrite_rec (iterator:ident) (startr:arith_expr) (endr:arith_expr)
                (pat:pat) (e:expr) : deq list =
  let env = Hashtbl.create 10 in
  let i_init = eval_arith env startr in
  let i_end  = eval_arith env endr in
  let body = ref [] in
  for i = i_init to i_end do
    env_add env iterator i;
    let pat_i  = rewrite_pat env pat in
    let expr_i = rewrite_expr env i e in
    body := !body @ [ Norec(pat_i, expr_i) ]
  done;
  !body
                     
                     
let rewrite_deqs (deqs:deq list) : deq list =
  List.flatten @@
    List.map (fun x -> match x with
                       | Rec(i,startr,endr,pat,expr) ->
                          rewrite_rec i startr endr pat expr
                       | _ -> [x]) deqs

              
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
                          Single(id,p_in,p_out,vars,rewrite_deqs body)
                       | _ -> def) prog'
           
