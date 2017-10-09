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

let rec rename_arith_expr (e:arith_expr) =
  match e with
  | Const_e c -> Const_e c
  | Var_e v -> Var_e (v^"'")
  | Op_e(op,x,y) -> Op_e(op,rename_arith_expr x,rename_arith_expr y)
       
let rec rename_var (v:var) =
  match v with
  | Var v -> Var (v ^ "'")
  | Field(v,e) -> Field(rename_var v,rename_arith_expr e)
  | Index(v,e) -> Index(v^"'",rename_arith_expr e)
  | Range(v,ei,ef) -> Range(v^"'",rename_arith_expr ei,rename_arith_expr ef)
  | Slice(v,l) -> Slice(v^"'",List.map rename_arith_expr l)
       
let rec rename_expr (e:expr) =
  match e with
  | Const c -> Const c
  | ExpVar v -> ExpVar (rename_var v)
  | Tuple l  -> Tuple(List.map rename_expr l)
  | Log(op,x,y) -> Log(op,rename_expr x,rename_expr y)
  | Arith(op,x,y) -> Arith(op,rename_expr x,rename_expr y)
  | Shift(op,x,y) -> Shift(op,rename_expr x,rename_arith_expr y)
  | Intr(op,x,y) -> Intr(op,rename_expr x,rename_expr y)
  | Not e -> Not (rename_expr e)
  | Fun(f,l) -> if f = "print" then Fun(f,List.map rename_expr l)
                else Fun(f^"'",List.map rename_expr l)
  | Fun_v(f,e,l) -> Fun_v(f^"'",rename_arith_expr e,List.map rename_expr l)
  | Fby(ei,ef,f)   -> Fby(rename_expr ei,rename_expr ef,
                          match f with
                          | None -> None
                          | Some id -> Some (id^"'"))
  | Nop -> Nop
  | _ -> raise (Not_implemented (Usuba_print.expr_to_str e))


                      
let rec rename_pat pat =
  List.map rename_var pat
           
let rec rename_deq deqs =
    List.map (function
               | Norec(pat,expr) -> Norec(rename_pat pat,rename_expr expr)
               | Rec(id,ei,ef,d) -> Rec(id^"'",rename_arith_expr ei,
                                        rename_arith_expr ef,
                                        rename_deq d)) deqs
             
let rec rename_p p =
  List.map (fun ((id,typ),ck) -> ((id^"'",typ),ck)) p
                                          
let rename_def (def:def) : def =
  { id    = def.id ^ "'";
    p_in  = rename_p def.p_in;
    p_out = rename_p def.p_out;
    opt   = def.opt;
    node = match def.node with
           | Single (p_var, body) ->
              Single(rename_p p_var, rename_deq body)
           | Multiple nodes ->
              Multiple(List.map (fun (vars,body) -> rename_p vars, rename_deq body) nodes)
           | _ -> def.node }
     
                                   
let rename_prog (p: prog) : prog =
  { nodes = List.map rename_def p.nodes }

