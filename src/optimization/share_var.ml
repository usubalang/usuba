open Usuba_AST
open Usuba_print
open Basic_utils
open Utils



let rec simpl_var env_it (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v',ae) -> Index(simpl_var env_it v',Const_e(eval_arith env_it ae))
  | _ -> assert false


(* Replace "arrays of arrays" by "arrays": 
   for instance u8x16[10] becomes u8x16
   (if possible)
*)
module Linearize_arrays = struct

  exception Keep_it

  let update_vars to_linearize (vars:p) : p =
    let rec simpl_type (typ:typ) : typ =
      match typ with
      | Array(Int(n,m),_) -> Int(n,m)
      | Array(Array(typ',ae),_) -> Array(typ',ae)
      | _ -> assert false in
    
    List.map (fun vd -> match Hashtbl.find_opt to_linearize vd.vid with
                        | Some _ -> { vd with vtyp = simpl_type vd.vtyp }
                        | None -> vd) vars
             
              
  let rec replace_var to_linearize (v:var) : var =
    match v with
    | Var _ -> v
    | Index(Var id,_) ->
       begin match Hashtbl.find_opt to_linearize id with
             | Some _ -> Var id
             | None -> v end
    | Index(v',i) -> Index(replace_var to_linearize v',i)
    | _ -> assert false

  let rec replace_expr to_linearize (e:expr) : expr =
    match e with
    | Const _        -> e
    | ExpVar v       -> ExpVar (replace_var to_linearize v)
    | Tuple l        -> Tuple (List.map (replace_expr to_linearize) l)
    | Not e          -> Not (replace_expr to_linearize e)
    | Shift(op,e,ae) -> Shift(op,replace_expr to_linearize e,ae)
    | Log(op,x,y)    -> Log(op,replace_expr to_linearize x,
                            replace_expr to_linearize y)
    | Arith(op,x,y)  -> Arith(op,replace_expr to_linearize x,
                              replace_expr to_linearize y)
    | Shuffle(v,pat) -> Shuffle(replace_var to_linearize v,pat)
    | Fun(f,l)       -> Fun(f,List.map (replace_expr to_linearize) l)
    | _ -> assert false

    
  let rec linearize to_linearize (deqs:deq list) : deq list =
    List.map (function
               | Norec(v,e) -> Norec(List.map (replace_var to_linearize) v,
                                     replace_expr to_linearize e)
               | Rec(i,ei,ef,dl,opts) -> Rec(i,ei,ef,linearize to_linearize dl,opts)) deqs
              
  let rec try_linear ?(env_it=Hashtbl.create 10)
                     ?(idx=ref (-1))
                     (deqs:deq list)
                     (id:ident) : unit =
    
    List.iter (
        function
        | Norec(lhs,e) ->
           List.iter (
               fun v ->
               match v with
               | Index(Var v',Const_e n)
               | Index(Index(Var v',Const_e n),_) when v' = id ->
                  if !idx <> -1 && n <> !idx then raise Keep_it
               | Var v' when v' = id -> raise Keep_it
               | _ -> ()
             ) (List.map (simpl_var env_it) (get_used_vars e));
           let new_idx = ref (-1) in
           List.iter (fun v -> match v with
                               | Index(Var v',Const_e n)
                               | Index(Index(Var v',Const_e n),_) when v' = id ->
                                  if !new_idx = -1 then
                                    new_idx := n
                                  else if !new_idx <> n then
                                    raise Keep_it
                               | _ -> ()) lhs;
           idx := !new_idx
        | Rec(x,ei,ef,dl,_) ->
           let ei = eval_arith env_it ei in
           let ef = eval_arith env_it ef in
           List.iter (fun i -> Hashtbl.add env_it x i;
                               try_linear ~env_it:env_it ~idx:idx dl id;
                               Hashtbl.remove env_it x) (gen_list_bounds ei ef)
      ) deqs
  
  let get_2d_arrays (vars:p) : p =
    List.filter (fun vd ->
                 match vd.vtyp with
                 | Array(Array(Bool,_),_) ->  true
                 | Array(Array(Int(_,1),_),_) -> true
                 | Array(Int(_,m),_) when m > 1 -> true
                 | _ -> false) vars

  let linearize_def (def:def) : def =
    match def.node with
    | Single(vars,body) ->
       let to_linearize = Hashtbl.create 100 in
       List.iter (fun vd ->
                  try try_linear body vd.vid;
                      Hashtbl.replace to_linearize vd.vid true
                  with Keep_it -> ()) (get_2d_arrays vars);
       let vars = update_vars to_linearize vars in
       let body = linearize to_linearize body in
       { def with node = Single(vars,body) }
    | _ -> def

  let linearize_arrays (prog:prog) : prog =
    { nodes = List.map linearize_def prog.nodes }

end



            
let rec replace_var (env:(var,var) Hashtbl.t) (v:var) : var =
  match Hashtbl.find_opt env v with
  | Some v' -> v'
  | None ->  match v with
             | Var _ -> v
             | Index(v',ae) -> Index(replace_var env v',ae)
             | _ -> assert false
                
let rec replace_expr
          (env:(var,var) Hashtbl.t)
          (e:expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> ExpVar (replace_var env v)
  | Shuffle(v,l) -> Shuffle(replace_var env v,l)
  | Tuple l -> Tuple(List.map (replace_expr env) l)
  | Not e -> Not(replace_expr env e)
  | Shift(op,x,y) -> Shift(op,replace_expr env x,y)
  | Log(op,x,y) -> Log(op,replace_expr env x, replace_expr env y)
  | Arith(op,x,y) -> Arith(op,replace_expr env x, replace_expr env y)
  | Fun(f,l) -> Fun(f,List.map (replace_expr env) l)
  | _ -> assert false


let rec get_last_used
          (env_var:(ident,typ) Hashtbl.t)
          ?(env_it=Hashtbl.create 100)
          (last_used:(var,int) Hashtbl.t)
          ?(cpt_start=0)
          (deqs: deq list) : unit =

  let cpt = ref cpt_start in

  let rec update_used_bellow env_it last_used (v:var) : unit =
    let v = simpl_var env_it v in
    Hashtbl.replace last_used v !cpt;    
    match v with
    | Var _ -> ()
    | Index(v',_) -> update_used_bellow env_it last_used v'
    | _ -> assert false in

  let rec update_used_above env_var env_it last_used (v:var) : unit =
    let v = simpl_var env_it v in
    Hashtbl.replace last_used v !cpt;
    match get_var_type env_var v with
    | Bool | Int(_,1) -> ()
    | Int _ | Array _ -> List.iter (update_used_above env_var env_it last_used)
                                   (expand_var_partial env_var v)
    | _ -> assert false in
  
  let update_used env_var env_it last_used (v:var) : unit =
    update_used_bellow env_it last_used v;
    update_used_above env_var env_it last_used v in
    
  
  List.iter (fun d ->
             match d with
             | Norec(_,e) ->
                incr cpt;
                List.iter (update_used env_var env_it last_used)
                          (get_used_vars e)
             | Rec(x,ei,ef,dl,_) ->
                let ei = eval_arith env_it ei in
                let ef = eval_arith env_it ef in
                List.iter (fun i -> Hashtbl.add env_it x i;
                                    get_last_used env_var ~env_it:env_it
                                                  ~cpt_start:!cpt
                                                  last_used dl;
                                    Hashtbl.remove env_it x)
                          (gen_list_bounds ei ef);
                cpt := !cpt + (List.length dl)
            ) deqs
             
let share_deqs (p_in:p) (p_out:p) (vars:p) (deqs:deq list) : deq list =

  (* variables and their types *)
  let env_var = build_env_var p_in p_out vars in
  (* last line at which a variable is used *)
  let last_used = Hashtbl.create 1000 in
  get_last_used env_var last_used deqs;
  (* The inputs (that shouldn't be overused I think) *)
  let env_in = Hashtbl.create 100 in
  List.iter (fun vd -> Hashtbl.replace env_in (Var vd.vid) true) p_in;
  (* out variables, should be kept *)
  let env_out = Hashtbl.create 100 in
  List.iter (fun vd -> Hashtbl.replace env_out (Var vd.vid) true) p_out;
  (* replacement env for variables that have been replaced *)
  let env_replace = Hashtbl.create 1000 in

  let rec do_it ?(cpt_start=0) (deqs:deq list) : deq list =
    let cpt = ref cpt_start in
    List.map (
        fun deq ->
        match deq with
        | Norec(lhs,e) ->
           let e = replace_expr env_replace e in
           let lhs = List.map (replace_var env_replace) lhs in
           incr cpt;
           let avail = List.filter
                         (fun v ->
                          match Hashtbl.find_opt env_in (get_var_base v) with
                          | Some _ -> false
                          | None -> match Hashtbl.find_opt last_used v with
                                    | Some n -> n <= !cpt
                                    | None -> false)
                         (get_used_vars e) in
           let used = Hashtbl.create 10 in
           Norec(List.map
                   (fun v ->
                    match Hashtbl.find_opt env_out (get_var_base v) with
                    | Some _ -> v
                    | None ->
                       let typ = get_var_type env_var (get_var_base v) in
                       match List.find_opt
                               (fun v ->
                                (not (Hashtbl.mem used v))
                                && (typ = get_var_type env_var (get_var_base v))) avail with
                       | Some v' ->
                          Hashtbl.add used v' true;
                          Hashtbl.replace env_replace (get_var_base v) (get_var_base v');
                          (try
                              Hashtbl.replace last_used v' (Hashtbl.find last_used v)
                            with Not_found -> Printf.fprintf stderr "Not_found: %s.\n"
                                                             (Usuba_print.var_to_str v');
                                              raise Not_found);
                            v'
                       | None -> v
                   ) lhs, e)
        | Rec(i,ei,ef,dl,opts) -> 
           let r = Rec(i,ei,ef,do_it ~cpt_start:!cpt dl,opts) in
           cpt := !cpt + (List.length dl);
           r
      ) deqs
  
  in

  do_it deqs
           
  
      
let share_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let body = share_deqs def.p_in def.p_out vars body in
     { def with node = Single(vars,body) }
  | _ -> def
           
let share_prog (prog:prog) : prog =
  (* { nodes = List.map share_def prog.nodes } *)
  let prog = Linearize_arrays.linearize_arrays prog in
  if true then
    { nodes = apply_last prog.nodes share_def }
  else
    prog
