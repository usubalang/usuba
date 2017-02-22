
open Abstract_syntax_tree

exception Not_implemented of string
exception Invalid_ast
exception Empty_list
exception Undeclared_var of string

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
  | Fun(f,l) -> Fun(f,List.map rename_expr l)
  | Mux(e,c,i) -> Mux(rename_expr e, c, i ^ "_")
  | Demux(i,l) -> Demux(i ^ "_", List.map (fun (c,e) -> c,rename_expr e) l)
               
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

(* Adds the variables vars to env *)
let rec add_vars (vars: p) (env: (ident, int) Hashtbl.t) : unit =
  match vars with
  | [] -> ()
  | (id,typ,_)::tl -> ( Hashtbl.add env id
                                    (match typ with
                                     | Bool  -> 1
                                     | Int n -> n);
                        add_vars tl env )

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

(* Flatten a list of expr inside a tuple *)
let rec flatten_expr (l: expr list) : expr list =
  match l with
  | [] -> []
  | hd::tl -> (match hd with
               | Tuple l -> flatten_expr l
               | _ -> [ hd ]) @ (flatten_expr tl)

                                  
let rec rewrite_expr (env: (ident, int) Hashtbl.t) (e: expr) : expr =
  match e with
  | Const c -> Const c (* TODO: convert potential integer to list of bool? *)
  | Var id  -> (try
                   let size = Hashtbl.find env id in
                   if size > 1 then Tuple (expand_intn_expr id size)
                   else e
                 with Not_found -> raise (Undeclared_var id))
  | Field (id,n) -> Var (id ^ (string_of_int n))
  | Tuple (l)    -> Tuple (flatten_expr (List.map (rewrite_expr env) l))
  | Op (op,l)    -> (match op with
                     | And -> Op(And, List.map (rewrite_expr env) l)
                     | Or  -> Op(Or, List.map (rewrite_expr env) l)
                     | Not -> Op(Not, List.map (rewrite_expr env) l)
                     (* a ^ b == ( a && ! b ) || ( ! a && b ) *)
                     | Xor -> (match l with
                               | e1::e2::[] ->
                                  Op(Or,
                                     [ Op(And, [ rewrite_expr env e1;
                                                 Op(Not, [ rewrite_expr env e2 ]) ]) ;
                                       Op(And, [ Op(Not, [ rewrite_expr env e1 ]);
                                                 rewrite_expr env e2 ])])
                               | _ -> raise (Not_implemented "n-ary XOR")))
  | Fun (f,l)    -> Fun(f, List.map (rewrite_expr env) l)
  | Mux (e,c,id) -> raise (Not_implemented "Mux")
  | Demux(id,l)  -> raise (Not_implemented "Demux")
                         
                                               
let rec rewrite_pat (pat: pat) (env: (ident, int) Hashtbl.t) : pat =
  match pat with
  | [] -> []
  | hd::tl -> (match hd with
               | Ident id -> ( try
                                 let size = Hashtbl.find env id in
                                 if size > 1 then expand_intn_pat id size
                                 else [ Ident id ]
                               with Not_found -> raise (Undeclared_var id) )
               | Dotted(id,n) -> [ Ident (id ^ (string_of_int n)) ] )
              @ (rewrite_pat tl env)
                  
let rec rewrite_deq (deq: deq) (env: (ident, int) Hashtbl.t) : deq =
  match deq with
  | [] -> []
  | (pat,expr) :: tl -> (rewrite_pat pat env, rewrite_expr env expr)
                        :: (rewrite_deq tl env)


(* mostly converting the uint_n to bools *)
let rec rewrite_p (p: p) =
  match p with
  | [] -> []
  | (id,typ,ck)::tl -> ( match typ with
                        | Bool  -> [ (id,Bool,ck) ]
                        | Int x -> expand_intn_typed id x ck ) @ (rewrite_p tl)

                                                             
let rewrite_def (name, p_in, p_out, p_var, body) =
  let env = Hashtbl.create 10 in
  add_vars p_in env;
  add_vars p_out env;
  add_vars p_var env;
  (name, rewrite_p p_in, rewrite_p p_out, p_var, rewrite_deq body env)
       
let rec rewrite_defs (l: def list) : def list =
  match l with
  | [] -> []
  | hd::tl -> (rewrite_def hd) :: (rewrite_defs tl)

let rewrite_prog (p: prog) : prog =
  rewrite_defs (rename_prog p)


               



               
(* ************************************************** *)
(*        Convertion of the AST to OCaml code         *)
(* ************************************************** *)       

let size_of_typ = function
  | Int _ -> 64
  | Bool  -> 1

let str_size_of_typ = function
  | Int _ -> "64"
  | Bool  -> "1"
            
let indent tab =
  String.make (tab * 4) ' '
              
let rec join s l =
  match l with
  | [] -> ""
  | e::[] -> e
  | hd::tl -> hd ^ s ^ (join s tl)

let ident_to_ml id = id
                       
let const_to_ml c = string_of_int c

let left_asgn_to_ml = function
  | Ident x -> ident_to_ml x
  | Dotted(x,i) -> (ident_to_ml x)  ^ (const_to_ml i)
                                  
let constructor_to_ml = function
  | "True"  -> "1"
  | "False" -> "0"
  | _ -> raise (Not_implemented "only constructor True and False are allowed for now.")
                                  
let rec expr_to_ml tab e =
  match e with
  | Const c -> const_to_ml c
  | Var v   -> ident_to_ml v
  | Field(x,i) -> (ident_to_ml x) ^ (const_to_ml i)
  | Tuple t -> "(" ^ (join "," (List.map (expr_to_ml tab) t)) ^ ")"
  | Op (op,a::b::[]) -> "(" ^ (expr_to_ml tab a) ^  ")" ^
                                ( match op with
                                  | And -> " && "
                                  | Or  -> " || "
                                  | _ -> raise Invalid_ast )
                                ^ "(" ^ (expr_to_ml tab b) ^ ")"
  | Op (Not,x::[]) -> "not (" ^ (expr_to_ml tab x) ^ ")"
  | Fun (f, l) -> (ident_to_ml f) ^ " " ^
                        (join " "
                              (List.map (fun x -> "(" ^ x ^ ")")
                                        (List.map (expr_to_ml tab) l)))
  | Mux (e,_,_) -> expr_to_ml tab e
  | Demux (id,l) -> "match " ^ (ident_to_ml id) ^ " with\n" ^
                          (join "\n"
                                (List.map (fun (c,e) ->
                                           (indent tab) ^ "  | " ^
                                             (constructor_to_ml c) ^ " -> " ^
                                               (expr_to_ml (tab+1) e)) l))
  | _ -> raise Invalid_ast
                       
let pat_to_ml tab pat =
  match pat with
  | e::[] -> left_asgn_to_ml e
  | l -> "(" ^ (join "," (List.map left_asgn_to_ml l)) ^ ")"

let deq_to_ml tab l =
  join "\n" (List.map (fun (p,e) -> (indent tab) ^ "let "
                                  ^ (pat_to_ml tab p) ^ " = "
                                  ^ (expr_to_ml tab e) ^ " in ") l)
                         
(* print a node *)
let def_to_ml tab (id, p_in, p_out, _, body) =
  "let " ^ (ident_to_ml id) ^ " "
  ^ (join " " (List.map (fun (id, _, _) -> (ident_to_ml id)) p_in)) ^ " = \n"
  ^ (deq_to_ml (tab+1) body) ^ "\n" ^ (indent (tab+1)) ^ "("
  ^ (join "," (List.map (fun (id,_,_) -> (ident_to_ml id)) p_out)) ^ ")\n"
                                                                           
let prog_to_ml (p:prog) : string =
  join "\n\n" (List.map (def_to_ml 0) (rewrite_prog p))













       


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
    


                 
