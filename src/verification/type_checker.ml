open Usuba_AST
open Utils
open Usuba_print

exception Unsound of string

let rec eval_arith (e:arith_expr) : int =
  match e with
  | Const_e n -> n
  | Var_e id  -> raise (Unsound "Var in typ")
  | Op_e(op,x,y) -> let x' = eval_arith x in
                    let y' = eval_arith y in
                    match op with
                    | Add -> x' + y'
                    | Mul -> x' * y'
                    | Sub -> x' - y'
                    | Div -> x' / y'
                    | Mod -> if x' > 0 then x' mod y' else y' + (x' mod y')

            
let rec type_size (t:typ) : int =
  match t with
  | Bool -> 1
  | Int n -> n
  | Array(typ,e) -> (type_size typ) * (eval_arith e)
  | Nat -> raise (Error "Unexpected Nat")

let rec p_size (p:p) : int =
  let rec typ_size (t:typ) =
    match t with
    | Bool -> 1
    | Int n -> n
    | Array(t,e) -> (typ_size t) * (eval_arith e)
    | _ -> raise (Error "Unexpected Nat") in
  match p with
  | [] -> 0
  | ((_,typ),_) :: tl -> (typ_size typ) + (p_size tl)

                                          
let make_loc_env (p_in:p) (p_out:p) (vars:p): (typ * int) env =
  let env = Hashtbl.create 100 in
  List.iter (fun ((id,typ),_) -> Hashtbl.add env id.name (typ,type_size typ)) p_in;
  List.iter (fun ((id,typ),_) -> Hashtbl.add env id.name (typ,type_size typ)) p_out;
  List.iter (fun ((id,typ),_) -> Hashtbl.add env id.name (typ,type_size typ)) vars;
  env
    
let make_glob_env (prog:prog) =
  let env = Hashtbl.create 100 in
  List.iter (fun def ->
             Hashtbl.add env
                         def.id.name
                         (p_size def.p_in,p_size def.p_out,
                          match def.node with
                          | Single _ | Perm _ | Table _ -> false
                          | Multiple _ | MultiplePerm _ | MultipleTable _ -> true)
            ) prog.nodes;
  env

            
let rec type_arith (idx_env: int env) (e:arith_expr) : bool =
  match e with
  | Const_e n -> true
  | Var_e id  -> ( match env_fetch idx_env id with
                   | Some _ -> true
                   | None   -> false )
  | Op_e(op,x,y) -> type_arith idx_env x && type_arith idx_env y
  

let size_var loc_env (idx_env: int env) (v:var) : int =
  match v with
  | Var v' -> ( match env_fetch loc_env v' with
                | Some(_,size) -> size
                | None -> raise (Unsound (v'.name ^ " undeclared")))
  | Field(v',i) -> ( match v' with
                     | Var v' -> ( match env_fetch loc_env v' with
                                   | Some _ -> 1
                                   | None   -> raise (Unsound (v'.name ^ " undeclared")))
                     | Index(v',_) -> ( match env_fetch loc_env v' with
                                        | Some(typ,_) ->
                                           (match typ with
                                            | Array(Int _,_) -> 1
                                            | _ -> raise
                                                     (Unsound(v'.name ^ " not an int or not an array")))
                                        | None -> raise (Unsound (v'.name ^ " undeclared")))
                     | _ -> raise (Unsound ("Invalid field: " ^ (var_to_str v))))
  | Index(v',e) -> if type_arith idx_env e then
                     match env_fetch loc_env v' with
                     | Some(Array(typ,_),_) -> type_size typ
                     | _ -> raise (Unsound ("Invalid index: not an array: " ^ (var_to_str v)))
                   else raise (Unsound ("Bad arith: " ^ (arith_to_str e)))
  | Range(v',ei,ef) -> if type_arith idx_env ei then
                         if type_arith idx_env ef then
                           match env_fetch loc_env v' with
                           | Some(Array(typ,_),_) -> (type_size typ) *
                                                       (1 + (abs ((eval_arith ei) - (eval_arith ef))))
                           | _ -> raise (Unsound ("Invalid Range: not an array: " ^ (var_to_str v)))
                         else raise (Unsound ("Bad arith: " ^ (arith_to_str ef)))
                       else raise (Unsound ("Bad arith: " ^ (arith_to_str ei)))
  | Slice(v',l) -> if List.for_all (type_arith idx_env) l then
                     match env_fetch loc_env v' with
                     | Some(Array(typ,_),_) -> (type_size typ) * (List.length l)
                     | _ -> raise (Unsound ("Invalid Slice: not an array: " ^ (var_to_str v)))
                   else raise (Unsound ("Invalid slice: " ^ (var_to_str v)))
                    
(* Note: a "Const" has any size. Therefore, this function return a tuple (size,status),
   where status is true if the expr contains a Const, in which case its size doesn't 
   matter *)
let rec type_expr glob_env loc_env idx_env (e:expr) : int * bool =
  let rec_call = type_expr glob_env loc_env idx_env in
  match e with
  | Const _  -> 0, true
  | ExpVar v -> size_var loc_env idx_env v, false
  | Tuple l  -> let l' = List.map rec_call l in
                List.fold_left (fun (sum,stat) (curr,statcurr) ->
                                sum + curr, stat || statcurr) (0,false) l'
  | Not e -> rec_call e
  | Shift(_,e',ae) -> if type_arith idx_env ae then
                       rec_call e'
                      else raise (Unsound ("Invalid arith expr in " ^ (expr_to_str e)))
  | Log(_,x,y) | Arith(_,x,y) ->
        let (s1,b1) = rec_call x in
        let (s2,b2) = rec_call y in
        if b1 then s2,b2
        else if b2 then s1,b1 else
          if s1 = s2 then s1,false
          else raise (Unsound ("Both operands aren't the same size in expr: " ^
                                 (expr_to_str e)))
  | Fun(f,l) -> let (size,b) = List.fold_left
                                 (fun (sum,stat) (curr,statcurr) ->
                                  sum + curr, stat || statcurr) (0,false)
                                 (List.map rec_call l) in
                ( match env_fetch glob_env f with
                  | None -> raise (Unsound (f.name ^ " undeclared"))
                  | Some(s_in,s_out,arr) ->
                     if arr then raise (Unsound ("Simple access to array of fun: " ^
                                                   (expr_to_str e)));
                     if b then s_out,false
                                            else if s_in = size then s_out,false
                                            else raise (Unsound ("Wrong number of arguments " ^
                                                                   (expr_to_str e))))
  | Fun_v(f,i,l) -> if not (type_arith idx_env i) then
                      raise (Unsound ("Invalid arith expr in " ^ (expr_to_str e)));
                    let (size,b) = List.fold_left
                                     (fun (sum,stat) (curr,statcurr) ->
                                      sum + curr, stat || statcurr) (0,false)
                                     (List.map rec_call l) in
                    ( match env_fetch glob_env f with
                      | None -> raise (Unsound (f.name ^ " undeclared"))
                      | Some(s_in,s_out,arr) ->
                         if not arr then raise (Unsound ("Not an array of fun: " ^
                                                           (expr_to_str e)));
                         if b then s_out,false
                         else if s_in = size then s_out,false
                         else raise (Unsound ("Wrong number of arguments " ^
                                                (expr_to_str e))))
  | Fby _ -> raise (Not_implemented "Type checking of Fby")
  | When(e,_,id) -> (match env_fetch loc_env id with
                     | Some _ -> rec_call e
                     | None   -> raise (Unsound ("Undeclared var " ^ id.name)))
  | Merge(id,l) ->
     (match env_fetch loc_env id with
      | Some _ -> (match List.map (fun (_,x) -> rec_call x) l with
                   | hd::tl -> 
                      List.fold_left (fun (all,stat) (curr,statcurr) ->
                                      if stat then curr,statcurr
                                      else if statcurr then all,stat
                                      else if all = curr then all,stat
                                      else raise (Unsound ("Different sizes in merge: "
                                                           ^ (expr_to_str e)))
                                     ) hd tl
                   | _ -> unreached ())
      | None   -> raise (Unsound ("Undeclared var " ^ id.name)))
                  
                  
                               


let type_lhs loc_env idx_env (lhs:var list) : int =
  List.fold_left (fun sum v -> sum + (size_var loc_env idx_env v)) 0 lhs
            
let rec type_deq glob_env loc_env idx_env (deq:deq) : bool =
  match deq with
  | Norec(lhs,e) -> let (size,stat) = type_expr glob_env loc_env idx_env e in
                    if stat then type_lhs loc_env idx_env lhs > -1
                    else type_lhs loc_env idx_env lhs = size
  | Rec(i,ei,ef,l) -> if type_arith idx_env ei then
                        if type_arith idx_env ef then
                          (Hashtbl.add idx_env i.name 1;
                           let res = List.for_all (type_deq glob_env loc_env idx_env) l in
                           Hashtbl.remove idx_env i.name;
                           res)
                        else raise (Unsound ("Bad arith: " ^ (arith_to_str ef)))
                       else raise (Unsound ("Bad arith: " ^ (arith_to_str ei)))
    

let type_def (glob_env: (int * int * bool) env)(def:def) : bool =
  match def.node with
  | Single(vars,body) -> let loc_env = make_loc_env def.p_in def.p_out vars in
                         List.for_all (type_deq glob_env loc_env (Hashtbl.create 10)) body
  | Multiple l -> List.for_all
                    (fun (vars,body) ->
                     let loc_env = make_loc_env def.p_in def.p_out vars in
                     List.for_all (fun x ->
                                   type_deq glob_env loc_env
                                            (Hashtbl.create 10) x) body
                    ) l
  | _ -> true

  
let type_prog (prog:prog) : bool =
  let glob_env = make_glob_env prog in
  List.for_all (type_def glob_env) prog.nodes

let is_typed = type_prog
