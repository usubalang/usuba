open Usuba_AST
open Basic_utils
open Utils
open Printf

let ident_to_str id =
  Str.global_replace (Str.regexp "'") "_" id.name

let m_as_int = function
  | Mint m -> m
  | _ -> assert false

let arith_op_to_str = function
  | Add -> "+"
  | Mul -> "*"
  | Sub -> "-"
  | Div -> "/"
  | Mod -> "%"

let rec arith_to_str = function
  | Const_e i -> string_of_int i
  | Var_e v   -> v.name
  | Op_e(op,x,y) -> sprintf "(%s %s %s)" (arith_to_str x) (arith_op_to_str op)
                            (arith_to_str y)

let log_op_to_str = function
  | And -> "&"
  | Or  -> "|"
  | Xor -> "^"
  | _   -> assert false

let shift_op_to_str = function
  | Lshift  -> "#lsl"
  | Rshift  -> "#lsr"
  | RAshift -> Printf.eprintf "Cannot generate arithmetic shifts for maskverif.\n";
               assert false
  | Lrotate -> "#rol"
  | Rrotate -> "#ror"

let rec var_to_str = function
  | Var v -> ident_to_str v
  | Index(v,e) -> sprintf "%s[%s]" (var_to_str v) (arith_to_str e)
  | Range(v,ei,ef) -> Printf.eprintf "Cannot generate range for tightprove (%s).\n"
                                     (Usuba_print.var_to_str (Range(v,ei,ef)));
                      assert false
  | Slice(v,l) -> Printf.eprintf "Cannot generate slice for tightprove (%s).\n"
                                 (Usuba_print.var_to_str (Slice(v,l)));
                  assert false

let rec expr_to_str (env_var:(ident,typ) Hashtbl.t) = function
  | Const(c,Some (Uint(_,Mint m,_))) -> sprintf "(0x%x:w%d)" c m
  | ExpVar v   -> var_to_str v
  | Log(o,x,y) -> sprintf "%s %sw%d %s"
                          (expr_to_str env_var x) (log_op_to_str o)
                          (m_as_int (get_type_m (get_normed_expr_type env_var x)))
                          (expr_to_str env_var y)
  | Arith(o,x,y) -> sprintf "%s %s %s"
                            (expr_to_str env_var x) (arith_op_to_str o) (expr_to_str env_var y)
  | Shift(op,e,ae) -> sprintf "%s(%s,%s)"
                    (shift_op_to_str op) (expr_to_str env_var e) (arith_to_str ae)
  | Not e -> sprintf "~w%d %s"
                     (m_as_int (get_type_m (get_normed_expr_type env_var e)))
                     (expr_to_str env_var e)
  | Fun(f,l) ->
     sprintf "%s(%s)" (ident_to_str f) (join "," (List.map (expr_to_str env_var) l))
  | e -> Printf.eprintf "expr_to_str: invalid expr `%s`\n"
           (Usuba_print.expr_to_str e);
         assert false

let pat_to_str pat =
  match pat with
  | [] -> assert false
  | x :: [] -> var_to_str x
  | l -> "(" ^ (join "," (List.map var_to_str pat)) ^ ")"

let rec deq_to_str (env_var:(ident,typ) Hashtbl.t) = function
  | Eqn(pat,e,_) -> sprintf "  %s := %s;\n"
                            (pat_to_str pat)
                            (expr_to_str env_var e)
  | _ -> assert false

let rec vd_typ_to_str (typ:typ) (acc:string) : string =
  match typ with
  | Uint(_,_,1)   -> sprintf "%s" acc
  | Uint(_,_,n)   -> sprintf "%s[%d]" acc n
  | Array(typ',n) -> vd_typ_to_str typ' (sprintf "%s[%s]" acc (arith_to_str n))
  | _ -> assert false

let vd_to_str (vd:var_d) : string =
  sprintf "w%d %s[0:D]"
          (m_as_int (get_type_m vd.vtyp))
          (ident_to_str vd.vid)


let single_node_to_str (id:ident) (p_in:p) (p_out:p) (vars:p) (deq:deq list) =
  let env_var = build_env_var p_in p_out vars in
  sprintf
"proc %s:
  inputs: %s
  outputs: %s
  shares: %s;

%s
end
"
(* function name *)
(ident_to_str id)
(* inputs *)
(join ", " (List.map vd_to_str p_in))
(* outputs *)
(join ", " (List.map vd_to_str p_out))
(* local variables *)
(join ", " (List.map vd_to_str vars))
(* body *)
(join "" (List.map (deq_to_str env_var) deq))

let def_to_str (def:def) =
  match def.node with
  | Single(vars,deq) ->
     single_node_to_str def.id def.p_in def.p_out vars deq
  | _ -> assert false

let prog_to_str (prog:prog) : string=
  join "\n\n" (List.map def_to_str prog.nodes)

let print_prog (prog:prog) : unit =
  Printf.printf "%s" (prog_to_str prog)
