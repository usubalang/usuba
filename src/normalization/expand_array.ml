(***************************************************************************** )
                                expand_array.ml

  ( *****************************************************************************)

open Usuba_AST

type array_fate = Keep | Remove | Split

(* Precision on the "force" parameter that we keep around in most functions:
   It has 3 values possible:
     Keep: keep array
     Remove: remove arrays
     Split: split arrays: arrays are kept around, but only as Index, not as Var.
   This was needed for rotations/shifts.
   More explanations in this commit: 24cf4b83aed7388c31f71c1b30ac8ba7a74bdc7c.
*)

(* To notify calling function that unrolling is necessary *)
exception Need_unroll of ident

(* Abstracting Hashtbl.
   This functions should replace the ones in Utils, one day. *)
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v

let env_fetch env v =
  try Hashtbl.find env v
  with Not_found -> raise (Errors.Error ("Not found: " ^ Ident.name v))

(* Using a custom eval_arith to raise Need_unroll with the correct
   argument. *)
let rec eval_arith env (e : Usuba_AST.arith_expr) : int =
  match e with
  | Const_e n -> n
  | Var_e id -> (
      match Hashtbl.find_opt env id with
      | Some v -> v
      | None -> raise (Need_unroll id))
  | Op_e (op, x, y) -> (
      let x' = eval_arith env x in
      let y' = eval_arith env y in
      match op with
      | Add -> x' + y'
      | Mul -> x' * y'
      | Sub -> x' - y'
      | Div -> x' / y'
      | Mod -> if x' >= 0 then x' mod y' else y' + (x' mod y'))

let rec check_need_unroll_it (env_it : (ident, bool) Hashtbl.t)
    (ae : arith_expr) : unit =
  match ae with
  | Const_e _ -> ()
  | Var_e id -> if Hashtbl.mem env_it id then raise (Need_unroll id)
  | Op_e (_, x, y) ->
      check_need_unroll_it env_it x;
      check_need_unroll_it env_it y

(* Returns true iff e uses variables. *)
let rec uses_var (e : arith_expr) : bool =
  match e with
  | Const_e _ -> false
  | Var_e _ -> true
  | Op_e (_, e1, e2) -> uses_var e1 && uses_var e2

(* Returns true iff v (or a 'subvar' of v is v is an Index) is in env_keep *)
let rec need_to_keep env_keep (v : var) : bool =
  match v with
  | Var id -> (
      match Hashtbl.find_opt env_keep id with Some _ -> true | _ -> false)
  | Index (v, _) -> need_to_keep env_keep v
  | _ -> assert false

(* Replaces Index with Var, thus removing arrays.
   remove_arr( Index(x,5) ) = Var( x'5 )
*)
let rec remove_arr (v : var) : var =
  match v with
  | Var _ -> v
  | Index (v', Const_e i) -> (
      match remove_arr v' with
      | Var id -> Var (Ident.fresh_suffixed id (Format.sprintf "%d'" i))
      | _ -> assert false)
  | _ ->
      Format.eprintf "Error: remove_arr(%a)@." (Usuba_print.pp_var ()) v;
      assert false

(* Warning: this shadows (and calls) the definition above *)
let remove_arr env_keep (v : var) : var =
  if need_to_keep env_keep v then v else remove_arr v

let expand_var env_var env_keep env force (v : var) : var list =
  let rec aux (v : var) : var list =
    match v with
    | Var _ -> [ v ]
    | Index (v', i) ->
        List.map (fun x -> Index (x, Utils.simpl_arith env i)) (aux v')
    | Range (v', ei, ef) ->
        (* Note: can raise Need_unroll *)
        let ei = eval_arith env ei in
        let ef = eval_arith env ef in
        Basic_utils.flat_map
          (fun v'' ->
            List.map
              (fun i -> Index (v'', Const_e i))
              (Basic_utils.gen_list_bounds ei ef))
          (aux v')
    | Slice (v', el) -> Basic_utils.flat_map (fun i -> aux (Index (v', i))) el
  in
  if force = Remove then
    List.map (remove_arr env_keep)
      (Basic_utils.flat_map (Utils.expand_var env_var) (aux v))
  else if force = Split then
    Basic_utils.flat_map (Utils.expand_var env_var) (aux v)
  else aux v

let expand_vars env_var env_keep env force (vars : var list) : var list =
  Basic_utils.flat_map (expand_var env_var env_keep env force) vars

let rec expand_expr env_var env_keep env env_it force (e : expr) : expr =
  let rec_call = expand_expr env_var env_keep env env_it force in
  match e with
  | Const _ -> e
  | ExpVar v ->
      let l = expand_var env_var env_keep env force v in
      Tuple
        (List.map
           (fun x ->
             match x with
             | Var id -> (
                 match Hashtbl.find_opt env id with
                 | Some i ->
                     Const (i, Some (Utils.get_var_type env_var (Var id)))
                 | None -> ExpVar x)
             | _ -> ExpVar x)
           l)
  | Tuple el -> Tuple (List.map rec_call el)
  | Not e' -> Not (rec_call e')
  | Log (op, e1, e2) -> Log (op, rec_call e1, rec_call e2)
  | Arith (op, e1, e2) -> Arith (op, rec_call e1, rec_call e2)
  | Shift (op, e1, ae) ->
      let e1' =
        expand_expr env_var env_keep env env_it
          (if force = Keep then Split else force)
          e1
      in
      (* if e1' greater than 1, then it's a shift of a tuple *)
      if Utils.get_expr_size env_var e1' > 1 then
        (* check_need_unroll_it will raise Need_unroll if ae depends on
           an iterator (since we are performing a shift on a tuple (which
           needs to be done at compile time), but we can only do it if the
           iterator has a value -> need to unroll). *)
        check_need_unroll_it env_it ae;
      Shift (op, e1', Utils.simpl_arith env ae)
  | Shuffle (v, pat) ->
      Tuple
        (List.map
           (fun x -> Shuffle (x, pat))
           (expand_var env_var env_keep env force v))
  | Bitmask (e, ae) -> Bitmask (rec_call e, ae)
  | Pack (e1, e2, t) -> Pack (rec_call e1, rec_call e2, t)
  | Fun (f, el) ->
      if Ident.name f = "refresh" then
        Fun
          ( f,
            List.map
              (expand_expr env_var env_keep env env_it
                 (if force = Remove then Remove else Split))
              el )
      else Fun (f, List.map rec_call el)
  | Fun_v (f, ae, el) ->
      (* Note: can raise Need_unroll *)
      Fun
        ( Ident.fresh_suffixed f (Format.sprintf "%d'" (eval_arith env ae)),
          List.map rec_call el )

let rec do_unroll env_var env_keep env force unroll x ei ef deqs : deq list =
  (* Note: can raise Need_unroll *)
  let ei = eval_arith env ei in
  let ef = eval_arith env ef in
  let eqs =
    Basic_utils.flat_map
      (fun i ->
        env_update env x i;
        expand_deqs env_var env_keep ~env force unroll deqs)
      (Basic_utils.gen_list_bounds ei ef)
  in
  env_remove env x;
  eqs

and expand_deqs env_var env_keep ?(env = make_env ())
    ?(env_it : (ident, bool) Hashtbl.t = make_env ()) (force : array_fate)
    (unroll : bool) (deqs : deq list) : deq list =
  Basic_utils.flat_map
    (fun deq ->
      match deq.content with
      | Eqn (lhs, e, sync) ->
          [
            {
              deq with
              content =
                Eqn
                  ( expand_vars env_var env_keep env force lhs,
                    expand_expr env_var env_keep env env_it force e,
                    sync );
            };
          ]
      | Loop (x, ei, ef, deqs, opts) ->
          Hashtbl.add env_var x Nat;
          Hashtbl.add env_it x true;
          let res =
            if List.mem Unroll opts || force = Remove || unroll then
              do_unroll env_var env_keep env force unroll x ei ef deqs
            else
              try
                [
                  {
                    deq with
                    content =
                      Loop
                        ( x,
                          ei,
                          ef,
                          expand_deqs env_var env_keep ~env ~env_it force unroll
                            deqs,
                          opts );
                  };
                ]
              with Need_unroll id ->
                if id = x then (
                  try do_unroll env_var env_keep env force unroll x ei ef deqs
                  with Need_unroll id2 ->
                    (* Unrolling failed and needs to unroll one level
                       higher -> need to clean the environements. *)
                    Hashtbl.remove env_var x;
                    Hashtbl.remove env x;
                    raise (Need_unroll id2))
                else (
                  (* Gonna update one loop above; need to clean the |env_var|. *)
                  Hashtbl.remove env_var x;
                  (* No need to clean |env| since |x| can's be in |env| here. *)
                  raise (Need_unroll id))
          in
          Hashtbl.remove env_var x;
          res)
    deqs

let expand_p (p : p) : p =
  let rec aux vd =
    match vd.vd_typ with
    | Nat -> [ vd ]
    | Array (t, size) ->
        Basic_utils.flat_map
          (fun i ->
            aux
              {
                vd with
                vd_id = Ident.fresh_suffixed vd.vd_id (Format.sprintf "%d'" i);
                vd_typ = t;
              })
          (Utils.gen_list_0_int (Utils.eval_arith_ne size))
    | Uint (_, _, 1) -> [ vd ]
    | Uint (dir, m, n) ->
        Basic_utils.flat_map
          (fun i ->
            aux
              {
                vd with
                vd_id = Ident.fresh_suffixed vd.vd_id (Format.sprintf "%d'" i);
                vd_typ = Uint (dir, m, 1);
              })
          (Utils.gen_list_0_int n)
  in
  Basic_utils.flat_map aux p

(* cf env_keep description in expand_def:
   env_keep: in the main: contains the parameters (they should be expanded)
             in the other functions: is empty.*)
let build_env_keep (p_in : p) (p_out : p) =
  let env = Hashtbl.create 100 in

  let f (vd : var_d) = Hashtbl.add env vd.vd_id true in

  List.iter f p_in;
  List.iter f p_out;

  env

let update_env_var (env_var : (ident, typ) Hashtbl.t) (p_in : p) (p_out : p)
    (vars : p) : unit =
  let add_to_env (vd : var_d) : unit =
    Hashtbl.replace env_var vd.vd_id vd.vd_typ
  in

  List.iter add_to_env p_in;
  List.iter add_to_env p_out;
  List.iter add_to_env vars

(* force:
      Keep: keep array
      Remove: remove arrays
      Split: split arrays: arrays are kept around, but only as Index, not as Var.
   unroll:
      true: unroll all loops
      false: keep loops that are not annotated "_unroll" and that can be kept
   keep_param:
      true: keep arrays in parameters
      false: expand arrays from parameters IFF force == Remove
*)
let expand_def (force : array_fate) (unroll : bool) (keep_param : bool)
    (def : def) : def =
  let expand_p = if force = Remove then expand_p else fun x -> x in
  let p_in = if keep_param then def.p_in else expand_p def.p_in in
  let p_out = if keep_param then def.p_out else expand_p def.p_out in
  {
    def with
    p_in;
    p_out;
    node =
      (match def.node with
      | Single (vars, body) ->
          (* env_var: contains the variables and their types *)
          let env_var = Utils.build_env_var def.p_in def.p_out vars in
          let vars = expand_p vars in
          update_env_var env_var p_in p_out vars;
          (* env_keep: in the main: contains the parameters
                                             (they should be expanded)
                                in the other functions: is empty. *)
          let env_keep =
            if keep_param then build_env_keep def.p_in def.p_out
            else Hashtbl.create 100
          in
          Single (vars, expand_deqs env_var env_keep force unroll body)
      | _ -> def.node);
  }

(* Like `map f l` but `g` is applied to the last element instead of `f`. *)
let rec map_special_last f g l =
  match l with
  | [] -> []
  | [ x ] -> [ g x ]
  | hd :: tl -> f hd :: map_special_last f g tl

let run _ (prog : prog) (conf : Config.config) : prog =
  let force = if conf.no_arr then Remove else Keep in
  let unroll = conf.unroll in
  {
    nodes =
      map_special_last
        (expand_def force unroll false)
        (expand_def force unroll conf.arr_entry)
        prog.nodes;
  }

let as_pass = (run, "Expand_array", 0)
