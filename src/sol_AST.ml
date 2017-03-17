type ident = string

type op = And | Or | Xor | Not

type typ = Bool | Int64 | Int128

type m = (ident * typ) list
                       
type p = m
               
type c =
  | Var of ident           (*   x               *)
  | Const of int           (*   v               *)
  | Tuple of c list        (*   (c, ... , c)    *)
  | State_var of ident     (*   state(x)        *)
  | Op of op * c list      (*   op(c, ... , c)  *)

                    
type s =
  | Asgn of ident list * c               (*   x := c                      *)
  | State_asgn of ident list * c         (*   state(x) := c               *)
  | Skip                                 (*   skip                        *)
  | Reset of ident                       (*   o.reset()                   *)
  | Step of ident list * ident * c list  (*   (x,..,x) = o.step(c,..,c)   *)
                                   
type j = (ident * ident) list  (*   o:f, ... , o:f   *)

                         
type machine = ident * m * j * s list * p * p * p * s list
(* 
machine f = 
    memory m
    instances j
    reset() = s
    step(p) returns(p) = var p in s
 *)

                                                 
(* not described in the paper, but I think we quite need this: *)
type prog = machine list
