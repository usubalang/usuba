open Usuba_AST
open Utils

exception Break

let update_var env (var:var) (n:int) : unit =
  env.(n) <- var :: env.(n)
       
let rec update_expr env (n:int) (e:expr) : unit =
  match e with
  | Const _ -> ()
  | ExpVar v -> update_var env v n
  | Tuple l -> List.iter (update_expr env n) l
  | Not e -> update_expr env n e
  | Shift(_,x,_) -> update_expr env n x
  | Log(_,x,y) -> update_expr env n x; update_expr env n y
  | Arith(_,x,y) -> update_expr env n x; update_expr env n y
  | Intr(_,x,y) -> update_expr env n x; update_expr env n y
  | Fun(_,l) -> List.iter (update_expr env n) l
  | _ -> raise (Invalid_AST "")

let rec replace_expr env (e:expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> (match env_fetch env v with
                 | Some x -> ExpVar x
                 | None -> e)
  | Tuple l -> Tuple(List.map (replace_expr env) l)
  | Not e -> Not(replace_expr env e)
  | Shift(op,x,y) -> Shift(op,replace_expr env x,y)
  | Log(op,x,y) -> Log(op,replace_expr env x, replace_expr env y)
  | Arith(op,x,y) -> Arith(op,replace_expr env x, replace_expr env y)
  | Intr(op,x,y) -> Intr(op,replace_expr env x, replace_expr env y)
  | Fun(f,l) -> Fun(f,List.map (replace_expr env) l)
  | _ -> raise (Invalid_AST "")
               
let share_deqs (p_in:p) (p_out:p) (deqs:deq list) : p * deq list =
  let env = Array.make (List.length deqs) [] in
  let dont_use = Hashtbl.create 100 in
  List.iter (fun (id,_,_) -> env_add dont_use id 1) p_in;
  List.iter (fun (id,_,_) -> env_add dont_use id 1) p_out;
  List.iteri
    (fun n x -> match x with
                | Norec([Var v],e) ->
                   ( match env_fetch dont_use v with
                     | Some _ -> ()
                     | None -> update_expr env n e)
                | _ -> raise (Invalid_AST "")) deqs;
  let corres = Hashtbl.create 1000 in
  let vars = ref [] in
  let body =
    List.mapi
      (fun i x ->
       match x with
       | Norec([Var v],e) ->
          let new_v = ref (Var v) in
          (try
              for n = 1 to i do
                match env.(i) with
                | hd::tl -> new_v := hd;
                            env.(i) <- tl;
                            raise Break
                | [] -> ()
              done;
            with Break -> ());
          let e' = replace_expr corres e in
          env_add corres (Var v) !new_v;
          (match !new_v with
           | Var v -> vars := (v,Bool,"") :: !vars
           | _ -> unreached ());
          Norec([!new_v],e')
       | _ -> raise (Invalid_AST "")) deqs in
  let vars =
    List.flatten @@
      List.map (fun (id,typ,ck) -> match env_fetch dont_use id with
                                   | Some _ -> []
                                   | None -> [id,typ,ck]) !vars in
  vars,body
      
      
let share_def (def:def) : def =
  match def with
  | Single(id,p_in,p_out,vars,body) ->
     let (vars,body) = share_deqs p_in p_out body in
     Single(id,p_in,p_out,List.sort_uniq
                            (fun (id1,_,_) (id2,_,_)
                                 -> String.compare id1 id2) vars,body)
  | _ -> raise (Invalid_AST "")

let share_prog (prog:prog) : prog =
  List.map share_def prog
