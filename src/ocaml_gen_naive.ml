
open Abstract_syntax_tree

exception Not_implemented of string
exception Invalid_ast
exception Empty_list
exception Undeclared of string
exception Invalid_param_size
exception Invalid_operator_call

(* ************************************************** *)
(*            Renaming variables and nodes            *) 
(* ************************************************** *)

(* Since the transformation of the code will produce new variable names,
   we must rename the old variables to make there won't be any conflicts 
   with those new names (or with any ocaml builtin name) *)

let rec rename_expr = function
  | Const c -> Const c
  | Var v   -> Var (v ^ "_")
  | Field(id,n) -> Field(id^"_",n)
  | Tuple l  -> Tuple(List.map rename_expr l)
  | Op(op,l) -> Op(op,List.map rename_expr l)
  | Fun(f,l) -> Fun(f^"_",List.map rename_expr l)
  | Mux(e,c,i) -> Mux(rename_expr e, c, i ^ "_")
  | Demux(i,l) -> Demux(i ^ "_", List.map (fun (c,e) -> c,rename_expr e) l)
  | Fby(ei,ef)   -> Fby(rename_expr ei,rename_expr ef)
               
let rec rename_pat = function
  | [] -> []
  | hd::tl -> ( match hd with
                | Ident id -> Ident (id ^ "_")
                | Dotted(id,n) -> Dotted(id ^ "_", n) ) :: (rename_pat tl)
               
let rec rename_deq = function
  | [] -> []
  | (pat,expr) :: tl -> (rename_pat pat,rename_expr expr)::(rename_deq tl)
               
let rec rename_p = function
  | [] -> []
  | (id,typ,ck)::tl -> (id^"_",typ,ck)::(rename_p tl)
               
let rename_def (name, p_in, p_out, p_var, body) =
  (name^"_", rename_p p_in, rename_p p_out, rename_p p_var, rename_deq body)
               
let rec rename_defs = function
  | [] -> []
  | hd::tl -> (rename_def hd) :: (rename_defs tl)
                                   
let rename_prog (p: prog) : prog =
  rename_defs p

              
                              
(* ************************************************** *)
(*   AST transformation to match naive bool backend   *)
(* ************************************************** *)

let id_generator =
  let current = ref 0 in
  fun () -> incr current; !current
                
              
(* Auxiliary functions that need to be embeded in the code *)
let aux_fun = ref []
              
(* Adds the variables vars to env_var *)
let rec env_add_var (vars: p) (env_var: (ident, int) Hashtbl.t) : unit =
  match vars with
  | [] -> ()
  | (id,typ,_)::tl -> ( Hashtbl.add env_var id
                                    (match typ with
                                     | Bool  -> 1
                                     | Int n -> n);
                        env_add_var tl env_var )

(* Add a function (name,p_in,p_out) to env_fun *)
let env_add_fun (name: ident) (p_in: p) (p_out: p)
                (env_fun: (ident, int list * int) Hashtbl.t) : unit =
  let rec get_param_in_size = function
    | [] -> []
    | (id,typ,_)::tl -> (match typ with
                         | Bool -> 1
                         | Int n -> n) :: (get_param_in_size tl)
  in
  let rec get_param_out_size = function
    | [] -> 0
    | (_,typ,_)::tl -> (match typ with
                        | Bool -> 1
                        | Int n -> n)
  in
  Hashtbl.add env_fun name (get_param_in_size p_in,get_param_out_size p_out)


(* converts an uint_n to n bools (with types and clock) *)
let expand_intn_typed (id: ident) (n: int) (ck: clock) =
  let rec aux i =
    if i > n then []
    else (id ^ (string_of_int i), Bool, ck) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of pat) *)
let expand_intn_pat (id: ident) (n: int) : left_asgn list =
  let rec aux i =
    if i > n then []
    else (Ident (id ^ (string_of_int i))) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of expr) *)
let rec expand_intn_expr (id: ident) (n: int) : expr list =
  let rec aux i =
    if i > n then []
    else (Var (id ^ (string_of_int i))) :: (aux (i+1))
  in aux 1

let rec expand_intn_list (id: ident) (n: int) : ident list =
  let rec aux i =
    if i > n then []
    else (id ^ (string_of_int i)) :: (aux (i+1))
  in aux 1

(* Flatten a list of expr inside a tuple *)
let rec flatten_expr (l: expr list) : expr list =
  match l with
  | [] -> []
  | hd::tl -> (match hd with
               | Tuple l -> flatten_expr l
               | _ -> [ hd ]) @ (flatten_expr tl)

let rec distrib_not (l: expr list) : expr list =
  match l with
  | [] -> []
  | hd::tl -> (Op(Not,[hd])) :: (distrib_not tl)

let rec combine_op op l1 l2 =
  match l1, l2 with
  | [], [] -> []
  | hd1::tl1, hd2::tl2 -> (Op(op,[hd1;hd2])) :: (combine_op op tl1 tl2)
  | _ -> raise Invalid_param_size

let rec combine_xor l1 l2 =
  match l1, l2 with
  | [], [] -> []
  | hd1::tl1, hd2::tl2 -> ( Op(Or,
                               [ Op(And, [ hd1; Op(Not, [ hd2 ]) ]) ;
                                 Op(And, [ Op(Not, [ hd1 ]); hd2 ])]) )
                            :: (combine_xor tl1 tl2)
  | _ -> raise Invalid_param_size

let rec get_size e env =
  match e with
  | Const _ -> 1
  | Var _   -> 1 (* at this point, Var are only Bool *)
  | Field _ -> 1
  | Tuple l -> List.length l
  | Op _    -> 1 (* at this point, Op have already been normalized *)
  | Fun(f,_) -> (try
                    let (_,v) = Hashtbl.find env f in v
                  with Not_found -> raise @@ Undeclared("function " ^ f))
  | Mux _ -> raise (Not_implemented "Mux")
  | Demux _  -> raise (Not_implemented "Demux")
  | Fby(ei,_) -> get_size ei env
                      
let gen_conv target orig =
  if target = orig then "id"
  else begin
      let id = "convert" ^ (string_of_int @@ id_generator ()) in
      let num_param = ref 0 in
      let param = List.map (fun n -> incr num_param;
                                     ("in"^(string_of_int !num_param),
                                      Int n,
                                      "_")) orig in
      let num_ret = ref 0 in
      let ret = List.map (fun n -> incr num_ret;
                                   ("out"^(string_of_int !num_ret),
                                    Int n,
                                    "_")) target in
      let rec make_body id_p num_p id_r num_r size_curr_p size_curr_r next_p next_r :
        (pat * expr) list =
        if size_curr_p = 0 then
          match next_p with
          | [] -> []
          | hd::tl -> make_body (id_p+1) 0 id_r num_r hd size_curr_r tl next_r
        else if size_curr_r = 0 then
          match next_r with
          | [] -> []
          | hd::tl -> make_body id_p num_p (id_r+1) 0 size_curr_p hd next_p tl
        else
          ([Dotted("out"^(string_of_int id_r),num_r)], Field("int"^(string_of_int id_p),num_p)) ::
            (make_body id_p (num_p+1) id_r (num_r+1) (size_curr_p-1) (size_curr_r-1) next_p next_r)
      in
      let f = (id,param,ret,[], make_body 0 0 0 0 0 0 orig target) in
      aux_fun := (!aux_fun) @ [f];
      id
    end
                      
let rec get_sizes l env =
  match l with
  | [] -> []
  | hd::tl -> ( get_size hd env ) :: (get_sizes tl env)
               
let format_param f l env =
  try
    let (params,_) = Hashtbl.find env f in
    let sizes = get_sizes l env in
    [ Fun (gen_conv params sizes, l) ]
  with Not_found -> raise @@ Undeclared("function " ^ f)
               
                                  
let rec rewrite_expr (env_var: (ident, int) Hashtbl.t)
                     (env_fun: (ident, int list * int) Hashtbl.t) (e: expr) : expr =
  match e with
  | Const c -> Const c (* TODO: convert potential integer to list of bool? *)
  | Var id  -> (try
                   let size = Hashtbl.find env_var id in
                   if size > 1 then Tuple (expand_intn_expr id size)
                   else e
                 with Not_found -> e) (* Not_found -> it's a boolean *)
  | Field (id,n) -> Var (id ^ (string_of_int n))
  | Tuple (l)    -> Tuple (flatten_expr (List.map (rewrite_expr env_var env_fun) l))
  | Op (And,x1::x2::[]) -> let t1 = rewrite_expr env_var env_fun x1 in
                           let t2 = rewrite_expr env_var env_fun x2 in
                           (match t1,t2 with
                            | Tuple l1, Tuple l2 -> Tuple(combine_op And l1 l2)
                            | _ -> Op(And,[t1;t2]) )
  | Op (Or, x1::x2::[]) -> let t1 = rewrite_expr env_var env_fun x1 in
                           let t2 = rewrite_expr env_var env_fun x2 in
                           (match t1,t2 with
                            | Tuple l1, Tuple l2 -> Tuple(combine_op Or l1 l2)
                            | _ -> Op(Or,[t1;t2]) )
  | Op (Xor,x1::x2::[]) -> let t1 = rewrite_expr env_var env_fun x1 in
                           let t2 = rewrite_expr env_var env_fun x2 in
                           (match t1,t2 with
                            | Tuple l1, Tuple l2 -> Tuple(combine_xor l1 l2)
                            | _ -> Op(Or,
                                      [ Op(And, [ t1; Op(Not,[t2])] ) ;
                                        Op(And, [ Op(Not,[t1]);t2])]) )
  | Op (Not,l) -> Tuple(distrib_not (List.map (rewrite_expr env_var env_fun) l))
  | Op _ -> raise Invalid_operator_call
  | Fun (f,l)    -> Fun(f, format_param f (List.map (rewrite_expr env_var env_fun) l) env_fun)
  | Mux (e,c,id) -> raise (Not_implemented "Mux")
  | Demux(id,l)  -> raise (Not_implemented "Demux")
  | Fby(ei,ef)   -> Fby(rewrite_expr env_var env_fun ei, rewrite_expr env_var env_fun ef)
                         
                                               
let rec rewrite_pat (pat: pat) (env: (ident, int) Hashtbl.t) : pat =
  match pat with
  | [] -> []
  | hd::tl -> (match hd with
               | Ident id -> ( try
                                 let size = Hashtbl.find env id in
                                 if size > 1 then expand_intn_pat id size
                                 else [ Ident id ]
                               with Not_found -> [ Ident id ] )
               | Dotted(id,n) -> [ Ident (id ^ (string_of_int n)) ] )
              @ (rewrite_pat tl env)
                  
let rec rewrite_deq (deq: deq) (env_var: (ident, int) Hashtbl.t) env_fun : deq =
  match deq with
  | [] -> []
  | (pat,expr) :: tl -> (rewrite_pat pat env_var, rewrite_expr env_var env_fun expr)
                        :: (rewrite_deq tl env_var env_fun)


(* mostly converting the uint_n to bools *)
let rec rewrite_p (p: p) =
  match p with
  | [] -> []
  | (id,typ,ck)::tl -> ( match typ with
                        | Bool  -> [ (id,Bool,ck) ]
                        | Int x -> expand_intn_typed id x ck ) @ (rewrite_p tl)

                                                             
let rewrite_def (name, p_in, p_out, p_var, body) env_fun =
  let env_var = Hashtbl.create 10 in
  env_add_var p_in env_var;
  env_add_var p_out env_var;
  env_add_var p_var env_var;
  env_add_fun name p_in p_out env_fun;
  (name, p_in, rewrite_p p_out, p_var, rewrite_deq body env_var env_fun)
       
let rec rewrite_defs (l: def list)
                     (env_fun: (ident, int list * int) Hashtbl.t)
        : def list =
  match l with
  | [] -> []
  | hd::tl -> let hd' = (rewrite_def hd env_fun) in
              hd' :: (rewrite_defs tl env_fun)

let rewrite_prog (p: prog) : prog =
  let env_fun = Hashtbl.create 10 in
  let p' = rewrite_defs (rename_prog p) env_fun in
  (!aux_fun) @ p'

               
(* ************************************************** *)
(*        Convertion of the AST to OCaml code         *)
(* ************************************************** *)       
            
let indent tab =
  String.make (tab * 4) ' '
              
let rec join s l =
  match l with
  | [] -> ""
  | e::[] -> e
  | hd::tl -> hd ^ s ^ (join s tl)


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
                 (join "," l) ^ ") = "
                 ^ (join "," (List.map (fun x -> "ref " ^ x) l)) in
               prologue_prog := (!prologue_prog) @ [fn];
               name)
                         
                       
                       
let size_of_typ = function
  | Int _ -> 64
  | Bool  -> 1

let str_size_of_typ = function
  | Int _ -> "64"
  | Bool  -> "1"
                         
let ident_to_str_ml id = id
                       
let const_to_str_ml = function
  | 0 -> "false"
  | 1 -> "true"
  | _ -> "illegal value for a bool"

let left_asgn_to_str_ml = function
  | Ident x -> ident_to_str_ml x
  | Dotted(x,i) -> (ident_to_str_ml x)  ^ (const_to_str_ml i)
                                  
let constructor_to_str_ml = function
  | "True"  -> "true"
  | "False" -> "false"
  | _ -> raise (Not_implemented "only constructor True and False are allowed for now.")
               
let rec expr_to_str_ml tab e =
  match e with
  | Const c -> const_to_str_ml c
  | Var v   -> ident_to_str_ml v
  | Field(x,i) -> (ident_to_str_ml x) ^ (const_to_str_ml i)
  | Tuple t -> "(" ^ (join "," (List.map (expr_to_str_ml tab) t)) ^ ")"
  | Op (op,a::b::[]) -> "(" ^ (expr_to_str_ml tab a) ^  ")" ^
                                ( match op with
                                  | And -> " && "
                                  | Or  -> " || "
                                  | _ -> raise Invalid_ast )
                                ^ "(" ^ (expr_to_str_ml tab b) ^ ")"
  | Op (Not,x::[]) -> "not (" ^ (expr_to_str_ml tab x) ^ ")"
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
  | _ -> raise Invalid_ast

let fby_to_str_ml tab p ei ef =
  let len = List.length p in
  let ref_fun = generate_ref_fun len in
  let p' = List.map (fun x -> (left_asgn_to_str_ml x) ^ "'") p in
  let prologue = "let (" ^ (join "," p') ^ ") = " ^ ref_fun ^ " ("
                 ^ (expr_to_str_ml tab ei) ^ ") in\n" in
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
                        | Fby(ei,ef) -> fby_to_str_ml tab p ei ef
                        | _ -> (indent tab) ^ "let "
                               ^ (pat_to_str_ml tab p) ^ " = "
                               ^ (expr_to_str_ml tab e) ^ " in ")) l)
let p_to_str_ml tab p =
  join "," (List.map (fun (id,typ,_) ->
                      match typ with
                      | Bool -> (ident_to_str_ml id)
                      | Int n -> "(" ^
                                   (join "," (List.map (fun id -> ident_to_str_ml id )
                                                       (expand_intn_list id n))) ^ ")") p)
       
(* print a node *)
let def_to_str_ml tab (id, p_in, p_out, _, body) =
  prologue_fun := [];
  let body_str = deq_to_str_ml (tab+1) body in
  match !prologue_fun with
  | [] -> ("let " ^ (ident_to_str_ml id) ^ " ("
           ^ (p_to_str_ml tab p_in) ^ ") = \n"
           ^ body_str ^ "\n" ^ (indent (tab+1)) ^ "("
           ^ (p_to_str_ml tab p_out) ^ ")\n")
  | l  -> ("let " ^ (ident_to_str_ml id) ^ " = \n" ^
             (join "\n" (List.map (fun x -> (indent (tab+1)) ^ x) l)) ^ "\n"
             ^ (indent (tab+1)) ^ "fun (" ^ (p_to_str_ml tab p_in) ^ ") -> \n"
             ^ body_str ^ "\n" ^ (indent (tab+1)) ^ "("
             ^ (p_to_str_ml tab p_out) ^ ")\n")
                                                                           
let prog_to_str_ml (p:prog) : string =
  prologue_prog := [];
  let body = List.map (def_to_str_ml 0) (rewrite_prog p) in
  match !prologue_prog with
  | [] -> join "\n\n" body
  | l  -> (join "\n\n" !prologue_prog)
          ^ "\n\n" ^  (join "\n\n" body)







       


(* (\* ************************************************** *\) *)
(* (\*      The boilerplate around the bitsliced code     *\) *)
(* (\* ************************************************** *\) *)
(* let rec get_last l = *)
(*   match l with *)
(*   | [] -> raise Empty_list *)
(*   | x::[] -> x *)
(*   | x::tl -> get_last tl *)


                   
(* let naive_code (p: prog) = *)
(*   let (main_id,main_arg,_,_,_) = get_last p in *)
(*   let decl = *)
(*     join "\n" (List.map (fun (x,t,_) -> *)
(*                          "let " ^ x ^ " = ortho " ^ (str_size_of_typ t) *)
(*                          ^ "_" ^ x ^ "in") main_arg) in *)
(*   let header = "let _" ^ main_id ^ *)
(*                  (join " " (List.map (fun (x,_,_) -> "_" ^ x) main_arg)) in *)
(*   let body = "" in *)
(*   let func = header ^ "\n" ^ decl ^ "\n" ^ body in *)
(*   print_string func; *)
(*   () *)

       
(* (\* what follows is what should actually be generated for the usuba implementation of DES *\) *)
    
(* (\* ortho_block is already inside ocaml_runtime.ml *\) *)
(* let ortho_block (size: int) (input: int array) : int array = *)
(*   let out = Array.make size 0 in *)
(*   for i = 0 to Array.length input - 1 do *)
(*     for j = 0 to size-1 do *)
(*       let b = (input.(i) lsr j) land 1 in *)
(*       out.(j) <- out.(j) lor (b lsl i) *)
(*     done *)
(*   done; *)
(*   out *)

    
(* (\* Just including des_bitsliced here so the code compiles *\) *)
(* (\* (this function just returns the plaintext) *\) *)
(* (\* STATUS: OK. (written by the user) *\) *)
(* let des_bitslice (a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64) *)
(*                  (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_) =  *)
(*   (a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64) *)

  
(* (\* ok, this function looks a little bit terrifying *\) *)
(* (\* It's basically a proxy between the main and the des_bistlice function: it extract the *)
(*    int from a stream (an array would be ok) to send them to des_bitslice  *\) *)
(* (\* STATUS: OK. just extracts values from a stream (could work with an array as well) *\) *)
(* let des (plaintext: int Stream.t) (key: int Stream.t) : int Stream.t = *)
(*   let [ a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12;a13;a14;a15;a16;a17;a18;a19;a20;a21;a22;a23;a24;a25;a26;a27;a28;a29;a30;a31;a32;a33;a34;a35;a36;a37;a38;a39;a40;a41;a42;a43;a44;a45;a46;a47;a48;a49;a50;a51;a52;a53;a54;a55;a56;a57;a58;a59;a60;a61;a62;a63;a64 ] = Stream.npeek 64 plaintext in *)
(*   let [ k1;k2;k3;k4;k5;k6;k7;k8;k9;k10;k11;k12;k13;k14;k15;k16;k17;k18;k19;k20;k21;k22;k23;k24;k25;k26;k27;k28;k29;k30;k31;k32;k33;k34;k35;k36;k37;k38;k39;k40;k41;k42;k43;k44;k45;k46;k47;k48;k49;k50;k51;k52;k53;k54;k55;k56;k57;k58;k59;k60;k61;k62;k63;k64 ] = Stream.npeek 64 key in *)

(*   let (r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,r32,r33,r34,r35,r36,r37,r38,r39,r40,r41,r42,r43,r44,r45,r46,r47,r48,r49,r50,r51,r52,r53,r54,r55,r56,r57,r58,r59,r60,r61,r62,r63,r64) = *)
(*     des_bitslice (a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64) *)
(*                  (k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32,k33,k34,k35,k36,k37,k38,k39,k40,k41,k42,k43,k44,k45,k46,k47,k48,k49,k50,k51,k52,k53,k54,k55,k56,k57,k58,k59,k60,k61,k62,k63,k64) in *)

(*   Stream.of_list [ r1;r2;r3;r4;r5;r6;r7;r8;r9;r10;r11;r12;r13;r14;r15;r16;r17;r18;r19;r20;r21;r22;r23;r24;r25;r26;r27;r28;r29;r30;r31;r32;r33;r34;r35;r36;r37;r38;r39;r40;r41;r42;r43;r44;r45;r46;r47;r48;r49;r50;r51;r52;r53;r54;r55;r56;r57;r58;r59;r60;r61;r62;r63;r64 ] *)


    
(* (\* just a test : what could be the main of DES *\) *)
(* (\* for now, assuming the size of plaintext is a multiple of 63 *\) *)
(* (\* returns an int array Stream (could be converted to an int stream, but it's  *)
(*    hardly the most urgent matter *\) *)
(* (\* Note: int Stream.t won't work for DES as int are only 63 bits in OCaml. *)
(*    maybe strings instead would do. *\) *)
(* (\* STATUS: TBD.  *)
(*            are all the streams really necessary?  *)
(*            need to think about the automated orthogonalization *\) *)
(* let main (plaintext : int Stream.t) (key : int) : int array Stream.t = *)
(*   let ortho_key = ortho_block 64 (Array.make 63 key) in *)
(*   let key_stream = Stream.from (fun i -> Some ortho_key.(i mod 64)) in *)
  
(*   let ciphered = *)
(*     Stream.from *)
(*       (fun _ ->  match Stream.npeek 63 plaintext with *)
(*                  | [] -> None *)
(*                  | l  -> let block = ortho_block 64 (Array.of_list l) in *)
(*                          let block_stream = Stream.from (fun i -> Some block.(i)) in *)
(*                          let ciphered_stream = des block_stream key_stream in *)
(*                          Some (ortho_block 63 (Array.of_list *)
(*                                                  (Stream.npeek 64 ciphered_stream)))) *)
(*   in *)
(*   ciphered *)
    


                 
