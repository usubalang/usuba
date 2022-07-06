open Sexplib.Std

type uid = int [@@deriving sexp]
type t = { name : string; uid : uid } [@@deriving sexp]

module Map = Map.Make (String)

(* Getters *)

let name { name; _ } = name
let uid { uid; _ } = uid

(* Parsing phase *)
let create_unbound name = { name; uid = -1 }

(* Fresh idents *)
let refresh, create_fresh =
  let counter = ref 0 in
  ( (fun t ->
      incr counter;
      { t with uid = -1 }),
    fun name ->
      incr counter;
      { name; uid = -1 } )

let fresh_suffixed { name; _ } suff = create_fresh (name ^ suff)
let fresh_prefixed { name; _ } suff = create_fresh (suff ^ name)
let fresh_concat t1 t2 = create_fresh (t1.name ^ t2.name)
let fresh_copy { name; _ } = create_fresh name

(* Bindings *)

let bind ~backtrace map { name; _ } =
  match Map.find name map with
  | uid ->
      if uid = -1 then raise (Errors.Binding_to_unbound (name, backtrace))
      else { name; uid }
  | exception Not_found -> raise (Errors.Binding_unknown (name, backtrace))

(* Copies *)
let copy id name = { id with name }
let copy2_id id = { id with name = id.name ^ "__2" }
let copy3_id id = { id with name = id.name ^ "__3" }

(* Linking phase *)
(* let bound_id t map =
 *   match   { t with uid } *)
let pp ?(detailed = false) () ppf { name; uid } =
  Format.fprintf ppf "%s%s" name
    (if detailed then Format.sprintf "(%d)" uid else "")

let show t = Format.asprintf "%a" (pp ()) t
let equal t1 t2 = t1.uid = t2.uid
let compare t1 t2 = t1.uid - t2.uid
let hash { uid; _ } = Hashtbl.hash uid
