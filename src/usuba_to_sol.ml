open Usuba_AST
open Sol_AST
open Utils

let var_gen =
  let cpt = ref 0 in
  fun () -> incr cpt;
            "x" ^ (string_of_int !cpt)

(* let get_fbys (l: deq) = *)
(*   List.map (fun (l,r) -> match r with *)
(*                          | Fby(ei,ef,id) -> (var_gen (),l,ei,ef,id) *)
(*                          | _ -> unreached ()) *)
(*            (List.filter (fun (_,e) -> match e with *)
(*                                       | Fby _ -> true *)
(*                                       | _ -> false) l) *)

(* let get_memory l = *)
(*   List.map (fun (x,_,_,_,_) -> List.map (fun x -> (x,Bool,"_")) l) l *)
           
let rec get_funs (l: deq) =
  List.map (fun (l,r) -> match r with
                         | Fun(f,body) -> (var_gen(), l,f,body)
                         | _ -> unreached ())
           (List.filter (fun (_,e) -> match e with
                                      | Fun _ -> true
                                      | _ -> false) l)
let get_instances l : (ident*ident) list =
  List.map (fun (x,_,f,_) -> (x,f)) l

let gen_reset instances =
  List.map (fun (x,_) -> Reset x) instances
           
(* let convert_body (body: Usuba_AST.deq) : s list = *)
(*   List.map (fun (left,right) -> match right with *)
(*                                 | Fun( *)
           
let convert_node f p_in p_out vars body : machine =
  let memory = [] in
  let funs = get_funs body in
  let instances = get_instances funs in
  let reset = gen_reset instances in
  let p_in' = List.map (fun (x,_,_) -> x) p_in in
  let p_out' = List.map (fun (x,_,_) -> x) p_out in
  let vars' = List.map (fun (x,_,_) -> x) vars in
  (f,memory,instances,reset,p_in',p_out',vars',[])
    
    
let convert_def (def: def) : machine =
  match def with
  | Single(f,p_in,p_out,vars,body) -> convert_node f p_in p_out vars body
  | _ -> raise (Error "Can't convert non-Single nodes to SOL")
               
let usuba_to_sol (prog: Usuba_AST.prog) : Sol_AST.prog =
  List.map convert_def prog
