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
  | [x] -> []
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
                
(* Alias for String.concat *)
let rec join = String.concat

(* Returns true if s1 contains s2 *)
let contains (s1:string) (s2:string) : bool =
  let re = Str.regexp_string s2
  in
  try ignore (Str.search_forward re s1 0); true
  with Not_found -> false

(* Retrieving the keys of a hash *)
let keys hash = Hashtbl.fold (fun k _ acc -> k :: acc) hash []

(* Retrieving the keys of a HoH's 2nd layer*)
let keys_2nd_layer hash k =
  try
    keys (Hashtbl.find hash k)
  with Not_found -> []

(* Generates the list of integers between i and f *)
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
