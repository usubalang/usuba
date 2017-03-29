open Usuba_AST
open Sol_AST
open Utils

let gen_instance_id =
  let cpt = ref 0 in
  fun () -> incr cpt;
            "o" ^ (string_of_int !cpt)

let convert_log_op op =
  match op with
  | Usuba_AST.And -> Sol_AST.And
  | Or  -> Or
  | Xor -> Xor
             
let convert_arith_op op =
  match op with
  | Usuba_AST.Add -> Sol_AST.Add
  | Mul  -> Mul
  | Sub -> Sub
  | Div -> Div
  | Mod -> Mod
                    
let pat_to_idlist (pat: Usuba_AST.var list) : ident list =
  List.map (function Usuba_AST.Var id -> id
                   | _ -> unreached ()) pat

let rec convert_expr (expr: Usuba_AST.expr) : c =
  match expr with
  | Usuba_AST.Const n -> Sol_AST.Const n
  | ExpVar(Var v) -> Var v
  | Tuple l -> Tuple (List.map convert_expr l)
  | Log(o,x,y) -> Op(convert_log_op o,[convert_expr x;convert_expr y])
  | Not e -> Op(Not,[convert_expr e])
  | Arith(o,x,y) -> Op(convert_arith_op o,[convert_expr x;convert_expr y])
  | _ -> print_endline (Usuba_print.expr_to_str expr);
         raise (Error "Usuba AST isn't normalized.")
           
let convert_body (body: Usuba_AST.deq list) : s list * j  * m =
  let funs = ref [] in
  let body =
    List.map (function
               | Norec (left,right) ->
                  let left = pat_to_idlist left in
                  ( match right with
                    | Usuba_AST.Const n -> Asgn(left,Sol_AST.Const n)
                    | ExpVar(Var v)     -> Asgn(left,Var v)
                    | Tuple l  -> Asgn(left,Tuple(List.map convert_expr l))
                    | Log(op,x,y) -> Asgn(left,Op(convert_log_op op,
                                                   [convert_expr x;
                                                   convert_expr y]))
                    | Arith(op,x,y) -> Asgn(left,Op(convert_arith_op op,
                                                       [convert_expr x;
                                                       convert_expr y]))
                    | Not e    -> Asgn(left,Op (Not,[convert_expr e]))
                    | Fun(f,l) -> let id = gen_instance_id() in
                                  funs := (id,f) :: !funs;
                                  Step(left,id,List.map convert_expr l)
                    | _ -> unreached ())
               | Rec _ -> raise (Error "REC")) body in
  (body, List.rev !funs, [])
           
let convert_node f p_in p_out vars body : machine =
  let (body,instances,memory) = convert_body body in
  let reset =
    match List.map (fun (id,_) -> Reset id) instances with
    | [] -> [Skip]
    | l  -> l in
  let p_in' = List.map (fun (x,_,_) -> x,Bool) p_in in
  let p_out' = List.map (fun (x,_,_) -> x,Bool) p_out in
  let vars' = List.map (fun (x,_,_) -> x,Bool) vars in
  (f,memory,instances,reset,p_in',p_out',vars',body)
    
    
let convert_def (def: def) : machine =
  match def with
  | Single(f,p_in,p_out,vars,body) -> convert_node f p_in p_out vars body
  | _ -> raise (Error "Can't convert non-Single nodes to SOL")
               
let usuba_to_sol (prog: Usuba_AST.prog) : Sol_AST.prog =
  List.map convert_def prog
