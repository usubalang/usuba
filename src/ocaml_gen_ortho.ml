
open Abstract_syntax_tree
open Utils

exception Not_implemented of string
exception Empty_list
exception Undeclared of string
exception Invalid_param_size
exception Invalid_operator_call
    
                              

               
(* ************************************************** *)
(*        Convertion of the AST to OCaml code         *)
(* ************************************************** *)       
           
module Rewriter = Rewriter.Make (Ortho_rewriter.Ortho_rewriter)   


let prologue_prog : string list ref = ref []
let prologue_fun : string list ref = ref []
let before_fun : string list ref = ref []

let generate_ref_fun =
  let rec upto_list n acc =
    if n = 0 then acc
    else upto_list (n-1) (("x"^(string_of_int n))::acc) in
  let counter = ref 0 in
  fun size -> (incr counter;
               let l = upto_list size [] in
               let name = "referencize"^(string_of_int !counter) in
               let fn = "let " ^ name ^ " (" ^
                 (join "," l) ^ ") = "
                 ^ (join "," (List.map (fun x -> "ref " ^ x) l)) in
               prologue_prog := (!prologue_prog) @ [fn];
               name)
                         
                       
                       
let size_of_typ = function
  | Int _ -> 64
  | Bool  -> 1
  | Array _ -> raise (Invalid_AST "Arrays should have been cleaned by now")

let str_size_of_typ = function
  | Int _ -> "64"
  | Bool  -> "1"
  | Array _ -> raise (Invalid_AST "Arrays should have been cleaned by now")
                         
let ident_to_str_ml id = id
                       
let const_to_str_ml = function
  | 0 -> "0"
  | 1 -> "-1"
  | _ -> "illegal value for a bool"

let left_asgn_to_str_ml = function
  | Ident x -> ident_to_str_ml x
  | Dotted(Ident x,i) -> (ident_to_str_ml x)  ^ (string_of_int i)
  | _ -> raise (Invalid_AST "non-conform AST")
                                  
let constructor_to_str_ml = function
  | "True"  -> "true"
  | "False" -> "false"
  | _ -> raise (Not_implemented "only constructor True and False are allowed for now.")
               
let rec expr_to_str_ml tab e =
  match e with
  | Const c -> const_to_str_ml c
  | Var v   -> ident_to_str_ml v
  | Field(Var x,i) -> (ident_to_str_ml x) ^ (string_of_int i)
  | Tuple t -> "(" ^ (join "," (List.map (expr_to_str_ml tab) t)) ^ ")"
  | Op (op,a::b::[]) -> "(" ^ (expr_to_str_ml tab a) ^  ")" ^
                                ( match op with
                                  | And -> " land "
                                  | Or  -> " lor "
                                  | _ -> raise (Invalid_AST "Unknown binary operator" ))
                                ^ "(" ^ (expr_to_str_ml tab b) ^ ")"
  | Op (Not,[Tuple l]) -> "(" ^ (join ","
                                      (List.map
                                         (fun x -> "lnot ("
                                                   ^ (expr_to_str_ml tab x) ^ ")") l)) ^ ")"
  | Op (Not,l) -> "(" ^ (join ","
                              (List.map
                                 (fun x -> "lnot ("
                                           ^ (expr_to_str_ml tab x) ^ ")") l)) ^ ")"
  | Fun (f, l) -> (ident_to_str_ml f) ^ " (" ^
                        (join ","
                              (List.map (fun x -> x )
                                        (List.map (expr_to_str_ml tab) l))) ^ ")"
  | Mux (e,_,_) -> expr_to_str_ml tab e
  | Demux (id,l) -> "match " ^ (ident_to_str_ml id) ^ " with\n" ^
                          (join "\n"
                                (List.map (fun (c,e) ->
                                           (indent tab) ^ "  | " ^
                                             (constructor_to_str_ml c) ^ " -> " ^
                                               (expr_to_str_ml (tab+1) e)) l))
  | Fby _  -> raise (Not_implemented "fby may not be part of a larger expression")
  | _ -> raise (Invalid_AST "Unrecognized expression")

let const_to_tuple c size =
  let rec aux c n =
    if n > size then []
    else (string_of_int (c mod 2))::(aux (c/2) (n+1)) in
  join "," (List.rev (aux c 1))

(* TODO: this function could easily be improved. 
   with something like "if x mod 2 = 1 then -1 else 0" *)
let gen_expand_identity size =
  let name = "expand_identity_" ^ (string_of_int size) in
  let body = ref ("let " ^ name ^ " (" ^ (join "," (gen_list "in" size)) ^ ") =\n") in
  for i = 1 to size do
    body := !body ^ (indent 1) ^ "let out" ^ (string_of_int i) ^ " = "
            ^ (join " lor " (List.map (fun x -> "(in" ^ (string_of_int i)
                                                ^ " lsl " ^ x ^ ")")
                                      (gen_list_0 "" 63))) ^ " in\n"
  done;
  body := !body ^ (indent 1) ^ "(" ^ (join "," (gen_list "out" size)) ^ ")";
  before_fun := !before_fun @ [!body];
  name

let gen_expand_fun f size =
  let name = "expand_fun_" ^ (string_of_int (id_generator ())) in
  let body = ref ("let " ^ name ^ " (" ^ (join "," (gen_list "in_0_" size)) ^ ") =\n") in
  for i = 1 to 62 do
    body := !body ^ (indent 1) ^ "let ("
            ^ (join "," (gen_list ("in_" ^ (string_of_int i) ^ "_") size))
            ^ ") = " ^ f ^ " ("
            ^ (join "," (gen_list ("in_" ^ (string_of_int (i-1)) ^ "_") size)) ^ ") in\n"
  done;
  for i = 1 to size do
    body := !body ^ (indent 1) ^ "let out" ^ (string_of_int i) ^ " = "
            ^ (join " lor " (List.map (fun x -> "(in_" ^ x ^ "_" ^ (string_of_int i)
                                                ^ " lsl " ^ x ^ ")")
                                      (gen_list_0 "" 63))) ^ " in\n"
  done;
  body := !body ^ (indent 1) ^ "(" ^ (join "," (gen_list "out" size)) ^ ")";
  before_fun := !before_fun @ [!body];
  name
       
let expand_init_fby size f =
  match f with
  | None -> gen_expand_identity size
  | Some f -> gen_expand_fun f size
       
let fby_to_str_ml tab p ei ef f =
  let len = List.length p in
  let ref_fun = generate_ref_fun len in
  let p' = List.map (fun x -> (left_asgn_to_str_ml x) ^ "'") p in
  let init = (match ei with
              | Const c -> const_to_tuple c (List.length p)
              | _ -> expr_to_str_ml tab ei) in
  let expand = expand_init_fby len f in
  let prologue = "let (" ^ (join "," p') ^ ") = " ^ ref_fun ^ " (" ^ expand ^ "(" 
                 ^ init ^ ")) in\n" in
  prologue_fun := (!prologue_fun) @ [prologue];
  let p'' = List.map (fun x -> (left_asgn_to_str_ml x) ^ "''") p in
  (indent tab) ^
    "let (" ^ (join "," (List.map left_asgn_to_str_ml p)) ^ ") = ("
    ^ (join "," (List.map (fun x -> let v = left_asgn_to_str_ml x in
                                              "!" ^ v ^ "'") p)) ^ ") in\n"
    ^ "let (" ^ (join "," p'') ^ ") = (" ^ (expr_to_str_ml tab ef) ^ ") in\n"
    ^ (join "\n" (List.map (fun x ->
                            let v = left_asgn_to_str_ml x in
                                      (indent tab) ^ (v ^ "' := " ^ v ^ "'';")) p))
        
let pat_to_str_ml tab pat =
  match pat with
  | e::[] -> left_asgn_to_str_ml e
  | l -> "(" ^ (join "," (List.map left_asgn_to_str_ml l)) ^ ")"

let deq_to_str_ml tab l =
  join "\n" (List.map (fun (p,e) ->
                       (match e with
                        | Fby(ei,ef,f) -> fby_to_str_ml tab p ei ef f
                        | _ -> (indent tab) ^ "let "
                               ^ (pat_to_str_ml tab p) ^ " = "
                               ^ (expr_to_str_ml tab e) ^ " in ")) l)
let p_to_str_ml tab p =
  join "," (List.map (fun (id,typ,_) ->
                      match typ with
                      | Bool -> (ident_to_str_ml id)
                      | Int n -> "(" ^
                                   (join "," (List.map (fun id -> ident_to_str_ml id )
                                                       (expand_intn_list id n))) ^ ")"
                      | Array _ -> raise
                                     (Invalid_AST
                                        "Arrays should have been cleaned by now")) p)
       
(* print a node *)
let def_to_str_ml tab = function
  | Single (id, p_in, p_out, _, body) ->
     prologue_fun := [];
     before_fun := [];
     let body_str = deq_to_str_ml (tab+1) body in
     ( match !prologue_fun with
       | [] -> (join "\n\n" !before_fun) ^ "\n"
               ^ ("let " ^ (ident_to_str_ml id) ^ " ("
                  ^ (p_to_str_ml tab p_in) ^ ") = \n"
                  ^ body_str ^ "\n" ^ (indent (tab+1)) ^ "("
                  ^ (p_to_str_ml tab p_out) ^ ")\n")
       | l  -> (join "\n\n" !before_fun) ^ "\n"
               ^ ("let " ^ (ident_to_str_ml id) ^ " = \n" ^
                    (join "\n" (List.map (fun x -> (indent (tab+1)) ^ x) l)) ^ "\n"
                    ^ (indent (tab+1)) ^ "fun (" ^ (p_to_str_ml tab p_in) ^ ") -> \n"
                    ^ body_str ^ "\n" ^ (indent (tab+1)) ^ "("
                    ^ (p_to_str_ml tab p_out) ^ ")\n"))
  | Multiple _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                        "Arrays should have been cleaned by now"))
  | Temporary _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                         "Temporary should be gone by now"))
  | Perm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                    "Perm should be gone by now"))
  | MultiplePerm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                            "MultiplePerm should have been cleaned by now"))
  | Table _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                     "Tables should be gone by now"))

                    
let prog_to_str_ml (p:prog) : string =
  prologue_prog := ["let id x = x";
"let convert_ortho (size: int) (input: int64 array) : int array =
  let out = Array.make size 0 in
  for i = 0 to Array.length input - 1 do
    for j = 0 to size-1 do
      let b = Int64.to_int (Int64.logand (Int64.shift_right input.(i) j) Int64.one) in
      out.(j) <- out.(j) lor (b lsl i)
    done
  done;
  out
 ";
"let convert_unortho (input: int array) : int64 array =
  let out = Array.make 63 Int64.zero in
  for i = 0 to Array.length input - 1 do
    for j = 0 to 62 do
      let b = Int64.of_int (input.(i) lsr j land 1) in
      out.(j) <- Int64.logor out.(j) (Int64.shift_left b i)
    done
  done;
  out"];
  let body = List.map (def_to_str_ml 0) (Rewriter.rewrite_prog p) in
  (join "\n\n" !(Rewriter.print_fun)) ^ "\n\n" ^ 
    (match !prologue_prog with
     | [] -> (join "\n\n" body) ^ "\n\n" ^ !(Rewriter.entry)
     | l  -> (join "\n\n" !prologue_prog)
             ^ "\n\n" ^  (join "\n\n" body) ^ "\n\n" ^ !(Rewriter.entry))
