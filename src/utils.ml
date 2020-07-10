open Usuba_AST
open Basic_utils

exception Invalid_AST of string
exception Error of string
exception Syntax_error
exception Not_implemented of string
exception Empty_list
exception Undeclared of ident
exception Invalid_param_size
exception Invalid_operator_call
exception Break
exception Skip

let default_conf : config =
  { warnings       = true;
    verbose        = 1;
    path           = [ "." ];
    type_check     = true;
    check_tbl      = false;
    auto_inline    = true;
    light_inline   = false;
    no_inline      = false;
    inline_all     = false;
    heavy_inline   = false;
    compact_mono   = true;
    fold_const     = true;
    cse            = true;
    copy_prop      = true;
    loop_fusion    = true;
    pre_schedule   = true;
    scheduling     = true;
    schedule_n     = 10;
    share_var      = false;
    linearize_arr  = true;
    precal_tbl     = true;
    archi          = Std;
    bits_per_reg   = 64;
    no_arr         = false;
    arr_entry      = true;
    unroll         = false;
    interleave     = 0;
    inter_factor   = 0;
    fdti           = "";
    lazylift       = false;
    slicing_set    = false;
    slicing_type   = B;
    m_set          = false;
    m_val          = 1;
    tightPROVE     = false;
    tightprove_dir = "tightprove";
    maskVerif      = false;
    masked         = false;
    ua_masked      = false;
    shares         = 1;
    gen_bench      = false;
    keep_tables    = false;
    compact        = false;
    bench_inline   = false;
    bench_inter    = false;
    bench_bitsched = false;
    bench_msched   = false;
    bench_sharevar = false;
  }

let default_dir = Varslice { uid = -1; name = "D" }
let default_m   = Mvar     { uid = -1; name = "m" }

let bool = Uint(Bslice, Mint 1, 1)

let make_env () = Hashtbl.create 100
let env_add env v e = Hashtbl.replace env v e
let env_update env v e = Hashtbl.replace env v e
let env_remove env v = Hashtbl.remove env v
let env_fetch env v = try Hashtbl.find env v
                      with Not_found -> raise (Error (__LOC__ ^ ":Not found: " ^ v.name))


let rec eval_arith env (e:Usuba_AST.arith_expr) : int =
  match e with
  | Const_e n -> n
  | Var_e id  -> Hashtbl.find env id
  | Op_e(op,x,y) -> let x' = eval_arith env x in
                    let y' = eval_arith env y in
                    match op with
                    | Add -> x' + y'
                    | Mul -> x' * y'
                    | Sub -> x' - y'
                    | Div -> x' / y'
                    | Mod -> if x' >= 0 then x' mod y' else y' + (x' mod y')

let eval_arith_ne (e:Usuba_AST.arith_expr) : int =
  eval_arith (Hashtbl.create 100) e

(* Evaluates the arithmetic expression as much as possible: if the variables are
in the environment, then replaces them by their values, otherwise let them as is. *)
let rec simpl_arith (env:(ident,int) Hashtbl.t) (e: arith_expr) : arith_expr =
  match e with
  | Const_e n -> e
  | Var_e id  -> (try Const_e (Hashtbl.find env id)
                  with Not_found -> Var_e id)
  | Op_e(op,x,y) -> let x' = simpl_arith env x in
                    let y' = simpl_arith env y in
                    match x', y' with
                    | Const_e n1, Const_e n2 ->
                       Const_e (match op with
                                | Add -> n1 + n2
                                | Mul -> n1 * n2
                                | Sub -> n1 - n2
                                | Div -> n1 / n2
                                | Mod -> if n1 >= 0 then n1 mod n2 else n2 + (n1 mod n2))
                    | _ -> Op_e(op,x',y')
let simpl_arith_ne (e:arith_expr) : arith_expr =
  simpl_arith (Hashtbl.create 100) e


let fresh_ident (name: string): ident =
  (* XXX: glue code, not actually maintaining a freshness of uid *)
  { uid = -1 ; name = name }

let fresh_suffix (id: ident)(suff: string): ident =
  fresh_ident (id.name ^ suff)

let fresh_prefix (pref: string)(id: ident): ident =
  fresh_ident (pref ^ id.name)

let fresh_concat (x: ident)(y: ident): ident =
  fresh_ident (x.name ^ y.name)

let gen_list (id: string) (n: int) : string list =
  let rec aux n acc =
    if n <= 0 then acc
    else aux (n-1) ((id ^ (string_of_int n))::acc)
  in aux n []
let gen_list0 (id: string) (n: int) : string list =
  let rec aux n acc =
    if n <= 0 then acc
    else aux (n-1) ((id ^ (string_of_int (n-1)))::acc)
  in aux n []

let gen_list_0 (id: ident) (n: int) : ident list =
  let rec aux n acc =
    if n <= 0 then acc
    else aux (n-1) (fresh_suffix id (string_of_int (n-1))::acc)
  in aux n []

let gen_list_int (n: int) : int list =
  let rec aux n acc =
    if n <= 0 then acc
    else aux (n-1) (n :: acc)
  in aux n []

let gen_list_0_int (n: int) : int list =
  let rec aux n acc =
    if n <= 0 then acc
    else aux (n-1) ((n-1) :: acc)
  in aux n []

let make_var_d (id:ident) (typ:typ)
               (opts:var_d_opt list) (orig:(ident*var_d) list) : var_d =
  { vd_id   = id;
    vd_typ  = typ;
    vd_opts = opts;
    vd_orig = orig }

let simple_var_d (id:ident) = make_var_d id bool [] []
let simple_typed_var_d (id:ident) (typ:typ) = make_var_d id typ [] []

let env_fetch env v =
  (* try *)
    Hashtbl.find env v
  (* with Not_found -> Printf.fprintf stderr "Not found: %s.\n" v.name; *)
  (*                   assert false *)


(* Constructs a map { fun : def } *)
let build_env_fun (nodes:def list) : (ident,def) Hashtbl.t =
  let env_fun = Hashtbl.create 20 in
  List.iter (fun d -> Hashtbl.add env_fun d.id d) nodes;
  env_fun


(* Constructs a map { variables : types } *)
let build_env_var (p_in:p) (p_out:p) (vars:p) : (ident, typ) Hashtbl.t =
  let env = Hashtbl.create 20 in

  let add_to_env (vd:var_d) : unit =
    Hashtbl.replace env vd.vd_id vd.vd_typ in

  List.iter add_to_env p_in;
  List.iter add_to_env p_out;
  List.iter add_to_env vars;

  env

let rec typ_size ?(env=Hashtbl.create 10) (t:typ) : int =
  match t with
  | Uint(_,_,n) -> n
  | Array(t',s) -> (typ_size ~env:env t') * (eval_arith env s)
  | Nat -> 1

let rec reg_size (t:typ) : int =
  match t with
  | Uint(_,Mint i,1) -> i
  | _ -> Printf.fprintf stderr "Non linear type `%s', can't get reg_size.\n"
                        (Usuba_print.typ_to_str t);
         assert false


let elem_size (t:typ) : int =
  match t with
  | Array(t',_) -> typ_size t'
  | _ -> assert false

let rec get_var_type env (v:var) : typ =
  match v with
  | Var x -> env_fetch env x
  | Index(v',_) -> (match get_var_type env v' with
                    | Array(t,_) -> t
                    | Uint(dir,m,n) when n > 1 -> Uint(dir,m,1)
                    | Uint(dir,m,1) -> Uint(dir,Mint 1,1)
                    | _ -> assert false)
  | _ -> Printf.fprintf stderr "Error: get_var_type(%s)\n" (Usuba_print.var_to_str v);
         assert false
(* Shadowing the above def to add error treatment *)
let get_var_type env (v:var) : typ =
  try get_var_type env v with
    Not_found -> Printf.fprintf stderr "Error: get_var_type(%s): not found\n"
                                (Usuba_print.var_to_str v);
                 raise Not_found

let get_var_size env (v:var) : int =
  typ_size @@ get_var_type env v

let rec get_expr_size env (e:expr) : int =
  match e with
  | Const _ -> 1
  | ExpVar v -> get_var_size env v
  | Tuple l -> List.fold_left (+) 0 (List.map (get_expr_size env) l)
  | Not e -> get_expr_size env e
  | Shift(_,e,_) -> get_expr_size env e
  | Log(_,e,_) -> get_expr_size env e
  | Shuffle(v,_) -> get_var_size env v
  | Arith(_,e,_) -> get_expr_size env e
  | Fun _ -> Printf.fprintf stderr "Not implemented yet, get_expr_size(Fun...).\n";
             assert false
  | _ -> assert false


let get_reg_size env (v:var) : int =
  reg_size @@ get_var_type env v

let rec get_expr_reg_size env (e:expr) : int =
  match e with
  | Const(n,None) -> Printf.fprintf stderr "Unsafe inference of `Const %d' size.\n" n;
                     1
  | Const(n,Some typ) -> reg_size typ
  | ExpVar v -> get_reg_size env v
  | Not e -> get_expr_reg_size env e
  | Shift(_,e,_) -> get_expr_reg_size env e
  | Log(_,e,_) -> get_expr_reg_size env e
  | Shuffle(v,_) -> get_reg_size env v
  | Arith(_,e,_) -> get_expr_reg_size env e
  | Fun _ -> Printf.fprintf stderr "Not implemented yet, get_reg_size(Fun...).\n";
             assert false
  | Tuple l -> Printf.fprintf stderr "Non linear expression Tuple(%s), can't get reg_size.\n"
                              (Usuba_print.expr_to_str_l l);
               assert false

  | _ -> assert false

let rec get_expr_type env_fun env_var (e:expr) : typ list =
  match e with
  | Const(n,None) -> Printf.fprintf stderr "Unsafe inference of `Const %d' type.\n" n;
                     [ Nat ]
  | Const(n,Some typ) -> [ typ ]
  | ExpVar v -> [ get_var_type env_var v ]
  | Tuple l -> flat_map (get_expr_type env_fun env_var) l
  | Not e -> get_expr_type env_fun env_var e
  | Shift(_,e,_) -> get_expr_type env_fun env_var e
  | Log(_,e,_) -> get_expr_type env_fun env_var e
  | Shuffle(v,_) -> [ get_var_type env_var v ]
  | Arith(_,e,_) -> get_expr_type env_fun env_var e
  | Fun(f,_) ->
     if f.name = "rand" then [ Uint(default_dir,Mint 1,1) ]
     else
       let def = Hashtbl.find env_fun f in
       List.map (fun vd -> vd.vd_typ) def.p_out
  | _ -> assert false

let rec get_normed_expr_type env_var (e:expr) : typ =
  match e with
  | Const(n,Some typ) -> typ
  | ExpVar v -> get_var_type env_var v
  | Not e -> get_normed_expr_type env_var e
  | Shift(_,e,_) -> get_normed_expr_type env_var e
  | Log(_,e,_) -> get_normed_expr_type env_var e
  | Shuffle(v,_) -> get_var_type env_var v
  | Arith(_,e,_) -> get_normed_expr_type env_var e
  | _ -> Printf.eprintf "get_normed_expr_type: error: unnormed expr: %s.\n"
           (Usuba_print.expr_to_str e);
         assert false

(* Expands a typ into a list of basic (umx1) types *)
let rec expand_typ (typ:typ) : typ list =
  match typ with
  | Nat -> [ Nat ]
  | Uint(d,m,n) -> List.map (fun _ -> Uint(d,m,1))  (gen_list_int n)
  | Array(t, n) -> flat_map (fun _ -> expand_typ t) (gen_list_int (eval_arith_ne n))

let rec expand_var env_var ?(env_it=Hashtbl.create 100) ?(bitslice=false) ?(partial=false) (v:var) : var list =
  let typ = get_var_type env_var v in
  match typ with
  | Nat -> [ v ]
  | Uint(_,Mint m,1) when m > 1 ->
     if bitslice then
       List.map (fun i -> Index(v, Const_e i)) (gen_list_0_int m)
     else [ v ]
  | Uint(_,_,1) -> [ v ]
  | Uint(_,_,n) -> flat_map (fun i -> expand_var env_var ~env_it:env_it
                                                 ~bitslice:bitslice ~partial:partial
                                                 (Index(v,Const_e i))) (gen_list_0_int n)
  | Array(_,s)  ->
     if partial then
       List.map (fun i -> Index(v,Const_e i))
                (gen_list_0_int (eval_arith env_it s))
     else
       flat_map (fun i -> expand_var env_var ~env_it:env_it
                                     ~bitslice:bitslice
                                     (Index(v,Const_e i)))
                (gen_list_0_int (eval_arith env_it s))

let rec expand_var_partial env_var ?(env_it=Hashtbl.create 100) (v:var) : var list =
  expand_var env_var ~env_it:env_it ~partial:true v

let expand_vd (vd:var_d) : var list =
  expand_var (build_env_var [vd] [] []) (Var vd.vd_id)

(* Returns the base variable of a variable (ie, remove ranges/slices/index) *)
let rec get_var_base (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v,_) | Slice(v,_) | Range(v,_,_) -> get_var_base v

(* Returns the base name of a variable *)
let rec get_base_name (v:var) : ident =
  match v with
  | Var x -> x
  | Index(v,_) | Slice(v,_) | Range(v,_,_) -> get_base_name v

let rec replace_base (v:var) (id:ident) : var =
  match v with
  | Var x             -> Var id
  | Index(v',idx)     -> Index(replace_base v' id,idx)
  | Range(v',aei,aef) -> Range(replace_base v' id,aei,aef)
  | Slice(v',l)       -> Slice(replace_base v' id,l)

let rec replace_m (typ:typ) (m:mtyp) : typ =
  match typ with
  | Uint(dir,_,n) -> Uint(dir,m,n)
  | Array(t,size) -> Array(replace_m t m,size)
  | Nat -> Nat

(* TODO: make this function return Uint(dir,m,n) instead of Uint(dir,m,1) ? *)
let rec get_base_type (typ:typ) : typ =
  match typ with
  | Uint(dir,m,_) ->  Uint(dir,m,1)
  | Array(t,_) -> get_base_type t
  | Nat -> Nat

let get_type_dir (typ:typ) : dir =
  match get_base_type typ with
  | Uint(dir,_,_) -> dir
  | Nat -> Natdir
  | _ -> assert false
let get_type_m (typ:typ) : mtyp =
  match get_base_type typ with
  | Uint(_,m,_) -> m
  | Nat -> Mnat
  | _ -> assert false


let get_var_dir env_var (v:var) : dir =
  get_type_dir (get_var_type env_var v)
let get_var_m env_var (v:var) : mtyp =
  get_type_m (get_var_type env_var v)

let get_normed_expr_dir env_var (e:expr) : dir =
  get_type_dir (get_normed_expr_type env_var e)
let get_normed_expr_m env_var (e:expr) : mtyp =
  get_type_m (get_normed_expr_type env_var e)

let rec update_type_dir (typ:typ) (dir:dir) : typ =
  match typ with
  | Uint(_,m,n) -> Uint(dir,m,n)
  | Array(t,n)  -> Array(update_type_dir t dir,n)
  | Nat         -> Nat
let rec update_type_m (typ:typ) (m:mtyp) : typ =
  match typ with
  | Uint(dir,_,n) -> Uint(dir,m,n)
  | Array(t,n)    -> Array(update_type_m t m,n)
  | Nat           -> Nat

let vd_to_var (vd:var_d) : var =
  Var vd.vd_id

let p_to_vars (p:p) : var list =
  List.map vd_to_var p

let env_fetch (env: ('b, 'a) Hashtbl.t) (id: ident) : 'a option =
  try
    let v = Hashtbl.find env id.name in Some v
  with Not_found -> None

let env_contains env key : bool =
  match env_fetch env key with
  | Some _ -> true
  | None -> false

(* XXX: keys should be ident, using [uid] as a perfect hash *)
type 'a env = (string, 'a) Hashtbl.t

let env_add (env: 'a env) (id: ident) (value: 'a) : unit =
  Hashtbl.add env id.name value

(* converts an uint_n to n bools *)
let expand_intn_typed (id: ident) (n: int) =
  let rec aux i =
    if i > n then []
    else (fresh_suffix id (string_of_int i), bool) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of pat) *)
let expand_intn_pat (id: ident) (n: int) : var list =
  let rec aux i =
    if i > n then []
    else (Var (fresh_suffix id (string_of_int i))) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of expr) *)
let rec expand_intn_expr (id: ident) (n: int) : expr list =
  let rec aux i =
    if i > n then []
    else ExpVar (Var (fresh_suffix id (string_of_int i))) :: (aux (i+1))
  in aux 1

let rec expand_intn_list (id: ident) (n: int) : ident list =
  let rec aux i =
    if i > n then []
    else (fresh_suffix id (string_of_int i)) :: (aux (i+1))
  in aux 1


(* x[5] will say x[5] is used, when it should say x is used as well *)
let rec get_used_vars (e:expr) : var list =
  match e with
  | Const _ -> []
  | ExpVar v -> [ v ]
  | Shuffle(v,_) -> [ v ]
  | Tuple l -> List.flatten @@ List.map get_used_vars l
  | Not e -> get_used_vars e
  | Shift(_,e,_) -> get_used_vars e
  | Log(_,x,y) | Arith(_,x,y) -> (get_used_vars x) @ (get_used_vars y)
  | Fun(_,l) -> List.flatten @@ List.map get_used_vars l
  | _ -> assert false
let rec get_used_vars_deq (deq:deq) : var list =
  match deq.content with
  | Eqn(_,e,_) -> get_used_vars e
  | Loop(_,_,_,dl,_) -> flat_map get_used_vars_deq dl

let rec get_var_name (v:var) : ident =
  match v with
  | Var id -> id
  | Index(v,_)
  | Range(v,_,_) | Slice(v,_) -> get_var_name v


let is_unroll (opts:stmt_opt list) : bool =
  List.mem Unroll opts

let is_nounroll (opts:stmt_opt list) : bool =
  List.mem No_unroll opts

let is_inline (def:def) : bool =
  List.mem Inline def.opt

let is_noinline (def:def) : bool =
  List.mem No_inline def.opt

let is_noopt (def:def) : bool =
  List.mem No_opt def.opt

let is_perm (def:def) : bool =
  match def.node with
  | Perm _ -> true
  | _ -> false

let is_const (var:var_d) : bool =
  List.mem Pconst var.vd_opts

let is_lazyLift (var:var_d) : bool =
  List.mem PlazyLift var.vd_opts

let default_bits_per_reg (arch:arch) : int =
  match arch with
  | Std     -> 64
  | MMX     -> 64
  | SSE     -> 128
  | AVX     -> 256
  | AVX512  -> 512
  | Neon    -> 128
  | AltiVec -> 128


let p_size (p:p) : int =
  List.fold_left (fun sum vd -> sum + (typ_size vd.vd_typ)) 0 p

let var_constr_to_str (v:var) : string =
  match v with
  | Var _   -> "Var"
  | Index _ -> "Index"
  | Range _ -> "Range"
  | Slice _ -> "Slice"

let get_expr_constr_str (e:expr) : string =
  match e with
  | Const _   -> "Const"
  | ExpVar _  -> "ExpVar"
  | Tuple _   -> "Tuple"
  | Not _     -> "Not"
  | Shift _   -> "Shift"
  | Log _     -> "Log"
  | Shuffle _ -> "Shuffle"
  | Arith _   -> "Arith"
  | Fun _     -> "Fun"
  | Fun_v _   -> "Fun_v"

let rec contains_fun (e:expr) : bool =
    match e with
  | Const _ | ExpVar _ | Shuffle _ -> false
  | Tuple l       -> List.exists contains_fun l
  | Not e'        -> contains_fun e'
  | Shift(_,e',_) -> (contains_fun e')
  | Log(_,x,y)    -> (contains_fun x) || (contains_fun y)
  | Arith(_,x,y)  -> (contains_fun x) || (contains_fun y)
  | Fun _         -> true
  | Fun_v _       -> true

let rec is_constant (ae:arith_expr) : bool =
  match ae with
  | Const_e _   -> true
  | Var_e _     -> false
  | Op_e(_,x,y) -> (is_constant x) && (is_constant y)


let rec simpl_var_indices (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v',ae) -> Index(simpl_var_indices v',simpl_arith_ne ae)
  | _ -> assert false

let is_builtin (f:ident) : bool =
  List.mem f.name [ "print"; "rand"; "refresh" ]

(* Returns true if |defi| is a single; false otherwise *)
let is_single (defi:def_i) =
  match defi with
  | Single _ -> true
  | _ -> false

(* Helps to get the variables and body of a "Single" node *)
let get_vars_body = function
  | Single(vars,body) -> vars, body
  | _ -> assert false
let get_vars x = fst (get_vars_body x)
let get_body x = snd (get_vars_body x)

let get_deq_expr (deq:deq) : expr =
  match deq.content with
  | Eqn(_,e,_) -> e
  | _ -> assert false

let all_vars_same_m (var_l:var_d list) : bool =
  let first_m = get_type_m (List.hd var_l).vd_typ in
  List.for_all (fun vd -> get_type_m vd.vd_typ = first_m) var_l
