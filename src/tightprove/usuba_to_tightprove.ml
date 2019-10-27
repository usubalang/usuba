open Usuba_AST
open Tp_AST
open Basic_utils
open Utils
open Printf

(* true if bitslicing; false if vslicing *)
let bitslice = ref true

let ident_to_str id =
  Str.global_replace (Str.regexp "'") "_" id.name

let rec arith_to_int (ae:Usuba_AST.arith_expr) : int =
  eval_arith_ne ae

let log_op_to_tp (op:Usuba_AST.log_op) : Tp_AST.log_op =
  match op with
  | And -> And
  | Or  -> Or
  | Xor -> Xor
  | _   -> assert false

let shift_op_to_tp (op:Usuba_AST.shift_op) : Tp_AST.shift_op =
  match op with
  | Lshift  -> Lshift
  | Rshift  -> Rshift
  | Lrotate -> Lrotate
  | Rrotate -> Rrotate
  | RAshift -> Printf.eprintf "Cannot generate arithmetic shifts for tightprove.\n";
               assert false

let rec var_to_tp (v:Usuba_AST.var) : string =
  match v with
  | Var v -> ident_to_str v
  | Index(v,e) -> sprintf "%s[%d]" (var_to_tp v) (arith_to_int e)
  | _ -> Printf.eprintf "Invalid var to convert to tp: %s\n"
                        (Usuba_print.var_to_str v);
         assert false

let rec expr_to_tp (e:Usuba_AST.expr) : Tp_AST.expr =
  match e with
  | Const(c,_)    -> if !bitslice then ConstAll c else Const c
  | ExpVar v      -> ExpVar(var_to_tp v)
  | Not(ExpVar v) -> Not(var_to_tp v)
  | Log(op,ExpVar x,ExpVar y) ->  Log(log_op_to_tp op, var_to_tp x, var_to_tp y)
  | Shift(op,ExpVar e,ae)     -> Shift(shift_op_to_tp op, var_to_tp e, arith_to_int ae)
  | Fun(f,[ExpVar v]) when f.name = "refresh" -> Refresh(var_to_tp v)
  | e -> Printf.eprintf "expr_to_str: invalid expr `%s`\n"
                        (Usuba_print.expr_to_str e);
         assert false

let deq_to_tp (deq:Usuba_AST.deq) : Tp_AST.asgn =
  match deq with
  | Eqn([lhs],e,_) -> { lhs = var_to_tp lhs; rhs = expr_to_tp e }
  | _ -> assert false

let rec vd_typ_to_tp (typ:Usuba_AST.typ) (acc:string) : string =
  match typ with
  | Uint(_,_,1)   -> sprintf "%s" acc
  | Uint(_,_,n)   -> sprintf "%s[%d]" acc n
  | Array(typ',n) -> vd_typ_to_tp typ' (sprintf "%s[%d]" acc (arith_to_int n))
  | _ -> assert false

let vd_to_tp (vd:Usuba_AST.var_d) : string =
  sprintf "%s%s" (ident_to_str vd.vid)
          (vd_typ_to_tp vd.vtyp "")

let all_vars_same_m (var_l:Usuba_AST.var_d list) : bool =
  let first_m = get_type_m (List.hd var_l).vtyp in
  List.for_all (fun vd -> get_type_m vd.vtyp = first_m) var_l

let get_node_body (def:Usuba_AST.def) : Usuba_AST.deq list =
  match def.node with
  | Single(_,body) -> body
  | _ -> assert false

let m_as_int = function
  | Mint m -> m
  | _ -> assert false

let usuba_to_tp (def:Usuba_AST.def) : Tp_AST.def =
  assert (all_vars_same_m def.p_in);
  let m = m_as_int (get_type_m (List.hd def.p_in).vtyp) in
  bitslice := m = 1;

  { rs     = m;
    inputs = List.map vd_to_tp def.p_in;
    body   = List.map deq_to_tp (get_node_body def) }


let def_to_str (def:Usuba_AST.def) =
  Print_tp.def_to_str (usuba_to_tp def)

let prog_to_str (prog:Usuba_AST.prog) : string=
  join "\n\n" (List.map def_to_str prog.nodes)

let print_prog (prog:Usuba_AST.prog) : unit =
  Printf.printf "%s" (prog_to_str prog)
