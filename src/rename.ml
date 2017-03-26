open Usuba_AST
open Utils
       
(* Since the transformation of the code will produce new variable names,
   we must rename the old variables to make there won't be any conflicts 
   with those new names (or with any ocaml builtin name).
   Basically, it means adding an "'" at the end of every identifier name. *)

let rec rename_var (v:var) =
  match v with
  | Var v -> Var (v ^ "'")
  | Field(v,e) -> Field(rename_var v,e)
  | Index(v,e) -> raise (Invalid_AST(__LOC__ ^ "INDEX"))
  | Range(v,ei,ef) -> raise (Invalid_AST(__LOC__ ^ "RANGE"))
       
let rec rename_expr (e:expr) =
  match e with
  | Const c -> Const c
  | ExpVar v -> ExpVar (rename_var v)
  | Tuple l  -> Tuple(List.map rename_expr l)
  | Log(op,x,y) -> Log(op,rename_expr x,rename_expr y)
  | Arith(op,x,y) -> Arith(op,rename_expr x,rename_expr y)
  | Shift(op,x,y) -> Shift(op,rename_expr x,y)
  | Not e -> Not (rename_expr e)
  | Fun(f,l) -> if f = "print" then Fun(f,List.map rename_expr l)
                else Fun(f^"'",List.map rename_expr l)
  | Fby(ei,ef,f)   -> Fby(rename_expr ei,rename_expr ef,match f with
                                                        | None -> None
                                                        | Some id -> Some (id^"'"))
  | Nop -> Nop
  | Fun_v _ -> raise (Invalid_AST (__LOC__ ^ "Fun_v"))


                      
let rec rename_pat pat =
  let rec rename_pat_single = function
    | Var id -> Var (id ^ "'")
    | Field(p,n) -> Field(rename_pat_single p,n)
    | Index _ -> raise (Invalid_AST (format_exn __LOC__ "Index"))
    | Range _ -> raise (Invalid_AST (format_exn __LOC__ "Range")) in
  List.map rename_pat_single pat
           
let rec rename_deq deqs =
    List.map (function
               | Norec(pat,expr)  -> Norec(rename_pat pat,rename_expr expr)
               | Rec _ -> raise (Error (format_exn __LOC__ "Unexpected REC"))) deqs
                                                             
let rec rename_p p =
  List.map (fun (id,typ,ck) -> (id^"'",typ,ck)) p
                                          
let rename_def = function
  | Single (name, p_in, p_out, p_var, body) ->
     Single(name^"'", rename_p p_in, rename_p p_out, rename_p p_var, rename_deq body)
  | Multiple _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                        "Array should have been cleaned by now"))
  | Perm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                    "Perm should be gone by now"))
  | MultiplePerm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                            "MultiplePerm should have been cleaned by now"))
  | Table _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                     "Table should be gone by now"))
  | MultipleTable _ -> raise (Invalid_AST (__LOC__ ^
                                            "MultipleTable should have been cleaned by now"))
                                   
let rename_prog (p: prog) : prog =
  List.map rename_def p

