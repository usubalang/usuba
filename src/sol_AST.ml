type ident = string

               
type log_op = And | Or | Xor
type arith_op = Add | Mul | Sub | Div

type typ = Bool | Int64 | Int128

type m = (ident * typ) list
                       
type p = m
               
type c =
  | Var of ident               (*   x               *)
  | Const of int               (*   v               *)
  | Tuple of c list            (*   (c, ... , c)    *)
  | State_var of ident         (*   state(x)        *)
  | Not of c                   (*   not c           *)
  | Log of log_op * c * c      (*   c op c          *)
  | Arith of arith_op * c * c  (*   c op c          *)

                    
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
