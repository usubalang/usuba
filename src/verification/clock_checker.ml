open Usuba_AST
open Utils


let init_env (p_in:p) (p_out:p) (vars:p) =
  let env = Hashtbl.create 100 in
  List.iter (fun ((id,_),ck) -> Hashtbl.add env id ck) p_in;
  List.iter (fun ((id,_),ck) -> Hashtbl.add env id ck) p_out;
  List.iter (fun ((id,_),ck) -> Hashtbl.add env id ck) vars;
       
let type_def (def:def) : bool =
  match def.node with
  | Single(vars,body) -> let env = Hashtbl.create 

let check_prog (prog:prog) : bool =
  List.for_all type_def prog.nodes
       
let is_clocked = check_prog 
