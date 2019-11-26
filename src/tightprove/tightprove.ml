open Usuba_AST
open Basic_utils
open Utils
open Printf

let get_vars_body = function
  | Single(vars,body) -> vars, body
  | _ -> assert false
let get_vars x = fst (get_vars_body x)
let get_body x = snd (get_vars_body x)



module Refresh = struct


  (* Replaces variables with their old names before inlining in |deqs|
     (|env| contains the association between old and new names) *)
  let norm_after_inlining (env:(ident,ident) Hashtbl.t) (deqs:deq list) : deq list =

    let rec norm_var (v:var) : var =
      match v with
      | Var id -> (try Var (Hashtbl.find env id)
                   with Not_found -> Var id)
      | Index(v,ae) -> Index(norm_var v,ae)
      | _ -> assert false in

    let rec norm_expr (e:expr) : expr =
      match e with
      | Const _        -> e
      | ExpVar v       -> ExpVar (norm_var v)
      | Tuple l        -> Tuple (List.map norm_expr l)
      | Not e          -> Not (norm_expr e)
      | Shift(op,x,ae) -> Shift(op,norm_expr x,ae)
      | Log(op,x,y)    -> Log(op,norm_expr x,norm_expr y)
      | Shuffle(v,l)   -> Shuffle(norm_var v,l)
      | Arith(op,x,y)  -> Arith(op,norm_expr x,norm_expr y)
      | Fun(f,l)       -> Fun(f,List.map norm_expr l)
      | _ -> assert false in

    let norm_deq (deq:deq) : deq =
      match deq with
      | Eqn(lhs,e,sync) -> Eqn(List.map norm_var lhs, norm_expr e, sync)
      | _ -> assert false in

    List.map norm_deq deqs

  (* |vd| is a new variable (created using "refresh"), which should be
     added into |f|'s body based on the content of |full_prog|. *)
  let refresh_function (f:def) (full_prog:def) (vd:var_d) : deq list =
    (* Step 1: find |vd|'s initialisation in |full_prog|. *)
    let rec find_vd_init l =
      match l with
      | [] -> assert false
      | hd :: tl -> match hd with
                    | Eqn([Var v],_,_) when v = vd.vid -> l
                    | _ -> find_vd_init tl in
    let full_prog = find_vd_init (get_body full_prog.node) in

    (* Step 2: find out the variable |rv| refreshed by |vd| (based on
       the result of Step 1) *)
    let vd_init = List.hd full_prog in
    let rv = match vd_init with
      | Eqn(_,Fun(_,[ExpVar v]),_) -> (get_base_name v)
      | _ -> assert false in

    (* Step 3: iterate |full_prog| up to where |vd| is first used. *)
    let rec find_first_vd_use l =
      match l with
      | [] -> assert false
      | hd :: tl -> match hd with
                    | Eqn(_,e,_) ->
                       if List.exists (fun id -> id = vd.vid)
                                      (List.map get_base_name
                                                (get_used_vars e)) then l
                       else find_first_vd_use tl
                    | _ -> assert false in
    let full_prog = find_first_vd_use full_prog in

    (* Step 4: generate a deq from Step 3's result, where |vd| is
       replaced by |rv|.*)
    let rec replace_vd_by_v_var (v:var) =
      match v with
      | Var id -> if id = vd.vid then Var rv else v
      | Index(v',idx) -> Index(replace_vd_by_v_var v',idx)
      | _ -> assert false in
    let rec replace_vd_by_v_expr (e:expr) : expr =
      match e with
      | Const _        -> e
      | ExpVar v       -> ExpVar (replace_vd_by_v_var v)
      | Tuple l        -> Tuple (List.map replace_vd_by_v_expr l)
      | Not e          -> Not (replace_vd_by_v_expr e)
      | Shift(op,x,ae) -> Shift(op,replace_vd_by_v_expr x,ae)
      | Log(op,x,y)    -> Log(op,replace_vd_by_v_expr x,replace_vd_by_v_expr y)
      | Shuffle(v,l)   -> Shuffle(replace_vd_by_v_var v,l)
      | Arith(op,x,y)  -> Arith(op,replace_vd_by_v_expr x,replace_vd_by_v_expr y)
      | Fun(f,l)       -> Fun(f,List.map replace_vd_by_v_expr l)
      | _ -> assert false in
    let deq = match vd_init with
      | Eqn(lhs,e,sync) -> Eqn(lhs,replace_vd_by_v_expr e,sync)
      | _ -> assert false in

    (* Step 5: iterate |f|'s body up to the deq |deq| generated in Step 4. *)
    let old_body = ref (get_body f.node) in
    let new_body = ref [] in
    let rec find_deq_in_f () =
      if List.hd !old_body = deq then ()
      else (new_body := (List.hd !old_body) :: !new_body;
            old_body := List.tl !old_body;
            find_deq_in_f ()) in
    find_deq_in_f ();

    (* Step 6: insert |vd|'s definition *)
    new_body := vd_init :: !new_body;

    (* Step 7: iterate simultaneously |f| and |full_prog|, replacing
       |rv| by |vd| as needed. Stop when reaching the end of |f| *)
    let full_prog = ref full_prog in
    let merge_vars (vf:var) (vo:var) : var =
      if get_base_name vf = vd.vid then vf else vo in
    let rec merge_expr (ef:expr) (eo:expr): expr =
      match ef, eo with
      | Const _, Const _                 -> eo
      | ExpVar vf, ExpVar vo             -> ExpVar (merge_vars vf vo)
      | Tuple lf, Tuple lo               -> Tuple (List.map2 merge_expr lf lo)
      | Not ef', Not eo'                 -> Not (merge_expr ef' eo')
      | Shift(_,ef',_), Shift(op,eo',ae) -> Shift(op,merge_expr ef' eo',ae)
      | Log(_,xf,yf),Log(op,xo,yo)       -> Log(op,merge_expr xf xo,merge_expr yf yo)
      | Shuffle(vf,_),Shuffle(vo,l)      -> Shuffle(merge_vars vf vo,l)
      | Arith(_,xf,yf),Arith(op,xo,yo)   -> Arith(op,merge_expr xf xo,merge_expr yf yo)
      | Fun(_,lf),Fun(f,lo)              -> Fun(f,List.map2 merge_expr lf lo)
      | _ -> assert false in
    let rec update_f_body () =
      match !old_body with
      | [] -> ()
      | hd :: tl ->
         let next_deq_full_prog = List.hd !full_prog in
         match hd with
         | Eqn(lhs,e_old_body,sync) ->
            (match next_deq_full_prog with
             | Eqn(_,e_full_prog,_) ->
                new_body := Eqn(lhs,merge_expr e_full_prog e_old_body,sync) :: !new_body;
                old_body  := List.tl !old_body;
                full_prog := List.tl !full_prog;
                update_f_body ()
             | _ -> assert false)
         | _ -> assert false in
    update_f_body ();

    List.rev !new_body

  (* |vd| is a new variable (created using "refresh"), which appears
     in |def| and need to be propagated back to a node in |prog_nodes|. *)
  let insert_refresh (prog_nodes:(ident,def) Hashtbl.t) (def:def) (vd:var_d) : unit =
    let env_var = Hashtbl.create 100 in
    List.iter (fun vd -> Hashtbl.add env_var vd.vid vd) def.p_in;
    List.iter (fun vd -> Hashtbl.add env_var vd.vid vd) def.p_out;
    List.iter (fun vd -> Hashtbl.add env_var vd.vid vd) (get_vars def.node);

    (* Step 1: find out which node to refresh: find which variable
       |vd| refreshes, and which node this variable comes from *)
    let refreshed_deq =
      try List.find (function
                      | Eqn([Var v],Fun(_,[ExpVar _]),sync) when v = vd.vid -> true
                      | _ -> false) (get_body def.node)
      with Not_found -> Printf.fprintf stderr "Couldn't find %s's definition...\n" vd.vid.name;
                        assert false in
    let refreshed_fun = match refreshed_deq with
      | Eqn(_,Fun(_,[ExpVar v]),_) -> (Hashtbl.find env_var (get_base_name v)).vid
      | _ -> assert false in
    let f = Hashtbl.find prog_nodes refreshed_fun in

    (* Step 2: update |f| by adding refresh *)
    let new_body = refresh_function f def vd in
    let new_vars = vd :: (get_vars f.node) in

    Hashtbl.replace prog_nodes f.id { f with node = Single(new_vars, new_body) }



  (* Computes a hash where keys are refreshed variables, and values
     are deqs that use those variables. The variables manipulated by
     those deqs have been un-inlined, so that two refreshes that touch
     exactly the same function in the same way can be identified as
     being "the same". *)
  let compute_refresh_graph (def:def) (refreshed:var_d list) : (var_d,deq list) Hashtbl.t =

    (* Computes a list of deq using |vd| on their right-hand side. *)
    let get_refreshed_list (vd:var_d) : deq list =
      match def.node with
      | Single(vars,body) ->
         let env = Hashtbl.create 100 in
         (* Using |gen_id| to avoid false positive because two functions
          would be using the same variable names. *)
         let gen_id ((f,vd):ident*var_d) =
           fresh_ident (sprintf "fun:%s var:%s" f.name vd.vid.name) in
         let add_to_env (vd:var_d) : unit =
           match vd.vorig with
           | [] -> ()
           | l  -> Hashtbl.add env vd.vid (gen_id (last l)) in
         List.iter add_to_env def.p_in;
         List.iter add_to_env def.p_out;
         List.iter add_to_env vars;

         norm_after_inlining env
                             (List.filter (function
                                            | Eqn(_,e,_) ->
                                               List.exists (fun v -> (get_base_name v) = vd.vid)
                                                           (get_used_vars e)
                                            | _ -> assert false) body)
      | _ -> assert false in

    let refresh_graph = Hashtbl.create 100 in

    List.iter (fun vd -> let l = get_refreshed_list vd in
                         Hashtbl.add refresh_graph vd l) refreshed;

    refresh_graph

  let propagate_refreshes (init_prog:prog) (def:def) (refreshed:var_d list) : prog =
    (* Computing equations directly impacted by each refresh in order
       to get a list of unique refreshes. *)
    let refresh_graph = compute_refresh_graph def refreshed in
    (* Filtering |refreshed| in order to keep uniques ones *)
    let refreshed = List.sort_uniq
                      (fun a b -> compare (Hashtbl.find refresh_graph a)
                                          (Hashtbl.find refresh_graph b))
                      refreshed in

    (* Storing the nodes as a Hashtbl in order to edit them easily *)
    let prog_nodes = Hashtbl.create 10 in
    List.iter (fun d -> Hashtbl.add prog_nodes d.id d) init_prog.nodes;

    (* Now inserting the refreshes in the initial functions *)
    List.iter (fun vd -> insert_refresh prog_nodes def vd) refreshed;

    (* Returning the new nodes by looking them up in the Hashtbl (but
       keeping the original order by maping over |init_prog|. *)
    { nodes = List.map (fun d -> Hashtbl.find prog_nodes d.id) init_prog.nodes }

end

(* Not quite the same "is_call_free" as in the Inline module: that one
   doesn't care about _no_inline functions. *)
let is_call_free (def:def) : bool =
  let rec deq_call_free (deq:deq) : bool =
    match deq with
    | Eqn(_,Fun(f,_),_) ->
       if f.name = "refresh" then true
       else false
    | Eqn _ -> true
    | Loop(_,_,_,dl,_) -> List.for_all deq_call_free dl in
  match def.node with
  | Single(_,body) ->
     List.for_all deq_call_free body
  | _ -> false


(* This is a bit ugly: after inlining, some stuffs need to be
   normalized again. Mainly, tuples, need to be unfolded again. Since
   there is no function that inlines everything _and_ normalized the
   program after, we define it here.*)
let clean_inline (prog:prog) (conf:config) : prog =
  let conf = { conf with inline_all = true; light_inline = false } in
  let prog = Inline.inline prog conf in
  let prog = Unfold_unnest.norm_prog     prog conf in
  let prog = Expand_array.expand_array   prog conf in
  let prog = Expand_permut.expand_permut prog conf in
  let prog = Norm_tuples.norm_tuples     prog conf in
  let prog = Shift_tuples.expand_shifts  prog conf in
  let prog = Norm_tuples.norm_tuples     prog conf in
  prog

(* |new_def| was produced using Tightprove_to_usuba, while |old_def|
   comes from the original AST. This function updates the variables of
   |new_def| in order to recover information about inlining in
   variables declarations. *)
let match_variables (new_def:def) (old_def:def) : def * (var_d list) =
  let get_varsd = function Single(vars,_) -> vars | _ -> assert false in
  match new_def.node with
  | Single(vars,body) ->
     (* Collecting old vars *)
     let old_vars = Hashtbl.create 100 in
     List.iter (fun vd -> Hashtbl.add old_vars vd.vid vd) (get_varsd old_def.node);

     (* Hashtable for new refreshes *)
     let new_refreshes = Hashtbl.create 10 in

     (* Updating new vars *)
     let new_vars =
       List.map (fun vd -> try Hashtbl.find old_vars vd.vid
                           with Not_found ->
                             Hashtbl.add new_refreshes vd true;
                             vd ) vars in
     { new_def with node = Single(new_vars,body) }, keys new_refreshes
  | _ -> assert false


(* Refreshes a program which doesn't contain loops *)
let refresh_prog (prog:prog) (conf:config) : prog =
  (* Step 1: fully inline prog *)
  let inlined_prog = clean_inline prog conf in
  assert (List.length inlined_prog.nodes = 1);
  let ua_def = List.hd inlined_prog.nodes in

  (* Step 2: call TP *)
  let (vars_corres,tp_def) = Usuba_to_tightprove.usuba_to_tp ua_def in
  let r_tp_def = Tp_IO.get_refreshed_def tp_def conf in

  (* Step 3: reconstruct Usuba node from TP *)
  let r_ua_def_raw = Tightprove_to_usuba.tp_to_usuba vars_corres ua_def r_tp_def in

  (* Step 4: match origin of variables in new program with variables
     in old one, get list of new variables *)
  let (r_ua_def,new_vars) = match_variables r_ua_def_raw ua_def in

  (* Step 5: insert refreshes *)
  Refresh.propagate_refreshes prog r_ua_def new_vars


(* Refreshes a def wich doesnt contain function calls nor loops *)
let refresh_simple_def (conf:config) (def:def) : def =
  if is_call_free def then
    let (vars_corres,tp_def) = Usuba_to_tightprove.usuba_to_tp def in
    let r_tp_def = Tp_IO.get_refreshed_def tp_def conf in
    Tightprove_to_usuba.tp_to_usuba vars_corres def r_tp_def
  else
    def

(* This is a simplified version that doesn't do inlining/unrolling. To
   improve.*)
let process_prog (prog:prog) (conf:config) : prog =
  let prog = { nodes = List.map (refresh_simple_def conf) prog.nodes } in
  (* let prog = refresh_prog prog conf in *)
  prog
