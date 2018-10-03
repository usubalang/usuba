open Usuba_AST
open Basic_utils
open Utils



let rec add_right live e =
  match e with
  | Const _ -> ()
  | ExpVar v -> Hashtbl.replace live (get_var_base v) true
  | Tuple l -> List.iter (add_right live) l
  | Not e -> add_right live e
  | Shift(_,e,_) -> add_right live e
  | Log(_,x,y) -> add_right live x; add_right live y
  | Shuffle(v,_) -> Hashtbl.replace live (get_var_base v) true
  | Arith(_,x,y) -> add_right live x; add_right live y
  | Fun(_,l) -> List.iter (add_right live) l
  | _ -> assert false

let remove_left live lhs =
  List.iter (fun v -> Hashtbl.remove live (get_var_base v)) lhs
                              
       
let live_deq live (deq:deq) : int =
  let nb_live = Hashtbl.length live in
  (match deq with
   | Norec(lhs,rhs) -> add_right live rhs;
                       remove_left live lhs
   | Rec _ -> raise (Not_implemented "live_deq(Rec ...)"));
  (* Printf.printf "[%3d -> %3d]  %s\n" nb_live (Hashtbl.length live) (Usuba_print.deq_to_str deq); *)
  nb_live

let live_deqs (p_out:p) (deqs:deq list) : int =
  let live = Hashtbl.create 50 in
  List.iter (fun x -> Hashtbl.add live (Var x.vid) true) p_out;

  max_l (List.map (live_deq live) (List.rev deqs))

       
let live_def (def:def) : unit =
  match def.node with
  | Single(vars,body) ->
     (try Printf.printf "%s: %d max live variables.\n"
                        def.id.name
                        (live_deqs def.p_out body)
      with Not_implemented _ -> ())
  | _ -> ()
       
let get_live_var (prog:prog) : unit =
  List.iter live_def prog.nodes
