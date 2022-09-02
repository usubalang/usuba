(* Note: this file needs a full rework. It's too hacky, poorly written, etc. *)

open Prelude
open Usuba_AST
open Basic_utils
open Utils

(* |eqs_ready|: equations ready to be scheduled;
   |vars_avail|: variables available (ie, on the lhs of already
                 scheduled equations)
   |depends|: hashtbl containing for each variable, all equations that
              use it (ie, equations that directly depends on it).

   Loops are not currently handled (this module does nothing on nodes
   containing loops). *)

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

(* We use a custom get_used_vars (divided into
   get_uses_vars_{var,expr,deq}) because of iterators: when a variable
   depends on the value of an iterator (ie, it's an Index), it need to
   be expanded into all the variables it will become. For instance:

     forall i in [0, 3] {
       ... = ... x[i] ...
     }

   |x| should be expanded into [ x[0], x[1], x[2], x[3] ].
*)

(* Returns the iterators (=~ variables) used in an arithmetic
   expression. *)
let rec get_iterators (ae : arith_expr) : ident list =
  match ae with
  | Const_e _ -> []
  | Var_e x -> [ x ]
  | Op_e (_, x, y) -> get_iterators x @ get_iterators y

(* Returns a list of arith_expr containing all values |ae| can take
   depending on the iterators in |its|. *)
let expand_with_iterators (its : (ident * arith_expr * arith_expr) list)
    (ae : arith_expr) : arith_expr list =
  let used_iterators = Ident.Hashtbl.create 10 in
  List.iter
    (fun idx -> Ident.Hashtbl.add used_iterators idx true)
    (get_iterators ae);
  let env_it = Ident.Hashtbl.create 10 in
  let rec aux (remaining : (ident * arith_expr * arith_expr) list) :
      arith_expr list =
    match remaining with
    | [] -> [ simpl_arith env_it ae ]
    | (idx, ei, ef) :: tl ->
        if Ident.Hashtbl.mem used_iterators idx then
          let ei = eval_arith env_it ei in
          let ef = eval_arith env_it ef in
          flat_map
            (fun i ->
              Ident.Hashtbl.add env_it idx i;
              let r = aux tl in
              Ident.Hashtbl.remove env_it idx;
              r)
            (gen_list_bounds ei ef)
        else (* Iterator not used in |ae|, skipping it *)
          aux tl
  in
  aux (List.rev its)

(* Returns all the variables a var |v| can represent depending on
   |its|. *)
let rec get_used_vars_var (its : (ident * arith_expr * arith_expr) list)
    (env_var : typ Ident.Hashtbl.t) (v : var) : var list =
  match v with
  | Var _ -> [ v ]
  | Index (v', ae) -> (
      let vl = get_used_vars_var its env_var v' in
      match simpl_arith_ne ae with
      | Const_e n -> List.map (fun v'' -> Index (v'', Const_e n)) vl
      | ae' ->
          (* The index contains one or more variables *)
          let all_ae = expand_with_iterators its ae' in
          flat_map (fun v'' -> List.map (fun i -> Index (v'', i)) all_ae) vl)
  | _ -> assert false

(* Shadowing the definition above *)
let get_used_vars_var (its : (ident * arith_expr * arith_expr) list)
    (env_var : typ Ident.Hashtbl.t) (v : var) : var list =
  let vl = get_used_vars_var its env_var v in
  flat_map (expand_var env_var) vl

(* Returns the variables used in an expr (concretized with |its|) *)
let rec get_used_vars_expr (its : (ident * arith_expr * arith_expr) list)
    (env_var : typ Ident.Hashtbl.t) (e : expr) : var list =
  match e with
  | Const _ -> []
  | ExpVar v -> get_used_vars_var its env_var v
  | Shuffle (v, _) -> get_used_vars_var its env_var v
  | Tuple l -> flat_map (get_used_vars_expr its env_var) l
  | Not e -> get_used_vars_expr its env_var e
  | Shift (_, e, _) -> get_used_vars_expr its env_var e
  | Log (_, x, y) | Arith (_, x, y) ->
      get_used_vars_expr its env_var x @ get_used_vars_expr its env_var y
  | Fun (_, l) -> flat_map (get_used_vars_expr its env_var) l
  | _ -> assert false

(* Returns the variables used in a deq (concretized with |its|) *)
let rec get_used_vars_deq (its : (ident * arith_expr * arith_expr) list)
    (env_var : typ Ident.Hashtbl.t) (deq : deq) : var list =
  match deq.content with
  | Eqn (_, e, _) -> get_used_vars_expr its env_var e
  | Loop { id; start; stop; body; _ } ->
      let its = (id, start, stop) :: its in
      flat_map (get_used_vars_deq its env_var) body

let rec schedule_preds (its : (ident * arith_expr * arith_expr) list)
    (env_var : typ Ident.Hashtbl.t) (ready : deq VarHashtbl.t)
    (computed : bool DeqHashtbl.t) (result : deq list ref) (deq : deq) : unit =
  List.iter
    (fun v ->
      match VarHashtbl.find_opt ready v with
      | Some deq' ->
          if DeqHashtbl.mem computed deq' then ()
          else (
            (* Starting by adding current |deq| to |computed|
               to avoid any cycle in the recursive call below *)
            DeqHashtbl.add computed deq' true;
            schedule_preds its env_var ready computed result deq';
            result := deq' :: !result)
      | None -> ())
    (get_used_vars_deq its env_var deq)

let add_to_ready (its : (ident * arith_expr * arith_expr) list)
    (env_var : typ Ident.Hashtbl.t) (ready : deq VarHashtbl.t) (lhs : var list)
    (deq : deq) : unit =
  List.iter
    (fun v -> VarHashtbl.add ready v deq)
    (flat_map (get_used_vars_var its env_var) lhs)

let rec schedule_deqs (its : (ident * arith_expr * arith_expr) list)
    (env_var : typ Ident.Hashtbl.t) (deqs : deq list) : deq list =
  let result = ref [] in
  (* |deqs| but correctly scheduled; to be reversed at the end. *)
  let computed = DeqHashtbl.create 10 in
  (* Variables already computed *)
  let ready = VarHashtbl.create 10 in

  (* Equations ready to be scheduled *)
  List.iter
    (fun deq ->
      match deq.content with
      | Eqn (_, Fun _, _) ->
          schedule_preds its env_var ready computed result deq;
          DeqHashtbl.add computed deq true;
          result := deq :: !result
      | Eqn (lhs, _, _) -> add_to_ready its env_var ready lhs deq
      | Loop t ->
          DeqHashtbl.add computed deq true;
          let its = (t.id, t.start, t.stop) :: its in
          schedule_preds its env_var ready computed result deq;
          result :=
            {
              deq with
              content = Loop { t with body = schedule_deqs its env_var t.body };
            }
            :: !result)
    deqs;

  (* Scheduling unscheduled equations (the ones that don't call
     functions and whose return values are not used in any function
     call.
     Since the code was already scheduled before calling this module,
     there is no need to call schedule_preds in this step. *)
  List.iter
    (fun deq ->
      if DeqHashtbl.mem computed deq then () else result := deq :: !result)
    deqs;

  List.rev !result

(* Returns true if |deqs| contains a function call. *)
let rec deqs_contain_funcall (deqs : deq list) : bool =
  List.exists
    (fun deqs ->
      match deqs.content with
      | Eqn (_, Fun _, _) -> true
      | Eqn _ -> false
      | Loop { body; _ } -> deqs_contain_funcall body)
    deqs

(*

*)
let schedule_def (def : def) : def =
  {
    def with
    node =
      (match def.node with
      | Single (vars, body) ->
          if deqs_contain_funcall body then
            let env_var = build_env_var def.p_in def.p_out vars in
            let body = schedule_deqs [] env_var body in
            Single (vars, body)
          else
            (* If |body| contains no funcall, lets save some time and
               avoid completely messing the initial scheduling *)
            Single (vars, body)
      | _ -> def.node);
  }

let run _ (prog : prog) _ : prog = { nodes = List.map schedule_def prog.nodes }
let as_pass = (run, "Pre_schedule", 0)

module Test = struct
  let test () = ()
end
(* let update_hoh hash k1 k2 = *)
(*   match Hashtbl.find_opt hash k1 with *)
(*   | Some h -> Hashtbl.replace h k2 true *)
(*   | None   -> let h = Hashtbl.create 60 in *)
(*               Hashtbl.add h k2 true; *)
(*               Hashtbl.add hash k1 h *)

(* let rec make_var_ready (env_var: (ident,typ) Hashtbl.t) *)
(*                        (ready:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t) *)
(*                        (is_sched:(var list*expr,bool) Hashtbl.t) *)
(*                        (sched_vars:(var,bool) Hashtbl.t) *)
(*                        (var:var) : (var list * expr * ((ident*deq_i) list)) list = *)
(*   let rec aux (var:var) : (var list * expr * ((ident*deq_i) list)) list = *)
(*     match Hashtbl.find_opt ready var with *)
(*     | None      -> (match get_var_type env_var var with *)
(*                     | Uint(_,_,1) | Nat -> [] *)
(*                     | _ -> flat_map aux (expand_var_partial env_var var)) *)
(*     | Some(l,e,orig) -> match Hashtbl.find_opt is_sched (l,e) with *)
(*                         | Some _ -> [] *)
(*                         | None   -> let prevs = flat_map aux (get_used_vars e) in *)
(*                                     Hashtbl.remove ready var; *)
(*                                     Hashtbl.add is_sched (l,e) true; *)
(*                                     List.iter (fun x -> Hashtbl.add sched_vars x true) l; *)
(*                                     (l,e,orig) :: prevs in *)
(*   List.rev @@ aux var *)

(* let schedule_pre (env_var: (ident,typ) Hashtbl.t) *)
(*                  (ready:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t) *)
(*                  (is_sched:(var list*expr,bool) Hashtbl.t) *)
(*                  (sched_vars:(var,bool) Hashtbl.t) *)
(*                  (args:var list) : (var list * expr * ((ident*deq_i) list)) list = *)
(*   List.rev @@ *)
(*     flat_map (make_var_ready env_var ready is_sched sched_vars) args *)

(* let schedule_post (deps:(var,(var,bool) Hashtbl.t) Hashtbl.t) *)
(*                   (defs:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t) *)
(*                   (is_sched:(var list*expr,bool) Hashtbl.t) *)
(*                   (sched_vars:(var,bool) Hashtbl.t) *)
(*                   (vars:var list) : (var list * expr * ((ident*deq_i) list)) list = *)
(*   List.rev @@ *)
(*     flat_map *)
(*         (fun x -> *)
(*          flat_map (fun y -> *)
(*                    let def = Hashtbl.find defs y in *)
(*                    let (vl,e,_) = def in *)
(*                    match Hashtbl.find_opt is_sched (vl,e) with *)
(*                    | Some _ -> [] *)
(*                    | None   -> *)
(*                       if List.for_all (fun x -> Hashtbl.mem sched_vars x) *)
(*                                       (get_used_vars e) then ( *)
(*                         Hashtbl.add is_sched (vl,e) true; *)
(*                         Hashtbl.add sched_vars x true; *)
(*                         [ def ]) *)
(*                       else *)
(*                         [] ) *)
(*                   (keys_2nd_layer deps x)) vars *)

(* let schedule_asgn (env_var: (ident,typ) Hashtbl.t) *)
(*                   (ready:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t) *)
(*                   (is_sched:(var list*expr,bool) Hashtbl.t) *)
(*                   (sched_vars:(var,bool) Hashtbl.t) *)
(*                   (schedule:(var list * expr * ((ident*deq_i) list)) list ref) *)
(*                   (deps:(var,(var,bool) Hashtbl.t) Hashtbl.t) *)
(*                   (defs:(var,var list * expr * ((ident*deq_i) list)) Hashtbl.t) *)
(*                   (orig:(ident*deq_i) list) *)
(*                   (l:var list) (e:expr) : unit = *)
(*   match e with *)
(*   | Fun(f,args) -> schedule := (schedule_pre env_var ready is_sched sched_vars *)
(*                                              (flat_map get_used_vars args)) *)
(*                                @ !schedule; *)
(*                    Hashtbl.add is_sched (l,e) true; *)
(*                    List.iter (fun x -> Hashtbl.add sched_vars x true) l; *)
(*                    schedule := (l,e,orig) :: !schedule; *)
(*                    schedule := (schedule_post deps defs is_sched sched_vars l) @ !schedule *)
(*   | _ -> List.iter (fun x -> match Hashtbl.find_opt is_sched (l,e) with *)
(*                              | Some _ -> () *)
(*                              | None   -> Hashtbl.add ready x (l,e,orig)) l *)

(* let get_used_vars_no_fun (e:expr) : var list = *)
(*   match e with *)
(*   | Fun _ -> [] *)
(*   | _ -> get_used_vars e *)

(* let build_deps (deqs: deq list) = *)
(*   let deps_down = Hashtbl.create 500 in *)
(*   let deps_up   = Hashtbl.create 500 in *)
(*   let defs      = Hashtbl.create 500 in *)

(*   List.iter (fun d -> match d.content with *)
(*               | Eqn(l,e,_) -> List.iter (fun x -> *)
(*                                          List.iter (fun y -> *)
(*                                                     update_hoh deps_up x y; *)
(*                                                     update_hoh deps_down y x *)
(*                                                    ) (get_used_vars_no_fun e); *)
(*                                          Hashtbl.add defs x (l,e,d.orig) *)
(*                                         ) l *)
(*               | _ -> raise (Error "Invalid Loop") *)
(*             ) deqs; *)

(*   deps_down,deps_up,defs *)

(* let schedule_deqs (vars:var_d list) (deqs:deq list) (def:def): deq list = *)
(*   let (deps_down,deps_up,defs)  = build_deps deqs in *)
(*   let ready    = Hashtbl.create 500 in *)
(*   let is_sched = Hashtbl.create 500 in *)
(*   let sched_vars = Hashtbl.create 500 in *)
(*   let schedule = ref [] in *)

(*   let env_var = build_env_var def.p_in def.p_out vars in *)
(*   let rec init_sched_vars (v:var) : unit = *)
(*     Hashtbl.add sched_vars v true; *)
(*     match expand_var_partial env_var v with *)
(*     | [ x ] when x = v -> () *)
(*     | l -> List.iter init_sched_vars l in *)
(*   List.iter (fun vd -> init_sched_vars (Var vd.vd_id)) def.p_in; *)

(*   List.iter (fun d -> match d.content with *)
(*               | Eqn(l,e,_) -> schedule_asgn env_var ready is_sched sched_vars *)
(*                                             schedule deps_down defs d.orig l e *)
(*               | _ -> raise (Error "Invalid Loop")) deqs; *)

(*   List.iter (fun d -> match d.content with *)
(*               | Eqn(l,e,_) -> ( match Hashtbl.find_opt is_sched (l,e) with *)
(*                                 | Some _ -> () *)
(*                                 | None   -> schedule := (l,e,d.orig) :: !schedule; *)
(*                                             Hashtbl.add is_sched (l,e) true) *)
(*               | _ -> raise (Error "Invalid Loop")) deqs; *)

(*   List.rev_map (fun (x,y,orig) -> { orig=orig; content=Eqn(x,y,false) }) !schedule *)

(* let schedule_node (def:def) : def = *)
(*   if is_noopt def then def else *)
(*     { def with node = match def.node with *)
(*                       | Single(vars,deqs) -> Single(vars,schedule_deqs vars deqs def) *)
(*                       | _ -> def.node } *)

(* let run _ (prog:prog) (conf:config) : prog = *)
(*   try *)
(*     { nodes = List.map schedule_node prog.nodes } *)
(*   with Error _ -> prog *)

(* let as_pass = (run, "Pre_schedule") *)
