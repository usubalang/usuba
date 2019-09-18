(***************************************************************************** )
                              expand_array.ml

( *****************************************************************************)

open Usuba_AST
open Basic_utils
open Utils
open Printf

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
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error ("Not found: " ^ v.name))

(* Using a custom eval_arith to raise Need_unroll with the correct
   argument. *)
let rec eval_arith env (e:Usuba_AST.arith_expr) : int =
  match e with
  | Const_e n -> n
  | Var_e id  -> (match Hashtbl.find_opt env id with
                  | Some v -> v
                  | None -> raise (Need_unroll id))
  | Op_e(op,x,y) -> let x' = eval_arith env x in
                    let y' = eval_arith env y in
                    match op with
                    | Add -> x' + y'
                    | Mul -> x' * y'
                    | Sub -> x' - y'
                    | Div -> x' / y'
                    | Mod -> if x' >= 0 then x' mod y' else y' + (x' mod y')

let rec check_need_unroll_it (env_it:(ident,bool) Hashtbl.t) (ae:arith_expr) : unit =
  match ae with
  | Const_e _   -> ()
  | Var_e id    -> if Hashtbl.mem env_it id then raise (Need_unroll id)
  | Op_e(_,x,y) -> check_need_unroll_it env_it x;
                   check_need_unroll_it env_it y

(* Returns true iff e uses variables. *)
let rec uses_var (e:arith_expr) : bool =
  match e with
  | Const_e _ -> false
  | Var_e _ -> true
  | Op_e(_,e1,e2) -> (uses_var e1) && (uses_var e2)

(* Returns true iff v (or a 'subvar' of v is v is an Index) is in env_keep *)
let rec need_to_keep env_keep (v:var) : bool =
  match v with
  | Var id -> begin match Hashtbl.find_opt env_keep id with
                    | Some _ -> true
                    | _ -> false end
  | Index(v,_) -> need_to_keep env_keep v
  | _ -> assert false

(* Replaces Index with Var, thus removing arrays.
   remove_arr( Index(x,5) ) = Var( x'5 )
*)
let rec remove_arr (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v',Const_e i) ->
     begin
       match remove_arr v' with
       | Var id -> Var(fresh_suffix id (sprintf "%d'" i))
       | _ -> assert false
     end
  | _ -> Printf.fprintf stderr "Error: remove_arr(%s)\n" (Usuba_print.var_to_str v);
         assert false
(* Warning: this shadows (and calls) the definition above *)
let remove_arr env_keep (v:var) : var =
  if need_to_keep env_keep v then v
  else remove_arr v


let rec expand_var env_var env_keep env bitslice force (v:var) : var list =

  let rec aux (v:var) : var list =
    match v with
    | Var _ -> [ v ]
    | Index(v',i) -> List.map (fun x -> Index(x,simpl_arith env i)) (aux v')
    | Range(v',ei,ef) ->
       (* Note: can raise Need_unroll *)
       let ei = eval_arith env ei in
       let ef = eval_arith env ef in
       flat_map (fun v'' -> List.map (fun i -> Index(v'',Const_e i))
                              (gen_list_bounds ei ef)) (aux v')
    | Slice(v',el) -> flat_map (fun i -> aux (Index(v',i))) el in
  if force = Remove then
    List.map (remove_arr env_keep) (flat_map (Utils.expand_var env_var ~bitslice:bitslice) (aux v))
  else if force = Split then
    flat_map (Utils.expand_var env_var) (aux v)
  else
    aux v

let expand_vars env_var env_keep env bitslice force (vars:var list) : var list =
  flat_map (expand_var env_var env_keep env bitslice force) vars

let rec expand_expr env_var env_keep env env_it bitslice force (e:expr) : expr =
  let rec_call = expand_expr env_var env_keep env env_it bitslice force in
  match e with
  | Const _ -> e
  | ExpVar v ->
     let l = (expand_var env_var env_keep env bitslice force v) in
     Tuple (List.map (fun x ->
                match x with
                | Var id -> (match Hashtbl.find_opt env id with
                             | Some i -> Const(i,Some (get_var_type env_var (Var id)))
                             | None   -> ExpVar x)
                | _ -> ExpVar x) l)
  | Tuple el -> Tuple(List.map rec_call el)
  | Not e' -> Not (rec_call e')
  | Shift(op,e1,ae) ->
     let e1' = expand_expr env_var env_keep env env_it bitslice
                           (if force = Keep then Split else force) e1 in
     (* if e1' greater than 1, then it's a shift of a tuple *)
     if get_expr_size env_var e1' > 1 then
       (* check_need_unroll_it will raise Need_unroll if ae depends on
       an iterator (since we are performing a shift on a tuple (which
       needs to be done at compile time), but we can only do it if the
       iterator has a value -> need to unroll). *)
       check_need_unroll_it env_it ae;
     Shift(op,e1',simpl_arith env ae)
  | Log(op,e1,e2) -> Log(op,rec_call e1,rec_call e2)
  | Shuffle(v,pat) -> Tuple(List.map (fun x -> Shuffle(x,pat))
                                     (expand_var env_var env_keep env bitslice force v))
  | Arith(op,e1,e2) -> Arith(op,rec_call e1,rec_call e2)
  | Fun(f,el) ->
     if f.name = "refresh" then
       Fun(f,List.map (expand_expr env_var env_keep env env_it bitslice
                                   (if force = Remove then Remove else Split)) el)
     else Fun(f,List.map rec_call el)
  | Fun_v(f,ae,el) ->
     (* Note: can raise Need_unroll *)
     Fun(fresh_suffix f (sprintf "%d'" (eval_arith env ae)),
                          List.map rec_call el)
  | Fby _ | When _ | Merge _ -> e


let rec do_unroll env_var env_keep env bitslice force unroll x ei ef deqs : deq list =
  (* Note: can raise Need_unroll *)
  let ei = eval_arith env ei in
  let ef = eval_arith env ef in
  let eqs = flat_map (fun i -> env_update env x i;
                               expand_deqs env_var env_keep ~env:env bitslice force unroll deqs)
              (gen_list_bounds ei ef) in
  env_remove env x;
  eqs

and expand_deqs env_var env_keep ?(env=make_env ())
                ?(env_it:(ident,bool) Hashtbl.t = make_env ())
                (bitslice:bool) (force:array_fate) (unroll:bool) (deqs:deq list) : deq list =
  flat_map
    (fun deq ->
     match deq with
     | Eqn(lhs,e,sync) -> [ Eqn(expand_vars env_var env_keep env bitslice force lhs,
                                expand_expr env_var env_keep env env_it bitslice force e, sync) ]
     | Loop(x,ei,ef,deqs,opts) ->
        Hashtbl.add env_var x Nat;
        Hashtbl.add env_it x true;
        let res =
          if List.mem Unroll opts || (force = Remove) || unroll then
            do_unroll env_var env_keep env bitslice force unroll x ei ef deqs
          else
            try
              [ Loop(x,ei,ef,expand_deqs env_var env_keep ~env:env ~env_it:env_it bitslice force unroll deqs,opts) ]
            with Need_unroll id ->
              if id = x then (
                try
                  do_unroll env_var env_keep env bitslice force unroll x ei ef deqs
                with
                  Need_unroll id2 ->
                  (* Unrolling failed and needs to unroll one level
                     higher -> need to clean the environements. *)
                  Hashtbl.remove env_var x;
                  Hashtbl.remove env x;
                  raise (Need_unroll id2);
              )
              else (
                (* Gonna update one loop above; need to clean the |env_var|. *)
                Hashtbl.remove env_var x;
                (* No need to clean |env| since |x| can's be in |env| here. *)
                raise (Need_unroll id)) in
        Hashtbl.remove env_var x;
        res)
    deqs

let expand_p (bitslice:bool) (p:p) : p =
  let rec aux vd =
    match vd.vtyp with
    | Nat -> [ vd ]
    | Array(t,size) ->
       flat_map (fun i ->
                 aux { vd with vid  = fresh_suffix vd.vid (sprintf "%d'" i);
                               vtyp = t })
                (gen_list_0_int size)
    | Uint(dir,Mint m,1) when m > 1 ->
       if bitslice then
         List.map (fun i ->
                   { vd with vid  = fresh_suffix vd.vid (sprintf "%d'" i);
                             vtyp = Uint(dir,Mint 1,1) })
                  (gen_list_0_int m)
       else [ vd ]
    | Uint(_,_,1)   -> [ vd ]
    | Uint(dir,m,n) ->
       flat_map (fun i ->
                 aux { vd with vid  = fresh_suffix vd.vid (sprintf "%d'" i);
                               vtyp = Uint(dir,m,1) })
                (gen_list_0_int n) in
  flat_map aux p


(* cf env_keep description in expand_def:
   env_keep: in the main: contains the parameters (they should be expanded)
             in the other functions: is empty.*)
let build_env_keep (p_in:p) (p_out:p) =
  let env = Hashtbl.create 100 in

  let f (vd:var_d) = Hashtbl.add env vd.vid true in

  List.iter f p_in;
  List.iter f p_out;

  env

(* bitslice:
      true: convert un to bn
      false: keep un
   force:
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
let expand_def (bitslice:bool) (force:array_fate) (unroll:bool) (keep_param:bool) (def:def) : def =
  let expand_p = if force = Remove then expand_p bitslice else (fun x -> x) in
  { def with
    p_in  = if keep_param then def.p_in  else expand_p def.p_in;
    p_out = if keep_param then def.p_out else expand_p def.p_out;
    node  = match def.node with
            | Single(vars,body) ->
               (* env_var: contains the variables and their types *)
               let env_var  = build_env_var def.p_in def.p_out vars in
               (* env_keep: in the main: contains the parameters
                                                  (they should be expanded)
                                     in the other functions: is empty. *)
               let env_keep = if keep_param then build_env_keep def.p_in def.p_out
                              else Hashtbl.create 100 in
               Single(expand_p vars, expand_deqs env_var env_keep bitslice force unroll body)
            | _ -> def.node }


(* Like `map f l` but `g` is applied to the last element instead of `f`. *)
let rec map_special_last f g l =
  match l with
  | [] -> []
  | [ x ] -> [ g x ]
  | hd :: tl -> (f hd) :: (map_special_last f g tl)


let rec expand_array (prog:prog) (conf:config): prog =
  let force    = if conf.no_arr then Remove else Keep in
  let bitslice = conf.slicing_set && (conf.slicing_type = B) in
  let unroll   = conf.unroll in
  { nodes = map_special_last (expand_def bitslice force unroll false)
                             (expand_def bitslice force unroll conf.arr_entry) prog.nodes }
