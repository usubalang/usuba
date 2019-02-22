
open Usuba_AST
open Basic_utils
open Printf

let lift_comma f = fun l -> join "," (List.map f l)
let lift_space f = fun l -> join " " (List.map f l)
                           
let unfold_andn e =
  match e with
  | Log(Andn,x,y) -> Log(And,Not x,y)
  | _ -> e         

let log_op_to_str = function
  | And -> "&"
  | Or  -> "|"
  | Xor -> "^"
  | Andn -> "&~"
             
let arith_op_to_str = function
  | Add -> "+"
  | Mul -> "*"
  | Sub -> "-"
  | Div -> "/"
  | Mod -> "%"

let shift_op_to_str = function
  | Lshift -> "<<"
  | Rshift -> ">>"
  | Lrotate -> "<<<"
  | Rrotate -> ">>>"

let rec arith_to_str = function
  | Const_e i -> string_of_int i
  | Var_e v   -> v.name
  | Op_e(op,x,y) -> sprintf "(%s %s %s)" (arith_to_str x) (arith_op_to_str op)
                            (arith_to_str y)
                                                 
let rec arith_to_str_types = function
  | Const_e i -> "Const_e: " ^ (string_of_int i)
  | Var_e v   -> "Var_e: " ^ v.name
  | Op_e(op,x,y) -> "Op_e(" ^ (arith_to_str_types x) ^ " " ^ (arith_op_to_str op) ^
                      " " ^ (arith_to_str_types y) ^ ")"

let rec var_to_str = function
  | Var v -> v.name
  | Index(v,e) -> sprintf "%s[%s]" (var_to_str v) (arith_to_str e)
  | Range(v,ei,ef) -> sprintf "%s[%s .. %s]" (var_to_str v) (arith_to_str ei) (arith_to_str ef)
  | Slice(v,l) -> sprintf "%s[%s]" (var_to_str v) (join "," (List.map arith_to_str l))
let var_to_str_l = lift_comma var_to_str
                                              
let rec var_to_str_types = function
  | Var v -> sprintf "Var: %s" v.name
  | Index(v,e) -> sprintf "Index: %s[%s]" (var_to_str_types v) (arith_to_str_types e)
  | Range(v,ei,ef) -> sprintf "Range: %s[%s..%s] " (var_to_str_types v) (arith_to_str_types ei)
                              (arith_to_str_types ef)
  | Slice(v,l) -> sprintf "Splice: %s[%s]" (var_to_str_types v)
                          (join "," (List.map arith_to_str_types l))

let constr_to_str = function
  | True  -> "True"
  | False -> "False"
                                                                    
let rec expr_to_str_types = function
  | Const c -> "Const: " ^ (string_of_int c)
  | ExpVar v -> "ExpVar: " ^ (var_to_str v)
  | Tuple t -> "Tuple: (" ^ (join "," (List.map expr_to_str_types t)) ^ ")"
  | Log(Andn,x,y) -> "Andn: " ^ (expr_to_str_types (unfold_andn (Log(Andn,x,y))))
  | Log(o,x,y) -> "Log: " ^ "(" ^ (expr_to_str_types x) ^ (log_op_to_str o)
                  ^ (expr_to_str_types y) ^ ")"
  | Shuffle(v,l) -> sprintf "Shuffle: Shuffle(%s,[%s])" (var_to_str v)
                            (join "," (List.map string_of_int l))
  | Arith(o,x,y) -> "Arith: " ^ "(" ^ (expr_to_str_types x) ^ (arith_op_to_str o)
                    ^ (expr_to_str_types y) ^ ")"
  | Shift(o,x,y) -> "Shift: " ^ "(" ^ (expr_to_str_types x) ^ (shift_op_to_str o)
                    ^ (arith_to_str y) ^ ")"
  | Not e -> "Not: ~" ^ (expr_to_str_types e)
  | Fun(f,l) -> "Fun: " ^ f.name ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fun_v(f,e,l) -> "Fun_v: " ^ f.name ^ "[" ^ (arith_to_str e) ^ "]"
                               ^ "(" ^ (join "," (List.map expr_to_str_types l)) ^ ")"
  | Fby(ei,ef,id) -> "Fby: " ^ (expr_to_str_types ei) ^ " fby " ^ (expr_to_str_types ef)
  | When(e,c,x)  -> sprintf "When: %s when %s(%s)" (expr_to_str_types e) (constr_to_str c) x.name
  | Merge(ck,c)   -> sprintf "Merge: merge %s %s"
                             ck.name (join " "
                                      (List.map (fun (c,y) ->
                                                 sprintf "| %s -> %s "
                                                         (constr_to_str c)
                                                         (expr_to_str_types y)) c))

let rec expr_to_str = function
  | Const c -> (string_of_int c)
  | ExpVar v   -> var_to_str v
  | Tuple t -> sprintf "(%s)" (join "," (List.map expr_to_str t))
  | Log(o,x,y) -> sprintf "(%s %s %s)" (expr_to_str x)
                          (log_op_to_str o) (expr_to_str y)
  | Shuffle(v,l) -> sprintf "Shuffle(%s,[%s])" (var_to_str v)
                            (join "," (List.map string_of_int l))
  | Arith(o,x,y) -> sprintf "(%s %s %s)" (expr_to_str x)
                            (arith_op_to_str o) (expr_to_str y)
  | Shift(o,x,y) -> sprintf "(%s %s %s)" (expr_to_str x)
                            (shift_op_to_str o) (arith_to_str y)
  | Not e -> sprintf "(~ %s)" (expr_to_str e)
  | Fun(f,l) -> sprintf "%s(%s)" f.name (join "," (List.map expr_to_str l))
  | Fun_v(f,e,l) -> sprintf "%s[%s](%s)" f.name (arith_to_str e)
                            (join "," (List.map expr_to_str l))
  | Fby(ei,ef,id) -> sprintf "%s fby %s" (expr_to_str ei) (expr_to_str ef)
  | When(e,c,x)  -> sprintf "%s when %s(%s)" (expr_to_str e) (constr_to_str c) x.name
  | Merge(ck,c)   -> sprintf "merge %s %s"
                             ck.name (join " "
                                      (List.map (fun (c,y) ->
                                                 sprintf "| %s -> %s "
                                                         (constr_to_str c)
                                                         (expr_to_str y)) c))
let expr_to_str_l = lift_comma expr_to_str

let pat_to_str pat =
  "(" ^ (join "," (List.map var_to_str pat)) ^ ")"
let pat_to_str_types pat =
  "(" ^ (join "," (List.map var_to_str_types pat)) ^ ")"

let m_to_str m =
  match m with
  | Mint n  -> sprintf "%d" n
  | Mvar id -> id.name
                                                       
let dir_to_str d =
  match d with
  | Hslice     -> "<H>"
  | Vslice     -> "<V>"
  | Bslice     -> "<B>"
  | Mslice i   -> sprintf "<%d>" i
  | Varslice v -> if v.name = "D" then "" else sprintf "<%s>" v.name
          
let rec typ_to_str typ =
  match typ with
  | Nat -> "nat"
  | Uint(d,m,n) ->
     let dir_str = dir_to_str d in
     begin match m with
     | Mint 1  -> sprintf "b%s%d" dir_str n
     | Mint i  -> if n = 1 then sprintf "u%s%d" dir_str i
                  else sprintf "u%s%dx%d" dir_str i n
     | Mvar id -> if id.name = "m" then sprintf "v%s%d" dir_str n
                  else sprintf "u%s%sx%d" dir_str id.name n end
  | Array(typ,n) -> sprintf "%s[%d]" (typ_to_str typ) n
let typ_to_str_l = lift_comma typ_to_str

let rec clock_to_str ck =
  match ck with
  | Defclock -> "_"
  | Base -> "base"
  | On(ck,x) -> (clock_to_str ck) ^ " on " ^ x.name
  | Onot(ck,x) -> (clock_to_str ck) ^ " onot " ^ x.name

let var_d_opt_to_str (vopt:var_d_opt) =
  match vopt with
  | Pconst -> "const"
  | PlazyLift  -> "lazyLift"
let var_d_opt_to_str_l = lift_space var_d_opt_to_str
                                                   
let vd_to_str (vd:var_d) =
  sprintf "%s : %s %s :: %s"
          vd.vid.name
          (var_d_opt_to_str_l vd.vopts)
          (typ_to_str vd.vtyp)
          (clock_to_str vd.vck)
let p_to_str = lift_comma vd_to_str
                            

let optstmt_to_str = function
  | Unroll    -> "_unroll"
  | No_unroll -> "_no_unroll"
  | Pipelined -> "_pipelined"
  | Safe_exit -> "_safe_exit"
                   
let rec deq_to_str = function
  | Eqn(pat,e,sync) -> sprintf "%s %s= %s" (pat_to_str pat) (if sync then ":" else "")
                                (expr_to_str e)
  | Loop(id,ei,ef,d,opts) ->
     sprintf "%s%sforall %s in [%s,%s] {\n    %s\n  }"
             (join " " (List.map optstmt_to_str opts))
             (if List.length opts > 0 then " " else "")
             id.name  (arith_to_str ei) (arith_to_str ef)
             (join "\n    " (List.map deq_to_str d))
let deq_to_str_l = lift_comma deq_to_str
                                                                                 
let rec deq_to_str_types = function
  | Eqn(pat,e,sync) -> sprintf "%s %s= %s" (pat_to_str_types pat) (if sync then ":" else "")
                               (expr_to_str_types e)
  | Loop(id,ei,ef,d,opts) ->
     sprintf "%s forall %s in [%s,%s] {\n    %s\n  }"
             (join " " (List.map optstmt_to_str opts))
             id.name  (arith_to_str_types ei) (arith_to_str_types ef)
             (join "\n    " (List.map deq_to_str_types d))
     
                                                                
let single_node_to_str (id:ident) (p_in:p) (p_out:p) (vars:p) (deq:deq list) =
  "node " ^ id.name ^ "(" ^ (p_to_str p_in) ^ ")\n  returns "
  ^ (p_to_str p_out) ^ "\nvars\n"
  ^ (join ",\n" (List.map (fun x -> "  " ^ (vd_to_str x)) vars)) ^ "\nlet\n"
  ^ (join ";\n" (List.map (fun x -> "  " ^ x) (List.map deq_to_str deq)))
  ^ "\ntel"

let optdef_to_str = function
  | Inline    -> "_inline"
  | No_inline -> "_no_inline"
  | Interleave n -> sprintf "_interleave(%d)" n
  | No_opt    -> "_no_opt"
  | Is_table  -> ""
      
let def_to_str (def:def) =
  let (id,p_in,p_out) = (def.id,def.p_in,def.p_out) in
  (join " " (List.map optdef_to_str def.opt)) ^ " " ^ 
    (match def.node with
     | Single(vars,deq) ->
        single_node_to_str id p_in p_out vars deq
     | Perm l ->
        "perm " ^ id.name ^ "(" ^ (p_to_str p_in)
        ^ ")\n  returns " ^ (p_to_str p_out) ^ "\n{\n  "
        ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
     | Table l ->
        "table " ^ id.name ^ "(" ^ (p_to_str p_in)
        ^ ")\n  returns " ^ (p_to_str p_out) ^ "\n{\n  "
        ^ (join ", " (List.map string_of_int l)) ^ "\n}\n"
                                                     
     | Multiple l ->
        match List.nth l 0 with
        | Single _ ->
           "node " ^ id.name ^ "(" ^ (p_to_str p_in)
           ^ ")\n  returns " ^ (p_to_str p_out) ^ "\n[\n"
           ^  (join "\n;\n"
                    (List.map
                       (fun x -> match x with
                                 | Single (v,d) -> "vars\n"
                                                   ^ (join ",\n"
                                                           (List.map
                                                              (fun x -> "  " ^ (vd_to_str x)) v))
                                                   ^ "\nlet\n" 
                                                   ^ (join ";\n"
                                                           (List.map deq_to_str d))
                                                   ^ "\ntel\n"
                                 | _ -> assert false) l))
           ^ "\n]\n"
        | Perm _   ->
           "perm[] " ^ id.name ^ "(" ^ (p_to_str p_in)
           ^ ")\n  returns " ^ (p_to_str p_out) ^ "\n[ "
           ^ (join "\n;\n"
                   (List.map
                      (fun x -> match x with
                                | Perm l -> "["
                                            ^ (join ", " (List.map string_of_int l))
                                            ^ "]"
                                | _ -> assert false) l))
           ^ "\n]\n"
        | Table _  ->
           "table[] " ^ id.name ^ "(" ^ (p_to_str p_in)
           ^ ")\n  returns " ^ (p_to_str p_out) ^ "\n[ "
           ^ (join "\n;\n"
                   (List.map
                      (fun x -> match x with
                                | Table l -> "{"
                                             ^ (join ", " (List.map string_of_int l))
                                             ^ "}"
                                | _ -> assert false) l))
           ^ "\n]\n"
        | _ -> assert false)
let def_to_str_l = lift_comma def_to_str
                                                       
let prog_to_str (prog:prog) : string=
  join "\n\n" (List.map def_to_str prog.nodes)

let print_prog (prog:prog) : unit =
  print_endline (prog_to_str prog)
