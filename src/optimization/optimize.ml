open Basic_utils
open Utils
open Usuba_AST
open Usuba_print

(* Clean.clean_vars_decl removes unused variables from variable declarations of nodes
   (unused variables will likely be variables that have been optimized out) *)
module Clean = struct

  let rec clean_var env (var:var) : unit =
    match var with
    | Var id -> Hashtbl.replace env id 1
    | Index(v,_)
    | Range(v,_,_) | Slice(v,_) -> clean_var env v

  let rec clean_expr env (e:expr) : unit =
    match e with
    | ExpVar(v) -> clean_var env v
    | Tuple l -> List.iter (clean_expr env) l
    | Not e -> clean_expr env e
    | Shift(_,x,_) -> clean_expr env x
    | Log(_,x,y) -> clean_expr env x; clean_expr env y
    | Arith(_,x,y) -> clean_expr env x; clean_expr env y
    | Fun(_,l) -> List.iter (clean_expr env) l
    | Fun_v(_,_,l) -> List.iter (clean_expr env) l
    | Fby(ei,ef,_) -> clean_expr env ei; clean_expr env ef
    | _ -> ()

  let clean_in_deqs (vars:p) (deqs:deq list) : p =
    let env = Hashtbl.create 100 in
    let rec aux = function
      | Eqn(l,e,_) -> List.iter (clean_var env) l;
                      clean_expr env e
      | Loop(_,_,_,d,_) -> List.iter aux d in
    List.iter aux deqs;
    List.sort_uniq (fun a b -> compare a b)
                   ( List.filter (fun vd -> match Hashtbl.find_opt env vd.vid with
                                            | Some _ -> true
                                            | None -> false) vars)

  let clean_def (def:def) : def =
    match def.node with
    | Single(vars,body) ->
       let vars = clean_in_deqs vars body in
       { def with node = Single(vars,body) }
    | _ -> def

  let clean_vars_decl (prog:prog) (conf:config) : prog =
    { nodes = List.map clean_def prog.nodes }
end


let print title body conf =
  if conf.verbose >= 5 then
    begin
      Printf.fprintf stderr "%s\n" title;
      if conf.verbose >= 100 then
        Printf.fprintf stderr "%s\n" (Usuba_print.prog_to_str body)
    end


let run_pass title func conf prog =
  if conf.verbose >= 5 then
    Printf.fprintf stderr "\n\nRunning %s...\n%!" title;
  let res = func prog conf in
  if conf.verbose >= 5 then
    Printf.fprintf stderr "\n%s done.\n%!" title;
  if conf.verbose >= 100 then
    Printf.fprintf stderr "%s\n%!" (Usuba_print.prog_to_str res);
  res


let opt_prog (prog: Usuba_AST.prog) (conf:config) : Usuba_AST.prog =

  let run_pass title func ?(sconf = conf) prog =
    run_pass title func sconf prog in


  (* All optimization are opt-in/opt-out => selecting here which ones to do. *)
  let interleave  = if conf.interleave > 0 then Interleave.interleave      else fun p _ -> p in
  let schedule    = if conf.scheduling     then Scheduler.schedule         else fun p _ -> p in
  let share_var   = if conf.share_var      then Share_var.share_prog       else fun p _ -> p in
  (* Simple_opts alreay takes care of checking conf *)
  let simple_opts = Simple_opts.opt_prog in

  prog |>
    (run_pass "Interleaving" interleave)                             |>
    (run_pass "Simple_opts" simple_opts)                             |>
    (run_pass "Scheduling" schedule)                                 |>
    (run_pass "Share_var" share_var)                                 |>
    (run_pass "Cleaning var decls" Clean.clean_vars_decl)            |>
    (run_pass "Remove_dead_code" Remove_dead_code.remove_dead_code)
