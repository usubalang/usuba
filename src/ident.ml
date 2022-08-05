open Sexplib.Std

type uid = int [@@deriving sexp]
type t = { name : string; uid : uid; parent : t option } [@@deriving sexp]

let equal t1 t2 = String.equal t1.name t2.name
let hash { name; _ } = Hashtbl.hash name
let compare t1 t2 = String.compare t1.name t2.name

(* Getters *)

let name { name; _ } = name
let uid { uid; _ } = uid

(* Parsing phase *)
let create_unbound name = { name; uid = -1; parent = None }

(* let create_constant = *)
(*   let counter = ref 0 in *)
(*   fun name -> *)
(*     decr counter; *)
(*     { name; uid = !counter } *)
let create_constant name = { name; uid = -1; parent = None }

(* Fresh idents *)

let free_unbound, create_free =
  let counter = ref 0 in
  ( (fun t ->
      assert (t.uid = -1);
      incr counter;
      { t with uid = !counter }),
    fun name ->
      incr counter;
      { name; uid = !counter; parent = None } )

(* let create_free name = { name; uid = -1 } *)
let fresh_suffixed { name; _ } suff = create_free (name ^ suff)
let fresh_prefixed { name; _ } suff = create_free (suff ^ name)
let fresh_concat t1 t2 = create_free (t1.name ^ t2.name)
let fresh_copy { name; _ } = create_free name

(* Copies *)
let bound_copy id name = { id with name }
let bound_copy2 id = { id with name = id.name ^ "__2" }
let bound_copy3 id = { id with name = id.name ^ "__3" }

(* Printers *)
let rec pp ?(detailed = false) () ppf { name; uid; parent } =
  Format.fprintf ppf "%s%s" name
    (if detailed then
     Format.asprintf "(%d%a)" uid
       (fun ppf -> function
         | None -> ()
         | Some parent -> Format.fprintf ppf " > %a" (pp ~detailed ()) parent)
       parent
    else "")

let pp_create ppf t =
  Format.fprintf ppf {|(Ident.create_unbound "%a")|} (pp ()) t

(* Collections *)

module NameMap = struct
  include Map.Make (struct
    type t = string

    let compare = String.compare
  end)

  let pp ?(pp_sep = fun ppf () -> Format.fprintf ppf "; ") ?(left = "[")
      ?(right = "]") pp_v ppf t =
    Usuba_pp.List.pp ~pp_sep ~left ~right
      (fun ppf (k, v) ->
        Format.fprintf ppf "%a -> %a" Usuba_pp.String.pp k pp_v v)
      ppf (bindings t)
end

module Map = struct
  include Map.Make (struct
    type nonrec t = t

    let compare = compare
  end)

  let pp ?(pp_sep = fun ppf () -> Format.fprintf ppf "; ") ?(left = "[")
      ?(right = "]") pp_v ppf t =
    Usuba_pp.List.pp ~pp_sep ~left ~right
      (fun ppf (k, v) ->
        Format.fprintf ppf "%a -> %a" (pp ~detailed:true ()) k pp_v v)
      ppf (bindings t)
end

module Hashtbl = struct
  include Hashtbl.Make (struct
    type nonrec t = t

    let equal = equal
    let hash = hash
  end)

  (* Retrieving the keys of a hash *)
  let keys hash = fold (fun k _ acc -> k :: acc) hash []

  (* Retrieving the values of a hash *)
  let values hash = fold (fun _ v acc -> v :: acc) hash []

  (* Getting a list of keys,values *)
  let each hash = fold (fun k v acc -> (k, v) :: acc) hash []

  (* Retrieving the keys of a HoH's 2nd layer*)
  let keys_2nd_layer hash k = try keys (find hash k) with Not_found -> []
end

let bind ~backtrace map { name; _ } =
  match NameMap.find name map with
  | { uid; _ } as parent ->
      if uid = -1 then raise (Errors.Binding_to_unbound (name, backtrace))
      else { name; uid; parent = Some parent }
  | exception Not_found -> raise (Errors.Binding_unknown (name, backtrace))
