type ident = string

(* TODO: add arithmetics operators *)
type op =
  | Pand | Por | Pxor | Pandn
  | VPand | VPor | VPxor | VPandn
                                  
type typ = Bool | Int64 | Int128 | Int256 | Int512

type m = (ident * typ) list
                       
type p = m
               
type c =
  | Var of ident               (*   x               *)
  | Const of int               (*   v               *)
  | State_var of ident         (*   state(x)        *)
  | Op of op * c * c           (*   op(c,c)         *)

                    
type s =
  | Asgn of ident * c                    (*   x := c                      *)
  | State_asgn of ident * c              (*   state(x) := c               *)
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
