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

(* Returns true if a list is empty *)
let is_empty = function [] -> true | _ -> false

(* Alias for List.flatten @@ List.map *)
let flat_map f l = List.flatten @@ List.map f l

(* Alias for String.concat *)
let rec join (s:string) (l:string list) : string = String.concat s l

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
