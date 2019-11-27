open Usuba_AST
open Usuba_print
open Basic_utils
open Utils



let rec simpl_var env_it (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v',ae) -> Index(simpl_var env_it v',Const_e(eval_arith env_it ae))
  | _ -> assert false


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
          (deqs: deq list)
          (no_arr:bool) : unit =

  let cpt = ref cpt_start in

  let rec update_used_bellow env_it last_used (v:var) : unit =
    let v = simpl_var env_it v in
    Hashtbl.replace last_used v !cpt;
    if not no_arr then
      match v with
      | Var _ -> ()
      | Index(v',_) -> update_used_bellow env_it last_used v'
      | _ -> assert false in

  let rec update_used_above env_var env_it last_used (v:var) : unit =
    let v = simpl_var env_it v in
    Hashtbl.replace last_used v !cpt;
    if not no_arr then
      match get_var_type env_var v with
      | Uint(_,_,1) -> ()
      | Uint _ | Array _ -> List.iter (update_used_above env_var env_it last_used)
                                     (expand_var_partial env_var v)
      | _ -> assert false in

  let update_used env_var env_it last_used (v:var) : unit =
    update_used_bellow env_it last_used v;
    update_used_above env_var env_it last_used v in


  List.iter (fun d ->
             match d.content with
             | Eqn(_,e,_) ->
                incr cpt;
                List.iter (update_used env_var env_it last_used)
                          (get_used_vars e)
             | Loop(x,ei,ef,dl,_) ->
                let ei = eval_arith env_it ei in
                let ef = eval_arith env_it ef in
                List.iter (fun i -> Hashtbl.add env_it x i;
                                    get_last_used env_var ~env_it:env_it
                                                  ~cpt_start:!cpt
                                                  last_used dl no_arr;
                                    Hashtbl.remove env_it x)
                          (gen_list_bounds ei ef);
                cpt := !cpt + (List.length dl)
            ) deqs

let share_deqs (p_in:p) (p_out:p) (vars:p) (deqs:deq list) (no_arr:bool) : deq list =

  (* variables and their types *)
  let env_var = build_env_var p_in p_out vars in
  (* last line at which a variable is used *)
  let last_used = Hashtbl.create 1000 in
  get_last_used env_var last_used deqs no_arr;
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
        { deq with content=
        match deq.content with
        | Eqn(lhs,e,sync) ->
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
           Eqn(List.map
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
                   ) lhs, e, sync)
        | Loop(i,ei,ef,dl,opts) ->
           let r = Loop(i,ei,ef,do_it ~cpt_start:!cpt dl,opts) in
           cpt := !cpt + (List.length dl);
           r }
      ) deqs

  in

  do_it deqs



let share_def (def:def) (no_arr:bool) : def =
  match def.node with
  | Single(vars,body) ->
     let body = share_deqs def.p_in def.p_out vars body no_arr in
     { def with node = Single(vars,body) }
  | _ -> def

let share_prog (prog:prog) (conf:config) : prog =
  { nodes = apply_last prog.nodes (fun x -> share_def x conf.no_arr) }
