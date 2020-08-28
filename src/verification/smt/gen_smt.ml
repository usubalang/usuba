open Basic_utils
open Utils
open Usuba_AST
open Printf


module SMTlib = struct
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

end

module PythonSMT = struct

  let norm_ident (id:ident) : string =
    Str.global_replace (Str.regexp "'") "_" id.name

  let make_indent (i:int) : string =
    (* using 2 spaces for indentation *)
    (String.make i ' ') ^ (String.make i ' ')

  let typ_to_smt (name:string) (typ:typ) : string =
    let rec get_dim_list (acc:int list) (typ:typ) : int * int list =
      match typ with
      | Uint(_,Mint k,1) -> k, acc
      | Uint(_,Mint k,n) -> k, acc @ [n]
      | Array(typ',s) -> get_dim_list (s :: acc) typ'
      | _ -> assert false in
    match typ with
    | Uint(_,Mint 1,1) -> sprintf "btor.Var(btor.BitVecSort(1), '%s')" name
    | Uint(_,Mint m,1) -> sprintf "btor.Var(btor.BitVecSort(%d),'%s')" m name
    | _ -> let base, sizes = get_dim_list [] typ in
           let opening_brackets = String.make (List.length sizes) '[' in
           let base_type, end_type = match base with
             | 1 -> "btor.Var", "btor.BitVecSort(1)"
             | k -> "btor.Var", sprintf "btor.BitVecSort(%d)" k in
           let var_name = name ^
                            (join "" (List.map (fun _ -> "[%d]") sizes)) in
           let size_tuple = join "," (List.mapi (fun i _ -> sprintf "c%d" i) sizes) in
           let _, end_for =
             List.fold_left (fun (cpt, acc) s -> (cpt+1), (sprintf "for c%d in range(%d)]"
                                                                   cpt s)::acc) (0,[]) sizes in
           let end_for = join " " end_for in
           sprintf "%s %s(%s, '%s' %% (%s)) %s"
                   opening_brackets base_type end_type var_name size_tuple end_for

  let array_to_smt (typ:typ) : string =
    let rec get_dim_list (acc:int list) (typ:typ) : int list =
      match typ with
      | Uint(_,Mint k,1) -> acc
      | Uint(_,Mint k,n) -> acc @ [n]
      | Array(typ',s) -> get_dim_list (s :: acc) typ'
      | _ -> assert false in
    let sizes = get_dim_list [] typ in
    let opening_brackets = String.make (List.length sizes) '[' in
    let fors =
      List.fold_left (fun  acc s -> (sprintf "for _ in range(%d)]" s)::acc) [] sizes in
    let fors = join " " fors in
    sprintf "%s None %s" opening_brackets fors
                       
  let var_d_to_smt (vd:var_d) : string =
    typ_to_smt (norm_ident vd.vid) vd.vtyp

  let log_op_to_smt (slicing:dir) (op:log_op) : string =
    match op with
    | And -> "&"
    | Or  -> "|"
    | Xor -> "^"
    | Andn -> assert false (* Let's hope this is fine *)

  let arith_op_to_smt (op:arith_op) : string =
    match op with
    | Add -> "+"
    | Sub -> "-"
    | Mul -> "*"
    | Div -> "/"
    | Mod -> "%"

  let shift_op_to_smt (op:shift_op) : string =
    match op with
    | Lshift -> "<<"
    | Rshift -> ">>"
    | Lrotate -> "btor.Rol"
    | Rrotate -> "btor.Ror"

  let rec arith_expr_to_smt (ae:arith_expr) : string =
    match ae with
    | Const_e i -> string_of_int i
    | Var_e v   -> norm_ident v
    | Op_e(op,x,y) -> sprintf "(%s %s %s)" (arith_expr_to_smt x) (arith_op_to_smt op)
                              (arith_expr_to_smt y)
               
  let rec var_to_smt (v:var) : string =
    match v with
    | Var id -> (norm_ident id)
    | Index(v',i) -> sprintf "%s[%s]" (var_to_smt v') (arith_expr_to_smt i)
    | _ -> printf "Can't var_to_smt( %s )\n" (Usuba_print.var_to_str v);
           assert false
                     
  let rec expr_to_smt (slicing:dir) (msize:int) (e:expr) : string =
    match e with
    | Const b  -> if b = 1 then "True" else "False"
    | ExpVar v -> var_to_smt v
    | Not e -> sprintf "~ %s" (expr_to_smt slicing msize e)
    | Log(op,x,y) -> sprintf "%s %s %s" 
                                     (expr_to_smt slicing msize x)
                                     (log_op_to_smt slicing op)
                                     (expr_to_smt slicing msize y)
    | Arith(op,x,y) -> sprintf "%s %s %s"
                               (expr_to_smt slicing msize x)
                               (arith_op_to_smt op)
                               (expr_to_smt slicing msize y)
    | Shift(op,e,ae) -> (match op with
                         | Lshift | Rshift -> sprintf "%s %s %d"
                                                      (expr_to_smt slicing msize e)
                                                      (shift_op_to_smt op)
                                                      (eval_arith_ne ae)
                         | Lrotate | Rrotate ->
                                      (* Using Boolector's Rotate functions *)
                                        sprintf "%s(%s,%d)"
                                                        (shift_op_to_smt op)
                                                        (expr_to_smt slicing msize e)
                                                        (eval_arith_ne ae))
                         (* | Lrotate->
                            (* sprintf "(%s << %d) | LShR(%s, %d-%d)" *)
                            (* sprintf "(%s << %d) | (%s >> (%d-%d))" *)
                            sprintf "(%s << %d) | ((%s >> (%d-%d)) & %#010x)"
                                    (expr_to_smt slicing msize e)
                                    (eval_arith_ne ae)
                                    (expr_to_smt slicing msize e)
                                    msize
                                    (eval_arith_ne ae)
                                    (0xFFFFFFFF lsr (msize-(eval_arith_ne ae)))
                          | Rrotate->
                            (* sprintf "LShR(%s, %d) | (%s << (%d-%d))" *)
                            (* sprintf "(%s >> %d) | (%s << (%d-%d))" *)
                            sprintf "((%s >> %d) & %#010x) | (%s << (%d-%d))"
                                    (expr_to_smt slicing msize e)
                                    (eval_arith_ne ae)
                                    (0xFFFFFFFF lsr (eval_arith_ne ae))
                                    (expr_to_smt slicing msize e)
                                    msize
                                    (eval_arith_ne ae)) *)
    | _ -> printf "Can't expr_to_smt( %s )\n" (Usuba_print.expr_to_str e);
           assert false
                  
  let rec deqs_to_smt (indent:int) (prefix:string) (slicing:dir)
                      (msize:int) (deqs:deq list) : string =
    join ""
         (List.map (function
                     | Eqn(vl,Fun(f,l),_) -> (* funcall *)
                        sprintf "%s(%s) = %s(%s)\n"
                                (make_indent indent)
                                (join "," (List.map var_to_smt vl))
                                (prefix ^ (norm_ident f))
                                (join "," (List.map (expr_to_smt slicing msize) l))
                     | Eqn([v],e,_) -> (* Not a funcall *)
                        sprintf "%s%s = %s\n"
                                (make_indent indent)
                                (var_to_smt v)
                                (expr_to_smt slicing msize e)
                     | Loop(i,ei,ef,dl,_) -> (* loop *)
                        sprintf "%sfor %s in range(%d,%d+1):\n%s"
                                (make_indent indent)
                                (norm_ident i)
                                (eval_arith_ne ei)
                                (eval_arith_ne ef)
                                (deqs_to_smt (indent+1) prefix slicing msize dl)
                     | _ -> assert false (* *)
                   ) deqs)
                           
  let def_to_smt (prefix:string) (def:def) : string =
    let p_to_smt p =
         join ""
              (List.map (fun vd -> sprintf "%s%s = %s\n"
                                           (make_indent 1)
                                           (norm_ident vd.vid)
                                           (array_to_smt vd.vtyp))
                        (List.filter (fun vd -> match vd.vtyp with
                                                | Uint(_,_,n) when n > 1 -> true
                                                | Array _ -> true
                                                | _ -> false) p)) in      
    match def.node with
    | Single(vars,body) ->
       let slicing = get_type_dir (List.hd def.p_in).vtyp in
       let msize = match get_type_m (List.hd def.p_in).vtyp with
         | Mint m -> m
         | _ -> assert false in
       let p_out = p_to_smt def.p_out in
       let vars = p_to_smt vars in
       let body = deqs_to_smt 1 prefix slicing msize body in
       sprintf "def %s(%s):\n%s\n%s\n%s\n  return (%s)\n"
               (prefix ^ (norm_ident def.id))
               (join "," (List.map (fun vd -> norm_ident vd.vid) def.p_in))
               p_out
               vars
               body
               (join "," (List.map (fun vd -> norm_ident vd.vid) def.p_out))
    | _ -> assert false

  let prog_inputs_to_smt (prefix:string) (prog:prog) : string =
    let p_in = (last prog.nodes).p_in in
    join ""
         (List.map (fun vd -> sprintf "%s = %s\n" (prefix ^ (norm_ident vd.vid))
                                      (typ_to_smt (norm_ident vd.vid) vd.vtyp)) p_in)

  let prog_to_smt (prefix:string) (prog:prog) : string =
    let prefix = prefix ^ "_" in
    let entry = last prog.nodes in
    sprintf
"
%s

(%s) = %s(%s)
 "
(join "\n\n" (List.map (def_to_smt prefix) prog.nodes))
(join "," (List.map (fun vd -> prefix ^ (norm_ident vd.vid)) entry.p_out))
(prefix ^ (norm_ident entry.id))
(join "," (List.map (fun vd ->  (norm_ident vd.vid)) entry.p_in))

let flat_ors l1 l2 = 
  let var_idx oc n = Format.fprintf oc "ortmp%d" n in
  let rec go n l1 l2 =
    match l1, l2 with
    | [], [] -> Format.asprintf "btor.Assert(%a)\n" var_idx n
    | v1 :: vs1, v2 :: vs2 -> 
       Format.asprintf "%a = btor.Or(orig_%s != dest_%s, %a)\n"
         var_idx (n+1)
         (var_to_smt v1) (var_to_smt v2)
         var_idx n ^
       go (n+1) vs1 vs2
  in
  match l1, l2 with
  | v1 :: vs1, v2 :: vs2  -> 
     Format.asprintf "%a = orig_%s != dest_%s\n" var_idx 0 (var_to_smt v1) (var_to_smt v2) ^
     go 0 vs1 vs2
  | _ -> assert(false)

  let gen_smt (orig:prog) (dest:prog) : string =
    let orig_smt = prog_to_smt "orig" orig in
    let dest_smt = prog_to_smt "dest" dest in
    let inputs = prog_inputs_to_smt "" orig in
    let env_var_orig = build_env_var [] (last orig.nodes).p_out [] in
    let env_var_dest = build_env_var [] (last dest.nodes).p_out [] in
    let out_orig =
      flat_map
        (fun vd ->
         Expand_array.expand_var
           env_var_orig (Hashtbl.create 1) (Hashtbl.create 1) 2 (Var vd.vid))
        (last orig.nodes).p_out in
    let out_dest =
      flat_map
        (fun vd ->
         Expand_array.expand_var
           env_var_dest (Hashtbl.create 1) (Hashtbl.create 1) 2 (Var vd.vid))
        (last dest.nodes).p_out in
    sprintf
"
from pyboolector import *
from timeit import default_timer as timer

btor = Boolector()

# Inputs
%s

######################################################################
#                          Original program                          #
######################################################################
%s



######################################################################
#                        Transformed program                         #
######################################################################
%s


######################################################################
#                        Equivalence checking                        #
######################################################################

%s

start = timer()
res = btor.Sat()
end = timer()
print(\"Running time: \" + str(end - start))
if res == btor.SAT:
  print('SAT')
  #btor.Print_model()
else:
  print('UNSAT')
"
inputs
orig_smt
dest_smt
(flat_ors  out_orig out_dest)
    
end


let print_gen_smt (orig:prog) (dest:prog) (filename:string) : unit =
  let ext = ".py" (* ".smt.l" *) in
  let smt_prog = PythonSMT.gen_smt orig dest in
  let fp = open_create_file (filename ^ ext) in
  output_string fp smt_prog;
  close_out fp
