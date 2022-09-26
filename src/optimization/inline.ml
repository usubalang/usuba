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

(* TODO: the function environment used throughout this module is
   called either |env| or |env_fun| --> it should be called |env_fun|
   everywhere. Futhermore, its type is "(string,def) Hashtbl.t" --> it
   should be "(ident,def) Hashtbl.t". *)

open Prelude
open Usuba_AST
open Basic_utils
open Utils
open Pass_runner
open Inline_core

let pre_inline = ref false

module Is_linear = struct
  let rec is_linear_expr (env_fun : (string, def) Hashtbl.t) (e : expr) : bool =
    match e with
    | Const _ | ExpVar _ -> true
    | Tuple l -> List.for_all (is_linear_expr env_fun) l
    | Not e' -> is_linear_expr env_fun e'
    | Log (op, _, _) -> ( match op with And | Or | Andn -> false | _ -> true)
    | Arith (op, _, _) -> (
        match op with Add | Sub -> true | Mul | Div | Mod -> false)
    | Shift (_, e', _) -> is_linear_expr env_fun e'
    | Shuffle _ -> true
    | Bitmask (e', _) -> is_linear_expr env_fun e'
    | Pack (e1, e2, _) -> is_linear_expr env_fun e1 && is_linear_expr env_fun e2
    | Fun (f, l) ->
        is_linear_def_by_name env_fun f
        && List.for_all (is_linear_expr env_fun) l
    | Fun_v (f, _, l) ->
        is_linear_def_by_name env_fun f
        && List.for_all (is_linear_expr env_fun) l

  and is_linear_deqs (env_fun : (string, def) Hashtbl.t) (deqs : deq list) :
      bool =
    List.for_all
      (fun deq ->
        match deq.content with
        | Eqn (_, e, _) -> is_linear_expr env_fun e
        | Loop { body; _ } -> is_linear_deqs env_fun body)
      deqs

  and is_linear_def_i (env_fun : (string, def) Hashtbl.t) (def_i : def_i) : bool
      =
    match def_i with
    | Single (_, body) -> is_linear_deqs env_fun body
    | Multiple l -> List.for_all (is_linear_def_i env_fun) l
    | _ -> false

  and is_linear_def (env_fun : (string, def) Hashtbl.t) (def : def) : bool =
    is_linear_def_i env_fun def.node

  and is_linear_def_by_name (env_fun : (string, def) Hashtbl.t) (f : ident) :
      bool =
    if is_builtin f then true
    else is_linear_def env_fun (Hashtbl.find env_fun (Ident.name f))

  let is_linear (env_fun : (string, def) Hashtbl.t) (def : def) : bool =
    is_linear_def env_fun def
end

(* Returns true is the inlining level in |conf| is more aggressive
   than auto_inline. *)
let is_more_aggressive_than_auto (conf : Config.config) : bool =
  if conf.inline_all || conf.heavy_inline || conf.auto_inline then true
  else false

let sbox_minimal_size _ = 10

(* below code doesn't work because of Skinny, whose 8x8 S-box requires
   only 24 instructions...*)
(* match out_size with *)
(* | 4 -> 10 (\* Shortest = Gift *\) *)
(* | 5 -> 20 (\* Shortest = Ascon *\) *)
(* | 6 -> 50 (\* Shortest = DES *\) *)
(* | 8 -> 110 (\* Shortest = AES *\) *)
(* | _ -> out_size * out_size *)

(* is_n_percent_assign returns true if |deqs| contains more than |n|
   percent assginments. *)
let is_more_than_n_percent_assign (n : int) (deqs : deq list) : bool =
  let rec get_assigns (deqs : deq list) : int * int =
    List.fold_left
      (fun (asgns, tot) deq ->
        match deq.content with
        | Eqn (_, ExpVar _, _) -> (asgns + 1, tot + 1)
        | Loop { body; _ } ->
            let asgns', tot' = get_assigns body in
            (asgns + asgns', tot + tot')
        | _ -> (asgns, tot + 1))
      (0, 0) deqs
  in
  let asgns, tot = get_assigns deqs in
  (* STDLIB_IMPORT: Comparing float *)
  Stdlib.(float_of_int tot *. float_of_int n /. 100. <= float_of_int asgns)

(* Heuristically decides (ie returns true of false) if |def| should be
   inlined or not. *)
(* TODO: add a criteria related to live variables? (obtainable using
   Get_live_vars.live_def) *)
let should_inline_heuristic (def : def) : bool =
  let in_size =
    List.fold_left ( + ) 0 (List.map (fun vd -> typ_size vd.vd_typ) def.p_in)
  in
  let out_size =
    List.fold_left ( + ) 0 (List.map (fun vd -> typ_size vd.vd_typ) def.p_out)
  in

  if List.length def.p_in + List.length def.p_out > 16 then
    (* More than 16 parameters -> is probably not a S-box -> inlining *)
    true
  else if in_size > 31 && out_size > 31 then
    (* Lots of parameters, unlikely to be a S-box *)
    true
  else if is_single def.node then
    if List.length (get_body def.node) < sbox_minimal_size out_size then
      (* Too short to be a S-box *)
      true
    else if is_more_than_n_percent_assign 50 (get_body def.node) then
      (* Lots of asignments; unlikely to be a S-box *)
      true
    else false
  else
    (* Not a regular node; should not really happen (but it can
       because of the hack to keep lookup tables with -keep-tables) *)
    false

(* Pre-inlining inlines linear nodes *)
let should_pre_inline env (def : def) : bool = Is_linear.is_linear env def

(* Returns true if def doesn't contain any function call,
   or if those calls are to functions that are not going
   to be inlined *)
let rec is_call_free env inlined conf (def : def) : bool =
  let rec deq_call_free (deq : deq) : bool =
    match deq.content with
    | Eqn (_, Fun (f, _), _) ->
        if String.equal (Ident.name f) "refresh" then true
        else not (can_inline env inlined conf (Hashtbl.find env (Ident.name f)))
    | Eqn _ -> true
    | Loop { body; _ } -> List.for_all deq_call_free body
  in
  match def.node with
  | Single (_, body) -> List.for_all deq_call_free body
  | _ -> false

(* Returns true if the node can be inlined now. ie:
    - is not already inlined
    - it doesn't have the attribute "no_inline"
       (and "inline_all" isn't set to true)
    - it doesn't contain any function call, or
    - every function call it contains is to a node that should not be inlined
    - the heuristic decides that this node is worth being inlined *)
and can_inline env inlined (conf : Config.config) (node : def) : bool =
  (* Printf.printf "Can_inline(%s) (pre_inline=%b)\n" node.id.name !pre_inline; *)
  if Hashtbl.find inlined (Ident.name node.id) then false (* Already inlined *)
  else if not (is_single node.node) then false
  else if conf.light_inline then is_inline node
    (* Only inline if node is marked as "_inline" *)
  else if conf.inline_all then true
    (* All nodes are inlined if -inline-all is active *)
  else if conf.heavy_inline then not (is_noinline node)
    (* Inline all nodes that aren't _no_inline *)
  else if is_call_free env inlined conf node then
    (* Node doesn't contain any function call that should be inlined
       -> heuristically deciding to inline it or not *)
    is_inline node
    || (not (is_noinline node))
       &&
       if !pre_inline then should_pre_inline env node
       else should_inline_heuristic node
  else false

(* Inline every node that should be and hasn't already been
   (inlined contains the status of each node: inlined or not) *)
let rec _inline (runner : pass_runner) (prog : prog) (conf : Config.config)
    inlined : prog =
  (* A list of every node, needed for "is_call_free" *)
  let env = Hashtbl.create 20 in
  List.iter (fun x -> Hashtbl.add env (Ident.name x.id) x) prog.nodes;

  (* If there is a node that can be inlined *)
  if List.exists (can_inline env inlined conf) prog.nodes then (
    (* find the node to inline *)
    let to_inline = List.find (can_inline env inlined conf) prog.nodes in

    (* inline it *)
    let prog' = do_inline prog to_inline in

    if Option.equal Config.equal_dump_steps conf.dump_steps (Some AST) then
      dump_to_file prog' conf;
    (* add it to the hash of inlined nodes *)
    Hashtbl.replace inlined (Ident.name to_inline.id) true;
    (* Running basic optimizations; copy propagation in particular is
       useful for the heuristic inlining *)
    let prog' =
      if conf.simple_opts then runner#run_module Simple_opts.as_pass prog'
      else prog'
    in

    (* continue inlining *)
    _inline runner prog' conf inlined)
  else (* inlining is done, return the prog *)
    prog

(* Main inlining function. _inline actually does most of the job *)
let run_common (runner : pass_runner) (prog : prog) (conf : Config.config) :
    prog =
  if conf.no_inline then prog
  else
    (* Hashtbl containing the inlining status of each node:
       false if it is not already inlined, true if it is *)
    let inlined = Hashtbl.create 20 in
    List.iter (fun x -> Hashtbl.add inlined (Ident.name x.id) false) prog.nodes;
    (* The last node is the entry point, it wouldn't make sense to try inline it *)
    Hashtbl.replace inlined (Ident.name (last prog.nodes).id) true;
    (* And now, perform the inlining *)
    _inline runner prog conf inlined

let run_pre_inline (runner : pass_runner) (prog : prog) (conf : Config.config) :
    prog =
  pre_inline := true;
  if is_more_aggressive_than_auto conf then (
    let conf =
      {
        conf with
        auto_inline = true;
        light_inline = false;
        heavy_inline = false;
        inline_all = false;
      }
    in
    let prog' = run_common runner prog conf in
    if Option.equal Config.equal_dump_steps conf.dump_steps (Some AST) then (
      dump_to_file prog' conf;
      dump_caller [ "Inline-pre" ] conf);
    prog')
  else prog

let run_simple (runner : pass_runner) (prog : prog) (conf : Config.config) :
    prog =
  pre_inline := false;
  run_common runner prog conf

let run_bench (runner : pass_runner) (prog : prog) (conf : Config.config) nexts
    : prog =
  assert conf.bench_inline;

  let fully_inlined = run_simple runner prog { conf with inline_all = true } in
  let no_inlined = run_simple runner prog { conf with no_inline = true } in
  let auto_inlined = run_simple runner prog { conf with auto_inline = true } in

  runner#push_in_bench "Inline:always";
  let fully_inlined = runner#run_modules_bench nexts fully_inlined in
  runner#pop_in_bench ();
  runner#push_in_bench "Inline:never";
  let no_inlined = runner#run_modules_bench nexts no_inlined in
  runner#pop_in_bench ();
  runner#push_in_bench "Inline:heuristic";
  let auto_inlined = runner#run_modules_bench nexts auto_inlined in
  runner#pop_in_bench ();

  let perfs_full, perfs_no, perfs_auto =
    list_to_tuple3
      (Perfs.compare_perfs [ fully_inlined; no_inlined; auto_inlined ] conf)
  in

  let prog, selected =
    (* STDLIB_IMPORT: Comparing float *)
    if Stdlib.(perfs_full < perfs_auto) then
      if Stdlib.(perfs_full < perfs_no) then (fully_inlined, "always")
      else (no_inlined, "never")
    else if Stdlib.(perfs_no < perfs_auto) then (no_inlined, "never")
    else (auto_inlined, "heuristic")
  in

  Printf.printf
    "Inline: always:%.2f  --  never:%.2f  --  heuristic:%.2f --> selecting %s\n\
     %!"
    perfs_full perfs_no perfs_auto selected;

  prog

let run (runner : pass_runner) (prog : prog) (conf : Config.config) : prog =
  let nexts = runner#get_nexts () in
  pre_inline := false;
  let prog' =
    if not conf.bench_inline then
      runner#run_modules_bench ~conf
        (((run_simple, "Inline", 1), true, Pass_runner.Always) :: nexts)
        prog
    else run_bench runner prog conf nexts
  in
  if Option.equal Config.equal_dump_steps conf.dump_steps (Some AST) then (
    dump_to_file prog' conf;
    dump_caller [ "Inline" ] conf);
  prog'

let as_pass = (run, "Inline", 1)
let as_pass_pre = (run_pre_inline, "Inline-pre", 1)
