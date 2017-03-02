
open Abstract_syntax_tree

let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> 
     let b = pow a (n / 2) in
     b * b * (if n mod 2 = 0 then 1 else a)

let last l =
  List.nth l (List.length l - 1)

let rec join s l =
  match l with
  | [] -> ""
  | e::[] -> e
  | hd::tl -> hd ^ s ^ (join s tl)

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

                           
let env_fetch (env: (ident, 'a) Hashtbl.t) (name: ident) : 'a option =
  try
    let v = Hashtbl.find env name in Some v
  with Not_found -> None

let env_add (env: ('a,'b) Hashtbl.t) (key: 'a) (value: 'b) : unit =
  Hashtbl.add env key value
              
(* Adds the variables vars to env_var *)
let rec env_add_var (vars: p) (env_var: (ident, int) Hashtbl.t) : unit =
  match vars with
  | [] -> ()
  | (id,typ,_)::tl -> ( env_add env_var id
                                (match typ with
                                 | Bool  -> 1
                                 | Int n -> n);
                        env_add_var tl env_var )

(* Add a function (name,p_in,p_out) to env_fun *)
let env_add_fun (name: ident) (p_in: p) (p_out: p)
                (env_fun: (ident, int list * int) Hashtbl.t) : unit =
  let rec get_param_in_size = function
    | [] -> []
    | (id,typ,_)::tl -> (match typ with
                         | Bool -> 1
                         | Int n -> n) :: (get_param_in_size tl)
  in
  let rec get_param_out_size = function
    | [] -> 0
    | (_,typ,_)::tl -> (match typ with
                        | Bool -> 1
                        | Int n -> n) + (get_param_out_size tl)
  in
  env_add env_fun name (get_param_in_size p_in,get_param_out_size p_out)


          

(* converts an uint_n to n bools (with types and clock) *)
let expand_intn_typed (id: ident) (n: int) (ck: clock) =
  let rec aux i =
    if i > n then []
    else (id ^ (string_of_int i), Bool, ck) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of pat) *)
let expand_intn_pat (id: ident) (n: int) : left_asgn list =
  let rec aux i =
    if i > n then []
    else (Ident (id ^ (string_of_int i))) :: (aux (i+1))
  in aux 1

(* converts an uint_n to n bools (in the format of expr) *)
let rec expand_intn_expr (id: ident) (n: int) : expr list =
  let rec aux i =
    if i > n then []
    else (Var (id ^ (string_of_int i))) :: (aux (i+1))
  in aux 1

let rec expand_intn_list (id: ident) (n: int) : ident list =
  let rec aux i =
    if i > n then []
    else (id ^ (string_of_int i)) :: (aux (i+1))
  in aux 1