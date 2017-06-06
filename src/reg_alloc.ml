open Usuba_AST
open Utils


let update_hoh hash k1 k2 =
  if k1 <> k2 then
    match env_fetch hash k1 with
    | Some h -> Hashtbl.replace h k2 true
    | None   -> let h = Hashtbl.create 60 in
                Hashtbl.add h k2 true;
                Hashtbl.add hash k1 h
                            
let build (deqs: deq list) (p_in:p) (p_out:p) :
      (var, (var,bool) Hashtbl.t) Hashtbl.t  =
  let live : (var,bool) Hashtbl.t = Hashtbl.create 100 in (* variables currently alive *)
  let adj_graph : (var, (var,bool) Hashtbl.t) Hashtbl.t = Hashtbl.create 1000 in

  let p_out = List.map (fun (x,_,_) -> Var x) p_out in
  let p_in  = List.map (fun (x,_,_) -> Var x) p_in in
  
  List.iter (fun x -> Hashtbl.add live x true;
                            List.iter (fun y ->
                                       update_hoh adj_graph x y;
                                       update_hoh adj_graph y x) p_out) p_out;

  List.iter (function
              | Norec(l,e) ->
                 List.iter (fun x -> Hashtbl.replace live x true) l;
                 List.iter (fun x ->
                            Hashtbl.iter (fun y _ ->
                                          update_hoh adj_graph x y;
                                          update_hoh adj_graph y x) live) l;
                 List.iter (fun x -> Hashtbl.replace live x true) (get_used_vars e);
                 List.iter (fun x -> Hashtbl.remove live x) l
              | _ -> unreached()) (List.rev deqs);

  List.iter (fun x -> Hashtbl.iter (fun y _ -> update_hoh adj_graph x y;
                                               update_hoh adj_graph y x) live) p_in;
  
  adj_graph

let init (adj_graph: (var, (var,bool) Hashtbl.t) Hashtbl.t) (nb_reg:int):
      var list ref * (var,bool) Hashtbl.t =
  let spill_worklist    = Hashtbl.create ~random:true 1000 in
  let simplify_worklist = ref [] in
  Hashtbl.iter (fun x y -> if Hashtbl.length y >= nb_reg then
                             Hashtbl.replace spill_worklist x true
                           else
                             simplify_worklist := x :: !simplify_worklist) adj_graph;
  simplify_worklist,spill_worklist

let simplify (worklist:var list ref) (stack:var list ref)
             (degrees:(var,int) Hashtbl.t) adj_graph spill_wl
             (in_stack:(var,bool) Hashtbl.t)
             (nb_reg:int) : unit =
  match !worklist with
  | hd::tl -> worklist := tl;
              stack := hd :: !stack;
              Hashtbl.replace in_stack hd true;
              Hashtbl.iter (fun x _ ->
                            try let _ = Hashtbl.find in_stack x in ()
                            with Not_found -> 
                                 let deg = Hashtbl.find degrees x in
                                 Hashtbl.replace degrees x (deg-1);
                                 if deg = nb_reg then
                                   ( worklist := x :: !worklist;
                                     Hashtbl.remove spill_wl x)) (Hashtbl.find adj_graph hd)
  | _ -> unreached ()
              

let select_spill (worklist:(var,bool) Hashtbl.t) simpl_wl : unit =
  let tmp = ref (Var "_") in
  try
    Hashtbl.iter (fun x _ -> tmp := x;
                             simpl_wl := x :: !simpl_wl;
                             raise Break) worklist
  with Break -> Hashtbl.remove worklist !tmp

let assign_colors (stack: var list ref) adj_graph (nb_reg:int) =
  let colors = Hashtbl.create 1000 in
  let spilled = ref [] in
  
  let get_color x =
    try Hashtbl.find colors x
    with Not_found -> -1 in
  
  let fresh_colors () =
    let h = Hashtbl.create nb_reg in
    for i = 0 to nb_reg do
      Hashtbl.add h i true
    done;
    h in
  
  while !stack <> [] do
    let n = List.hd !stack in
    stack := List.tl !stack;
    
    let ok_colors = fresh_colors () in
    Hashtbl.iter (fun x _ -> let c = get_color x in
                             if c <> (-1) then
                               Hashtbl.remove ok_colors c ) (Hashtbl.find adj_graph n);
    if Hashtbl.length ok_colors = 0 then
      spilled := n :: !spilled
    else begin
        try Hashtbl.iter (fun x _ -> Hashtbl.add colors n x;
                                     raise Break) ok_colors
        with Break -> ()
      end
  done;
  (* Printf.printf "Spilled: %d\nNot spilled:%d\n" (List.length !spilled) (Hashtbl.length colors); *)
  colors
  
    
let alloc_deqs def (deqs:deq list) (nb_reg:int) : deq list =
  let adj_graph = build deqs def.p_in def.p_out in
  let degrees = Hashtbl.create 1000 in
  Hashtbl.iter (fun x y -> Hashtbl.add degrees x (Hashtbl.length y)) adj_graph;
  let (simplify_worklist,spill_worklist) = init adj_graph nb_reg in
  let select_stack = ref [] in

  let in_stack = Hashtbl.create 1000 in
  while (!simplify_worklist <> []) || (Hashtbl.length spill_worklist <> 0) do
    if !simplify_worklist <> [] then
      simplify simplify_worklist select_stack degrees adj_graph spill_worklist in_stack nb_reg
    else
      select_spill spill_worklist simplify_worklist
  done;

  let colors = assign_colors select_stack adj_graph nb_reg in
  
  deqs 

let alloc_def (def:def) (nb_reg:int) : def =
  { def with node = match def.node with
                    | Single(vars,body) -> Single(vars,alloc_deqs def body nb_reg)
                    | _ -> def.node }

let alloc_reg (prog:prog) : prog =
  let nb_reg = 15 in
  { nodes = List.map (fun x -> alloc_def x nb_reg) prog.nodes }
  
