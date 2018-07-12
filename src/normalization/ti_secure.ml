open Usuba_AST
open Basic_utils
open Utils

let std_and = "_andTI"
let std_not = "_notTI"
let std_or  = "_orTI"


let rename_for_ti (id:ident) (i:int) : ident =
  { id with name = sprintf "_sh%d_%s" i id.name }


let rec trip_var_i (v:var) (i:int) =
    match v with
    | Var id          -> Var (rename_for_ti id i)
    | Index(v',ae)    -> Index(trip_var v' i,ae)
    | Range(v',ei,ef) -> Range(trip_var v',ei,ef)
    | Slice(v',l)     -> Slice(trip_var v' i,l)

let trip_var (v:var) : var list =
  [ trip_var_i v 1; trip_var_i v 2; trip_var_i v 3 ]
                       
let trip_vars (vars:var list) : var list =
  flat_map trip_var vars

let trip_params (el:expr list) : expr list =
  flat_map (function
      | ExpVar(v) -> [ ExpVar(trip_var_i v 1);
                       ExpVar(trip_var_i v 2);
                       ExpVar(trip_var_i v 3) ]
      | _ -> assert false) el

let trip_deqs (deqs:deq list) : deq list =
  flat_map (function
      | Norec(vars,e) -> (match e with
                          | Const _  -> assert false
                          | ExpVar v -> List.map2 (fun l r -> Norec([l], ExpVar r))
                                          (trip_vars vars) (trip_var v)
                          | Tuple _  -> assert false
                          | Not e    -> List.map2 (fun l r -> Norec([l], Not r))
                                          (trip_vars vars) (trip_expr e)
                          | Shift(op,e,ae) -> List.map2 (fun l r -> Norec(l,Shift(op,r,ae)))
                                                (trip_vars vars) (trip_expr e)
                          | Log(op,x,y) -> (match op with
                                            | And -> Fun(
                          | Fun(f,l) -> [ Norec(List.map trip_var vars,
                                                Fun(f,trip_params l)) ] 
                          | _ -> [ Norec(flat_map trip_var vars, trip_expr e) ])
      | Rec(i,ei,ef,dl,opts) -> [ Rec(i,ei,ef,trip_deqs dl,opts) ] ) deqs
  
  
let trip_p (p:p) : p =
  flat_map (fun ((id,typ),ck) -> [((rename_for_ti id 1,typ),ck);
                                  ((rename_for_ti id 2,typ),ck);
                                  ((rename_for_ti id 3,typ),ck) ]) p
   
let secure_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with p_in  = trip_p def.p_in;
                p_out = trip_p def.p_out;
                node  = Single(trip_vars,trip_deqs body) }
  | _ -> def
   
let ti_secure (prog:prog) : prog =
  let std_node = (Parse_file.parse_file "data/nodes/ti.ua").nodes in
  { nodes = std_nodes @ (List.map secure_def prog.nodes) } 
