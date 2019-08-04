(* Abandonning for now due to:
je veux bien ton avis sur un truc: j'ai un noeud `f : b32[4] -> ...`, et je lui passe en argument un `b128`. Pour le moment, usubac se demerde pour que les 2 matchent (`b128` = 1 argument; `b32[4]` = 4 arguments). Du coup, le noeud se retrouve transformé en `f: b1[128]` et son paramètre devient un `b1[128]` également. Le truc, c'est que ca me force à inliner l'appel de fonction (parce que sinon, 128 paramètres pour un appel de fonction; bof), et ca force potentiellement une expansion des paramètres que je n'aime pas. Un truc qui serait envisable, c'est que usubac garde les mêmes types `b32[4]` et `b128`, parce que en C, si t'as `x: bool[128]`, alors tu peux faire `x0=x, x1=&x[32],x2=&x[64],x3=&x[96]` et t'as tes `x:bool* =~ bool[32]` et donc tout se goupille bien. Sauf que du coup ca fait des trucs étranges dans Usuba : ca devient quoi le type du premier param de `f` (appelons le `x`) ? ca ne peut pas rester `x:b32[4]`, parce que dans ce cas, son premier élément sera `x[0][0]` et son 32e `x[1][0]` alors qu'ils devraient etre respectivement `x[0]` et `x[32]`. Si du coup on essaye de donner `b128` comme type à `x`, alors par quoi tu remplace `x[1]`, qui avait pour type `b32` devient désormais quelque chose que `x[32]`, mais qui a pour type `b1` et non `b128` (en C, tu aurais remplacé `x[1]` par `&x[32]` qui a donc pour type `bool* =~ bool[32]`, mais pas vraiment faisable dans Usuba). Any thoughts? on peut en parler en physique si c'est plus simple
 *)

open Usuba_AST
open Basic_utils
open Utils

let stable = ref false


                 
let rec match_lists (env_var:(ident, typ) Hashtbl.t)
                    (expect:p) (given:var list) =
  match expect, given with
  | hd_e::tl_e, hd_g::tl_g ->
     let typ_e = hd_e.vtyp in
     let typ_g = get_var_type env_var hd_g in
     if typ_e = typ_g then
       
  | _ -> assert false
    
let fix_funcall (env_fun:(ident,def) Hashtbl.t)
                (env_var:(ident, typ) Hashtbl.t)
                (lhs:var list)
                (id:ident)
                (args:expr list)
                (sync:bool) : deq =
  let f = Hashtbl.find env_fun id in

  (* args can only be variables *)
  let args = List.map (function ExpVar v -> v | _ -> assert false) args in
  

    
  
let rec fix_deq (env_fun:(ident,def) Hashtbl.t)
                (env_var:(ident, typ) Hashtbl.t)
                (deqs:deq) : deq =
  match deq with
  | Eqn(lhs,Fun(id,args),sync) ->
     if id.name = "rand" then deq
     else fix_funcall env_fun env_var lhs id args sync
  | Eqn _ -> deq
  | Loop(i,ei,ef,dl,opts) ->
     Hashtbl.add env_var i Nat;
     let new_deq = Loop(i,ei,ef,List.map (fix_deq env_fun env_var) dl,opts) in
     Hashtbl.remove env_var i;
     new_deq  
                 

let fix_def (env_fun:(ident,def) Hashtbl.t) (def:def) : unit =
  match def.node with
  | Single(vars,body) ->
     let env_var = build_env_var def.p_in def.p_out vars in
     let body    = List.map (fix_deq env_fun env_var) body in
     Hashtbl.replace env_fun def.id { def with node = Single(vars,body) }
  | _ -> ()

                 
let fix_prog (prog:prog) (conf:config) : prog =

  let env_fun = Hashtbl.create 100 in
  List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

  stable := false;
  while not !stable do
    stable := true;
    List.iter (fun node -> fix_def env_fun (Hashtbl.find env_fun node.id)) prog.nodes
  done;
  
  { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }
  
