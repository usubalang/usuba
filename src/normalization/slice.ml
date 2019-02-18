open Basic_utils
open Utils
open Usuba_AST


(* module Slice_H = struct *)

(*   let rotate_l l x = *)
(*     let rec aux x l1 l2 = *)
(*       match x with *)
(*       | 0 -> l1 @ (List.rev l2) *)
(*       | n -> aux (n-1) (List.tl l1) ((List.hd l1) :: l2) in *)
(*     aux x l [] *)

(*   let rotate_r l x = *)
(*     List.rev (rotate_l (List.rev l) x) *)
        
(*   let slice_shift env_var (op:shift_op) (e:expr) (ae:arith_expr) : expr = *)
(*     match e with *)
(*     | ExpVar v -> *)
(*        let typ = get_var_type env_var v in *)
(*        (match typ with *)
(*         | Int(n,_) -> let l = gen_list_0_int n in *)
(*                       (match op with *)
(*                        | Lrotate -> let x = Shuffle(v,rotate_l l (eval_arith_ne ae)) in *)
(*                                     print_endline (Usuba_print.expr_to_str x); *)
(*                                     x *)
(*                        | Rrotate -> Shuffle(v,rotate_r l (eval_arith_ne ae)) *)
(*                        | _ -> Shift(op,e,ae)) *)
(*         | _ -> assert false) *)
(*     | _ -> assert false *)
                      
  
(*   let rec slice_expr env_var (e:expr) : expr = *)
(*     match e with *)
(*     | Const _ | ExpVar _ | Shuffle _-> e *)
(*     | Tuple l         -> Tuple (List.map (slice_expr env_var) l) *)
(*     | Not e           -> Not (slice_expr env_var e) *)
(*     | Shift(op,e,ae)  -> slice_shift env_var op e ae *)
(*     | Log(op,e1,e2)   -> Log(op,slice_expr env_var e1,slice_expr env_var e2) *)
(*     | Arith(op,e1,e2) -> Arith(op,slice_expr env_var e1,slice_expr env_var e2) *)
(*     | Fun(f,l)        -> Fun(f,List.map (slice_expr env_var) l) *)
(*     | _               -> assert false *)
                                

(*   let rec slice_deqs env_var (deqs:deq list) : deq list = *)
(*     List.map (fun deq -> *)
(*               match deq with *)
(*               | Eqn(lhs,e,sync)       -> Eqn(lhs,slice_expr env_var e,sync) *)
(*               | Loop(i,ei,ef,dl,opts) -> Loop(i,ei,ef,slice_deqs env_var dl,opts)) deqs *)

(*   let slice_def (def) : def = *)
(*     match def.node with *)
(*     | Single(vars,body) -> *)
(*        let env_var = build_env_var def.p_in def.p_out vars in *)
(*        { def with node = Single(vars,slice_deqs env_var body) } *)
(*     | _ -> def *)
  
(*   let slice (prog:prog) : prog = *)
(*     { nodes = List.map slice_def prog.nodes } *)
(* end *)

(* module Slice_B = struct *)

(*   let rec get_base_type (typ:typ) : typ = *)
(*     match typ with *)
(*     | Bool -> Bool *)
(*     | Int _ -> typ *)
(*     | Array(t,_) -> get_base_type t *)
(*     | _ -> assert false *)
                  

(*   let rec build_type (n:int) (m:int) (typ:typ) : typ * bool = *)
(*     let typ_size = n + m in *)
(*     match typ with *)
(*     | Bool        -> Bool, typ_size = 1 *)
(*     | Int(i,j)    -> Int(1,i*j), i <> n || j <> m *)
(*     | Array(t,ae) -> let (t',b) = build_type n m t in *)
(*                      Array(t',ae), b *)
(*     | _ -> typ, false *)
(*   let build_vars (n:int) (m:int) (l:p) = *)
(*     let missmatch = ref false in *)
(*     let l' = List.map (fun vd -> let typ, b = build_type n m vd.vtyp in *)
(*                                  missmatch := !missmatch || b; *)
(*                                  { vd with vtyp = typ } *)
(*                       ) l in *)
(*     l', !missmatch *)


(*   let missmatch_slice_deqs (n:int) (m:int) *)
(*                            (old_vars: (ident,typ) Hashtbl.t) *)
(*                            (new_vars: (ident,typ) Hashtbl.t) *)
(*                            (deqs:deq list) : deq list = *)
(*     deqs *)

(*   let rec gen_slice (size:int) (start:arith_expr) (step:int) : arith_expr list = *)
(*     let rec aux size curr acc = *)
(*       match size with *)
(*       | 0 -> List.rev acc *)
(*       | _ -> aux (size-1) (curr+step) ((Op_e(Add,start,Const_e curr)) :: acc) in *)
(*     aux size 0 [] *)
    
         
(*   let lift_table (n:int) (m:int) (def:def) (l:int list) : def list = *)
(*     let in_size = match (List.hd def.p_in).vtyp with *)
(*       | Int(t_in,t_out) -> t_in * t_out *)
(*       | _ -> assert false in *)
(*     let p_in  = { (List.hd def.p_in)  with vtyp = Int(1,n*m) } in *)
(*     let p_out = { (List.hd def.p_out) with vtyp = Int(1,n*m) } in *)
(*     let slice = gen_slice in_size (Var_e (fresh_ident "i")) (n * m / in_size) in *)
(*     let new_id = fresh_ident (def.id.name ^ "single") in *)
(*     let body = [ *)
(*       Loop(fresh_ident "i",Const_e 0,Const_e (n * m / in_size - 1), *)
(*            [ *)
(*              Eqn([Slice(Var p_out.vid,slice)], *)
(*                  Fun(new_id,[ExpVar(Slice(Var p_in.vid,slice))]), *)
(*                  false) *)
(*            ], *)
(*            []) *)
(*     ] in *)
(*     let table = { def with id = new_id } in *)
(*     let new_node = { id    = def.id; *)
(*                      p_in  = List.map (fun vd -> { vd with vtyp = Int(1,n*m)}) def.p_in; *)
(*                      p_out = List.map (fun vd -> { vd with vtyp = Int(1,n*m)}) def.p_out; *)
(*                      opt   = []; *)
(*                      node  = Single([], body) } in *)
(*     [ table; new_node ] *)

(*   let missmatch_slice_def (n:int) (m:int) (def:def) : def list = *)
(*     match def.node with *)
(*     | Table t           -> lift_table n m def t *)
(*     | Single(vars,body) -> [ def ] *)
(*        (\* let vars',_  = build_vars n m vars in *\) *)
(*        (\* let old_vars = build_env_var def.p_in def.p_out vars in *\) *)
(*        (\* let new_vars = build_env_var def.p_out p_out vars' in *\) *)
(*        (\* [ { def with p_in  = p_in; *\) *)
(*        (\*              p_out = p_out; *\) *)
(*        (\*              node  = Single(vars', missmatch_slice_deqs n m old_vars *\) *)
(*        (\*                                                         new_vars body) } ] *\) *)
(*   (\* | _ -> [ { def with p_in = p_in; p_out = p_out } ] *\) *)
(*     | _ -> assert false *)

(*   let rec match_slice_var (n:int) (m:int) *)
(*                       (old_vars: (ident,typ) Hashtbl.t) *)
(*                       (new_vars: (ident,typ) Hashtbl.t) *)
(*                       (v:var) : var = *)
(*     match Hashtbl.find old_vars (get_base_name v) with *)
(*     | Int _ -> *)
(*        (match v with *)
(*         | Var _        -> v *)
(*         | Index(v',ae) -> Range(v', Op_e(Mul,ae,Const_e n), *)
(*                                 Op_e(Add,Op_e(Mul,ae,Const_e n),Const_e (n-1))) *)
(*         | Range(v',ae1,ae2) -> Range(v', Op_e(Mul,ae1,Const_e n), *)
(*                                      Op_e(Mul,ae2,Const_e n)) *)
(*         | Slice(v',l)  -> Slice(v',List.map (fun ae -> Op_e(Mul,ae,Const_e n)) l)) *)
(*     | _ -> v *)

(*   let rec match_slice_expr (n:int) (m:int) *)
(*                        (old_vars: (ident,typ) Hashtbl.t) *)
(*                        (new_vars: (ident,typ) Hashtbl.t) *)
(*                        (e:expr) : expr = *)
(*     let rec_call = match_slice_expr n m old_vars new_vars in *)
(*     match e with *)
(*     | Const _         -> e *)
(*     | ExpVar v        -> ExpVar (match_slice_var n m old_vars new_vars v) *)
(*     | Tuple l         -> Tuple (List.map rec_call l) *)
(*     | Not e           -> Not (rec_call e) *)
(*     | Shift(op,e1,e2) -> Shift(op,rec_call e1,e2) *)
(*     | Log(op,e1,e2)   -> Log(op,rec_call e1,rec_call e2) *)
(*     | Shuffle(v,l)    -> Shuffle(match_slice_var n m old_vars new_vars v,l) *)
(*     | Arith(op,e1,e2) -> Arith(op,rec_call e1,rec_call e2) *)
(*     | Fun(f,l)        -> Fun(f,List.map rec_call l) *)
(*     | _               -> assert false *)

(*   let rec match_slice_deqs (n:int) (m:int) *)
(*                        (old_vars: (ident,typ) Hashtbl.t) *)
(*                        (new_vars: (ident,typ) Hashtbl.t) *)
(*                        (deqs:deq list) : deq list = *)
(*     List.map (fun deq -> *)
(*               match deq with *)
(*               | Eqn(lhs,e,sync) -> *)
(*                  Eqn(List.map (match_slice_var n m old_vars new_vars) lhs, *)
(*                      match_slice_expr n m old_vars new_vars e, *)
(*                      sync) *)
(*               | Loop(i,ei,ef,dl,opts) -> *)
(*                  Loop(i,ei,ef,match_slice_deqs n m old_vars new_vars dl,opts) *)
(*              ) deqs *)
             
(*   let match_slice_def (n:int) (m:int) (p_in:p) (p_out:p) (def:def) : def = *)
(*     match def.node with *)
(*     | Single(vars,body) -> *)
(*        let vars',_  = build_vars n m vars in *)
(*        let old_vars = build_env_var def.p_in def.p_out vars in *)
(*        let new_vars = build_env_var p_in p_out vars' in *)
(*        { def with p_in  = p_in; *)
(*                   p_out = p_out; *)
(*                   node  = Single(vars', match_slice_deqs n m old_vars new_vars body) } *)
(*     | _ -> { def with p_in = p_in; p_out = p_out } *)
          
(*   let slice_def (n:int) (m:int) (def:def) : def list = *)
(*     let p_in, b1  = build_vars n m def.p_in in *)
(*     let p_out, b2 = build_vars n m def.p_out in *)
(*     if b1 || b2 then missmatch_slice_def n m def  *)
(*     else [ match_slice_def n m p_in p_out def ] *)

(*   let get_generic_type (prog:prog) : int * int = *)
(*     match get_base_type (List.hd ((last prog.nodes).p_in)).vtyp with *)
(*     | Int(n,m) -> n,m *)
(*     | _ -> assert false *)
  
(*   let slice (prog:prog) : prog = *)
(*     let (n,m) = get_generic_type prog in *)
(*     { nodes = flat_map (slice_def n m) prog.nodes } *)
      
(* end *)

module Resolve_types = struct

  let resolve_types (prog:prog) (conf:config) : prog =
    match conf.slicing_set with
    | false -> prog
    | true  -> let slicing = match conf.slicing with
                 | H -> Hslice
                 | V -> Vslice
                 | B -> Bslice in
              
end

       
let slice (prog:prog) (conf:config) : prog =
  prog
  (* match conf.slicing_set with *)
  (* | false -> prog *)
  (* | true  -> match conf.slicing_type with *)
  (*            | V -> prog *)
  (*            | H -> Slice_H.slice prog *)
  (*            | B -> Slice_B.slice prog *)
