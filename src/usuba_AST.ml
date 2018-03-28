
type nat =
| O
| S of nat

(** val option_map : ('a1 -> 'a2) -> 'a1 option -> 'a2 option **)

let option_map f = function
| Some a -> Some (f a)
| None -> None

(** val app : 'a1 list -> 'a1 list -> 'a1 list **)

let rec app l m =
  match l with
  | [] -> m
  | a :: l1 -> a :: (app l1 m)

type comparison =
| Eq
| Lt
| Gt

module Coq__1 = struct
 (** val add : nat -> nat -> nat **)
 let rec add n m =
   match n with
   | O -> m
   | S p -> S (add p m)
end
include Coq__1

module type EqLtLe =
 sig
  type t
 end

module MakeOrderTac =
 functor (O:EqLtLe) ->
 functor (P:sig
 end) ->
 struct
 end

module Pos =
 struct
  (** val compare_cont : comparison -> int -> int -> comparison **)

  let rec compare_cont = fun c x y -> if x=y then c else if x<y then Lt else Gt

  (** val compare : int -> int -> comparison **)

  let compare = fun x y -> if x=y then Eq else if x<y then Lt else Gt
 end

type 'x compare0 =
| LT
| EQ
| GT

module type OrderedType =
 sig
  type t

  val compare : t -> t -> t compare0

  val eq_dec : t -> t -> bool
 end

module OrderedTypeFacts =
 functor (O:OrderedType) ->
 struct
  module TO =
   struct
    type t = O.t
   end

  module IsTO =
   struct
   end

  module OrderTac = MakeOrderTac(TO)(IsTO)

  (** val eq_dec : O.t -> O.t -> bool **)

  let eq_dec =
    O.eq_dec

  (** val lt_dec : O.t -> O.t -> bool **)

  let lt_dec x y =
    match O.compare x y with
    | LT -> true
    | _ -> false

  (** val eqb : O.t -> O.t -> bool **)

  let eqb x y =
    if eq_dec x y then true else false
 end

module KeyOrderedType =
 functor (O:OrderedType) ->
 struct
  module MO = OrderedTypeFacts(O)
 end

module PositiveOrderedTypeBits =
 struct
  type t = int

  (** val compare : t -> t -> int compare0 **)

  let rec compare p y =
    (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
      (fun p0 ->
      (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
        (fun y0 -> compare p0 y0)
        (fun _ -> GT)
        (fun _ -> GT)
        y)
      (fun p0 ->
      (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
        (fun _ -> LT)
        (fun y0 -> compare p0 y0)
        (fun _ -> LT)
        y)
      (fun _ ->
      (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
        (fun _ -> LT)
        (fun _ -> GT)
        (fun _ -> EQ)
        y)
      p

  (** val eq_dec : int -> int -> bool **)

  let eq_dec x y =
    match Pos.compare x y with
    | Eq -> true
    | _ -> false
 end

(** val append : int -> int -> int **)

let rec append i j =
  (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
    (fun ii -> (fun p->1+2*p) (append ii j))
    (fun ii -> (fun p->2*p) (append ii j))
    (fun _ -> j)
    i

module PositiveMap =
 struct
  module E = PositiveOrderedTypeBits

  module ME = KeyOrderedType(E)

  type key = int

  type 'a tree =
  | Leaf
  | Node of 'a tree * 'a option * 'a tree

  type 'a t = 'a tree

  (** val empty : 'a1 t **)

  let empty =
    Leaf

  (** val is_empty : 'a1 t -> bool **)

  let rec is_empty = function
  | Leaf -> true
  | Node (l, o, r) ->
    (match o with
     | Some _ -> false
     | None -> (&&) (is_empty l) (is_empty r))

  (** val find : key -> 'a1 t -> 'a1 option **)

  let rec find i = function
  | Leaf -> None
  | Node (l, o, r) ->
    ((fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
       (fun ii -> find ii r)
       (fun ii -> find ii l)
       (fun _ -> o)
       i)

  (** val mem : key -> 'a1 t -> bool **)

  let rec mem i = function
  | Leaf -> false
  | Node (l, o, r) ->
    ((fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
       (fun ii -> mem ii r)
       (fun ii -> mem ii l)
       (fun _ -> match o with
                 | Some _ -> true
                 | None -> false)
       i)

  (** val add : key -> 'a1 -> 'a1 t -> 'a1 t **)

  let rec add i v = function
  | Leaf ->
    ((fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
       (fun ii -> Node (Leaf, None, (add ii v Leaf)))
       (fun ii -> Node ((add ii v Leaf), None, Leaf))
       (fun _ -> Node (Leaf, (Some v), Leaf))
       i)
  | Node (l, o, r) ->
    ((fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
       (fun ii -> Node (l, o, (add ii v r)))
       (fun ii -> Node ((add ii v l), o, r))
       (fun _ -> Node (l, (Some v), r))
       i)

  (** val remove : key -> 'a1 t -> 'a1 t **)

  let rec remove i m =
    (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
      (fun ii ->
      match m with
      | Leaf -> Leaf
      | Node (l, o, r) ->
        (match l with
         | Leaf ->
           (match o with
            | Some _ -> Node (l, o, (remove ii r))
            | None ->
              (match remove ii r with
               | Leaf -> Leaf
               | Node (t1, o0, t2) -> Node (Leaf, None, (Node (t1, o0, t2)))))
         | Node (_, _, _) -> Node (l, o, (remove ii r))))
      (fun ii ->
      match m with
      | Leaf -> Leaf
      | Node (l, o, r) ->
        (match o with
         | Some _ -> Node ((remove ii l), o, r)
         | None ->
           (match r with
            | Leaf ->
              (match remove ii l with
               | Leaf -> Leaf
               | Node (t1, o0, t2) -> Node ((Node (t1, o0, t2)), None, Leaf))
            | Node (_, _, _) -> Node ((remove ii l), o, r))))
      (fun _ ->
      match m with
      | Leaf -> Leaf
      | Node (l, _, r) ->
        (match l with
         | Leaf ->
           (match r with
            | Leaf -> Leaf
            | Node (_, _, _) -> Node (l, None, r))
         | Node (_, _, _) -> Node (l, None, r)))
      i

  (** val xelements : 'a1 t -> key -> (key * 'a1) list **)

  let rec xelements m i =
    match m with
    | Leaf -> []
    | Node (l, o, r) ->
      (match o with
       | Some x ->
         app (xelements l (append i ((fun p->2*p) 1))) ((i,
           x) :: (xelements r (append i ((fun p->1+2*p) 1))))
       | None ->
         app (xelements l (append i ((fun p->2*p) 1)))
           (xelements r (append i ((fun p->1+2*p) 1))))

  (** val elements : 'a1 t -> (key * 'a1) list **)

  let elements m =
    xelements m 1

  (** val cardinal : 'a1 t -> nat **)

  let rec cardinal = function
  | Leaf -> O
  | Node (l, o, r) ->
    (match o with
     | Some _ -> S (Coq__1.add (cardinal l) (cardinal r))
     | None -> Coq__1.add (cardinal l) (cardinal r))

  (** val xfind : key -> key -> 'a1 t -> 'a1 option **)

  let rec xfind i j m =
    (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
      (fun ii ->
      (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
        (fun jj -> xfind ii jj m)
        (fun _ -> None)
        (fun _ -> find i m)
        j)
      (fun ii ->
      (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
        (fun _ -> None)
        (fun jj -> xfind ii jj m)
        (fun _ -> find i m)
        j)
      (fun _ ->
      (fun f2p1 f2p f1 p ->
  if p<=1 then f1 () else if p mod 2 = 0 then f2p (p/2) else f2p1 (p/2))
        (fun _ -> None)
        (fun _ -> None)
        (fun _ -> find i m)
        j)
      i

  (** val xmapi : (key -> 'a1 -> 'a2) -> 'a1 t -> key -> 'a2 t **)

  let rec xmapi f m i =
    match m with
    | Leaf -> Leaf
    | Node (l, o, r) ->
      Node ((xmapi f l (append i ((fun p->2*p) 1))), (option_map (f i) o),
        (xmapi f r (append i ((fun p->1+2*p) 1))))

  (** val mapi : (key -> 'a1 -> 'a2) -> 'a1 t -> 'a2 t **)

  let mapi f m =
    xmapi f m 1

  (** val map : ('a1 -> 'a2) -> 'a1 t -> 'a2 t **)

  let map f m =
    mapi (fun _ -> f) m

  (** val xmap2_l :
      ('a1 option -> 'a2 option -> 'a3 option) -> 'a1 t -> 'a3 t **)

  let rec xmap2_l f = function
  | Leaf -> Leaf
  | Node (l, o, r) -> Node ((xmap2_l f l), (f o None), (xmap2_l f r))

  (** val xmap2_r :
      ('a1 option -> 'a2 option -> 'a3 option) -> 'a2 t -> 'a3 t **)

  let rec xmap2_r f = function
  | Leaf -> Leaf
  | Node (l, o, r) -> Node ((xmap2_r f l), (f None o), (xmap2_r f r))

  (** val _map2 :
      ('a1 option -> 'a2 option -> 'a3 option) -> 'a1 t -> 'a2 t -> 'a3 t **)

  let rec _map2 f m1 m2 =
    match m1 with
    | Leaf -> xmap2_r f m2
    | Node (l1, o1, r1) ->
      (match m2 with
       | Leaf -> xmap2_l f m1
       | Node (l2, o2, r2) ->
         Node ((_map2 f l1 l2), (f o1 o2), (_map2 f r1 r2)))

  (** val map2 :
      ('a1 option -> 'a2 option -> 'a3 option) -> 'a1 t -> 'a2 t -> 'a3 t **)

  let map2 f =
    _map2 (fun o1 o2 ->
      match o1 with
      | Some _ -> f o1 o2
      | None -> (match o2 with
                 | Some _ -> f o1 o2
                 | None -> None))

  (** val xfoldi :
      (key -> 'a1 -> 'a2 -> 'a2) -> 'a1 t -> 'a2 -> key -> 'a2 **)

  let rec xfoldi f m v i =
    match m with
    | Leaf -> v
    | Node (l, o, r) ->
      (match o with
       | Some x ->
         xfoldi f r (f i x (xfoldi f l v (append i ((fun p->2*p) 1))))
           (append i ((fun p->1+2*p) 1))
       | None ->
         xfoldi f r (xfoldi f l v (append i ((fun p->2*p) 1)))
           (append i ((fun p->1+2*p) 1)))

  (** val fold : (key -> 'a1 -> 'a2 -> 'a2) -> 'a1 t -> 'a2 -> 'a2 **)

  let fold f m i =
    xfoldi f m i 1

  (** val equal : ('a1 -> 'a1 -> bool) -> 'a1 t -> 'a1 t -> bool **)

  let rec equal cmp m1 m2 =
    match m1 with
    | Leaf -> is_empty m2
    | Node (l1, o1, r1) ->
      (match m2 with
       | Leaf -> is_empty m1
       | Node (l2, o2, r2) ->
         (&&)
           ((&&)
             (match o1 with
              | Some v1 ->
                (match o2 with
                 | Some v2 -> cmp v1 v2
                 | None -> false)
              | None -> (match o2 with
                         | Some _ -> false
                         | None -> true)) (equal cmp l1 l2)) (equal cmp r1 r2))
 end

module PM = PositiveMap

type ident = { uid : int; name : string }

type typ =
| ATOM of nat
| TUP of typ list

type clock =
| Defclock
| Base
| On of clock * ident
| Onot of clock * ident

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
| Const of nat * arith_expr
| ExpVar of var
| Tuple of expr list
| Not of expr
| Shift of shift_op * expr * arith_expr
| Log of log_op * expr * expr
| Fun of ident * arith_expr * expr list

type deq =
| Norec of var list * expr
| Rec of ident * arith_expr * arith_expr * deq list

type formal = { t0 : typ; c : clock }

type formals = (ident * formal) list

type def_i =
| Single of formals * deq list
| Perm of int list
| Table of nat * int list

type def_opt =
| Inline
| No_inline

type def = { d_name : string; p_in : formals; p_out : formals;
             opt : def_opt list; node : def_i list }

type prog = def PM.t

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
