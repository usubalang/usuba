open Usuba_AST
open Utils

       
       
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
    (let normed = Norm_bitslice.norm_prog tables_converted in
     print "PRE-NORMALIZED:" normed conf;
     let scheduled = if conf.scheduling then
                       Pre_schedule.schedule normed else normed in
     print "SCHEDULED:" scheduled conf;
     let inlined = if conf.inlining then
                     Inline.inline scheduled else scheduled in
     print "INLINED:" inlined conf;
     Norm_bitslice.norm_prog inlined) in
  print "NORMALIZED:" normalized conf;
  
  assert (Assert_lang.Usuba_norm.is_usuba_normalized normalized);
  
  let optimized = Optimize.opt_prog normalized conf in
  print "OPTIMIZED:" optimized conf;

  if conf.check_tbl then
    Soundness.tables_sound renamed optimized;

  
  optimized
