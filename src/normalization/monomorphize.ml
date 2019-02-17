open Usuba_AST
open Basic_utils
open Utils

module Monomorphize = struct
  
  module Hslice = struct
    
    let rotate_l l x =
      let rec aux x l1 l2 =
        match x with
        | 0 -> l1 @ (List.rev l2)
        | n -> aux (n-1) (List.tl l1) ((List.hd l1) :: l2) in
      aux x l []

    let rotate_r l x =
      List.rev (rotate_l (List.rev l) x)

    let lshift_l l x =
      let rec aux x acc l =
        match l with
        | [] -> acc
        | hd::tl -> match x with
                    | 0 -> aux 0 (hd::acc) tl
                    | n -> aux (n-1) ((-1)::acc) tl in
      aux x [] l

    let rshift_l l x =
      List.rev (lshift_l (List.rev l) x)
               
  end
                    
  let hslice_expr env_var (ltyp:typ list) (e:expr) =
    match e with
    | Shift(op,ExpVar v,ae) ->
       (* ltyp _has_ to be only one element here *)
       let m = match List.hd ltyp with
         | Uint(_,Mint m,_) -> m
         | _ -> assert false in
       let l = gen_list_0_int m in
       (match op with
        | Lrotate -> Shuffle(v, Hslice.rotate_l l (eval_arith_ne ae))
        | Rrotate -> Shuffle(v, Hslice.rotate_r l (eval_arith_ne ae))
        | Lshift  -> Shuffle(v, Hslice.shift_l  l (eval_arith_ne ae))
        | Rshift  -> Shuffle(v, Hslice.shift_l  l (eval_arith_ne ae)))
    | _ -> e
             

  let rec specialize_typ (env_dir:(dir,dir) Hashtbl.t) (t:typ) : typ =
    match t with
    | Nat -> t
    | Array(t', n)  -> Array(specialize_typ env_dir t', n)
    | Uint(d, m, n) -> match Hashtbl.find_opt env_dir d with
                       | Some d' -> Uint(d', m, n)
                       | None    -> Uint(d, m, n)

  let monomorphize_p (env_dir:(dir,dir) Hashtbl.t) (p:p) : p =
    List.map (fun v -> { v with vtyp = specialize_typ env_dir v.vtyp }) p

  let monomorphize_expr (env_var:(ident, typ) Hashtbl.t) (ltyp:typ list) (e:expr) : expr =
    let dir = match get_base_type (List.hd ltyp) with
      | Uint(d,_,_) -> d
      | _ -> assert false in
    e
      match dir with
      | Hslice -> hslice_expr env_var e
      | Vslice -> e (* Nothing to do for now with vslicing *)
      | Bslice -> bslice_expr env_var e
      | _ -> assert false

                    
  let rec monomorphize_deqs (env_var:(ident, typ) Hashtbl.t) (deqs:deq list) : deq list =
    List.map (fun x ->
              match x with
              | Eqn(vs,e,sync) ->
                 let ltyp = List.map (get_var_type env_var) vs in
                 Eqn(vs,monomorphize_expr env_var ltyp e, sync)
              | Loop(e,ei,ef,l,opts) -> Loop(e,ei,ef,monomorphize_deqs env_var l,opts))
             deqs
             
end

module Specialize_types = struct

  let gen_fun_name (f:ident) (l:dir list) : ident =
    fresh_ident
      (f.name ^ (join "_" (List.map (function
                                      | Hslice -> "H"
                                      | Vslice -> "V"
                                      | Bslice -> "B"
                                      | _ -> assert false) l)))

  let match_types dir_env (p:p) (typs:typ list) : p =
    List.map2 (fun vd t -> let dir = get_type_dir t in
                           let old_dir = get_type_dir vd.vtyp in
                           let vtyp = update_typ_dir vd.vtyp dir in
                           Hashtbl.update dir_env old_dir dir;
                           { vd with vtyp = vtyp }
                           ) p typs
      
  let rec specialize_fun_call (all_nodes:(ident,def) Hashtbl.t)
                              (specialized_nodes:(ident*(typ list),def) Hashtbl.t)
                              (env_var:(ident, typ) Hashtbl.t)
                              (f:ident) (vs:var list) (l:expr list) : ident =
    let dir_env = Hashtbl.create 10 in
    
    let typs_out = List.map (get_var_type env_var) vs in
    let typs_in  = flat_map (get_expr_type (Hashtbl.create 1) env_var) l in

    let def   = Hashtbl.find all_nodes f in
    let p_in  = match_types dir_env node.p_in  typs_in  in
    let p_out = match_types dir_env node.p_out typs_out in

    let def =
      { def with
        p_in  = p_in;
        p_out = p_out;
        node  =
          match def.node with
          | Single(vars,body) ->
             Single(List.map
                      (fun vd ->
                       let old_dir = get_type_dir vd.vtyp in
                       let new_dir = Hashtbl.find dir_env old_dir in
                       { vd with vtyp = update_typ_dir vd.vtyp new_dir }) vars,
                    body)
          | _ -> def.node } in
    f
        
                          
      
  let rec specialize_deqs (all_nodes:(ident,def) Hashtbl.t)
                          (specialized_nodes:(ident*(typ list),def) Hashtbl.t)
                          (env_var:(ident, typ) Hashtbl.t) (deqs:deq list) : deq list =
    List.map (fun x ->
              match x with
              | Eqn(vs,Fun(f,l),sync) ->
                 let f' = specialize_fun_call all_nodes specialized_nodes
                                              env_var f vs l in
                 Eqn(vs,Fun(f',l),sync)
              | Eqn _ -> x
              | Loop(e,ei,ef,l,opts) -> Loop(e,ei,ef,monomorphize_deqs env_var l,opts))
             deqs
             
  let rec specialize_node (all_nodes:(ident,def) Hashtbl.t)
                          (specialized_nodes:(typ list,def) Hashtbl.t)
                          (env_dir:(dir,dir) Hashtbl.t)
                          (p_in:p) (p_out:p) (vars:p) (body:deq list): def_i =
    let vars = specialize_p env_dir vars in
    let env_var = build_env_var p_in p_out vars in

    let body = specialize_deqs all_nodes specialized_nodes env_var body in

    Single(vars, body)

  (* NOTE: shadowing the definition above *)
  let specialize_node (all_nodes:(ident,def) Hashtbl.t)
                      (specialized_nodes:(typ list,def) Hashtbl.t)
                      (env_dir:(dir,dir) Hashtbl.t)
                      (def:def) (p_in:p) (p_out:p) : ident =
    let ltyp = List.rev (Hashtbl.fold (fun _ t acc -> t :: acc) [] env_dir) in
    let f = gen_fun_name def.id ltyp in
    Hashtbl.add specialized_nodes f
                { def with
                  id    = f;
                  p_in  = p_in;
                  p_out = p_out;
                  node  =
                    match def.node with
                    | Single(vars,body) -> specialize_node all_nodes specialized_nodes
                                                           env_dir p_in p_out vars body
                    | _ -> def.node };
    f
      

  (* Main monomorphization is a bit special: the specialization of the parameters
   depends on the compilation flags rather than how it's called (since there is
   no way to know how it will be called... *)
  let specialize_main (all_nodes:(ident,def) Hashtbl.t)
                      (specialized_nodes:(typ list,def) Hashtbl.t)
                      (env_dir:(dir,dir) Hashtbl.t) (def:def) (conf:config) : def =

    let p_in  = specialize_p env_dir def.p_in  in
    let p_out = specialize_p env_dir def.p_out in

    specialize_node all_nodes specialized_nodes env_dir def p_in p_out
                    
                    
  let specialize_types (prog:prog) (conf:config) : prog =
    (* Getting the default dir (command line parameter) *)
    let spec_dir = match conf.slicing_set with
      | false -> Vslice (* not used *)
      | true  -> match conf.slicing_type with
                 | V -> Vslice
                 | H -> Hslice
                 | B -> Bslice in
    let env_dir = Hashtbl.create 10 in
    Hashtbl.add env_dir default_dir spec_dir;

    (* Environment of all (non-monomorphized) nodes *)
    let all_nodes = Hashtbl.create 10 in
    List.iter (fun f -> Hashtbl.add all_nodes f true) prog.nodes;

    (* Environment of monomorphized nodes *)
    let specialized_nodes = Hashtbl.create 100 in

    let main = specialize_main all_nodes specialize_nodes env_dir (last prog.nodes) conf in
    Printf.printf "%s" (Usuba_print.def_to_str main);
    exit 1;
    
    prog

end

let monomorphize (prog:prog) (conf:config) : prog =
  (* Getting the default dir (command line parameter) *)
