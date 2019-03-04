open Basic_utils
open Utils
open Usuba_AST
open Printf

let norm_ident (id:ident) : string =
    Str.global_replace (Str.regexp "'") "_" id.name

let var_d_to_smt (vd:var_d) : string =
  sprintf "(%s Bool)" (norm_ident vd.vid)
                       
let rec var_to_smt (v:var) : string =
  match v with
  | Var id -> (norm_ident id)
  | Index(v',Const_e i) -> sprintf "%s/%d\\" (var_to_smt v') i
  | _ -> assert false

let log_op_to_smt (op:log_op) : string =
  match op with
  | And -> "and"
  | Or  -> "or"
  | Xor -> "xor"
  | Andn -> assert false (* Let's hope this is fine *)
       
let rec expr_to_smt (e:expr) : string =
  match e with
  | Const b  -> sprintf "%b" (b = 1)
  | ExpVar v -> var_to_smt v
  | Not e -> sprintf "(not %s)" (expr_to_smt e)
  | Log(op,x,y) -> sprintf "(%s %s %s)" (log_op_to_smt op)
                           (expr_to_smt x)
                           (expr_to_smt y)
  | _ -> assert false

let deqs_to_smt (deqs:deq list) (out:var_d): string =
  let nb_lets = ref 0 in
  let l = List.map (function
                     | Eqn([v],e,_) -> (* Not a funcall *)
                        incr nb_lets;
                        sprintf "(let ((%s %s))"
                                (var_to_smt v)
                                (expr_to_smt e)
                     | Eqn(vl,Fun(f,l),_) -> (* a funcall *)
                        join "\n  "
                             (List.mapi (fun i v ->
                                         incr nb_lets;
                                         sprintf "(let ((%s (%s-%d %s)))"
                                                 (var_to_smt v)
                                                 (norm_ident f)
                                                 i
                                                 (join " " (List.map expr_to_smt l))) vl)
                     | Loop _ -> Printf.fprintf stderr "Can't encode loop in SMT\n";
                                 assert false
                     | _ -> assert false (* Not normalized or something like that *)
                   ) deqs in
  sprintf "%s\n  %s%s" (join "\n  " l)
          (norm_ident out.vid)
          (String.make !nb_lets ')')
                           
let p_in_to_smt (p:p) : string =
  join " " (List.map var_d_to_smt p)
                           
let def_to_smt (prefix:string) (def:def) : string =
  match def.node with
  | Single(_,body) ->
     join "\n"
          (List.mapi
             (fun i out ->
              sprintf "(define-fun %s%s-%d (%s) Bool\n  %s)\n"
                      (if prefix <> "" then prefix ^ "-" else "")
                      (norm_ident def.id)
                      i
                      (p_in_to_smt def.p_in)
                      (deqs_to_smt body out)
             ) def.p_out)
  | _ -> assert false
                           
       
let gen_smt (prog:prog) : string =
  join "\n\n" (List.map (def_to_smt "") prog.nodes)

let print_gen_smt (prog:prog) (filename:string) : unit =
  let smt_prog = gen_smt prog in
  let fp = open_out filename in
  output_string fp smt_prog;
  close_out fp
