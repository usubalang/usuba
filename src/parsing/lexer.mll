

{
open Lexing
open Usuba_AST
open Parser
open Utils

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
     "merge", TOK_MERGE;
     "when", TOK_WHEN;
     "whenot", TOK_WHENOT;
     "on", TOK_ON;
     "onot", TOK_ONOT;
     "base", TOK_BASE;
     "Shuffle", TOK_SHUFFLE;
     "_inline", TOK_INLINE;
     "_no_inline", TOK_NOINLINE;
     "_unroll", TOK_UNROLL;
     "_no_unroll", TOK_NOUNROLL;
     "_interleave", TOK_INTERLEAVE;
     "_no_opt", TOK_NOOPT;
     "const", TOK_CONST;
     "lazyLift", TOK_LAZYLIFT;
    ]

let next_line lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_bol = pos.pos_cnum; (*lexbuf.lex_curr_pos;*)
                 pos_lnum = pos.pos_lnum + 1
    }

(* if bitslicing is true then the program is purely bitsliced.
   it means that u_n are equivalent to u_1xm.
   if bitslicing is false, then the program is vectorized, 
   and u_n mean u_nx1 
   *)
let bitslicing = ref true
                     
}


rule token = parse

| "__END__" { TOK_EOF }

(* pragmas *)
| "#pragma" [' ']+ (['a' - 'z']+ as pragma)    
  { (match pragma with
      | "bitslicing"    -> bitslicing := true
      | "vectorization" -> bitslicing := false
      | _ -> raise (Error ("Unknown pragma " ^ pragma)));
    token lexbuf }
                                   
(* spaces *)
| [' ' '\t']+  { token lexbuf; }
| ['\n']       { next_line lexbuf; token lexbuf; }
| '#' [^ '\n' '\r']*     { token lexbuf; }
| "//" [^ '\n' '\r']*    { token lexbuf; }
                                   
(* types *)
| "u" (['0' - '9']+ as n)
      { match !bitslicing with
        | true  -> TOK_type (Int(1,int_of_string n))
        | false -> TOK_type (Int(int_of_string n,1)) }
| "u" (['0' - '9']+ as n) "x" (['0' - '9']+ as m)
           { TOK_type (Int(int_of_string n,int_of_string m)) }
| "bool"   { TOK_type Bool }
| "nat"    { TOK_type Nat  }

(* identifiers / keywords *)
| "True"   { TOK_constr True  }
| "False"  { TOK_constr False }
| ['a'-'z' 'A'-'Z' '_' ] ['a'-'z' 'A'-'Z' '0'-'9' '_' '\'']* as id
{ try Hashtbl.find kwd_table id with Not_found -> TOK_id (fresh_ident id) }

(* symbols *)
| "->"   { TOK_ARROW     }
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
| "&"    { TOK_AND       }
| "~"    { TOK_TILDE     }
| "!"    { TOK_TILDE     } (* for now, both ~ and ! have the same semantic *)
| "^"    { TOK_XOR       }
| "+"    { TOK_PLUS      }
| "*"    { TOK_STAR      }
| "-"    { TOK_DASH      }
| "/"    { TOK_SLASH     }
| "%"    { TOK_MOD       }
         
(* integers *)
| ['0'-'9']+ as i { TOK_int (int_of_string i) }
                 
(* end of file *)
| eof   { TOK_EOF }

(* error *)
| _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
