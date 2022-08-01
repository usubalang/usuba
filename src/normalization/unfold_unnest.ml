open Prelude
open Usuba_AST

let sum_type = List.fold_left (fun tot vd -> tot + Utils.typ_size vd.vd_typ) 0

(* ************************************************************************** *)

let reduce_same_list l =
  try
    List.fold_left
      (fun acc t -> if equal_typ acc t then acc else raise Exit)
      (List.hd l) l
  with Exit ->
    Format.eprintf "Error: list [%a] isn't type-homogeneous.@."
      (Usuba_print.pp_typ_list ())
      l;
    assert false

let expand_intn (id : ident) (n : int) : ident list =
  if n = 1 || n = 0 then [ id ]
  else
    let rec aux i =
      if i > n then []
      else Ident.fresh_suffixed id (string_of_int i) :: aux (i + 1)
    in
    aux 1

let expand_intn_typed (id : ident) (n : int) =
  List.map (fun x -> (x, Utils.bool)) (expand_intn id n)

let expand_intn_pat (id : ident) (n : int) : var list =
  List.map (fun x -> Var x) (expand_intn id n)

let expand_intn_expr (id : ident) (n : int option) : expr =
  match n with
  | Some n -> Tuple (List.map (fun x -> ExpVar (Var x)) (expand_intn id n))
  | None -> ExpVar (Var id)

(* Differs a bit from the version of utils in how Const are handled *)
let rec get_expr_type env_fun env_var (ltyp : typ list) (e : expr) : typ list =
  match e with
  | Const (n, None) ->
      Format.eprintf "Invalid untyped const (0x%x). Exiting.@." n;
      assert false
  | Const (_, Some typ) -> [ typ ]
  | ExpVar v -> [ Utils.get_var_type env_var v ]
  | Tuple l -> Basic_utils.flat_map (get_expr_type env_fun env_var ltyp) l
  | Not e -> get_expr_type env_fun env_var ltyp e
  | Log (_, e, _) -> get_expr_type env_fun env_var ltyp e
  | Arith (_, e, _) -> get_expr_type env_fun env_var ltyp e
  | Shift (_, e, _) -> get_expr_type env_fun env_var ltyp e
  | Shuffle (v, _) -> [ Utils.get_var_type env_var v ]
  | Bitmask (e, _) -> get_expr_type env_fun env_var ltyp e
  | Pack (_, _, Some typ) -> [ typ ]
  | Fun (f, l) ->
      if String.equal (Ident.name f) "rand" then
        [ Uint (Utils.default_dir, Mint 1, 1) ]
      else if String.equal (Ident.name f) "refresh" then
        Basic_utils.flat_map (get_expr_type env_fun env_var ltyp) l
      else
        let def = Ident.Hashtbl.find env_fun f in
        List.map (fun vd -> vd.vd_typ) def.p_out
  | _ -> assert false

let new_vars : p ref = ref []

(* |its| is supposed to be in the correct order here (ie, it was
   reversed before calling this function since it's created in reverse
   order). *)
let rec typ_of_its (its : (ident * int) list) (typ : typ) : typ =
  match its with
  | [] -> typ
  | hd :: tl -> Array (typ_of_its tl typ, Const_e (snd hd))

(* |its| is supposed to be in the correct order here (ie, it was
   reversed before calling this function since it's created in reverse
   order). *)
let rec var_of_its (its : (ident * int) list) (id : ident) : var =
  match its with
  | [] -> Var id
  | hd :: tl -> Index (var_of_its tl id, Var_e (fst hd))

let gen_tmp =
  let cpt = ref 0 in
  fun (env_var : typ Ident.Hashtbl.t) (its : (ident * int) list) (typ : typ) ->
    incr cpt;
    let id = Ident.create_free ("_tmp" ^ string_of_int !cpt ^ "_") in
    let var = var_of_its its id in
    let its = List.rev its in
    let typ = typ_of_its its typ in
    Ident.Hashtbl.replace env_var id typ;
    (id, var, typ)

(* flatten_expr removes nested tuples *)
let rec flatten_expr (l : expr list) : expr list =
  match l with
  | [] -> []
  | hd :: tl ->
      (match hd with Tuple l -> flatten_expr l | _ -> [ hd ])
      @ flatten_expr tl

(* A primitive expression doesn't need to be rewritten in Tuples or fun calls *)
let rec is_primitive e =
  match e with
  (* Const _ |  *)
  | ExpVar _ (* | Shuffle _ *) -> true
  | Tuple l -> List.fold_left ( && ) true (List.map is_primitive l)
  | _ -> false

let rec expand_expr env_var (e : expr) : expr list =
  match e with
  | Const _ -> [ e ]
  | ExpVar v -> List.map (fun x -> ExpVar x) (Utils.expand_var env_var v)
  | Tuple l -> Basic_utils.flat_map (fun e -> expand_expr env_var e) l
  | Not e -> List.map (fun x -> Not x) (expand_expr env_var e)
  | Log (op, x, y) ->
      let l1 = expand_expr env_var x in
      let l2 = expand_expr env_var y in
      if List.length l1 = List.length l2 then
        List.map2 (fun x y -> Log (op, x, y)) l1 l2
      else [ Log (op, Tuple l1, Tuple l2) ]
  | Arith (op, x, y) ->
      let l1 = expand_expr env_var x in
      let l2 = expand_expr env_var y in
      if List.length l1 = List.length l2 then
        List.map2 (fun x y -> Arith (op, x, y)) l1 l2
      else [ Arith (op, Tuple l1, Tuple l2) ]
  | Shift (op, x, ae) -> (
      let x' = match expand_expr env_var x with [ x' ] -> x' | l -> Tuple l in
      try
        match Shift_tuples.shift env_var op x' (Utils.eval_arith_ne ae) with
        | Tuple l -> Basic_utils.flat_map (expand_expr env_var) l
        | x' -> [ x' ]
      with Not_found ->
        (* |ae| does not simplify to a Const *)
        [ Shift (op, x', ae) ])
  | Shuffle (v, pat) ->
      List.map (fun x -> Shuffle (x, pat)) (Utils.expand_var env_var v)
  | Bitmask _ -> [ e ] (* TODO: is that correct? *)
  | Pack _ -> [ e ] (* TODO: is that correct? *)
  | Fun (f, l) ->
      if String.equal (Ident.name f) "refresh" && List.length l <> 1 then
        Basic_utils.flat_map
          (fun v -> expand_expr env_var (Fun (f, [ v ])))
          (Basic_utils.flat_map (expand_expr env_var) l)
      else [ e ]
  | _ -> assert false

(* ************************************************************************** *)

let rec remove_generic (typ : typ) (dir : dir) (mtyp : mtyp) : typ =
  match typ with
  | Nat -> Nat
  | Uint (d, m, n) ->
      let new_m = match m with Mint _ | Mnat -> m | Mvar _ -> mtyp in
      let new_d = match d with Varslice _ -> dir | _ -> d in
      Uint (new_d, new_m, n)
  | Array (t, n) -> Array (remove_generic t dir mtyp, n)

let rec remove_call env_var env_fun (its : (ident * int) list)
    ((dir, mtyp) : dir * mtyp) (ltyp : typ list) (e : expr) : deq list * expr =
  let deq, e' = norm_expr env_var env_fun its (dir, mtyp) ltyp e in

  if is_primitive e' then (deq, e')
  else
    let expr_typ_l = get_expr_type env_fun env_var ltyp e' in
    let typ =
      if List.length expr_typ_l > 1 then
        Array (reduce_same_list expr_typ_l, Const_e (List.length expr_typ_l))
      else List.hd expr_typ_l
    in
    (* Not entirely sure why this is necessary. Remove it and run
       `./usubac -V samples/usuba/serpent.ua` and it will not work
       anymore. TODO: spend a few minutes understanding why this is
       necessary and fix. *)
    let typ = remove_generic typ dir mtyp in
    let new_id, new_var, new_typ = gen_tmp env_var its typ in
    new_vars := Utils.simple_typed_var_d new_id new_typ :: !new_vars;

    ( deq @ [ { content = Eqn ([ new_var ], e', false); orig = [] } ],
      ExpVar new_var )

and remove_calls env_var env_fun (its : (ident * int) list)
    ((dir, mtyp) : dir * mtyp) (ltyp : typ list) (l : expr list) :
    deq list * expr list =
  let pre_deqs = ref [] in
  let l' =
    List.map
      (fun e ->
        let deq, e' = norm_expr env_var env_fun its (dir, mtyp) ltyp e in
        pre_deqs := !pre_deqs @ deq;

        if is_primitive e' then [ e' ]
        else
          let expr_typ_l =
            try get_expr_type env_fun env_var ltyp e'
            with Not_found ->
              Format.eprintf "Not found: %a@." (Usuba_print.pp_expr ()) e';
              raise Not_found
          in
          let typ =
            if List.length expr_typ_l > 1 then
              Array
                (reduce_same_list expr_typ_l, Const_e (List.length expr_typ_l))
            else List.hd expr_typ_l
          in
          (* See comment un |remove_call| for the next line. *)
          let typ = remove_generic typ dir mtyp in
          let new_id, new_var, new_typ = gen_tmp env_var its typ in
          new_vars := Utils.simple_typed_var_d new_id new_typ :: !new_vars;
          pre_deqs :=
            !pre_deqs
            @ [ { content = Eqn ([ new_var ], e', false); orig = [] } ];

          [ ExpVar new_var ])
      l
  in
  (!pre_deqs, flatten_expr (List.flatten l'))

and norm_expr env_var env_fun (its : (ident * int) list)
    ((dir, mtyp) : dir * mtyp) (ltyp : typ list) (e : expr) : deq list * expr =
  match e with
  | Const _ | ExpVar _ | Shuffle _ -> ([], e)
  | Tuple l ->
      let deqs, l' = remove_calls env_var env_fun its (dir, mtyp) ltyp l in
      (deqs, Tuple l')
  | Not e -> (
      let deqs, e' = remove_call env_var env_fun its (dir, mtyp) ltyp e in
      ( deqs,
        match e' with
        | Tuple l ->
            Tuple
              (List.map
                 (fun x -> Not x)
                 (Basic_utils.flat_map (expand_expr env_var) l))
        | _ -> Tuple (List.map (fun x -> Not x) (expand_expr env_var e')) ))
  | Log (op, x1, x2) -> (
      let deqs1, x1' = remove_call env_var env_fun its (dir, mtyp) ltyp x1 in
      let deqs2, x2' = remove_call env_var env_fun its (dir, mtyp) ltyp x2 in
      ( deqs1 @ deqs2,
        match (x1', x2') with
        | Tuple l1, Tuple l2 ->
            let l1' = Basic_utils.flat_map (expand_expr env_var) l1 in
            let l2' = Basic_utils.flat_map (expand_expr env_var) l2 in
            if List.length l1' = List.length l2' then
              Tuple (List.map2 (fun x y -> Log (op, x, y)) l1' l2')
            else
              (* There should be some const in either |l1'| or |l2'| that
                 are not yet expanded. *)
              Log (op, Tuple l1', Tuple l2')
        | _ ->
            let l1 = expand_expr env_var x1' in
            let l2 = expand_expr env_var x2' in
            if List.length l1 = List.length l2 then
              Tuple (List.map2 (fun x y -> Log (op, x, y)) l1 l2)
            else
              (* There should be some const in either |l1| or |l2| that
                 are not yet expanded. *)
              Log (op, Tuple l1, Tuple l2) ))
  | Arith (op, x1, x2) -> (
      let deqs1, x1' = remove_call env_var env_fun its (dir, mtyp) ltyp x1 in
      let deqs2, x2' = remove_call env_var env_fun its (dir, mtyp) ltyp x2 in
      ( deqs1 @ deqs2,
        match (x1', x2') with
        | Tuple l1, Tuple l2 ->
            let l1' = Basic_utils.flat_map (expand_expr env_var) l1 in
            let l2' = Basic_utils.flat_map (expand_expr env_var) l2 in
            if List.length l1' = List.length l2' then
              Tuple (List.map2 (fun x y -> Arith (op, x, y)) l1' l2')
            else
              (* There should be some const in either |l1'| or |l2'| that
                 are not yet expanded. *)
              Arith (op, Tuple l1', Tuple l2')
        | _ ->
            let l1 = expand_expr env_var x1' in
            let l2 = expand_expr env_var x2' in
            if List.length l1 = List.length l2 then
              Tuple (List.map2 (fun x y -> Arith (op, x, y)) l1 l2)
            else
              (* There should be some const in either |l1| or |l2| that
                 are not yet expanded. *)
              Arith (op, Tuple l1, Tuple l2) ))
  | Shift (op, e, n) ->
      let deqs, e' = remove_call env_var env_fun its (dir, mtyp) ltyp e in
      (deqs, Shift (op, e', n))
  | Bitmask (e, i) -> (
      let deqs, e' = remove_call env_var env_fun its (dir, mtyp) ltyp e in
      ( deqs,
        match e' with
        | Tuple [ e' ] -> Bitmask (e', i)
        | Tuple _ -> assert false
        | _ -> Bitmask (e', i) ))
  | Pack (e1, e2, typ) ->
      let deqs1, e1' = remove_call env_var env_fun its (dir, mtyp) ltyp e1 in
      let deqs2, e2' = remove_call env_var env_fun its (dir, mtyp) ltyp e2 in
      ( deqs1 @ deqs2,
        let e1' =
          match e1' with
          | Tuple [ e' ] -> e'
          | Tuple _ -> assert false
          | _ -> e1'
        in
        let e2' =
          match e2' with
          | Tuple [ e' ] -> e'
          | Tuple _ -> assert false
          | _ -> e2'
        in
        Pack (e1', e2', typ) )
  | Fun (f, l) ->
      if String.equal (Ident.name f) "refresh" && List.length l > 1 then
        norm_expr env_var env_fun its (dir, mtyp) ltyp
          (Tuple (List.map (fun v -> Fun (f, [ v ])) l))
      else
        let deqs, l' = remove_calls env_var env_fun its (dir, mtyp) ltyp l in
        (deqs, Fun (f, l'))
  | _ -> assert false

let rec norm_deq env_var env_fun (its : (ident * int) list) (body : deq list) :
    deq list =
  Basic_utils.flat_map
    (fun d ->
      match d.content with
      | Eqn (lhs, e, sync) -> (
          let ltyp =
            Basic_utils.flat_map
              (fun v -> Utils.expand_typ (Utils.get_var_type env_var v))
              lhs
          in
          match List.hd ltyp with
          | Nat -> [ { d with content = Eqn (lhs, e, sync) } ]
          | t ->
              let dir = Utils.get_type_dir t in
              let m = Utils.get_type_m t in
              let expr_l, e' = norm_expr env_var env_fun its (dir, m) ltyp e in
              expr_l @ [ { d with content = Eqn (lhs, e', sync) } ])
      | Loop (x, ei, ef, dl, opts) ->
          let size =
            abs (Utils.eval_arith_ne ei - Utils.eval_arith_ne ef) + 1
          in
          [
            {
              d with
              content =
                Loop
                  ( x,
                    ei,
                    ef,
                    norm_deq env_var env_fun ((x, size) :: its) dl,
                    opts );
            };
          ])
    body

let norm_def env_fun (def : def) : def =
  match def.node with
  | Single (p_var, body) ->
      let env_var = Utils.build_env_var def.p_in def.p_out p_var in
      new_vars := [];
      let body = norm_deq env_var env_fun [] body in
      { def with node = Single (p_var @ !new_vars, body) }
  | _ -> def

let run _ prog _ : prog =
  let env_fun = Utils.build_env_fun prog.nodes in
  { nodes = List.map (norm_def env_fun) prog.nodes }

let as_pass = (run, "Unfold_unnest", 0)
