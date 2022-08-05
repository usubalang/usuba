{
open Lexing
open Usuba_AST
open Parser
open Errors

(* keyword table *)
let kwd_table =
let t = Hashtbl.create 10 in
  List.iter
    (fun (a, b) -> Hashtbl.add t a b)
    [
      ("node", NODE);
      ("returns", RETURN);
      ("vars", VAR);
      ("let", LET);
      ("tel", TEL);
      ("perm", PERM);
      ("table", TABLE);
      ("forall", FORALL);
      ("in", IN);
      ("Shuffle", SHUFFLE);
      ("Bitmask", BITMASK);
      ("Pack", PACK);
      ("_inline", INLINE);
      ("_no_inline", NOINLINE);
      ("_unroll", UNROLL);
      ("_no_unroll", NOUNROLL);
      ("_interleave", INTERLEAVE);
      ("_no_opt", NOOPT);
      ("const", CONST);
      ("lazyLift", LAZYLIFT);
      ("_pipelined", PIPELINED);
      ("include", INCLUDE);
    ]; t

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <-
    { pos with pos_bol = pos.pos_cnum; pos_lnum = pos.pos_lnum + 1 }

let parse s rule = rule (Lexing.from_string s)

let parse_opt ~default s rule =
  match s with None -> default | Some s -> rule (Lexing.from_string s)
}

let newline = [ '\n' '\r' ]
let space = [' ' '\t' '\r']
let all_but_newline = [^ '\n' '\r']

let integer = '0' | ['1'-'9']['0'-'9']* | "0x" ['0'-'9' 'a'-'f' 'A'-'F']+

let ident = ['a'-'z' 'A'-'Z' '_']['a'-'z' 'A'-'Z' '0'-'9' '_' '\'']*

let quoted_ident = '\'' ident

let dir = 'H' | 'V' | 'B' | integer | quoted_ident
let mtyp = integer | quoted_ident

rule token = parse

| "__END__" { EOF }

(* spaces *)

| space+  { token lexbuf; }
| newline { next_line lexbuf; token lexbuf; }

(* Comments *)

| ('#' | "//") all_but_newline*     { token lexbuf; }

(* identifiers / keywords *)
| ident as id
{
  try Hashtbl.find kwd_table id with Not_found ->
  IDENT (Ident.create_unbound id, parse id parse_typ)
}

(* This is copy/pasted to its own lexer *)
| "nat"  { TYPE Nat }
| 'u' (('<' (dir as d) '>')?) (mtyp as m) ('x' (integer as i))? {
  let dir = parse_opt ~default:Utils.default_dir d parse_dir in
  let m = parse m parse_mtyp in
  let xi = match i with None -> 1 | Some i -> int_of_string i in
  TYPE (Uint (dir, m, xi))
}
| 'b' (('<' (dir as d) '>')?) (integer as i) {
  let dir = parse_opt ~default:Utils.default_dir d parse_dir in
  TYPE (Uint (dir, Mint 1, int_of_string i))
}
| 'v' (('<' (dir as d) '>')?) (integer as i) {
  let dir = parse_opt ~default:Utils.default_dir d parse_dir in
  TYPE (Uint (dir, Utils.default_m, int_of_string i))
}

(* strings *)
| '"' (( [^'\\' '"'] | '\\' '.' ) + as str) '"' { STRING str }

(* symbols *)
| "[]"   { ARRAY }
| "("    { LPAREN    }
| ")"    { RPAREN    }
| "["    { LBRACKET  }
| "]"    { RBRACKET  }
| "{"    { LCURLY    }
| "}"    { RCURLY    }
| "="    { EQUAL     }
| "<<<"  { LROTATE   }
| "<<"   { LSHIFT    }
| ">>>"  { RROTATE   }
| ">>!"  { RASHIFT   }
| ">>"   { RSHIFT    }
| "<"    { LT        }
| ">"    { GT        }
| ","    { COMMA     }
| ":"    { COLON     }
| ";"    { SEMICOLON }
| "|"    { PIPE      }
| ".."   { RANGE     }
| "&"    { AND       }
| "~"    { TILDE     }
| "!"    { BANG      } (* for now, both ~ and ! have the same semantic *)
| "^"    { XOR       }
| "+"    { PLUS      }
| "*"    { STAR      }
| "-"    { DASH      }
| "/"    { SLASH     }
| "%"    { MOD       }

(* integers *)
| integer as i { INT (int_of_string i) }

(* end of file *)
| eof   { EOF }

(* error *)
| _ as c { raise (Lexing_error (lexbuf, (fun ppf () -> Format.fprintf ppf "Unexpected character \'%c\'" c))) }


and parse_dir = parse
| 'H' { Hslice }
| 'V' { Vslice }
| 'B' { Bslice }
| integer as i { Mslice (int_of_string i) }
| '\'' ident as id { Varslice (Ident.create_unbound id) }
| _ { raise Exit }

and parse_mtyp = parse
| integer as i { Mint (int_of_string i) }
| '\'' (ident as id) { Mvar (Ident.create_unbound id) }

and parse_typ = parse
| "nat"  { Some Nat }
| 'u' (('<' (dir as d) '>')?) (mtyp as m) ('x' (integer as i))? {
  let dir = parse_opt ~default:Utils.default_dir d parse_dir in
  let m = parse m parse_mtyp in
  let xi = match i with None -> 1 | Some i -> int_of_string i in
  Some (Uint (dir, m, xi))
}
| 'b' (('<' (dir as d) '>')?) (integer as i) {
  let dir = parse_opt ~default:Utils.default_dir d parse_dir in
  Some (Uint (dir, Mint 1, int_of_string i))
}
| 'v' (('<' (dir as d) '>')?) (integer as i) {
  let dir = parse_opt ~default:Utils.default_dir d parse_dir in
  Some (Uint (dir, Utils.default_m, int_of_string i))
}
| _ { None }
