
open Abstract_syntax_tree
open Utils
open Specific_rewriter
open Rename
open Print_ast

exception Not_implemented of string
exception Empty_list
exception Undeclared of string
exception Invalid_param_size
exception Invalid_operator_call
            
            
(* ************************************************** *)
(*   AST transformation to match naive bool backend   *)
(* ************************************************** *)

module Make (Aux : SPECIFIC_REWRITER ) = struct
                             
                             
  (* Auxiliary functions that need to be embeded in the code *)
  let aux_fun = ref []
  let print_fun = ref []
  let entry   = ref ""

  let tmp_generator =
    let counter = ref 0 in
    fun () -> incr counter;
              "__tmp" ^ (string_of_int !counter) ^ "_"

                    
  (* Flatten a list of expr inside a tuple *)
  let rec flatten_expr (l: expr list) : expr list =
    match l with
    | [] -> []
    | hd::tl -> (match hd with
                 | Tuple l -> flatten_expr l
                 | _ -> [ hd ]) @ (flatten_expr tl)

  let rec distrib_not (l: expr list) : expr list =
    match l with
    | [] -> []
    | hd::tl -> (Op(Not,[hd])) :: (distrib_not tl)

  let rec combine_op op l1 l2 =
    match l1, l2 with
    | [], [] -> []
    | hd1::tl1, hd2::tl2 -> (Op(op,[hd1;hd2])) :: (combine_op op tl1 tl2)
    | _ -> raise Invalid_param_size

  let rec combine_xor l1 l2 =
    match l1, l2 with
    | [], [] -> []
    | hd1::tl1, hd2::tl2 -> ( Op(Or,
                                 [ Op(And, [ hd1; Op(Not, [ hd2 ]) ]) ;
                                   Op(And, [ Op(Not, [ hd1 ]); hd2 ])]) )
                            :: (combine_xor tl1 tl2)
    | _ -> raise Invalid_param_size

  let rec get_size e env =
    match e with
    | Const _ -> 1
    | Var x   -> 1 (* at this point, Var are only Bool *)
    | Field _ -> 1
    | Tuple l -> List.fold_left (+) 0 (List.map (fun x -> get_size x env) l)
    | Op _    -> 1 (* at this point, Op have already been normalized *)
    | Fun(f,_) -> (match env_fetch env f with
                   | Some (_,v) -> v
                   | None -> if contains f "print" then 1
                             else raise @@ Undeclared("function " ^ f))
    | Mux _ -> raise (Not_implemented "Mux")
    | Demux _  -> raise (Not_implemented "Demux")
    | Fby(ei,_,_) -> get_size ei env
    | Nop -> 0
    | _ -> raise (Invalid_AST "Non-conform AST")

  let rec get_sizes l env =
    match l with
    | [] -> []
    | hd::tl -> ( get_size hd env ) :: (get_sizes tl env)

  let rec sizes_from_expr e env =
    match e with
    | Const _ -> [1]
    | Var x   -> [1] (* at this point, Var are only Bool *)
    | Field _ -> [1]
    | Tuple l -> List.map (fun x -> get_size x env) l
    | Op _    -> [1] (* at this point, Op have already been normalized *)
    | Fun(f,_) -> (match env_fetch env f with
                   | Some (_,v) -> [v]
                   | None -> if contains f "print" then [1]
                             else raise @@ Undeclared("function " ^ f))
    | Mux _ -> raise (Not_implemented "Mux")
    | Demux _  -> raise (Not_implemented "Demux")
    | Fby(ei,_,_) -> [get_size ei env]
    | Nop -> [0]
    | _ -> raise (Invalid_AST "Non-conform AST")
                                         
  let gen_conv =
    let cache = Hashtbl.create 10 in
    fun target orig ->
    if target = orig then "id"
    else
      let key = (join " " (List.map string_of_int orig)) ^ "_" ^
                  (join " " (List.map string_of_int target)) in
      match env_fetch cache key with
      | Some name -> name
      | None ->
        begin
          let id = "convert" ^ (string_of_int @@ id_generator ()) in
          let num_param = ref 0 in
          let param = List.map (fun n -> incr num_param;
                                         ("in"^(string_of_int !num_param)^"_",
                                          Int n,
                                          "_")) orig in
          let num_ret = ref 0 in
          let ret = List.map (fun n -> incr num_ret;
                                       ("out"^(string_of_int !num_ret)^"_",
                                        Int n,
                                        "_")) target in
          let rec make_body id_p num_p id_r num_r size_curr_p size_curr_r next_p next_r :
                    (pat * expr) list =
            if size_curr_p = 0 then
              match next_p with
              | [] -> []
              | hd::tl -> make_body (id_p+1) 1 id_r num_r hd size_curr_r tl next_r
            else if size_curr_r = 0 then
              match next_r with
              | [] -> []
              | hd::tl -> make_body id_p num_p (id_r+1) 1 size_curr_p hd next_p tl
            else
              ([Dotted(Ident("out"^(string_of_int id_r)^"_"),num_r)],
               Field(Var("in"^(string_of_int id_p)^"_"),num_p)) ::
                (make_body id_p (num_p+1) id_r (num_r+1) (size_curr_p-1)
                           (size_curr_r-1) next_p next_r)
          in
          let f = Single(id,param,ret,[], make_body 0 1 0 1 0 0 orig target) in
          aux_fun := (!aux_fun) @ [f];
          env_add cache key id;
          id
        end
                                           
  let format_param f l env =
    match env_fetch env f with
    | Some (params,_) ->
       let sizes = get_sizes l env in
       [ Fun (gen_conv params sizes, l) ]
    | None -> raise @@ Undeclared("function " ^ f)

  let rec is_one_only = function
    | [] -> true
    | hd::tl -> hd = 1 && (is_one_only tl)

  let gen_conv_to_size (size:int) (e:expr) env =
    let sizes = sizes_from_expr e env in
    if is_one_only sizes then e
    else match sizes with
         | x::[] -> e
         | _ -> let sizes = sizes_from_expr e env in
                let params = [size] in
                Fun(gen_conv params sizes, [e])
                   
                   
         
  let rec rewrite_expr (env_var: (ident, int) Hashtbl.t)
                       (env_fun: (ident, int list * int) Hashtbl.t) (e: expr)
          : deq * expr =
    let before_deq = ref [] in
    let res = (
    match e with
    | Const c -> Const c (* TODO: convert potential integer to list of bool? *)
    | Var id  -> (match env_fetch env_var id with
                  | Some size -> if size > 1 then Tuple (expand_intn_expr id size)
                                 else e
                  | None -> e) (* Not_found -> it's a boolean *)
    | Field (Var id,n) -> Var (id ^ (string_of_int n))
    | Tuple (l)    -> Tuple (flatten_expr
                               (List.map
                                  (fun x ->
                                   let (deq,e) = rewrite_expr env_var env_fun x in
                                   before_deq := deq @ !before_deq;
                                   e) l))
    | Op (Xor,x1::x2::[]) -> let (deq1, t1) = rewrite_expr env_var env_fun x1 in
                             let (deq2, t2) = rewrite_expr env_var env_fun x2 in
                             before_deq := deq1 @ deq2 @ !before_deq;
                             ( match t1, t2 with
                               | Var _, Var _ | Var _, Const _ | Var _, Field _
                               | Const _, Var _ | Const _, Const _ | Const _, Field _
                               | Field _, Var _ | Field _, Const _ | Field _, Field _
                                    -> Op(Or,
                                        [ Op(And, [ t1; Op(Not,[t2])] ) ;
                                          Op(And, [ Op(Not,[t1]);t2])])
                               | _ -> 
                                  let tmp1 = tmp_generator () in
                                  let tmp2 = tmp_generator () in
                                  env_add env_var tmp1 (get_size t1 env_fun);
                                  env_add env_var tmp2 (get_size t2 env_fun);
                                  let tmp1_pat = rewrite_pat [Ident tmp1] env_var in
                                  let tmp2_pat = rewrite_pat [Ident tmp2] env_var in
                                  let (d1,tmp1_expr) = rewrite_expr env_var env_fun (Var tmp1) in
                                  let (d2,tmp2_expr) = rewrite_expr env_var env_fun (Var tmp2) in
                                  before_deq := !before_deq @ d1 @ d2 @
                                                  [(tmp1_pat,t1); (tmp2_pat,t2)];
                                  (match tmp1_expr, tmp2_expr with
                                   | Tuple l1, Tuple l2 -> Tuple(combine_xor l1 l2)
                                   | _ -> Op(Or,
                                             [ Op(And, [ tmp1_expr; Op(Not,[tmp2_expr])] ) ;
                                               Op(And, [ Op(Not,[tmp1_expr]);tmp2_expr])])))
    | Op (op,x1::x2::[]) -> let (deq1,t1) = rewrite_expr env_var env_fun x1 in
                            let (deq2,t2) = rewrite_expr env_var env_fun x2 in
                            before_deq := deq1 @ deq2 @ !before_deq;
                            ( match t1, t2 with
                              | Var _, Var _ | Var _, Const _ | Var _, Field _
                              | Const _, Var _ | Const _, Const _ | Const _, Field _
                              | Field _, Var _ | Field _, Const _ | Field _, Field _
                                                                    -> Op(op,[t1;t2])
                              | _ -> 
                                 let tmp1 = tmp_generator () in
                                 let tmp2 = tmp_generator () in
                                 env_add env_var tmp1 (get_size t1 env_fun);
                                 env_add env_var tmp2 (get_size t2 env_fun);
                                 let tmp1_pat = rewrite_pat [Ident tmp1] env_var in
                                 let tmp2_pat = rewrite_pat [Ident tmp2] env_var in
                                 let (d1,tmp1_expr) = rewrite_expr env_var env_fun (Var tmp1) in
                                 let (d2,tmp2_expr) = rewrite_expr env_var env_fun (Var tmp2) in
                                 before_deq := !before_deq @ d1 @ d2 @ 
                                                 [(tmp1_pat,t1); (tmp2_pat,t2)] ;
                                 (match tmp1_expr, tmp2_expr with
                                  | Tuple l1, Tuple l2 -> Tuple(combine_op op l1 l2)
                                  | _ -> Op(op,[tmp1_expr;tmp2_expr])))
    | Op (Not,x::[]) -> let (deq,x) = rewrite_expr env_var env_fun x in
                        before_deq := deq @ !before_deq;
                        ( match x with
                          | Var _ | Const _ | Access _ | Field _
                                                         -> Op(Not,[x])
                          | _ -> 
                             let tmp = tmp_generator () in
                             env_add env_var tmp (get_size x env_fun);
                             let tmp_pat = rewrite_pat [Ident tmp] env_var in
                             let (_,tmp_expr) = rewrite_expr env_var env_fun (Var tmp) in
                             before_deq := (tmp_pat,x) ::
                                             !before_deq;
                             ( match tmp_expr with
                               | Tuple l ->
                                  Tuple(distrib_not
                                          (List.map
                                             (fun x ->
                                              let (d,e) = rewrite_expr env_var env_fun x in
                                              before_deq := d @ !before_deq;
                                              e) l))
                               | _ -> Op(Not,[tmp_expr])))
    | Op (Not,l) -> Tuple(distrib_not
                            (List.map
                               (fun x ->
                                let (d,e) = rewrite_expr env_var env_fun x in
                                before_deq := d @ !before_deq;
                                e) l))
    | Op _ -> raise Invalid_operator_call
    | Fun (f,l)    -> if f = "print" then
                        if Aux.keep_print then
                          (match l with
                           | (Var id)::[] ->
                              (match env_fetch env_var id with
                               | Some size ->  if size > 1 then
                                                 let l = expand_intn_expr id size in
                                                 let name = Aux.gen_print l in
                                                 Fun(name, l)
                                               else Fun(f, l)
                               | None -> raise (Undeclared id))
                           | _ -> raise Invalid_operator_call)
                        else Nop
                      else
                        Fun(f, format_param f (List.map (fun x ->
                                   let (deq,e) = rewrite_expr env_var env_fun x in
                                   before_deq := deq @ !before_deq;
                                   e) l) env_fun)
    | Mux (e,c,id) -> let (deq,e) = rewrite_expr env_var env_fun e in
                      before_deq := deq @ !before_deq;
                      e
    | Demux(id,l)  -> raise (Not_implemented "Demux")
    | Fby(ei,ef,f)   -> let (di,ei') = rewrite_expr env_var env_fun ei in
                        let (df,ef') = rewrite_expr env_var env_fun ef in
                        before_deq := di @ df @ !before_deq;
                        Fby(ei', ef' ,f)
    | Nop -> Nop
    | _ -> raise (Invalid_AST "Non-conform AST")
    ) in
    (!before_deq, res)
                           
                           
  and rewrite_pat (pat: pat) (env: (ident, int) Hashtbl.t) : pat =
    match pat with
    | [] -> []
    | hd::tl -> (match hd with
                 | Ident id -> ( match env_fetch env id with
                                 | Some size -> 
                                    if size > 1 then expand_intn_pat id size
                                    else [ Ident id ]
                                 | None -> [ Ident id ] )
                 | Dotted(Ident id,n) -> [ Ident (id ^ (string_of_int n)) ]
                 | _ -> raise (Invalid_AST "Non-conform AST"))
                @ (rewrite_pat tl env)
                    
  and rewrite_deq (deq: deq) (env_var: (ident, int) Hashtbl.t) env_fun : deq =
    match deq with
    | [] -> []
    | (pat,expr) :: tl -> match expr with
                          | Nop -> rewrite_deq tl env_var env_fun
                          | _ -> let pat' = rewrite_pat pat env_var in
                                 let (head,e) = rewrite_expr env_var env_fun expr in
                                 let left_size = List.length pat' in
                                 head @ [(pat',gen_conv_to_size left_size e env_fun)]
                                 @ (rewrite_deq tl env_var env_fun)


  (* mostly converting the uint_n to bools *)
  and rewrite_p (p: p) =
    match p with
    | [] -> []
    | (id,typ,ck)::tl -> ( match typ with
                           | Bool  -> [ (id,Bool,ck) ]
                           | Int x -> expand_intn_typed id x ck
                           | Array _ -> raise (Invalid_AST
                                                 "Arrays should have been cleaned by now")
                         ) @ (rewrite_p tl)

                                                                      
  and rewrite_def (def: def) env_fun : def =
    match def with
    | Single (name, p_in, p_out, p_var, body) ->
       let env_var = Hashtbl.create 10 in
       env_add_var p_in env_var;
       env_add_var p_out env_var;
       env_add_var p_var env_var;
       env_add_fun name p_in p_out env_fun;
       Single(name, p_in, rewrite_p p_out, p_var, rewrite_deq body env_var env_fun)
    | Multiple _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                          "Multiple nodes should have been cleaned by now"))
    | Temporary _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                           "Temporary should be gone by now"))
    | Perm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                      "Perm should be gone by now"))
    | MultiplePerm _ -> raise (Invalid_AST (__FILE__ ^ (string_of_int __LINE__) ^
                                          "MultiplePerm should have been cleaned by now"))
                              
  and rewrite_defs (l: def list)
                       (env_fun: (ident, int list * int) Hashtbl.t)
          : def list =
    match l with
    | [] -> []
    | hd::tl -> let hd' = (rewrite_def hd env_fun) in
                hd' :: (rewrite_defs tl env_fun)
                     
                     
  and rewrite_prog (p: prog) : prog =
    let env_fun = Hashtbl.create 10 in
    let usuba0_prog = (Usuba1_rewriter.rewrite_prog p) in
    let renamed_prog = rename_prog usuba0_prog in
    let p' = rewrite_defs renamed_prog env_fun in
    let (prints,entry_point) =
      Aux.gen_entry_point (Utils.last renamed_prog) in
    print_fun := prints;
    entry := entry_point ;
    (!aux_fun) @ p'
                  

end
