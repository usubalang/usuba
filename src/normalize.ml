open Usuba_AST
open Utils


module Bitsliceable = struct

  let rec expr_ok (e:expr) : bool =
    match e with
    | Arith _ -> false
    | Log(_,x,y) -> (expr_ok x) && (expr_ok y)
    | Tuple l  -> List.fold_left (&&) true @@ List.map expr_ok l
    | Fun(_,l) -> List.fold_left (&&) true @@ List.map expr_ok l
    | Shift(_,e,_) -> expr_ok e
    | _ -> true

  let deq_ok (deq:deq) : bool =
    match deq with
    | Norec(_,e) -> expr_ok e
    | _ -> raise (Invalid_AST "Should only have Norec")
  
  let def_ok (def:def) : bool =
    match def with
    | Single(_,_,_,_,body) ->
       List.fold_left (&&) true @@ List.map deq_ok body
    | _ -> raise (Invalid_AST "Should only have Single")
  
  let bitsliceable (prog:prog) : bool =
    List.fold_left (&&) true @@ List.map def_ok prog

end
       
let print title body =
  if false then
    begin
      print_endline title;
      if true then print_endline (Usuba_print.prog_to_str body)
    end

(* Note: the print actually if the boolean if the function "print" above 
         are set to true (or at least the first one) *)
let norm_prog (prog: prog)  =
  print "INPUT:" prog;

  let renamed = Rename.rename_prog prog in
  print "RENAMED:" renamed;

  (* remove arrays and recursion *)
  let array_expanded = Expand_array.expand_array renamed in
  print "ARRAYS EXPANDED:"  array_expanded;

  (* convert lookup-tables to circuit (ie. to nodes) *)
  let tables_converted = Convert_tables.convert_tables array_expanded in
  print "TABLES CONVERTED:" tables_converted;

  (* expand permutation tables *)
  let perm_expanded = Expand_permut.expand_permut tables_converted in
  print "PERM EXPANDED:" perm_expanded;

  let normalized =
    if Bitsliceable.bitsliceable perm_expanded then
      (let normed = Norm_bitslice.norm_prog perm_expanded in
      print "PRE-NORMALIZED:" normed;
      let inlined = Inline.inline normed in
      print "INLINED:" inlined;
      Norm_bitslice.norm_prog inlined)
    else
      perm_expanded in
  print "NORMALIZED:" normalized;

  let optimized = Optimize.opt_prog normalized in
  print "OPTIMIZED:" optimized;

  optimized
