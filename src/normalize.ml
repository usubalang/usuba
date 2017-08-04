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
    match def.node with
    | Single(_,body) ->
       List.fold_left (&&) true @@ List.map deq_ok body
    | _ -> true
  
  let bitsliceable (prog:prog) : bool =
    List.fold_left (&&) true @@ List.map def_ok prog.nodes

end
       
let print title body conf =
  if conf.verbose >= 5 then
    begin
      print_endline title;
      if conf.verbose >= 100 then print_endline (Usuba_print.prog_to_str body)
    end

(* Note: the print actually print if the booleans in the function "print" above 
         are set to true (or at least the first one) *)
let norm_prog (prog: prog) (conf:config) : prog  =
  print "INPUT:" prog conf;

  let renamed = Rename.rename_prog prog in
  print "RENAMED:" renamed conf;

  (* remove arrays and recursion *)
  let array_expanded = Expand_array.expand_array renamed in
  print "ARRAYS EXPANDED:"  array_expanded conf;

  (* convert lookup-tables to circuit (ie. to nodes) *)
  let tables_converted = Convert_tables.convert_tables array_expanded in
  print "TABLES CONVERTED:" tables_converted conf;

  let normalized =
    if Bitsliceable.bitsliceable tables_converted then
      (let normed = Norm_bitslice.norm_prog tables_converted in
       print "PRE-NORMALIZED:" normed conf;
       let scheduled = Pre_schedule.schedule normed in
       print "SCHEDULED:" scheduled conf;
       let inlined = if conf.inline then Inline.inline scheduled else scheduled in
       print "INLINED:" inlined conf;
       Norm_bitslice.norm_prog inlined)
    else
      tables_converted in
  print "NORMALIZED:" normalized conf;
  
  assert (Assert_lang.Usuba_norm.is_usuba_normalized normalized);

  Printf.fprintf stderr "Warning: variable sharing is disabled.\n";
  let optimized = Optimize.opt_prog normalized false in
  print "OPTIMIZED:" optimized conf;

  if conf.check_tables then
    Soundness.tables_sound renamed optimized;

  
  optimized
