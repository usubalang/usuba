open Usuba_AST
open Basic_utils
open Utils
open Pass_runner
open Inline_core


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
    | Log(_,x,y)     -> (must_inline_expr env_var env_in x) ||
                          (must_inline_expr env_var env_in y)
    | Arith(_,x,y)   -> (must_inline_expr env_var env_in x) ||
                          (must_inline_expr env_var env_in y)
    | Shift(_,e',ae) -> (must_inline_expr env_var env_in e') ||
                          (must_inline_shift env_var env_in e' ae)
    | Shuffle _      -> false
    | Mask(e',_)     -> must_inline_expr env_var env_in e'
    | Pack(l,_)      -> List.exists (must_inline_expr env_var env_in) l
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


(* Inlines only the functions that must be inlined. For now, those are
   functions that use tuple shifts with a shift size depending on a
   parameter *)
let rec vital_inline (prog:prog) (conf:config) : prog =
  match Must_inline.must_inline prog with
  | None      -> prog
  | Some node ->
     try vital_inline (do_inline prog node) conf with
       _ -> prog (* Program not normalized -> can't inline now *)
