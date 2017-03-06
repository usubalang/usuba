open Abstract_syntax_tree
exception Syntax_error
       
(* Since the transformation of the code will produce new variable names,
   we must rename the old variables to make there won't be any conflicts 
   with those new names (or with any ocaml builtin name).
   Basically, it means adding an "_" at the end of every identifier name. *)
       
let rec rename_expr = function
  | Const c -> Const c
  | Var v   -> Var (v ^ "_")
  | Field(e,n) -> Field((match e with
                         | Var id -> Var (id ^ "_")
                         | _ -> raise Syntax_error), n)
  | Tuple l  -> Tuple(List.map rename_expr l)
  | Op(op,l) -> Op(op,List.map rename_expr l)
  | Fun(f,l) -> if f = "print" then Fun(f,List.map rename_expr l)
                else Fun(f^"_",List.map rename_expr l)
  | Mux(e,c,i) -> Mux(rename_expr e, c, i ^ "_")
  | Demux(i,l) -> Demux(i ^ "_", List.map (fun (c,e) -> c,rename_expr e) l)
  | Fby(ei,ef,f)   -> Fby(rename_expr ei,rename_expr ef,match f with
                                                        | None -> None
                                                        | Some id -> Some (id^"_"))
  | Nop -> Nop
  | Fun_i _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^ "A fun_i"))
  | Fun_v _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^ "A fun_v"))
  | Access _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^ "An Access"))
  | Fill_i _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^ "A fill_i"))

let rec rename_pat_single = function
  | Ident id -> Ident (id ^ "_")
  | Dotted(p,n) -> Dotted(rename_pat_single p,n)
  | _ -> raise Syntax_error
               
let rec rename_pat = function
  | [] -> []
  | hd::tl -> ( rename_pat_single hd ) :: (rename_pat tl)
                                                             
let rec rename_deq = function
  | [] -> []
  | (pat,expr) :: tl -> (rename_pat pat,rename_expr expr)::(rename_deq tl)
                                                             
let rec rename_p = function
  | [] -> []
  | (id,typ,ck)::tl -> (id^"_",typ,ck)::(rename_p tl)
                                          
let rename_def = function
  | Single (name, p_in, p_out, p_var, body) ->
     Single(name^"_", rename_p p_in, rename_p p_out, rename_p p_var, rename_deq body)
  | Multiple _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                        "Array should have been cleaned by now"))
  | Temporary _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                         "Temporary should be gone by now"))
  | Perm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                    "Perm should be gone by now"))
  | MultiplePerm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                            "MultiplePerm should have been cleaned by now"))
                         
let rec rename_defs = function
  | [] -> []
  | hd::tl -> (rename_def hd) :: (rename_defs tl)
                                   
let rename_prog (p: prog) : prog =
  rename_defs p

