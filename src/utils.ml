open Usuba_AST

exception Error of string
exception Syntax_error
exception Not_implemented of string
exception Empty_list
exception Undeclared of string
exception Invalid_param_size
exception Invalid_operator_call
exception Break            

let unreached () = raise (Error "This point can't be reached")
                         
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

let rec join s l = String.concat s l

let indent (tab: int) : string =
  String.make (tab * 4) ' '
let indent_small (tab: int) : string =
  String.make (tab * 2) ' '

let gen_list (id: string) (n: int) : string list =
  let rec aux n acc =
    if n <= 0 then acc
    else aux (n-1) ((id ^ (string_of_int n))::acc) 
  in aux n []

let gen_list_0 (id: string) (n: int) : string list =
  let rec aux n acc =
    if n <= 0 then acc
    else aux (n-1) ((id ^ (string_of_int (n-1)))::acc) 
  in aux n []
         
let id_generator =
  let current = ref 0 in
  fun () -> incr current; !current
                           
let id_generator_var =
  let current = ref 0 in
  fun () -> incr current; !current

let env_fetch (env: ('b, 'a) Hashtbl.t) (name: 'b) : 'a option =
  try
    let v = Hashtbl.find env name in Some v
  with Not_found -> None

let env_contains env key : bool =
  match env_fetch env key with
  | Some _ -> true
  | None -> false
    
let env_add (env: ('a,'b) Hashtbl.t) (key: 'a) (value: 'b) : unit =
  Hashtbl.add env key value
              
(* Adds the variables vars to env_var *)
let rec env_add_var (vars: p) (env_var: (ident, int) Hashtbl.t) : unit =
  match vars with
  | [] -> ()
  | (id,typ,_)::tl -> ( env_add env_var id
                                (match typ with
                                 | Bool  -> 1
                                 | Int n -> n
                                 | Nat -> raise (Invalid_AST "Nat")
                                 | Array _ -> raise (Invalid_AST "Array"));
                        env_add_var tl env_var )

(* Add a function (name,p_in,p_out) to env_fun *)
let env_add_fun (name: ident) (p_in: p) (p_out: p)
                (env_fun: (ident, int list * int) Hashtbl.t) : unit =
  let rec get_param_in_size = function
    | [] -> []
    | (_,typ,_)::tl -> (match typ with
                         | Bool -> 1
                         | Int n -> n
                         | Nat -> raise (Invalid_AST "Nat")
                         | Array _ -> raise (Invalid_AST "Array"))
                        :: (get_param_in_size tl)
  in
  let rec get_param_out_size = function
    | [] -> 0
    | (_,typ,_)::tl -> (match typ with
                        | Bool -> 1
                        | Int n -> n
                        | Nat -> raise (Invalid_AST "Nat")
                        | Array _ -> raise (Invalid_AST "Array"))
                       + (get_param_out_size tl)
  in
  env_add env_fun name (get_param_in_size p_in,get_param_out_size p_out)


let rec get_typ (id: ident) (vars: p) =
  match vars with
  | [] -> print_endline("Type not found for " ^ id);Bool
  | (id',typ,_) :: tl -> if id = id' then typ else get_typ id tl

(* converts an uint_n to n bools (with types and clock) *)
let expand_intn_typed (id: ident) (n: int) (ck: clock) =
  let rec aux i =
    if i > n then []
    else (id ^ (string_of_int i), Bool, ck) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of pat) *)
let expand_intn_pat (id: ident) (n: int) : var list =
  let rec aux i =
    if i > n then []
    else (Var (id ^ (string_of_int i))) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of expr) *)
let rec expand_intn_expr (id: ident) (n: int) : expr list =
  let rec aux i =
    if i > n then []
    else ExpVar (Var (id ^ (string_of_int i))) :: (aux (i+1))
  in aux 1

let rec expand_intn_list (id: ident) (n: int) : ident list =
  let rec aux i =
    if i > n then []
    else (id ^ (string_of_int i)) :: (aux (i+1))
  in aux 1


let contains s1 s2 =
  let re = Str.regexp_string s2
  in
  try ignore (Str.search_forward re s1 0); true
  with Not_found -> false


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
                    | Mod -> if x' > 0 then x' mod y' else y' + (x' mod y')

   
let rec get_used_vars (e:expr) : var list =
  match e with
  | Const _ -> []
  | ExpVar v -> [ v ]
  | Tuple l -> List.flatten @@ List.map get_used_vars l
  | Not e -> get_used_vars e
  | Shift(_,e,_) -> get_used_vars e
  | Log(_,x,y) | Arith(_,x,y) | Intr(_,x,y)
                                -> (get_used_vars x) @ (get_used_vars y)
  | Fun(_,l) -> List.flatten @@ List.map get_used_vars l
  | _ -> raise (Error "Not supported expr")


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
