(* ************************************************************************** *)
(*                                  INLINING                                  *)
(*                                                                            *)
(* I see two ways of doing inlining:                                          *)
(*   - iterating through the nodes' bodies, and inlining functions calls as   *)
(*      they appear.                                                          *)
(*   - iterating through the nodes, and for each nodes, inline every call     *)
(*      made to it by parcouring the other nodes' bodies.                     *)
(* I chose the latter; not sure what more efficient though.                   *)
(* ************************************************************************** *)


open Usuba_AST
open Basic_utils
open Utils
open Pass_runner
open Inline_core

let pre_inline = ref false
let orig_conf  = ref default_conf

(* Returns true is the inlining level in |conf| is more aggressive
   than auto_inline. *)
let is_more_aggressive_than_auto (conf:config) : bool =
  if conf.inline_all || conf.heavy_inline then true
  else false


let sbox_minimal_size (out_size:int) : int =
  12
  (* below code doesn't work because of Skinny, whose 8x8 S-box requires
     only 24 instructions...*)
  (* match out_size with *)
  (* | 4 -> 12 (\* Shortest = Rectangle *\) *)
  (* | 5 -> 20 (\* Shortest = Ascon *\) *)
  (* | 6 -> 50 (\* Shortest = DES *\) *)
  (* | 8 -> 110 (\* Shortest = AES *\) *)
  (* | _ -> out_size * out_size *)


(* is_n_percent_assign returns true if |deqs| contains more than |n|
   percent assginments. *)
let is_more_than_n_percent_assign (n:int) (deqs:deq list) : bool =
  let rec get_assigns (deqs:deq list) : int * int =
    List.fold_left (fun (asgns,tot) deq ->
                    match deq.content with
                    | Eqn(_,ExpVar _,_) -> (asgns+1, tot+1)
                    | Loop(_,_,_,dl,_) ->
                       let (asgns',tot') = get_assigns dl in
                       (asgns+asgns', tot+tot')
                    | _ -> (asgns, tot+1)) (0,0) deqs in
  let (asgns, tot) = get_assigns deqs in
  (float_of_int tot) *. (float_of_int n) /. 100. <= (float_of_int asgns)

(* Heuristically decides (ie returns true of false) if |def| should be
   inlined or not. *)
let should_inline_heuristic (def:def) : bool =
  let in_size  = List.fold_left (+) 0
                    (List.map (fun vd -> typ_size vd.vd_typ) def.p_in) in
  let out_size = List.fold_left (+) 0
                    (List.map (fun vd -> typ_size vd.vd_typ) def.p_out) in


  if (List.length def.p_in) + (List.length def.p_out) > 16 then
    (* More than 16 parameters -> is probably not a S-box -> inlining *)
    true
  else if (in_size > 31) && (out_size > 31) then
    (* Lots of parameters, unlikely to be a S-box *)
    true
  else if is_single def.node then
    if List.length (get_body def.node) < sbox_minimal_size out_size then
      (* Too short to be a S-box *)
      true
    else if is_more_than_n_percent_assign 50 (get_body def.node) then
      (* Lots of asignments; unlikely to be a S-box *)
      true
    else
      false
  else
    (* Not a regular node; should not really happen (but it can
    because of the hack to keep lookup tables with -keep-tables) *)
    false


(* Returns true if def doesn't contain any function call,
   or if those calls are to functions that are not going
   to be inlined *)
let rec is_call_free env inlined conf (def:def) : bool =
  let rec deq_call_free (deq:deq) : bool =
    match deq.content with
    | Eqn(_,Fun(f,_),_) ->
       if f.name = "refresh" then true
       else not (can_inline env inlined conf (Hashtbl.find env f.name))
    | Eqn _ -> true
    | Loop(_,_,_,dl,_) -> List.for_all deq_call_free dl in
  match def.node with
  | Single(_,body) -> List.for_all deq_call_free body
  | _ -> false

(* Returns true if the node can be inlined now. ie:
    - is not already inlined
    - it doesn't have the attribute "no_inline"
       (and "inline_all" isn't set to true)
    - it doesn't contain any function call, or
    - every function call it contains is to a node that should not be inlined
    - the heuristic decides that this node is worth being inlined *)
and can_inline env inlined conf (node:def) : bool =
  if Hashtbl.find inlined node.id.name then
    false (* Already inlined *)
  else if not (is_single node.node) then
    false
  (* else if !pre_inline && (not (is_noinline node)) then *)
  (*   (let r = should_pre_inline env inlined conf node in *)
  (*   Printf.printf "should_pre_inline %s = %b\n" node.id.name r; *)
  (*   r) *)
  else if conf.light_inline then
    is_inline node (* Only inline if node is marked as "_inline" *)
  else if conf.inline_all then
    true (* All nodes are inlined if -inline-all is active *)
  else if conf.heavy_inline then
    not (is_noinline node) (* Inline all nodes that aren't _no_inline *)
  else if is_call_free env inlined conf node then
    (* Node doesn't contain any function call that should be inlined
       -> heuristically deciding to inline it or not *)
    should_inline_heuristic node
  else
    false


(* Inline every node that should be and hasn't already been
   (inlined contains the status of each node: inlined or not) *)
let rec _inline (runner:pass_runner) (prog:prog) (conf:config) inlined : prog =

  (* A list of every node, needed for "is_call_free" *)
  let env = Hashtbl.create 20 in
  List.iter (fun x -> Hashtbl.add env x.id.name x) prog.nodes;

  (* If there is a node that can be inlined *)
  if List.exists (can_inline env inlined conf) prog.nodes then
    (* find the node to inline *)
    let to_inline = List.find (can_inline env inlined conf) prog.nodes in
    (* inline it *)
    let prog' = do_inline prog to_inline in
    (* add it to the hash of inlined nodes *)
    Hashtbl.replace inlined to_inline.id.name true;
    (* Running basic optimizations; copy propagation in particular is
       useful for the heuristic inlining *)
    let prog' = runner#run_module Simple_opts.as_pass prog' in
    (* continue inlining *)
    _inline runner prog' conf inlined
  else
    (* inlining is done, return the prog *)
    prog


(* Main inlining function. _inline actually does most of the job *)
let run_common (runner:pass_runner) (prog:prog) (conf:config) : prog =
  if conf.no_inline then prog
  else
    (* Hashtbl containing the inlining status of each node:
     false if it is not already inlined, true if it is *)
    let inlined = Hashtbl.create 20 in
    List.iter (fun x -> Hashtbl.add inlined x.id.name false) prog.nodes;
    (* The last node is the entry point, it wouldn't make sense to try inline it *)
    Hashtbl.replace inlined (last prog.nodes).id.name true;

    (* And now, perform the inlining *)
    _inline runner prog conf inlined

let run (runner:pass_runner) (prog:prog) (conf:config) : prog =
  pre_inline := false;
  run_common runner prog conf

let run_pre_inline (runner:pass_runner) (prog:prog) (conf:config) : prog =
  pre_inline := true;
  orig_conf  := conf;
  if is_more_aggressive_than_auto conf then
    let conf = { conf with auto_inline  = true;
                           heavy_inline = false;
                           inline_all   = false } in
    run_common runner prog conf
  else
    prog



let as_pass = (run, "Inline")
let as_pass_pre = (run_pre_inline, "Inline-pre")


let run_with_cont (runner:pass_runner) (prog:prog) (conf:config) nexts : prog =
  pre_inline := false;
  if not conf.bench_inline then
    runner#run_modules_guard ~conf:conf ((as_pass, true) :: nexts) prog
  else
    (assert conf.bench_inline;
     let fully_inlined = run runner prog { conf with inline_all = true } in
     let no_inlined    = run runner prog { conf with no_inline  = true } in
     let auto_inlined  = run runner prog conf in

     let fully_inlined = runner#run_modules_guard nexts fully_inlined in
     let no_inlined    = runner#run_modules_guard nexts no_inlined in
     let auto_inlined  = runner#run_modules_guard nexts auto_inlined in

     Printf.printf "Benchmarking dat shit...\n";

     let (perfs_full, perfs_no, perfs_auto) =
       list_to_tuple3
         (Perfs.compare_perfs [ fully_inlined; no_inlined; auto_inlined ]) in

     Printf.printf "Benchmarks res: %.2f vs %.2f vs %.2f\n" perfs_full perfs_no perfs_auto;

     if perfs_full < perfs_auto then
       if perfs_full < perfs_no then
         fully_inlined
       else
         no_inlined
     else
       if perfs_no < perfs_auto then
         no_inlined
       else
         auto_inlined)
