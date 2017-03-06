
exception Invalid_AST of string

type undef

type ident = string
               
type typ =
    Bool
  | Int of int
  | Array of typ * int (* usuba1 *)
             
type constr = string

type clock = string

type op = And | Or | Xor | Not
                            
type expr = Const  of int
          | Var    of ident
          | Access of ident * int
          | Field  of expr * int
          | Tuple  of expr list
          | Op     of op * expr list
          | Fun    of ident * expr list
          | Fun_i  of ident * int * expr list (* usuba1 - f[1] *)
          | Fun_v  of ident * ident * expr list (* usuba1 - f[i] *)
          | Mux    of expr * constr * ident
          | Demux  of ident * (constr * expr) list
          | Fby    of expr * expr * ident option
          | Fill_i of ident * int * pat
          | Nop

and left_asgn =
  | Ident of ident
  | Dotted of left_asgn * int
  | Index of ident * int (* usuba1 - a[5] *)
                               
and pat = left_asgn list                              
                            
type deq = (pat * expr) list

type p = (ident * typ * clock) list
                                
type def =
  | Single of ident * p * p * p * deq
  | Temporary of ident * p * p * p * deq
  | Multiple  of ident * p * p * (p * deq) list (* usuba1 - array of nodes*)
  | Perm of ident * p * p * int list (* usuba1 - permutation *)
  | MultiplePerm of ident * p * p * (int list) list (* usuba1 - array of perm *)
                                
type prog = def list
