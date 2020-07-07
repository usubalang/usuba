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


(* A hashtable to store the possible parameter constness for each
   function. It is updated everytime Get_consts.get_consts_def is
   called. TODO: it would be cleaner to initialize it only once at the
   begining, and not have a global variable for that. *)
let fun_params : (ident,(bool list) list) Hashtbl.t = Hashtbl.create 100


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
      (if Hashtbl.mem env_not_const id then
         Printf.printf "%s is both const and not const\n" id.name;
       assert (not (Hashtbl.mem env_not_const id));
       true)
    else
      (assert (Hashtbl.mem env_not_const id);
       false)


  and expr_is_const (env_fun:(ident,def) Hashtbl.t)
                    (env_const:(ident,bool) Hashtbl.t)
                    (env_not_const:(ident,bool) Hashtbl.t)
                    (e:expr) : bool list =
    let rec_call = expr_is_const env_fun env_const env_not_const in
    match e with
    | Const _       -> [ true ]
    | ExpVar v      -> [ var_is_const env_const env_not_const v ]
    | Tuple l       -> flat_map rec_call l
    | Not e'        -> rec_call e'
    | Shift(_,e',_) -> rec_call e'
    | Log(_,x,y)    -> List.map2 (fun a b -> a && b) (rec_call x) (rec_call y)
    | Shuffle(v,_)  -> [ var_is_const env_const env_not_const v ]
    | Arith(_,x,y)  -> List.map2 (fun a b -> a && b) (rec_call x) (rec_call y)
    | Fun(f,l)      ->
       let params_consts = flat_map rec_call l in
       if f.name = "refresh" then params_consts
       else get_consts_inner_def env_fun params_consts f
    | _ -> Printf.eprintf "expr_is_const: not supported expression: %s.\n"
                          (Usuba_print.expr_to_str e);
           assert false


  and get_consts_deqs (env_fun:(ident,def) Hashtbl.t)
                      (env_const:(ident,bool) Hashtbl.t)
                      (env_not_const:(ident,bool) Hashtbl.t)
                      (deqs:deq list) : unit =
    List.iter (fun d -> match d.content with
                | Eqn(lhs,e,_) ->
                   List.iter2 (
                       fun v is_const ->
                       let id = get_base_name v in
                       if is_const then
                         match Hashtbl.find_opt env_not_const id with
                         | Some _ -> ()
                         | None -> Hashtbl.replace env_const id true
                       else
                         (Hashtbl.replace env_not_const id true;
                          match Hashtbl.find_opt env_const id with
                          | Some _ -> Hashtbl.remove env_const id
                          | None   -> ()))
                              lhs (expr_is_const env_fun env_const env_not_const e)
                | Loop(_,_,_,dl,_) -> assert false (* Loops have been unrolled *)
              ) deqs

  (* This function is used on node calls: it returns the constness of
     the return values of |def| rather than an environment with the
     constness of all variables of |def|. *)
  and get_consts_inner_def (env_fun:(ident,def) Hashtbl.t) (consts_in:bool list)
                           (f:ident) : bool list  =
    (* Updating |fun_params| *)
    if consts_in <> [] then
      (match Hashtbl.find_opt fun_params f with
       | Some l -> Hashtbl.replace fun_params f (consts_in :: l)
       | None   -> Hashtbl.add     fun_params f [ consts_in ]);

    let def = Hashtbl.find env_fun f in

    let env_const = get_consts_def env_fun ~consts_in:consts_in def in

    List.map (fun vd -> Hashtbl.mem env_const vd.vd_id) def.p_out

  (* Returns a hash containing the constness of all variables of |def|. *)
  and get_consts_def (env_fun:(ident,def) Hashtbl.t) ?(consts_in:bool list = [])
                     (def:def) : (ident,bool) Hashtbl.t =
    match def.node with
    | Single(vars,body) ->
       let env_const     = Hashtbl.create 10 in
       let env_not_const = Hashtbl.create 10 in
       (* Setting up |env_const|. *)
       if List.length consts_in <> 0 then
         List.iter2 (fun vd b -> if b then Hashtbl.add env_const vd.vd_id true
                                 else Hashtbl.add env_not_const vd.vd_id true)
                    def.p_in consts_in
       else
         (* Parameters are assumed not const by default, while nothing
            is assumed for local variables, nor for output variables. *)
         List.iter (fun vd -> Hashtbl.add env_not_const vd.vd_id true) def.p_in;

       (* Note: we need to unroll the loops before trying to find the
           constants, since an iteration could change a constant into
           a non-constant. For instance:

               x[0] = 0;
               forall i in [0, 4] {
                 y[i] = x[i] ^ 0xf0f0;
                 x[i+1] = x[i] ^ secret_input[i];
               }

           When stumbling upon `y[i] = x[i] ^ 0xf0f0` for the first time,
           `x[i]` is thought to be constant (since `x` was set const when
           doing `x[0] = 0`), but in the end of the iteration it turns
           out than `x` is actually no constant.
        *)
       let body = Unroll.unroll_deqs (Hashtbl.create 10) true def.id body in
       (*                            ^^^^^^^^^^^^^^^^^^  ^^^^             *)
       (*                                   env_it       force            *)

       get_consts_deqs env_fun env_const env_not_const body;

       (* Removing non-constant variables from |env_const|. It could
          happen because for instance the first cell of an array is
          constant but not the next ones. In that case, we remove the
          whole array. This is a bit approximative: ideally we would
          like a finer analysis. TODO! *)
       Hashtbl.iter (fun id _ -> Hashtbl.remove env_const id) env_not_const;

       env_const
    | _ -> (* This case should be catched somewhere else (eg, on the caller's side) *)
       assert false
end

let masking_order = fresh_ident "MASKING_ORDER"
let loop_end      = Op_e(Sub,Var_e masking_order,Const_e 1)
let loop_idx      = fresh_ident "_mask_idx"

let make_loop_indexed (v:var) : var =
  Index(v,Var_e loop_idx)

let mask_var (env_var:(ident,typ) Hashtbl.t)
             (env_const:(ident,bool) Hashtbl.t)
             (orig:(ident*deq_i) list) (vl:var) (ve:var) : deq list =
  match Hashtbl.mem env_const (get_base_name vl) with
  | true  ->
     (match Hashtbl.mem env_const (get_base_name ve) with
      | true  -> (* const = const *)
         [ { orig=orig; content=Eqn([vl],ExpVar ve, false) } ]
      | false -> (* const = var *)
         Printf.eprintf "Cannot convert non-constant into constant.\n";
                 assert false)
  | false ->
     match Hashtbl.mem env_const (get_base_name ve) with
     | true  -> (* var = const *)
        let typ = get_var_type env_var vl in
        [ {orig=orig;
           content=Eqn([Index(vl,Const_e 0)],ExpVar ve,false)};
          {orig=orig;
           content=Loop(loop_idx,Const_e 1,loop_end,
                        [{orig=orig;
                          content=Eqn([make_loop_indexed vl],
                                      Const(0,Some typ),false)}],[])}]
     | false -> (* var = var *)
        [ { orig=orig;
            content=
              Loop(loop_idx,Const_e 0,loop_end,
                   [{orig=orig;
                     content=Eqn([make_loop_indexed vl],
                                 ExpVar(make_loop_indexed ve),false)}],[]) }]
(*                                                            ^^^^^    ^^ *)
(*                                                   (eqn's sync)  (loop's opts)   *)

let mask_cst (env_const:(ident,bool) Hashtbl.t)
             (orig:(ident*deq_i) list) (vl:var) (c:int) (typ:typ option) : deq list =
  match Hashtbl.mem env_const (get_base_name vl) with
  | true  -> (* const = const *)
     [ { orig = orig; content=Eqn([vl],Const(c,typ),false) } ]
  | false -> (* var = const *)
     if c = 0 then
       [ { orig=orig;
           content=
             Loop(loop_idx,Const_e 0,loop_end,
                  [{orig=orig;
                    content=Eqn([make_loop_indexed vl],Const(0,typ),false)}],[]) }]
     else
       [ { orig=orig; content=Eqn([Index(vl,Const_e 0)],Const(c,typ),false) };
         { orig=orig;
           content=Loop(loop_idx,Const_e 1,loop_end,
                        [{orig=orig;
                          content=Eqn([make_loop_indexed vl],Const(0,typ),false)}],[])}]

let mask_shift (env_var:(ident,typ) Hashtbl.t)
               (env_const:(ident,bool) Hashtbl.t)
               (orig:(ident*deq_i) list) (vl:var) (op:shift_op)
               (ve:var) (ae:arith_expr) : deq list =
  match Hashtbl.mem env_const (get_base_name vl) with
  | true ->
     (match Hashtbl.mem env_const (get_base_name ve) with
      | true  -> (* const = const *)
         [ { orig=orig; content=Eqn([vl],Shift(op,ExpVar ve,ae),false) } ]
      | false -> (* const = var *)
         Printf.eprintf "Cannot convert non-constant into constant.\n";
         assert false)
  | false ->
     match Hashtbl.mem env_const (get_base_name ve) with
      | true  -> (* var = const *)
         let typ = get_var_type env_var vl in
         [ { orig=orig; content=Eqn([vl],Shift(op,ExpVar ve,ae),false) };
           { orig=orig;
             content=
               Loop(loop_idx,Const_e 1,loop_end,
                    [{orig=orig;
                      content=Eqn([make_loop_indexed vl],
                                  Const(0,Some typ), false)}],[])} ]
      | false -> (* var = var *)
         [ { orig=orig;
             content=
               Loop(loop_idx,Const_e 0,loop_end,
                    [{orig=orig;
                      content=Eqn([make_loop_indexed vl],
                                  Shift(op,ExpVar(make_loop_indexed ve),ae), false)}],[])}]

let mask_not (env_var:(ident,typ) Hashtbl.t)
             (env_const:(ident,bool) Hashtbl.t)
             (orig:(ident*deq_i) list) (vl:var) (ve:var) : deq list =
  match Hashtbl.mem env_const (get_base_name vl) with
  | true ->
     (match Hashtbl.mem env_const (get_base_name ve) with
      | true  -> (* const = const *)
         [ { orig=orig; content=Eqn([vl],Not (ExpVar ve),false) } ]
      | false -> (* const = var *)
         Printf.eprintf "Cannot convert non-constant into constant.\n";
         assert false)
  | false ->
     match Hashtbl.mem env_const (get_base_name ve) with
     | true  -> (* var = const *)
        let typ = get_var_type env_var vl in
        [ {orig=orig;
           content=Eqn([Index(vl,Const_e 0)],Not(ExpVar ve),false)};
          {orig=orig;
           content=Loop(loop_idx,Const_e 1,loop_end,
                        [{orig=orig;
                          content=Eqn([make_loop_indexed vl],
                                      Const(0,Some typ),false)}],[])}]
     | false -> (* var = var *)
        [ {orig=orig;
           content=Eqn([Index(vl,Const_e 0)],Not(ExpVar(Index(ve,Const_e 0))),false)};
          {orig=orig;
           content=Loop(loop_idx,Const_e 1,loop_end,
                        [{orig=orig;
                          content=Eqn([make_loop_indexed vl],
                                      ExpVar(make_loop_indexed ve),false)}],[])}]

type is_const = Zero | One | Two

let mask_xor (env_var:(ident,typ) Hashtbl.t)
             (env_const:(ident,bool) Hashtbl.t)
             (orig:(ident*deq_i) list) (vl:var) (x:var) (y:var) : deq list =
  let (cst,x,y) = if (Hashtbl.mem env_const (get_base_name x)) &&
                       (Hashtbl.mem env_const (get_base_name y)) then (Two,x,y)
                  else if Hashtbl.mem env_const (get_base_name x) then (One,y,x)
                  else if Hashtbl.mem env_const (get_base_name y) then (One,x,y)
                  else (Zero,x,y) in
  let typ = get_var_type env_var x in
  match cst with
  | Zero ->
     (match Hashtbl.mem env_const (get_base_name vl) with
      | true -> (* const = var ^ var *)
         Printf.eprintf "Cannot convert non-constant into constant.\n";
         assert false
      | false -> (* var = var ^ var *)
         (* Xoring share by share *)
         [ { orig=orig;
             content=
               Loop(loop_idx,Const_e 0,loop_end,
                    [{orig=orig;
                      content=Eqn([make_loop_indexed vl],
                                  Log(Xor,ExpVar(make_loop_indexed x),
                                      ExpVar(make_loop_indexed y)),false)}],[])}])
  | One ->
     (match Hashtbl.mem env_const (get_base_name vl) with
      | true -> (* const = var ^ const *)
         Printf.eprintf "Cannot convert non-constant into constant.\n";
         assert false
      | false -> (* var = var ^ const *)
         (* Xoring first share with the constant and the next ones with 0 *)
         [ { orig=orig;
             content=Eqn([Index(vl,Const_e 0)],
                         Log(Xor,ExpVar(Index(x,Const_e 0)),ExpVar y), false)};
           { orig=orig;
             content=
               Loop(loop_idx,Const_e 1,loop_end,
                    [{orig=orig;
                      content=Eqn([make_loop_indexed vl],
                                  Log(Xor,ExpVar(make_loop_indexed x),
                                      Const(0,Some typ)),false)}],[])}])
  | Two ->
     match Hashtbl.mem env_const (get_base_name vl) with
     | true -> (* const = const ^ const *)
        (* Straightforward Xor *)
        [ { orig=orig;
            content=Eqn([vl],Log(Xor,ExpVar x,ExpVar y),false) } ]
     | false -> (* var = const ^ const *)
         [ { orig=orig;
             content=Eqn([Index(vl,Const_e 0)],
                         Log(Xor,ExpVar x,ExpVar y), false)};
           { orig=orig;
             content=
               Loop(loop_idx,Const_e 1,loop_end,
                    [{orig=orig;
                      content=Eqn([make_loop_indexed vl],Const(0,Some typ),false)}],[])}]



let mask_and_or (env_var:(ident,typ) Hashtbl.t)
                (env_const:(ident,bool) Hashtbl.t)
                (orig:(ident*deq_i) list) (vl:var) (op:log_op) (x:var) (y:var) : deq list =
  let (cst,x,y) = if (Hashtbl.mem env_const (get_base_name x)) &&
                       (Hashtbl.mem env_const (get_base_name y)) then (Two,x,y)
                  else if Hashtbl.mem env_const (get_base_name x) then (One,y,x)
                  else if Hashtbl.mem env_const (get_base_name y) then (One,x,y)
                  else (Zero,x,y) in
  let typ = get_var_type env_var x in
  match cst with
  | Zero ->
     (match Hashtbl.mem env_const (get_base_name vl) with
      | true  -> (* const = var & var *)
         Printf.eprintf "Cannot convert non-constant into constant.\n";
         assert false
      | false -> (* var = var & var *)
        [ {orig=orig; content=Eqn([vl],Log(Masked op,ExpVar x,ExpVar y),false)} ])
  | One  -> (* The second operand is a constant *)
     (match Hashtbl.mem env_const (get_base_name vl) with
      | true  -> (* const = var & const *)
         Printf.eprintf "Cannot convert non-constant into constant.\n";
         assert false
      | false -> (* var = var & const *)
         [ {orig=orig;
            content=
              Loop(loop_idx,Const_e 0,loop_end,
                   [{orig=orig;
                     content=Eqn([make_loop_indexed vl],
                                 Log(op,ExpVar(make_loop_indexed x),ExpVar y),false)}],[])}])
  | Two -> (* both operands are constant *)
     match Hashtbl.mem env_const (get_base_name vl) with
     | true -> (* const = const & const *)
        [ {orig=orig;
           content=Eqn([vl],
                       Log(op,ExpVar x,ExpVar y), false)} ]
     | false -> (* var = const & const *)
         [ { orig=orig;
             content=Eqn([Index(vl,Const_e 0)],
                         Log(op,ExpVar x,ExpVar y), false)};
           { orig=orig;
             content=
               Loop(loop_idx,Const_e 1,loop_end,
                    [{orig=orig;
                      content=Eqn([make_loop_indexed vl],Const(0,Some typ),false)}],[])}]

let mask_eqn (env_var:(ident,typ) Hashtbl.t)
             (env_const:(ident,bool) Hashtbl.t)
             (orig:(ident*deq_i) list) (vl:var) (e:expr)
    : deq list =
  match get_var_m env_var vl with
  | Mnat -> (* not masking nats *) [ {orig=orig;content=Eqn([vl],e,false)} ]
  | _ ->
     match e with
     | Const(c,typ) -> mask_cst env_const orig vl c typ
     | ExpVar v     -> mask_var env_var env_const orig vl v
     | Shift(op,ExpVar v,ae)      -> mask_shift env_var env_const orig vl op v ae
     | Not(ExpVar v) -> mask_not env_var env_const orig vl v
     | Log(Xor,ExpVar x,ExpVar y) -> mask_xor env_var env_const orig vl x y
     | Log(And as op,ExpVar x,ExpVar y)
     | Log(Or as op,ExpVar x,ExpVar y)  -> mask_and_or env_var env_const orig vl op x y
     | _ -> Printf.eprintf "Cannot mask expression: %s.\n"
                           (Usuba_print.expr_to_str e);
            assert false

let rec mask_deqs (env_var:(ident,typ) Hashtbl.t)
                  (env_const:(ident,bool) Hashtbl.t)
                  (deqs:deq list) : deq list =
  flat_map (fun d -> match d.content with
             | Eqn(lhs,Fun(f,l),sync) -> [ { d with content = Eqn(lhs,Fun(f,l),sync) } ]
             | Eqn([lv],e,_) -> mask_eqn env_var env_const d.orig lv e
             | Eqn _ -> assert false (* Not normalized *)
             | Loop(i,ei,ef,dl,sync) ->
                [ { d with content = Loop(i,ei,ef,mask_deqs env_var env_const dl,sync) } ]) deqs

let rec mask_typ (typ:typ) : typ =
  match typ with
  | Nat -> Nat
  | Uint(d,m,1) -> Array(typ,Var_e masking_order)
  | Uint(d,m,n) -> Array(Array(Uint(d,m,1),Var_e masking_order),Const_e n)
  | Array(typ',s) -> Array(mask_typ typ',s)

let mask_p (env_const:(ident,bool) Hashtbl.t) (p:p) : p =
  List.map (fun vd -> { vd with vd_typ = match Hashtbl.find_opt env_const vd.vd_id with
                                         | Some _ -> vd.vd_typ
                                         | None   -> mask_typ vd.vd_typ}) p

let mask_def (env_fun:(ident,def) Hashtbl.t) (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let consts_params = match Hashtbl.find_opt fun_params def.id with
       | Some (hd :: tl) -> if List.for_all (fun x -> x = hd) (hd::tl) then hd
                            else (Printf.eprintf "Node %s is called with constness-varying parameters. Usubac does not handle that for now. Overaproximating for now, which may produce too many ISW multiplications that needed.\n" def.id.name;
                                  [])
       | _ -> [] (* Node not called *) in

     (* |env_var| is just used to type some (Const 0) introduced in mask_and_or *)
     let env_var   = build_env_var def.p_in def.p_out vars in
     let env_const = Get_consts.get_consts_def env_fun ~consts_in:consts_params def in

     { def with p_in  = mask_p env_const def.p_in;
                p_out = mask_p env_const def.p_out;
                node  = Single(mask_p env_const vars, mask_deqs env_var env_const body) }
  | _ -> Printf.eprintf "Cannot mask something else that a def (%s). Exiting.\n" def.id.name;
         assert false

let run _ (prog:prog) (_:config) : prog =
  let env_fun = Hashtbl.create 10 in
  List.iter (fun def -> Hashtbl.add env_fun def.id def) prog.nodes;
  (* Note that we need to iter nodes in reverse order in order to know
     the constness of the parameters of each node. *)
  { nodes = List.rev_map (mask_def env_fun) (List.rev prog.nodes) }


let as_pass = (run, "Mask")
