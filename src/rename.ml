open Abstract_syntax_tree
       
(* Since the transformation of the code will produce new variable names,
   we must rename the old variables to make there won't be any conflicts 
   with those new names (or with any ocaml builtin name).
   Basically, it means adding an "_" at the end of every identifier name. *)
       
let rec rename_expr = function
  | Const c -> Const c
  | Var v   -> Var (v ^ "_")
  | Field(id,n) -> Field(id^"_",n)
  | Tuple l  -> Tuple(List.map rename_expr l)
  | Op(op,l) -> Op(op,List.map rename_expr l)
  | Fun(f,l) -> if f = "print" then Fun(f,List.map rename_expr l)
                else Fun(f^"_",List.map rename_expr l)
  | Mux(e,c,i) -> Mux(rename_expr e, c, i ^ "_")
  | Demux(i,l) -> Demux(i ^ "_", List.map (fun (c,e) -> c,rename_expr e) l)
  | Fby(ei,ef,f)   -> Fby(rename_expr ei,rename_expr ef,match f with
                                                        | None -> None
                                                        | Some id -> Some (id^"_"))
  | Nop -> Nop
             
let rec rename_pat = function
  | [] -> []
  | hd::tl -> ( match hd with
                | Ident id -> Ident (id ^ "_")
                | Dotted(id,n) -> Dotted(id ^ "_", n) ) :: (rename_pat tl)
                                                             
let rec rename_deq = function
  | [] -> []
  | (pat,expr) :: tl -> (rename_pat pat,rename_expr expr)::(rename_deq tl)
                                                             
let rec rename_p = function
  | [] -> []
  | (id,typ,ck)::tl -> (id^"_",typ,ck)::(rename_p tl)
                                          
let rename_def (name, p_in, p_out, p_var, body) =
  (name^"_", rename_p p_in, rename_p p_out, rename_p p_var, rename_deq body)
    
let rec rename_defs = function
  | [] -> []
  | hd::tl -> (rename_def hd) :: (rename_defs tl)
                                   
let rename_prog (p: prog) : prog =
  rename_defs p

