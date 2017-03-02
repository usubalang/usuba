
exception Invalid_AST of string

type undef

type ident = string
               
type typ = (* usuba0 only has Bool and Int *)
    Bool
  | Int of int
  | Array of typ * int
             
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
          | Fby   of expr * expr * ident option
          | Nop

type left_asgn =
  | Ident of ident
  | Dotted of ident * int
                               
type pat = left_asgn list                              
                            
type deq = (pat * expr) list

type p = (ident * typ * clock) list
                                
type def = (* usuba0 only has Single *)
  | Single of ident * p * p * p * deq
  | Array  of ident * p * p * (p * deq) list
                                
type prog = def list
