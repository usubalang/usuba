
open Abstract_syntax_tree

exception Not_implemented of string
exception Invalid_ast


(* ************************************************** *)
(*        Convertion of the AST to OCaml code         *)
(* ************************************************** *)       
            
let indent tab =
  String.make (tab * 4) ' '
              
let join s l =
  let rec join_aux s l acc =
    match l with
    | [] -> acc
    | hd::tl -> join_aux s tl (hd ^ s ^ acc)
  in match l with
     | [] -> ""
     | hd::tl -> join_aux s tl hd

let ident_to_ml id = id
                       
let const_to_ml c = string_of_int c

let constructor_to_ml = function
  | "True"  -> "1"
  | "False" -> "0"
  | _ -> raise (Not_implemented "only constructor True and False are allowed for now.")
                                  
let rec expr_to_ml tab e =
  match e with
  | AST_const c -> const_to_ml c
  | AST_var v   -> ident_to_ml v
  | AST_tuple t -> "(" ^ (join "," (List.map (expr_to_ml tab) t)) ^ ")"
  | AST_op (op,a::b::[]) -> "(" ^ (expr_to_ml tab a) ^  ")" ^
                                ( match op with
                                  | AST_and -> " land "
                                  | AST_or  -> " lor "
                                  | AST_xor -> " lxor "
                                  | _ -> raise Invalid_ast )
                                ^ "(" ^ (expr_to_ml tab b) ^ ")"
  | AST_op (AST_not,x::[]) -> "lnot (" ^ (expr_to_ml tab x) ^ ")"
  | AST_fun (f, l) -> (ident_to_ml f) ^ " " ^
                        (join " "
                              (List.map (fun x -> "(" ^ x ^ ")")
                                        (List.map (expr_to_ml tab) l)))
  | AST_mux (e,_,_) -> expr_to_ml tab e
  | AST_demux (id,l) -> "match " ^ (ident_to_ml id) ^ " with\n" ^
                          (join "\n"
                                (List.map (fun (c,e) ->
                                           (indent tab) ^ "  | " ^
                                             (constructor_to_ml c) ^ " -> " ^
                                               (expr_to_ml (tab+1) e)) l))
  | _ -> raise Invalid_ast
                       
let pat_to_ml tab pat =
  match pat with
  | e::[] -> ident_to_ml e
  | l -> "(" ^ (join "," (List.map ident_to_ml l)) ^ ")"

let deq_to_ml tab l =
  join "\n" (List.map (fun (p,e) -> (indent tab) ^ "let "
                                  ^ (pat_to_ml tab p) ^ " = "
                                  ^ (expr_to_ml tab e) ^ " in ") l)
                       
(* print a node *)
let def_to_ml tab (id, p_in, p_out, body) =
  "let " ^ (ident_to_ml id) ^ " "
  ^ (join " " (List.map (fun (id, _, _) -> (ident_to_ml id)) p_in)) ^ " = \n"
  ^ (deq_to_ml (tab+1) body) ^ "\n" ^ (indent (tab+1)) ^ "("
  ^ (join "," (List.map (fun (id,_,_) -> (ident_to_ml id)) p_out)) ^ ")\n"
                                                                      
let prog_to_ml p =
  join "\n\n" (List.map (def_to_ml 0) p)
       


(* ************************************************** *)
(*      The boilerplate around the bitsliced code     *)
(* ************************************************** *)

(* what follows is what should actually be generated for the usuba implementation of DES *)
       
(* ortho_block is already inside ocaml_runtime.ml *)
let ortho_block (size: int) (input: int array) : int array =
  let out = Array.make size 0 in
  for i = 0 to Array.length input - 1 do
    for j = 0 to size-1 do
      let b = (input.(i) lsr j) land 1 in
      out.(j) <- out.(j) lor (b lsl i)
    done
  done;
  out

    
(* Just including des_bitsliced here so the code compiles *)
(* (this function just returns the plaintext) *)
(* STATUS: OK. (written by the user) *)
let des_bitslice (a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64)
                 (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_) = 
  (a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64)

  
(* ok, this function looks a little bit terrifying *)
(* It's basically a proxy between the main and the des_bistlice function: it extract the
   int from a stream (an array would be ok) to send them to des_bitslice  *)
(* STATUS: OK. just extracts values from a stream (could work with an array as well) *)
let des (plaintext: int Stream.t) (key: int Stream.t) : int Stream.t =
  let [ a1;a2;a3;a4;a5;a6;a7;a8;a9;a10;a11;a12;a13;a14;a15;a16;a17;a18;a19;a20;a21;a22;a23;a24;a25;a26;a27;a28;a29;a30;a31;a32;a33;a34;a35;a36;a37;a38;a39;a40;a41;a42;a43;a44;a45;a46;a47;a48;a49;a50;a51;a52;a53;a54;a55;a56;a57;a58;a59;a60;a61;a62;a63;a64 ] = Stream.npeek 64 plaintext in
  let [ k1;k2;k3;k4;k5;k6;k7;k8;k9;k10;k11;k12;k13;k14;k15;k16;k17;k18;k19;k20;k21;k22;k23;k24;k25;k26;k27;k28;k29;k30;k31;k32;k33;k34;k35;k36;k37;k38;k39;k40;k41;k42;k43;k44;k45;k46;k47;k48;k49;k50;k51;k52;k53;k54;k55;k56;k57;k58;k59;k60;k61;k62;k63;k64 ] = Stream.npeek 64 key in

  let (r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31,r32,r33,r34,r35,r36,r37,r38,r39,r40,r41,r42,r43,r44,r45,r46,r47,r48,r49,r50,r51,r52,r53,r54,r55,r56,r57,r58,r59,r60,r61,r62,r63,r64) =
    des_bitslice (a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a33,a34,a35,a36,a37,a38,a39,a40,a41,a42,a43,a44,a45,a46,a47,a48,a49,a50,a51,a52,a53,a54,a55,a56,a57,a58,a59,a60,a61,a62,a63,a64)
                 (k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16,k17,k18,k19,k20,k21,k22,k23,k24,k25,k26,k27,k28,k29,k30,k31,k32,k33,k34,k35,k36,k37,k38,k39,k40,k41,k42,k43,k44,k45,k46,k47,k48,k49,k50,k51,k52,k53,k54,k55,k56,k57,k58,k59,k60,k61,k62,k63,k64) in

  Stream.of_list [ r1;r2;r3;r4;r5;r6;r7;r8;r9;r10;r11;r12;r13;r14;r15;r16;r17;r18;r19;r20;r21;r22;r23;r24;r25;r26;r27;r28;r29;r30;r31;r32;r33;r34;r35;r36;r37;r38;r39;r40;r41;r42;r43;r44;r45;r46;r47;r48;r49;r50;r51;r52;r53;r54;r55;r56;r57;r58;r59;r60;r61;r62;r63;r64 ]


    
(* just a test : what could be the main of DES *)
(* for now, assuming the size of plaintext is a multiple of 63 *)
(* returns an int array Stream (could be converted to an int stream, but it's 
   hardly the most urgent matter *)
(* Note: int Stream.t won't work for DES as int are only 63 bits in OCaml.
   maybe strings instead would do. *)
(* STATUS: TBD. 
           are all the streams really necessary? 
           need to think about the automated orthogonalization *)
let main (plaintext : int Stream.t) (key : int) : int array Stream.t =
  let ortho_key = ortho_block 64 (Array.make 63 key) in
  let key_stream = Stream.from (fun i -> Some ortho_key.(i mod 64)) in
  
  let ciphered =
    Stream.from
      (fun _ ->  match Stream.npeek 63 plaintext with
                 | [] -> None
                 | l  -> let block = ortho_block 64 (Array.of_list l) in
                         let block_stream = Stream.from (fun i -> Some block.(i)) in
                         let ciphered_stream = des block_stream key_stream in
                         Some (ortho_block 63 (Array.of_list
                                                 (Stream.npeek 64 ciphered_stream))))
  in
  ciphered



                 
