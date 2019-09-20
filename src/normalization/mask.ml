(*********************************************************************
                          mask.ml

  Masks a program: each variable becomes an array of size
  MASKING_ORDER. Linear operators (xors) become loops. Non-linear
  operators (and, or) are left as-is (the generated C will use the
  appropriate macros).

 ********************************************************************)

open Usuba_AST
open Basic_utils
open Utils


(* This modules finds out which variables in a function are
   constants. This is useful because non-linear operations (and/or)
   are expensive to mask if they are between variables, but don't
   require special care if one of their operands is a constant. *)
(* This module works in the following way: initially, variables marked
   const are added to a constant set, and non-const inputs are added
   to a non-constant set. Then, every time a variable is set, if its
   operands are all consts, then it's added to the const set, else
   it's added to the non-const set (and remove from the const set;
   where it could be it is an array and a previous assignment in one
   of its index was const). *)
module Get_consts = struct

  let rec var_is_const (env_const:(ident,bool) Hashtbl.t)
                        (env_not_const:(ident,bool) Hashtbl.t)
                        (v:var) : bool =
    let id = get_base_name v in
    (* Not that a variable _cannot_ be in both |env_const| and
          |env_not_const|. The following 2 asserts make sure of that,
          even though it shouldn't be necessary to check it. *)
    if Hashtbl.mem env_const id then
      (assert (not (Hashtbl.mem env_not_const id));
       true)
    else
      (assert (Hashtbl.mem env_not_const id);
       false)


  let rec expr_is_const (env_const:(ident,bool) Hashtbl.t)
                        (env_not_const:(ident,bool) Hashtbl.t)
                        (e:expr) : bool =
    let rec_call = expr_is_const env_const env_not_const in
    match e with
    | Const _       -> true
    | ExpVar v      -> var_is_const env_const env_not_const v
    | Tuple l       -> List.for_all rec_call l
    | Not e'        -> rec_call e'
    | Shift(_,e',_) -> rec_call e'
    | Log(_,x,y)    -> (rec_call x) && (rec_call y)
    | Shuffle(v,_)  -> var_is_const env_const env_not_const v
    | Arith(_,x,y)  -> (rec_call x) && (rec_call y)
    | Fun(_,l)      -> (* Note: this is a bit of an approximation. A function could return both const & non-const values.... *)
       List.for_all rec_call l
    | _ -> Printf.eprintf "expr_is_const: not supported expression: %s.\n"
                          (Usuba_print.expr_to_str e);
           assert false


  let rec get_consts_deqs (env_const:(ident,bool) Hashtbl.t)
                          (env_not_const:(ident,bool) Hashtbl.t)
                          (deqs:deq list) : unit =
    List.iter (function
                | Eqn(lhs,e,_) ->
                   if expr_is_const env_const env_not_const e then
                     (* Adding variables that are not in
                        |env_not_const| to |env_const|. *)
                     List.iter (fun v ->
                                let id = get_base_name v in
                                match Hashtbl.find_opt env_not_const id with
                                | Some _ -> ()
                                | None -> Hashtbl.replace env_const id true) lhs
                   else
                     (* Adding |lhs| to |env_not_const|, and removing
                        them from |env_const|. *)
                     List.iter (fun v ->
                                let id = get_base_name v in
                                Hashtbl.replace env_not_const id true;
                                match Hashtbl.find_opt env_const id with
                                | Some _ -> Hashtbl.remove env_const id
                                | None   -> ()) lhs
                | Loop(_,_,_,dl,_) -> get_consts_deqs env_const env_not_const dl) deqs

  let get_consts_def (def:def) : (ident,bool) Hashtbl.t =
    match def.node with
    | Single(vars,body) ->
       let env_const     = Hashtbl.create 10 in
       let env_not_const = Hashtbl.create 10 in
       (* Setting up |env_const|. *)
       let add_consts (l:p) =
         List.iter (fun vd -> if is_const vd then
                                Hashtbl.add env_const vd.vid true) l in
       add_consts def.p_in;
       add_consts vars;
       (* Setting up |env_not_const|. Note that parameters are assumed
       not const by default, while nothing is assumed for local
       variables, nor for output variables. *)
       List.iter (fun vd -> if not (is_const vd) then
                              Hashtbl.add env_not_const vd.vid true) def.p_in;
       get_consts_deqs env_const env_not_const body;
       env_const
    | _ -> (* This case should be catched somewhere else (eg, on the caller's side) *)
       assert false
end

let masking_order = fresh_ident "MASKING_ORDER"
let loop_end      = Op_e(Sub,Var_e masking_order,Const_e 1)
let loop_idx      = fresh_ident "_mask_idx"

let make_loop_indexed (v:var) : var =
  Index(v,Var_e loop_idx)

let mask_var (vl:var) (ve:var) : deq list =
  [ Loop(loop_idx,Const_e 0,loop_end,
         [Eqn([make_loop_indexed vl],
              ExpVar(make_loop_indexed ve),false)],[])]
(*                                         ^^^^^   ^^ *)
(*                                   (eqn's sync)  (loop's opts)   *)

let mask_cst (vl:var) (c:int) (typ:typ option) : deq list =
  [ Eqn([Index(vl,Const_e 0)],Const(c,typ),false);
    Loop(loop_idx,Const_e 1,loop_end,
         [Eqn([make_loop_indexed vl],Const(0,typ),false)],[])]

let mask_shift (vl:var) (op:shift_op) (ve:var) (ae:arith_expr) : deq list =
  [ Loop(loop_idx,Const_e 0,loop_end,
         [Eqn([make_loop_indexed vl],
              Shift(op,ExpVar(make_loop_indexed ve),ae), false)],[])]

let mask_not (vl:var) (ve:var) : deq list =
  [ Eqn([Index(vl,Const_e 0)],Not(ExpVar(Index(ve,Const_e 0))),false);
    Loop(loop_idx,Const_e 1,loop_end,
         [Eqn([make_loop_indexed vl],ExpVar(make_loop_indexed ve),false)],[])]

let mask_xor (vl:var) (x:var) (y:var) : deq list =
  (* TODO: could be optimized if one of the operands is a constant... *)
  [ Loop(loop_idx,Const_e 0,loop_end,
         [Eqn([make_loop_indexed vl],
              Log(Xor,ExpVar(make_loop_indexed x),
                  ExpVar(make_loop_indexed y)),false)],[])]

type is_const = Zero | One | Two
let mask_and_or (env_var:(ident,typ) Hashtbl.t)
                (env_const:(ident,bool) Hashtbl.t)
                (vl:var) (op:log_op) (x:var) (y:var) : deq list =
  let (cst,x,y) = if (Hashtbl.mem env_const (get_base_name x)) &&
                       (Hashtbl.mem env_const (get_base_name y)) then (Two,x,y)
                  else if Hashtbl.mem env_const (get_base_name x) then (One,y,x)
                  else if Hashtbl.mem env_const (get_base_name y) then (One,x,y)
                  else (Zero,x,y) in
  match cst with
  | Zero -> [ Eqn([vl],Log(Masked op,ExpVar x,ExpVar y),false) ]
  | One  -> (* The second operand is a constant *)
     [ Loop(loop_idx,Const_e 0,loop_end,
            [Eqn([make_loop_indexed vl],
                 Log(op,ExpVar(make_loop_indexed x),
                     ExpVar(Index(y,Const_e 0))),false)],[])]
  | Two -> (* both operands are constant *)
     let zero_typ = get_var_type env_var x in
     [ Eqn([Index(vl,Const_e 0)],
           Log(op,ExpVar(Index(x,Const_e 0)),ExpVar(Index(y,Const_e 0))), false);
       Loop(loop_idx,Const_e 1,loop_end,
            [ Eqn([make_loop_indexed vl],Const(0,Some zero_typ),false) ],[])]

let mask_eqn (env_var:(ident,typ) Hashtbl.t)
             (env_const:(ident,bool) Hashtbl.t) (vl:var) (e:expr) : deq list =
  match e with
  | Const(c,typ) -> mask_cst vl c typ
  | ExpVar v     -> mask_var vl v
  | Shift(op,ExpVar v,ae)      -> mask_shift vl op v ae
  | Not(ExpVar v) -> mask_not vl v
  | Log(Xor,ExpVar x,ExpVar y) -> mask_xor vl x y
  | Log(And as op,ExpVar x,ExpVar y)
  | Log(Or as op,ExpVar x,ExpVar y)  -> mask_and_or env_var env_const vl op x y
  | _ -> Printf.eprintf "Cannot mask expression: %s.\n"
                        (Usuba_print.expr_to_str e);
         assert false

let rec mask_deqs (env_var:(ident,typ) Hashtbl.t)
                  (env_const:(ident,bool) Hashtbl.t)
                  (deqs:deq list) : deq list =
  flat_map (function
             | Eqn(lhs,Fun(f,l),sync) -> [ Eqn(lhs,Fun(f,l),sync) ]
             | Eqn([lv],e,_) -> mask_eqn env_var env_const lv e
             | Eqn _ -> assert false (* Not normalized *)
             | Loop(i,ei,ef,dl,sync) ->
                [ Loop(i,ei,ef,mask_deqs env_var env_const dl,sync) ]) deqs

let rec mask_typ (typ:typ) : typ =
  match typ with
  | Nat -> Nat
  | Uint(d,m,1) -> Array(typ,Var_e masking_order)
  | Uint(d,m,n) -> Array(Array(Uint(d,m,1),Var_e masking_order),Const_e n)
  | Array(typ',s) -> Array(mask_typ typ',s)

let mask_p (p:p) : p =
  List.map (fun vd -> { vd with vtyp = mask_typ vd.vtyp}) p

let mask_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     (* |env_var| is just used to type some (Const 0) introduced in mask_and_or *)
     let env_var   = build_env_var def.p_in def.p_out vars in
     let env_const = Get_consts.get_consts_def def in
     { def with p_in  = mask_p def.p_in;
                p_out = mask_p def.p_out;
                node  = Single(mask_p vars, mask_deqs env_var env_const body) }
  | _ -> Printf.eprintf "Cannot mask something else that a def (%s). Exiting.\n" def.id.name;
         assert false

let mask_prog (prog:prog) : prog =
  { nodes = List.map mask_def prog.nodes }
