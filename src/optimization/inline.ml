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

let pre_inline = ref false
let orig_conf  = ref default_conf


(* Returns true is the inlining level in |conf| is more aggressive
   than auto_inline. *)
let is_more_aggressive_than_auto (conf:config) : bool =
  if conf.inline_all || conf.heavy_inline then true
  else false


(* This module checks if a node _must_ be inlined and if so, returns
   it. For now, a node must be inlined if it uses shifts of sizes
   depending on the parameters. *)
module Must_inline = struct
  let rec contains_in (env_in:(ident,bool) Hashtbl.t) (ae:arith_expr) : bool =
    match ae with
    | Const_e _   -> false
    | Var_e v     -> Hashtbl.mem env_in v
    | Op_e(_,x,y) -> (contains_in env_in x) || (contains_in env_in y)

  (* |e| is a variable that is being shifted. Need to check if it's a
  tuple, or it's dir is Bitslice. *)
  (* TODO: this should be done somewhere else / some other way. *)
  let must_inline_shift (env_var:(ident,typ) Hashtbl.t)
                        (env_in:(ident,bool) Hashtbl.t)
                        (e:expr) (ae:arith_expr) : bool =
    (contains_in env_in ae) &&
      match e with
      | Tuple l -> true
      | _       ->
         (* Note that at this point, there is a chance that we are
         bitslicing but Monomorphize hasn't ran already. In this case,
         this will return false, but we don't care, as later call to
         this module will work correctly. *)
         get_normed_expr_dir env_var e = Bslice

  let rec must_inline_expr (env_var:(ident,typ) Hashtbl.t)
                           (env_in:(ident,bool) Hashtbl.t)
                           (e:expr) : bool =
    match e with
    | Const _        -> false
    | ExpVar _       -> false
    | Tuple l        -> List.exists (must_inline_expr env_var env_in) l
    | Not e'         -> must_inline_expr env_var env_in e'
    | Shift(_,e',ae) -> (must_inline_expr env_var env_in e') ||
                          (must_inline_shift env_var env_in e' ae)
    | Log(_,x,y)     -> (must_inline_expr env_var env_in x) ||
                          (must_inline_expr env_var env_in y)
    | Shuffle _      -> false
    | Arith(_,x,y)   -> (must_inline_expr env_var env_in x) ||
                          (must_inline_expr env_var env_in y)
    | Fun(_,l)       -> List.exists (must_inline_expr env_var env_in) l
    | Fun_v(_,_,l)   -> List.exists (must_inline_expr env_var env_in) l

  let rec must_inline_deqs (env_var:(ident,typ) Hashtbl.t)
                           (env_in:(ident,bool) Hashtbl.t)
                           (deqs:deq list) : bool =
    List.exists (fun d -> match d.content with
                  | Eqn(_,e,_) -> must_inline_expr env_var env_in e
                  | Loop(_,_,_,dl,_) -> must_inline_deqs env_var env_in dl) deqs

  let must_inline_def (def:def) : bool =
    match def.node with
    | Single(vars,body) ->
       let env_var = build_env_var def.p_in def.p_out vars in
       let env_in  = Hashtbl.create 10 in
       List.iter (fun vd -> Hashtbl.add env_in vd.vd_id true) def.p_in;
       must_inline_deqs env_var env_in body
    | _ -> false

  let must_inline (prog:prog) : def option =
    List.find_opt must_inline_def prog.nodes
end

let gen_iterator =
  let cpt = ref 0 in
  fun id ->
    incr cpt;
    fresh_ident (Printf.sprintf "%s%d" id.name !cpt)

let rec update_aexpr_idx (it_env:(var,var) Hashtbl.t)
                         (ae:arith_expr) : arith_expr =
  match ae with
  | Const_e _ -> ae
  | Var_e id  -> (match Hashtbl.find_opt it_env (Var id) with
                  | Some (Var v) -> Var_e v
                  | _ -> Var_e id)
  | Op_e(op,x,y) -> Op_e(op,update_aexpr_idx it_env x,update_aexpr_idx it_env y)

let add_iterators (its:(ident*int) list) (v:var) : var =
  let rec create_new_base (its:(ident*int) list) (v:var) : var =
    match its with
    | [] -> v
    | (i,_) :: tl -> Index(create_new_base tl v,Var_e i) in
  let rec replace_base (v:var) (new_base:var) : var =
    match v with
    | Var _ -> new_base
    | Index(v',ae) -> Index(replace_base v' new_base,ae)
    | _ -> assert false in
  let base = get_var_base v in
  replace_base v (create_new_base its base)


let rec update_in_var (it_env:(var,var) Hashtbl.t)
                      (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v',ae) -> Index(update_in_var it_env v',update_aexpr_idx it_env ae)
  | _ -> assert false

let rec update_var_to_var (it_env:(var,var) Hashtbl.t)
                          (var_env : (var,var) Hashtbl.t)
                          (v:var) : var =
  let v = update_in_var it_env v in
  match Hashtbl.find_opt it_env v with
  | Some v' -> v'
  | None ->
     match Hashtbl.find_opt var_env v with
     | Some v' -> v'
     | None -> match v with
               | Var _ -> Printf.fprintf stderr "Fail: %s\n" (Usuba_print.var_to_str v);
                          assert false
               | Index(v',ae) -> Index(update_var_to_var it_env var_env v',ae)
               | _ -> assert false
(* /!\ Shadowing definition above *)
let update_var_to_var (its:(ident*int) list)
                      (it_env:(var,var) Hashtbl.t)
                      (var_env : (var,var) Hashtbl.t)
                      (extern_vars:(ident,bool) Hashtbl.t)
                      (v:var) : var =
  let v = update_var_to_var it_env var_env v in
  match Hashtbl.find_opt extern_vars (get_base_name v) with
  | Some _ -> v (* Variable comes from "outside" (ie, parameter/return values) *)
  | None   -> add_iterators its v

let rec update_var_to_expr (it_env:(var,var) Hashtbl.t)
                           (var_env : (var,var) Hashtbl.t)
                           (expr_env: (var,expr) Hashtbl.t)
                           (v:var) : expr =
  match Hashtbl.find_opt it_env v with
  | Some v' -> ExpVar v'
  | None ->
     match Hashtbl.find_opt expr_env v with
     | Some e -> e
     | None ->
        match Hashtbl.find_opt var_env v with
        | Some v' -> ExpVar v'
        | None ->
           match v with
           | Var id -> assert false
           | Index(v',ae) ->
              begin
                match update_var_to_expr it_env var_env expr_env v' with
                | ExpVar v'' -> ExpVar(Index(v'',update_aexpr it_env var_env expr_env ae))
                | _ -> assert false
              end
           | _ -> assert false

and expr_to_aexpr (e:expr) : arith_expr =
  match e with
  | Const(c,_) -> Const_e c
  | ExpVar(Var v) -> Var_e v
  | Arith(op,x,y) -> Op_e(op,expr_to_aexpr x,expr_to_aexpr y)
  | _ -> assert false

(* TODO: this is quite messy, as we are mixing aexpr and expr ... *)
and update_aexpr(it_env:(var,var) Hashtbl.t)
                (var_env : (var,var) Hashtbl.t)
                (expr_env: (var,expr) Hashtbl.t)
                (ae:arith_expr) : arith_expr =
  let rec_call = update_aexpr it_env var_env expr_env in
  match ae with
  | Const_e _ -> ae
  | Var_e v -> expr_to_aexpr (update_var_to_expr it_env var_env expr_env (Var v))
  | Op_e(op,x,y) -> Op_e(op,rec_call x, rec_call y)

(* /!\ Shadowing definition above *)
let update_var_to_expr (its:(ident*int) list)
                       (it_env:(var,var) Hashtbl.t)
                       (var_env : (var,var) Hashtbl.t)
                       (expr_env: (var,expr) Hashtbl.t)
                       (extern_vars:(ident,bool) Hashtbl.t)
                       (v:var) : expr =
  let e = update_var_to_expr it_env var_env expr_env v in
  match e with
  | ExpVar v ->
     (match Hashtbl.find_opt extern_vars (get_base_name v) with
      | Some _ -> e (* Variable comes from "outside" (ie, parameter/return values) *)
      | None   -> ExpVar (add_iterators its v))
  | _ -> e

(* Convert variables names inside an expression *)
let rec update_expr (its:(ident*int) list)
                    (it_env:(var,var) Hashtbl.t)
                    (var_env : (var,var) Hashtbl.t)
                    (expr_env: (var,expr) Hashtbl.t)
                    (extern_vars:(ident,bool) Hashtbl.t)
                    (e:expr) : expr =
  let rec_call = update_expr its it_env var_env expr_env extern_vars in
  match e with
  | Const _ -> e
  | ExpVar v -> update_var_to_expr its it_env var_env expr_env extern_vars v
  | Shuffle(v,l) -> begin match update_var_to_expr its it_env var_env expr_env extern_vars v with
                          | ExpVar v' -> Shuffle(v',l)
                          | _ -> assert false end
  | Tuple l -> Tuple (List.map rec_call l)
  | Not e -> Not (rec_call e)
  (* TODO: Should do something with 'ae' *)
  | Shift(op,e,ae) -> Shift(op,rec_call e,update_aexpr it_env var_env expr_env ae)
  | Log(op,x,y) -> Log(op,rec_call x,rec_call y)
  | Arith(op,x,y) -> Arith(op,rec_call x,rec_call y)
  | Fun(f,l) -> Fun(f,List.map rec_call l)
  | _ -> print_endline (Usuba_print.expr_to_str e);
         assert false

(* Convert the variable names, and update deq's orig with |f| (since
   those deqs are being inlined from |f| into another node). *)
let rec update_vars_and_deqs
          (its:(ident*int) list)
          (it_env:(var,var) Hashtbl.t)
          (var_env : (var,var) Hashtbl.t)
          (expr_env: (var,expr) Hashtbl.t)
          (extern_vars:(ident,bool) Hashtbl.t)
          (f:ident)
          (body:deq list) : deq list =
  List.map (
      fun d -> {
        orig = (f,d.content) :: d.orig;
        content =
          match d.content with
          | Eqn(lhs,e,sync) -> Eqn( List.map (update_var_to_var its it_env var_env extern_vars) lhs,
                                    update_expr its it_env var_env expr_env extern_vars e, sync )
          | Loop(i,ei,ef,dl,opts) ->
             let i' = gen_iterator i in
             Hashtbl.add it_env (Var i) (Var i');
             let updated = Loop(i',ei,ef,update_vars_and_deqs its it_env var_env
                                                              expr_env extern_vars f dl,opts) in
             Hashtbl.remove it_env (Var i);
             updated }
    ) body

(* Changes the variables of |vars| into arrays of dimensions
   corresponding to the iterators in |its| *)
let update_vars (its:(ident*int) list) (vars:var_d list) : var_d list =
  let rec update_typ (its:(ident*int) list) (typ:typ) : typ =
    match its with
    | [] -> typ
    | (_,s) :: tl -> Array(update_typ tl typ,Const_e s) in
  let its = List.rev its in
  List.map (fun vd -> { vd with vd_typ = update_typ its vd.vd_typ }) vars

(* Inline a specific call (defined by lhs & args) *)
let inline_call (its:(ident*int) list) (to_inl:def) (args:expr list) (lhs:var list) (cnt:int) :
      p * deq list =
  (* Define a name conversion function *)
  let conv_name (id:ident) : ident =
    { id with name = Printf.sprintf "%s_%d_%s" to_inl.id.name cnt id.name } in

  (* Extract body, vars, params and name of the node to inline *)
  let (vars_inl,body_inl) = match to_inl.node with
    | Single(vars,body) -> vars, body
    | _ -> assert false in
  let p_in  = to_inl.p_in  in
  let p_out = to_inl.p_out in

  (* alpha-conversion environments *)
  let var_env = Hashtbl.create 100 in
  let extern_vars = Hashtbl.create 100 in
  let expr_env = Hashtbl.create 100 in
  (* p_out replaced by the lhs *)
  List.iter2 ( fun vd v -> Hashtbl.add var_env (Var vd.vd_id) v;
                           Hashtbl.add extern_vars (get_base_name v) true) p_out lhs;
  (* p_in replaced by the expressions of arguments *)
  List.iter2 ( fun vd e ->
               Hashtbl.add expr_env (Var vd.vd_id) e;
               List.iter (fun v -> Hashtbl.add extern_vars (get_base_name v) true)
                         (get_used_vars e)) p_in args;
  (* Create a list containing the new variables names *)
  let vars = List.map (fun vd -> { vd with vd_id = conv_name vd.vd_id;
                                           vd_orig = (to_inl.id,vd) :: vd.vd_orig}) vars_inl in
  (* nodes variables alpha-converted *)
  List.iter2 ( fun vd vd' ->
               Hashtbl.add var_env (Var vd.vd_id) (Var vd'.vd_id)) vars_inl vars;

  update_vars its vars,
  update_vars_and_deqs its (Hashtbl.create 10) var_env expr_env extern_vars to_inl.id body_inl


(* Inline all the calls to "to_inl" in a given node
   (desribed by its variables and body "vars,body") *)
(* |cnt| is used as a counter for alpha-conversion *)
let rec inline_in_node ?(its:(ident*int) list=[]) ?(cnt:int ref=ref 0)
                       (deqs:deq list) (to_inl:def) : p * deq list =
  let f_inl = to_inl.id.name in

  let (vars,deqs) =
    (* Unpack the list bellow into a single list of vars and
       a list of deqs *)
    List.split
      (* Find the calls to f_inl, and inline them.
       This will introduce new variables, which is
       why maps returns a (p * deq list) list. *)
      ( List.map (
            fun eqn ->
            match eqn.content with
            | Eqn(lhs,Fun(f,l),_) when f.name = f_inl ->
               incr cnt;
               inline_call its to_inl l lhs !cnt
            | Eqn _ -> [], [eqn]
            | Loop(i,ei,ef,dl,opts) ->
               let size = (abs ((eval_arith_ne ei) - (eval_arith_ne ef))) + 1 in
               let (vars, deqs) = inline_in_node ~its:((i,size)::its) ~cnt:cnt dl to_inl in
               vars, [ { eqn with content = Loop(i,ei,ef,deqs,opts) } ]
          ) deqs ) in
  List.flatten vars, List.flatten deqs


(* Perform the inlining of node "to_inline" at every call point *)
(* And removes the node from the program *)
let do_inline (prog:prog) (to_inline:def) : prog =

  { nodes =
      List.filter (fun def -> def.id <> to_inline.id) @@
        List.map (fun def ->
                  match def.node with
                  | Single(vars,body) ->
                     let (vars',body') = inline_in_node body to_inline in
                     { def with node = Single(vars @ vars',body') }
                  | _ -> def) prog.nodes }



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
    true
  else if is_single def.node then
    if is_more_than_n_percent_assign 50 (get_body def.node) then
      (* Node contains more than 50% assignments -> probably better to
         inline it *)
      true
    else
      false
  else
    (* Not a regular node; should not really happen (but it can
    because of the hack to keep lookup tables with -keep-tables) *)
    false

(* Returns true if |def| is chosen to be pre-inlined (in order to
   pre_schedule to be as effective as possible). For now, the
   condition is: more than 31 inputs and more than 31 outputs. The
   reasoning being that if this function takes that much
   inputs/outputs, it's very unlikely an Sbox and more likely either a
   linear function, or a wrapper around several S-boxes. In all cases,
   we'd rather have it inlined for pre-schedule to be able to do
   something. Small exception: if |def| is _no_inline and -inline-all
   wasn't enabled, then it's not inlined. *)
let should_pre_inline (def:def) : bool =
  let in_size  = List.fold_left (+) 0
                    (List.map (fun vd -> typ_size vd.vd_typ) def.p_in) in
  let out_size = List.fold_left (+) 0
                    (List.map (fun vd -> typ_size vd.vd_typ) def.p_out) in
  if (not !orig_conf.inline_all) && (is_noinline def) then false
  else ((in_size > 31) && (out_size > 31))
       || (is_more_than_n_percent_assign 65 (get_body def.node))


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
  else if conf.light_inline then
    is_inline node (* Only inline if node is marked as "_inline" *)
  else if !pre_inline then
    should_pre_inline node
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

(* Inlines only the functions that must be inlined. For now, those are
   functions that use tuple shifts with a shift size depending on a
   parameter *)
let rec vital_inline (prog:prog) (conf:config) : prog =
  match Must_inline.must_inline prog with
  | None      -> prog
  | Some node ->
     try vital_inline (do_inline prog node) conf with
       _ -> prog (* Program not normalized -> can't inline now *)


(* Inline every node that should be and hasn't already been
   (inlined contains the status of each node: inlined or not) *)
let rec _inline (prog:prog) (conf:config) inlined : prog =

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
    (* continue inlining *)
    _inline prog' conf inlined
  else
    (* inlining is done, return the prog *)
    prog


(* Main inlining function. _inline actually does most of the job *)
let run_common (prog:prog) (conf:config) : prog =
  if conf.no_inline then prog
  else
    (* Hashtbl containing the inlining status of each node:
     false if it is not already inlined, true if it is *)
    let inlined = Hashtbl.create 20 in
    List.iter (fun x -> Hashtbl.add inlined x.id.name false) prog.nodes;
    (* The last node is the entry point, it wouldn't make sense to try inline it *)
    Hashtbl.replace inlined (last prog.nodes).id.name true;

    (* And now, perform the inlining *)
    _inline prog conf inlined

let run _ (prog:prog) (conf:config) : prog =
  pre_inline := false;
  run_common prog conf

let run_pre_inline _ (prog:prog) (conf:config) : prog =
  pre_inline := true;
  orig_conf  := conf;
  if is_more_aggressive_than_auto conf then
    let conf = { conf with auto_inline  = true;
                           heavy_inline = false;
                           inline_all   = false } in
    run_common prog conf
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
