open Usuba_AST
open Utils

let rec get_used_vars (e:expr) : var list =
  match e with
  | Const _ -> []
  | ExpVar v -> [ v ]
  | Tuple l -> List.flatten @@ List.map get_used_vars l
  | Not e -> get_used_vars e
  | Shift(_,e,_) -> get_used_vars e
  | Log(_,x,y) | Arith(_,x,y) | Intr(_,x,y)
                                -> (get_used_vars x) @ (get_used_vars y)
  | Fun(_,l) -> List.flatten @@ List.map get_used_vars l
  | _ -> raise (Error "Not supported expr")

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
  { prog with nodes = List.map schedule_def prog.nodes }
