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
            
let default_conf : config =
  { block_size  = 64;
    key_size    = 64;
    warnings    = true;
    verbose     = 1;
    verif       = false;
    type_check  = true;
    clock_check = true;
    check_tbl   = false;
    inlining    = true;
    inline_all  = false;
    cse_cp      = true;
    scheduling  = true;
    share_var   = true;
    precal_tbl  = true;
    runtime     = true;
    archi       = Std;
    bits_per_reg = 64;
    bench       = false;
    rand_input  = false;
    ortho       = true;
    openmp      = 1;
    no_arr      = false;
    interleave  = 1;
  }
    
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

         
let env_fetch env v =
  try Hashtbl.find env v
  with Not_found -> raise (Error (__LOC__ ^ ":Not found: " ^ v.name))


(* Constructs a map { variables : types } *)
let build_env_var (p_in:p) (p_out:p) (vars:p) : (ident, typ) Hashtbl.t =
  let env = make_env () in

  let add_to_env ((id,typ),_) =
    env_add env id typ in
  
  List.iter add_to_env p_in;
  List.iter add_to_env p_out;
  List.iter add_to_env vars;

  env
                          
let rec typ_size (t:typ) : int =
  match t with
  | Bool -> 1
  | Int(_,m) -> m
  | Array(t',ae) -> (typ_size t') * (eval_arith_ne ae)
  | Nat -> 1
                        
let elem_size (t:typ) : int =
  match t with
  | Array(t',_) -> typ_size t'
  | _ -> assert false
                
let rec get_var_type env (v:var) : typ =
  match v with
  | Var x -> env_fetch env x
  | Index(v',_) -> (match get_var_type env v' with
                    | Bool -> Bool
                    | Array(t,_) -> t
                    | Int(n,m) -> Int(n,1)
                    | _ -> assert false)
  | _ -> assert false

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

                           
let rec expand_var env_var ?(env_it=Hashtbl.create 100) ?(partial=false) (v:var) : var list =
  let typ = get_var_type env_var v in
  match typ with
  | Bool -> [ v ]
  | Int(_,1) -> [ v ]
  | Int(_,m) -> List.map (fun i -> Index(v,Const_e i)) (gen_list_0_int m)
  | Array(_,ae) -> if partial then
                     List.map (fun i -> Index(v,Const_e i))
                              (gen_list_0_int (eval_arith env_it ae))
                   else
                     flat_map (fun i -> expand_var env_var ~env_it:env_it (Index(v,Const_e i)))
                              (gen_list_0_int (eval_arith env_it ae))
  | _ -> assert false

let rec expand_var_partial env_var ?(env_it=Hashtbl.create 100) (v:var) : var list =
  expand_var env_var ~env_it:env_it ~partial:true v

let rec get_var_base (v:var) : var =
  match v with
  | Var _ -> v
  | Index(v,_) | Slice(v,_) | Range(v,_,_) -> get_var_base v
  

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

let rec get_typ (id: ident) (vars: p) =
  match vars with
  | [] -> print_endline("Type not found for " ^ id.name);Bool
  | ((id',typ),_) :: tl -> if id = id' then typ else get_typ id tl


(* converts an uint_n to n bools (with types and clock) *)
let expand_intn_typed (id: ident) (n: int) (ck: clock) =
  let rec aux i =
    if i > n then []
    else ((fresh_suffix id (string_of_int i), Bool), ck) :: (aux (i+1))
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

let default_bits_per_reg (arch:arch) : int =
  match arch with
  | Std     -> 64 
  | MMX     -> 64
  | SSE     -> 128
  | AVX     -> 256
  | AVX512  -> 512
  | Neon    -> 128
  | AltiVec -> 128


let rec p_size (p:p) : int =
  match p with
  | [] -> 0
  | ((_,typ),_) :: tl -> (typ_size typ) + (p_size tl)
