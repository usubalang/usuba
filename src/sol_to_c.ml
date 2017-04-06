open Sol_AST
open Utils

let rename (name:string) : string =
  Str.global_replace (Str.regexp "'") "__" name

let op_to_C (op:op) : string =
  match op with
  | Pand  -> "_mm_and_si128"
  | Por   -> "_mm_or_si128"
  | Pxor  -> "_mm_xor_si128"
  | Pandn -> "_mm_andnot_si128"
  | VPand  -> "_mm256_and_si128"
  | VPor   -> "_mm256_or_si128"
  | VPxor  -> "_mm256_xor_si128"
  | VPandn -> "_mm256_andnot_si128"
                
let rec c_to_C (c: c) : string =
  match c with
  | Var v    -> v
  | Const n  -> string_of_int n
  | Log(op,a,b)  -> (op_to_C op) ^ "(" ^ (c_to_C a) ^  "," ^ (c_to_Cl b) ^ ")"
  | State_var _ -> raise (Not_implemented "State var")
                 
       
let s_to_C (s: s) : string =
  match s with
  | Asgn(v,c) -> v  ^ " = " ^ (c_to_C c) ^ ";"
  | Skip -> ""
  | Step(ll,o,lr) -> raise (Not_implemented "Step")
  | _ -> raise (Not_implemented "Can't convert state_asgn or reset to ocaml")

let vars_to_C (vars:m) : string =
  join "\n"
       (List.map
          (fun (id,typ) -> "  " ^ (typ_to_C typ) ^  ""))

let typ_inout p : string =
  match p with
  | (_,typ)::_ -> match typ with
                  | Int64 -> "unsigned long"
                  | Int128 -> "__m128i"
                  | Int256 -> "__m256i"
                  | Int512 -> "__m512i"
                             
let machine_to_C ((id,memory,instances,reset,p_in,p_out,vars,body):machine)
    : string =
  Printf.sprintf
    "void %s (%s,%s) {\n%s\n%s\n%s\n%s\n}\n"
    (rename id)
    ((typ_inout p_in) ^ " input[" ^ (string_of_int (List.length p_in)) ^ "]")
    ((typ_inout p_out) ^ " output[" ^ (string_of_int (List.length p_in)) ^ "]")
    (join "\n"
          (List.mapi
             (fun i (id,typ)
    
  "let " ^ id ^ " () = \n"
  ^ (join "\n"
          (List.map (fun x -> "  " ^ x)
                    (List.map
                       (fun (x,y) -> "let " ^ x ^ " = " ^ y ^ " () in")
                       instances)))
  ^ "\n  fun " ^ (join " " p_in) ^ " ->\n"
  ^ (join "\n"
          (List.map (fun x -> "    " ^ x)
                    (List.map s_to_str_ml body)))
  ^ "\n  (" ^ (join "," p_out) ^ ")"   
       
let prog_to_c (prog:prog) : string =
  "#include <stdlib.h>\n"
  ^ "#include \"tmmintrin.h\"\n"
  ^ "#include \"emmintrin.h\"\n\n\n"
  ^ (join "\n\n" (List.map machine_to_C prog))
  ^ "\n\nint main() { return 0; }" (* just so it can be compiled directly *)
