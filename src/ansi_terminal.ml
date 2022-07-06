type style =
  | Normal
  | FG_Black
  | FG_Red
  | FG_Green
  | FG_Yellow
  | FG_Default
  | BG_Default

let close_tag = function
  | FG_Black | FG_Red | FG_Green | FG_Yellow | FG_Default -> FG_Default
  | BG_Default -> BG_Default
  | _ -> Normal

let style_of_tag = function
  | Format.String_tag s -> (
      match s with
      | "n" -> Normal
      | "fg_black" -> FG_Black
      | "fg_red" -> FG_Red
      | "fg_green" -> FG_Green
      | "fg_yellow" -> FG_Yellow
      | "fg_default" -> FG_Default
      | "bg_default" -> BG_Default
      | _ -> raise Not_found)
  | _ -> raise Not_found

(* See https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters for some values *)
let to_ansi_value = function
  | Normal -> "0"
  | FG_Black -> "30"
  | FG_Red -> "31"
  | FG_Green -> "32"
  | FG_Yellow -> "33"
  | FG_Default -> "39"
  | BG_Default -> "49"

let ansi_tag = Printf.sprintf "\x1B[%sm"
let start_mark_ansi_stag t = ansi_tag @@ to_ansi_value @@ style_of_tag t

let stop_mark_ansi_stag t =
  ansi_tag @@ to_ansi_value @@ close_tag @@ style_of_tag t

let add_ansi_marking formatter =
  let open Format in
  pp_set_mark_tags formatter true;
  let old_fs = pp_get_formatter_stag_functions formatter () in
  pp_set_formatter_stag_functions formatter
    {
      old_fs with
      mark_open_stag = start_mark_ansi_stag;
      mark_close_stag = stop_mark_ansi_stag;
    }
