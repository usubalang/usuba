open Usuba_AST

exception Invalid_AST of string
exception Error of string
exception Syntax_error
exception Not_implemented of string
exception Empty_list
exception Undeclared of ident
exception Invalid_param_size
exception Invalid_operator_call
exception Break            

let unreached () = raise (Error "This point can't be reached")

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
    array_opti  = true;
    share_var   = true;
    precal_tbl  = true;
    runtime     = true;
    archi       = Std;
    bit_per_reg = 64;
    bench       = false;
    rand_input  = false;
    ortho       = true;
    openmp      = 1;
  }

let print_conf (conf:config) : unit =
  Printf.printf
"config = {
  inlining     = %B;
  gen_z3       = %B;
  check_tables = %B;
  verbose      = %d;
  warnings     = %B;
}\n" conf.inlining conf.verif conf.check_tbl
conf.verbose conf.warnings

               
let rec map_no_end f = function
  | [] -> []
  | [x] -> []
  | hd::tl -> (f hd) :: (map_no_end f tl)

let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> 
     let b = pow a (n / 2) in
     b * b * (if n mod 2 = 0 then 1 else a)

let unfold_andn e =
  match e with
  | Log(Andn,x,y) -> Log(And,Not x,y)
  | _ -> e          

let last l =
  List.nth l (List.length l - 1)
let is_empty = function [] -> true | _ -> false


let rec eval_arith env (e:Usuba_AST.arith_expr) : int =
  match e with
  | Const_e n -> n
  | Var_e id  -> Hashtbl.find env id.name
  | Op_e(op,x,y) -> let x' = eval_arith env x in
                    let y' = eval_arith env y in
                    match op with
                    | Add -> x' + y'
                    | Mul -> x' * y'
                    | Sub -> x' - y'
                    | Div -> x' / y'
                    | Mod -> if x' > 0 then x' mod y' else y' + (x' mod y')
                                            
let rec join s l = String.concat s l

let indent (tab: int) : string =
  String.make (tab * 4) ' '
let indent_small (tab: int) : string =
  String.make (tab * 2) ' '

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

let rec gen_list_bound (n1: int) (n2:int) : int list =
  if n1 < n2 then n1 :: (gen_list_bound (n1 + 1) n2)
  else if n2 < n1 then n1 :: (gen_list_bound (n1 - 1) n2)
  else [n1]

let rec typ_size (typ:typ) : int =
  match typ with
  | Bool -> 1
  | Int n -> n
  | Array(t,n) -> (eval_arith (Hashtbl.create 1) n)*(typ_size t)
  | _ -> raise (Error "Invalid Array with non-const size")
         
let id_generator =
  let current = ref 0 in
  fun () -> incr current; !current
                           
let id_generator_var =
  let current = ref 0 in
  fun () -> incr current; !current

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
              
(* Adds the variables vars to env_var *)
let rec env_add_var (vars: p) (env_var: int env) : unit =
  match vars with
  | [] -> ()
  | ((id,typ),_)::tl -> ( env_add env_var id
                                (match typ with
                                 | Bool  -> 1
                                 | Int n -> n
                                 | Nat -> raise (Invalid_AST "Nat")
                                 | Array _ -> raise (Invalid_AST "Array (1)"));
                        env_add_var tl env_var )

(* Add a function (name,p_in,p_out) to env_fun *)
let env_add_fun (name: ident) (p_in: p) (p_out: p)
                (env_fun: (int list * int) env) : unit =
  let rec get_param_in_size = function
    | [] -> []
    | ((_,typ),_)::tl -> (match typ with
                         | Bool -> 1
                         | Int n -> n
                         | Nat -> raise (Invalid_AST "Nat")
                         | Array _ -> raise (Invalid_AST "Array (2)"))
                        :: (get_param_in_size tl)
  in
  let rec get_param_out_size = function
    | [] -> 0
    | ((_,typ),_)::tl -> (match typ with
                        | Bool -> 1
                        | Int n -> n
                        | Nat -> raise (Invalid_AST "Nat")
                        | Array _ -> raise (Invalid_AST "Array (3)"))
                       + (get_param_out_size tl)
  in
  env_add env_fun name (get_param_in_size p_in,get_param_out_size p_out)


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

let contains s1 s2 =
  let re = Str.regexp_string s2
  in
  try ignore (Str.search_forward re s1 0); true
  with Not_found -> false


   
let rec get_used_vars (e:expr) : var list =
  match e with
  | Const _ -> []
  | ExpVar v -> [ v ]
  | Tuple l -> List.flatten @@ List.map get_used_vars l
  | Not e -> get_used_vars e
  | Shift(_,e,_) -> get_used_vars e
  | Log(_,x,y) | Arith(_,x,y) -> (get_used_vars x) @ (get_used_vars y)
  | Fun(_,l) -> List.flatten @@ List.map get_used_vars l
  | _ -> raise (Error "Not supported expr")

let rec get_var_name (v:var) : ident =
  match v with
  | Var id -> id
  | Field(v,_) -> get_var_name v
  | Index(id,_) -> id
  | Range(id,_,_) -> id
  | Slice(id,_) -> id

(* Retrieving the keys of a hash *)
let keys hash = Hashtbl.fold (fun k _ acc -> k :: acc) hash []

(* Retrieving the keys of a HoH's 2nd layer*)
let keys_2nd_layer hash k =
  try
    keys (Hashtbl.find hash k)
  with Not_found -> []

let is_inline (def:def) : bool =
  List.exists (function
                | Inline    -> true
                | No_inline -> false) def.opt

let is_noinline (def:def) : bool =
  List.exists (function
                | Inline    -> false
                | No_inline -> true) def.opt

let print_bool_list (l:bool list) : unit =
  List.iter (fun x -> print_int (if x then 1 else 0)) l;
  print_endline ""

(* Note: boollist_to_int (int_to_boollist x n) == x 
   (if x is less than 2^n) *)
let boollist_to_int (l: bool list) : int =
  let rec aux l n =
    match l with
    | [] -> n
    | hd :: tl -> aux tl ((n lsl 1) lor (if hd then 1 else 0)) in
  aux l 0

let int_to_boollist (n : int) (size: int) : bool list =
  let rec aux i l =
    if i = 0 then List.rev l
    else aux (i-1) (((n lsr (i-1)) land 1 = 1) :: l) in
  aux size []

let rec p_size (p:p) : int =
  let typ_size (t:typ) =
    match t with
    | Bool -> 1
    | Int n -> n
    | _ -> raise (Not_implemented "p_size restricted to Bool & Int") in
  match p with
  | [] -> 0
  | ((_,typ),_) :: tl -> (typ_size typ) + (p_size tl)
