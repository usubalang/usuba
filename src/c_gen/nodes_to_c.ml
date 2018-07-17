open Usuba_AST
open Basic_utils
open Utils
open Printf

       
let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch (env:('a,'b) Hashtbl.t) (v:'a) : 'b = try Hashtbl.find env v
                      with Not_found -> raise (Error (__LOC__ ^ ":Not found: " ^ v.name))
                                              

let get_vars_body (node:def_i) : p * deq list =
  match node with
  | Single(vars,body) -> vars,body
  | _ -> raise (Error "Not a Single")
               
let rename (name:string) : string =
  Str.global_replace (Str.regexp "'") "__" name

let log_op_to_c = function
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
             
let arith_op_to_c_generic = function
  | Add -> "ADD"
  | Mul -> "MUL"
  | Sub -> "SUB"
  | Div -> "DIV"
  | Mod -> "MOD"

let rec aexpr_to_c (e:arith_expr) : string =
  match simpl_arith (make_env ()) e with
  | Const_e n -> sprintf "%d" n
  | Var_e x   -> rename x.name
  | Op_e(op,x,y) -> sprintf "(%s %s %s)"
                            (aexpr_to_c x) (arith_op_to_c op) (aexpr_to_c y)


let rec var_to_c (env:(string,string) Hashtbl.t) (v:var) : string =
  match v with
  | Var id -> (try Hashtbl.find env id.name
               with Not_found -> rename id.name)
  | Index(v',i) -> sprintf "%s[%s]" (var_to_c env v') (aexpr_to_c i)
  | _ -> assert false

let rec ret_var_to_c (env:(string,string) Hashtbl.t)
                     (env_var:(ident,typ) Hashtbl.t) (v:var) : string =
  match get_var_type env_var v with
  | Bool | Int(_,1) -> "&" ^ (var_to_c env v)
  | Array(_,_) | Int(_,_) -> var_to_c env v
  | _ -> assert false


(* TODO: this 64 and 32 shouldn't be hardcoded *)
let rec expr_to_c (conf:config) (env:(string,string) Hashtbl.t) (e:expr) : string =
  match e with
  | Const n -> ( match n with
                 | 0 -> "SET_ALL_ONE()"
                 | 1 -> "SET_ALL_ZERO()"
                 | n -> sprintf "SET(%d,%d)" n 64 )
  | ExpVar v -> var_to_c env v
  | Not e -> sprintf "NOT(%s)" (expr_to_c conf env e)
  | Log(op,x,y) -> sprintf "%s(%s,%s)"
                           (log_op_to_c op)
                           (expr_to_c conf env x)
                           (expr_to_c conf env y)
  | Arith(op,x,y) -> 
     (*Printf.fprintf stderr "Hardcoded arith op size\n";*)
     sprintf "%s(%s,%s,%d)"
                             (arith_op_to_c_generic op)
                             (expr_to_c conf env x)
                             (expr_to_c conf env y)
                             32
  | Shuffle(v,l) -> sprintf "PERMUT_%d(%s,%s)"
                                 (List.length l)
                                 (var_to_c env v)
                                 (join "," (List.map string_of_int l))
  | Shift(op,e,ae) ->
     (*Printf.fprintf stderr "Hardcoded rotation size\n";*)
     sprintf "%s(%s,%s,%d)"
             (shift_op_to_c op)
             (expr_to_c conf env e)
             (aexpr_to_c ae)
             32
  | Fun(f,[v]) when f.name = "rand" ->
     sprintf "%s = rand();" (expr_to_c conf env v)
  | _ -> raise (Error (Printf.sprintf "Wrong expr: %s" (Usuba_print.expr_to_str e)))

               
let fun_call_to_c (conf:config)
                  (env:(string,string) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t)
                  ?(tabs="  ")
                  (p:var list) (f:ident) (args: expr list) : string =
  sprintf "%s%s(%s,%s);"
          tabs
          (rename f.name) (join "," (List.map (expr_to_c conf env) args))
          (join "," (List.map (fun v -> ret_var_to_c env env_var v) p))
          
let rec deqs_to_c (env:(string,string) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t)
                  (deqs: deq list)
                  ?(tabs="  ")
                  (conf:config) : string =
  join "\n"
       (List.map
          (fun deq -> match deq with
            | Norec([v],Fun(f,[])) when f.name = "rand" ->
               sprintf "%s%s = rand();" tabs (var_to_c env v)
            | Norec(p,Fun(f,l)) -> fun_call_to_c conf env env_var ~tabs:tabs p f l
            | Norec([v],e) ->
               sprintf "%s%s = %s;" tabs (var_to_c env v) (expr_to_c conf env e)
            | Rec(i,ei,ef,l,_) ->
               sprintf "%sfor (int %s = %s; %s <= %s; %s++) {\n%s\n%s}"
                       tabs
                       (rename i.name) (aexpr_to_c ei)
                       (rename i.name) (aexpr_to_c ef)
                       (rename i.name)
                       (deqs_to_c env env_var l ~tabs:(tabs ^ "  ") conf)
                       tabs
            | _ -> print_endline (Usuba_print.deq_to_str deq);
                   assert false) deqs)

let params_to_arr (params: p) (marker:string) : string list =
  let rec typ_to_arr typ l =
    match typ with
    | Bool | Int(_,1) -> l
    | Int(_,n) -> (l @ [sprintf "[%d]" n])
    | Array(t,Const_e n) -> typ_to_arr t ((sprintf "[%d]" n) :: l)
    | _ -> raise (Not_implemented "Invalid input") in
  List.map (fun ((id,typ),_) -> match typ with
                                | Bool | Int(_,1) -> sprintf "%s%s" marker id.name
                                | _ -> sprintf "%s%s" id.name
                                               (join "" (typ_to_arr typ []))) params

let rec gen_list_typ (x:string) (typ:typ) : string list =
  match typ with
  | Bool  -> [ x ]
  | Int(_,n) -> List.map (sprintf "%s'") (gen_list0 x n)
  | Array(t',Const_e n) -> List.flatten @@
                             List.map (fun x -> gen_list_typ x t')
                                      (List.map (sprintf "%s'") (gen_list0 x n))
  | _ -> assert false
                              
           
let inputs_to_arr (def:def) : (string, string) Hashtbl.t =
  let inputs = make_env () in
  let aux (marker:string) ((id,typ),_) =
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
    | Bool -> Hashtbl.add inputs id (Printf.sprintf "%s%s" marker (rename id))
    | Int(_,1) -> Hashtbl.add inputs id (Printf.sprintf "%s%s" marker (rename id));
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
  
  List.iter (aux "") def.p_in;
  List.iter (aux "*") def.p_out;
  inputs
    
let outputs_to_ptr (def:def) : (string, string) Hashtbl.t =
  let outputs = make_env () in
  List.iter (fun ((id,typ),_) -> 
             let id = id.name in
             match typ with
             | Bool | Int(_,1) -> env_add outputs id ("*"^(rename id))
             | _ -> ()) def.p_out;
  outputs    

let rec var_decl_to_c (id:ident) (typ:typ) : string =
  (* x : Array(Int(_,m),k) should become x[k][m] and not x[m][k]
     that's the role of this "start" parameter *)
  let rec aux (id:ident) (typ:typ) start =
    match typ with
    | Nat  -> (rename id.name) ^ start
    | Bool -> (rename id.name) ^ start
    | Int(_,1) -> (rename id.name) ^ start
    | Int(_,m) -> sprintf "%s%s[%d]" (rename id.name) start m
    | Array(typ,size) -> aux id typ (sprintf "[%d]" (eval_arith_ne size)) in
  aux id typ ""
      
let c_header (arch:arch) : string =
  match arch with
  | Std -> "STD.h"
  | MMX -> "MMX.h"
  | SSE -> "SSE.h"
  | AVX -> "AVX.h"
  | AVX512  -> "AVX512.h"
  | Neon    -> "Neon.h"
  | AltiVec -> "AltiVec.h"
    
let single_to_c (def:def) (array:bool) (vars:p)
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
               List.map (fun x -> "DATATYPE " ^ (rename x)) (params_to_arr def.p_in "")
             else
               List.map (fun ((id,typ),_) -> "DATATYPE " ^ (var_decl_to_c id typ)) def.p_in))
  (join "," (if array then
               List.map (fun x -> "DATATYPE " ^  (rename x)) (params_to_arr def.p_out "*")
             else
               List.map (fun ((id,typ),_) -> (match typ with
                                              | Bool | Int(_,1) -> "DATATYPE* "
                                              | _ -> "DATATYPE ") ^ (var_decl_to_c id typ)) def.p_out))

  (* declaring variabes *)
  (join "" (List.map (fun ((id,typ),_) -> sprintf "  DATATYPE %s;\n" (var_decl_to_c id typ)) vars))

  (* body *)
  (deqs_to_c (if array then inputs_to_arr def else outputs_to_ptr def)
             (build_env_var def.p_in def.p_out vars) body conf)
  

let def_to_c (def:def) (array:bool) (conf:config) : string =
  match def.node with
  | Single(vars,body) -> single_to_c def array vars body conf
  | _ -> assert false
