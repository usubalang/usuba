open Usuba_AST
open Utils

let update_hoh hash v1 v2 =
  match env_fetch hash v1 with
  | Some h -> Hashtbl.replace h v2 1
  | None   -> let h = Hashtbl.create 60 in
              Hashtbl.add h v2 1;
              Hashtbl.add hash v1 h
       
let build_inter (deqs:deq list) (p_in:p) (p_out:p)
    : (var, (var,int) Hashtbl.t) Hashtbl.t  =
  let size = List.length deqs in   (* number of instr (= of "points") *)
  let live = Array.make size [] in (* live var at each point *)
  let curr = Hashtbl.create 10 in (* variables currently alive *)

  (* Marking the out variables as alive *)
  List.iter (fun (id,_,_) -> Hashtbl.add curr (Var id) 1) p_out;

  (* Computing live var at any point *)
  List.iteri (fun i deq -> match deq with
             | Norec(l,e) -> List.iter (fun x -> Hashtbl.remove curr x) l;
                             List.iter (fun x -> Hashtbl.replace curr x 1)
                                       (get_used_vars e);
                             live.(size-i-1) <- Hashtbl.fold
                                                  (fun x _ acc -> x :: acc)
                                                  curr [];
             | _ -> unreached ()
             ) (List.rev deqs);

  (* Computing the adjacency list of each variable *)
  let graph = Hashtbl.create 100 in
  Array.iter (fun l -> List.iter (fun x ->
                                  List.iter (fun y ->
                                             if y <> x then
                                               update_hoh graph x y) l) l) live;
  graph
       
let alloc_deqs def (deqs:deq list) : deq list =
  let _ = build_inter deqs def.p_in def.p_out in
  deqs 

let alloc_def (def:def) : def =
  { def with node = match def.node with
                    | Single(vars,body) -> Single(vars,alloc_deqs def body)
                    | _ -> def.node }

let alloc_reg (prog:prog) : prog =
   { nodes = List.map alloc_def prog.nodes }
  
     
