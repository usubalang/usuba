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
      List.flatten @@
        List.map (
            fun d ->
            (match d with
             | Norec(p,e) -> (
               match p with
               | [Var v] ->
                  let used = get_used_vars e in
                  let pre = List.flatten @@
                              List.map (fun x -> match Hashtbl.find_opt deflist x with
                                                 | Some e -> Hashtbl.remove deflist x;
                                                             [ [x],e ]
                                                 | None -> []) used in
                  (match pre with
                   | [] -> Hashtbl.add deflist (Var v) e; []
                   | _ -> pre @ [ (p,e) ])
               | _ -> 
                  let used = get_used_vars e in
                  let pre = List.flatten @@
                              List.map (fun x -> match Hashtbl.find_opt deflist x with
                                                 | Some e -> Hashtbl.remove deflist x;
                                                             [ [x],e ]
                                                 | None -> []) used in
                  pre @ [p,e])
             | Rec _ -> raise (Error "Invalid Rec"))) deqs in
    List.map (fun (x,y) -> Norec(x,y))
             (dep_deqs @ (Hashtbl.fold (fun k v acc -> ([k],v) :: acc) deflist []))
             
             
             
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
      (fun eq -> match eq with
                 | Norec(_,e) ->
                    let prec = get_used_vars e in
                    List.iter ( fun x ->
                                let l = init imply x in
                                l := eq :: !l
                              ) prec;
                    Hashtbl.add status eq (ref (List.length prec))
                 | _ -> assert false) deqs;

    (* Setting successors of p_in to ready *)
    List.iter
      (fun ((id,_),_) ->
       let v = Var id in
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
      match selected with
      | Norec(p,_) -> List.iter
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
        (var,(var list * expr,bool) Hashtbl.t) Hashtbl.t
        * (var,(var list * expr)) Hashtbl.t =
    let using = Hashtbl.create 1000 in
    let decls = Hashtbl.create 1000 in

    List.iter (function
                | Norec(l,e) ->
                   let used = get_used_vars e in
                   List.iter (fun x -> update_hoh using x (l,e)) used;
                   List.iter (fun x -> Hashtbl.add decls x (l,e)) l
                | _ -> assert false) deqs;

    using,decls
              
  
  let schedule_deqs (deqs: deq list) (p_in: p) : deq list =
    let (using,decls) = build_dep deqs in
    let available     = Hashtbl.create 1000 in

    List.iter (fun ((id,_),_) -> Hashtbl.add available (Var id) true) p_in;

    let scheduling = ref [] in
    let ready      = ref [] in

    (* Looking for the initially ready instrs (those who depend only on p_in) *)
    ( List.iter (function
                  | Norec(l,e) -> if List.filter (fun x -> not (exists available x))
                                                 (get_used_vars e) = [] then
                                    ready := (l,e) :: !ready
                  | _ -> assert false) deqs );
    
    let rec do_schedule ((l,e):var list*expr) =
      (* Only if "l" isn't scheduled already *)
      if List.filter (fun x -> not (exists available x)) l <> [] then (
        (* Scheduling the pre-requisite dependencies *)
        List.iter (fun x -> if not (exists available x) then
                              do_schedule (Hashtbl.find decls x)) (get_used_vars e);
        (* Scheduling the instruction *)
        scheduling := (l,e) :: !scheduling;
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
    
    List.rev_map (fun (l,e) -> Norec(l,e)) !scheduling
                 
  let schedule_def (def:def) : def =
    { def with node = match def.node with
                      | Single(vars,body) ->
                         Single(vars,schedule_deqs body def.p_in)
                      | _ -> def.node }
      

  let schedule (prog:prog) : prog =
    { nodes = List.map schedule_def prog.nodes }
end
      
let schedule (prog:prog) : prog =
  (* Reg_alloc.alloc_reg prog        *)
  (* Basic_scheduler.schedule prog   *)
  (* Random_scheduler.schedule prog  *)
  (* Depth_first_sched.schedule prog *)
   prog 
