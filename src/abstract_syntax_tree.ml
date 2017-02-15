
type undef = AST_undef

type typ = AST_bool

type ident = string

type constr = string

type clock = string

type op = AST_and | AST_or | AST_xor | AST_not
                            
type expr = AST_const of int (* it's actually a boolean *)
          | AST_var   of ident
          | AST_tuple of expr list
          | AST_op    of op * (expr list)
          | AST_fun   of ident * (expr list)
          | AST_mux   of expr * constr * ident
          | AST_demux of ident * ((constr * expr) list)

type pat = ident list
                            
type deq = (pat * expr) list

type p = (ident * typ * undef) list
                                
type def = ident * p * p * deq
                                
type prog = def list
