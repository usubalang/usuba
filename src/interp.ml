open Usuba_AST
open Basic_utils
open Utils

let env_fetch env id =
  try Hashtbl.find env id.name
  with Not_found -> raise (Undeclared id)
let env_update env id v =
  Hashtbl.replace env id.name v

module Usuba0 = struct
  let rec interp_expr env_fun env_var (e:expr) : bool list =
    let interp_expr_rec = interp_expr env_fun env_var in
    match e with
    | Const(0,_) -> [ false ]
    | Const(1,_) -> [ true ]
    | ExpVar (Var v) -> [ env_fetch env_var v ]
    | Not e' -> List.map (not) (interp_expr_rec e')
    | Log(op,x,y) -> (match op with
                      | And -> List.map2 (&&) (interp_expr_rec x) (interp_expr_rec y)
                      | Or  -> List.map2 (||) (interp_expr_rec x) (interp_expr_rec y)
                      | Xor -> List.map2 (fun x y -> (x && (not y)) || ((not x) && y))
                                         (interp_expr_rec x) (interp_expr_rec y)
                      | Andn -> List.map2 (fun x y -> (not x) && y)
                                          (interp_expr_rec x) (interp_expr_rec y))
    | Fun(f,l) -> let l' = List.flatten (List.map interp_expr_rec l) in
                  let f' = env_fetch env_fun f in
                  interp_node env_fun f' l'
    | _ -> raise (Error ("Invalid expression :" ^ (Usuba_print.expr_to_str e)))

  and interp_node env_fun (f:def) (l:bool list) : bool list =

    (* the function to evaluate an assignment *)
    let interp_asgn env_fun env_var (vars : var list) (expr: expr) : unit =
      let res = interp_expr env_fun env_var expr in
      List.iter2 (fun x y -> match x with
                             | Var v -> env_update env_var v y
                             | _ -> raise (Error ("Invalid left-hand side: " ^
                                                    (Usuba_print.var_to_str x)))) vars res in
    (* creating a lexical environement *)
    let env_var = Hashtbl.create 100 in
    (* adding the inputs in the environment *)
    List.iter2 (fun vd y -> env_update env_var vd.vid y) f.p_in l;
    (* evaluating the instructions of the node *)
    begin
      match f.node with
      | Single(_,deqs) -> List.iter
                            (function
                              | Eqn(vars,e,_) -> interp_asgn env_fun env_var vars e
                              | _ -> raise (Error "Invalid 'Loop'")) deqs
      | _ -> raise (Error ("Invalid node: " ^ (Usuba_print.def_to_str f)))
    end;
    (* returning the values of the output variables *)
    List.map (fun vd -> env_fetch env_var vd.vid) f.p_out


  let interp_prog (prog:prog) (input: bool list) : bool list =
    let env_fun = Hashtbl.create 100 in
    (* Collecting the list of nodes *)
    List.iter (fun f -> env_update env_fun f.id f) prog.nodes;
    (* Calling the last node (the entry point by convention) *)
    interp_node env_fun (last prog.nodes) input
end

module Usuba = struct

  (* Note: node is a Table *)
  let interp_table (node:def) (l: bool list) : bool list =
    let idx = boollist_to_int l in
    match node.node with
    | Table tbl -> int_to_boollist (List.nth tbl idx) (p_size node.p_out)
    | _ -> assert false


end
