open Basic_utils
open Utils
open Usuba_AST

let new_vars = ref []
                
let gen_tmp =
  let cpt = ref 0 in
  fun env_var typ id ->
    incr cpt;
    let var = fresh_ident (Printf.sprintf "_shadow_%s%d_" id !cpt) in
    Hashtbl.add env_var var typ;
    new_vars := (make_var_d var typ Defclock []) :: !new_vars;
    Var var
                

let rec clean_var (env_var : (ident,typ) Hashtbl.t)
                  (env_replace: (var,var) Hashtbl.t)
                  (v:var) : var list =
  match Hashtbl.find_opt env_replace v with
  | Some r -> [ r ]
  | None ->
     match v with
     | Index(v',ae) ->
        (match Hashtbl.find_opt env_replace v' with
         | Some r -> [ Index(r,ae) ]
         | None -> [ v ])
     | Var _ ->
        (match get_var_type env_var v with
        | Uint(_,_,1) -> [ v ]
        | Uint(_,_,n) ->
           let subv = List.map (fun i -> Index(v,Const_e i)) (gen_list_0_int n) in
           let change = List.exists (fun x -> match Hashtbl.find_opt env_replace x with
                                           | Some _ -> true
                                           | None -> false) subv in
           if change then
             List.map (fun x -> match Hashtbl.find_opt env_replace x with
                                | Some x' -> x'
                                | None -> x) subv
           else [ v ]
        | Array(_,n) ->
           let subv = List.map (fun i -> Index(v,Const_e i)) (gen_list_0_int n) in
           let change = List.exists (fun x -> match Hashtbl.find_opt env_replace x with
                                           | Some _ -> true
                                           | None -> false) subv in
           if change then
             List.map (fun x -> match Hashtbl.find_opt env_replace x with
                                | Some x' -> x'
                                | None -> x) subv
           else [ v ]
        | Nat -> [ v ])
     | _ -> assert false
                          

               
        
let rec clean_expr (env_var : (ident,typ) Hashtbl.t)
                   (env_replace: (var,var) Hashtbl.t)
                   (e:expr) : expr =
  let rec_call = clean_expr env_var env_replace in
  match e with
  | Const _         -> e
  | ExpVar v        -> (match clean_var env_var env_replace v with
                        | [ x ] -> ExpVar x
                        | l -> Tuple(List.map (fun x -> ExpVar x) l))
  | Tuple l         -> Tuple (List.map rec_call l)
  | Not e           -> Not (rec_call e)
  | Shift(op,e,ae)  -> Shift(op,rec_call e,ae)
  | Log(op,e1,e2)   -> Log(op,rec_call e1,rec_call e2)
  | Shuffle(v,l)    -> (match clean_var env_var env_replace v with
                        | [ x ] -> Shuffle(x, l)
                        | xs -> Tuple(List.map (fun x -> Shuffle(x,l)) xs))
  | Arith(op,e1,e2) -> Arith(op,rec_call e1,rec_call e2)
  | Fun(f,l)        -> Fun(f,List.map (rec_call) l)
  | _               -> assert false
        
       
let rec clean_deqs (env_var : (ident,typ) Hashtbl.t)
                   (env_replace: (var,var) Hashtbl.t)
                   (deqs:deq list) : deq list =
  List.map (
      function
      | Loop(x,ei,ef,dl,opts) ->
         Hashtbl.add env_var x Nat;
         let res = Loop(x,ei,ef,clean_deqs env_var env_replace dl,opts) in
         Hashtbl.remove env_var x;
         res
      | Eqn(lhs,e,sync) ->
         let e' = clean_expr env_var env_replace e in
         match sync with
         | false -> Eqn(lhs,e',false)
         | true ->
            let tmps = List.map (fun v ->
                                 let typ = get_var_type env_var v in
                                 let v' =  gen_tmp env_var typ (get_base_name v).name in
                                 Hashtbl.add env_replace v v';
                                 v') lhs in
            Eqn(tmps,e',false)
                   
    ) deqs
  
let clean_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     new_vars := [];
     let env_var     = build_env_var def.p_in def.p_out vars in
     let env_replace = Hashtbl.create 100 in
     let new_body    = clean_deqs env_var env_replace body in
     {def with node = Single(vars @ !new_vars, new_body) }
  | _ -> def
       
       
let remove_sync (prog:prog) (conf:config) : prog =
  { nodes = List.map clean_def prog.nodes }
