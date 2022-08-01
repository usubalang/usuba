open Prelude
open Usuba_AST

(* Clean.clean_vars_decl removes unused variables from variable declarations of nodes
   (unused variables will likely be variables that have been optimized out) *)
let rec collect_var env (var : var) : unit =
  match var with
  | Var id -> Ident.Hashtbl.replace env id 1
  | Index (v, _) | Range (v, _, _) | Slice (v, _) -> collect_var env v

let rec collect_expr env (e : expr) : unit =
  match e with
  | Const _ -> ()
  | ExpVar v -> collect_var env v
  | Tuple l -> List.iter (collect_expr env) l
  | Not e -> collect_expr env e
  | Log (_, x, y) ->
      collect_expr env x;
      collect_expr env y
  | Arith (_, x, y) ->
      collect_expr env x;
      collect_expr env y
  | Shift (_, x, _) -> collect_expr env x
  | Shuffle (v, _) -> collect_var env v
  | Bitmask (e, _) -> collect_expr env e
  | Pack (e1, e2, _) ->
      collect_expr env e1;
      collect_expr env e2
  | Fun (_, l) -> List.iter (collect_expr env) l
  | Fun_v (_, _, l) -> List.iter (collect_expr env) l

let clean_in_deqs (vars : p) (deqs : deq list) : p =
  let env = Ident.Hashtbl.create 100 in
  let rec aux d =
    match d.content with
    | Eqn (l, e, _) ->
        List.iter (collect_var env) l;
        collect_expr env e
    | Loop (_, _, _, d, _) -> List.iter aux d
  in
  List.iter aux deqs;
  List.sort_uniq compare_var_d
    (List.filter
       (fun vd ->
         match Ident.Hashtbl.find_opt env vd.vd_id with
         | Some _ -> true
         | None -> false)
       vars)

let clean_def (def : def) : def =
  match def.node with
  | Single (vars, body) ->
      let vars = clean_in_deqs vars body in
      { def with node = Single (vars, body) }
  | _ -> def

let run _ prog _ = { nodes = List.map clean_def prog.nodes }
let as_pass = (run, "Clean", 0)
