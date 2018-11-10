open Usuba_AST
open Basic_utils
open Utils
open Usuba_print

let error = ref false


let build_env_fun (prog:prog) : (ident,def) Hashtbl.t =
  let env = Hashtbl.create 100 in
  List.iter (fun def ->
             match Hashtbl.mem env def.id with
             | false -> Hashtbl.add env def.id def
             | true  -> Printf.fprintf stderr "[Type error] Redefinition of function `%s'\n"
                                       def.id.name;
                        error := true) prog.nodes;
  env
    
let build_env_var (name:string) (p_in:p) (p_out:p) (vars:p) : (ident, typ) Hashtbl.t =
  let env = Hashtbl.create 100 in

  let add_to_env ((id,typ),_) =
    match Hashtbl.mem env id with
    | true -> Printf.fprintf stderr "[Type error] Node `%s': redeclaration of variable `%s'.\n"
                             name id.name;
              error := true
    | false -> Hashtbl.add env id typ in
  
  List.iter add_to_env p_in;
  List.iter add_to_env p_out;
  List.iter add_to_env vars;

  env

let rec type_eq (t1:typ) (t2:typ) : bool =
  match t1,t2 with
  | Bool, Bool     -> true
  | Bool, Int(1,1) -> true
  | Int(1,1), Bool -> true
  | Int(n1,m1), Int(n2,m2) -> n1 = n2 && m1 = m2
  | _ -> assert false

let rec typ_aexpr (name:string) (env_it:(ident,bool) Hashtbl.t) (ae:arith_expr) : bool =
  assert false
  (* match ae with *)
  (* | Const_e _ -> true *)
  (* | Var_e x -> (match Hashtbl.find_opt env_it x with *)
  (*              | Some _ -> true *)
  (*              | None   -> Printf.fprintf stderr "[Type error] Node `%s'" name *)
                
let rec get_type_expr (name:string) (env_fun:(ident,def) Hashtbl.t)
                      (env_var:(ident,typ) Hashtbl.t)
                      (env_it:(ident,bool) Hashtbl.t)
                      (e:expr) : typ list =
  assert false
  (* let rec_call = get_type_expr name env_fun env_var env_it in *)
  (* match e with *)
  (* | Const _  -> assert false *)
  (* | ExpVar v -> expand_var env_var v *)
  (* | Tuple l  -> flat_map rec_call l *)
  (* | Not e    -> rec_call e *)
  (* | Shift(op,e,ae) -> assert false *)
              
    
let type_asgn (name:string) (env_fun:(ident,def) Hashtbl.t)
              (env_var:(ident,typ) Hashtbl.t)
              (env_it:(ident,bool) Hashtbl.t)
              (vs:var list) (e:expr) : bool =
  let lhs_types = List.map (get_var_type env_var)
                           (flat_map (expand_var env_var) vs) in
  let rhs_types = get_type_expr name env_fun env_var env_it e in
  if List.length lhs_types <> List.length rhs_types then
    begin
      Printf.fprintf stderr
        "[Type error] Node `%s', equation `%s'.\n  Types reduces to (%s) = (%s).\n  Left-hand side and right-hand side have different sizes.\n"
        name (Usuba_print.deq_to_str (Eqn(vs,e)))
        (typ_to_str_l lhs_types) (typ_to_str_l rhs_types);
      error := true;
      false
    end
  else                   
  List.for_all2
    (fun x y ->
     if type_eq x y then true
     else begin
         Printf.fprintf stderr
           "[Type error] Node `%s', equation `%s'.\n  Types reduces to (%s) = (%s).\n"
           name (Usuba_print.deq_to_str (Eqn(vs,e)))
           (typ_to_str_l lhs_types) (typ_to_str_l rhs_types);
         error := true;
         false end) lhs_types rhs_types
    
      
       
let rec type_deqs (name:string) (env_fun:(ident,def) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t)
                  (env_it:(ident,bool) Hashtbl.t)
                  (body:deq list) : bool =
  List.for_all (fun deq -> match deq with
                           | Eqn(vs,e) -> type_asgn name env_fun env_var env_it vs e
                           | Loop(x,ei,ef,dl,_) ->
                              Hashtbl.add env_it x true;
                              let b = type_deqs name env_fun env_var env_it dl in
                              Hashtbl.remove env_it x;
                              b
               ) body


let type_perm (name:string) (p_in:p) (p_out:p) (l:int list) : bool =
  let in_size  = p_size p_in  in
  let out_size = p_size p_out in
  if List.length l <> out_size then
    begin
      Printf.fprintf stderr "[Type error] Perm `%s': wrong number of elements. Expected %d, got %d.\n"
                     name out_size (List.length l);
      error := true
    end;
  List.for_all (fun i ->
                match i <= in_size with
                | true  -> if i <> 0 then true
                           else begin
                               Printf.fprintf stderr "[Type error] Perm `%s': invalid element `0'.\n" name;
                               error := true;
                               false end                           
                | false -> Printf.fprintf stderr
                                         "[Type error] Perm `%s': invalid element `%d' (only %d inputs).\n"
                                         name i in_size;
                           error := true;
                           false) l
           
                                                          
let type_table (name:string) (p_in:p) (p_out:p) (l:int list) : bool =
  let in_size  = p_size p_in  in
  let out_size = p_size p_out in
  if List.length l > pow 2 in_size then
    begin
      Printf.fprintf stderr "[Type error] Perm `%s': too many elements. Expected %d (or less), got %d.\n"
                     name (pow 2 in_size) (List.length l);
      error := true
    end;
  List.for_all (fun i ->
                match i < pow 2 out_size with
                | true  -> true
                | false -> Printf.fprintf stderr
                                          "[Type error] Table `%s': invalid element `%d' higher than 2**#inputs = 2**%d = %d.\n"
                                          name i in_size (pow 2 out_size);
                           error := true;
                           false) l
                                                                   

let rec type_defi (name:string) (env_fun:(ident,def) Hashtbl.t)
                  (p_in:p) (p_out:p) (defi:def_i) : bool =
  match defi with
  | Single(vars,body) ->
     let env_var = build_env_var name p_in p_out vars in
     let env_it  = Hashtbl.create 10 in
     type_deqs name env_fun env_var env_it body
  | Perm l     -> type_perm  name p_in p_out l
  | Table l    -> type_table name p_in p_out l
  | Multiple l -> List.for_all (type_defi name env_fun p_in p_out) l

let type_def (env_fun:(ident,def) Hashtbl.t) (def:def) : bool =
  type_defi def.id.name env_fun def.p_in def.p_out def.node

                                                  
            
let type_prog (prog:prog) : bool =
  (* Environment containing the nodes *)
  let env_fun = build_env_fun prog in
  let r = List.for_all (type_def env_fun) prog.nodes in
  r && not !error

let is_typed = type_prog
