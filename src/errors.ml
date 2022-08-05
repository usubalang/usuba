type infos = { filename : string; line : int; col_start : int; col_end : int }
type loc = Lexing.position * Lexing.position

(* Lexing and parsing errors *)
exception Malformed_type of string
exception Syntax_error of infos option * (Format.formatter -> unit -> unit)
exception Single_of_table of (loc * string)
exception Table_of_single of (loc * string)
exception Lexing_error of Lexing.lexbuf * (Format.formatter -> unit -> unit)

(* Ident errors *)

exception Binding_to_unbound of string * string list
exception Binding_unknown of string * string list
exception Rename_to_unknown of string

(* Other errors *)
exception Error of string
exception Invalid_AST of string
exception Not_implemented of string
exception Empty_list
exception Undeclared of string
exception Invalid_param_size
exception Invalid_operator_call
exception Break
exception Skip

(* The type-checker tries not to stop at the first error. However,
   given some errors, it wouldn't make sense to keep type-checking a
   given node. In that case, |Fatal_type_error| is raised. *)
exception Fatal_type_error of (Format.formatter -> unit -> unit) * string list

(* Exception raise whenever an arithmetic expression (array index for
   instance) cannot be computed statically because it depends on a
   parameter or something like that. *)
exception Uncomputable
exception Typing_Warning of (Format.formatter -> unit -> unit) * string list

(* Transform a string to a Format.formatter -> string -> unit
 * This function is used for homogenization of errors *)
let s_to_msg s ppf () = Format.fprintf ppf "%s" s

(* Print infos in emacs standard allowing to jump directly to the raised error *)
let pp_infos ppf { filename; line; col_start; col_end } =
  Format.fprintf ppf "File \"%s\", line %d, characters %d-%d:" filename line
    col_start col_end

(* Returns the entire line where the error is *)
let get_line infos =
  let ci = open_in infos.filename in
  for _i = 1 to infos.line - 1 do
    ignore (input_line ci)
  done;
  let line = input_line ci in
  close_in ci;
  line

let separator = " |     | "

(* Prints '^' under the error *)
let pp_marks ppf infos =
  let size =
    truncate (log10 (float infos.line))
    + 1 + String.length separator + infos.col_start
  in
  Format.fprintf ppf "%s%s" (String.make size ' ')
    (String.make (infos.col_end - infos.col_start) '^')

(* Gather useful informations from the lexing buffer in case of syntax or lexing error *)
let get_infos lexbuf =
  let p = Lexing.lexeme_start_p lexbuf in
  let line = p.Lexing.pos_lnum in
  let col_start = p.Lexing.pos_cnum - p.Lexing.pos_bol in
  let p = Lexing.lexeme_end_p lexbuf in
  let col_end = p.Lexing.pos_cnum - p.Lexing.pos_bol in
  { filename = lexbuf.Lexing.lex_start_p.pos_fname; line; col_start; col_end }

(*   *)
let lexing_error lexbuf msg =
  raise (Syntax_error (Some (get_infos lexbuf), s_to_msg msg))

let warning_or_error continuation pp_msg backtrace conf =
  match conf.Config.warning_as_error with
  | true -> raise (Typing_Warning (pp_msg, backtrace))
  | false ->
      Format.eprintf "@[<v 2>@{<fg_yellow>[Warning]@}: %a@,%a@." pp_msg ()
        Backtrace.pp backtrace;
      continuation ()

(* Combine the previous functions to print an easily readable error *)
let pp_error ppf = function
  | Syntax_error (infos, pp_msg) -> (
      match infos with
      | Some infos ->
          Format.fprintf ppf
            "@[<v 0>%a@,%d%s%s@,%a@,@,@{<fg_red>[Syntax error]@}: @[<v 2>%a@]@]"
            pp_infos infos infos.line separator (get_line infos) pp_marks infos
            pp_msg ()
      | None ->
          Format.fprintf ppf "@[<v 2>@{<fg_red>[Syntax error]@}:@,%a@]" pp_msg
            ())
  | Lexing_error (lexbuf, pp_msg) ->
      let infos = get_infos lexbuf in
      Format.fprintf ppf
        "@[<v 0>%a@,%d%s%s@,%a@,@,@{<fg_red>[Lexing error]@}: @[<v 2>%a@]@]"
        pp_infos infos infos.line separator (get_line infos) pp_marks infos
        pp_msg ()
  | Fatal_type_error (pp_msg, backtrace) ->
      Format.fprintf ppf "@[<v 2>@{<fg_red>[Typing error]@}: %a@,%a@]" pp_msg ()
        Backtrace.pp backtrace
  | Typing_Warning (pp_msg, backtrace) ->
      Format.fprintf ppf "@[<v 2>@{<fg_yellow>[Typing warning]@}: %a@,%a@]"
        pp_msg () Backtrace.pp backtrace
  | Binding_to_unbound (s, backtrace) ->
      Format.fprintf ppf
        "@[<v 2>@{<fg_red>[Binding Error]@}: '%s' is not a fresh ident@,%a@]" s
        Backtrace.pp backtrace
  | Binding_unknown (s, backtrace) ->
      Format.fprintf ppf
        "@[<v 2>@{<fg_red>[Binding Error]@}: '%s' can not be bound to any \
         ident@,\
         %a@]"
        s Backtrace.pp backtrace
  | Rename_to_unknown s ->
      Format.fprintf ppf
        "@[<v 2>@{<fg_red>[Renaming Error]@}: '%s' can not be renamed because \
         it isn't bounded to any ident@]"
        s
  | Error msg -> Format.fprintf ppf "@[<v 2>@{<fg_red>[Error]@}: %s@]" msg
  | e ->
      Format.eprintf "@[<v 2>@{<fg_red>[Unhandled error]@}: %s@]"
        (Printexc.to_string e)

let pp_list_errors ppf l =
  Format.(pp_print_list ~pp_sep:pp_print_cut pp_error ppf) l

let exec_with_print_and_fail f k v =
  match f v with
  | v -> k v
  | exception e ->
      Format.eprintf "%a@." pp_error e;
      exit 1
