open Usuba_AST
open Utils

exception Break

let update_var env (var:var) (n:int) : unit =
  env.(n) <- var :: env.(n)
       
let rec update_expr env (n:int) (e:expr) : unit =
  match e with
  | Const _ | Shuffle _ -> ()
  | ExpVar v -> update_var env v n
  | Tuple l -> List.iter (update_expr env n) l
  | Not e -> update_expr env n e
  | Shift(_,x,_) -> update_expr env n x
  | Log(_,x,y) -> update_expr env n x; update_expr env n y
  | Arith(_,x,y) -> update_expr env n x; update_expr env n y
  | Fun(_,l) -> List.iter (update_expr env n) l
  | _ -> assert false

let rec replace_expr env (e:expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> (match Hashtbl.find_opt env v with
                 | Some x -> ExpVar x
                 | None -> e)
  | Shuffle(v,l) -> Shuffle((match Hashtbl.find_opt env v with
                             | Some x -> x
                             | None -> v),l)
  | Tuple l -> Tuple(List.map (replace_expr env) l)
  | Not e -> Not(replace_expr env e)
  | Shift(op,x,y) -> Shift(op,replace_expr env x,y)
  | Log(op,x,y) -> Log(op,replace_expr env x, replace_expr env y)
  | Arith(op,x,y) -> Arith(op,replace_expr env x, replace_expr env y)
  | Fun(f,l) -> Fun(f,List.map (replace_expr env) l)
  | _ -> assert false


let get_live (deqs:deq list) =
  let last_use = Hashtbl.create 1000 in
  
  List.iter (fun d -> match d with
              | Norec(l,e) -> List.iter (fun x ->
                                         match Hashtbl.find_opt last_use x with
                                         | Some _ -> ()
                                         | None   -> Hashtbl.add last_use x d) (get_used_vars e)
              | _ -> unreached ()
            ) (List.rev deqs);

  last_use
               
                                      
let share_deqs (p_in:p) (p_out:p) (deqs:deq list) : deq list =
  let last_use = get_live deqs in
  let env      = Hashtbl.create 1000 in
  let keep     = Hashtbl.create 1000 in
  let age      = Hashtbl.create 1000 in

  List.iter (fun ((id,_),_) -> Hashtbl.add keep (Var id) true) p_out;
  List.iter (fun ((id,_),_) -> Hashtbl.add age  (Var id) (-1)) p_in;

  List.mapi (fun i d ->
             match d with
             | Norec(l,e) ->
                let e' = replace_expr env e in
                (* Find which variables can be reused *)
                let to_reuse =
                  ref (
                      (*List.filter (fun x -> let s = Usuba_print.var_to_str_types x in
                                            (* doesn't change any perf, just to be closer
                                             to Kwan's code for testing *)
                                            not ((contains s "key")
                                                 || (contains s "sbox_in"))) *) 
                      (List.sort (fun a b -> compare (Hashtbl.find age a)
                                                     (Hashtbl.find age b))
                                (List.map (fun x -> match Hashtbl.find_opt env x with
                                                    | Some y -> y
                                                    | None   -> x)
                                          (List.flatten @@
                                             List.map (fun x ->
                                                       match Hashtbl.find_opt last_use x with
                                                       | Some p when p = d -> [ x ]
                                                       | _ -> []
                                                      ) (get_used_vars e))))) in
                (* Replace new variables by reusing old ones *)
                let l' = List.map
                           (fun x ->
                            match Hashtbl.find_opt keep x with
                            | Some _ -> x (* it's an output variable *)
                            | None -> 
                               match !to_reuse with
                               | hd::tl ->
                                  to_reuse := tl;
                                  Hashtbl.replace env x hd;
                                  Hashtbl.replace last_use hd
                                                  (Hashtbl.find last_use x); 
                                  hd
                               | [] -> x) l in
                List.iter (fun x -> match Hashtbl.find_opt age x with
                                    | None -> Hashtbl.add age x i
                                    | Some _ -> ()) l';
                Norec(l',e')
             | _ -> unreached ()) deqs
            
           
           
      
let share_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     let body = share_deqs def.p_in def.p_out body in
     { def with node = Single(vars,body) }
  | _ -> def

let rec apply_last l f =
  match l with
  | x::[] -> [ f x ]
  | hd::tl -> hd :: (apply_last tl f)
  | [] -> []
           
let share_prog (prog:prog) : prog =
  (* { nodes = List.map share_def prog.nodes } *)
  { nodes = apply_last prog.nodes share_def }
    (* prog *)
