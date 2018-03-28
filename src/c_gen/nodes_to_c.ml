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

let shift_op_to_c = function
  | Lshift  -> "L_SHIFT"
  | Rshift  -> "R_SHIFT"
  | Lrotate -> "L_ROTATE"
  | Rrotate -> "R_ROTATE"

let arith_op_to_c = function
  | Add -> "+"
  | Mul -> "*"
  | Sub -> "-"
  | Div -> "/"
  | Mod -> "%"

let rec aexpr_to_c (e:arith_expr) : string =
  match e with
  | Const_e n -> sprintf "%d" n
  | Var_e x   -> rename x.name
  | Op_e(op,x,y) -> sprintf "((%s) %s (%s))"
                            (aexpr_to_c x) (arith_op_to_c op) (aexpr_to_c y)
                
let rec expr_to_c (conf:config) env (e:expr) : string =
  match e with
  | Const n -> ( match n with
                 | 0 -> "SET_ALL_ONE()"
                 | 1 -> "SET_ALL_ZERO()"
                 | _ -> raise (Error ("Only 0 and 1 are allowed. Got "
                                      ^ (string_of_int n))))
  | ExpVar(Var id) -> var_to_c env id
  | Not e -> sprintf "NOT(%s)" (expr_to_c conf env e)
  | Log(op,x,y) -> sprintf "%s(%s,%s)"
                           (op_to_c op)
                           (expr_to_c conf env x)
                           (expr_to_c conf env y)
  | Shuffle(Var id,l) -> sprintf "PERMUT_%d(%s,%s)"
                                 (List.length l)
                                 (var_to_c env id)
                                 (join "," (List.map string_of_int l))
  | Shift(op,e,ae) ->
     Printf.fprintf stderr "Hardcoded rotation size\n";
     sprintf "%s(%s,%s,%d)"
             (shift_op_to_c op)
             (expr_to_c conf env e)
             (aexpr_to_c ae)
             32
  | _ -> raise (Error (Usuba_print.expr_to_str e))

               
let fun_call_to_c (conf:config) env (p:var list) (f:ident) (args: expr list) : string =
  sprintf "  %s(%s,%s);"
          (rename f.name) (join "," (List.map (expr_to_c conf env) args))
          (join "," (List.map (function
                                | Var id -> "&" ^ (var_to_c env id)
                                | _ -> unreached ()) p))
          
let rec deqs_to_c env (deqs: deq list) (conf:config) : string =
  join "\n"
       (List.map
          (fun deq -> match deq with
            | Norec(p,Fun(f,l)) -> fun_call_to_c conf env p f l
            | Norec([Var p],e) ->
               sprintf "  %s = %s;" (var_to_c env p) (expr_to_c conf env e)
            | Rec(i,ei,ef,l,_) ->
               sprintf "  for (int %s = %s; %s < %s; %s++) {\n%s\n}"
                       i.name (aexpr_to_c ei)
                       i.name (aexpr_to_c ef)
                       i.name
                       (deqs_to_c env l conf)
            | _ -> print_endline (Usuba_print.deq_to_str deq);
                   assert false) deqs)

let params_to_arr (params: p) : string list =
  List.map (fun ((id,typ),_) ->
            match typ with
            | Bool -> id.name
            | Int(_,n) -> Printf.sprintf "%s[%d]" id.name n
            (* Hard-coding the case ukxn[m] for now *)
            | Array(Int(_,n),Const_e m) -> Printf.sprintf "%s[%d][%d]" id.name m n
            | Array(t,Const_e n) -> Printf.sprintf "%s[%d]" id.name (n*typ_size t)
            | _ -> raise (Not_implemented "Invalid input")) params

let rec gen_list_typ (x:string) (typ:typ) : string list =
  match typ with
  | Bool  -> [ x ]
  | Int(_,n) -> List.map (sprintf "%s'") (gen_list0 x n)
  | Array(t',Const_e n) -> List.flatten @@
                             List.map (fun x -> gen_list_typ x t')
                                      (List.map (sprintf "%s'") (gen_list0 x n))
  | _ -> assert false
                              
           
let inputs_to_arr (def:def) =
  let inputs = Hashtbl.create 100 in
  let aux ((id,typ),_) =
    let id = id.name in
    match typ with
    (* Hard-coding the case ukxn[m] for now *)
    | Array(Int(_,n),Const_e m) ->
       List.iteri
         (fun i x ->
          List.iteri (fun j y ->
                      Hashtbl.add inputs
                                  (Printf.sprintf "%s'" y)
                                  (Printf.sprintf "%s[%d][%d]" (rename id) i j))
                     (gen_list0 (Printf.sprintf "%s'" x) n))
         (gen_list0 id m)
    | Bool -> Hashtbl.add inputs id (Printf.sprintf "%s[0]" (rename id))
    | Int(_,1) -> Hashtbl.add inputs id (Printf.sprintf "%s[0]" (rename id))
    | Int(_,n) -> List.iter2
                    (fun x y ->
                     Hashtbl.add inputs
                                 (Printf.sprintf "%s'" x)
                                 (Printf.sprintf "%s[%d]" (rename id) y))
                    (gen_list0 id n)
                    (gen_list_0_int n)
    | Array(t,Const_e n) -> let size = typ_size t in
                            List.iter2
                              (fun x y ->
                               Hashtbl.add inputs x
                                           (Printf.sprintf "%s[%d]" (rename id) y))
                              (gen_list_typ id typ)
                              (gen_list_0_int (size * n))
    | _ -> Printf.printf "%s => %s:%s\n" def.id.name id
                         (Usuba_print.typ_to_str typ);
           raise (Not_implemented "Arrays as input") in
  
  List.iter aux (Rename.rename_p def.p_in);
  List.iter aux (Rename.rename_p def.p_out);
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
    
let single_to_c (orig:def) (def:def) (array:bool) (vars:p)
                (body:deq list) (conf:config) : string =
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
               List.map (fun x -> "DATATYPE " ^ (rename x))
                        (params_to_arr (Rename.rename_p orig.p_in))
             else
               List.map (fun ((id,_),_) -> "DATATYPE " ^ (rename id.name)) def.p_in))
  (join "," (if array then
               List.map (fun x -> "DATATYPE " ^  (rename x))
                        (params_to_arr (Rename.rename_p orig.p_out))
             else
               List.map (fun ((id,_),_) -> "DATATYPE* " ^ (rename id.name)) def.p_out))

  (* declaring variabes *)
  (join "" (List.map (fun ((id,_),_) -> sprintf "  DATATYPE %s;\n" (rename id.name)) vars))

  (* body *)
  (deqs_to_c (if array then inputs_to_arr orig else outputs_to_ptr def) body conf)
  

let def_to_c (orig:def) (def:def) (array:bool) (conf:config) : string =
  match def.node with
  | Single(vars,body) -> single_to_c orig def array vars body conf
  | _ -> assert false
