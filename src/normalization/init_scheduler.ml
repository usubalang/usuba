open Usuba_AST
open Utils


let init_ready (p:p) =
  let env = Hashtbl.create 100 in
  List.iter (fun ((id,_),_) -> Hashtbl.add env (Var id) true) p;
  env

let schedule_deqs (def:def) (deqs:deq list) : deq list =
  let ready = init_ready def.p_in in

  let body     = ref [] in
  let to_sched = Hashtbl.create 100 in
  let sched    = Hashtbl.create 100 in

  let rec sched_it (instr:deq) : unit =
    try ignore(Hashtbl.find sched instr)
    with Not_found ->
         match instr with
         | Norec(lhs,e) -> 
            if List.for_all (fun x -> try Hashtbl.find ready x
                                      with Not_found -> false)
                            (get_used_vars e) then
              ( body := Norec(lhs,e) :: !body;
                Hashtbl.add sched instr true;
                List.iter (fun x -> Hashtbl.add ready x true) lhs;
                List.iter (fun x ->
                           try ignore(sched_it (Hashtbl.find to_sched x))
                           with Not_found -> ()) lhs )
            else
              List.iter (fun x -> Hashtbl.add to_sched x instr) (get_used_vars e)
         | Rec _ -> raise (Error "Invalid rec")
  in
  List.iter sched_it deqs;
  if List.length !body <> List.length deqs then
    (
      let hash = Hashtbl.create 1000 in
      List.iter (fun x -> Hashtbl.add hash x true) !body;
      List.iter (fun x -> match Hashtbl.find_opt hash x with
                          | Some _ -> ()
                          | None -> Printf.printf "Didn't schedule %s\n" (Usuba_print.deq_to_str x)) deqs;
      raise (Error (Printf.sprintf "Couldn't find a valid scheduling. (%s)" def.id.name))
    )
  else
    List.rev !body
              
       
let schedule_def (def:def) : def =
  { def with node =
               match def.node with
               | Single(vars,body) -> Single(vars,schedule_deqs def body)
               | _ -> def.node }

(* Must be called once arrays (and thus Rec) have been removed. *)
let schedule_prog (prog:prog) (conf:config): prog =
  Printf.fprintf stderr "Scheduler (simple) disabled.\n";
  prog
  (* { nodes = List.map schedule_def prog.nodes } *)
