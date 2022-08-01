open Prelude
open Usuba_AST

(* WARNING: this module contains some old code, poorly written and
   document, kept around just in case. Interleave_generic is reasonably
   well written and documented, and is the current implementation of the
   interleaver -> look at it if you need to, and ignore everything else
   in this file. *)

(* Interleave_generic is a fully parametric interleaving module. It is
    parametrized (not in the sense "functor", but rather in the sense
    "its functions takes some parameters") by:

      - |inter_factor|: how many instances of the cipher should be
        interleaved

      - |grain|: at which granularity should the interleaving be done.

    All instructions are duplicated |inter_factor| times, except for
    function calls, where we just duplicate parameters, and loops,
    where only the body of the loop is duplicated.

    This implies that function calls and loops act as synchronization
    barriers and disrigard |grain|. For instance, consider the
    following code:

       a = x;
       b = y;
       forall i in [1, 2] { ... }

    With a |grain| of 3, it becomes:

       a = x;
       b = y;
       a__2 = x__2;
       b__2 = y__2;
       forall i in [1, 2] { ... }

    (note how |a__2| and |b__2| come before forall)


   TODO:

     - think about whether there should be a special case to not
       interleave the body of functions that are less than |grain|
       instructions long. Pro: it would make smaller code, and probably
       should be as fast, or maybe faster (less register pressure
       within the function). Cons: interleaving should happen when
       register pressure is low, and inlining a small function should
       always be useful, or at least not hurt the performances. Cons2:
       interleaving works tightly with scheduling, and this would
       prevent the scheduler from optimizing the interleaving.

     - determine best interleaving grain and factor by benchmarking
       during the compilation.
*)
module Interleave_generic = struct
  (* Adds the suffix |suffix| at the end of a var *)
  let rec update_var (env_var : var_d Ident.Hashtbl.t) (suffix : int) (v : var)
      : var =
    if
      (* SMTLIB_IMPORT: List.mem of sum type is authorized *)
      Stdlib.List.mem Pconst
        (Ident.Hashtbl.find env_var (Utils.get_base_name v)).vd_opts
    then v
    else
      match v with
      | Var v ->
          Var
            (Ident.bound_copy v
               (Format.asprintf "%a__%d" (Ident.pp ()) v suffix))
      | Index (v, ae) -> Index (update_var env_var suffix v, ae)
      | _ -> assert false

  (* Adds the suffix |suffix| at the end of the vars contained in |e| *)
  let rec update_expr (env_var : var_d Ident.Hashtbl.t) (suffix : int)
      (e : expr) : expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (update_var env_var suffix v)
    | Tuple l -> Tuple (List.map (update_expr env_var suffix) l)
    | Not e -> Not (update_expr env_var suffix e)
    | Shift (op, e, ae) -> Shift (op, update_expr env_var suffix e, ae)
    | Log (op, x, y) ->
        Log (op, update_expr env_var suffix x, update_expr env_var suffix y)
    | Arith (op, x, y) ->
        Arith (op, update_expr env_var suffix x, update_expr env_var suffix y)
    | Shuffle (v, l) -> Shuffle (update_var env_var suffix v, l)
    | _ -> assert false

  (* Duplicates variables in |lhs| (return values of |f|) and
     expressions of |l| (input arguments of |f|). *)
  let update_funcall (inter_factor : int) (env_var : var_d Ident.Hashtbl.t)
      (lhs : var list) (f : ident) (l : expr list) (sync : bool) : deq_i =
    let lhs =
      Basic_utils.flat_map
        (fun v ->
          v
          :: List.map
               (fun suffix -> update_var env_var suffix v)
               (Basic_utils.gen_list_bounds 2 inter_factor))
        lhs
    in
    let e_fun =
      Fun
        ( f,
          Basic_utils.flat_map
            (fun e ->
              e
              :: List.map
                   (fun suffix -> update_expr env_var suffix e)
                   (Basic_utils.gen_list_bounds 2 inter_factor))
            l )
    in
    Eqn (lhs, e_fun, sync)

  (* Returns |deqs| with the suffix |suffix| added at the end of each
     of the variables in each of the expression of |deqs|. *)
  let schedule_deqs (env_var : var_d Ident.Hashtbl.t) (suffix : int)
      (deqs : deq list) : deq list =
    List.map
      (fun deq ->
        {
          deq with
          content =
            (match deq.content with
            | Eqn (lhs, rhs, sync) ->
                Eqn
                  ( List.map (update_var env_var suffix) lhs,
                    update_expr env_var suffix rhs,
                    sync )
            | _ ->
                (* Loops should not reach this point *)
                assert false);
        })
      deqs

  (* Returns |deqs| duplicated |inter_factor| times by calling
     |schedule_deqs| |inter_factor| times. *)
  let schedule_now (inter_factor : int) (env_var : var_d Ident.Hashtbl.t)
      (deqs : deq list) : deq list =
    Basic_utils.flat_map
      (fun suffix -> schedule_deqs env_var suffix deqs)
      (Basic_utils.gen_list_bounds 2 inter_factor)

  (* The function that actually does the interleaving. *)
  let interleave_deqs (inter_factor : int) (grain : int)
      (env_var : var_d Ident.Hashtbl.t) (deqs : deq list) : deq list =
    (* aux iterates |deqs| while constructing a list of |grain|
       instructions that need to be scheduled once after |grain|
       instructions have been seen.
       Parameters:
           |remain|: how many instructions remain to be added to the
                     current batch
           |ready|: the current batch of instructions
           |nexts|: the remaining instructions (ie, the end of the
                   function)
    *)
    let rec aux (remain : int) (ready : deq list) (nexts : deq list) =
      match nexts with
      | [] -> schedule_now inter_factor env_var (List.rev ready)
      | nexts_hd :: nexts_tl -> (
          match remain with
          | 0 ->
              (* |ready| contains |grain| instructions and they need
                 to be duplicated |inter_factor| times *)
              schedule_now inter_factor env_var (List.rev ready)
              @ (* continue on with the next batch (|remain| set to
                   |grain|, and |ready| set to []) *)
              aux grain [] nexts
          | _ -> (
              (* |ready| contains less than |grain| instructions, keep
                 going on except if the current instruction is a
                 function call or a loop. *)
              match nexts_hd.content with
              | Eqn (lhs, Fun (f, l), sync) ->
                  (* A function call -> need to schedule |ready| now,
                     duplicate the inputs/outputs of the function call,
                     and continue with the next instructions. *)
                  schedule_now inter_factor env_var (List.rev ready)
                  @ [
                      {
                        nexts_hd with
                        content =
                          update_funcall inter_factor env_var lhs f l sync;
                      };
                    ]
                  @ aux grain [] nexts_tl
              | Loop (i, ei, ef, dls, opts) ->
                  (* A loop -> need to schedule |ready| now, duplicate
                     the loops body, and continue with the next
                     instructions. *)
                  schedule_now inter_factor env_var (List.rev ready)
                  @ [
                      {
                        nexts_hd with
                        content = Loop (i, ei, ef, aux grain [] dls, opts);
                      };
                    ]
                  @ aux grain [] nexts_tl
              | Eqn _ ->
                  (* A standard instruction, add it to |ready|, decrement
                     |remain|, and continue with the next instructions. *)
                  nexts_hd :: aux (remain - 1) (nexts_hd :: ready) nexts_tl))
    in
    aux grain [] deqs

  (* Duplicate |inter_factor| times each var_d of |vdl| *)
  let update_vds (inter_factor : int) (vdl : var_d list) : var_d list =
    Basic_utils.flat_map
      (fun vd ->
        vd
        ::
        (if
         (* SMTLIB_IMPORT: List.mem of sum type is authorized *)
         Stdlib.List.mem Pconst vd.vd_opts
        then []
        else
          List.map
            (fun i ->
              {
                vd with
                vd_id =
                  Ident.bound_copy vd.vd_id
                    (Format.asprintf "%a__%d" (Ident.pp ()) vd.vd_id i);
              })
            (Basic_utils.gen_list_bounds 2 inter_factor)))
      vdl

  (* Using a custom build_env_var to have opts and not just types in it. *)
  (* Note that local variables (|vars|) can't be const, but it's
     easier it the environment contains all variables (no need to
     find_opt, find is enough). *)
  let build_env_var (p_in : p) (p_out : p) (vars : p) : var_d Ident.Hashtbl.t =
    let env_var = Ident.Hashtbl.create 100 in
    List.iter (fun vd -> Ident.Hashtbl.add env_var vd.vd_id vd) p_in;
    List.iter (fun vd -> Ident.Hashtbl.add env_var vd.vd_id vd) p_out;
    List.iter (fun vd -> Ident.Hashtbl.add env_var vd.vd_id vd) vars;
    env_var

  let interleave_def (inter_factor : int) (grain : int) (def : def) : def =
    let p_in = update_vds inter_factor def.p_in in
    let p_out = update_vds inter_factor def.p_out in
    {
      def with
      p_in;
      p_out;
      node =
        (match def.node with
        | Single (vars, body) ->
            let env_var = build_env_var p_in p_out vars in
            Single
              ( update_vds inter_factor vars,
                interleave_deqs inter_factor grain env_var body )
        | _ -> def.node);
    }

  let interleave (prog : prog) (conf : Config.config) : prog =
    (* Using 2 as default inter_factor; that's a safe bet *)
    let inter_factor = if conf.inter_factor = 0 then 2 else conf.inter_factor in
    (* Using 1 as default grain; that's reasonable given the CPU
       architecture to maximize parallelism *)
    let grain = if conf.interleave = 0 then 1 else conf.interleave in
    if inter_factor > 1 then
      { nodes = List.map (interleave_def inter_factor grain) prog.nodes }
    else (* Nothing to do if inter_factor is less than 2 *)
      prog
end

module Dup3 = struct
  let rec dup3_var (v : var) : var =
    match v with
    | Var id -> Var (Ident.bound_copy3 id)
    | Index (v, i) -> Index (dup3_var v, i)
    | _ -> assert false

  let rec dup3_expr (e : expr) : expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (dup3_var v)
    | Tuple l -> Tuple (List.map dup3_expr l)
    | Shift (op, e, ae) -> Shift (op, dup3_expr e, ae)
    | Log (op, x, y) -> Log (op, dup3_expr x, dup3_expr y)
    | Not e -> Not (dup3_expr e)
    | Shuffle (v, p) -> Shuffle (dup3_var v, p)
    | Arith (op, x, y) -> Arith (op, dup3_expr x, dup3_expr y)
    | Fun (f, l) -> Fun (f, List.map dup3_expr l)
    | _ -> assert false

  let rec dup_var (v : var) : var =
    match v with
    | Var id -> Var (Ident.bound_copy2 id)
    | Index (v, i) -> Index (dup_var v, i)
    | _ -> assert false

  let rec dup_expr (e : expr) : expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (dup_var v)
    | Tuple l -> Tuple (List.map dup_expr l)
    | Shift (op, e, ae) -> Shift (op, dup_expr e, ae)
    | Not e -> Not (dup_expr e)
    | Log (op, x, y) -> Log (op, dup_expr x, dup_expr y)
    | Shuffle (v, p) -> Shuffle (dup_var v, p)
    | Arith (op, x, y) -> Arith (op, dup_expr x, dup_expr y)
    | Fun (f, l) -> Fun (f, List.map dup_expr l)
    | _ -> assert false

  let rec interleave_deqs (deqs : deq list) : deq list =
    Basic_utils.flat_map
      (fun d ->
        match d.content with
        | Eqn (lhs, e, sync) ->
            [
              d;
              {
                orig = d.orig;
                content = Eqn (List.map dup_var lhs, dup_expr e, sync);
              };
              {
                orig = d.orig;
                content = Eqn (List.map dup3_var lhs, dup3_expr e, sync);
              };
            ]
        | Loop (i, ei, ef, l, opts) ->
            [ { d with content = Loop (i, ei, ef, interleave_deqs l, opts) } ])
      deqs

  let dup_p (p : p) : p =
    Basic_utils.flat_map
      (fun vd ->
        [
          vd;
          { vd with vd_id = Ident.bound_copy2 vd.vd_id };
          { vd with vd_id = Ident.bound_copy3 vd.vd_id };
        ])
      p

  let interleave_def (def : def) : def =
    match def.node with
    | Single (vars, body) ->
        {
          def with
          p_in = dup_p def.p_in;
          p_out = dup_p def.p_out;
          node = Single (dup_p vars, interleave_deqs body);
        }
    | _ -> assert false

  let interleave (prog : prog) _ : prog =
    { nodes = Basic_utils.apply_last prog.nodes interleave_def }
end

(* GP-64: 37.05 -> 27.35  cycles/byte
   SSE  : 16.35 -> 14.70  cycles/byte
   AVX  : 13.40 -> 10.43  cycles/byte
   AVX2 : 7.70  -> 6.00   cycles/byte
*)
module Dup2 = struct
  let rec dup_var (v : var) : var =
    match v with
    | Var id -> Var (Ident.bound_copy2 id)
    | Index (v, i) -> Index (dup_var v, i)
    | _ -> assert false

  let rec dup_expr (e : expr) : expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (dup_var v)
    | Tuple l -> Tuple (List.map dup_expr l)
    | Shift (op, e, ae) -> Shift (op, dup_expr e, ae)
    | Log (op, x, y) -> Log (op, dup_expr x, dup_expr y)
    | Not e -> Not (dup_expr e)
    | Shuffle (v, p) -> Shuffle (dup_var v, p)
    | Arith (op, x, y) -> Arith (op, dup_expr x, dup_expr y)
    | Fun (f, l) -> Fun (f, List.map dup_expr l)
    | _ -> assert false

  let rec interleave_deqs (deqs : deq list) : deq list =
    Basic_utils.flat_map
      (fun d ->
        match d.content with
        | Eqn (lhs, e, sync) ->
            [
              d;
              {
                orig = d.orig;
                content = Eqn (List.map dup_var lhs, dup_expr e, sync);
              };
            ]
        | Loop (i, ei, ef, l, opts) ->
            [
              {
                orig = d.orig;
                content = Loop (i, ei, ef, interleave_deqs l, opts);
              };
            ])
      deqs

  let dup_p (p : p) : p =
    Basic_utils.flat_map
      (fun vd -> [ vd; { vd with vd_id = Ident.bound_copy2 vd.vd_id } ])
      p

  let interleave_def (def : def) : def =
    match def.node with
    | Single (vars, body) ->
        {
          def with
          p_in = dup_p def.p_in;
          p_out = dup_p def.p_out;
          node = Single (dup_p vars, interleave_deqs body);
        }
    | _ -> assert false

  let interleave (prog : prog) _ : prog =
    { nodes = Basic_utils.apply_last prog.nodes interleave_def }
end

(* GP-64: 37.05 -> 28.65  cycles/byte
   SSE  : 16.35 -> 13.83  cycles/byte
   AVX  : 13.40 -> 10.30  cycles/byte
   AVX2 : 7.70  -> 5.95   cycles/byte
*)
module Dup2_nofunc = struct
  let rec make_2nd_var (v : var) : var =
    match v with
    | Var id -> Var (Ident.bound_copy2 id)
    | Index (v, i) -> Index (make_2nd_var v, i)
    | _ -> assert false

  let rec make_2nd_expr (e : expr) : expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (make_2nd_var v)
    | Tuple l -> Tuple (List.map make_2nd_expr l)
    | Shift (op, e, ae) -> Shift (op, make_2nd_expr e, ae)
    | Log (op, x, y) -> Log (op, make_2nd_expr x, make_2nd_expr y)
    | Not e -> Not (make_2nd_expr e)
    | Shuffle (v, p) -> Shuffle (make_2nd_var v, p)
    | Arith (op, x, y) -> Arith (op, make_2nd_expr x, make_2nd_expr y)
    | Fun (f, l) -> Fun (f, List.map make_2nd_expr l)
    | _ ->
        Format.printf "Not valid: %a@." (Usuba_print.pp_expr ()) e;
        assert false

  let dup_var (v : var) : var list = [ v; make_2nd_var v ]
  let dup_expr (e : expr) : expr list = [ e; make_2nd_expr e ]

  let rec interleave_deqs (deqs : deq list) : deq list =
    Basic_utils.flat_map
      (fun d ->
        match d.content with
        | Eqn (lhs, e, sync) -> (
            match e with
            | Fun (f, l) ->
                [
                  {
                    d with
                    content =
                      Eqn
                        ( Basic_utils.flat_map dup_var lhs,
                          Fun (f, Basic_utils.flat_map dup_expr l),
                          sync );
                  };
                ]
            | _ ->
                [
                  d;
                  {
                    d with
                    content =
                      Eqn (List.map make_2nd_var lhs, make_2nd_expr e, sync);
                  };
                ])
        | Loop (i, ei, ef, l, opts) ->
            [ { d with content = Loop (i, ei, ef, interleave_deqs l, opts) } ])
      deqs

  let dup_p (p : p) : p =
    Basic_utils.flat_map
      (fun vd -> [ vd; { vd with vd_id = Ident.bound_copy2 vd.vd_id } ])
      p

  let interleave_def (def : def) : def =
    match def.node with
    | Single (vars, body) ->
        {
          def with
          p_in = dup_p def.p_in;
          p_out = dup_p def.p_out;
          node = Single (dup_p vars, interleave_deqs body);
        }
    | _ -> assert false

  let interleave (prog : prog) _ : prog =
    { nodes = List.map interleave_def prog.nodes }
end

(* GP-64: 37.05 ->    cycles/byte
   SSE  : 16.35 ->    cycles/byte
   AVX  : 13.40 ->    cycles/byte
   AVX2 : 7.70  ->    cycles/byte
*)
module Dup2_nofunc_param = struct
  (*
  let rec map_n (n:int) (f:'a -> 'b) (l:'a list) (acc:'b list) (res:'b list): 'b list =
    match l with
    | [] -> List.rev (acc @ res)
    | hd::tl -> if List.length acc = n then
                  map_n n f tl [f hd] (hd :: (acc @ res))
                else
                  map_n n f tl ((f hd) :: acc) (hd :: res)
  (* Warning: shadowing (and using) map_n above *)
  let map_n (n:int) (f:'a -> 'b) (l:'a list) : 'b list =
    map_n n f l [] []
   *)

  let build_complete_env_var (p_in : p) (p_out : p) (vars : p) :
      var_d VarHashtbl.t =
    let env = VarHashtbl.create 100 in

    let add_to_env (vd : var_d) : unit = VarHashtbl.add env (Var vd.vd_id) vd in

    List.iter add_to_env p_in;
    List.iter add_to_env p_out;
    List.iter add_to_env vars;

    env

  let rec make_2nd_var env_var (v : var) : var =
    match v with
    | Var id -> (
        match
          (* SMTLIB_IMPORT: List.mem of sum type is authorized *)
          Stdlib.List.mem Pconst
            (VarHashtbl.find env_var (Utils.get_var_base v)).vd_opts
        with
        | false -> Var (Ident.bound_copy2 id)
        | true -> v)
    | Index (v, i) -> Index (make_2nd_var env_var v, i)
    | _ -> assert false

  let rec make_2nd_expr env_var (e : expr) : expr =
    match e with
    | Const _ -> e
    | ExpVar v -> ExpVar (make_2nd_var env_var v)
    | Tuple l -> Tuple (List.map (make_2nd_expr env_var) l)
    | Shift (op, e, ae) -> Shift (op, make_2nd_expr env_var e, ae)
    | Log (op, x, y) ->
        Log (op, make_2nd_expr env_var x, make_2nd_expr env_var y)
    | Not e -> Not (make_2nd_expr env_var e)
    | Shuffle (v, p) -> Shuffle (make_2nd_var env_var v, p)
    | Arith (op, x, y) ->
        Arith (op, make_2nd_expr env_var x, make_2nd_expr env_var y)
    | Fun (f, l) -> Fun (f, List.map (make_2nd_expr env_var) l)
    | _ ->
        Format.printf "Not valid: %a@." (Usuba_print.pp_expr ()) e;
        assert false

  let dup_var env_var (v : var) : var list =
    match
      (* SMTLIB_IMPORT: List.mem of sum type is authorized *)
      Stdlib.List.mem Pconst
        (VarHashtbl.find env_var (Utils.get_var_base v)).vd_opts
    with
    | false -> [ v; make_2nd_var env_var v ]
    | true -> [ v ]

  (* TODO: this feels very wrong *)
  let dup_expr env_var (e : expr) : expr list =
    match e with
    | ExpVar v -> List.map (fun v -> ExpVar v) (dup_var env_var v)
    | _ -> [ e; make_2nd_expr env_var e ]

  (*let rec map_n (n:int) (f:'a -> ('b option * 'b option)) (l:'a list)
                (acc:'b list) (res:'b list) : 'b list =*)
  let rec map_n (n : int) f l acc res =
    match l with
    | [] -> List.rev (acc @ res)
    | hd :: tl -> (
        let res = if List.length acc = n then acc @ res else res in
        let acc = if List.length acc = n then [] else acc in
        let hd, hd' = f hd in
        match (hd, hd') with
        | None, None -> map_n n f tl [] (acc @ res)
        | None, Some hd' -> map_n n f tl [] (hd' :: (acc @ res))
        | Some hd, Some hd' -> map_n n f tl (hd' :: acc) (hd :: res)
        | Some hd, None -> map_n n f tl acc (hd :: res))

  (* Warning: shadowing (and using) map_n above *)
  let map_n (n : int) (f : 'a -> 'b option * 'b option) (l : 'a list) : 'b list
      =
    map_n n f l [] []

  let rec interleave_deqs env_var (g : int) (deqs : deq list) : deq list =
    map_n g
      (fun d ->
        match d.content with
        | Eqn (lhs, e, sync) -> (
            match e with
            | Fun (f, l) ->
                ( None,
                  Some
                    {
                      d with
                      content =
                        Eqn
                          ( Basic_utils.flat_map (dup_var env_var) lhs,
                            Fun (f, Basic_utils.flat_map (dup_expr env_var) l),
                            sync );
                    } )
            | _ ->
                ( Some d,
                  Some
                    {
                      d with
                      content =
                        Eqn
                          ( List.map (make_2nd_var env_var) lhs,
                            make_2nd_expr env_var e,
                            sync );
                    } ))
        | Loop (i, ei, ef, l, opts) ->
            ( None,
              Some
                {
                  d with
                  content = Loop (i, ei, ef, interleave_deqs env_var g l, opts);
                } ))
      deqs

  let dup_p (p : p) : p =
    Basic_utils.flat_map
      (fun vd ->
        (* SMTLIB_IMPORT: List.mem of sum type is authorized *)
        match Stdlib.List.mem Pconst vd.vd_opts with
        | true -> [ vd ]
        | false -> [ vd; { vd with vd_id = Ident.bound_copy2 vd.vd_id } ])
      p

  let interleave_def (g : int) (def : def) : def =
    match def.node with
    | Single (vars, body) ->
        let p_in = dup_p def.p_in in
        let p_out = dup_p def.p_out in
        let vars = dup_p vars in
        let env_var = build_complete_env_var p_in p_out vars in
        {
          def with
          p_in;
          p_out;
          node = Single (vars, interleave_deqs env_var g body);
        }
    | _ -> assert false

  let interleave (g : int) (prog : prog) _ : prog =
    { nodes = List.map (interleave_def g) prog.nodes }
end

let run _ (prog : prog) (conf : Config.config) =
  Interleave_generic.interleave prog conf
(* Dup2_nofunc_param.interleave conf.interleave prog conf *)
(*Dup2.interleave prog conf*)

let as_pass = (run, "Interleave", 0)
