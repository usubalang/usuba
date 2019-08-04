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

let var_to_c (lift_env:(var,int)  Hashtbl.t)
             (env:(string,string) Hashtbl.t) (v:var) : string =
  let rec aux (v:var) : string =
    match v with
    | Var id -> (try Hashtbl.find env id.name
                 with Not_found -> rename id.name)
    | Index(v',i) -> sprintf "%s[%s]" (aux  v') (aexpr_to_c i)
    | _ -> assert false in
  let cvar = aux v in
  match Hashtbl.find_opt lift_env (get_var_base v) with
  | Some n -> sprintf "LIFT_%d(%s)" n cvar
  | None -> cvar

let rec ret_var_to_c (lift_env:(var,int)  Hashtbl.t)
                     (env:(string,string) Hashtbl.t)
                     (env_var:(ident,typ) Hashtbl.t) (v:var) : string =
  match get_var_type env_var v with
  | Uint(_,_,1) -> "&" ^ (var_to_c lift_env env v)
  | Array _ | Uint _ -> var_to_c lift_env env v
  | _ -> assert false


(* TODO: this 64 and 32 shouldn't be hardcoded *)
let rec expr_to_c (lift_env:(var,int)  Hashtbl.t)
                  (conf:config) (env:(string,string) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t) (e:expr) : string =
  match e with
  | Const(n,_) -> ( match n with
                    | 0 -> "SET_ALL_ZERO()"
                    | 1 -> "SET_ALL_ONE()"
                    | n -> sprintf "SET(%d,%d)" n 64 )
  | ExpVar v -> var_to_c lift_env env v
  | Not e -> sprintf "NOT(%s)" (expr_to_c lift_env conf env env_var e)
  | Log(op,x,y) -> sprintf "%s(%s,%s)"
                           (log_op_to_c op)
                           (expr_to_c lift_env conf env env_var x)
                           (expr_to_c lift_env conf env env_var y)
  | Arith(op,x,y) ->
     (*Printf.fprintf stderr "Hardcoded arith op size\n";*)
     sprintf "%s(%s,%s,%d)"
                             (arith_op_to_c_generic op)
                             (expr_to_c lift_env conf env env_var x)
                             (expr_to_c lift_env conf env env_var y)
                             32
  | Shuffle(v,l) -> sprintf "PERMUT_%d(%s,%s)"
                                 (List.length l)
                                 (var_to_c lift_env env v)
                                 (join "," (List.map string_of_int l))
  | Shift(op,e,ae) ->
     (*Printf.fprintf stderr "Hardcoded rotation size\n";*)
     sprintf "%s(%s,%s,%d)"
             (shift_op_to_c op)
             (expr_to_c lift_env conf env env_var e)
             (aexpr_to_c ae)
             (get_expr_reg_size env_var e)
  | Fun(f,[v]) when f.name = "rand" ->
     sprintf "%s = RAND();" (expr_to_c lift_env conf env env_var v)
  | _ -> raise (Error (Printf.sprintf "Wrong expr: %s" (Usuba_print.expr_to_str e)))


(* TODO: this 64 and 32 shouldn't be hardcoded *)
let rec expr_to_c_ret (lift_env:(var,int)  Hashtbl.t)
                  (conf:config) (env:(string,string) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t) (ret:string) (e:expr) : string =
  match e with
  | Const(n,_) -> ( match n with
                    | 0 -> sprintf "%s = SET_ALL_ONE()" ret
                    | 1 -> sprintf "%s = SET_ALL_ZERO()" ret
                    | n -> sprintf "%s = SET(%d,%d)" ret n 64 )
  | ExpVar v -> sprintf "%s = %s" ret (var_to_c lift_env env v)
  | Not e -> sprintf "NOT(%s,%s)" ret (expr_to_c lift_env conf env env_var e)
  | Log(op,x,y) -> sprintf "%s(%s,%s,%s)"
                           (log_op_to_c op) ret
                           (expr_to_c lift_env conf env env_var x)
                           (expr_to_c lift_env conf env env_var y)
  | Arith(op,x,y) ->
     (*Printf.fprintf stderr "Hardcoded arith op size\n";*)
     sprintf "%s(%s,%s,%s,%d)"
                             (arith_op_to_c_generic op) ret
                             (expr_to_c lift_env conf env env_var x)
                             (expr_to_c lift_env conf env env_var y)
                             32
  | Shuffle(v,l) -> sprintf "%s = PERMUT_%d(%s,%s)" ret
                                 (List.length l)
                                 (var_to_c lift_env env v)
                                 (join "," (List.map string_of_int l))
  | Shift(op,e,ae) ->
     (*Printf.fprintf stderr "Hardcoded rotation size\n";*)
     sprintf "%s(%s,%s,%s,%d)"
             (shift_op_to_c op) ret
             (expr_to_c lift_env conf env env_var e)
             (aexpr_to_c ae)
             (get_expr_reg_size env_var e)
  | Fun(f,[v]) when f.name = "rand" ->
     sprintf "%s = RAND();" (expr_to_c lift_env conf env env_var v)
  | _ -> raise (Error (Printf.sprintf "Wrong expr: %s" (Usuba_print.expr_to_str e)))


let fun_call_to_c (lift_env:(var,int)  Hashtbl.t)
                  (conf:config)
                  (env:(string,string) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t)
                  ?(tabs="  ")
                  (p:var list) (f:ident) (args: expr list) : string =
  sprintf "%s%s(%s,%s);"
          tabs
          (rename f.name) (join "," (List.map (expr_to_c lift_env conf env env_var) args))
          (join "," (List.map (fun v -> ret_var_to_c lift_env env env_var v) p))

let rec deqs_to_c (lift_env:(var,int)  Hashtbl.t)
                  (env:(string,string) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t)
                  (deqs: deq list)
                  ?(tabs="  ")
                  (conf:config) : string =
  join "\n"
       (List.map
          (fun deq -> match deq with
            | Eqn([v],Fun(f,[]),_) when f.name = "rand" ->
               sprintf "%s%s = RAND();" tabs (var_to_c lift_env env v)
            | Eqn(p,Fun(f,l),_) -> fun_call_to_c lift_env conf env env_var ~tabs:tabs p f l
            | Eqn([v],e,_) ->
               sprintf "%s%s;" tabs (expr_to_c_ret lift_env conf env env_var
                                       (var_to_c lift_env env v) e)
            | Loop(i,ei,ef,l,_) ->
               sprintf "%sfor (int %s = %s; %s <= %s; %s++) {\n%s\n%s}"
                       tabs
                       (rename i.name) (aexpr_to_c ei)
                       (rename i.name) (aexpr_to_c ef)
                       (rename i.name)
                       (deqs_to_c lift_env env env_var l ~tabs:(tabs ^ "  ") conf)
                       tabs
            | _ -> print_endline (Usuba_print.deq_to_str deq);
                   assert false) deqs)

let params_to_arr (params: p) (marker:string) : string list =
  let rec typ_to_arr typ l =
    match typ with
    | Uint(_,_,1) -> l
    | Uint(_,_,n) -> (l @ [sprintf "[%d]" n])
    | Array(t,n) -> typ_to_arr t ((sprintf "[%d]" n) :: l)
    | _ -> raise (Not_implemented "Invalid input") in
  List.map (fun vd -> match vd.vtyp with
                      | Uint(_,_,1) -> sprintf "%s%s" marker vd.vid.name
                      | _ -> sprintf "%s%s" vd.vid.name
                                     (join "" (typ_to_arr vd.vtyp []))) params

let rec gen_list_typ (x:string) (typ:typ) : string list =
  match typ with
  | Uint(_,_,n) -> List.map (sprintf "%s'") (gen_list0 x n)
  | Array(t',n) ->
     List.flatten @@
       List.map (fun x -> gen_list_typ x t')
                (List.map (sprintf "%s'") (gen_list0 x n))
  | _ -> assert false


let inputs_to_arr (def:def) : (string, string) Hashtbl.t =
  let inputs = make_env () in
  let aux (marker:string) vd =
    let id = vd.vid.name in
    match vd.vtyp with
    (* Hard-coding the case ukxn[m] for now *)
    | Array(Uint(_,_,n),size) ->
       List.iteri
         (fun i x ->
          List.iteri (fun j y ->
                      Hashtbl.add inputs
                                  (Printf.sprintf "%s'" y)
                                  (Printf.sprintf "%s[%d][%d]" (rename id) i j))
                     (gen_list0 (Printf.sprintf "%s'" x) n))
         (gen_list0 id size)
    | Uint(_,_,1) -> Hashtbl.add inputs id (Printf.sprintf "%s%s" marker (rename id));
    | Uint(_,_,n) -> List.iter2
                    (fun x y ->
                     Hashtbl.add inputs
                                 (Printf.sprintf "%s'" x)
                                 (Printf.sprintf "%s[%d]" (rename id) y))
                    (gen_list0 id n)
                    (gen_list_0_int n)
    | Array(t,n) ->
       let size = typ_size t in
       List.iter2
         (fun x y ->
          Hashtbl.add inputs x
                      (Printf.sprintf "%s[%d]" (rename id) y))
         (gen_list_typ id vd.vtyp)
         (gen_list_0_int (size * n))
    | _ -> Printf.printf "%s => %s:%s\n" def.id.name id
                         (Usuba_print.typ_to_str vd.vtyp);
           raise (Not_implemented "Arrays as input") in

  List.iter (aux "") def.p_in;
  List.iter (aux "*") def.p_out;
  inputs

let outputs_to_ptr (def:def) : (string, string) Hashtbl.t =
  let outputs = make_env () in
  List.iter (fun vd ->
             let id = vd.vid.name in
             match vd.vtyp with
             | Uint(_,_,1) -> env_add outputs id ("*"^(rename id))
             | _ -> ()) def.p_out;
  outputs

let gen_intn (n:int) : string =
  match n with
  | 16 -> "uint16_t"
  | 32 -> "uint32_t"
  | 64 -> "uint64_t"
  | _ -> fprintf stderr "Can't generate native %d bits integer." n;
         assert false

let get_lift_size (vd:var_d) : int =
  match get_base_type vd.vtyp with
  | Uint(_,Mint i,_) -> i
  | _ -> fprintf stderr "Invalid lazy lift with type '%s'.\n"
                 (Usuba_print.typ_to_str vd.vtyp);
         assert false


let rec var_decl_to_c conf (vd:var_d) (out:bool) : string =
  (* x : Array(Int(_,m),k) should become x[k][m] and not x[m][k]
     that's the role of this "start" parameter *)
  let rec aux (id:ident) (typ:typ) start =
    match typ with
    | Nat  -> (rename id.name) ^ start
    | Uint(_,_,1) -> (rename id.name) ^ start
    | Uint(_,_,n) -> sprintf "%s%s[%d]" (rename id.name) start n
    | Array(typ,size) -> aux id typ (sprintf "[%d]" size) in
  let vname = aux vd.vid vd.vtyp "" in
  let vtype = if conf.lazylift && is_const vd then
                gen_intn (get_lift_size vd)
              else "DATATYPE" in
  let pointer = match out with
    | false -> ""
    | true  -> match vd.vtyp with
               | Uint(_,_,1) -> "*"
               | _ -> "" in
  sprintf "%s%s %s" vtype pointer vname

let c_header (arch:arch) : string =
  match arch with
  | Std -> "FAME.h"
  | MMX -> "MMX.h"
  | SSE -> "SSE.h"
  | AVX -> "AVX.h"
  | AVX512  -> "AVX512.h"
  | Neon    -> "Neon.h"
  | AltiVec -> "AltiVec.h"


let single_to_c (def:def) (array:bool) (vars:p)
                (body:deq list) (conf:config) : string =
  let lift_env = Hashtbl.create 100 in
  if conf.lazylift then
    List.iter (fun vd ->
               if is_const vd then
                 Hashtbl.add lift_env (Var vd.vid) (get_lift_size vd)) def.p_in;


  sprintf
"void %s (/*inputs*/ %s, /*outputs*/ %s) {

  // Variables declaration
  %s;

  // Instructions (body)
%s

}"
  (* Node name *)
  (rename def.id.name)

  (* Parameters *)
  (join "," (List.map (fun vd -> var_decl_to_c conf vd false) def.p_in))
  (join "," (List.map (fun vd -> var_decl_to_c conf vd true) def.p_out))

  (* declaring variabes *)
  (join ";\n  " (List.map (fun vd -> var_decl_to_c conf vd false) vars))

  (* body *)
  (deqs_to_c lift_env
             (if array then inputs_to_arr def else outputs_to_ptr def)
             (build_env_var def.p_in def.p_out vars) body conf)


let def_to_c (def:def) (array:bool) (conf:config) : string =
  match def.node with
  | Single(vars,body) -> single_to_c def array vars body conf
  | _ -> assert false
