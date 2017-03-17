open Sol_AST

let rec c_to_str_ml (c: c) : string =
  match c with
  | Var v    -> v
  | Const n  -> string_of_int n
  | Tuple l  -> "(" ^ (join "," (List.map c_to_str_ml l)) ^ ")"
  | Op(op,a::b::[])  -> "(" ^ (c_to_str_ml a) ^  ")" ^
                          ( match op with
                            | And -> " land "
                            | Or  -> " lor "
                            | Xor -> " lxor "
                            | _ -> unreached () )
                          ^ "(" ^ (c_to_str_ml b) ^ ")"
  | Op(Not,x::[]) -> "not (" ^ (c_to_str_ml x) ^ ")"
  | Op(Xor,a::b::[]) ->  
                 
       
let s_to_str_ml (s: s) : string =
  match s with
  | Asgn(l,c) -> "let (" ^ (join "," l)  ^ ") = " ^ (c_to_str_ml c) ^ " in"
  | Skip -> ""
  | Step(ll,o,lr) -> "let (" ^ (join "," ll) ^ ") = " ^ o ^ " "
                     ^ (join " " (List.map c_to_str lr)) ^ " in"
  | _ -> raise (Not_implemented (format_exn __LOC__
                                            "Can't convert state_asgn or reset to ocaml"))
       
let machine_to_str_ml ((id,memory,instances,reset,p_in,p_out,vars,body):machine)
    : string =
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
       
let prog_to_str_ml (prog: Sol_AST.prog) : string =
  join "\n\n" (List.map machine_to_str_ml prog)
