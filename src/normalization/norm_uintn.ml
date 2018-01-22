(***************************************************************************** )
                              norm_uintn.ml                                 

    This module converts uint_n to n booleans.
    
    After this module has ran, there souldn't be any "uint_n" variables, nor
    any "Field" expression.

( *****************************************************************************)


open Usuba_AST
open Utils

       
(* "norm_exp" potentially introduce a lot of nested tuples, so we need
   to clean them. That's what "flatten_expr" does. *)
let rec flatten_expr (l: expr list) : expr list =
  List.flatten @@
    List.map (fun x -> match x with
                       | Tuple l -> flatten_expr l
                       | _ -> [ x ]) l

                                  
let rec norm_expr env (e: expr) : expr = 
  match e with
  | Const c -> Const c
  | ExpVar(Var id)  -> ( match env_fetch env id with
                         | Some n when n > 1 ->
                            Tuple(flatten_expr @@ expand_intn_expr id n)
                         | _ ->
                            e )
  | ExpVar(Field(Var id, Const_e n)) -> ExpVar(Var (fresh_suffix id (string_of_int n)))
  | Tuple (l) -> Tuple(flatten_expr @@ List.map (norm_expr env) l)
  | Fun(f,l) -> Fun(f,flatten_expr @@ List.map (norm_expr env) l)
  | Log(op,x1,x2) -> let x1' = norm_expr env x1 in
                     let x2' = norm_expr env x2 in
                     ( match x1', x2' with
                       | Tuple l1, Tuple l2 ->
                          Tuple(List.map2 (fun x y -> Log(op,x,y)) l1 l2)
                       | _, _ -> Log(op,x1',x2'))
  | Not e -> Not(norm_expr env e)
  | Shift(op,e,n) -> Shift(op,norm_expr env e,n)
  | _ -> raise (Invalid_AST "Invalid expr")

let norm_pat env (pat: var list) : var list =
  flat_map
    (fun x -> match x with
              | Var id -> (match env_fetch env id with
                           | Some size ->
                              if size > 1 then expand_intn_pat id size
                              else [ Var id ]
                           | None -> [ Var id ]) (* undeclared bool *)
              | Field(Var id,Const_e i) -> [Var (fresh_suffix id (string_of_int i)) ]
              | _ -> raise (Invalid_AST ("Illegal array access : " ^
                                           (Usuba_print.var_to_str x)))) pat
    
let norm_deq env (body: deq list) : deq list =
   List.map
     (function
       | Norec (p,e) -> Norec(norm_pat env p,norm_expr env e)
       | Rec _ -> raise (Error "REC")) body


let norm_p (p: p) : p =
  List.flatten
    (List.map
       (fun ((id,typ),ck) ->
        match typ with
        | Bool     -> [ (id,Bool),ck ]
        | Int(_,1) -> [ (id,Bool),ck ]
        | Int(_,n) -> expand_intn_typed id n ck
        | Nat      -> raise (Invalid_AST "Illegal nat")
        | Array _  -> raise (Invalid_AST "Illegal Array")) p)

let norm_def (def: def) : def =
  match def.node with
  | Single(vars,body) ->
      let env = Hashtbl.create 10 in
      env_add_var def.p_in env;
      env_add_var def.p_out env;
      env_add_var vars env;
      { def with p_in  = norm_p def.p_in;
                 p_out = norm_p def.p_out;
                 node  = Single(norm_p vars, norm_deq env body) }
  | _ -> def


let norm_uintn (prog: prog) : prog =
  (* { nodes = List.map norm_def prog.nodes } *)
  prog
