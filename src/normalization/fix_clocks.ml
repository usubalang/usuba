open Usuba_AST
open Utils


(* TODO
  - debug this!
*)

let init_env (p_in:p) (p_out:p) (vars:p) =
  let env = Hashtbl.create 100 in
  List.iter (fun ((id,_),ck) -> Hashtbl.add env (Var id) ck) p_in;
  List.iter (fun ((id,_),ck) -> Hashtbl.add env (Var id) ck) p_out;
  List.iter (fun ((id,_),ck) -> Hashtbl.add env (Var id) ck) vars;
  env

let rec get_ck_name (ck:clock) : expr list =
  match ck with
  | Defclock | Base -> []
  | On(ck,id)   -> (ExpVar (Var id)) :: (get_ck_name ck)
  | Onot(ck,id) -> (Not (ExpVar (Var id))) :: (get_ck_name ck)
                                     
let rec fix_deq env (deq:deq) : deq =
  match deq with
  | Norec(lhs,e) -> let ck = get_ck_name (Hashtbl.find env (List.hd lhs)) in
                    Norec(lhs,List.fold_left (fun x y -> Log(And,x,y)) e ck)
  | Rec _ -> assert false

    
let fix_def (def:def) : def =
  match def.node with
  | Single(vars,body) -> let env = init_env def.p_in def.p_out vars in
                         { def with node = Single(vars,List.map (fix_deq env) body) }
  | _ -> assert false
       
let fix_prog (prog:prog) : prog =
  { nodes = List.map fix_def prog.nodes }
