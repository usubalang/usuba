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

open Prelude
open Usuba_AST
open Utils

(* Since the transformation of the code will produce new variable names,
   we must rename the old variables to make there won't be any conflicts
   with those new names (or with any ocaml builtin name).
   Basically, it means adding an "'" at the end of every identifier name. *)

let get_fresh map id =
  match Ident.Map.find id map with
  | id -> id
  | exception Not_found -> raise (Errors.Rename_to_unknown (Ident.name id))

let rec rename_arith_expr map (e : arith_expr) =
  match e with
  | Const_e c -> Const_e c
  | Var_e v -> Var_e (get_fresh map v)
  | Op_e (op, x, y) ->
      Op_e (op, rename_arith_expr map x, rename_arith_expr map y)

let rec rename_var map (v : var) =
  match v with
  | Var v -> Var (get_fresh map v)
  | Index (v, e) -> Index (rename_var map v, rename_arith_expr map e)
  | Range (v, ei, ef) ->
      Range
        (rename_var map v, rename_arith_expr map ei, rename_arith_expr map ef)
  | Slice (v, l) -> Slice (rename_var map v, List.map (rename_arith_expr map) l)

let rec rename_expr map (e : expr) =
  match e with
  | Const (c, t) -> Const (c, t)
  | ExpVar v -> ExpVar (rename_var map v)
  | Tuple l -> Tuple (List.map (rename_expr map) l)
  | Not e -> Not (rename_expr map e)
  | Log (op, x, y) -> Log (op, rename_expr map x, rename_expr map y)
  | Arith (op, x, y) -> Arith (op, rename_expr map x, rename_expr map y)
  | Shift (op, x, y) -> Shift (op, rename_expr map x, rename_arith_expr map y)
  | Shuffle (v, l) -> Shuffle (rename_var map v, l)
  | Bitmask (e, ae) -> Bitmask (rename_expr map e, rename_arith_expr map ae)
  | Pack (e1, e2, t) -> Pack (rename_expr map e1, rename_expr map e2, t)
  | Fun (f, l) ->
      if is_builtin f then Fun (f, List.map (rename_expr map) l)
      else Fun (get_fresh map f, List.map (rename_expr map) l)
  | Fun_v (f, e, l) ->
      Fun_v
        (get_fresh map f, rename_arith_expr map e, List.map (rename_expr map) l)

let rename_pat map pat = List.map (rename_var map) pat

let rec rename_deq map deqs =
  List.map
    (fun d ->
      {
        d with
        content =
          (match d.content with
          | Eqn (pat, expr, sync) ->
              Eqn (rename_pat map pat, rename_expr map expr, sync)
          | Loop (id, ei, ef, d, opts) ->
              let new_id = Ident.fresh_suffixed id "'" in
              let map = Ident.Map.add id new_id map in
              Loop (new_id, ei, ef, rename_deq map d, opts));
      })
    deqs

let rename_p map (p : p) =
  List.fold_left_map
    (fun map vd ->
      let id = Ident.fresh_suffixed vd.vd_id "'" in
      (Ident.Map.add vd.vd_id id map, { vd with vd_id = id }))
    map p

let rename_def map def =
  let id = Ident.fresh_suffixed def.id "'" in
  let map_node = Ident.Map.add def.id id map in
  let map, p_in = rename_p map_node def.p_in in
  let map, p_out = rename_p map def.p_out in
  ( map_node,
    {
      id;
      p_in;
      p_out;
      opt = def.opt;
      node =
        (match def.node with
        | Single (vars, body) ->
            let map, vars = rename_p map vars in
            Single (vars, rename_deq map body)
        | Multiple nodes ->
            Multiple
              (List.map
                 (fun node ->
                   match node with
                   | Single (vars, body) ->
                       let map, vars = rename_p map vars in
                       Single (vars, rename_deq map body)
                   | _ -> node)
                 nodes)
        | _ -> def.node);
    } )

let run _ (p : prog) _ =
  {
    nodes =
      List.fold_left_map
        (fun map node -> rename_def map node)
        Ident.Map.empty p.nodes
      |> snd;
  }

let as_pass = (run, "Rename", 0)
