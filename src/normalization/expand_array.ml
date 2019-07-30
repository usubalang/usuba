(***************************************************************************** )
                              expand_array.ml                                 

( *****************************************************************************)

open Usuba_AST
open Basic_utils
open Utils
open Printf

(* Precision on the "force" parameter that we keep around in most functions:
  It has 3 values possible:
    0: keep array
    1: remove arrays
    2: split arrays: arrays are kept around, but only as Index, not as Var.
  This was needed for rotations/shifts.
  More explanations in this commit: 24cf4b83aed7388c31f71c1b30ac8ba7a74bdc7c.
*)

(* To notify calling function that unrolling is necessary *)
exception Need_unroll
            
(* Abstracting Hashtbl.
   This functions should replace the ones in Utils, one day. *)
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error ("Not found: " ^ v.name))


(* If the program contains permutations, then arrays must be unrolled
 This is a bit of a simplification: 
  - The permutation could be at some point where it doesn't impact unrolling
  - Dummy assigments are a sign that indicates that arrays should be unrolled as well
 *)
let must_expand (prog:prog) =
  List.exists (fun x -> match x.node with Perm _ -> true | _ -> false) prog.nodes

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
       (try
           let ei = eval_arith env ei in
           let ef = eval_arith env ef in
           flat_map (fun v'' -> List.map (fun i -> Index(v'',Const_e i))
                                  (gen_list_bounds ei ef)) (aux v')
           (* flat_map (fun i -> aux (Index(v',Const_e i)))
            *          (gen_list_bounds ei ef) *)
                    (* Not_found can be raised by the calls to eval_arith *)
         with Not_found -> raise Need_unroll)
    | Slice(v',el) -> flat_map (fun i -> aux (Index(v',i))) el in
  if force = 1 then
    List.map (remove_arr env_keep) (flat_map (Utils.expand_var env_var ~bitslice:bitslice) (aux v))
  else if force = 2 then
    flat_map (Utils.expand_var env_var) (aux v)
  else
    aux v
                             
let expand_vars env_var env_keep env bitslice force (vars:var list) : var list =
  flat_map (expand_var env_var env_keep env bitslice force) vars
           
let rec expand_expr env_var env_keep env bitslice force (e:expr) : expr =
  let rec_call = expand_expr env_var env_keep env bitslice force in
  match e with
  | Const _ -> e
  | ExpVar v -> let l = (expand_var env_var env_keep env bitslice force v) in
                Tuple (List.map (fun x ->
                                 match x with
                                 | Var id -> (match Hashtbl.find_opt env id with
                                              | Some i -> Const i
                                              | None   -> ExpVar x)
                                 | _ -> ExpVar x) l)
  | Tuple el -> Tuple(List.map rec_call el)
  | Not e' -> Not (rec_call e')
  | Shift(op,e1,ae) -> Shift(op,expand_expr env_var env_keep env bitslice
                                            (if force = 0 then 2 else force) e1,ae)
  | Log(op,e1,e2) -> Log(op,rec_call e1,rec_call e2)
  | Shuffle(v,pat) -> Tuple(List.map (fun x -> Shuffle(x,pat))
                                     (expand_var env_var env_keep env bitslice force v))
  | Arith(op,e1,e2) -> Arith(op,rec_call e1,rec_call e2)
  | Fun(f,el) -> Fun(f,List.map rec_call el)
  | Fun_v(f,ae,el) -> (try Fun(fresh_suffix f (sprintf "%d'" (eval_arith env ae)),
                               List.map rec_call el)
                       with Not_found -> raise Need_unroll)
  | Fby _ | When _ | Merge _ -> e


let rec do_unroll env_var env_keep env bitslice force unroll x ei ef deqs : deq list =
  try
    let ei = eval_arith env ei in
    let ef = eval_arith env ef in
    let eqs = flat_map (fun i -> env_update env x i;
                                 expand_deqs env_var env_keep ~env:env bitslice force unroll deqs)
                       (gen_list_bounds ei ef) in
    env_remove env x;
    eqs
  with Not_found -> raise Need_unroll

and expand_deqs env_var env_keep ?(env=make_env ())
                (bitslice:bool) (force:int) (unroll:bool) (deqs:deq list) : deq list =
  flat_map
    (fun deq ->
     match deq with
     | Eqn(lhs,e,sync) -> [ Eqn(expand_vars env_var env_keep env bitslice force lhs,
                                expand_expr env_var env_keep env bitslice force e, sync) ]
     | Loop(x,ei,ef,deqs,opts) ->
        Hashtbl.add env_var x Nat;
        let res =
          if List.mem Unroll opts || (force = 1) || unroll then
            do_unroll env_var env_keep env bitslice force unroll x ei ef deqs
          else
            try
              [ Loop(x,ei,ef,expand_deqs env_var env_keep ~env:env bitslice force unroll deqs,opts) ]
            with Need_unroll -> do_unroll env_var env_keep env bitslice force unroll x ei ef deqs in
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
      0: keep array
      1: remove arrays
      2: split arrays: arrays are kept around, but only as Index, not as Var.
   unroll:
      true: unroll all loops
      false: keep loops that are not annotated "_unroll" and that can be kept
   keep_param:
      true: keep arrays in parameters
      false: expand arrays from parameters IFF force == 1
 *)
let expand_def (bitslice:bool) (force:int) (unroll:bool) (keep_param:bool) (def:def) : def =
  let expand_p = if force = 1 then expand_p bitslice else (fun x -> x) in
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
  let force    = if conf.no_arr (* || must_expand prog  *)then 1 else 0 in
  let bitslice = conf.slicing_set && (conf.slicing_type = B) in
  let unroll   = conf.unroll in
  { nodes = map_special_last (expand_def bitslice force unroll false)
                             (expand_def bitslice force unroll conf.arr_entry) prog.nodes }

