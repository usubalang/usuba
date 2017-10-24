open Usuba_AST
open Utils
       
                      
let update_hoh hash k1 k2 =
  match Hashtbl.find_opt hash k1 with
  | Some h -> Hashtbl.replace h k2 true
  | None   -> let h = Hashtbl.create 60 in
              Hashtbl.add h k2 true;
              Hashtbl.add hash k1 h


let make_var_ready (ready:(var,var list * expr) Hashtbl.t)
                   (is_sched:(var list*expr,bool) Hashtbl.t)
                   (var:var) : (var list * expr) list =
  let rec aux (var:var) : (var list * expr) list =
    match Hashtbl.find_opt ready var with
    | None      -> []
    | Some(l,e) -> match Hashtbl.find_opt is_sched (l,e) with
                   | Some _ -> []
                   | None   -> let prevs = List.flatten @@
                                             List.map aux (get_used_vars e) in
                               Hashtbl.remove ready var;
                               Hashtbl.add is_sched (l,e) true;
                               (l,e) :: prevs in
  List.rev @@ aux var

                  
let schedule_pre (ready:(var,var list * expr) Hashtbl.t)
                 (is_sched:(var list*expr,bool) Hashtbl.t)
                 (args:var list) : (var list * expr) list =
  List.rev @@
    List.flatten @@
      List.map (make_var_ready ready is_sched) args


let schedule_post (deps:(var,(var,bool) Hashtbl.t) Hashtbl.t)
                  (defs:(var,var list * expr) Hashtbl.t)
                  (is_sched:(var list*expr,bool) Hashtbl.t)
                  (vars:var list) : (var list * expr) list =
  List.rev @@
    List.flatten @@
      List.map (fun x ->
                List.flatten @@
                  List.map (fun y -> let def = Hashtbl.find defs y in
                                     match Hashtbl.find_opt is_sched def with
                                     | Some _ -> []
                                     | None   -> Hashtbl.add is_sched def true;
                                                 [ def ])
                           (keys_2nd_layer deps x)) vars
             
             
let schedule_asgn (ready:(var,var list * expr) Hashtbl.t)
                  (is_sched:(var list*expr,bool) Hashtbl.t)
                  (schedule:(var list * expr) list ref)
                  (deps:(var,(var,bool) Hashtbl.t) Hashtbl.t)
                  (defs:(var,var list * expr) Hashtbl.t)
                  (l:var list) (e:expr) : unit =  
  match e with
  | Fun(f,args) -> schedule := (schedule_pre ready is_sched
                                             (List.flatten
                                                (List.map get_used_vars args)))
                               @ !schedule;
                   Hashtbl.add is_sched (l,e) true;
                   schedule := (l,e) :: !schedule;
                   schedule := (schedule_post deps defs is_sched l) @ !schedule
  | _ -> List.iter (fun x -> match Hashtbl.find_opt is_sched (l,e) with
                             | Some _ -> ()
                             | None   -> Hashtbl.add ready x (l,e)) l


let get_used_vars_no_fun (e:expr) : var list =
  match e with
  | Fun _ -> []
  | _ -> get_used_vars e
                   
let build_deps (deqs: deq list) =
  let deps_down = Hashtbl.create 500 in
  let deps_up   = Hashtbl.create 500 in
  let defs      = Hashtbl.create 500 in

  List.iter (function
              | Norec(l,e) -> List.iter (fun x -> 
                                         List.iter (fun y ->
                                                    update_hoh deps_up x y;
                                                    update_hoh deps_down y x
                                                   ) (get_used_vars_no_fun e);
                                         Hashtbl.add defs x (l,e)
                                        ) l
              | _ -> raise (Error "Invalid Rec")
            ) deqs;

  deps_down,deps_up,defs
                   
let schedule_deqs (deqs:deq list) : deq list =
  let (deps_down,deps_up,defs)  = build_deps deqs in
  let ready    = Hashtbl.create 500 in
  let is_sched = Hashtbl.create 500 in
  let schedule = ref [] in
  
  List.iter (function
              | Norec(l,e) -> schedule_asgn ready is_sched schedule deps_down defs l e
              | _ -> raise (Error "Invalid Rec")) deqs;

  List.iter (function
              | Norec(l,e) -> ( match Hashtbl.find_opt is_sched (l,e) with
                                | Some _ -> ()
                                | None   -> schedule := (l,e) :: !schedule;
                                            Hashtbl.add is_sched (l,e) true)
              | _ -> raise (Error "Invalid Rec")) deqs;

  List.rev_map (fun (x,y) -> Norec(x,y)) !schedule
       
let schedule_node (def:def) : def =
  { def with node = match def.node with
                    | Single(vars,deqs) -> Single(vars,schedule_deqs deqs)
                    | _ -> def.node }
       
let schedule (prog:prog) : prog =
  { nodes = List.map schedule_node prog.nodes }
  
  
