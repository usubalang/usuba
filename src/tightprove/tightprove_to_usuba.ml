open Basic_utils
open Usuba_AST
open Tp_AST
open Printf

(* More like "update envs" than "gen_var": given a TP variable (ie, a
   string), generates a Usuba variable, and updates |new_vars| and
   |vars_corres| accordingly. *)
let gen_var (new_vars:(Usuba_AST.ident,bool) Hashtbl.t)
            (vars_corres: (string, Usuba_AST.var) Hashtbl.t)
            (v:string) : unit =
  let new_v = Utils.fresh_ident v in
  Hashtbl.add new_vars new_v true;
  Hashtbl.add vars_corres v (Var new_v)

let var_to_ua (vars_corres: (string, Usuba_AST.var) Hashtbl.t)
              (v:string) : Usuba_AST.var =
  Hashtbl.find vars_corres v

let log_op_to_ua (op:Tp_AST.log_op) : Usuba_AST.log_op =
  match op with
  | Tp_AST.And -> Usuba_AST.And
  | Tp_AST.Or  -> Usuba_AST.Or
  | Tp_AST.Xor -> Usuba_AST.Xor

let shift_op_to_ua (op:Tp_AST.shift_op) : Usuba_AST.shift_op =
  match op with
  | Tp_AST.Lshift  -> Usuba_AST.Lshift
  | Tp_AST.Rshift  -> Usuba_AST.Rshift
  | Tp_AST.Lrotate -> Usuba_AST.Lrotate
  | Tp_AST.Rrotate -> Usuba_AST.Rrotate

let asgn_to_ua (vars_corres: (string, Usuba_AST.var) Hashtbl.t)
               (new_vars:(Usuba_AST.ident,bool) Hashtbl.t)
               (base_type:Usuba_AST.typ)
               (asgn:Tp_AST.asgn) : deq =
  let ua_rhs =
    match asgn.rhs with
    | Tp_AST.ExpVar v      -> Usuba_AST.ExpVar (var_to_ua vars_corres v)
    | Tp_AST.Const c       -> Usuba_AST.Const(c,Some base_type)
    | Tp_AST.ConstAll c    -> Usuba_AST.Const(c,Some base_type)
    | Tp_AST.Not v         -> Usuba_AST.Not (Usuba_AST.ExpVar (var_to_ua vars_corres v))
    | Tp_AST.Log(op,x,y)   ->
       let x = Usuba_AST.ExpVar (var_to_ua vars_corres x) in
       let y = Usuba_AST.ExpVar (var_to_ua vars_corres y) in
       Usuba_AST.Log(log_op_to_ua op, x, y)
    | Tp_AST.Shift(op,x,n) ->
       let x = Usuba_AST.ExpVar (var_to_ua vars_corres x) in
       Usuba_AST.Shift(shift_op_to_ua op, x, Usuba_AST.Const_e n)
    | Tp_AST.Refresh v     ->
       gen_var new_vars vars_corres asgn.lhs;
       Usuba_AST.Fun(Utils.fresh_ident "refresh",
                     [Usuba_AST.ExpVar (var_to_ua vars_corres v)])
    | Tp_AST.BitToReg _    -> Printf.fprintf stderr "Not implemented: bit_to_reg.\n";
                              assert false
  in
  Usuba_AST.Eqn([var_to_ua vars_corres asgn.lhs], ua_rhs, false)

let body_to_ua (vars_corres: (string, Usuba_AST.var) Hashtbl.t)
               (new_vars:(Usuba_AST.ident,bool) Hashtbl.t)
               (base_type:Usuba_AST.typ)
               (body:Tp_AST.asgn list) : deq list =
  List.map (asgn_to_ua vars_corres new_vars base_type) body

(* |ua_def| is the initial Usuba def that produces |tp_def|. It's
   taken as parameters as it simplifies getting the
   input/output/variables with the right types for Usuba. *)
let tp_to_usuba (vars_corres: (string, Usuba_AST.var) Hashtbl.t)
                (ua_def:Usuba_AST.def) (tp_def:Tp_AST.def) : Usuba_AST.def =
  match ua_def.node with
  | Single(vars,body) ->
     let new_vars  = Hashtbl.create 10 in
     let base_type = Utils.get_base_type (List.hd (ua_def.p_in)).vtyp in
     let new_body  = body_to_ua vars_corres new_vars base_type tp_def.body in
     let new_vars  = vars @ (List.map (fun v -> Utils.simple_typed_var_d v base_type)
                                      (keys new_vars)) in
     { ua_def with node = Single(new_vars,new_body) }
  | _ -> assert false
