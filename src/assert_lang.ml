open Usuba_AST
open Utils


module Usuba0 = struct

  let is_usuba0 (prog:prog) : bool =
    true
end

module Usuba_norm = struct

  let check_var (var:var) : bool =
    match var with
    | Var _ -> true
    | _ -> false

  let check_pat_e (p:var list) (e:expr) : bool =
    match e with
    | Tuple l -> List.length l = List.length p
    | _ -> true
             
  let rec check_expr (e:expr) : bool =
    match e with
    | Const _ -> true
    | ExpVar v -> check_var v
    | Tuple l  -> List.for_all check_expr l
    | Not e -> check_expr e
    | Shift(_,e,_) -> check_expr e
    | Log(_,x,y) -> check_expr x && check_expr y
    | Arith(_,x,y) -> check_expr x && check_expr y
    | Intr(_,x,y) -> check_expr x && check_expr y
    | Fun(_,l) -> List.for_all check_expr l
    | Fun_v _ -> false
    | Fby _ -> raise (Not_implemented "Fby")
    | Nop -> true
  
  let check_p (p:p) : bool =
    List.for_all (function
                   | (_,Array _,_) -> false
                   | _ -> true) p
  
  let check_def (def:def) : bool =
    match def with
    | Single(_,p_in,p_out,vars,body) ->
       check_p p_in && check_p p_out && check_p vars
       && List.for_all (function
                         | Norec(p,e) -> List.for_all check_var p && check_expr e
                                         && check_pat_e p e
                         | _ -> false) body
    | _ -> false
  
  let is_usuba_normalized (prog:prog) : bool =
    Usuba0.is_usuba0 prog &&
      List.for_all check_def prog
end

module Usuba_intrinsics = struct

  let rec check_expr (e:expr) : bool =
    match e with
    | Const _ | ExpVar _ -> true
    | Intr(_,x,y) -> check_expr x && check_expr y
    | _ -> false
  
  let check_def (def:def) : bool =
    match def with
    | Single(_,_,_,_,body) ->
       List.for_all (function
                      | Norec(p,e) -> check_expr e
                      | _ -> false) body
    | _ -> false
                
                
  let is_only_intrinsics (prog:prog) : bool =
    Usuba_norm.is_usuba_normalized prog &&
      List.for_all check_def prog
end
                      
