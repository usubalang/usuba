open Usuba_AST
open Utils
open Printf

let get_vars_body (node:def_i) : p * deq list =
  match node with
  | Single(vars,body) -> vars,body
  | _ -> raise (Error "Not a Single")
               
let rename (name:string) : string =
  Str.global_replace (Str.regexp "'") "__" name

let var_to_c env (id:ident) : string =
  match env_fetch env id with
  | Some s -> s
  | None -> rename id.name

let op_to_c = function
  | And  -> "AND"
  | Or   -> "OR"
  | Xor  -> "XOR"
  | Andn -> "ANDN"
                
let rec expr_to_c env (e:expr) : string =
  match e with
  | Const n -> ( match n with
                 | 0 -> "SET_ALL_ONE()"
                 | 1 -> "SET_ALL_ZERO()"
                 | _ -> raise (Error ("Only 0 and 1 are allowed. Got "
                                      ^ (string_of_int n))))
  | ExpVar(Var id) -> var_to_c env id
  | Not e -> sprintf "NOT(%s)" (expr_to_c env e)
  | Log(op,x,y) -> sprintf "%s(%s,%s)"
                           (op_to_c op)
                           (expr_to_c env x)
                           (expr_to_c env y)
  | _ -> raise (Error (Usuba_print.expr_to_str e))
               
let fun_call_to_c env (p:var list) (f:ident) (args: expr list) : string =
  sprintf "  %s(%s,%s);"
          (rename f.name) (join "," (List.map (expr_to_c env) args))
          (join "," (List.map (function
                                | Var id -> "&" ^ (var_to_c env id)
                                | _ -> unreached ()) p))
          
let deqs_to_c env (deqs: deq list) : string =
  join "\n"
       (List.map
          (fun deq -> match deq with
            | Norec(p,Fun(f,l)) -> fun_call_to_c env p f l
            | Norec([Var p],e) ->
               sprintf "  %s = %s;" (var_to_c env p) (expr_to_c env e)
            | _ ->
               print_endline (Usuba_print.deq_to_str_types deq);
               assert false) deqs)

let params_to_arr (params: p) : string list =
  List.map (fun ((id,typ),_) ->
            match typ with
            | Bool -> id.name
            | Int(_,n) -> Printf.sprintf "%s[%d]" id.name n
            | Array(t,Const_e n) -> Printf.sprintf "%s[%d]" id.name (n*typ_size t)
            | _ -> raise (Not_implemented "Invalid input")) params

let rec gen_list_typ (x:string) (typ:typ) : string list =
  print_endline ("Suspicious \"'\" at: " ^ __LOC__);
  match typ with
  | Bool  -> [ x ]
  | Int(_,n) -> gen_list (x ^ "'") n
  | Array(t',Const_e n) -> List.flatten @@
                             List.map (fun x -> gen_list_typ x t')
                                      (gen_list0 (x ^ "'") n)
  | _ -> assert false
                              
           
let inputs_to_arr (def:def) =
  let inputs = Hashtbl.create 100 in
  let aux ((id,typ),_) =
    let id = id.name in
    match typ with
             | Bool -> Hashtbl.add inputs id (Printf.sprintf "%s[0]" (rename id))
             | Int(_,n) -> List.iter2
                          (fun x y ->
                           Hashtbl.add inputs x
                                       (Printf.sprintf "%s[%d]" (rename id) y))
                          (gen_list (id ^ "'") n)
                          (gen_list_0_int n)
             | Array(t,Const_e n) -> let size = typ_size t in
                             List.iter2
                               (fun x y ->
                                Hashtbl.add inputs x
                                            (Printf.sprintf "%s[%d]" (rename id) y))
                               (* (List.flatten
                                  (List.map (fun x -> gen_list (x ^ "'") n)
                                                     (gen_list (id ^ "'") size))) *)
                               (gen_list_typ id typ)
                               (gen_list_0_int (size * n))
             | _ -> Printf.printf "%s => %s:%s\n" def.id.name id
                                  (Usuba_print.typ_to_str typ);
                                  raise (Not_implemented "Arrays as input") in
  List.iter aux def.p_in;
  List.iter aux def.p_out;
  inputs
    
let outputs_to_ptr (def:def) =
  let outputs = Hashtbl.create 100 in
  List.iter (fun ((id,_),_) -> 
      let id = id.name in
      Hashtbl.add outputs id ("*"^(rename id))) def.p_out;
  outputs    

let c_header (arch:arch) : string =
  match arch with
  | Std -> "STD.h"
  | MMX -> "MMX.h"
  | SSE -> "SSE.h"
  | AVX -> "AVX.h"
  | AVX512  -> "AVX512.h"
  | Neon    -> "Neon.h"
  | AltiVec -> "AltiVec.h"
    
let def_to_c (orig:def) (def:def) (array:bool) : string =
  let (vars,body) = get_vars_body def.node in
  sprintf
"void %s (/*inputs*/ %s, /*outputs*/ %s) {
  
  // Variables declaration
%s

  // Instructions (body)
%s

}"
  (* Node name *)
  (rename def.id.name)

  (* Parameters *)
  (join "," (if array then
               List.map (fun x -> "DATATYPE " ^ x) (params_to_arr orig.p_in)
             else
               List.map (fun ((id,_),_) -> "DATATYPE " ^ (rename id.name)) def.p_in))
  (join "," (if array then
               List.map (fun x -> "DATATYPE " ^  x) (params_to_arr orig.p_out)
             else
               List.map (fun ((id,_),_) -> "DATATYPE* " ^ (rename id.name)) def.p_out))

  (* declaring variabes *)
  (join "" (List.map (fun ((id,_),_) -> sprintf "  DATATYPE %s;\n" (rename id.name)) vars))

  (* body *)
  (deqs_to_c (if array then inputs_to_arr orig else outputs_to_ptr def) body)


