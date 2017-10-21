
type ident = string

type clock =
| Defclock
| Base
| On of clock * ident
| Onot of clock * ident

type log_op =
| And
| Or
| Xor
| Andn

type arith_op =
| Add
| Mul
| Sub
| Div
| Mod

type shift_op =
| Lshift
| Rshift
| Lrotate
| Rrotate

type arith_expr =
| Const_e of int
| Var_e of ident
| Op_e of arith_op * arith_expr * arith_expr

type typ =
| Bool
| Int of int
| Nat
| Array of typ * arith_expr

type constr =
| True
| False

type var =
| Var of ident
| Field of var * arith_expr
| Index of ident * arith_expr
| Range of ident * arith_expr * arith_expr
| Slice of ident * arith_expr list

type expr =
| Const of int
| ExpVar of var
| Tuple of expr list
| Not of expr
| Shift of shift_op * expr * arith_expr
| Log of log_op * expr * expr
| Arith of arith_op * expr * expr
| Fun of ident * expr list
| Fun_v of ident * arith_expr * expr list
| Fby of expr * expr * ident option
| When of expr * constr * ident
| Merge of ident * (constr * expr) list

type deq =
| Norec of var list * expr
| Rec of ident * arith_expr * arith_expr * deq list

type p = ((ident * typ) * clock) list

type def_i =
| Single of p * deq list
| Multiple of (p * deq list) list
| Perm of int list
| MultiplePerm of int list list
| Table of int list
| MultipleTable of int list list

type def_opt =
| Inline
| No_inline

type def = { id : ident; p_in : p; p_out : p; opt : def_opt list; node : def_i }

type prog = { nodes : def list }

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
                archi : arch; bench : bool; ortho : bool; openmp : int }
