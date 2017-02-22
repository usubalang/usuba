
type undef

type typ = Bool | Int of int

type ident = string

type constr = string

type clock = string

type op = And | Or | Xor | Not
                            
type expr = Const of int
          | Var   of ident
          | Field of ident * int
          | Tuple of expr list
          | Op    of op * expr list
          | Fun   of ident * expr list
          | Mux   of expr * constr * ident
          | Demux of ident * (constr * expr) list

type left_asgn =
  | Ident of ident
  | Dotted of ident * int
                               
type pat = left_asgn list                              
                            
type deq = (pat * expr) list

type p = (ident * typ * clock) list
                                
type def = ident * p * p * p * deq
                                
type prog = def list
