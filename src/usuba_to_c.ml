open Usuba_AST
open Utils

let rename (name:string) : string =
  Str.global_replace (Str.regexp "'") "__" name

let op_to_c (op:intr_fun) : string =
  match op with
  | Pand  -> "_mm_and_si128"
  | Por   -> "_mm_or_si128"
  | Pxor  -> "_mm_xor_si128"
  | Pandn -> "_mm_andnot_si128"
  | VPand  -> "_mm256_and_si256"
  | VPor   -> "_mm256_or_si256"
  | VPxor  -> "_mm256_xor_si256"
  | VPandn -> "_mm256_andnot_si256"
  (* AVX-512 aren't supported on most modern processors *)
  | VPandd  -> "_mm512_and_si512"
  | VPord   -> "_mm512_or_si512"
  | VPxord  -> "_mm512_xor_si512"
  | VPandnd -> "_mm512_andnot_si512"
  
                
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
                 | 0 -> "_mm_setzero_si128()"
                 | 1 -> "_mm_set1_epi32(-1)"
                 (* | 0 -> "_mm256_setzero_si256()" *)
                 (* | 1 -> "_mm256_set1_epi32(-1)" *)
                 | _ -> raise (Error ("Only 0 and 1 are allowed. Got "
                                      ^ (string_of_int n))))
  | ExpVar(Var id) -> rename id
  | Intr(op,x,y) -> (op_to_c op) ^ "(" ^ (expr_to_c x) ^ ","
                    ^ (expr_to_c y) ^ ")"
  | _ -> unreached ()
                     
let deqs_to_c (deqs: deq list) : string =
  join "\n"
       (List.map
          (function
            | Norec([Var p],e) ->
               "  " ^ (rename p) ^ " = " ^ (expr_to_c e) ^ ";"
            | _ -> unreached ()) deqs)
                     
let def_to_c (def:def) : string =
  match def with
  | Single(id,p_in,p_out,vars,body) ->
     Printf.sprintf
       "void %s (%s,%s) {\n%s\n%s\n%s\n%s\n}\n"
       (rename id)
       
       (* parameters *)
       ("__m128i input[" ^ (string_of_int (List.length p_in)) ^ "]")
       ("__m128i output[" ^ (string_of_int (List.length p_out)) ^ "]")

       (* retrieving input value *)
       (join "\n" (List.mapi (fun i (id,_,_) ->"  __m128i " ^ (rename id) ^ " = input["
                                               ^ (string_of_int i) ^ "];") p_in))

       (* declaring variabes *)
       (join "\n" (List.map (fun (id,_,_) -> "  __m128i " ^ (rename id) ^ ";") (vars@p_out)))

       (* the body *)
       (deqs_to_c body)

       (* setting the output *)
       (join "\n" (List.mapi (fun i (id,_,_) -> "  output[" ^ (string_of_int i) ^ "] = "
                                                ^ (rename id) ^ ";") p_out))
  | _ -> unreached () 
     
       
let prog_to_c (prog:prog) : string =
  assert (Assert_lang.Usuba_norm.is_usuba_normalized prog);
  let prog = Choose_instr.choose_instr prog in
  assert (Assert_lang.Usuba_intrinsics.is_only_intrinsics prog);
  "#include <stdlib.h>\n"
  ^ "#include \"mmintrin.h\"\n"
  ^ "#include \"immintrin.h\"\n"
  ^ "#include \"tmmintrin.h\"\n"
  ^ "#include \"emmintrin.h\"\n\n\n"
  ^ (join "\n\n" (List.map def_to_c prog))
  ^ "\n\nint main() { return 0; }" (* just so it can be compiled directly *)
