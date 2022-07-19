open Usuba_AST

let ident_to_str id = Str.global_replace (Str.regexp "'") "_" (Ident.name id)
let m_as_int = function Mint m -> m | _ -> assert false

let arith_op_to_str = function
  | Add -> "+"
  | Mul -> "*"
  | Sub -> "-"
  | Div -> "/"
  | Mod -> "%"

let rec arith_to_str = function
  | Const_e i -> Format.sprintf "0x%x" i
  | Var_e v -> Ident.name v
  | Op_e (op, x, y) ->
      Format.sprintf "(%s %s %s)" (arith_to_str x) (arith_op_to_str op)
        (arith_to_str y)

let log_op_to_str = function And -> "AND" | Or -> "OR" | _ -> assert false

let shift_op_to_str = function
  | Lshift -> "#lsl"
  | Rshift -> "#lsr"
  | RAshift ->
      Format.eprintf "Cannot generate arithmetic shifts for maskverif.@.";
      assert false
  | Lrotate -> "#rol"
  | Rrotate -> "#ror"

let var_to_str = function
  | Var v -> ident_to_str v
  | v ->
      Format.eprintf "Cannot have arrays for maskverif (%a).@."
        (Usuba_print.pp_var ()) v;
      assert false

let rec expr_to_str (env_var : (ident, typ) Hashtbl.t) = function
  | Const (c, Some (Uint (_, Mint m, _))) -> Format.sprintf "[0x%x:w%d; 0D]" c m
  | ExpVar v -> var_to_str v
  | Log (Xor, x, y) ->
      Format.sprintf "%s ^w%d %s" (expr_to_str env_var x)
        (m_as_int (Utils.get_type_m (Utils.get_normed_expr_type env_var x)))
        (expr_to_str env_var y)
  | Log (op, x, y) ->
      Format.sprintf "%s(%s,%s)" (log_op_to_str op) (expr_to_str env_var x)
        (expr_to_str env_var y)
  | Arith (o, x, y) ->
      Format.sprintf "%s %s %s" (expr_to_str env_var x) (arith_op_to_str o)
        (expr_to_str env_var y)
  | Shift (op, e, ae) ->
      Format.sprintf "%s(%s,%s)" (shift_op_to_str op) (expr_to_str env_var e)
        (arith_to_str ae)
  | Not e -> Format.sprintf "NOT(%s)" (expr_to_str env_var e)
  | Fun (f, l) ->
      Format.sprintf "%s(%s)" (ident_to_str f)
        (Basic_utils.join "," (List.map (expr_to_str env_var) l))
  | e ->
      Format.eprintf "expr_to_str: invalid expr `%a`\n" (Usuba_print.pp_expr ())
        e;
      assert false

let pat_to_str pat =
  match pat with
  | [] -> assert false
  | [ x ] -> var_to_str x
  | _ -> "(" ^ Basic_utils.join "," (List.map var_to_str pat) ^ ")"

let deq_to_str (env_var : (ident, typ) Hashtbl.t) (d : deq) : string =
  match d.content with
  | Eqn (pat, e, _) ->
      Format.sprintf "  %s %s= %s;\n" (pat_to_str pat)
        (match e with
        | Fun _ | Log (And, _, _) | Log (Or, _, _) -> ""
        | _ -> ":")
        (expr_to_str env_var e)
  | _ -> assert false

let vd_to_str (vd : var_d) : string =
  Format.sprintf "w%d %s[0:D]"
    (m_as_int (Utils.get_type_m vd.vd_typ))
    (ident_to_str vd.vd_id)

let single_node_to_str (id : ident) (p_in : p) (p_out : p) (vars : p)
    (deq : deq list) =
  let env_var = Utils.build_env_var p_in p_out vars in
  Format.sprintf
    "proc %s:\n  inputs: %s\n  outputs: %s\n  shares: %s;\n\n%s\nend\n"
    (* function name *)
    (ident_to_str id)
    (* inputs *)
    (Basic_utils.join ", " (List.map vd_to_str p_in))
    (* outputs *)
    (Basic_utils.join ", " (List.map vd_to_str p_out))
    (* local variables *)
    (Basic_utils.join ", " (List.map vd_to_str vars))
    (* body *)
    (Basic_utils.join "" (List.map (deq_to_str env_var) deq))

let def_to_str (def : def) =
  match def.node with
  | Single (vars, deq) -> single_node_to_str def.id def.p_in def.p_out vars deq
  | _ -> assert false

let prog_to_str (prog : prog) : string =
  Basic_utils.join "\n\n" (List.map def_to_str prog.nodes)

let print_prog (prog : prog) : unit = Format.printf "%s" (prog_to_str prog)

let run _ (prog : prog) _ : prog =
  print_prog prog;
  prog

let as_pass = (run, "Usuba_to_maskverif", 0)
