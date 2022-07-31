open Sexplib.Std

type uid = int [@@deriving sexp]
type t = { name : string; uid : uid } [@@deriving sexp]

module Hashtbl = struct
  include Hashtbl.Make (struct
    type nonrec t = t

    let equal t1 t2 = String.equal t1.name t2.name && Int.equal t1.uid t2.uid

    let hash { name; uid; _ } =
      Hashtbl.hash (Hashtbl.hash name + Hashtbl.hash uid)
  end)
end

(* Getters *)

let name { name; _ } = name
let uid { uid; _ } = uid

(* Parsing phase *)
let create_unbound name = { name; uid = -1 }

(* Fresh idents *)
let create_free name = { name; uid = -1 }
let fresh_suffixed { name; _ } suff = create_free (name ^ suff)
let fresh_prefixed { name; _ } suff = create_free (suff ^ name)
let fresh_concat t1 t2 = create_free (t1.name ^ t2.name)
let fresh_copy { name; _ } = create_free name

(* Copies *)
let bound_copy id name = { id with name }
let bound_copy2 id = { id with name = id.name ^ "__2" }
let bound_copy3 id = { id with name = id.name ^ "__3" }

(* Printers *)
let pp ?(detailed = false) () ppf { name; uid } =
  Format.fprintf ppf "%s%s" name
    (if detailed then Format.sprintf "(%d)" uid else "")

let pp_create ppf t =
  Format.fprintf ppf {|(Ident.create_unbound "%a")|} (pp ()) t

let equal t1 t2 = String.equal t1.name t2.name
let compare t1 t2 = String.compare t1.name t2.name
