
open Usuba_AST
open Utils


module Gen_entry = struct
  
  open Usuba_AST
  open Utils

  let gen_ortho (id,size) =
    let rec aux i =
      if i > size then ([],[])
      else let stri = (string_of_int i) in
           let stri_m1 = (string_of_int (i-1)) in
           let (left,right) = aux (i+1) in
           ((id^stri)::left, ("Int64.logand (Int64.shift_right " ^ id ^ " " ^ stri_m1
                              ^ ") Int64.one = Int64.one")::right)
    in
    let (left,right) = aux 1 in
    (join "," left,
     "let " ^ id ^ " = Stream.next " ^ id ^ "stream in\n" ^
       (indent 2) ^ "let (" ^ (join "," left) ^ ") = (" ^ (join "," (List.rev right)) ^ ") in")


      
  let combine_out p_out =
    let rec aux = function
      | [] -> []
      | (id,typ,_)::tl -> ( match typ with
                            | Bool  -> [ id ]
                            | Int n -> gen_list id n 
                            | Nat   -> raise (Invalid_AST "Illegal Nat")
                            | Array _ -> raise
                                           (Invalid_AST "Arrays not cleaned"))
                          @ (aux tl)
    in aux p_out
           
  let gen_unortho p_out =
    let l = combine_out p_out in
    let rec aux size i =
      if i > size then []
      else ( let mul = "(Int64.shift_left Int64.one " ^ (string_of_int (size-i)) ^ ")" in
             let id_curr  = "ret" ^ (string_of_int i) in
             ("(if " ^ id_curr ^ " then " ^ mul ^ " else Int64.zero)")::(aux size (i+1)))
    in
    let left = gen_list "ret" (List.length l) in
    let right = List.map (fun (_,typ,_) ->
                          let size = match typ with
                              Bool  -> 1
                            | Int n -> n
                            | Nat   -> raise (Invalid_AST "Illegal Nat")
                            | Array _ -> raise (Invalid_AST "Arrays not cleaned") in
                          ( List.fold_left (fun x y -> "(Int64.logor " ^ x ^ " " ^ y ^ ")")
                                           "Int64.zero" (aux size 1) )) p_out in
    let ret = join "," (List.map (fun (id,_,_) -> id) p_out) in
    (join "," left,
     "let (" ^ ret ^ ") = " ^ (join "," right) ^ "\n"
     ^ (indent 2) ^ "in Some (" ^ ret ^ ")")    

      
  let gen_entry_point (node:def) =
    (match node.node with
     | Multiple _ -> raise (Invalid_AST "Arrays should have been cleaned by now")
     | Perm _ -> raise (Invalid_AST "Perm should be gone by now")
     | MultiplePerm _ -> raise (Invalid_AST "MultiplePerm should have been cleaned by now")
     | Table _ -> raise (Invalid_AST "Tables should be gone by now")
     | MultipleTable _ -> raise (Invalid_AST "MultipleTable should have been cleaned by now")
     | Single _ -> ());
    let params = List.map (fun (id,typ,_) ->
                           match typ with
                           | Bool  -> (id,1)
                           | Int n -> (id,n)
                           | Nat   -> raise (Invalid_AST "Nat in entry point")
                           | Array _ -> raise (Invalid_AST "Arrays not cleaned"))
                          node.p_in in
    let ortho = List.map gen_ortho params in
    let in_streams = List.map (fun (id,_) -> id ^ "stream") params in
    let head = "let main " ^ (join " " in_streams) ^ " = " in
    let (left,right) = gen_unortho node.p_out in
    (head ^ "\n" ^ (indent 1) ^ "Stream.from\n" ^ (indent 1) ^ "(fun _ -> \n"
     ^ (indent 1) ^ "try\n"
     ^ (indent 2) ^ (join ("\n"^(indent 2)) (List.map snd ortho)) ^ "\n"
     ^ (indent 2) ^ "let (" ^ left ^ ") = " ^ node.id ^ "' ("
     ^ (join "," (List.map fst ortho)) ^ ") in\n"
     ^ (indent 2) ^ right ^ "\n"
     ^ (indent 1) ^ "with Stream.Failure -> None)\n")

end ;;
  
(* ************************************************** *)
(*        Convertion of the AST to OCaml code         *)
(* ************************************************** *)       

let prologue_prog : string list ref = ref []
let prologue_fun : string list ref = ref []

let generate_ref_fun =
  let rec upto_list n acc =
    if n = 0 then acc
    else upto_list (n-1) (("x"^(string_of_int n))::acc) in
  let counter = ref 0 in
  fun size -> (incr counter;
               let l = upto_list size [] in
               let name = "referencize"^(string_of_int !counter) in
               let fn = "let " ^ name ^ " (" ^
                          (Utils.join "," l) ^ ") = "
                          ^ (join "," (List.map (fun x -> "ref " ^ x) l)) in
               prologue_prog := (!prologue_prog) @ [fn];
               name)
                
let ident_to_str_ml id = id
                           
let const_to_str_ml = function
  | 0 -> "false"
  | 1 -> "true"
  | x -> raise (Error ((string_of_int x) ^ " isn't a boolean"))

let var_to_str_ml = function
  | Var x -> ident_to_str_ml x
  | Field(Var x,Const_e i) -> (ident_to_str_ml x)  ^ (string_of_int i)
  | _ -> raise (Invalid_AST "non-conform AST")
               
let constructor_to_str_ml = function
  | "True"  -> "true"
  | "False" -> "false"
  | _ -> raise (Not_implemented "only constructor True and False are allowed for now.")
               
let rec expr_to_str_ml tab e =
  match e with
  | Const c -> const_to_str_ml c
  | ExpVar(Var v) -> ident_to_str_ml v
  | ExpVar(Field(Var x,Const_e i)) -> (ident_to_str_ml x) ^ (string_of_int i)
  | Tuple t -> "(" ^ (join "," (List.map (expr_to_str_ml tab) t)) ^ ")"
  | Log (Xor,a,b) -> expr_to_str_ml tab (Log(Or,Log(And,a,Not b),
                                             Log(And,Not a,b)))
  | Log (Andn,_,_) -> expr_to_str_ml tab (unfold_andn e)
  | Log (op,a,b) -> "(" ^ (expr_to_str_ml tab a) ^  ")" ^
                      ( match op with
                        | And -> " && "
                        | Or  -> " || "
                        | _ -> raise (Invalid_AST "Unknown binary operator") )
                      ^ "(" ^ (expr_to_str_ml tab b) ^ ")"
  | Arith (op,a,b) -> "(" ^ (expr_to_str_ml tab a) ^  ")" ^
                        ( match op with
                          | Add -> " + "
                          | Mul -> " * "
                          | Sub -> " - "
                          | Div -> " / "
                          | Mod -> " mod ")
                        ^ "(" ^ (expr_to_str_ml tab b) ^ ")"
  | Not e -> "not (" ^ (expr_to_str_ml tab e) ^ ")"
  | Fun (f, l) -> (ident_to_str_ml f) ^ " (" ^
                    (join ","
                          (List.map (fun x -> x )
                                    (List.map (expr_to_str_ml tab) l))) ^ ")"
  | Fby _  -> raise (Not_implemented "fby may not be part of a larger expression")
  | _ -> raise (Invalid_AST "Unrecognized expression")

let const_to_tuple c size =
  let rec aux c n =
    if n > size then []
    else (string_of_bool ((c mod 2) = 1))::(aux (c/2) (n+1)) in
  join "," (List.rev (aux c 1))
       
let fby_to_str_ml tab p ei ef =
  let len = List.length p in
  let ref_fun = generate_ref_fun len in
  let p' = List.map (fun x -> var_to_str_ml x) p in
  let init = (match ei with
              | Const c -> const_to_tuple c (List.length p)
              | _ -> expr_to_str_ml tab ei) in
  let prologue = "let (" ^ (join "," p') ^ ") = " ^ ref_fun ^ " ("
                 ^ init ^ ") in\n" in
  prologue_fun := (!prologue_fun) @ [prologue];
  let p'' = List.map (fun x -> (var_to_str_ml x) ^ "''") p in
  (indent tab) ^
    "let (" ^ (join "," (List.map var_to_str_ml p)) ^ ") = ("
    ^ (join "," (List.map (fun x -> let v = var_to_str_ml x in
                                    "!" ^ v) p)) ^ ") in\n"
    ^ "let (" ^ (join "," p'') ^ ") = (" ^ (expr_to_str_ml tab ef) ^ ") in\n"
    ^ (join "\n" (List.map (fun x ->
                            let v = var_to_str_ml x in
                            (indent tab) ^ (v ^ "' := " ^ v ^ "'';")) p))
        
let pat_to_str_ml tab pat =
  match pat with
  | e::[] -> var_to_str_ml e
  | l -> "(" ^ (join "," (List.map var_to_str_ml l)) ^ ")"

let deq_to_str_ml tab l =
  join "\n" (List.map (function
                        | Norec(p,e) ->
                           (match e with
                            | Fby(ei,ef,_) -> fby_to_str_ml tab p ei ef
                            | _ -> (indent tab) ^ "let "
                                   ^ (pat_to_str_ml tab p) ^ " = "
                                   ^ (expr_to_str_ml tab e) ^ " in ")
                        | Rec _ -> raise (Invalid_AST "REC")) l)
let p_to_str_ml tab p =
  join "," (List.map (fun (id,typ,_) ->
                      match typ with
                      | Bool  -> (ident_to_str_ml id)
                      | Int n -> (ident_to_str_ml id)
                      | Nat   -> raise (Invalid_AST "Nat shouldn't be there")
                      | Array _ -> raise (Invalid_AST "Arrays not cleaned")) p)
       
let def_to_str_ml tab def =
  match def.node with
  | Multiple _ -> raise (Invalid_AST "Arrays should have been cleaned by now")
  | Perm _ -> raise (Invalid_AST "Perm should be gone by now")
  | MultiplePerm _ -> raise (Invalid_AST "MultiplePerm should have been cleaned by now")
  | Table _ -> raise (Invalid_AST "Tables should be gone by now")
  | MultipleTable _ -> raise (Invalid_AST "MultipleTable should have been cleaned by now")
  | Single(_,body) ->
     prologue_fun := [];
     let body_str = deq_to_str_ml (tab+1) body in
     (match !prologue_fun with
      | [] -> ("let " ^ (ident_to_str_ml def.id) ^ " ("
               ^ (p_to_str_ml tab def.p_in) ^ ") = \n"
               ^ body_str ^ "\n" ^ (indent (tab+1)) ^ "("
               ^ (p_to_str_ml tab def.p_out) ^ ")\n")
      | l  -> ("let " ^ (ident_to_str_ml def.id) ^ " = \n" ^
                 (join "\n" (List.map (fun x -> (indent (tab+1)) ^ x) l)) ^ "\n"
                 ^ (indent (tab+1)) ^ "fun (" ^ (p_to_str_ml tab def.p_in) ^ ") -> \n"
                 ^ body_str ^ "\n" ^ (indent (tab+1)) ^ "("
                 ^ (p_to_str_ml tab def.p_out) ^ ")\n"))


                     
let prog_to_str_ml (p:prog) : string =
  let entry_point = Gen_entry.gen_entry_point
                      (Utils.last (Expand_array.expand_array p).nodes) in
  let converted = Normalize.norm_prog p in
  let body = List.map (def_to_str_ml 0) converted.nodes in
  (join "\n\n" !prologue_prog)
  ^ "\n\n" ^  (join "\n\n" body) ^ "\n\n" ^ entry_point

