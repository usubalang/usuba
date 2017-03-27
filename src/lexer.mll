

{
open Lexing
open Usuba_AST
open Parser

exception SyntaxError of string

(* keyword table *)
let kwd_table = Hashtbl.create 10
let _ = 
  List.iter (fun (a,b) -> Hashtbl.add kwd_table a b)
    [
     "node",  TOK_NODE;
     "returns", TOK_RETURN;
     "vars", TOK_VAR;
     "let", TOK_LET;
     "tel", TOK_TEL;
     "perm", TOK_PERM;
     "table", TOK_TABLE;
     "fby", TOK_FBY;
     "forall", TOK_FORALL;
     "in", TOK_IN;
   ]

let next_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_bol = pos.pos_cnum; (*lexbuf.lex_curr_pos;*)
                 pos_lnum = pos.pos_lnum + 1
    }

}

rule token = parse

(* spaces *)
| [' ' '\t']+  { token lexbuf; }
| ['\n']       { next_line lexbuf; token lexbuf; }
| '#' [^ '\n' '\r']*     { token lexbuf; }

                           
| "uint_" (['0' - '9']+ as n)    { TOK_type (Int(int_of_string n))  }
| "u" (['0' - '9']+ as n)        { TOK_type (Int(int_of_string n))  }
| "bool"                         { TOK_type Bool                    }
| "nat"                          { TOK_type Nat                     }

(* identifiers / keywords *)
| ['a'-'z' 'A'-'Z' '_' ] ['a'-'z' 'A'-'Z' '0'-'9' '_']* as id
{ try Hashtbl.find kwd_table id with Not_found -> TOK_id id }

(* symbols *)
| "("    { TOK_LPAREN    }
| ")"    { TOK_RPAREN    }
| "["    { TOK_LBRACKET  }
| "]"    { TOK_RBRACKET  }
| "{"    { TOK_LCURLY    }
| "}"    { TOK_RCURLY    }
| "="    { TOK_EQUAL     }
| "<<<"  { TOK_LROTATE   }
| "<<"   { TOK_LSHIFT    }
| ">>>"  { TOK_RROTATE   }
| ">>"   { TOK_RSHIFT    }
| "<"    { TOK_LT        }
| ">"    { TOK_GT        }
| ","    { TOK_COMMA     }
| "::"   { TOK_TWO_COLON }
| ":"    { TOK_COLON     }
| ";"    { TOK_SEMICOLON }
| "|"    { TOK_PIPE      }
| ".."   { TOK_RANGE     }
| "."    { TOK_DOT       }
| "&"    { TOK_AND       }
| "~"    { TOK_TILDE     }
| "!"    { TOK_TILDE     } (* for now, both ~ and ! have the same semantic *)
| "^"    { TOK_XOR       }
| "+"    { TOK_PLUS      }
| "*"    { TOK_STAR      }
| "-"    { TOK_DASH      }
| "/"    { TOK_SLASH     }
         
(* integers *)
| ['0'-'9']+ as i { TOK_int (int_of_string i) }
                 
(* end of file *)
| eof   { TOK_EOF }

(* error *)
| _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
