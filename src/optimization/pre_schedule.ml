(* Note: this file needs a full rework. It's too hacky, poorly written, etc. *)

open Usuba_AST
open Basic_utils
open Utils
open Printf


(* |eqs_ready|: equations ready to be scheduled;
   |vars_avail|: variables available (ie, on the lhs of already
                 scheduled equations)
   |depends|: hashtbl containing for each variable, all equations that
              use it (ie, equations that directly depends on it).

   Loops are not currently handled (this module does nothing on nodes
   containing loops).  *)

(* exception Loop_not_implemented *)

(* let schedule_deqs (env_var:(ident, typ) Hashtbl.t) (eqs_ready: *)

(* (\* Initialize the |depends| hash which contains for each variable, all *)
(*    equations that use it directly. *\) *)
(* let compute_dependencies (env_var:(ident, typ) Hashtbl.t) (deqs:deq list) : *)
(*       (var, deq list) Hashtbl.t = *)
(*   let depends = Hashtbl.create 100 in *)

(*   List.iter *)
(*     (fun d -> *)
(*      match d.content with *)
(*      | Loop _ -> raise Loop_not_implemented *)
(*      | Eqn(lhs,e,_) -> *)
(*         List.iter *)
(*           (fun v -> *)
(*            let prev_deps = match Hashtbl.find_opt depends v with *)
(*              | Some l -> l *)
(*              | None   -> [] in *)
(*            Hashtbl.replace depends v (d :: prev_deps)) *)
(*           (List.map (expand_var env_var) (get_used_vars e))) deqs; *)

(*   deqs *)

(* (\* Adds all variables of |p_in| into a hashmap of available variables. *\) *)
(* let init_vars_avail (p_in:var_d list) = *)
(*   let vars_avail = Hashtbl.create 10 in *)
(*   List.iter (fun vd -> *)
(*              List.iter (fun v -> Hashtbl.add vars_avail vd true) *)
(*                        (expand_vd vd)) p_in; *)
(*   vars_avail *)

(* let schedule_def (def:def) : def = *)
(*   try *)
(*     { def with *)
(*       node = match def.node with *)
(*              | Single(vars,body) -> *)
(*                 let env_var = build_env_var def.p_in def.p_out vars in *)
(*                 let eqs_ready = Hashtbl.create 50 in *)
(*                 let vars_avail = init_vars_avail def.p_in in *)
(*                 let depends = compute_dependencies env_var body in *)
(*                 schedule_deqs env_var eqs_ready vars_avail depends body *)
(*              | _ -> def.node } *)
(*   with Loop_not_implemented -> def *)


(* let schedule (prog:prog) : prog = *)
(*   {nodes = List.map schedule_def prog.nodes } *)











let update_hoh hash k1 k2 =
  match Hashtbl.find_opt hash k1 with
  | Some h -> Hashtbl.replace h k2 true
  | None   -> let h = Hashtbl.create 60 in
              Hashtbl.add h k2 true;
              Hashtbl.add hash k1 h


let rec make_var_ready (env_var: (ident,typ) Hashtbl.t)
                       (ready:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t)
                       (is_sched:(var list*expr,bool) Hashtbl.t)
                       (sched_vars:(var,bool) Hashtbl.t)
                       (var:var) : (var list * expr * ((ident*deq_i) list)) list =
  let rec aux (var:var) : (var list * expr * ((ident*deq_i) list)) list =
    match Hashtbl.find_opt ready var with
    | None      -> (match get_var_type env_var var with
                    | Uint(_,_,1) | Nat -> []
                    | _ -> flat_map aux (expand_var_partial env_var var))
    | Some(l,e,orig) -> match Hashtbl.find_opt is_sched (l,e) with
                        | Some _ -> []
                        | None   -> let prevs = flat_map aux (get_used_vars e) in
                                    Hashtbl.remove ready var;
                                    Hashtbl.add is_sched (l,e) true;
                                    List.iter (fun x -> Hashtbl.add sched_vars x true) l;
                                    (l,e,orig) :: prevs in
  List.rev @@ aux var


let schedule_pre (env_var: (ident,typ) Hashtbl.t)
                 (ready:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t)
                 (is_sched:(var list*expr,bool) Hashtbl.t)
                 (sched_vars:(var,bool) Hashtbl.t)
                 (args:var list) : (var list * expr * ((ident*deq_i) list)) list =
  List.rev @@
    flat_map (make_var_ready env_var ready is_sched sched_vars) args


let schedule_post (deps:(var,(var,bool) Hashtbl.t) Hashtbl.t)
                  (defs:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t)
                  (is_sched:(var list*expr,bool) Hashtbl.t)
                  (sched_vars:(var,bool) Hashtbl.t)
                  (vars:var list) : (var list * expr * ((ident*deq_i) list)) list =
  List.rev @@
    flat_map
        (fun x ->
         flat_map (fun y ->
                   let def = Hashtbl.find defs y in
                   let (vl,e,_) = def in
                   match Hashtbl.find_opt is_sched (vl,e) with
                   | Some _ -> []
                   | None   ->
                      if List.for_all (fun x -> Hashtbl.mem sched_vars x)
                                      (get_used_vars e) then (
                        Hashtbl.add is_sched (vl,e) true;
                        Hashtbl.add sched_vars x true;
                        [ def ])
                      else
                        [] )
                  (keys_2nd_layer deps x)) vars


let schedule_asgn (env_var: (ident,typ) Hashtbl.t)
                  (ready:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t)
                  (is_sched:(var list*expr,bool) Hashtbl.t)
                  (sched_vars:(var,bool) Hashtbl.t)
                  (schedule:(var list * expr * ((ident*deq_i) list)) list ref)
                  (deps:(var,(var,bool) Hashtbl.t) Hashtbl.t)
                  (defs:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t)
                  (orig:(ident*deq_i) list)
                  (l:var list) (e:expr) : unit =
  match e with
  | Fun(f,args) -> schedule := (schedule_pre env_var ready is_sched sched_vars
                                             (flat_map get_used_vars args))
                               @ !schedule;
                   Hashtbl.add is_sched (l,e) true;
                   List.iter (fun x -> Hashtbl.add sched_vars x true) l;
                   schedule := (l,e,orig) :: !schedule;
                   schedule := (schedule_post deps defs is_sched sched_vars l) @ !schedule
  | _ -> List.iter (fun x -> match Hashtbl.find_opt is_sched (l,e) with
                             | Some _ -> ()
                             | None   -> Hashtbl.add ready x (l,e,orig)) l


let get_used_vars_no_fun (e:expr) : var list =
  match e with
  | Fun _ -> []
  | _ -> get_used_vars e

let build_deps (deqs: deq list) =
  let deps_down = Hashtbl.create 500 in
  let deps_up   = Hashtbl.create 500 in
  let defs      = Hashtbl.create 500 in

  List.iter (fun d -> match d.content with
              | Eqn(l,e,_) -> List.iter (fun x ->
                                         List.iter (fun y ->
                                                    update_hoh deps_up x y;
                                                    update_hoh deps_down y x
                                                   ) (get_used_vars_no_fun e);
                                         Hashtbl.add defs x (l,e,d.orig)
                                        ) l
              | _ -> raise (Error "Invalid Loop")
            ) deqs;

  deps_down,deps_up,defs

let schedule_deqs (vars:var_d list) (deqs:deq list) (def:def): deq list =
  let (deps_down,deps_up,defs)  = build_deps deqs in
  let ready    = Hashtbl.create 500 in
  let is_sched = Hashtbl.create 500 in
  let sched_vars = Hashtbl.create 500 in
  let schedule = ref [] in

  let env_var = build_env_var def.p_in def.p_out vars in
  let rec init_sched_vars (v:var) : unit =
    Hashtbl.add sched_vars v true;
    match expand_var_partial env_var v with
    | [ x ] when x = v -> ()
    | l -> List.iter init_sched_vars l in
  List.iter (fun vd -> init_sched_vars (Var vd.vd_id)) def.p_in;

  List.iter (fun d -> match d.content with
              | Eqn(l,e,_) -> schedule_asgn env_var ready is_sched sched_vars
                                            schedule deps_down defs d.orig l e
              | _ -> raise (Error "Invalid Loop")) deqs;

  List.iter (fun d -> match d.content with
              | Eqn(l,e,_) -> ( match Hashtbl.find_opt is_sched (l,e) with
                                | Some _ -> ()
                                | None   -> schedule := (l,e,d.orig) :: !schedule;
                                            Hashtbl.add is_sched (l,e) true)
              | _ -> raise (Error "Invalid Loop")) deqs;

  List.rev_map (fun (x,y,orig) -> { orig=orig; content=Eqn(x,y,false) }) !schedule

let schedule_node (def:def) : def =
  if is_noopt def then def else
    { def with node = match def.node with
                      | Single(vars,deqs) -> Single(vars,schedule_deqs vars deqs def)
                      | _ -> def.node }

let run _ (prog:prog) (_:config) : prog =
  try
    { nodes = List.map schedule_node prog.nodes }
  with Error _ -> prog


let as_pass = (run, "Pre_schedule")
