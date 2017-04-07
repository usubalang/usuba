

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

(* intrinsics list *)
let _ = 
  List.iter (fun (a,b) -> Hashtbl.add kwd_table a b)
  [
    (* MMX *)
    "pand64", TOK_intrinsic Pand64;
    "por64", TOK_intrinsic Por64;
    "pxor64", TOK_intrinsic Pxor64;
    "pandn64", TOK_intrinsic Pandn64;
    "paddb64", TOK_intrinsic Paddb64;
    "paddw64", TOK_intrinsic Paddw64;
    "paddd64", TOK_intrinsic Paddd64;
    "psubb64", TOK_intrinsic Psubb64;
    "psubw64", TOK_intrinsic Psubw64;
    "psubd64", TOK_intrinsic Psubd64;
    (* SSE *)
    "pand128", TOK_intrinsic Pand128;
    "por128", TOK_intrinsic Por128;
    "pxor128", TOK_intrinsic Pxor128;
    "pandn128", TOK_intrinsic Pandn128;
    "paddb128", TOK_intrinsic Paddb128;
    "paddw128", TOK_intrinsic Paddw128;
    "paddd128", TOK_intrinsic Paddd128;
    "paddq128", TOK_intrinsic Paddq128;
    "psubb128", TOK_intrinsic Psubb128;
    "psubw128", TOK_intrinsic Psubw128;
    "psubd128", TOK_intrinsic Psubd128;
    "psubq128", TOK_intrinsic Psubq128;
    (* AVX *)          
    "vpand256", TOK_intrinsic VPand256;
    "vpor256", TOK_intrinsic VPor256;
    "vpxor256", TOK_intrinsic VPxor256;
    "vpandn256", TOK_intrinsic VPandn256;
    "vpaddb256", TOK_intrinsic VPaddb256;
    "vpaddw256", TOK_intrinsic VPaddw256;
    "vpaddd256", TOK_intrinsic VPaddd256;
    "vpaddq256", TOK_intrinsic VPaddq256;
    "vpsubb256", TOK_intrinsic VPsubb256;
    "vpsubw256", TOK_intrinsic VPsubw256;
    "vpsubd256", TOK_intrinsic VPsubd256;
    "vpsubq256", TOK_intrinsic VPsubq256;
    (* AVX-512 *)       
    "vpandd512", TOK_intrinsic VPandd512;
    "vpord512", TOK_intrinsic VPord512;
    "vpxord512", TOK_intrinsic VPxord512;
    "vpandnd512", TOK_intrinsic VPandnd512;
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
| "//" [^ '\n' '\r']*    { token lexbuf; }

                           
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
