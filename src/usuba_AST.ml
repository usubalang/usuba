
exception Invalid_AST of string

type undef

type ident = string
               
type typ =
    Bool
  | Int of int
  | Array of typ * int (* arrays *)
             
type constr = string

type clock = string

type op = And | Or | Xor | Not
                            
type expr = Const  of int
          | Var    of ident
          | Access of ident * int (* arrays *)
          | Field  of expr * int
          | Tuple  of expr list
          | Op     of op * expr list
          | Fun    of ident * expr list
          | Fun_i  of ident * int * expr list (* nodes arrays *)
          | Fun_v  of ident * ident * expr list (* nodes arrays + fill *)
          | Mux    of expr * constr * ident
          | Demux  of ident * (constr * expr) list
          | Fby    of expr * expr * ident option
          | Fill_i of ident * int * expr (* arrays *)
          | Nop

and left_asgn =
  | Ident of ident
  | Dotted of left_asgn * int
  | Index of ident * int (* arrays *)
                               
and pat = left_asgn list                              
                            
type deq = (pat * expr) list

type p = (ident * typ * clock) list
                                
type def =
  | Single of ident * p * p * p * deq
  | Temporary of ident * p * p * p * deq
  | Multiple  of ident * p * p * (p * deq) list (*array of nodes*)
  | Perm of ident * p * p * int list (* permutation *)
  | MultiplePerm of ident * p * p * (int list) list (* array of perm *)
  | Table of ident * p * p * int list (* lookup table *)
                                
type prog = def list
