open Usuba_AST
open Basic_utils
open Utils
open Usuba_print
open Printf

(* Note: this version of the type-checker is somewhat weak with regard
   to slicing types (Bitslicing, Hslicing, Vslicing). A better version
   should perform direction and word-size inference. That being said,
   both the slicing type and word size are themselves somewhat
   limited: a slicing type can either be generic or be a speficic
   one. A better type-system should allow constraints on both the
   slicing and word-size (so that the user can express that an
   algorithm works on B/H-slicing but not Vslicing for instance). *)

(* Most function return something: this is actually to build an AST in
   which Consts are typed. In the future, it should also (probably)
   perform dir/m inference. *)

(* Note: to check for out-of-bounds access, and to be able to easily
   expand types, loops are simulated. For instance, to type everything
   inside `forall x in [1,5] { deqs }`, we type deqs with x=1, then
   x=2, etc up to x=5. It might have been cleaner to perform some
   symbolic execution instead, or to delay bound checking to later in
   the pipeline, but doing this for now. *)

(* Note: the term "array" in this modules design both types Array and
   Uint of size > 1. *)

(* About the variable |backtrace|: ideally, Ocaml would have an option
   to die gracefully with a backtrace. In pratice, this doesn't work
   well. To provide meaningfull error messages, we use a (local)
   variable called |backtrace| which we update upon entering a
   function.
   |backtrace| is maintained as a list of string representing the
   backtrace in reverse order (meaning that when printing it, the most
   recent calls appear first).  *)
let print_backtrace (backtrace:string list) : unit =
  fprintf stderr "%s" ("backtrace:\n  " ^ (join "\n  " backtrace) ^ "\n")

(* The type-checker tries not to stop at the first error. However,
   given some errors, it wouldn't make sense to keep type-checking a
   given node. In that case, |Fatal_type_error| is raised. *)
exception Fatal_type_error

(* Exception raise whenever an arithmetic expression (array index for
   instance) cannot be computed statically because it depends on a
   parameter or something like that. *)
exception Uncomputable

(* On the other hand, when an error that doesn't prevent typing the
   current node is encountered, |error| is just set to true. *)
let error = ref false

(* Using a custom build_env_fun to check for node redefinition. *)
let build_env_fun (backtrace:string list) (prog:prog) : (ident,def) Hashtbl.t =
  let backtrace = "build_env_fun()" :: backtrace in
  let env = Hashtbl.create 100 in
  List.iter
    (fun def ->
      match Hashtbl.mem env def.id with
      | false -> Hashtbl.add env def.id def
      | true  ->
         eprintf "[Type error] Redefinition of function `%s'.\n"
           def.id.name;
         print_backtrace backtrace;
         error := true) prog.nodes;
  env

(* Using a custom build_env_var to check for variable redefinition. *)
let build_env_var (backtrace:string list) (p_in:p) (p_out:p) (vars:p) : (ident, typ) Hashtbl.t =
  let ret_env = Hashtbl.create 100 in

  let add_to_env (env:(ident,typ) Hashtbl.t) (vd:var_d) : unit =
    match Hashtbl.mem env vd.vd_id with
    | true ->
       eprintf
         "[Type error] Redeclaration of variable `%s'.\n"
         vd.vd_id.name;
       print_backtrace backtrace;
       error := true;
    | false -> Hashtbl.add env vd.vd_id vd.vd_typ in

  let add_all_to_env (is_local_var:bool) (p:p) : unit =
    let local_env = Hashtbl.create 100 in
    List.iter (add_to_env local_env) p;
    Hashtbl.iter (fun id typ ->
                  match Hashtbl.mem ret_env id with
                  | true  -> if is_local_var then
                               (eprintf "[Type error] Local variable `%s' is already declared as a parameter.\n"
                                        id.name;
                                print_backtrace backtrace;
                                error := true)
                            (* else, variable will be modified in place *)
                  | false -> Hashtbl.add ret_env id typ) local_env in


  add_all_to_env false p_in;
  add_all_to_env false p_out;
  add_all_to_env true vars;

  ret_env

(* Returns a string representation of env_it *)
let env_it_to_str (env_it:(ident,int) Hashtbl.t) : string =
  sprintf "{%s}"
    (join ", "
       (Hashtbl.fold
          (fun k v acc ->
            (sprintf "%s:%d" k.name v) :: acc) env_it []))

(* Using a custom eval_arith to display custom error if unexisting
   variables are used. *)
let rec eval_arith (backtrace:string list)
                   (env_var:(ident,typ) Hashtbl.t)
                   (env_it:(ident,int) Hashtbl.t)
                   (ae:arith_expr) : int =
  let backtrace = (sprintf "eval_arith(%s)" (arith_to_str ae)) :: backtrace in
  match ae with
  | Const_e n -> n
  | Var_e id  ->
     (match Hashtbl.find_opt env_it id with
      | Some i -> i
      | None -> match Hashtbl.find_opt env_var id with
                | Some Nat -> raise Uncomputable
                | _ ->
                   eprintf
                     "[Type error] Use of undeclared variable |%s|.\n(Iteror environment: %s)\n"
                     id.name (env_it_to_str env_it);
                   print_backtrace backtrace;
                   raise Fatal_type_error)
  | Op_e(op,x,y) ->
     let x' = eval_arith backtrace env_var env_it x in
     let y' = eval_arith backtrace env_var env_it y in
     match op with
     | Add -> x' + y'
     | Mul -> x' * y'
     | Sub -> x' - y'
     | Div -> x' / y'
     | Mod -> if x' >= 0 then x' mod y' else y' + (x' mod y')


(* Expands a typ into basic types (Uint(_,_,1) or Nat) *)
(* No |backtrace| or error handling: I don't see anything that could
   go wrong. *)
let rec expand_typ (typ:typ) : typ list =
  match typ with
  | Uint(_,_,1) -> [ typ ]
  | Uint(d,m,n) -> List.map (fun _ -> Uint(d,m,1)) (gen_list_int n)
  | Array(t,n)  -> flat_map (fun _ -> expand_typ t) (gen_list_int (eval_arith_ne n))
  | Nat         -> [ Nat ]

(* Returns the size of a type, where size is defined as its
   length. Called on a bitsliced type, it can be used to rebuild a bn
   from n b1. On a vsliced type, this is probably not that useful.. *)
let typ_size (typ:typ) : int = List.length (expand_typ typ)

(* Helper function to check that |idx| is less than the size |v_size|
   of the array it is indexing. *)
let check_in_bounds (backtrace:string list) (env_it:(ident,int) Hashtbl.t)
      (v_size:int) (idx:int) : unit =
  if idx >= v_size then
    (eprintf
       ("[Type error] out of bounds index: idx:%d >= size:%d\n(iterator environment: %s)\n")
       idx v_size (env_it_to_str env_it);
     print_backtrace backtrace;
     error := true)

(* Helper function to check that |idx| is less than the size |v_size|
   of the array it is indexing. |v_size| can be None if it's not
   computable. In that case, this function doesn't do anything. *)
let check_in_bounds_opt (backtrace:string list) (env_it:(ident,int) Hashtbl.t)
                        (v_size:int) (idx_opt:int option) : unit =
  match idx_opt with
  | Some idx -> check_in_bounds backtrace env_it v_size idx
  | None -> ()

(* Helper function to remove one level of array from |v|'s type. Used
   to compute type of Slices and Ranges.
   Performs no error checking: check_is_array should have been called
   before.  *)
let rec remove_outer_array (backtrace:string list)
      (env_var:(ident,typ) Hashtbl.t)
      (env_it:(ident,int) Hashtbl.t) (v:var) : typ =
  match get_var_type backtrace env_var env_it v with
  | Array(typ,_) -> typ
  | Uint(dir,m,n) when n > 1 -> Uint(dir,m,1)
  | _ -> assert false

(* Helper function to check that |v| is an array *)
and check_is_array (backtrace:string list)
      (env_var:(ident,typ) Hashtbl.t)
      (env_it:(ident,int) Hashtbl.t) (v:var) : unit =
  match get_var_type backtrace env_var env_it v with
  | Array _ -> ()
  | Uint(_,_,n) when n > 1 -> ()
  | Uint(dir,m,1) ->
     eprintf "[Type error] indexing non-array `%s' (type: %s).\n"
       (var_to_str v) (typ_to_str (Uint(dir,m,1)));
     (* Suggesting use of bm rather than um. *)
     (match m with
      | Mint n when n > 1 -> eprintf "Did you mean to use type b%d rather than %s?\n"
                               n (typ_to_str (Uint(dir,m,1)))
      | _ -> ());
     print_backtrace backtrace;
  | Nat ->
     eprintf "[Type error] indexing non-array `%s' (type: Nat).\n"
       (var_to_str v);
     print_backtrace backtrace;
  | _ ->
     (* Need this case to silence warning because Uint(_,_,0) isn't matchted *)
     assert false


(* Using a custom get_var_type for two reasons:
     - the one in utils doesn't support Slices/Ranges
     - we want to output a custom error message
       for unexisting variables (or invalid access)
     - we want to check for out of bounds accesses *)
and get_var_type (backtrace:string list)
          (env_var:(ident,typ) Hashtbl.t)
          (env_it:(ident,int) Hashtbl.t) (v:var) : typ =
  let backtrace = (sprintf "get_var_type(%s)" (var_to_str v)) :: backtrace in
  match v with
  | Var x -> (match Hashtbl.find_opt env_var x with
              | Some typ -> typ
              | None ->
                 match Hashtbl.find_opt env_it x with
                 | Some _ -> Nat
                 | _ -> eprintf "[Type error] variable `%s' undeclared.\n" x.name;
                        print_backtrace backtrace;
                        raise Fatal_type_error)
  | Index(v',idx) ->
     (* For Index, checking that:
         - |v'| is indeed an array
         - |idx| is withing the bounds of |v'| *)
     let idx = try Some (eval_arith backtrace env_var env_it idx)
               with Uncomputable -> None in
     (match get_var_type backtrace env_var env_it v' with
      | Array(t,size) ->
         check_in_bounds_opt backtrace env_it (eval_arith_ne size) idx;
         t
      | Uint(dir,m,n) when n > 1 ->
         check_in_bounds_opt backtrace env_it n idx;
         Uint(dir,m,1)
      | Uint(dir,m,1) ->
         eprintf "[Type error] indexing non-array `%s' (type: %s).\n"
           (var_to_str v') (typ_to_str (Uint(dir,m,1)));
         (* Suggesting use of bm rather than um. *)
         (match m with
          | Mint n when n > 1 -> eprintf "Did you mean to use type b%d rather than %s?\n"
                                   n (typ_to_str (Uint(dir,m,1)))
          | _ -> ());
         print_backtrace backtrace;
         raise Fatal_type_error
      | _ -> assert false)
  (* We don't perform bound checking for Slice/Range: it is done by
     expand_slices_ranges *)
  | Range(v',ae1,ae2) ->
     let ae1 = eval_arith backtrace env_var env_it ae1 in
     let ae2 = eval_arith backtrace env_var env_it ae2 in
     let range_size = abs(ae2 - ae1) + 1 in
     check_is_array backtrace env_var env_it v';
     Array(remove_outer_array backtrace env_var env_it v',Const_e range_size)
  | Slice(v',l) ->
     check_is_array backtrace env_var env_it v';
     Array(remove_outer_array backtrace env_var env_it v',Const_e (List.length l))

(* Removes Slices and Ranges from a var. At the same time, checks for
   out of bounds indices (even though they would be rechecked later as
   Index, it will be clearer for the developers to have error messages
   blaming a Range/Slice rather than some Index whose origin would be
   hard to understand). *)
let rec expand_slices_ranges (backtrace:string list)
          (env_var:(ident,typ) Hashtbl.t)
          (env_it:(ident,int) Hashtbl.t)
          (v:var) : var list =
  let backtrace = (sprintf "expand_slices_ranges(%s)"  (var_to_str v)) :: backtrace in

  (* Helper function to print an error indicating that |v| is not an array *)
  let not_an_array_error (v:var) (t:typ) : unit =
    eprintf
      "[Type error] index into non-array variable `%s' (type: %s)\n."
      (Usuba_print.var_to_str v) (Usuba_print.typ_to_str t);
    print_backtrace backtrace;
    raise Fatal_type_error in

  (* Main processing of |v| *)
  match v with
  | Var _   -> [ v ]
  | Index(v',idx) ->
     (* Need a reccursive call in case the Range/Slice isn't in last
        position (eg, x[0..2][1]) *)
     List.map (fun v'' -> Index(v'',idx))
       (expand_slices_ranges backtrace env_var env_it v')
  | Range(v',ae1,ae2) ->
     let ae1 = eval_arith backtrace env_var env_it ae1 in
     let ae2 = eval_arith backtrace env_var env_it ae2 in
     let vl = expand_slices_ranges backtrace env_var env_it v' in
     (* The Range will be applied to each elements of |vl|. Therefore,
        we can perform type and bound-checking on (List.hd vl); since
        every elements of |vl| should have the same type. *)
     (* Making sure |vl| contains arrays, that are big enough *)
     (match get_var_type backtrace env_var env_it (List.hd vl) with
      | Array(_,Const_e size) | Uint(_,_,size) ->
         (* Make sure vl is big enough (no out of bounds) *)
          check_in_bounds backtrace env_it size ae1;
          check_in_bounds backtrace env_it size ae2
      | t ->
         (* v is not an array (-> error) *)
         not_an_array_error (List.hd vl) t);
     (* Checks passed, expanding the range *)
     flat_map (fun v'' -> List.map (fun i -> Index(v'',Const_e i))
                            (gen_list_bounds ae1 ae2))
       vl
  | Slice(v',aes) ->
     let aes = List.map (eval_arith backtrace env_var env_it) aes in
     let vl = expand_slices_ranges backtrace env_var env_it v' in
     (* The Slice will be applied to each elements of |vl|. Therefore,
        we can perform type and bound-checking on (List.hd vl); since
        every elements of |vl| should have the same type. *)
     (* Making sure |vl| contains arrays, that are big enough *)
     (match get_var_type backtrace env_var env_it (List.hd vl) with
      | Array(_,Const_e size) | Uint(_,_,size) ->
         (* Make sure vl is big enough (no out of bounds) *)
         List.iter (fun n -> check_in_bounds backtrace env_it size n) aes
      | t ->
         (* vl is not an array (-> error) *)
         not_an_array_error (List.hd vl) t);
     (* Checks passed, expanding the slice *)
     flat_map (fun v'' -> List.map (fun i -> Index(v'',Const_e i)) aes)
       vl

(* Using a custom 'expand_var' mostly to use a custom get_var_type.
   "usuba0" here means: without any Ranges and Slices. *)
let rec expand_var_usuba0 (backtrace:string list)
          (env_var:(ident,typ) Hashtbl.t)
          (env_it:(ident,int) Hashtbl.t)
          (v:var) : var list =
  let backtrace = (sprintf "expand_var_usuba0(%s)" (var_to_str v)) :: backtrace in
  match get_var_type backtrace env_var env_it v with
  | Nat -> [ v ]
  | Uint(_,_,1) -> [ v ]
  | Uint(_,_,n) ->
     List.map (fun i -> Index(v,Const_e i)) (gen_list_0_int n)
  | Array(_,s) -> flat_map (fun i -> expand_var_usuba0 backtrace env_var env_it
                                       (Index(v,Const_e i)))
                    (gen_list_0_int (eval_arith_ne s))


(* Using a custom 'expand_var' mostly to use a custom get_var_type,
   but also to support Slices and Ranges. *)
let rec expand_var (backtrace:string list)
          (env_var:(ident,typ) Hashtbl.t)
          (env_it:(ident,int) Hashtbl.t)
          (v:var) : var list =
  let backtrace = (sprintf "expand_var(%s)" (var_to_str v)) :: backtrace in
  (* Expanding Ranges/Slices (produces a list of var) *)
  let vl = expand_slices_ranges backtrace env_var env_it v in
  (* Expanding each var individually *)
  flat_map (expand_var_usuba0 backtrace env_var env_it) vl

(* Checks that two types are equals. |t1| and |t2| should be as
   expanded as possible and therefore can only be Uint(_,_,1) or
   Nat. Raises an error if both types aren't equals *)
let rec check_type_eq (backtrace:string list) (t1:typ) (t2:typ) : unit =
  let backtrace = (sprintf "check_type_eq(%s, %s)" (typ_to_str t1) (typ_to_str t2))
                  :: backtrace in
  let is_m_polymorphic (m:mtyp) : bool =
    match m with
    | Mint _ -> false
    | Mnat   -> false
    | Mvar _ -> true in
  match t1,t2 with
  | Uint(_,m1,n1), Uint(_,m2,n2) ->
     (* Ignoring slicing direction for now. *)
     (* Note: if either m1 or m2 are polymorphic, some type inference
        should probably happen. Ignoring that too for now. *)
     if n1 <> n2 then
       (eprintf "[Type error] Types `%s' and `%s' have different sizes: %d vs %d.\n"
          (typ_to_str t1) (typ_to_str t2) n1 n2;
        print_backtrace backtrace;
        raise Fatal_type_error);
     if m1 <> m2 && not (is_m_polymorphic(m1) || is_m_polymorphic(m2)) then
       (eprintf "[Type error] Types `%s' and `%s' have different word size: %s vs %s.\n"
          (typ_to_str t1) (typ_to_str t2) (m_to_str m1) (m_to_str m2);
        print_backtrace backtrace;
        raise Fatal_type_error)
  | Nat, Nat -> () (* All good, nothing to do *)
  | _, _ -> (* Probably Nat vs Uint (since there shouldn't be any array here).
               Not good. We could think of converting one to the other though. *)
     eprintf "[Type error] Can't match types `%s' and `%s'.\n"
       (typ_to_str t1) (typ_to_str t2);
     print_backtrace backtrace;
     raise Fatal_type_error

(* l1 should be the types of an expression, and l2 should be the type
   of the variables that is expression is being assigned to. *)
(* Doesn't return anything, but issues an error message if l2 is
   smaller than l1 (or if the first (length l1) elements of l1 and l2
   don't match. *)
(* To avoid a too verbose stacktrace in case of error, match_types
   sets up the backtrace at the begining, and then lets "aux" do the
   job. *)
let match_types_asgn (backtrace:string list) (l1:typ list) (l2:typ list ref) : unit =
  let backtrace = (sprintf "match_types_asgn([%s], [%s])" (typ_to_str_l l1)
                     (typ_to_str_l !l2)) :: backtrace in
  let rec aux (l1:typ list) : unit =
  match l1, !l2 with
  | [], _ -> () (* l1 has been entirely matched; no problem *)
  | _, [] -> (* l1 is longer than l2 *)
     eprintf "[Type error] Unbalanced left/right types: trying to match [%s]: nothing to match with.\n"
       (typ_to_str_l l1);
     print_backtrace backtrace;
     raise Fatal_type_error
  | typ1::tl1, typ2::tl2 -> (* Need to make sure that typ1 and typ2 match *)
     check_type_eq backtrace typ1 typ2;
     l2 := tl2; (* removing typ2 from l2 *)
     aux tl1 in
  aux l1

(* Matches two lists of types. Typically to be called on the types of
   the two operands of a Log/Arith expression. *)
(* To avoid a too verbose stacktrace in case of error, match_types
   sets up the backtrace at the begining, and then lets "aux" do the
   job. *)
(* Heavily inspired by match_types_asgn, but differs in three ways:
     - |l2| is an 'int list' rather than an 'int list ref'
     - |l1| and |l2| must be of the same size
     - The error message is not the same
   (we could probably merge them if we wanted to though) *)
let match_types_binop (backtrace:string list) (l1:typ list) (l2:typ list) : unit =
  let backtrace = (sprintf "match_types_binop([%s], [%s])" (typ_to_str_l l1)
                     (typ_to_str_l l2)) :: backtrace in
  let rec aux (l1:typ list) (l2: typ list): unit =
  match l1, l2 with
  | [], [] -> () (* both l1 and l2 have been entirely matched; no problem *)
  | _, [] -> (* l1 is longer than l2 *)
     eprintf "[Type error] Unbalanced types in binop: still have [%s] in left operand, but nothing in right one.\n"
       (typ_to_str_l l1);
     print_backtrace backtrace;
     raise Fatal_type_error
  | [], _ -> (* l1 is longer than l2 *)
     eprintf "[Type error] Unbalanced types in binop: still have [%s] in right operand, but nothing in left one.\n"
       (typ_to_str_l l2);
     print_backtrace backtrace;
     raise Fatal_type_error
  | typ1::tl1, typ2::tl2 -> (* Need to make sure that typ1 and typ2 match *)
     check_type_eq backtrace typ1 typ2;
     aux tl1 tl2 in
  aux l1 l2

(* Checks that |typs| can be used in an Arith expr. That is, their
   word size is either polymorphic, or in {8,16,32,64}, or is a Nat. *)
let check_can_be_arithed (backtrace:string list) (typs:typ list) : unit =
  let backtrace = (sprintf "check_can_be_arithed(%s)" (typ_to_str_l typs))
                  :: backtrace in
  List.iter (fun typ ->
      match get_type_m typ with
      | Mint n -> if not (List.mem n [8; 16; 32; 64]) then
                    (eprintf "[Type error] Invalid word-size: can't perform arithmetics on %d bits.\n" n;
                     print_backtrace backtrace;
                     error := true)
      | Mnat   -> () (* a Nat, ignoring for now *)
      | Mvar _ -> () (* polymorphic word-size; ignoring for now *)
    ) typs

(* checks that |ae| is well typed. The only way it could be not well
   typed is if it uses undeclared variables. Taking |env_var| as
   argument to provide more useful error messages if a variable for
   |env_var| is used inside the index (which is forbiden as it
   wouldn't be constant-time). *)
let rec check_aexpr_is_typed (backtrace:string list)
          (env_var:(ident,typ) Hashtbl.t)
          (env_it:(ident,int) Hashtbl.t)
          (ae:arith_expr) : unit =
  let backtrace = (sprintf "check_aexpr_is_typed(%s)" (arith_to_str ae)) :: backtrace in
  match ae with
  | Const_e _ -> ()
  | Var_e x ->
     (match Hashtbl.find_opt env_it x with
      | Some _ -> ()
      | None   ->
         match Hashtbl.find_opt env_var x with
         | Some Nat -> ()
         | _ ->
            eprintf "[Type error] Use of undeclared variable `%s' in index.\n" x.name;
            if Hashtbl.mem env_var x then
              eprintf "A variable with the same name exists, but is not a loop iterator and therefore cannot be used in an aexpr (type=%s).\n"
                      (typ_to_str (Hashtbl.find env_var x));
            eprintf "Iterator environment: { %s }.\n"
                    (join "," (List.map (fun x -> x.name) (keys env_it)));
            print_backtrace backtrace;
            error := true)
  | Op_e(_,ae1,ae2) ->
     check_aexpr_is_typed backtrace env_var env_it ae1;
     check_aexpr_is_typed backtrace env_var env_it ae2

(* Using a custom get_expr_type to have |env_it|, and to be able to
   call our custom |get_var_type|. Also, returned types are
   expanded. This function should be called after type_expr, since it
   requires Const to be typed. It is typically used after typing a
   binary operation to make sure that both operands have the same
   type. *)
(* Also, this function doesn't perform any verification: binary
   operations are supposed to have both operands of the same types
   (and we therefore look at only one here) *)
let rec get_expr_type
          (env_fun:(ident,def) Hashtbl.t)
          (env_var:(ident,typ) Hashtbl.t)
          (env_it:(ident,int) Hashtbl.t)
          (e:expr) : typ list =
  let backtrace = ["No backtrace provided: this path shouldn't fail. " ^
                     "If you see this backtrace, the type-checker is buggy. " ^
                       "Originated from get_type_expr()"] in
  flat_map expand_typ
    (match e with
     | Const(n,None) -> eprintf "get_expr_type should be called only on typed expression. Exiting.\n";
                        assert false
     | Const(n,Some typ) -> [ typ ]
     | ExpVar v -> [ get_var_type backtrace env_var env_it v ]
     | Tuple l -> flat_map (get_expr_type env_fun env_var env_it) l
     | Not e -> get_expr_type env_fun env_var env_it e
     | Shift(_,e,_) -> get_expr_type env_fun env_var env_it e
     | Log(_,e,_) -> get_expr_type env_fun env_var env_it e
     | Shuffle(v,_) -> [ get_var_type backtrace env_var env_it v ]
     | Arith(_,e,_) -> get_expr_type env_fun env_var env_it e
     | Fun(f,l)
     | Fun_v(f,_,l) ->
        if f.name = "rand" then [ Uint(default_dir,Mint 1,1) ]
        else if f.name = "refresh" then
          (if List.length l <> 1 then
             (eprintf "[Type error] refresh can only take one argument for now.\n";
              print_backtrace backtrace;
              raise Fatal_type_error);
           match List.hd l with
           | ExpVar v -> [ get_var_type backtrace env_var env_it v ]
           | _ -> eprintf "[Type error] refresh can only take variables as arguments for now.\n";
                  print_backtrace backtrace;
                  raise Fatal_type_error)
        else
          let def = Hashtbl.find env_fun f in
          List.map (fun vd -> vd.vd_typ) def.p_out)

(* Sets the type of all untyped consts in |e| to |typ| (not in
   function calls though). *)
let rec set_consts_type (typ:typ) (e:expr) : expr =
  match e with
  | Const(c,None)   -> Const(c,Some typ)
  | Tuple l         -> Tuple (List.map (set_consts_type typ) l)
  | _ -> e

(* Returns the amount of untyped Const (but not within a function
   call) in |e|. This function is used to know wether we need to be
   clever to type an eventual Const. *)
let rec count_untyped_consts (e:expr) : int =
  match e with
  | Const(_,None) -> 1
  | Tuple l       -> List.fold_left (fun tot e -> tot + (count_untyped_consts e)) 0 l
  | _             -> 0

(* Returns the amount of bits in |e|, except for the bits occupied by
   untyped constants. The idea being that if |e| contains |n| untyped
   constants, |k| bits, and is supposed to be |l| bits long, then each
   constant should have size (l-k)/n. *)
let rec get_nonconsts_bits (backtrace:string list)
                           (env_fun:(ident,def) Hashtbl.t)
                           (env_var:(ident,typ) Hashtbl.t)
                           (env_it:(ident,int) Hashtbl.t)
                           (e:expr) : int =
  let rec_call = get_nonconsts_bits backtrace env_fun env_var env_it in
  let var_size (v:var) : int = typ_size (get_var_type backtrace env_var env_it v) in
  match e with
  | Const(_,Some typ) -> typ_size typ
  | Const(_,None)     -> 0
  | ExpVar v          -> var_size v
  | Tuple l           -> List.fold_left (fun tot e -> tot + (rec_call e)) 0 l
  | Not e             -> rec_call e
  | Shift(_,e,_)      -> rec_call e
  | Log(_,x,y)        -> max (rec_call x) (rec_call y)
  | Shuffle(v,_)      -> var_size v
  | Arith(_,x,y)      -> max (rec_call x) (rec_call y)
  | Fun(f,_)
  | Fun_v(f,_,_)      ->
     let def = Hashtbl.find env_fun f in
     List.fold_left (fun tot vd -> typ_size vd.vd_typ) 0 def.p_out

(* Gives a type to bitslice constants *)
let rec fix_consts_types (backtrace:string list)
                         (env_fun:(ident,def) Hashtbl.t)
                         (env_var:(ident,typ) Hashtbl.t)
                         (env_it:(ident,int) Hashtbl.t)
                         (lhs_types:typ list)
                         (e:expr) : expr =
  let n_consts = count_untyped_consts e in
  let bitslice = List.exists (fun typ -> match typ with
                                         | Uint(_,Mint m,_) -> m = 1
                                         | _ -> false) lhs_types in
  if n_consts = 0 || bitslice = false then
    e (* Nothing to do *)
  else
    (* Gonna heuristically type constants. We need to find out the
       amount of bits left in the Tuple: we'll split them evenly
       between the |n| Consts. (note that here, we are necessarily in
       bitslice mode) *)
    (let nonconsts_bits = get_nonconsts_bits backtrace env_fun env_var env_it e in
     let lhs_size = List.fold_left (fun tot typ -> tot + (typ_size typ)) 0 lhs_types in
     let consts_bits = lhs_size - nonconsts_bits in
     if consts_bits mod n_consts <> 0 then (
       eprintf "[Type error] in (%s), %d constants to fit in %d bits; cannot guess what to do.\n"
               (expr_to_str e) n_consts consts_bits;
       print_backtrace backtrace;
       error := true;
       (* Returning the expression as is just to not die at the first
          error; but since |error| was just set, this result will
          never be used. *)
       e
     ) else (
       let const_size = consts_bits / n_consts in
       (* Typing all consts in |e| with the same type *)
       set_consts_type (Uint(Bslice,Mint 1,const_size)) e
     )
    )

(* Checks that the type of |e| is |lhs_types|. |lhs_types| has been
   obtained by typing the lhs that |e| is being assigned to.
   It returns a typed version of |e|. *)
(* |lhs_types| is mutable in order to facilitate typing of
   subexpressions *)
let rec type_expr (backtrace:string list)
                  (env_fun:(ident,def) Hashtbl.t)
                  (env_var:(ident,typ) Hashtbl.t)
                  (env_it:(ident,int) Hashtbl.t)
                  (lhs_types:typ list ref)
                  (e:expr) : expr =
  let backtrace = (sprintf "type_expr(%s)" (expr_to_str e)) :: backtrace in
  let rec_call = type_expr backtrace env_fun env_var env_it lhs_types in
  let e = fix_consts_types backtrace env_fun env_var env_it !lhs_types e in
  match e with
  | Const(n,None) ->
     (* A Const ->
          - since fix_consts_types has already ran, the Const is either:
             * msliced, in which case its type should be (List.hd !lhs_types)
             * bitsliced, in which case its type should be (!lhs_types)
               (in that case, it was not typed by fix_consts_types because
                it's not part of a Tuple)
        Additionally, we need to:
          - make sure its type is Nat or Uint(_,_,1)
          - if its type is Uint(_,_,1), make sure it fits within *)
     let bitslice = List.exists (fun typ -> match typ with
                                            | Uint(_,Mint m,_) -> m = 1
                                            | _ -> false) !lhs_types in
     let typ = if bitslice then
                 let typ = Uint(Bslice,Mint 1,List.length !lhs_types) in
                 lhs_types := [];
                 typ
               else
                 match !lhs_types with
                 | hd :: tl -> lhs_types := tl;
                               hd
                 | _ -> eprintf "[Type error] Unbalanced left/right types: trying to type [Const %d]: nothing to match with.\n"
                                n;
                        print_backtrace backtrace;
                        raise Fatal_type_error in
     (* Making sure that n will fit in its type *)
     (match typ with
      | Nat -> () (* nothing do do *)
      | Uint(_,Mint i,_) ->
         (* TODO: remove this "i < 63"; handle that better throughout Usubac *)
         if i < 63 && pow 2 i <= n then
           (eprintf "[Type error] Constant 0x%x doesn't fit in %d bits (inferred type: %s --> max=%d).\n"
                    n i (typ_to_str typ) (pow 2 i);
            print_backtrace backtrace;
            error := true)
      | Uint(_,Mvar _,_) ->
         eprintf "[Type error] Cannot make sure that const 0x%x fits in a type with polymorphic word-size (%s).\n"
                 n (typ_to_str typ);
         print_backtrace backtrace;
         error := true
      | _ -> assert false
     );
     (* Returning a typed Const *)
     Const(n,Some typ)
  | Const(n,Some typ) ->
     (* A typed Const; need to make sure its type is correct *)
     let typs = expand_typ typ in
     match_types_asgn backtrace typs lhs_types;
     Const(n,Some typ)
  | ExpVar v ->
     (* An ExpVar. Need to make sure it matches with lhs_types (and
        consuming the first elements of lhs_types accordingly) *)
     (* We expand v only to get its full type: we actually return the
        original v (because of loops on one part, and because we might
        not want to fully expand some variables) *)
     let vl = expand_var backtrace env_var env_it v in
     let typs = flat_map expand_typ
                         (List.map (get_var_type backtrace env_var env_it) vl) in
     match_types_asgn backtrace typs lhs_types;
     (* Returning v unchanged *)
     ExpVar v
  | Tuple l  -> Tuple(List.map rec_call l)
  | Not e    -> Not(rec_call e)
  | Shift(op,e,ae) ->
     (* A shift. Reccursive call is enough since there is nothing to
        actually check: Shifts are defined over both arrays an atomic
        types (Uint(_,_,1)). Making sure that |ae| is well typed as
        well though. *)
     check_aexpr_is_typed backtrace env_var env_it ae;
     Shift(op,rec_call e,ae)
  | Log(op,x,y) ->
     (* Need to be careful not to consume twice |lhs_types|. Also,
        would be nice to have useful a fairly useful error message if
        both x and y don't match (don't forget that we don't have the
        types of neither x nor y after the reccursive call to
        type_expr). *)
     (* Saving |lhs_types| to restore for reccursive call on |y| *)
     let lhs_types_initial = !lhs_types in
     let x' = rec_call x in
     (* Restoring |lhs_types|*)
     lhs_types := lhs_types_initial;
     let y' = rec_call y in
     (* Making sure x' and y' have the same type *)
     match_types_binop backtrace
                       (get_expr_type env_fun env_var env_it x')
                       (get_expr_type env_fun env_var env_it y');
     (* Returning the new expr *)
     Log(op,x',y')
  | Arith(op,x,y) ->
     (* The comments about Log applies here as well; see above. *)
     (* Saving |lhs_types| to restore for reccursive call on |y| *)
     let lhs_types_initial = !lhs_types in
     let x' = rec_call x in
     (* Restoring |lhs_types|*)
     lhs_types := lhs_types_initial;
     let y' = rec_call y in
     (* Making sure |x'| and |y'| have the same type *)
     let x'_typ = (get_expr_type env_fun env_var env_it x') in
     let y'_typ = (get_expr_type env_fun env_var env_it y') in
     (* Make sure |x'_typ| and |y'_typ| are compatible (ie, if they
        aren't polymorphic, they have the same word size, and, if they
        are arrays, they have the same size). *)
     match_types_binop backtrace x'_typ y'_typ;
     (* Then, make sure |x'| and |y'| can actually be Arith'ed: their
        word-size should be "Mint n" with n > 1 and n in {8, 16, 32,
        64}, or "Mvar _". *)
     check_can_be_arithed backtrace x'_typ;
     check_can_be_arithed backtrace y'_typ;
     (* Returning the new expr *)
     Arith(op,x',y')
  | Shuffle(v,l) ->
     (* Just matchhing the type(s) of |v| against |lhs_types|. *)
     (* TODO: should make sure that |l| can be applied to |v|. *)
     let vd_typ = expand_typ (get_var_type backtrace env_var env_it v) in
     match_types_asgn backtrace vd_typ lhs_types;
     Shuffle(v,l)
  | Fun(f,l) ->
     (* Need to match |l| against the parameters of |f|, and the
        return values of |f| against |lhs_types|. *)
     (* TODO: check that |f| isn't a Multiple *)
     if f.name = "refresh" then
       (if List.length l <> 1 then
          (eprintf "[Type error] refresh can only take one argument for now.\n";
           print_backtrace backtrace;
           raise Fatal_type_error);
        match List.hd l with
        | ExpVar v ->
           (* Matching parameters with returns is done by the reccursive call *)
           Fun(f,[type_expr backtrace env_fun env_var env_it lhs_types (ExpVar v)])
        | _ -> eprintf "[Type error] refresh can only take variables as arguments for now.\n";
               print_backtrace backtrace;
               raise Fatal_type_error)
     else
       (let f = match Hashtbl.find_opt env_fun f with
          | Some def -> def
          | None -> eprintf "[Type error] Use of undeclared funtion `%s'.\n"
                            f.name;
                    print_backtrace backtrace;
                    raise Fatal_type_error in
        (* First, typing |param_types| according to |f.p_in| *)
        let param_types =
          ref (flat_map expand_typ
                        (List.map (fun vd -> vd.vd_typ) f.p_in)) in
        (* Reccursive call on a Tuple in order to have the reccursive
           call on a single expr so that the Const typing rule
           (fix_consts_types) will work correctly *)
        let typed_l =
          match type_expr backtrace env_fun env_var env_it param_types (Tuple l) with
          | Tuple l' -> l'
          | _ -> assert false (* Definitely not possible *) in
        (* if |param_types| is not empty, then |vs| is larger than |e| *)
        if !param_types <> [] then
          (eprintf "[Type error] Unbalanced left/right types: type of rhs is smaller than type of lhs. Remains: %s.\n"
                   (typ_to_str_l !param_types);
           print_backtrace backtrace;
           error := true);
        (* Then, making sure that |f.p_out| matches with |lhs_types| *)
        let return_types =
          flat_map expand_typ
                   (List.map (fun vd -> vd.vd_typ) f.p_out) in
        match_types_asgn backtrace return_types lhs_types;
        Fun(f.id,typed_l))
  | Fun_v(f,ae,l) ->
     (* Reccursive call using Fun(f,l) instead of the Fun_v, since
        everything done in the case Fun needs to be done here as
        well. Not that this only works because the case Fun only looks
        at |f|'s parameters/returns and not its body (keep in mind
        that a Multiple isn't callable without indexing). *)
     let typed_l = match rec_call (Fun(f,l)) with
       | Fun(_,typed_l) -> typed_l
       | _ -> assert false (* cannot reach that *) in
     (* Making sure that |f| is a multiple and that |ae| is well
        typed, and within |f|'s bounds. *)
     check_aexpr_is_typed backtrace env_var env_it ae;
     (* Note that if we reach that point, then the reccursive call on
        Fun(f,l) made sure that (Hashtbl.find env_fun f) succeeds. *)
     let f = Hashtbl.find env_fun f in
     (match f.node with
      | Multiple l ->
         let size = List.length l in
         let ae = eval_arith backtrace env_var env_it ae in
         if ae >= size then
           (eprintf "[Type error] Out of bounds access in `%s' (Multiple of size %d): index %d.\n"
                    f.id.name size ae;
            print_backtrace backtrace;
            error := true);
      | _ -> eprintf "[Type error] Accessing non-Multiple `%s' as a Multiple.\n"
                     f.id.name;
             print_backtrace backtrace;
             error := true);
     Fun_v(f.id, ae, typed_l)


(* The types of the left han-side are always computable (since it's
   only vars, which have been declared with their types). The right
   hand-side might need some inference because of constants. *)
(* Note that even though indices can be computed (since we are passing
   |env_it|), we return uncomputed indices because we are actually
   rebuilding the original AST with the return of this function. *)
(* Note that the 'deq' returned can only be an Eqn (and not a Loop) *)
let type_eqn (backtrace:string list) (env_fun:(ident,def) Hashtbl.t)
      (env_var:(ident,typ) Hashtbl.t)
      (env_it:(ident,int) Hashtbl.t)
      (deq:deq) (* only used for tracing *)
      (vs:var list) (e:expr) (sync:bool) : deq =
  let backtrace = (sprintf "type_eqn(%s)" (deq_to_str deq)) :: backtrace in
  let lhs_types =
    ref (flat_map expand_typ
           (List.map (get_var_type backtrace env_var env_it)
              (flat_map (expand_var backtrace env_var env_it) vs))) in
  let typed_e = type_expr backtrace env_fun env_var env_it lhs_types e in
  (* if |lhs_types| is not empty, then |vs| is larger than |e| *)
  if !lhs_types <> [] then
    (eprintf "[Type error] Unbalanced left/right types: type of rhs is smaller than type of lhs. Remains: %s.\n"
       (typ_to_str_l !lhs_types);
     print_backtrace backtrace;
     error := true);
  (* Finally, returning |deq| with typed |e| *)
  { deq with content = Eqn(vs,typed_e,sync) }

(* A regular node; iterating over each deq; but most of the work is
   done by type_eqn above. *)
let rec type_deqs (backtrace:string list) (env_fun:(ident,def) Hashtbl.t)
          (env_var:(ident,typ) Hashtbl.t)
          (env_it:(ident,int) Hashtbl.t)
          (body:deq list) : deq list =
  let backtrace = "type_deqs()" :: backtrace in
  List.map
    (fun deq ->
      match deq.content with
      | Eqn(vs,e,sync) ->
         type_eqn backtrace env_fun env_var env_it deq vs e sync
      | Loop(x,ei,ef,dl,opts) ->
         (* Iterating over all values of x. This will detect out of
            bounds array access. *)
         let backtrace = (sprintf "  deq = forall %s in [%s, %s] { ... }"
                         x.name (arith_to_str ei) (arith_to_str ef)) :: backtrace in
         let ei_evaled = eval_arith backtrace env_var env_it ei in
         let ef_evaled = eval_arith backtrace env_var env_it ef in
         let typed_dl =
           List.map
             (fun i ->
               Hashtbl.add env_it x i;
               let dl = type_deqs backtrace env_fun env_var env_it dl in
               Hashtbl.remove env_it x;
               dl)
             (gen_list_bounds ei_evaled ef_evaled) in
         (* Need to rebuild the loop. Every elements of type_dl should
            be the same. Arbitrarily picking the first one. *)
         { deq with content = Loop(x,ei,ef,List.hd typed_dl,opts) }
    )
    body

(* In a permutation, we check that:
     - There are exactly #p_out elements
     - Each element is greater than 0 (permutations are 1-indexed)
     - Each element is less or equal than #p_in *)
let type_perm (backtrace:string list) (p_in:p) (p_out:p) (l:int list) : int list =
  let backtrace = "type_perm()" :: backtrace in
  let in_size  = p_size p_in  in
  let out_size = p_size p_out in
  if List.length l <> out_size then
    begin
      eprintf "[Type error] Wrong number of elements in perm: Expected %d, got %d.\n"
        out_size (List.length l);
      print_backtrace backtrace;
      error := true
    end;
  List.iter
    (fun i ->
      match i <= in_size with
      | true  ->
         if i <> 0 then ()
         else begin
             eprintf "[Type error] Invalid element `0' in perm.\n";
             print_backtrace backtrace;
             error := true
           end
      | false ->
         eprintf
           "[Type error] Invalid element in perm: `%d' (only %d inputs).\n"
           i in_size;
         print_backtrace backtrace;
         error := true) l;
  l

(* In a table, we check that:
     - There are at most 2**#p_in elements
     - No element is greater than 2**#p_out (or it wouldn't fit in p_out) *)
let type_table (backtrace:string list) (conf:config) (p_in:p) (p_out:p) (l:int list)
    : int list =
  let backtrace = "type_table()" :: backtrace in

  (* Using a special p_size if conf.keep_tables *)
  let p_size_keep (p:p) =
    match p with
    | vd :: [] -> (match get_type_m vd.vd_typ with
                   | Mint c -> c
                   | Mnat   -> begin
                       eprintf "[Type error] Cannot use a Nat in a table's parameters.\n";
                       print_backtrace backtrace;
                       raise Fatal_type_error
                             end
                   | Mvar _ -> begin
                       eprintf "[Type error] Cannot use word-size polymorphic tables with -keep-tables.\n";
                       print_backtrace backtrace;
                       raise Fatal_type_error
                     end)
    | _ -> eprintf "[Type error] Tables with -keep-tables must have exactly one parameter. Got %d.\n"
             (List.length p);
           raise Fatal_type_error in

  let in_size  = if conf.keep_tables then p_size_keep p_in  else p_size p_in  in
  let out_size = if conf.keep_tables then p_size_keep p_out else p_size p_out in
  if List.length l > pow 2 in_size then
    begin
      eprintf "[Type error] Too many elements in table. Expected %d (or less), got %d.\n"
        (pow 2 in_size) (List.length l);
      print_backtrace backtrace;
      error := true
    end;
  List.iter (fun i ->
      match i < pow 2 out_size with
      | true  -> ()
      | false -> eprintf
                   "[Type error] invalid element in table: `%d' is higher than 2**#inputs = 2**%d = %d.\n"
                   i in_size (pow 2 out_size);
                 print_backtrace backtrace;
                 raise Fatal_type_error) l;
  l


(* It's easier to split type_def into type_def+type_defi because of
   Multiple (reccursion happens over a def_i and not a def in that
   case). *)
let rec type_defi (backtrace:string list) (env_fun:(ident,def) Hashtbl.t)
          (conf:config) (p_in:p) (p_out:p) (defi:def_i) : def_i =
  match defi with
  | Single(vars,body) ->
     let backtrace = "type_defi(Single ...)" :: backtrace in
     let env_var = build_env_var backtrace p_in p_out vars in
     let env_it  = Hashtbl.create 10 in
     let body = type_deqs backtrace env_fun env_var env_it body in
     Single(vars, body)
  | Perm l ->
     let backtrace = "type_defi(Perm ...)" :: backtrace in
     Perm(type_perm  backtrace p_in p_out l)
  | Table l ->
     let backtrace = "type_defi(Table ...)" :: backtrace in
     Table(type_table backtrace conf p_in p_out l)
  | Multiple l ->
     let backtrace = "type_defi(Multiple ...)" :: backtrace in
     Multiple (List.map (type_defi backtrace env_fun conf p_in p_out) l)

let type_def (backtrace:string list) (env_fun:(ident,def) Hashtbl.t)
      (conf:config) (def:def) : def =
  let backtrace = (sprintf "type_def(%s)" def.id.name) :: backtrace in
  { def with node = type_defi backtrace env_fun conf def.p_in def.p_out def.node }


let type_prog (prog:prog) (conf:config) : prog =
  let backtrace = ["type_prog()"] in
  (* Environment containing the nodes *)
  let env_fun = build_env_fun backtrace prog in
  (* Checking that every node is well typed
     (two step to avoid early termination) *)
  let typed_nodes =
    List.map (
        fun x -> try
                type_def backtrace env_fun conf x
              with Fatal_type_error ->
                error := true;
                (* Returning |x| just to avoid early termination of
                   type-checking *)
                x) prog.nodes in
  if !error then
    raise Fatal_type_error
  else { nodes = typed_nodes }
