open Usuba_AST
open Basic_utils
open Utils


let rename_for_fd (id:ident) : ident =
  { id with name = "_fd_" ^ id.name }

let rec dup_var (v:var) : var =
  match v with
  | Var id -> Var (rename_for_fd id)
  | Index(v',ae) -> Index(dup_var v',ae)
  | Range(v',ei,ef) -> Range(dup_var v',ei,ef)
  | Slice(v',l) -> Slice(dup_var v',l)

let rec fd_expr (e:expr) : expr =
  match e with
  | Const _  -> e
  | ExpVar v -> ExpVar (dup_var v)
  | Tuple l  -> Tuple (List.map fd_expr l)
  | Not x   -> Not (fd_expr x)
  | Shift(op,x,ae) -> Shift(op,fd_expr x,ae)
  | Log(op,x,y)    -> (match op with
                       | And -> Log(Or,fd_expr x,fd_expr y)
                       | Or  -> Log(And,fd_expr x,fd_expr y)
                       | Xor -> Not(Log(Xor,fd_expr x,fd_expr y))
                       | Andn -> Printf.fprintf stderr "Fault detection Andn not implemented.\n";
                                 assert false)
  | Shuffle(v,l)  -> Shuffle(dup_var v,l)
  | Arith _       -> Printf.fprintf stderr "Fault detection with Arith not implemented.\n";
                     assert false
  | Fun(f,l) when f.name = "rand" -> Fun(f,l)
  | _ -> Printf.printf "Wrong expr: %s\n" (Usuba_print.expr_to_str e);
         assert false
  
let rec fd_deqs (deqs:deq list) : deq list =
  flat_map (function
             | Norec(vars,e) ->
                (match e with
                 | Fun(f,[]) when f.name = "rand" ->
                    [ Norec(vars,e);
                      Norec(List.map dup_var vars, ExpVar (List.hd vars)) ]
                 | Fun(f,l) -> [ Norec(vars @ (List.map dup_var vars),
                                       Fun(f,flat_map (fun x -> [ x ; fd_expr x]) l)) ] 
                 | _ -> [ Norec(vars,e) ; Norec(List.map dup_var vars,
                                                fd_expr e) ])
      | Rec(i,ei,ef,dl,opts) -> [ Rec(i,ei,ef,fd_deqs dl,opts) ] ) deqs
  
let dup_p (p:p) : p =
  flat_map (fun vd -> [vd; { vd with vid = rename_for_fd vd.vid }]) p
   
let fd_def (def:def) : def =
  match def.node with
  | Single(vars,body) ->
     { def with
       p_in  = dup_p def.p_in;
       p_out = dup_p def.p_out;
       node  = Single(vars @ (dup_p vars),fd_deqs body) }
  | _ -> def

   
let fault_detection (prog:prog) (conf:config) : prog =
  { nodes = List.map fd_def prog.nodes }
