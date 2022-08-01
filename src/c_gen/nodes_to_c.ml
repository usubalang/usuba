open Prelude
open Usuba_AST

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
  Str.global_replace (Str.regexp "\\[\\|\\]") "_"
    (Str.global_replace (Str.regexp "'") "__" name)

let log_op_to_c = function
  | And -> "AND"
  | Or -> "OR"
  | Xor -> "XOR"
  | Andn -> "ANDN"
  | Masked _ -> assert false

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

let ret_var_to_c (lift_env : int VarHashtbl.t)
    (env : (string, string) Hashtbl.t) (env_var : typ Ident.Hashtbl.t) (v : var)
    : string =
  match Utils.get_var_type env_var v with
  | Uint (_, _, 1) -> "&" ^ var_to_c lift_env env v
  | Array _ | Uint _ -> var_to_c lift_env env v
  | _ -> assert false

let const_to_c (m : mtyp) (n : int) : string =
  match m with
  | Mint 1 | Mint -1 -> (
      match n with
      | 0 -> "SET_ALL_ZERO()"
      | 1 -> "SET_ALL_ONE()"
      | _ -> assert false)
  | _ -> (
      match m with
      | Mint m -> Format.sprintf "LIFT_%d(0x%x)" m n
      | Mnat -> Format.sprintf "0x%x" n
      | _ -> assert false)

let rec expr_to_c (m : mtyp) (lift_env : int VarHashtbl.t)
    (env : (string, string) Hashtbl.t) (env_var : typ Ident.Hashtbl.t)
    (e : expr) : string =
  match e with
  | Const (n, _) -> const_to_c m n
  | ExpVar v -> var_to_c lift_env env v
  | Not e -> Format.sprintf "NOT(%s)" (expr_to_c m lift_env env env_var e)
  | Log (op, x, y) ->
      Format.sprintf "%s(%s,%s)" (log_op_to_c op)
        (expr_to_c m lift_env env env_var x)
        (expr_to_c m lift_env env env_var y)
  | Arith (op, x, y) -> (
      match m with
      | Mint mval ->
          Format.sprintf "%s(%s,%s,%d)" (arith_op_to_c_generic op)
            (expr_to_c m lift_env env env_var x)
            (expr_to_c m lift_env env env_var y)
            mval
      | Mnat ->
          Format.sprintf "((%s) %s (%s))"
            (expr_to_c m lift_env env env_var x)
            (arith_op_to_c op)
            (expr_to_c m lift_env env env_var y)
      | _ -> assert false)
  | Shuffle (v, l) ->
      Format.sprintf "PERMUT_%d(%s,%s)" (List.length l)
        (var_to_c lift_env env v)
        (Basic_utils.join "," (List.map string_of_int l))
  | Bitmask (e', ae) ->
      Format.sprintf "BITMASK(%s, %s, %d)"
        (expr_to_c m lift_env env env_var e')
        (aexpr_to_c ae)
        (match m with Mint m_val -> m_val | _ -> assert false)
  | Pack (e1, e2, Some _) ->
      let args_m = Utils.get_type_m (Utils.get_normed_expr_type env_var e1) in
      Format.sprintf "PACK_%dx2_to_%d(%s,%s)"
        (match args_m with Mint m_val -> m_val | _ -> assert false)
        (match m with Mint m_val -> m_val | _ -> assert false)
        (expr_to_c args_m lift_env env env_var e1)
        (expr_to_c args_m lift_env env env_var e2)
  | Shift (op, e, ae) ->
      Format.sprintf "%s(%s,%s,%d)" (shift_op_to_c op)
        (expr_to_c m lift_env env env_var e)
        (aexpr_to_c ae)
        (Utils.get_expr_reg_size env_var e)
  | Fun (f, [ v ]) when String.equal (Ident.name f) "rand" ->
      Format.sprintf "%s = RAND();" (expr_to_c m lift_env env env_var v)
  | _ ->
      raise
        (Errors.Error
           (Format.asprintf "Wrong expr: %a" (Usuba_print.pp_expr ()) e))

let fun_call_to_c (lift_env : int VarHashtbl.t)
    (env : (string, string) Hashtbl.t) (env_var : typ Ident.Hashtbl.t)
    ?(tabs = "  ") (p : var list) (f : ident) (args : expr list) : string =
  Format.sprintf "%s%s(%s,%s);" tabs
    (rename (Ident.name f))
    (Basic_utils.join "," (List.map (expr_to_c Mnat lift_env env env_var) args))
    (* ^^^^ this "m" value is ignored *)
    (Basic_utils.join ","
       (List.map (fun v -> ret_var_to_c lift_env env env_var v) p))

let rec deqs_to_c (lift_env : int VarHashtbl.t)
    (env : (string, string) Hashtbl.t) (env_var : typ Ident.Hashtbl.t)
    ?(tabs = "  ") (deqs : deq list) : string =
  Basic_utils.join "\n"
    (List.map
       (fun deq ->
         match deq.content with
         | Eqn ([ v ], Fun (f, []), _) when String.equal (Ident.name f) "rand"
           ->
             Format.sprintf "%s%s = RAND();" tabs (var_to_c lift_env env v)
         | Eqn ([ vl ], Fun (f, [ vr ]), _)
           when String.equal (Ident.name f) "refresh" ->
             (* No refresh needed if we are not masking *)
             Format.sprintf "%s%s = %s;" tabs (var_to_c lift_env env vl)
               (expr_to_c
                  (Utils.get_type_m (Utils.get_var_type env_var vl))
                  lift_env env env_var vr)
         | Eqn (p, Fun (f, l), _) ->
             fun_call_to_c lift_env env env_var ~tabs p f l
         | Eqn ([ v ], e, _) ->
             let m = Utils.get_type_m (Utils.get_var_type env_var v) in
             Format.sprintf "%s%s = %s;" tabs (var_to_c lift_env env v)
               (expr_to_c m lift_env env env_var e)
         | Loop (i, ei, ef, l, _) ->
             Format.sprintf "%sfor (int %s = %s; %s <= %s; %s++) {\n%s\n%s}"
               tabs
               (rename (Ident.name i))
               (aexpr_to_c ei)
               (rename (Ident.name i))
               (aexpr_to_c ef)
               (rename (Ident.name i))
               (deqs_to_c lift_env env env_var ~tabs:(tabs ^ "  ") l)
               tabs
         | _ ->
             Format.eprintf "%a@." (Usuba_print.pp_deq ()) deq;
             assert false)
       deqs)

let params_to_arr (params : p) (marker : string) : string list =
  let rec typ_to_arr typ l =
    match typ with
    | Uint (_, _, 1) -> l
    | Uint (_, _, n) -> l @ [ Format.sprintf "[%d]" n ]
    | Array (t, n) -> typ_to_arr t (Format.sprintf "[%s]" (aexpr_to_c n) :: l)
    | _ -> raise (Errors.Not_implemented "Invalid input")
  in
  List.map
    (fun vd ->
      match vd.vd_typ with
      | Uint (_, _, 1) -> Format.asprintf "%s%a" marker (Ident.pp ()) vd.vd_id
      | _ ->
          Format.asprintf "%a%s" (Ident.pp ()) vd.vd_id
            (Basic_utils.join "" (typ_to_arr vd.vd_typ [])))
    params

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
  List.iter (aux "*") def.p_out;
  inputs

let outputs_to_ptr (def : def) : (string, string) Hashtbl.t =
  let outputs = make_env () in
  List.iter
    (fun vd ->
      let id = Ident.name vd.vd_id in
      match vd.vd_typ with
      | Uint (_, _, 1) -> env_add outputs id ("*" ^ rename id)
      | _ -> ())
    def.p_out;
  outputs

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

let var_decl_to_c conf (vd : var_d) (out : bool) : string =
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
    else match Utils.get_type_m vd.vd_typ with Mnat -> "int" | _ -> "DATATYPE"
  in
  let pointer =
    match out with
    | false -> ""
    | true -> ( match vd.vd_typ with Uint (_, _, 1) -> "*" | _ -> "")
  in
  Format.sprintf "%s%s %s" vtype pointer vname

let c_header (arch : Config.arch) : string =
  match arch with
  | Std -> "STD.h"
  | MMX -> "MMX.h"
  | SSE -> "SSE.h"
  | AVX -> "AVX.h"
  | AVX512 -> "AVX512.h"
  | Neon -> "Neon.h"
  | AltiVec -> "AltiVec.h"

let single_to_c (def : def) (array : bool) (vars : p) (body : deq list)
    (conf : Config.config) : string =
  let lift_env = VarHashtbl.create 100 in
  if conf.lazylift then
    List.iter
      (fun vd ->
        if Utils.is_const vd then
          VarHashtbl.add lift_env (Var vd.vd_id) (get_lift_size vd))
      def.p_in;

  Format.sprintf
    "void %s (/*inputs*/ %s, /*outputs*/ %s) {\n\n\
    \  // Variables declaration\n\
    \  %s;\n\n\
    \  // Instructions (body)\n\
     %s\n\n\
     }"
    (* Node name *)
    (rename (Ident.name def.id))
    (* Parameters *)
    (Basic_utils.join ","
       (List.map (fun vd -> var_decl_to_c conf vd false) def.p_in))
    (Basic_utils.join ","
       (List.map (fun vd -> var_decl_to_c conf vd true) def.p_out))
    (* declaring variabes *)
    (Basic_utils.join ";\n  "
       (List.map (fun vd -> var_decl_to_c conf vd false) vars))
    (* body *)
    (deqs_to_c lift_env
       (if array then inputs_to_arr def else outputs_to_ptr def)
       (Utils.build_env_var def.p_in def.p_out vars)
       body)

(* A table is converted into a function that contains the lookup table
   (static const). The functions performs the lookup. It's necessary
   because a Table is called like any other function, and thus only
   generating a lookup table would result into function-like calls (ie
   f(...)) to a table which should rather be indexed a f[...]). *)
let table_to_c (def : def) (l : int list) (conf : Config.config) : string =
  assert (List.length def.p_in == 1);
  assert (List.length def.p_out == 1);

  Format.sprintf
    "void %s (/*inputs*/ %s, /*outputs*/ %s) {\n\
    \   static const DATATYPE t[%d] = { %s };\n\
    \   *%s = t[%s];\n\
     }"
    (* Table name *)
    (rename (Ident.name def.id))
    (* Parameters *)
    (Basic_utils.join ","
       (List.map (fun vd -> var_decl_to_c conf vd false) def.p_in))
    (Basic_utils.join ","
       (List.map (fun vd -> var_decl_to_c conf vd true) def.p_out))
    (* Table size *)
    (List.length l)
    (* Table content *)
    (Basic_utils.join "," (List.map string_of_int l))
    (* Return value *)
    (rename (Ident.name (List.hd def.p_out).vd_id))
    (* Index in the table *)
    (rename (Ident.name (List.hd def.p_in).vd_id))

let def_to_c (def : def) (array : bool) (conf : Config.config) : string =
  match def.node with
  | Single (vars, body) -> single_to_c def array vars body conf
  | Table l -> table_to_c def l conf
  | _ -> assert false

let rec get_typ_size (conf : Config.config) (typ : typ) : int =
  match typ with
  | Array (t, s) ->
      if equal_arith_expr s (Var_e Mask.masking_order) then get_typ_size conf t
      else get_typ_size conf t * Utils.eval_arith_ne s
  | Uint (dir, Mint m, n) -> (
      n * m
      *
      match conf.archi with
      | Std -> ( match dir with Bslice -> conf.bits_per_reg | _ -> 1)
      | _ -> conf.bits_per_reg / m)
  | Nat ->
      Format.eprintf "Can't get_typ_size(Nat).@.";
      assert false
  | Uint (_, _, _) ->
      Format.eprintf "Can't get_typ_size(%a).@." (Usuba_print.pp_typ ()) typ;
      assert false

let gen_bench (node : def) (conf : Config.config) : string =
  Format.sprintf
    "uint32_t bench_speed() {\n\
    \  /* Inputs */\n\
    \  %s\n\n\
    \  /* Preventing inputs from being optimized out */\n\
    \  %s\n\n\
    \  /* Outputs */\n\
    \  %s\n\
    \  /* Primitive call */\n\
    \  %s(%s,%s);\n\n\
    \  /* Preventing outputs from being optimized out */\n\
    \  %s\n\n\
    \  /* Returning the number of encrypted bytes */\n\
    \  return %d;\n\
     }"
    (* inputs *)
    (Basic_utils.join "\n  "
       (List.map
          (fun s -> s ^ ";")
          (List.map (fun vd -> var_decl_to_c conf vd false) node.p_in)))
    (Basic_utils.join "\n  "
       (List.map
          (fun vd ->
            let modifier =
              match vd.vd_typ with Uint (_, _, 1) -> "r" | _ -> "m"
            in
            Format.sprintf "asm volatile(\"\" : \"+%s\" (%s));" modifier
              (rename (Ident.name vd.vd_id)))
          node.p_in))
    (* outputs *)
    (Basic_utils.join "\n  "
       (List.map
          (fun s -> s ^ ";")
          (List.map (fun vd -> var_decl_to_c conf vd true) node.p_out)))
    (* node call *)
    (rename (Ident.name node.id))
    (*   node inputs *)
    (Basic_utils.join ", "
       (List.map (fun vd -> rename (Ident.name vd.vd_id)) node.p_in))
    (*   node outputs *)
    (Basic_utils.join ", "
       (List.map
          (fun vd ->
            match vd.vd_typ with
            | Nat | Uint (_, _, 1) -> "&" ^ rename (Ident.name vd.vd_id)
            | _ -> rename (Ident.name vd.vd_id))
          node.p_out))
    (* keeping outputs alive *)
    (Basic_utils.join "\n  "
       (List.map
          (fun vd ->
            Format.sprintf "asm volatile(\"\" : \"+m\" (%s));"
              (rename (Ident.name vd.vd_id)))
          node.p_out))
    (* returning number of encrypted bytes *)
    (List.fold_left
       (fun sum vd -> sum + get_typ_size conf vd.vd_typ)
       0 node.p_out
    / 8)
