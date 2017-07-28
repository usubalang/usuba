open Usuba_AST
open Utils
open Printf

let make_int_list (n:int) : int list =
  let rec aux i acc =
    if i = 0 then acc
    else aux (i-1) (i :: acc) in
  aux n []

let p_to_int_list (p:p) : int list =
  List.flatten @@
    List.map (fun (_,typ,_) -> match typ with
                               | Bool -> [1]
                               | Int n -> make_int_list n
                               | _ -> raise (Not_implemented "")) p
  
module Usuba = struct

  let rename (id:ident) : ident =
    "std-" ^ id

  let z3_node (def:def) (vars:p) (body:deq list) : string = ""

  let z3_table (def:def) (l:int list) : string =
    let id = rename def.id in
    let int_to_idx n =
      let size = int_of_float (log (float_of_int (List.length l)) /. (log 2.0)) in
      let res = ref [] in
      for i = size-1 downto 0 do
        res := (n lsr i land 1 = 1) :: !res
      done;
      !res in
    (join "\n" (List.mapi (fun _ i -> sprintf
"(declare-fun %s-%d (%s) Bool)" id i
(join " " (List.map (fun _ -> "Bool") (p_to_int_list def.p_in))))
                          (p_to_int_list def.p_out))) ^
      (join "\n" (List.mapi (fun x i -> sprintf
"(assert (forall (%s)
                 (=> (and %s)
                     (and %s))))"
                            ) l))

      
    
(*     let id = def.id in *)
(*     let int_l = p_to_int_list def.p_in in *)
(*     join "\n" (List.mapi *)
(*                  (fun i x -> sprintf *)
(* "(declare-fun %s-%d (%s) Bool) *)
(* (assert (forall (%s) *)
(*            (= (or %s) *)
(*               (= (%s-%d %s) %s))))" *)
(* id i (join " " (List.map (fun _ -> "Bool") int_l)) *)
(* (join " " (List.mapi (fun i _ -> sprintf "(i-%d Bool)" i) int_l)) *)
(* (...........) *)
(* id i (join " " (List.mapi (fun i _ -> sprintf "i-%d" i) int_l)) *)



  let z3_perm (def:def) (l:int list) : string =
    let id = rename def.id in
    let int_l = p_to_int_list def.p_in in
    join "\n" (List.mapi
                 (fun i x -> sprintf
"(declare-fun %s-%d (%s) Bool)
(assert (forall (%s (x Bool)) 
           (= (= (%s-%d %s) x)
              (= i-%d x))))" 
id i (join " " (List.map (fun _ -> "Bool") int_l))
(join " " (List.mapi (fun i _ -> sprintf "(i-%d Bool)" i) int_l))
id i (join " " (List.mapi (fun i _ -> sprintf "i-%d" i) int_l))
(x-1)) l)
  
  let rec z3_def env_fun (def:def) : string =
    let converted = 
      match def.node with
      | Single(vars,body) -> z3_node def vars body
      | Multiple l ->
         join "" (List.mapi
                    (fun i (v,b) ->
                     z3_def env_fun { def with id = def.id ^ (string_of_int i);
                                               node = Single(v,b) }) l)
      | Perm l -> z3_perm def l
      | MultiplePerm l ->
         join "" (List.mapi
                    (fun i l' ->
                     z3_def env_fun { def with id = def.id ^ (string_of_int i);
                                               node = Perm l'}) l)
      | Table l -> z3_table def l
      | MultipleTable l ->
         join "" (List.mapi
                    (fun i l' ->
                     z3_def env_fun { def with id = def.id ^ (string_of_int i);
                                               node = Table l'}) l)
    in
    env_add env_fun def.id converted;
    (* printf "%s:%s\n" def.id converted; *)
    converted
  
  let gen_z3 (prog:prog) : string =
    let env_fun = Hashtbl.create 100 in
    join "\n" (List.map (z3_def env_fun) prog.nodes)
    
    
end
