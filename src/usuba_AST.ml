
type nat =
| O
| S of nat



type ident = { uid : int; name : string }

type typ =
| ATOM of nat
| TUP of typ list

type clock =
| Defclock
| Base
| On of clock * ident
| Onot of clock * ident

type val0 =
| Atom of nat * int
| Tup of val0 list

type arith_op =
| Add
| Mul
| Sub
| Div
| Mod

type arith_expr =
| Const_e of int
| Var_e of ident
| Op_e of arith_op * arith_expr * arith_expr

type var =
| Var of ident
| Slice of var * arith_expr list
| Range of var * arith_expr * arith_expr

type log_op =
| And
| Or
| Xor
| Andn

type shift_op =
| Lshift
| Rshift
| Lrotate
| Rrotate

type expr =
| Const of val0
| ExpVar of var
| Tuple of expr list
| Not of expr
| Shift of shift_op * expr * arith_expr
| Log of log_op * expr * expr
| Fun of ident * expr list

type deq =
| Norec of var list * expr
| Rec of ident * arith_expr * arith_expr * deq list

type formal = { t : typ; c : clock }

type formals = (ident * formal) list

type def_i =
| Single of formals * deq list
| Multiple of (formals * deq list) list
| Perm of int list
| MultiplePerm of int list list
| Table of int list
| MultipleTable of int list list

type def_opt =
| Inline
| No_inline

type def = { d_name : string; p_in : formals; p_out : formals;
             opt : def_opt list; node : def_i }

type prog = (ident * def) list

type arch =
| Std
| MMX
| SSE
| AVX
| AVX512
| Neon
| AltiVec

type config = { block_size : int; key_size : int; warnings : bool;
                verbose : int; verif : bool; type_check : bool;
                clock_check : bool; check_tbl : bool; inlining : bool;
                inline_all : bool; cse_cp : bool; scheduling : bool;
                array_opti : bool; share_var : bool; precal_tbl : bool;
                archi : arch; bit_per_reg : int; bench : bool;
                rand_input : bool; runtime : bool; ortho : bool; openmp : 
                int }
