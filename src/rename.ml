(***************************************************************************** )
                                   rename.ml

      This module renames every use defined variable or node, in order to avoid
      any name conflict with variables that the compiler may introduce, or
      variables that result of the expansion of array or uint_n.
      More precisely, we add a quote at the end of every user-defined name. We
      chose quotes because they aren't allowed to be part of variables names in
      Usuba.

      After this module has ran, every user-defined variable or module should
      have its name ending with a quote (').

  ( *****************************************************************************)

open Usuba_AST
open Utils

(* Since the transformation of the code will produce new variable names,
   we must rename the old variables to make there won't be any conflicts
   with those new names (or with any ocaml builtin name).
   Basically, it means adding an "'" at the end of every identifier name. *)

let rec rename_arith_expr (e : arith_expr) =
  match e with
  | Const_e c -> Const_e c
  | Var_e v -> Var_e (Ident.fresh_suffixed v "'")
  | Op_e (op, x, y) -> Op_e (op, rename_arith_expr x, rename_arith_expr y)

let rec rename_var (v : var) =
  match v with
  | Var v -> Var (Ident.fresh_suffixed v "'")
  | Index (v, e) -> Index (rename_var v, rename_arith_expr e)
  | Range (v, ei, ef) ->
      Range (rename_var v, rename_arith_expr ei, rename_arith_expr ef)
  | Slice (v, l) -> Slice (rename_var v, List.map rename_arith_expr l)

let rec rename_expr (e : expr) =
  match e with
  | Const (c, t) -> Const (c, t)
  | ExpVar v -> ExpVar (rename_var v)
  | Tuple l -> Tuple (List.map rename_expr l)
  | Not e -> Not (rename_expr e)
  | Log (op, x, y) -> Log (op, rename_expr x, rename_expr y)
  | Arith (op, x, y) -> Arith (op, rename_expr x, rename_expr y)
  | Shift (op, x, y) -> Shift (op, rename_expr x, rename_arith_expr y)
  | Shuffle (v, l) -> Shuffle (rename_var v, l)
  | Bitmask (e, ae) -> Bitmask (rename_expr e, rename_arith_expr ae)
  | Pack (e1, e2, t) -> Pack (rename_expr e1, rename_expr e2, t)
  | Fun (f, l) ->
      if is_builtin f then Fun (f, List.map rename_expr l)
      else Fun (Ident.fresh_suffixed f "'", List.map rename_expr l)
  | Fun_v (f, e, l) ->
      Fun_v
        (Ident.fresh_suffixed f "'", rename_arith_expr e, List.map rename_expr l)

let rename_pat pat = List.map rename_var pat

let rec rename_deq deqs =
  List.map
    (fun d ->
      {
        d with
        content =
          (match d.content with
          | Eqn (pat, expr, sync) -> Eqn (rename_pat pat, rename_expr expr, sync)
          | Loop (id, ei, ef, d, opts) ->
              Loop (Ident.fresh_suffixed id "'", ei, ef, rename_deq d, opts));
      })
    deqs

let rename_p (p : p) =
  List.map (fun vd -> { vd with vd_id = Ident.fresh_suffixed vd.vd_id "'" }) p

let rename_def (def : def) : def =
  {
    id = Ident.fresh_suffixed def.id "'";
    p_in = rename_p def.p_in;
    p_out = rename_p def.p_out;
    opt = def.opt;
    node =
      (match def.node with
      | Single (p_var, body) -> Single (rename_p p_var, rename_deq body)
      | Multiple nodes ->
          Multiple
            (List.map
               (fun node ->
                 match node with
                 | Single (vars, body) -> Single (rename_p vars, rename_deq body)
                 | _ -> node)
               nodes)
      | _ -> def.node);
  }

let run _ (p : prog) _ = { nodes = List.map rename_def p.nodes }
let as_pass = (run, "Rename", 0)
