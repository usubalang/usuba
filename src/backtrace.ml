type t = string list

let empty = []
let append s t = s :: t

let pp ppf t =
  Format.fprintf ppf "@[<v 0>Backtrace:@,%a@]"
    Usuba_pp.(List.pp_tree Usuba_pp.String.pp)
    t
