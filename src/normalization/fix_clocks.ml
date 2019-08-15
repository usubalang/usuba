open Usuba_AST
open Basic_utils
open Utils


(* TODO
  - debug this!
*)

let init_env (p_in:p) (p_out:p) (vars:p) =
  let env = Hashtbl.create 100 in
  List.iter (fun vd -> Hashtbl.add env vd.vid vd.vck) p_in;
  List.iter (fun vd -> Hashtbl.add env vd.vid vd.vck) p_out;
  List.iter (fun vd -> Hashtbl.add env vd.vid vd.vck) vars;
  env

let rec get_var_clock env (v:var) : clock =
  match v with
  | Var x -> Hashtbl.find env x
  | Index(v',_) -> get_var_clock env v'
  | _ -> assert false

let rec get_ck_name (ck:clock) : expr list =
  match ck with
  | Defclock | Base -> []
  | On(ck,id)   -> (ExpVar (Var id)) :: (get_ck_name ck)
  | Onot(ck,id) -> (Not (ExpVar (Var id))) :: (get_ck_name ck)

let rec fix_deq env (deq:deq) : deq =
  match deq with
  | Eqn(lhs,e,sync) -> let ck = get_ck_name (get_var_clock env (List.hd lhs)) in
                       Eqn(lhs,List.fold_left (fun x y -> Log(And,x,y)) e ck, sync)
  | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,List.map (fix_deq env) dl,opts)


let fix_def (def:def) : def =
  match def.node with
  | Single(vars,body) -> let env = init_env def.p_in def.p_out vars in
                         { def with node = Single(vars,List.map (fix_deq env) body) }
  | Perm _ -> def
  | Table _ -> def
  | _ -> assert false

let fix_prog (prog:prog) (conf:config) : prog =
  { nodes = List.map fix_def prog.nodes }
