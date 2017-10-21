open Usuba_AST
open Utils

let rec contains_const (e:expr) : bool =
  match e with
  | Const _ -> true
  | ExpVar _ -> false
  | Tuple l -> List.exists (fun x -> x) (List.map contains_const l)
  | Not e -> contains_const e
  | Shift(_,e,_) -> contains_const e
  | Log(_,x,y)   -> contains_const x || contains_const y
  | Arith(_,x,y) -> contains_const x || contains_const y
  | Fun(_,l)     -> List.exists (fun x -> x) (List.map contains_const l)
  | Fun_v(_,_,l) -> List.exists (fun x -> x) (List.map contains_const l)
  | Fby(x,y,_) -> contains_const x || contains_const y
  | Nop -> false
  | _ -> raise (Not_implemented (Usuba_print.expr_to_str e))
                                                     
let get_var_size env (v:ident) : int =
  match env_fetch env v with
  | None -> raise (Undeclared v)
  | Some typ -> match typ with
                | Bool -> 1
                | Int n -> n
                | _ -> raise (Error "Invalid type")

let rec get_expr_size env (e:expr) : int =
  match e with
  | Const _ -> raise (Error "Can't guess size")
  | ExpVar(Field(_,_)) -> 1
  | ExpVar(Var v) -> get_var_size env v
  | ExpVar _ -> raise (Error "Invalid var")
  | Tuple l -> List.fold_left (+) 0 (List.map (get_expr_size env) l)
  | Not e -> get_expr_size env e
  | Shift(_,e,_) -> get_expr_size env e
  | Log(_,x,y)   -> (try get_expr_size env x with Error _ -> get_expr_size env y)
  | Arith(_,x,y) -> (try get_expr_size env x with Error _ -> get_expr_size env y)
  | Fun(_,l)     -> List.fold_left (+) 0 (List.map (get_expr_size env) l)
  | Fun_v(_,_,l) -> List.fold_left (+) 0 (List.map (get_expr_size env) l)
  | Fby(x,_,_) -> get_expr_size env x
  | Nop -> raise (Error "Nop size unknown")
  | _ -> raise (Not_implemented (Usuba_print.expr_to_str e))
  
                             
let expand_const (size:int) (n:int) : expr =
  let rec make_0_list n acc =
    if n > 0 then make_0_list (n-1) (Const 0 :: acc)
    else acc in
  let rec dec_to_binlist n =
    if n > 0 then
      (Const (n mod 2))::(dec_to_binlist (n/2))
    else [] in
  let l = dec_to_binlist n in
  let len = List.length l in
  let diff = size - len in
  Tuple((make_0_list diff []) @ l)

let rec expand_list env (size:int) (l:expr list) : expr list =
  if List.exists (function Const _ -> true | _ -> false) l then
    let sizes =
      List.fold_left
        (+) 0 (List.map (fun x ->
                         try get_expr_size env x
                         with Error _ -> 0) l) in
    List.map (fun e -> match e with
                       | Const n -> expand_const (size-sizes) n
                       | _ -> e) l
  else
    List.map (fun x -> expand_expr env (get_expr_size env x) x) l
                                                     
and expand_expr env (size:int) (e:expr) : expr =
  let rec_call = expand_expr env size in
  match e with
  | Const x  -> expand_const size x
  | ExpVar _ -> e
  | Not e    -> Not (rec_call e)
  | Shift(op,x,y) -> Shift(op,rec_call x,y)
  | Log(op,x,y)   -> Log(op,rec_call x,rec_call y)
  | Arith(op,x,y) -> Arith(op,rec_call x,rec_call y)
  | Fun(f,l) -> Fun(f,expand_list env size l)
  | Fun_v(f,ei,l) -> Fun_v(f,ei,expand_list env size l)
  | Tuple l -> Tuple (expand_list env size l)
  | _ -> raise (Not_implemented "")
                         
let expand_deqs env (deq:deq) : deq =
  match deq with
  | Norec(p,e) ->
     if contains_const e then
       let size =
         List.fold_left (+) 0 (List.map (function
                                          | Var v -> get_var_size env v
                                          | Field _ -> 1
                                          | _ -> raise (Error "Invalid var")) p) in
       Norec(p,expand_expr env size e)
     else
       deq
  | _ -> deq
             
let expand_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let env = Hashtbl.create 100 in
     List.iter (fun ((id,typ),_) -> env_add env id typ) def.p_in;
     List.iter (fun ((id,typ),_) -> env_add env id typ) def.p_out;
     List.iter (fun ((id,typ),_) -> env_add env id typ) vars;
     { def with node  = Single(vars,List.map (expand_deqs env) body) }
  | _ -> def                     
       
let expand_prog (prog:prog) : prog =
  { nodes = List.map expand_def prog.nodes }
