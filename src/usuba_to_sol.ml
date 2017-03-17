open Usuba_AST
open Sol_AST
open Utils

let gen_instance_id =
  let cpt = ref 0 in
  fun () -> incr cpt;
            "o" ^ (string_of_int !cpt)

let convert_op (op: Usuba_AST.op) : Sol_AST.op =
  match op with
  | Usuba_AST.And -> Sol_AST.And
  | Or  -> Or
  | Xor -> Xor
  | Not -> Not
                    
let pat_to_idlist (pat: Usuba_AST.pat) : ident list =
  List.map (function Ident id -> id
                   | _ -> unreached ()) pat

let rec convert_expr (expr: Usuba_AST.expr) : c =
  match expr with
  | Usuba_AST.Const n -> Sol_AST.Const n
  | Var v -> Var v
  | Tuple l -> Tuple (List.map convert_expr l)
  | Op(o,l) -> Op(convert_op o,List.map convert_expr l)
  | _ -> print_endline (Usuba_print.expr_to_str expr);
         raise (Error (format_exn __LOC__
                                  "Usuba AST isn't normalized."))
           
let convert_body (body: Usuba_AST.deq) : s list * j  * m =
  let funs = ref [] in
  let body =
    List.map (fun (left,right) ->
              let left = pat_to_idlist left in
              match right with
              | Usuba_AST.Const n -> Asgn(left,Sol_AST.Const n)
              | Var v    -> Asgn(left,Var v)
              | Tuple l  -> Asgn(left,Tuple(List.map convert_expr l))
              | Op(op,l) -> Asgn(left,Op(convert_op op,List.map convert_expr l))
              | Fun(f,l) -> let id = gen_instance_id() in
                            funs := (id,f) :: !funs;
                            Step(left,id,List.map convert_expr l)
              | _ -> unreached ()) body in
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
