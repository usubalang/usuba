open Usuba_AST
open Basic_utils
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
    | Shuffle(v,_) -> check_var v
    | Arith(_,x,y) -> check_expr x && check_expr y
    | Fun(_,l) -> List.for_all check_expr l
    | Fun_v _ -> false
    | Fby _ -> raise (Not_implemented "Fby")
    | When(_,_,_) -> false
    | Merge(_,_) -> false
  
  let check_p (p:p) : bool =
    List.for_all (function
                   | ((_,Array _),_) -> false
                   | _ -> true) p
  
  let check_def (def:def) : bool =
    match def.node with
    | Single(vars,body) ->
       check_p def.p_in && check_p def.p_out && check_p vars
       && List.for_all (function
                         | Eqn(p,e) -> List.for_all check_var p && check_expr e
                                         && check_pat_e p e
                         | _ -> false) body
    | _ -> false
  
  let is_usuba_normalized (prog:prog) : bool =
    Usuba0.is_usuba0 prog &&
      List.for_all check_def prog.nodes
end
                      
