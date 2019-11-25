

{
open Lexing
open Usuba_AST
open Parser_tp
open Utils

exception SyntaxError of string

(* keyword table *)
let kwd_table = Hashtbl.create 10
let _ =
  List.iter (fun (a,b) -> Hashtbl.add kwd_table a b)
    [
      "rs",        TOK_RS;
      "in",        TOK_IN;
      "and",       TOK_AND;
      "or",        TOK_OR;
      "xor",       TOK_XOR;
      "not",       TOK_NOT;
      "setcst",    TOK_SETCST;
      "setcstall", TOK_SETCSTALL;
      "refresh",   TOK_REFRESH;
    ]

let next_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_bol = pos.pos_cnum; (*lexbuf.lex_curr_pos;*)
                 pos_lnum = pos.pos_lnum + 1
    }
}


rule token = parse

| "__END__" { TOK_EOF }

(* spaces *)
| [' ' '\t']+  { token lexbuf; }
| ['\n']       { next_line lexbuf; token lexbuf; }
| '#' [^ '\n' '\r']*     { token lexbuf; }
| "//" [^ '\n' '\r']*    { token lexbuf; }


(* identifiers / keywords *)
| ['a' - 'z' 'A' - 'Z' '_' ] ['a' - 'z' 'A' - 'Z' '_' '[' ']' '0' - '9']* as id
{ try Hashtbl.find kwd_table id with Not_found -> TOK_id id }

(* symbols *)
| "("    { TOK_LPAREN    }
| ")"    { TOK_RPAREN    }
| "="    { TOK_EQUAL     }
| "<<<"  { TOK_LROTATE   }
| "<<"   { TOK_LSHIFT    }
| ">>>"  { TOK_RROTATE   }
| ">>"   { TOK_RSHIFT    }

(* integers *)
| ['0'-'9']+ as i { TOK_int (int_of_string i) }
| "0x" ['0'-'9' 'a'-'f' 'A'-'F']+ as i { TOK_int (int_of_string i) }

(* end of file *)
| eof   { TOK_EOF }

(* error *)
| _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
