(******************************************************************* )
                        expand_parameters.ml


   Expands arrays as needed to make sure functions have as much
   parameters as they need.

   This is mainly performed by the functions match_args and match_ret,
   which are both very similar: they iterate a function's parameters
   (resp return values) and it's arguments (resp left hand-side of the
   assigment) in its invocation, one bye one. If at some point, the
   two of them don't have the same size, then the smallest one needs
   to be expanded. Example:

      f : b4 -> b4 a,b,x,y : b2 (a,b) = f(x,y)

     We'll iterate [b4] vs [x;y] for the params, and [b4] vs [a;b] for
     the returns (in practice, we iterate the var_d rather than just the
     types for the function's params/returns, but you get the idea).
     First, we find that b4 > typ(x). Therefore, b4 gets expanded to
     b1,b1,b1,b1. Then, we restart: we'll iterate [b1;b1;b1;b1] vs
     [x;y]. Then, we'll find that b1 < typ(x). Therefore, x needs to be
     expanded to x[0], x[1]. Then, restart. Then y will be expanded. You
     get the idea.

   Note that expanding a function's arguments is simple: it just means
   expanding some variables (x becomes x[0] and x[1] for instance). On
   the other hand, expanding a functions parameters (parameter ==
   expected argument) is more complexe since it requires propagating
   the expansion inside the function's body. For instance, consider:

       node f(a:b4) returns (b:b4) let b = a tel

     expanding |a| require changing the types of |f|'s parameter to:

      node f(a0,a1,a2,a3) return (b:b4) let b = (a0,a1,a2,a3) tel

   Also, when a node call to |f| in a node |g| is updated, |g| must be
   entirely re-processed, as previous calls to |f| may have now become
   invalid. This is done by raising an exception (|Updated|).  On the
   other hand, when a calls arguments are updated, it doesn't
   invalidate anything before (as it didn't change any type), and
   there is therefore no reason to re-process a node. Also, when a
   node's parameters are expanded, the whole program must be
   re-processed, as several nodes could be calling the same node f,
   and expanding f's parameter may invalidate some of the calls.

   This module can introduce some unrolling: consider for instance,
       forall i in [1, 5] { x[i] = x[i-1] ^ 2 }
   If x is a function's return value, then expanding it would
   transform it into (x0, ..., xn). Obviously, the forall now need to
   be unrolled.

   Often, there is a choice between expanding the innermost dimesion
   and expanding the outermost one. For instance:

      b1[2][4]  ---> b1[2], b1[2], b1[2], b1[2]
        x       -> x0, x1, x2, x3
        x[1]    -> x0[1], x1[1], x2[1], x3[1]
        x[1][2] -> x2[1]

      b1[2][4]  ---> b1[4], b1[4]
        x       -> x0, x1
        x[1]    -> x0[1], x1[1]
        x[1][2] -> x1[2]

   Expaning the outermost one (first case of the example) seems
   easier, so that's what I went for.
   TODO: expand in a way to make matching easier with the
   arguments. Depending on the arguments, it may make more sense to
   expand on a dimension rather than an other one.


( *******************************************************************)

open Usuba_AST
open Basic_utils
open Utils
open Printf


exception Updated
exception Need_unroll

let stable = ref false

(* Accessors to get the body and vars of a node; in order to avoid
   inline pattern-matching. *)
let get_body = function
  | Single(_,body) -> body
  | _ -> assert false
let get_vars = function
  | Single(vars,_) -> vars
  | _ -> assert false


(* Using a custom unroller: unrolling is only done by necessity (ie,
   when we unroll a loop, we don't want t unroll nested ones. *)
(* Only very few comments, but everything is fairly straight-forward:
   the idea is just to reconstruct an AST where occurences of the
   iterator of the loop being unrolled has been replaced with its
   value for the current iteration. *)
module Unroll = struct
  let rec unroll_var (env_it:(ident,int) Hashtbl.t) (v:var) : var =
    match v with
    | Var _ -> v
    | Index(v',ae) -> Index(unroll_var env_it v',simpl_arith env_it ae)
    | _ -> assert false

  let rec unroll_expr (env_it:(ident,int) Hashtbl.t) (e:expr) : expr =
    match e with
    | Const _        -> e
    | ExpVar v       -> ExpVar (unroll_var env_it v)
    | Tuple  l       -> Tuple (List.map (unroll_expr env_it) l)
    | Not e          -> Not (unroll_expr env_it e)
    | Shift(op,e,ae) -> Shift(op,unroll_expr env_it e,simpl_arith env_it ae)
    | Log(op,x,y)    -> Log(op,unroll_expr env_it x,unroll_expr env_it y)
    | Shuffle(v,l)   -> Shuffle(unroll_var env_it v,l)
    | Arith(op,x,y)  -> Arith(op,unroll_expr env_it x,unroll_expr env_it y)
    | Fun(f,l)       -> Fun(f,List.map (unroll_expr env_it) l)
    | _ -> assert false

  let rec unroll_deq (env_it:(ident,int) Hashtbl.t) (deq:deq) : deq =
    { deq with content =
       match deq.content with
       | Eqn(lhs,e,sync) ->
          Eqn(List.map (unroll_var env_it) lhs,
              unroll_expr env_it e, sync)
       | Loop(i,ei,ef,dl,opts) ->
          Loop(i,simpl_arith env_it ei,simpl_arith env_it ef,
               List.map (unroll_deq env_it) dl, opts) }

  (* |i|, |ei|, |ef| and |deqs| are from the loop being expanded,
     which should be like Loop(i, ei, ef, deqs, _)
   *)
  let do_unroll (i:ident) (ei:int) (ef:int) (deqs:deq list) : deq list =
    let env_it = Hashtbl.create 1 in
    flat_map (fun i_val -> Hashtbl.replace env_it i i_val;
                           List.map (unroll_deq env_it) deqs)
      (gen_list_bounds ei ef)
end

(* We need two functions to propagate the expansion into variables,
   because x and x[_]+ (where x[_]+ means "x indexed at least once")
   must not be expanded in the same manner:
     x becomes x0, x1, ..., xn
   while
     x[k] becomes xk
   and x[k][i]
     becomes xk[i]
   As you see, x alone becomes a list, while any index into x becomes
   a variable.

   propagate_var does the first one (ie expanding x into (x1,...,xn),
   while propagate_var_in_index does the second (x[k] becomes xk).
   (this should make it clear why propagate_var_in_index can therefore
    only return a single var while propagate_var returns a var list)
 *)
let rec propagate_var_in_index (expand_env:(var,var list) Hashtbl.t)
          (v:var) : var =
  match v with
  | Index(v',i) ->
     (match Hashtbl.find_opt expand_env v' with
      | Some [vr] -> Index(vr,i)
      | None      -> Index(propagate_var_in_index expand_env v',i)
      | Some _    -> (* If the element found in |expand_env| is a
                        list, it means that the individual Index where
                        not found, which means that one/some of them
                        contains loop variables*)
         raise Need_unroll)
  | _ -> (* Not possible since we can only be there is |v| needs
            expansion propagation *)
     assert false

(* See propagate_var_in_index's comment *)
let rec propagate_var (expand_env:(var,var list) Hashtbl.t) (v:var) : var list =
  (* Indices need to be canonical in order to match in |expand_env| *)
  let v = simpl_var_indices v in
  match Hashtbl.find_opt expand_env (get_var_base v) with
  | None -> [ v ] (* Not the variable we are expanding *)
  | Some _ -> (* It's the variable we are expanding *)
     match Hashtbl.find_opt expand_env v with
     | Some v' -> v' (* Not a nested index *)
     | None -> (* It's the variable we want to index, but as a
                  multi-level Index *)
        [ propagate_var_in_index expand_env v ]

(* propagate_expr just reccursve through the expressions to call
   propagate_var. *)
let rec propagate_expr (expand_env:(var,var list) Hashtbl.t) (e:expr) : expr =
  match e with
  | Const _ -> e
  | ExpVar v -> begin match propagate_var expand_env v with
                      | [ v ] -> ExpVar v
                      | l -> Tuple(List.map (fun x -> ExpVar x) l) end
  | Tuple l -> Tuple(List.map (propagate_expr expand_env) l)
  | Not e -> Not (propagate_expr expand_env e)
  | Shift(op,e,ae) ->
     Shift(op,propagate_expr expand_env e,ae)
  | Log(op,e1,e2) ->
     Log(op,propagate_expr expand_env e1,propagate_expr expand_env e2)
  | Shuffle(v,pat) ->
     Shuffle(List.hd (propagate_var expand_env v),pat)
  | Arith(op,e1,e2) ->
     Arith(op,propagate_expr expand_env e1,propagate_expr expand_env e2)
  | Fun(x,es) ->
     let l = List.map (propagate_expr expand_env) es in
     (match l with
      | [Tuple l'] -> Fun(x,l')
      | _ -> Fun(x,l))
  | _ -> assert false

(* propagate_deqs iterates through deqs mainly to call propagate_expr
   and propagate_vars. Note that in some case (described above in this
   file), loops must be expanded; the catcher for Need_unroll is here
   and takes care of unrolling loops. *)
let rec propagate_deqs (expand_env:(var,var list) Hashtbl.t) (deqs:deq list) : deq list =
  flat_map
    (fun d -> match d.content with
     | Eqn(l,e,sync) ->
        [ { d with content = Eqn(flat_map (propagate_var expand_env) l,
                                propagate_expr expand_env e, sync) } ]
     | Loop(i,ei,ef,dl,opts) ->
        try
          [ { d with content = Loop(i,ei,ef,propagate_deqs expand_env dl,opts) } ]
        with Need_unroll ->
          (* raise one more Need_unroll if ei/ef can't be computed
             because they are in a nested loop and use surrounding
             loop variable *)
          let ei = try eval_arith_ne ei with Not_found -> raise Need_unroll in
          let ef = try eval_arith_ne ef with Not_found -> raise Need_unroll in

          let new_eqns = Unroll.do_unroll i ei ef dl in
          propagate_deqs expand_env new_eqns
    ) deqs


(* See expand_p's comment.
   |f|: the function in which we are expanding
   |vd|: the variable to expand
   |is_p_in|: if true, then |vd| is in f.p_in, otherwise in f.p_out
   |size|: the size of the array layer being removed from |vd|
   |new_typ|: the type of |vd| after removing its outermost array
*)
let expand_in_node (env_fun:(ident,def) Hashtbl.t) (f:def) (vd:var_d)
      (size:int) (new_typ:typ) (is_p_in:bool) : unit =
  (* |expand_env| contains the replacements to use for |vd|.
     For instance:
        x becomes x0, x1, ..., xn
      But also,
        x[0] becomes x0, x[1] becomes x1, ...
   *)
  let expand_env = Hashtbl.create 100 in
  (* First, add the binding to expand the whole array into variables. *)
  Hashtbl.replace expand_env (Var vd.vd_id)
    (List.map (fun i -> Var(fresh_suffix vd.vd_id (sprintf "%d'" i)))
       (gen_list_0_int size));
  (* Then, add the bindings to expand Index into variables, and
     generate |vd|'s replacement in p_in or p_out *)
  let new_p =
    List.map
      (fun i -> let id' = fresh_suffix vd.vd_id (sprintf "%d'" i) in
                Hashtbl.replace expand_env (Index(Var vd.vd_id,Const_e i)) [ Var id' ];
                make_var_d id' new_typ vd.vd_opts vd.vd_orig)
      (gen_list_0_int size) in

  (* propagating thoughout |f|'s body *)
  let body = propagate_deqs expand_env (get_body f.node) in

  (* Updating |f|: its body have been updated, and either its p_in or
     p_out need to be updated. *)
  let replace l e e' = flat_map (fun x -> if x = e then e' else [x]) l in
  let new_node =
    if is_p_in then
      { f with p_in = replace f.p_in (make_var_d vd.vd_id vd.vd_typ
                                                 vd.vd_opts vd.vd_orig) new_p;
               node = Single(get_vars f.node,body); }
    else
      { f with p_out = replace f.p_out (make_var_d vd.vd_id vd.vd_typ
                                                   vd.vd_opts vd.vd_orig) new_p;
               node = Single(get_vars f.node,body); } in
  Hashtbl.replace env_fun new_node.id new_node


(* Expands |vd| in |f|. if |is_p_in| is true, then |vd| is in |f|'s
   p_in, otherwise, it is in its p_out. This expansion is propagated
   to |f|'s body using |expand_in_node|, which updates |env_fun|. *)
let expand_p (env_fun:(ident,def) Hashtbl.t) (f:def) (vd:var_d) (is_p_in:bool) : unit =

  (* Getting the size of the array we are expanding, and the new type
     of |vd|. The size is useful because `x` would be expanded to `x0,
     x1, ..., xn`, and this n is the size of the outer array of |vd|
     that we are removing. (note that in practice, we skip the "Range"
     step and expand it directly) *)
  let (size,new_typ) =
    match vd.vd_typ with
    | Uint(dir,m,n) when n > 1 -> (n, Uint(dir,m,1))
    | Array(typ',size) -> (eval_arith_ne size, typ')
    | _ -> assert false in

  (* Actually performing the expansion *)
  expand_in_node env_fun f vd size new_typ is_p_in


(* |e| must be an ExpVar (since this is running after Unfold_unnest,
   and |e| is a function's argument. This function will expand one
   layer of |e|. (ie, if |e| is a 2d array, it will be come a list of
   1d arrays, rather than a List of list of non-arrays) *)
let rec expand_expr (env_var:(ident,typ) Hashtbl.t) (e:expr) : expr list =
  match e with
  | Const _ -> [ e ]
  | ExpVar v -> List.map (fun x -> ExpVar x) (expand_var_partial env_var v)
  | _ -> Printf.fprintf stderr "Invalid expression: %s.\n"
                        (Usuba_print.expr_to_str_types e);
         assert false


(* See general explanations at the begining of the file. *)
let rec match_args (env_fun:(ident,def) Hashtbl.t)
          (env_var:(ident,typ) Hashtbl.t) (f:def) (p:p) (el:expr list) :
          expr list =
  match p, el with
  | [], [] -> []
  | vd :: tl_p, e :: tl_e ->
     begin
       match compare (typ_size vd.vd_typ) (get_expr_size env_var e) with
       | 0 -> (* The 2 types match *)
          e :: (match_args env_fun env_var f tl_p tl_e)
       | 1 -> (* |vd| (f's param) is bigger than |e| -> expand it *)
          expand_p env_fun f vd true;
          stable := false;
          raise Updated
       | -1 -> (* |e| is bigger than |vd| (f's param) -> expand it *)
          let e_start = expand_expr env_var e in
          stable := false;
          (* No need to "raise Updated": expanding |e| in this
             function call doesn't affect the previous function
             calls. *)
          match_args env_fun env_var f p (e_start @ tl_e)
       | _ -> assert false (* compare can only return -1/0/1 *)
     end
  | _ -> (* would mean that both lists are not the same size (and
            since one of them is empty, it means that expansion is
            over). This case cannot happen if type-checking was
            successful. *)
     assert false

(* match_ret follows the same pattern as match_args. The only
   difference is that this one taks as last argument a "var list"
   instead of a "expr list" (because left hand-side of equations are
   variables). *)
let rec match_ret (env_fun:(ident,def) Hashtbl.t)
          (env_var:(ident,typ) Hashtbl.t) (f:def) (p:p) (vars:var list) :
          var list =
  match p,vars with
  | [], [] -> []
  | (vd :: tl_p), (v :: tl_v) ->
     begin
       match compare (typ_size vd.vd_typ) (get_var_size env_var v) with
       | 0 -> (* The 2 types match *)
          v :: (match_ret env_fun env_var f tl_p tl_v)
       | 1 -> (* |vd| (f's returns) is bigger than |v| -> expand it *)
          expand_p env_fun f vd false;
          stable := false;
          raise Updated
       | -1 -> (* |e| is bigger than |vd| (f's param) -> expand it *)
          let vars_start = expand_var_partial env_var v in
          stable := false;
          match_ret env_fun env_var f p (vars_start @ tl_v)
       | _ -> assert false
     end
  | _ -> (* would mean that both lists are not the same size (and
            since one of them is empty, it means that expansion is
            over). This case cannot happen if type-checking was
            successful. *)
     assert false


let rec expand_deq (env_fun:(ident,def) Hashtbl.t)
                   (env_var:(ident,typ) Hashtbl.t) (deq:deq) : deq =
  { deq with content =
    match deq.content with
    | Eqn(lhs,Fun(id,args),sync) ->
       if is_builtin id then deq.content
       else
         let f = Hashtbl.find env_fun id in
         let args = match_args env_fun env_var f f.p_in args in
         let ret  = match_ret  env_fun env_var f f.p_out lhs in
         Eqn(ret,Fun(id,args),sync)
    | Loop(i,ei,ef,dl,opts) ->
       Hashtbl.add env_var i Nat;
       let res = Loop(i,ei,ef,List.map (expand_deq env_fun env_var) dl,opts) in
       Hashtbl.remove env_var i;
       res
    | _ -> deq.content } (* Not a Funcall, not a Loop, ignoring. *)


let rec expand_def (env_fun:(ident,def) Hashtbl.t) (def:def) : unit =
  try
    match def.node with
    | Single(vars,body) ->
       let env_var = build_env_var def.p_in def.p_out vars in
       Hashtbl.replace env_fun def.id
                  { def with node = Single(vars,List.map (expand_deq env_fun env_var) body) }
    | Table _ -> () (* Can end up here with --keep-tables *)
    | _ -> assert false
  with
    (* Something was expanded -> reccursive call as this might not
       have been expanded enough. This is because we try to expand as
       little as possible: a 2d arrat will be expanded to some 1d
       arrays and not to a lot of variables. *)
    Updated -> expand_def env_fun def


let run _ (prog:prog) (conf:config) : prog =

  let env_fun = Hashtbl.create 100 in
  List.iter (fun node -> Hashtbl.add env_fun node.id node) prog.nodes;

  (* Need to iterate to a fixpoint, as expanding an array might
     introduce new unbalancing. For instance, consider:
          f : (b2,b2) -> b4    and    x : b4
        f(x) will be expanded as f(x[0], x[1], x[2], x[3]),
        thus, f needs to be expanded to have for prototype
          f(b1,b1,b1,b1)
        After this expansion, other calls to f may become
        invalid... And fixing them might break this call to f...
   *)
  stable := false;
  while not !stable do
    stable := true;
    List.iter (fun node -> expand_def env_fun (Hashtbl.find env_fun node.id)) prog.nodes
  done;

  { nodes = List.map (fun node -> Hashtbl.find env_fun node.id) prog.nodes }


let as_pass = (run, "Expand_parameters")
