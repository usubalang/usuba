open Usuba_AST
open Utils
open Printf

let make_int_list (n:int) : int list =
  let rec aux i acc =
    if i = 0 then acc
    else aux (i-1) (i :: acc) in
  aux n []

let p_to_int_list (p:p) : int list =
  List.flatten @@
    List.map (fun ((_,typ),_) -> match typ with
                               | Bool -> [1]
                               | Int(_,n) -> make_int_list n
                               | _ -> raise (Not_implemented "")) p

let clean_name (id:ident) : string =
  Str.global_replace (Str.regexp "'") "__" id.name

let get_var_id (v:var) : string =
    match v with
    | Var id -> clean_name id
    | _ -> raise (Error "Non-var")
                 
module Shared = struct
  let close_paren = ref 0
  
  let get_vars (def:def) : p =
    match def.node with
    | Single(vars,_) -> vars
    | _ -> raise (Error "Non-single node")
  let get_body (def:def) : deq list =
    match def.node with
    | Single(_,body) -> body
    | _ -> raise (Error "Non-single node")
                 
  let rec e_to_z3 (rename: ident -> string) (e:expr) : string =
    let e_to_z3 = e_to_z3 rename in
    match e with
    | Const b -> sprintf "%b" (b = 1)
    | ExpVar(Var v) -> sprintf "%s" (clean_name v)
    | Not(e) -> sprintf "(not %s )" (e_to_z3 e)
    | Log(And,x,y)  -> sprintf "(and %s %s)" (e_to_z3 x) (e_to_z3 y)
    | Log(Or,x,y)   -> sprintf "(or %s %s)" (e_to_z3 x) (e_to_z3 y)
    | Log(Xor,x,y)  -> sprintf "(xor %s %s)" (e_to_z3 x) (e_to_z3 y)
    | Log(Andn,x,y) -> sprintf "(and (not %s) %s)" (e_to_z3 x) (e_to_z3 y)
    | Fun(f,l)    -> sprintf "(%s-%s %s)" (rename f) "0" (join " "
                                                               (List.map e_to_z3 l))
    | _ -> raise (Not_implemented (Usuba_print.expr_to_str e))
                 
  let asgn_to_z3 (p:var list) (e:expr) rename share_fun : string =
    match p with
    (* A single variable (=> the expr is "simple" *)
    | [ Var v ] -> incr close_paren;
                   sprintf "(let ((%s %s))" (clean_name v) (e_to_z3 rename e)
    (* Several variables (=> the expr is a function call *)
    | _ -> match e with
           | Fun(f,l) ->
              join "\n  "
                   (List.mapi
                      (fun i v ->
                       incr close_paren;
                       sprintf "(let ((%s (%s-%d %s)))"
                               (get_var_id v)
                               ((if share_fun then clean_name else rename) f) i
                               (join " "
                                     (List.map
                                        (e_to_z3 rename) l)))
                      p)
           | _ -> unreached ()
                            
  let z3_node (def:def) rename share_fun : string =
    
    let f_id     = rename def.id in
    let in_list  = join " " (List.map (fun ((id,_),_) ->
                                       sprintf "(%s Bool)" (clean_name id)) def.p_in) in
    let out_list = List.map (fun ((id,_),_) -> clean_name id) def.p_out in
    let body     = get_body def in

    join "\n"
         (List.mapi
            (fun i id ->
             close_paren := 0;
             let fun_str = 
               sprintf "(define-fun %s-%d (%s) Bool\n  %s\n  %s)"
                       f_id i in_list
                       (join "\n  "
                             (List.map (function
                                         | Norec(p,e) -> asgn_to_z3 p e rename share_fun
                                         | _ -> unreached ()) body))
                       id in
             fun_str ^ (String.init !close_paren (fun _ -> ')')))
            out_list)

end
                  
module Usuba0 = struct
           
  let z3_node (def:def) rename share_fun : string =
    Shared.z3_node def rename share_fun
                                             
                                             
  let rec z3_def rename share_fun (def:def) : string =
    match def.node with
    | Single(vars,body) -> z3_node def rename share_fun
    | _ -> unreached ()
        
  let gen_z3 (prog:prog) (prefix:string) share_fun : string =
    let rename (id:ident) : string = prefix ^ "-" ^ (clean_name id) in
    join "\n" (List.map (z3_def rename share_fun) prog.nodes)
         
end 
                  
module Usuba = struct

  let rename (id:ident) : string = "std-" ^ (clean_name id)

  let all_but_last (l:'a list) : 'a list =
    let rec aux l acc =
      match l with
      | [] -> []
      | [ _ ] -> List.rev acc
      | hd::tl -> aux tl (hd::acc) in
    aux l []

  let z3_node (def:def) : string =
    Shared.z3_node def rename true
                   
          
                                             
  let z3_table (def:def) (l:int list) : string =
    let id = rename def.id in
    let int_to_idx (n:int) (size:int): bool list =
      let res = ref [] in
      for i = size-1 downto 0 do
        res := (n lsr i land 1 = 1) :: !res
      done;
      !res in
    let int_l_in = p_to_int_list def.p_in in
    let int_l_out = p_to_int_list def.p_out in
    let size_in = List.length int_l_in in
    let size_out = List.length int_l_out in
    let args = join " " (List.mapi (fun i _ -> sprintf "(i-%d Bool)" i) int_l_in) in
    join "\n"
         (List.mapi
            (fun i _ ->
             sprintf
               "(define-fun %s-%d (%s) Bool\n   %s %B%s)"
               id i args
               (join "\n   "
                     (List.mapi
                        (fun idx v ->
                         let idx = List.rev (int_to_idx idx size_in) in
                         let v   = List.nth (int_to_idx v size_out) (size_out-i-1) in
                         sprintf "(if (and %s) %B"
                                 (join " "
                                       (List.mapi
                                          (fun i b ->
                                           sprintf "(= i-%d %B)" i b) idx)) v)
                        (all_but_last l)))
               (List.nth (int_to_idx (last l) size_out) (size_out-i-1))
               (String.init (List.length l-1) (fun _ -> ')'))) int_l_out)

        
  let z3_perm (def:def) (l:int list) (renameb:bool) : string =
    let id = if renameb then rename def.id else clean_name def.id in
    let int_l = p_to_int_list def.p_in in
    let args = join " " (List.mapi (fun i _ -> sprintf "(i-%d Bool)" i) int_l) in
    join "\n" (List.mapi (fun i x -> sprintf "(define-fun %s-%d (%s) Bool i-%d)"
                                             id i args (x-1)) l)
                                          
  let rec z3_def (def:def) : string =
    let converted = 
      match def.node with
      | Single(vars,body) -> z3_node def
      | Perm l -> z3_perm def l true
      | Table l -> z3_table def l
      | _ -> assert false
    in
    converted

  let norm_def env_fun (def:def) : def =
    (* remove tuples of 1 elt *)
    Norm_tuples.Simplify_tuples.simpl_tuples_def @@
      (* explode tuples *)
      Norm_tuples.Split_tuples.split_tuples_def @@
        (* apply shifts *)
        Bitslice_shift.shift_def @@
          (* remove tuples of 1 elt *)
          Norm_tuples.Simplify_tuples.simpl_tuples_def @@
            (* explode tuples *)
            Norm_tuples.Split_tuples.split_tuples_def @@
              (* remove nested function calls *)
              Norm_bitslice.norm_def_z3 env_fun @@
                (* remove uintn *)
                Norm_uintn.norm_def @@
                  (* expand constants *)
                  Expand_const.expand_def @@
                    (* remove arrays *)
                    Expand_array.expand_def def

      
  let simplify (prog:prog) : prog =
    let prog = Expand_multiples.expand_multiples (Rename.rename_prog prog) in
    let env_fun = Hashtbl.create 100 in
    { nodes = List.map (norm_def env_fun) prog.nodes } 
                                            
  let gen_z3 (prog:prog) : string =
    let nodes = (simplify prog).nodes in
    join "\n" (List.map z3_def nodes)
    
    
end

module Get_funcalls = struct

  let rec funcalls_expr (e:expr) : string list =
    match e with
    | Const _ | ExpVar _ | Shuffle _ -> []
    | Tuple l -> List.flatten @@ List.map funcalls_expr l
    | Not e -> funcalls_expr e
    | Shift(_,e,_) -> funcalls_expr e
    | Log(_,x,y) -> (funcalls_expr x) @ (funcalls_expr y)
    | Arith(_,x,y) -> (funcalls_expr x) @ (funcalls_expr y)
    | Fun(f,l) -> f.name :: (List.flatten @@ List.map funcalls_expr l)
    | When(e,_,_) -> funcalls_expr e
    | Merge(_,l) -> List.flatten @@ List.map (fun (_,e) -> funcalls_expr e) l
    | Fby _ | Fun_v _ -> assert false
  
  let get_funcalls (def:def) : string list =
    match def.node with
    | Single(_,body) -> List.flatten @@
                          List.map (function
                                     | Norec(_,e) -> funcalls_expr e
                                     | _ -> []) body
    | _ -> []
    
end

               
let check_eq_def (orig:def) (normed:def) all_nodes (dir:string) =
  let rename id = (Str.global_replace (Str.regexp "'") "__" id.name) ^ ".z3" in
  let ua  = Usuba.z3_def orig in
  let ua0 = Usuba0.z3_def (fun id -> "ua0-" ^ (clean_name id)) true normed in

  let funcalls = Hashtbl.create 10 in
  List.iter (fun id -> Hashtbl.replace funcalls id
                                       (Hashtbl.find all_nodes id))
            (Get_funcalls.get_funcalls orig);
  List.iter (fun id -> Hashtbl.replace funcalls id
                                       (Hashtbl.find all_nodes id))
            (Get_funcalls.get_funcalls normed);
  
  let p_in  = normed.p_in in
  let p_out = normed.p_out in
  let std_id = Usuba.rename orig.id in
  let ua0_id = "ua0-" ^  (clean_name normed.id) in
  let arg_list = join " " (List.mapi (fun i _ -> sprintf "i-%d" i) p_in) in

  let cmp_z3 = sprintf
"%s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

%s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(assert (forall (%s)
          (and %s)))

(check-sat)
 "
(join "\n"
      (Hashtbl.fold (fun _ v acc -> v::acc) funcalls []))
ua0 ua
(join " " (List.mapi (fun i _ -> sprintf "(i-%d Bool)" i) p_in))
(join "\n               "
      (List.mapi (fun i _ -> sprintf "(= (%s-%d %s) (%s-%d %s))"
                                     std_id i arg_list
                                     ua0_id i arg_list) p_out)) in

  let filename = Filename.concat dir ("no_inl_" ^ (rename (fresh_ident std_id))) in
  let fh = open_out filename in
  output_string fh cmp_z3;
  close_out fh;
  if (Sys.command ("z3 " ^ filename ^ " > /dev/null")) <> 0 then
    (fprintf stderr "Z3: compilation of node '%s' is unsound." orig.id.name;
     exit 1)
                 
let z3_1_by_1_no_inline (prog:prog) (filename:string) : unit =

  let dir = Filename.(concat "z3" (chop_suffix (basename filename) ".ua")) in
  (* Unix.mkdir would be cleaner *)
  let _ = Sys.command ("mkdir -p " ^ dir) in
  
  let z3_conf = { default_conf with warnings = false;
                                    verbose  = 0;
                                    check_tbl = false;
                                    inlining = false; } in
  let normed = Normalize.norm_prog prog z3_conf in
  let prog = Usuba.simplify prog in

  (* Checking Usuba vs Usuba0 non-inlined *)
  let all_nodes = Hashtbl.create 100 in
  List.iter
    (fun def ->
     Hashtbl.add all_nodes def.id.name
                 (match def.node with
                  | Perm l -> Usuba.z3_perm def l false
                  | _ ->   let in_list = join " " (List.map
                                                     (fun _ -> "Bool")
                                                     (p_to_int_list def.p_in)) in
                           
                           (join "\n"
                                 (List.mapi
                                    (fun i _ ->
                                     sprintf "(declare-fun %s-%d (%s) Bool)"
                                             (clean_name def.id) i in_list)
                                    (p_to_int_list def.p_out))))) prog.nodes;
  List.iter (fun def ->
             let in_list = join " " (List.map
                                       (fun _ -> "Bool")
                                       (p_to_int_list def.p_in)) in
             Hashtbl.replace all_nodes def.id.name
                             (join "\n"
                                   (List.mapi
                                      (fun i _ ->
                                       sprintf "(declare-fun %s-%d (%s) Bool)"
                                               (clean_name def.id) i in_list)
                                      (p_to_int_list def.p_out)))) normed.nodes;

  let normed_nodes = Hashtbl.create 100 in
  List.iter (fun def -> env_add normed_nodes def.id def) normed.nodes;
  
  List.iter (fun def -> match env_fetch normed_nodes def.id with
                        | Some norm_def -> check_eq_def def norm_def all_nodes dir
                        | None -> ()) prog.nodes

            
let z3_ua0_inline (prog:prog) (filename:string) : unit =  
  let dir = Filename.(concat "z3" (chop_suffix (basename filename) ".ua")) in
  (* Unix.mkdir would be cleaner *)
  let _ = Sys.command ("mkdir -p " ^ dir) in
  
  let z3_conf = { default_conf with warnings = false;
                                    verbose  = 0;
                                    check_tbl = false;
                                    inlining = true; } in
  let no_inline = Normalize.norm_prog prog { z3_conf with inlining = false } in
  let inlined   = Normalize.norm_prog prog z3_conf in

  let ua_ni = Usuba0.gen_z3 no_inline "ni" false in
  let ua_in = Usuba0.gen_z3 inlined "in" false in

  let p_in  = (last inlined.nodes).p_in in
  let p_out = (last inlined.nodes).p_out in
  let ni_id = "ni-" ^ (clean_name (last no_inline.nodes).id) in
  let in_id = "in-" ^ (clean_name (last inlined.nodes).id) in
  let arg_list = join " " (List.mapi (fun i _ -> sprintf "i-%d" i) p_in) in

  let cmp_z3 = 
  sprintf
"%s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(assert (forall (%s)
          (and %s)))
(check-sat)
 "
ua_in ua_ni
(join " " (List.mapi (fun i _ -> sprintf "(i-%d Bool)" i) p_in))
(join "\n               "
      (List.mapi (fun i _ -> sprintf "(= (%s-%d %s) (%s-%d %s))"
                                     ni_id i arg_list
                                     in_id i arg_list) p_out)) in
  
  let filename = Filename.concat dir "full_inline.z3" in
  let fh = open_out filename in
  output_string fh cmp_z3;
  close_out fh;
  if (Sys.command ("z3 " ^ filename ^ " > /dev/null")) <> 0 then
    (fprintf stderr "Z3: inlining is unsound.";
     exit 1)


let verify (prog:prog) (filename:string) (conf:config) : unit =
  if conf.verbose >= 1 then
    print_endline "Z3 checks in progress (without inline).";
  z3_1_by_1_no_inline prog filename;
  if conf.verbose >= 1 then
    print_endline "Z3 checks in progress (with inline).";
  z3_ua0_inline prog filename;
  if conf.verbose >= 1 then
    print_endline "Z3 checks OK.";            
