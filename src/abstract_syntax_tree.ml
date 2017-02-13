
type undef = AST_undef

type typ = AST_int

type ident = AST_ident of string

type clock = AST_clock of string

type op = AST_and | AST_or | AST_xor | AST_not
                            
type e = AST_const of int
       | AST_var   of ident
       | AST_tuple of e list
       | AST_op    of op * (e list)
       | AST_fun   of ident * (e list)
       | AST_mux   of e * ident * ident
       | AST_demux of ident * ((ident * e) list)

type pat = AST_pat of ident list
                            
type deq = AST_deq of (pat * e) list

type p = AST_p of (ident * undef * undef) list
                                
type def = AST_def of ident * p * p * deq
                                                               
type prog = def list
