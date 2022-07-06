open Usuba_AST

let pp_list_comma f l =
  Format.(pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf ",") f) l

let pp_list_comma_cut f l =
  Format.(pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf ",@,") f) l

let pp_list_space f l =
  Format.(pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " ") f) l

let pp_list_semi_cut f l =
  Format.(pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf ";@,") f) l

let pp_list_newline f l =
  Format.(pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf "@.@.") f) l

let unfold_andn e =
  match e with Log (Andn, x, y) -> Log (And, Not x, y) | _ -> e

let rec pp_log_op ppf op =
  Format.fprintf ppf "%s"
    (match op with
    | And -> "&"
    | Or -> "|"
    | Xor -> "^"
    | Andn -> "&~"
    | Masked op -> Format.asprintf "%a" pp_log_op op)

let pp_arith_op ppf op =
  Format.fprintf ppf "%s"
    (match op with
    | Add -> "+"
    | Mul -> "*"
    | Sub -> "-"
    | Div -> "/"
    | Mod -> "%")

let pp_shift_op ppf op =
  Format.fprintf ppf "%s"
    (match op with
    | Lshift -> "<<"
    | Rshift -> ">>"
    | RAshift -> ">>!"
    | Lrotate -> "<<<"
    | Rrotate -> ">>>")

let rec pp_arith ?(typed = false) ?(detailed = false) () ppf = function
  | Const_e i -> Format.fprintf ppf "%s%d" (if typed then "Const_e: " else "") i
  | Var_e v ->
      Format.fprintf ppf "%s%a"
        (if typed then "Var_e: " else "")
        (Ident.pp ~detailed ()) v
  | Op_e (op, x, y) ->
      Format.fprintf ppf "%s(%a %a %a)"
        (if typed then "Op_e: " else "")
        (pp_arith ~typed ~detailed ())
        x pp_arith_op op
        (pp_arith ~typed ~detailed ())
        y

let pp_full_m ?(detailed = false) () ppf m =
  match m with
  | Mint n -> Format.fprintf ppf "%d" n
  | Mnat -> assert false
  | Mvar id -> Format.fprintf ppf "%a" (Ident.pp ~detailed ()) id

let pp_dir ?(detailed = false) () ppf d =
  match d with
  | Hslice -> Format.fprintf ppf "<H>"
  | Vslice -> Format.fprintf ppf "<V>"
  | Bslice -> Format.fprintf ppf "<B>"
  | Natdir -> assert false
  | Mslice i -> Format.fprintf ppf "<%d>" i
  | Varslice v ->
      if Ident.name v = "D" then ()
      else Format.fprintf ppf "<%a>" (Ident.pp ~detailed ()) v

let rec pp_full_typ ?(typed = false) ~detailed () ppf = function
  | Nat -> Format.fprintf ppf "nat"
  | Uint (d, m, n) ->
      Format.fprintf ppf "u%a%ax%d" (pp_dir ~detailed ()) d
        (pp_full_m ~detailed ()) m n
  | Array (typ, n) ->
      Format.fprintf ppf "%a[%a]"
        (pp_full_typ ~typed ~detailed ())
        typ
        (pp_arith ~typed ~detailed ())
        n

let rec pp_typ ?(typed = false) ?(acc = "") ?(detailed = false) () ppf typ =
  match typ with
  | Nat -> Format.fprintf ppf "nat"
  | Uint (d, m, n) ->
      (match m with
      | Mint 1 -> Format.fprintf ppf "b%a%d" (pp_dir ~detailed ()) d n
      | Mint i ->
          if n = 1 then Format.fprintf ppf "u%a%d" (pp_dir ~detailed ()) d i
          else Format.fprintf ppf "u%a%dx%d" (pp_dir ~detailed ()) d i n
      | Mnat -> assert false
      | Mvar id ->
          if Ident.name id = "m" then
            Format.fprintf ppf "v%a%d" (pp_dir ~detailed ()) d n
          else
            Format.fprintf ppf "u%a%ax%d" (pp_dir ~detailed ()) d
              (Ident.pp ~detailed ()) id n);
      Format.fprintf ppf "%s" acc
  | Array (typ, n) ->
      Format.fprintf ppf "%a"
        (pp_typ ~detailed
           ~acc:(Format.asprintf "%s[%a]" acc (pp_arith ~typed ~detailed ()) n)
           ())
        typ

let pp_typ_list ?(typed = false) ?(acc = "") ?(detailed = false) () =
  pp_list_comma (pp_typ ~typed ~detailed ~acc ())

let rec pp_var ?(typed = false) ?(detailed = false) () ppf = function
  | Var v ->
      Format.fprintf ppf "%s%a"
        (if typed then "Var: " else "")
        (Ident.pp ~detailed ()) v
  | Index (v, e) ->
      Format.fprintf ppf "%s%a[%a]"
        (if typed then "Index: " else "")
        (pp_var ~typed ~detailed ())
        v
        (pp_arith ~typed ~detailed ())
        e
  | Range (v, ei, ef) ->
      Format.fprintf ppf "%s%a[%a .. %a]"
        (if typed then "Range: " else "")
        (pp_var ~typed ~detailed ())
        v
        (pp_arith ~typed ~detailed ())
        ei
        (pp_arith ~detailed ~typed ())
        ef
  | Slice (v, l) ->
      Format.fprintf ppf "%s%a[%a]"
        (if typed then "Slice: " else "")
        (pp_var ~typed ~detailed ())
        v
        (pp_list_comma (pp_arith ~typed ~detailed ()))
        l

let pp_var_list ?(typed = false) ?(detailed = false) () =
  pp_list_comma (pp_var ~typed ~detailed ())

let pp_params_list ?(typed = false) ?(detailed = false) () ppf el =
  Format.fprintf ppf "(%a)" (pp_list_comma (pp_var ~typed ~detailed ())) el

let rec pp_expr ?(typed = false) ?(detailed = false) () ppf = function
  | Const (c, Some t) ->
      Format.fprintf ppf "%s0x%x:%a"
        (if typed then "Const: " else "")
        c
        (pp_typ ~typed ~detailed ())
        t
  | Const (c, None) ->
      Format.fprintf ppf "%s0x%x" (if typed then "Const: : " else "") c
  | ExpVar v ->
      Format.fprintf ppf "%s%a"
        (if typed then "ExpVar: " else "")
        (pp_var ~typed ~detailed ())
        v
  | Tuple t ->
      Format.fprintf ppf "%s(%a)"
        (if typed then "Tuple: " else "")
        (pp_list_comma (pp_expr ~typed ~detailed ()))
        t
  | Log (o, x, y) ->
      Format.fprintf ppf "%s(%a %a %a)"
        (if typed then "Log: " else "")
        (pp_expr ~typed ~detailed ())
        x pp_log_op o
        (pp_expr ~typed ~detailed ())
        y
  | Shuffle (v, l) ->
      Format.fprintf ppf "%sShuffle(%a,[%a])"
        (if typed then "Shuffle: " else "")
        (pp_var ~typed ~detailed ())
        v
        (pp_list_comma Usuba_pp.Int.pp)
        l
  | Bitmask (e, ae) ->
      Format.fprintf ppf "%sBitmask(%a,%a)"
        (if typed then "Bitmask: " else "")
        (pp_expr ~typed ~detailed ())
        e
        (pp_arith ~typed ~detailed ())
        ae
  | Pack (e1, e2, _) ->
      Format.fprintf ppf "%sPack(%a, %a)"
        (if typed then "Pack: " else "")
        (pp_expr ~typed ~detailed ())
        e1
        (pp_expr ~typed ~detailed ())
        e2
  | Arith (o, x, y) ->
      Format.fprintf ppf "%s(%a %a %a)"
        (if typed then "Arith: " else "")
        (pp_expr ~typed ~detailed ())
        x pp_arith_op o
        (pp_expr ~typed ~detailed ())
        y
  | Shift (o, x, y) ->
      Format.fprintf ppf "%s(%a %a %a)"
        (if typed then "Shift: " else "")
        (pp_expr ~typed ~detailed ())
        x pp_shift_op o
        (pp_arith ~typed ~detailed ())
        y
  | Not e ->
      Format.fprintf ppf "%s(¬%a)"
        (if typed then "Not: " else "")
        (pp_expr ~typed ~detailed ())
        e
  | Fun (f, l) ->
      Format.fprintf ppf "%s%a(%a)"
        (if typed then "Fun: " else "")
        (Ident.pp ~detailed ()) f
        (pp_list_comma (pp_expr ~typed ~detailed ()))
        l
  | Fun_v (f, e, l) ->
      Format.fprintf ppf "%s%a[%a](%a)"
        (if typed then "Fun: " else "")
        (Ident.pp ~detailed ()) f
        (pp_arith ~typed ~detailed ())
        e
        (pp_list_comma (pp_expr ~typed ~detailed ()))
        l

let pp_expr_list ?(typed = false) ?(detailed = false) () =
  pp_list_comma (pp_expr ~typed ~detailed ())

let pp_var_d_opt ppf (vopt : var_d_opt) =
  Format.fprintf ppf "%s"
    (match vopt with Pconst -> "const" | PlazyLift -> "lazyLift")

let pp_var_d_opt_list = pp_list_space pp_var_d_opt

let pp_vd ?(full = false) ?(typed = false) ?(detailed = false) () ppf
    (vd : var_d) =
  Format.fprintf ppf "%a : %a %a" (Ident.pp ~detailed ()) vd.vd_id
    pp_var_d_opt_list vd.vd_opts
    (if full then pp_full_typ ~detailed ~typed ()
    else pp_typ ~typed ~detailed ())
    vd.vd_typ

let pp_p ?(full = false) ?(typed = false) ?(detailed = false) () =
  pp_list_comma (pp_vd ~typed ~full ~detailed ())

let pp_optstmt ppf o =
  Format.fprintf ppf "%s"
    (match o with
    | Unroll -> "_unroll"
    | No_unroll -> "_no_unroll"
    | Pipelined -> "_pipelined"
    | Safe_exit -> "_safe_exit")

let rec pp_deq_i ?(typed = false) ?(detailed = false) () ppf (deq_i : deq_i) =
  match deq_i with
  | Eqn (pat, e, sync) ->
      Format.fprintf ppf "%a %s= %a"
        (pp_params_list ~detailed ~typed ())
        pat
        (if sync then ":" else "")
        (pp_expr ~typed ~detailed ())
        e
  | Loop (id, ei, ef, d, opts) ->
      Format.fprintf ppf
        "@[<v 0>@[<v 2>%a%sforall %a in [%a,%a] {@,@[<v 2>%a@]@]@,}@]"
        (pp_list_space pp_optstmt) opts
        (if List.length opts > 0 then " " else "")
        (Ident.pp ~detailed ()) id
        (pp_arith ~typed ~detailed ())
        ei
        (pp_arith ~typed ~detailed ())
        ef
        (pp_list_semi_cut (pp_deq ~detailed ()))
        d

and pp_deq ?(typed = false) ?(detailed = false) () ppf (deq : deq) =
  pp_deq_i ~detailed ~typed () ppf deq.content

let pp_deq_i_list ?(typed = false) ?(detailed = false) () =
  pp_list_comma (pp_deq_i ~detailed ~typed ())

let pp_deq_list ?(typed = false) ?(detailed = false) () =
  pp_list_comma (pp_deq ~typed ~detailed ())

let pp_body ?(typed = false) ?(detailed = false) (vars : p) ppf (deq : deq list)
    =
  (match vars with
  | [] -> ()
  | vars ->
      Format.fprintf ppf "@[<v 2>vars@,%a@]@,"
        (pp_list_comma_cut (pp_vd ~typed ~detailed ()))
        vars);
  Format.fprintf ppf "@[<v 2>let@,%a@]@,tel"
    (pp_list_semi_cut (pp_deq ~typed ~detailed ()))
    deq

let pp_single_node ?(typed = false) ?(detailed = false) (id : ident) (p_in : p)
    (p_out : p) (vars : p) ppf (deq : deq list) =
  Format.fprintf ppf "@[<v 2>node %a(%a) returns %a@,%a@]"
    (Ident.pp ~detailed ()) id (pp_p ~typed ~detailed ()) p_in
    (pp_p ~typed ~detailed ()) p_out
    (pp_body ~typed ~detailed vars)
    deq

let pp_multiple_nodes ?(typed = false) ?(detailed = false) (id : ident)
    (p_in : p) (p_out : p) ppf (def_list : def_i list) =
  Format.fprintf ppf "@[<v 2>node[] %a(%a) returns %a[@[<v 2>@,%a@]@,]"
    (Ident.pp ~detailed ()) id (pp_p ~typed ~detailed ()) p_in
    (pp_p ~typed ~detailed ()) p_out
    (fun ppf l ->
      List.iter
        (function
          | Single (vars, deq) -> (pp_body ~typed ~detailed vars) ppf deq
          | _ -> assert false)
        l)
    def_list

let pp_perm_or_table_body ppf perm =
  Format.fprintf ppf "{@[<hov 2>%a@]}" (pp_list_semi_cut Usuba_pp.Int.pp) perm

let pp_single_perm_or_table ?(header = "perm") ?(typed = false)
    ?(detailed = false) (id : ident) (p_in : p) (p_out : p) ppf perm_or_table =
  Format.fprintf ppf "@[<v 2>%s %a(%a) returns %a@,[@[<v 2>@,%a@]@,]@]@]" header
    (Ident.pp ~detailed ()) id (pp_p ~typed ~detailed ()) p_in
    (pp_p ~typed ~detailed ()) p_out pp_perm_or_table_body perm_or_table

let pp_multiple_perm_or_table ?(header = "perm") ?(typed = false)
    ?(detailed = false) (id : ident) (p_in : p) (p_out : p) ppf
    perm_or_table_list =
  Format.fprintf ppf "@[<v 2>%s %a(%a) returns %a@,[@[<v 2>@,%a@]@,@]@]" header
    (Ident.pp ~detailed ()) id (pp_p ~typed ~detailed ()) p_in
    (pp_p ~typed ~detailed ()) p_out
    (fun ppf l ->
      List.iter
        (fun def ->
          match (def, header) with
          | Perm l, "perm" -> pp_perm_or_table_body ppf l
          | Table l, "table" -> pp_perm_or_table_body ppf l
          | _ -> assert false)
        l)
    perm_or_table_list

let pp_optdef ppf o =
  Format.fprintf ppf "%s"
    (match o with
    | Inline -> "_inline "
    | No_inline -> "_no_inline "
    | Interleave n -> Format.sprintf "_interleave(%d) " n
    | No_opt -> "_no_opt "
    | Is_table -> "")

let pp_def ?(typed = false) ?(detailed = false) () ppf (def : def) =
  let id, p_in, p_out = (def.id, def.p_in, def.p_out) in
  Format.fprintf ppf "%a" (pp_list_space pp_optdef) def.opt;
  match def.node with
  | Single (vars, deq) ->
      Format.fprintf ppf "%a"
        (pp_single_node ~typed ~detailed id p_in p_out vars)
        deq
  | Perm l ->
      Format.fprintf ppf "%a"
        (pp_single_perm_or_table ~typed ~detailed id p_in p_out)
        l
  | Table l ->
      Format.fprintf ppf "%a"
        (pp_single_perm_or_table ~header:"table" ~typed ~detailed id p_in p_out)
        l
  | Multiple l -> (
      match List.hd l with
      | Single _ ->
          Format.fprintf ppf "%a"
            (pp_multiple_nodes ~typed ~detailed id p_in p_out)
            l
      | Perm _ ->
          Format.fprintf ppf "%a"
            (pp_multiple_perm_or_table ~typed ~detailed id p_in p_out)
            l
      | Table _ ->
          Format.fprintf ppf "%a"
            (pp_multiple_perm_or_table ~header:"table" ~typed ~detailed id p_in
               p_out)
            l
      | _ -> assert false)

let pp_def_list ?(typed = false) ?(detailed = false) () =
  pp_list_comma (pp_def ~typed ~detailed ())

let pp_prog ?(typed = false) ?(detailed = false) () ppf (prog : prog) =
  Format.fprintf ppf "%a@."
    (pp_list_newline (pp_def ~typed ~detailed ()))
    prog.nodes
