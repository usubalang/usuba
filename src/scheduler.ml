open Usuba_AST
open Utils

               
module Basic_scheduler = struct

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
                              List.map (fun x -> match env_fetch deflist x with
                                                 | Some e -> Hashtbl.remove deflist x;
                                                             [ [x],e ]
                                                 | None -> []) used in
                  (match pre with
                   | [] -> env_add deflist (Var v) e; []
                   | _ -> pre @ [ (p,e) ])
               | _ -> 
                  let used = get_used_vars e in
                  let pre = List.flatten @@
                              List.map (fun x -> match env_fetch deflist x with
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

  let schedule_deqs (deqs: deq list) (p_in: p) : deq list =
    let init hash v =
      match env_fetch hash v with
      | Some l -> l
      | None -> let l = ref [] in
                env_add hash v l;
                l in
    
    Random.init 5;
    
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
                    env_add status eq (ref (List.length prec))
                 | _ -> unreached ()) deqs;

    (* Setting successors of p_in to ready *)
    List.iter
      (fun (id,_,_) ->
       let v = Var id in
       match env_fetch imply v with
       | Some l ->
          List.iter
            (fun eq ->
             match env_fetch status eq with
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
                         (match env_fetch imply p with
                          | Some l ->
                             List.iter (fun x -> match env_fetch status x with
                                                 | Some n -> decr n
                                                 | None -> ()) !l
                          | None -> ())) p
      | _ -> unreached()
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
      
let schedule (prog:prog) : prog =
  Reg_alloc.alloc_reg prog
  (*Random_scheduler.schedule prog *)
