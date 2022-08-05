module I = Parser.MenhirInterpreter

let get_parse_error env =
  match I.stack env with
  | (lazy Nil) -> "Invalid syntax"
  | (lazy (Cons (I.Element (state, _, _, _), _))) -> (
      try Parser_messages.message (I.number state)
      with Not_found -> "invalid syntax (no specific message for this error)")
