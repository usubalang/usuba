module String = struct
  include Stdlib.String

  let pp ppf s = Format.fprintf ppf "%s" s
end

module List = struct
  include Stdlib.List

  let pp ?(pp_sep = fun ppf () -> Format.fprintf ppf "; ") ?(left = "[")
      ?(right = "]") pp ppf l =
    Format.fprintf ppf "%s%a%s" left Format.(pp_print_list ~pp_sep pp) l right
end
