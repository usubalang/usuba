module Int = struct
  let pp ppf i = Format.fprintf ppf "%d" i
end

module String = struct
  let pp ppf s = Format.fprintf ppf "%s" s

  let pp_lowercase ?(ocaml_ident = true) ppf s =
    let s = String.lowercase_ascii s in
    Format.fprintf ppf "%s"
      (if ocaml_ident then
       String.map (function '.' -> 'D' | '-' -> 'H' | c -> c) s
      else s)
end

module List = struct
  let pp ?(pp_sep = fun ppf () -> Format.fprintf ppf "; ") ?(left = "[")
      ?(right = "]") pp ppf l =
    Format.fprintf ppf "%s%a%s" left Format.(pp_print_list ~pp_sep pp) l right

  let pp_tree =
    let pp_sep ppf () = Format.fprintf ppf "@,├───" in
    let pp_end ppf () = Format.fprintf ppf "@,└───" in
    fun pp ppf l ->
      let rec aux = function
        | [] -> ()
        | [ v ] -> pp ppf v
        | [ v1; v2 ] ->
            pp ppf v1;
            pp_end ppf ();
            pp ppf v2
        | hd :: tl ->
            pp ppf hd;
            pp_sep ppf ();
            aux tl
      in
      match l with
      | [] -> ()
      | _ ->
          Format.fprintf ppf "├───";
          aux l
end
