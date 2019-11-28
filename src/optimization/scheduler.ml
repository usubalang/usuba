open Usuba_AST
open Basic_utils
open Utils

(* Without doing any scheduling, the performances are:
    - 6.339 moves
    ~ 0.47 s

*)


module Basic_scheduler = struct
  (* Algorithm:
      Schedule an instruction just before it's being used.
      So basically,
        x1 = 1;
        x2 = 2;
        y1 = x1 + 1;
        y2 = x2 + 1;
      Becomes
        x1 = 1;
        y1 = x1 + 1;
        x2 = 2;
        y2 = x2 + 1;
      Doing this for every instruction would create long chains and result in a poor
      scheduling as several instruction depend on the same variables. As a compromise,
      when limit the size of the chain to 2: when we arrive on an instruction, if it
      has unscheduled dependencies, then we schedule them and it; otherwise, we wait
      to schedule it.


     Performances:
      - 6.488 moves
      ~ 0.45 s
   *)

  let schedule_deqs (deqs:deq list) : deq list =
    let deflist = Hashtbl.create 10 in
    let dep_deqs =
      flat_map (
            fun d ->
            (match d.content with
             | Eqn(p,e,_) -> (
               match p with
               | [Var v] ->
                  let used = get_used_vars e in
                  let pre = flat_map
                              (fun x -> match Hashtbl.find_opt deflist x with
                                        | Some(e,orig) -> Hashtbl.remove deflist x;
                                                    [ [x],e,orig ]
                                        | None -> []) used in
                  (match pre with
                   | [] -> Hashtbl.add deflist (Var v) (e,d.orig); []
                   | _ -> pre @ [ (p,e,d.orig) ])
               | _ ->
                  let used = get_used_vars e in
                  let pre = flat_map
                              (fun x -> match Hashtbl.find_opt deflist x with
                                        | Some(e,orig) -> Hashtbl.remove deflist x;
                                                    [ [x],e,orig ]
                                        | None -> []) used in
                  pre @ [p,e,d.orig])
             | Loop _ -> raise (Error "Invalid Loop"))) deqs in
    List.map (fun (x,y,orig) -> { orig=orig; content=Eqn(x,y,false) })
             (dep_deqs @ (Hashtbl.fold (fun k (e,orig) acc -> ([k],e,orig) :: acc) deflist []))



  let schedule_def (def:def) : def =
    { def with node = match def.node with
                      | Single(vars,body) ->
                         Single(vars,schedule_deqs body)
                      | _ -> def.node }

  let schedule (prog:prog) : prog =
    { nodes = List.map schedule_def prog.nodes }

end

module Random_scheduler = struct
  (* Algorithm:
      Choose an random instruction ready to be scheduled, and schedule it.

     Perf:
      ~ 7.700 moves
      ~ 0.50 s
   *)

  let schedule_deqs (deqs: deq list) (p_in: p) : deq list =
    let init hash v =
      match Hashtbl.find_opt hash v with
      | Some l -> l
      | None -> let l = ref [] in
                Hashtbl.add hash v l;
                l in

    Random.self_init ();

    let imply : (var, deq list ref) Hashtbl.t = Hashtbl.create 100 in
    let status : (deq, int ref) Hashtbl.t = Hashtbl.create 100 in
    let scheduling : deq list ref = ref [] in

    (* Initializing dependance graph *)
    List.iter
      (fun eq -> match eq.content with
                 | Eqn(_,e,_) ->
                    let prec = get_used_vars e in
                    List.iter ( fun x ->
                                let l = init imply x in
                                l := eq :: !l
                              ) prec;
                    Hashtbl.add status eq (ref (List.length prec))
                 | _ -> assert false) deqs;

    (* Setting successors of p_in to ready *)
    List.iter
      (fun vd ->
       let v = Var vd.vid in
       match Hashtbl.find_opt imply v with
       | Some l ->
          List.iter
            (fun eq ->
             match Hashtbl.find_opt status eq with
             | Some n -> decr n
             | None -> ()) !l
       | None -> ()) p_in;

    (* Actually scheduling the code *)
    while Hashtbl.length status > 0 do
      let ready = Hashtbl.fold (fun e n acc -> if !n = 0 then e::acc else acc) status [] in
      let selected = List.nth ready (Random.int (List.length ready)) in
      Hashtbl.remove status selected;
      scheduling := selected :: !scheduling;
      match selected.content with
      | Eqn(p,_,_) -> List.iter
                        (fun p ->
                         (match Hashtbl.find_opt imply p with
                          | Some l ->
                             List.iter (fun x -> match Hashtbl.find_opt status x with
                                                 | Some n -> decr n
                                                 | None -> ()) !l
                          | None -> ())) p
      | _ -> assert false
    done;

    (* Need to reverse as we added elements in 1st position in the list *)
    List.rev !scheduling

  let schedule_def (def:def) : def =
    { def with node = match def.node with
                      | Single(vars,body) ->
                         Single(vars,schedule_deqs body def.p_in)
                      | _ -> def.node }


  let schedule (prog:prog) : prog =
    { nodes = List.map schedule_def prog.nodes }
end


module Depth_first_sched = struct
  (* Algorithm:
       Try to schedule an instruction s. If it has missing pre-requisite dependencies,
       then schedule them first. Afterward, schedule all the instructions that were
       depending on s.

     Performances:
       - 7.040 moves
       ~ 0.47 s
   *)

  let exists hash k =
    try Hashtbl.find hash k; true
    with Not_found -> false

  let update_hoh hash k1 k2 =
    match Hashtbl.find_opt hash k1 with
    | Some h -> Hashtbl.replace h k2 true
    | None   -> let h = Hashtbl.create 60 in
                Hashtbl.add h k2 true;
                Hashtbl.add hash k1 h

  type node = { current: var list * expr; sons: node list; father: node list }

  let build_dep (deqs: deq list) :
        (var,(var list * expr * ((ident*deq_i) list),bool) Hashtbl.t) Hashtbl.t
        * (var,(var list * expr * ((ident*deq_i) list))) Hashtbl.t =
    let using = Hashtbl.create 1000 in
    let decls = Hashtbl.create 1000 in

    List.iter (fun d -> match d.content with
                | Eqn(l,e,_) ->
                   let used = get_used_vars e in
                   List.iter (fun x -> update_hoh using x (l,e,d.orig)) used;
                   List.iter (fun x -> Hashtbl.add decls x (l,e,d.orig)) l
                | _ -> assert false) deqs;

    using,decls


  let schedule_deqs (deqs: deq list) (p_in: p) : deq list =
    let (using,decls) = build_dep deqs in
    let available     = Hashtbl.create 1000 in

    List.iter (fun vd -> Hashtbl.add available (Var vd.vid) true) p_in;

    let scheduling = ref [] in
    let ready      = ref [] in

    (* Looking for the initially ready instrs (those who depend only on p_in) *)
    ( List.iter (fun d -> match d.content with
                  | Eqn(l,e,_) -> if List.filter (fun x -> not (exists available x))
                                                 (get_used_vars e) = [] then
                                    ready := (l,e,d.orig) :: !ready
                  | _ -> assert false) deqs );

    let rec do_schedule ((l,e,orig):var list*expr*((ident*deq_i) list)) =
      (* Only if "l" isn't scheduled already *)
      if List.filter (fun x -> not (exists available x)) l <> [] then (
        (* Scheduling the pre-requisite dependencies *)
        List.iter (fun x -> if not (exists available x) then
                              do_schedule (Hashtbl.find decls x)) (get_used_vars e);
        (* Scheduling the instruction *)
        scheduling := (l,e,orig) :: !scheduling;
        (* Marking it as scheduled *)
        List.iter (fun x -> Hashtbl.add available x true) l;
        (* Adding the sons to the Queue of instructions ready to be scheduled *)
        List.iter (fun x ->
                   List.iter (fun y -> ready := y :: !ready)
                             (keys_2nd_layer using x)) l
      )

    in

    (* While there are still instructions ready; schedule them *)
    while !ready <> [] do
      let current = List.hd !ready in
      ready := List.tl !ready;
      do_schedule current;
    done;

    List.rev_map (fun (l,e,orig) -> { orig=orig; content=Eqn(l,e,false) }) !scheduling

  let schedule_def (def:def) : def =
    { def with node = match def.node with
                      | Single(vars,body) ->
                         Single(vars,schedule_deqs body def.p_in)
                      | _ -> def.node }


  let schedule (prog:prog) : prog =
    { nodes = List.map schedule_def prog.nodes }
end

module Low_pressure_sched = struct
  (* Algorithm:
       Schedule an instruction, then find an instruction without dependencies
       with it to schedule and so on. Should introduce some intra-round
       interleaving.

   *)

  (* Expands a var a returns the intermediate vars.
     For instance, if x:u1x1[5][2] ->
        get_sub_vars x = x[0], x[1], ..., x[4], x[0][0], x[0][1], x[1][0], ..., x[4][1]. *)
  let rec get_sub_vars env_var ?(env_it=Hashtbl.create 100) (v:var) : var list =
    let typ = get_var_type env_var v in
    match typ with
    | Uint(_,_,1)   -> [ v ]
    | Uint(_,_,n)   -> List.map (fun i -> Index(v,Const_e i)) (gen_list_0_int n)
    | Array(_,size) -> (List.map (fun i -> Index(v,Const_e i))
                                 (gen_list_0_int (eval_arith_ne size))) @
                       (flat_map (fun i -> expand_var env_var ~env_it:env_it
                                                      (Index(v,Const_e i)))
                                 (gen_list_0_int (eval_arith_ne size)))
    | _ -> assert false

  (* "remove the array indexes":
       get_up_vars x[4][5] = [ x[4][5]; x[4]; x ] *)
  let rec get_up_vars (v:var) : var list =
    match v with
    | Var _ -> [ v ]
    | Index(v',_) -> v :: (get_up_vars v')
    | _ -> assert false

  let get_dep_vars env_var (vs:var list) : var list =
    (flat_map get_up_vars vs) @ (flat_map (get_sub_vars env_var) vs)

  let get_def_vars env_var (deq:deq) : var list =
    match deq.content with
    | Eqn(vs,e,_) -> uniq (flat_map (get_sub_vars env_var) vs)
    | Loop _ -> []

  let rec get_first_n (l:'a list) (i:int) : 'a list =
    match i with
    | 0 -> []
    | n -> match l with
           | [] -> []
           | hd::tl -> hd :: (get_first_n tl (n-1))

  let get_instr_no_dep env_var
                       (prev_def:var list ref)
                       (prev_used:var list ref)
                       (deqs:deq list ref) : deq =
    let exception Loop in
    let next_i = try
        find_get_i
          (fun d -> match d.content with
            | Eqn(vs,e,_) ->
               let used = get_dep_vars env_var (get_used_vars e) in
               let b = (not (common_elem !prev_def used)) &&
                         (not (common_elem vs !prev_used)) in
               if b then b else
                 begin prev_def := vs @ !prev_def;
                       prev_used := used @ !prev_used;
                       b
                 end
            (* As a first approximation, "raise Not_found" for loops.
               It makes some sense: I don't think there are a lot of cases where
               some instructions should be scheduled from after to before a loop... *)
            | _ -> raise Loop) !deqs
      with Loop -> 0 in
    let next = List.nth !deqs next_i in
    deqs := remove_nth !deqs next_i;
    next

  let rec inner_sched env_var (parallel_lvl:int) (deq:deq) : deq =
    match deq.content with
    | Eqn _ -> deq
    | Loop(x,ei,ef,dl,opts) ->
       { deq with content=Loop(x,ei,ef,schedule_deqs env_var parallel_lvl dl,opts) }

  and schedule_deqs env_var (parallel_lvl:int) (deqs: deq list) : deq list =
    let scheduling = ref [ List.hd deqs ] in
    let todo       = ref (List.tl deqs) in

    while !todo <> [] do
      let exception Found in
      try
      for num_prev = parallel_lvl-1 downto 1 do
        try
          let prev_deqs = flat_map (get_def_vars env_var) (get_first_n !scheduling num_prev) in
          let next = get_instr_no_dep env_var (ref prev_deqs) (ref []) todo in
          scheduling := (inner_sched env_var parallel_lvl next) :: !scheduling;
          raise Found
        with Not_found -> ()
      done;
      scheduling := (inner_sched env_var parallel_lvl (List.hd !todo)) :: !scheduling;
      todo := List.tl !todo;
      with Found -> ()
    done;

    List.rev !scheduling



  let schedule_def (parallel_lvl:int) (def:def) : def =
  (* TODO: cleaner decision than this "< 60" *)
    if Get_live_var.live_def def < 60 then
      { def with node = match def.node with
                        | Single(vars,body) ->
                           let env_var = build_env_var def.p_in def.p_out vars in
                           Single(vars,schedule_deqs env_var parallel_lvl body);
                        | _ -> def.node }
    else
    (* Too many live variables (bitslicing)
        => scheduling will actually introduce more spilling *)
      def


  (* TODO: make this more precise.
     Could be 1 on ARM/PowerPC. *)
  let parallel_arch (arch:arch) : int =
    match arch with
    | _ -> 15

  let schedule (prog:prog) (conf:config): prog =
    (* let parallel_lvl = parallel_arch conf.archi in *)
    let parallel_lvl = conf.schedule_n in
    { nodes = List.map (schedule_def parallel_lvl) prog.nodes }

end

let schedule (prog:prog) (conf:config) : prog =
  (* Reg_alloc.alloc_reg prog        *)
  (* Basic_scheduler.schedule prog *)
  (* Random_scheduler.schedule prog  *)
  (* Depth_first_sched.schedule prog *)
  Low_pressure_sched.schedule prog conf
