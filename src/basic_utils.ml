(* ****************************************************************** *)
(*                       basic_utils.ml                               *)
(*                                                                    *)
(*  Some basic utilitary functions, that aren't related to Usuba in   *)
(*  particular. This should allow for this module to be loaded        *)
(*  everywhere, without introducting any circular references.         *)
(*                                                                    *)
(* ****************************************************************** *)


(* Apply a function to every elements of a list but the last,
   which is removed *)
let rec map_no_end f = function
  | [] -> []
  | [_] -> []
  | hd::tl -> (f hd) :: (map_no_end f tl)

(* pow a b == a ** b *)
let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n ->
     let b = pow a (n / 2) in
     b * b * (if n mod 2 = 0 then 1 else a)

(* Returns the last element of a list *)
let last l =
  List.nth l (List.length l - 1)

let rec apply_last l f =
  match l with
  | x::[] -> [ f x ]
  | hd::tl -> hd :: (apply_last tl f)
  | [] -> []

(* Returns true if a list is empty *)
let is_empty = function [] -> true | _ -> false

(* Alias for List.flatten @@ List.map *)
let flat_map f l = List.flatten @@ List.map f l

let for_alli (f:int -> 'a -> bool) (l:'a list) : bool =
  let i = ref 0 in
  List.for_all (fun e -> let b = f !i e in
                         incr i;
                         b) l

let map2i (f:int -> 'a -> 'b -> 'c) (la:'a list) (lb:'b list) : 'c list =
  let i = ref 0 in
  List.map2 (fun a b -> let c = f !i a b in
                        incr i;
                        c) la lb

let for_all2i (f:int -> 'a -> 'b -> bool) (la:'a list) (lb:'b list) : bool =
  let i = ref 0 in
  List.for_all2 (fun a b -> let c = f !i a b in
                            incr i;
                            c) la lb

let find_get_i (f:'a -> bool) (l:'a list) : int =
  let i = ref 0 in
  let _ = List.find (fun a -> let b = f a in
                              if b then b
                              else (incr i; b)) l in
  !i

(* Removes the n-th element of a list *)
let rec remove_nth (l:'a list) (n:int) =
    match n with
    | 0 -> List.tl l
    | _ -> (List.hd l) :: (remove_nth (List.tl l) (n-1))

(* Removes duplicates from a list *)
let uniq (l:'a list) : 'a list =
  let mem = Hashtbl.create 50 in
  List.filter (fun e -> if Hashtbl.mem mem e then false
                        else (Hashtbl.add mem e true; true)) l

(* Returns true if l1 and l2 have at least one common element *)
let common_elem l1 l2 = List.fold_left (fun x y -> x || List.mem y l2) false l1

(* Alias for String.concat *)
let join = String.concat

(* Returns true if s1 contains s2 *)
let contains (s1:string) (s2:string) : bool =
  let re = Str.regexp_string s2
  in
  try ignore (Str.search_forward re s1 0); true
  with Not_found -> false

(* Retrieving the keys of a hash *)
let keys hash = Hashtbl.fold (fun k _ acc -> k :: acc) hash []

(* Retrieving the values of a hash *)
let values hash = Hashtbl.fold (fun _ v acc -> v :: acc) hash []

(* Getting a list of keys,values *)
let each hash = Hashtbl.fold (fun k v acc -> (k,v) :: acc) hash []

(* Retrieving the keys of a HoH's 2nd layer*)
let keys_2nd_layer hash k =
  try
    keys (Hashtbl.find hash k)
  with Not_found -> []

(* Retrieve a given value of a HoH's 2nd layer *)
let find_opt_2nd_layer hash k1 k2 =
  match Hashtbl.find_opt hash k1 with
  | Some hash2 -> Hashtbl.find_opt hash2 k2
  | None -> None

(* Adds a key/val in the 2nd layer of a HoH *)
let add_key_2nd_layer hash1 k1 k2 v : unit =
  match Hashtbl.find_opt hash1 k1 with
  | Some hash2 -> Hashtbl.add hash2 k2 v
  | None -> let hash2 = Hashtbl.create 10 in
            Hashtbl.add hash2 k2 v;
            Hashtbl.add hash1 k1 hash2
(* Adds a key/val in the 2nd layer of a HoH *)
let replace_key_2nd_layer hash1 k1 k2 v : unit =
  match Hashtbl.find_opt hash1 k1 with
  | Some hash2 -> Hashtbl.replace hash2 k2 v
  | None -> let hash2 = Hashtbl.create 10 in
            Hashtbl.replace hash2 k2 v;
            Hashtbl.replace hash1 k1 hash2

(* Generates the list of integers between |i| and |f| included.
   For instance: (gen_list_bounds 1 5) ===> [1; 2; 3; 4; 5] *)
let rec gen_list_bounds (i:int) (f:int) : int list =
  if i < f then
    i :: (gen_list_bounds (i+1) f)
  else if i > f then
    i :: (gen_list_bounds (i-1) f)
  else [ f ]

(* Note: boollist_to_int (int_to_boollist x n) == x
   (if x is less than 2^n) *)
let boollist_to_int (l: bool list) : int =
  List.fold_left (fun n b -> (n lsl 1) lor (if b then 1 else 0)) 0 l

let int_to_boollist (n : int) (size: int) : bool list =
  let rec aux i l =
    if i = 0 then List.rev l
    else aux (i-1) (((n lsr (i-1)) land 1 = 1) :: l) in
  aux size []

(* Returns the max of a *non-empty* list *)
let max_l l = List.fold_left max (List.hd l) l

(* Returns the first |n| elements of |l|. *)
(* Will raise an error if |l| is too short. *)
let rec first_n l n =
  match n with
  | 0 -> []
  | n ->
     if n > 0 then
       (List.hd l) :: (first_n (List.tl l) (n-1))
     else
       (Printf.eprintf "Can't call first_n with a negative n. Exiting.\n";
        assert false)

(* Generates 0b11111, where there are |s| 1s. This corresponds to -1
   on a |s| bits register. *)
let rec gen_minus_one (s:int) =
  if s <= 0 then 0
  else (1 lsl (s-1)) lor (gen_minus_one (s-1))

(* Like fold_left, but with an index as well.
   Default start index is 0.
   If |start| is provided, then starts at this index. *)
let fold_left_i ?(start:int=0) (f:int -> 'a -> 'b -> 'a) (init:'a) (l:'b list) : 'a =
  let i = ref start in
  List.fold_left (fun a b -> let res = f !i a b in
                             incr i;
                             res) init l

(* Like fold_right, but with an index as well.
   Default start index is 0.
   If |start| is provided, then starts at this index. *)
let fold_right_i ?(start:int=0) (f:int -> 'a -> 'b -> 'b) (l:'a list) (init:'b) : 'b =
  let i = ref start in
  List.fold_right (fun a b -> let res = f !i a b in
                              incr i;
                              res) l init


(* List destruction helpers (to avoid warnings within code) *)
let list_to_tuple1 l = match l with
  | [ x ] -> x
  | _ -> assert false
let list_to_tuple2 l = match l with
  | [ x; y ] -> (x, y)
  | _ -> assert false
let list_to_tuple3 l = match l with
  | [ x; y; z ] -> (x, y, z)
  | _ -> assert false
