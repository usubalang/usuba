open Usuba_AST
open Utils
open Printf

let struct_defs = ref []
       
let slice_type = ref (AVX 256)

let gen_tmp_arr =
  let cpt = ref 0 in
  fun () -> incr cpt;
            "__tmp_arr_" ^ (string_of_int !cpt)

let rename (name:string) : string =
  Str.global_replace (Str.regexp "'") "__" name

let op_to_c (op:intr_fun) : string =
  match op with
  | And64 -> "&"
  | Or64  -> "|"
  | Xor64 -> "^"
  | Add64 -> "+"
  | Sub64 -> "-"
  | Mul64 -> "*"
  | Div64 -> "/"
  | Mod64 -> "%"
  | Not64 -> "~"
  (* MMX *)
  | Pand64  -> "_mm_and_si64"
  | Por64   -> "_mm_or_si64"
  | Pxor64  -> "_mm_xor_si64"
  | Pandn64 -> "_mm_andnot_si64"
  | Paddb64 -> "_mm_add_pi8"
  | Paddw64 -> "_mm_add_pi16"
  | Paddd64 -> "_mm_add_pi32"
  | Psubb64 -> "_mm_sub_pi8"
  | Psubw64 -> "_mm_sub_pi16"
  | Psubd64 -> "_mm_sub_pi32"
  (* SSE *)
  | Pand128  -> "_mm_and_si128"
  | Por128   -> "_mm_or_si128"
  | Pxor128  -> "_mm_xor_si128"
  | Pandn128 -> "_mm_andnot_si128"
  | Paddb128 -> "_mm_add_epi8"
  | Paddw128 -> "_mm_add_epi16"
  | Paddd128 -> "_mm_add_epi32"
  | Paddq128 -> "_mm_add_epi64"
  | Psubb128 -> "_mm_sub_epi8"
  | Psubw128 -> "_mm_sub_epi16"
  | Psubd128 -> "_mm_sub_epi32"
  | Psubq128 -> "_mm_sub_epi64"
  (* AVX *)          
  | VPand256  -> "_mm256_and_si256"
  | VPor256   -> "_mm256_or_si256"
  | VPxor256  -> "_mm256_xor_si256"
  | VPandn256 -> "_mm256_andnot_si256"
  | VPaddb256 -> "_mm256_add_epi8"
  | VPaddw256 -> "_mm256_add_epi16"
  | VPaddd256 -> "_mm256_add_epi32"
  | VPaddq256 -> "_mm256_add_epi64"
  | VPsubb256 -> "_mm256_sub_epi8"
  | VPsubw256 -> "_mm256_sub_epi16"
  | VPsubd256 -> "_mm256_sub_epi32"
  | VPsubq256 -> "_mm256_sub_epi64"
  (* AVX-512 *)       
  | VPandd512  -> "_mm512_and_si512"
  | VPord512   -> "_mm512_or_si512"
  | VPxord512  -> "_mm512_xor_si512"
  | VPandnd512 -> "_mm512_andnot_si512"

let set_all_zero () =
  match !slice_type with
  | Std   -> "0"
  | MMX _ -> "_mm_setzero_si64()"
  | SSE _ -> "_mm_setzero_si128()"
  | AVX _ -> "_mm256_setzero_si256()"
  | AVX512 -> "_mm512_setzero_si512()"

let set_all_one () =
  match !slice_type with
  | Std   -> "-1"
  | MMX _ -> "_mm_set1_pi32(-1)"
  | SSE _ -> "_mm_set1_epi32(-1)"
  | AVX _ -> "_mm256_set1_epi32(-1)"
  | AVX512 -> "_mm512_set1_epi32(-1)"

let type_to_c (t:slice_type) : string =
  match t with
  | Std   -> "unsigned long"
  | MMX _ -> "__m64"
  | SSE _ -> "__m128i"
  | AVX _ -> "__m256i"
  | AVX512 -> "__m512i"
  
                
let replace_p_out (p_out: p) (deqs:deq list) : deq list =
  let env = Hashtbl.create 60 in
  List.iter (fun (id,_,_) -> env_add env id 1) p_out;
  let rec replace_in_expr e = match e with
    | ExpVar(Var v) -> (match env_fetch env v with
                        | Some x -> ExpVar(Var("*" ^ v))
                        | None -> e)
    | Intr(op,x,y) -> Intr(op,replace_in_expr x, replace_in_expr y)
    | _ -> e in
  List.map (function
             | Norec(p,e) ->
                Norec(
                    List.map (function Var v -> (match env_fetch env v with
                                                 | Some x -> Var("*" ^ v)
                                                 | None -> Var v)
                                     | _ -> unreached()) p,
                    replace_in_expr e)
             | _ -> unreached ()) deqs
                    
let rec expr_to_c (e:expr) : string =
  match e with
  | Const n -> ( match n with
                 | 0 -> set_all_zero ()
                 | 1 -> set_all_one ()
                 | _ -> raise (Error ("Only 0 and 1 are allowed. Got "
                                      ^ (string_of_int n))))
  | ExpVar(Var id) -> rename id
  | Not e -> sprintf "~(%s)" (expr_to_c e)
  | Intr(op,x,y) -> ( match !slice_type with
                      | Std -> sprintf "(%s) %s (%s)"
                                         (expr_to_c x) (op_to_c op) (expr_to_c y)
                      | _ -> sprintf "%s(%s,%s)"
                                     (op_to_c op) (expr_to_c x) (expr_to_c y))
  | _ -> raise (Error (Usuba_print.expr_to_str e)) 
           
let fun_call_to_c (p:var list) (f:ident) (args: expr list) : string =
  sprintf "  %s(%s,%s);"
          (rename f) (join "," (List.map (expr_to_c) args))
          (join "," (List.map (function
                                | Var id -> "&" ^ (rename id)
                                | _ -> unreached ()) p))
          
let deqs_to_c (deqs: deq list) : string =
  join "\n"
       (List.map
          (function
            | Norec(p,Fun(f,l)) -> fun_call_to_c p f l
            | Norec([Var p],e) ->
               sprintf "  %s = %s;" (rename p) (expr_to_c e)
            | _ -> unreached ()) deqs)

                   
let inner_def_to_c (def:def) : string =
  match def.node with
  | Single(vars,body) ->
     let type_c = type_to_c !slice_type in
     Printf.sprintf
       "void %s (%s,%s) {\n%s\n%s\n%s\n}\n"
       (rename def.id)
       
       (* parameters *)
       (join "," (List.map (fun (id,_,_) -> type_c ^ " " ^ (rename id)) def.p_in))
       (join "," (List.map (fun (id,_,_) -> type_c ^ "* __out_" ^ (rename id)) def.p_out))
       
       (* declaring variabes *)
       (join "" (List.map (fun (id,_,_) -> sprintf "  %s %s;\n"
                                                     type_c (rename id))
                            (vars@def.p_out)))

       (* the body *)
       (deqs_to_c body)

       (* setting the output *)
       (join "" (List.map (fun (id,_,_) -> sprintf "  *__out_%s = %s;\n"
                                                   (rename id) (rename id)) def.p_out))
  | _ -> unreached () 
                         
let def_to_c (def:def) : string =
  match def.node with
  | Single(vars,body) ->
     let type_c = type_to_c !slice_type in
     Printf.sprintf
       "void %s (%s,%s) {\n%s\n%s\n%s\n%s\n}\n"
       (rename def.id)
       
       (* parameters *)
       (type_c ^ " input[" ^ (string_of_int (List.length def.p_in)) ^ "]")
       (type_c ^ " output[" ^ (string_of_int (List.length def.p_out)) ^ "]")

       (* retrieving input value *)
       (join ""
             (List.mapi (fun i (id,_,_) -> sprintf "  %s %s = input[%d];\n"
                                                   type_c (rename id) i) def.p_in))

       (* declaring variabes *)
       (join "" (List.map (fun (id,_,_) -> sprintf "  %s %s;\n"
                                                     type_c (rename id))
                            (vars@def.p_out)))

       (* the body *)
       (deqs_to_c body)

       (* setting the output *)
       (join "" (List.mapi (fun i (id,_,_) -> sprintf "  output[%d] = %s;\n"
                                                        i (rename id)) def.p_out))
  | _ -> unreached () 

let rec map_no_end f l =
  match l with
  | [] -> []
  | [x] -> []
  | hd::tl -> (f hd) :: (map_no_end f tl)
                   
let prog_to_c (prog:prog) : string =
  assert (Assert_lang.Usuba_norm.is_usuba_normalized prog);
  let (slice, prog) = Select_instr.select_instr prog in
  slice_type := slice;
  assert (Assert_lang.Usuba_intrinsics.is_only_intrinsics prog);
  let len = List.length prog.nodes in
  let entry = def_to_c (List.nth prog.nodes (len-1)) in
  let prog_c = map_no_end inner_def_to_c prog.nodes in
  (* let _ = Share_var.share_prog prog input *)
  "#include <stdlib.h>\n"
  ^ "#include \"mmintrin.h\"\n"
  ^ "#include \"immintrin.h\"\n"
  ^ "#include \"tmmintrin.h\"\n"
  ^ "#include \"emmintrin.h\"\n\n\n"
  ^ (join "\n\n" !struct_defs) ^ "\n\n\n"
  ^ (join "\n\n" prog_c)
  ^ "\n\n" ^ entry
  ^ "\n\nint main() { return 0; }" (* just so it can be compiled directly *)
