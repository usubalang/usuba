open Prelude
open Usuba_AST

(* TODO: env_const is poorly handled. Fix. *)

let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v

let env_fetch (env : ('a, 'b) Hashtbl.t) (v : 'a) : 'b =
  try Hashtbl.find env v
  with Not_found ->
    raise (Errors.Error (__LOC__ ^ ":Not found: " ^ Ident.name v))

let get_vars_body (node : def_i) : p * deq list =
  match node with
  | Single (vars, body) -> (vars, body)
  | _ -> raise (Errors.Error "Not a Single")

let rename (name : string) : string =
  Str.global_replace (Str.regexp "\\[|\\]") "_"
    (Str.global_replace (Str.regexp "'") "__" name)

let log_op_to_c = function
  | And -> "AND"
  | Or -> "OR"
  | Xor -> "XOR"
  | _ -> assert false

let shift_op_to_c = function
  | Lshift -> "L_SHIFT"
  | Rshift -> "R_SHIFT"
  | RAshift -> "RA_SHIFT"
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

let rec aexpr_to_c (e : arith_expr) : string =
  match Utils.simpl_arith (Ident.Hashtbl.create 100) e with
  | Const_e n -> Format.sprintf "%d" n
  | Var_e x -> rename (Ident.name x)
  | Op_e (op, x, y) ->
      Format.sprintf "(%s %s %s)" (aexpr_to_c x) (arith_op_to_c op)
        (aexpr_to_c y)

let const_to_c (m : mtyp) (n : int) : string =
  match m with
  | Mint 1 | Mint -1 -> (
      match n with
      | 0 -> "SET_ALL_ZERO()"
      | 1 -> "SET_ALL_ONE()"
      | _ -> assert false)
  | _ -> (
      match m with
      | Mint m -> Format.sprintf "LIFT_%d(%d)" m n
      | Mnat -> Format.sprintf "%d" n
      | _ -> assert false)

let var_to_c (lift_env : int VarHashtbl.t) (env : (string, string) Hashtbl.t)
    (v : var) : string =
  let rec aux (v : var) : string =
    match v with
    | Var id -> (
        try Hashtbl.find env (Ident.name id)
        with Not_found -> rename (Ident.name id))
    | Index (v', i) -> Format.sprintf "%s[%s]" (aux v') (aexpr_to_c i)
    | _ -> assert false
  in
  let cvar = aux v in
  match VarHashtbl.find_opt lift_env (Utils.get_var_base v) with
  | Some n -> Format.sprintf "LIFT_%d(%s)" n cvar
  | None -> cvar

let rec expr_to_c (lift_env : int VarHashtbl.t)
    (env : (string, string) Hashtbl.t) (env_var : typ Ident.Hashtbl.t)
    (e : expr) : string =
  match e with
  | Const (n, Some typ) -> const_to_c (Utils.get_type_m typ) n
  | ExpVar v -> var_to_c lift_env env v
  | Arith (op, x, y) -> (
      (* nested arith are allowed (in shifts for instance) *)
      match Utils.get_normed_expr_m env_var e with
      | Mint mval ->
          Format.sprintf "%s(%s,%s,%d)" (arith_op_to_c_generic op)
            (expr_to_c lift_env env env_var x)
            (expr_to_c lift_env env env_var y)
            mval
      | Mnat ->
          Format.sprintf "((%s) %s (%s))"
            (expr_to_c lift_env env env_var x)
            (arith_op_to_c op)
            (expr_to_c lift_env env env_var y)
      | _ -> assert false)
  | _ ->
      raise
        (Errors.Error
           (Format.asprintf "Nested expressions not supported: %a.@."
              (Usuba_print.pp_expr ()) e))

let is_const_expr (env_const : bool Ident.Hashtbl.t) (e : expr) =
  match e with
  | Const _ -> true
  | ExpVar v -> Ident.Hashtbl.mem env_const (Utils.get_base_name v)
  | _ -> false

let expr_to_c_ret (env_const : bool Ident.Hashtbl.t)
    (lift_env : int VarHashtbl.t) (env : (string, string) Hashtbl.t)
    (env_var : typ Ident.Hashtbl.t) (retvar : var) (e : expr) : string =
  let ret = var_to_c lift_env env retvar in
  match e with
  | Const (n, Some typ) ->
      Ident.Hashtbl.replace env_const (Utils.get_base_name retvar) true;
      Format.sprintf "ASGN_CST(%s, %s)" ret
        (const_to_c (Utils.get_type_m typ) n)
  | ExpVar v ->
      if Ident.Hashtbl.mem env_const (Utils.get_base_name v) then
        Ident.Hashtbl.replace env_const (Utils.get_base_name retvar) true;
      Format.sprintf "ASGN(%s,%s)" ret (var_to_c lift_env env v)
  | Not e -> Format.sprintf "NOT(%s,%s)" ret (expr_to_c lift_env env env_var e)
  | Log (op, x, y) ->
      let cst, x, y =
        if is_const_expr env_const y then (true, x, y)
        else if is_const_expr env_const x then (true, y, x)
        else (false, x, y)
      in
      Format.sprintf "%s%s(%s,%s,%s)" (log_op_to_c op)
        (if cst then "_CST" else "")
        ret
        (expr_to_c lift_env env env_var x)
        (expr_to_c lift_env env env_var y)
  | Arith (op, x, y) -> (
      match Utils.get_normed_expr_m env_var e with
      | Mint mval ->
          Format.sprintf "%s(%s,%s,%s,%d)" (arith_op_to_c_generic op) ret
            (expr_to_c lift_env env env_var x)
            (expr_to_c lift_env env env_var y)
            mval
      | Mnat -> Format.sprintf "%s = %s" ret (expr_to_c lift_env env env_var e)
      | _ -> assert false)
  | Shuffle (v, l) ->
      Format.sprintf "%s = PERMUT_%d(%s,%s)" ret (List.length l)
        (var_to_c lift_env env v)
        (Basic_utils.join "," (List.map string_of_int l))
  | Shift (op, e, ae) ->
      Format.sprintf "%s(%s,%s,%s,%d)" (shift_op_to_c op) ret
        (expr_to_c lift_env env env_var e)
        (aexpr_to_c ae)
        (Utils.get_expr_reg_size env_var e)
  | Fun (f, [ v ]) when String.equal (Ident.name f) "rand" ->
      Format.sprintf "%s = RAND();" (expr_to_c lift_env env env_var v)
  | _ ->
      raise
        (Errors.Error
           (Format.asprintf "Wrong expr: %a" (Usuba_print.pp_expr ()) e))

let fun_call_to_c (lift_env : int VarHashtbl.t)
    (env : (string, string) Hashtbl.t) (env_var : typ Ident.Hashtbl.t)
    ?(tabs = "  ") (p : var list) (f : ident) (args : expr list) : string =
  Format.sprintf "%s%s(%s,%s);" tabs
    (rename (Ident.name f))
    (Basic_utils.join "," (List.map (expr_to_c lift_env env env_var) args))
    (Basic_utils.join "," (List.map (fun v -> var_to_c lift_env env v) p))

let rec deqs_to_c (env_const : bool Ident.Hashtbl.t)
    (lift_env : int VarHashtbl.t) (env : (string, string) Hashtbl.t)
    (env_var : typ Ident.Hashtbl.t) ?(tabs = "  ") (deqs : deq list) : string =
  Basic_utils.join "@."
    (List.map
       (fun deq ->
         match deq.content with
         | Eqn ([ vl ], Fun (f, [ vr ]), _)
           when String.equal (Ident.name f) "refresh" ->
             (* No refresh needed if we are not masking *)
             Format.sprintf "%sREFRESH(%s,%s);" tabs (var_to_c lift_env env vl)
               (expr_to_c lift_env env env_var vr)
         | Eqn (p, Fun (f, l), _) ->
             fun_call_to_c lift_env env env_var ~tabs p f l
         | Eqn ([ v ], e, _) -> (
             match Utils.get_var_m env_var v with
             | Mnat ->
                 Format.sprintf "%s%s = %s;" tabs (var_to_c lift_env env v)
                   (expr_to_c lift_env env env_var e)
             | _ ->
                 Format.sprintf "%s%s;" tabs
                   (expr_to_c_ret env_const lift_env env env_var v e))
         | Loop { id; start; stop; body; _ } ->
             Format.sprintf "%sfor (int %s = %s; %s <= %s; %s++) {@.%s@.%s}"
               tabs
               (rename (Ident.name id))
               (aexpr_to_c start)
               (rename (Ident.name id))
               (aexpr_to_c stop)
               (rename (Ident.name id))
               (deqs_to_c env_const lift_env env env_var ~tabs:(tabs ^ "  ")
                  body)
               tabs
         | _ ->
             Format.eprintf "%a@." (Usuba_print.pp_deq ()) deq;
             assert false)
       deqs)

let rec gen_list_typ (x : string) (typ : typ) : string list =
  match typ with
  | Uint (_, _, n) -> List.map (Format.sprintf "%s'") (Utils.gen_list0 x n)
  | Array (t', n) ->
      List.flatten
      @@ List.map
           (fun x -> gen_list_typ x t')
           (List.map (Format.sprintf "%s'")
              (Utils.gen_list0 x (Utils.eval_arith_ne n)))
  | _ -> assert false

let inputs_to_arr (def : def) : (string, string) Hashtbl.t =
  let inputs = make_env () in
  let aux (marker : string) vd =
    let id = Ident.name vd.vd_id in
    match vd.vd_typ with
    | Nat -> Hashtbl.add inputs id (Format.sprintf "%s%s" marker (rename id))
    (* Hard-coding the case ukxn[m] for now *)
    | Array (Uint (_, _, n), size) ->
        List.iteri
          (fun i x ->
            List.iteri
              (fun j y ->
                Hashtbl.add inputs (Format.sprintf "%s'" y)
                  (Format.sprintf "%s[%d][%d]" (rename id) i j))
              (Utils.gen_list0 (Format.sprintf "%s'" x) n))
          (Utils.gen_list0 id (Utils.eval_arith_ne size))
    | Uint (_, _, 1) ->
        Hashtbl.add inputs id (Format.sprintf "%s%s" marker (rename id))
    | Uint (_, _, n) ->
        List.iter2
          (fun x y ->
            Hashtbl.add inputs (Format.sprintf "%s'" x)
              (Format.sprintf "%s[%d]" (rename id) y))
          (Utils.gen_list0 id n) (Utils.gen_list_0_int n)
    | Array (t, n) ->
        let size = Utils.typ_size t in
        List.iter2
          (fun x y ->
            Hashtbl.add inputs x (Format.sprintf "%s[%d]" (rename id) y))
          (gen_list_typ id vd.vd_typ)
          (Utils.gen_list_0_int (size * Utils.eval_arith_ne n))
  in

  List.iter (aux "") def.p_in;
  List.iter (aux "") def.p_out;
  inputs

let gen_intn (n : int) : string =
  match n with
  | 16 -> "uint16_t"
  | 32 -> "uint32_t"
  | 64 -> "uint64_t"
  | _ ->
      Format.eprintf "Can't generate native %d bits integer." n;
      assert false

let get_lift_size (vd : var_d) : int =
  match Utils.get_base_type vd.vd_typ with
  | Uint (_, Mint i, _) -> i
  | _ ->
      Format.eprintf "Invalid lazy lift with type '%a'.@."
        (Usuba_print.pp_typ ()) vd.vd_typ;
      assert false

let var_decl_to_c conf (vd : var_d) (_ : bool) : string =
  (* x : Array(Int(_,m),k) should become x[k][m] and not x[m][k]
     that's the role of this "start" parameter *)
  let rec aux (id : ident) (typ : typ) start =
    match typ with
    | Nat -> rename (Ident.name id) ^ start
    | Uint (_, _, 1) -> rename (Ident.name id) ^ start
    | Uint (_, _, n) ->
        Format.sprintf "%s%s[%d]" (rename (Ident.name id)) start n
    | Array (typ, size) ->
        aux id typ (Format.sprintf "%s[%s]" start (aexpr_to_c size))
  in
  let vname = aux vd.vd_id vd.vd_typ "" in
  let vtype =
    if conf.Config.lazylift && Utils.is_const vd then
      gen_intn (get_lift_size vd)
    else "DATATYPE"
  in
  match Utils.get_type_m vd.vd_typ with
  | Mnat -> Format.sprintf "unsigned int %s" vname
  | _ -> Format.sprintf "%s %s[MASKING_ORDER]" vtype vname

let c_header (arch : Config.arch) : string =
  match arch with
  | Std -> "MASKED.h"
  | MMX -> "MMX.h"
  | SSE -> "SSE.h"
  | AVX -> "AVX.h"
  | AVX512 -> "AVX512.h"
  | Neon -> "Neon.h"
  | AltiVec -> "AltiVec.h"

let single_to_c (def : def) (array : bool) (vars : p) (body : deq list)
    (conf : Config.config) : string =
  let env_const = Ident.Hashtbl.create 10 in
  List.iter
    (fun vd ->
      if Utils.is_const vd then Ident.Hashtbl.add env_const vd.vd_id true)
    def.p_in;
  List.iter
    (fun vd ->
      if Utils.is_const vd then Ident.Hashtbl.add env_const vd.vd_id true)
    vars;
  let lift_env = VarHashtbl.create 100 in
  if conf.lazylift then
    List.iter
      (fun vd ->
        if Utils.is_const vd then
          VarHashtbl.add lift_env (Var vd.vd_id) (get_lift_size vd))
      def.p_in;

  Format.sprintf
    "void %s (/*inputs*/ %s, /*outputs*/ %s) {@.@.  // Variables \
     declaration@.  %s;@.@.  // Instructions (body)@.%s@.@.}"
    (* Node name *)
    (rename (Ident.name def.id))
    (* Parameters *)
    (Basic_utils.join ","
       (List.map (fun vd -> var_decl_to_c conf vd false) def.p_in))
    (Basic_utils.join ","
       (List.map (fun vd -> var_decl_to_c conf vd true) def.p_out))
    (* declaring variabes *)
    (Basic_utils.join ";@.  "
       (List.map (fun vd -> var_decl_to_c conf vd false) vars))
    (* body *)
    (deqs_to_c env_const lift_env
       (if array then inputs_to_arr def else make_env ())
       (Utils.build_env_var def.p_in def.p_out vars)
       body)

let def_to_c (def : def) (array : bool) (conf : Config.config) : string =
  match def.node with
  | Single (vars, body) -> single_to_c def array vars body conf
  | _ -> assert false

let gen_bench (node : def) (conf : Config.config) : string =
  Format.sprintf
    "uint32_t bench_speed() {@.  /* inputs */@.  %s@.@.  /* Preventing inputs \
     from being optimized out */@.  %s@.@.  /* outputs */@.  %s@.  /* \
     Primitive call */@.  %s(%s,%s);@.@.  /* Preventing outputs from being \
     optimized out */@.  %s@.@.  /* Returning the number of encrypted bytes \
     */@.  return %d;@.}"
    (* inputs *)
    (Basic_utils.join "@.  "
       (List.map
          (fun s -> s ^ " = { 0 };")
          (List.map (fun vd -> var_decl_to_c conf vd false) node.p_in)))
    (Basic_utils.join "@.  "
       (List.map
          (fun vd ->
            let modifier =
              match vd.vd_typ with Uint (_, _, 1) -> "r" | _ -> "m"
            in
            Format.sprintf "asm volatile(\"\" : \"+%s\" (%s));" modifier
              (rename (Ident.name vd.vd_id)))
          node.p_in))
    (* outputs *)
    (Basic_utils.join "@.  "
       (List.map
          (fun s -> s ^ " = { 0 };")
          (List.map (fun vd -> var_decl_to_c conf vd true) node.p_out)))
    (* node call *)
    (rename (Ident.name node.id))
    (* node inputs *)
    (Basic_utils.join ", "
       (List.map (fun vd -> rename (Ident.name vd.vd_id)) node.p_in))
    (* node outputs *)
    (Basic_utils.join ", "
       (List.map
          (fun vd ->
            match vd.vd_typ with
            | Nat | Uint (_, _, 1) -> "&" ^ rename (Ident.name vd.vd_id)
            | _ -> rename (Ident.name vd.vd_id))
          node.p_out))
    (* keeping outputs alive *)
    (Basic_utils.join "@.  "
       (List.map
          (fun vd ->
            Format.sprintf "asm volatile(\"\" : \"+m\" (%s));"
              (rename (Ident.name vd.vd_id)))
          node.p_out))
    (* returning number of encrypted bytes *)
    (List.fold_left
       (fun sum vd -> sum + Nodes_to_c.get_typ_size conf vd.vd_typ)
       0 node.p_out
    / 8)
