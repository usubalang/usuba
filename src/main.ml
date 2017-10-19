
open Usuba_AST
open Printf
open Utils

let block_size = ref 64
let key_size   = ref 64
let warnings   = ref false
let verbose    = ref 1
let verif      = ref false
let type_check = ref true
let check_tbl  = ref false
                     
let inlining   = ref true
let inline_all = ref false
let cse_cp     = ref true
let scheduling = ref true
let array_opti = ref true
let share_var  = ref true
let precal_tbl = ref true
                     
let arch       = ref Std
let bench      = ref false
let ortho      = ref true
let openmp     = ref 1
let output     = ref ""


let str_to_arch = function
  | "std"     -> Std
  | "mmx"     -> MMX
  | "sse"     -> SSE
  | "avx"     -> AVX
  | "avx512"  -> AVX512
  | "neon"    -> Neon
  | "altivec" -> AltiVec
  | x -> raise (Error ("Invalid archi: " ^ x))

let gen_output_filename (file_in: string) : string =
  let full_name = match (String.split_on_char '.' file_in) with
    | []   -> file_in
    | x::_ ->  x in
  let path = String.split_on_char '/' full_name in
  let out_name = List.nth path (List.length path - 1) in
  "tests/C/" ^ out_name ^ ".c"
               
let print_c (file_in: string) (prog: Usuba_AST.prog) (conf:config) : unit =
  (* Generating C code *)
  let out = match !output with
    | ""  -> open_out (gen_output_filename file_in)
    | str -> open_out str in

  let normalized = Normalize.norm_prog prog conf in

  let c_prog = Usuba_to_c.prog_to_c prog normalized conf in
  
  fprintf out "%s" c_prog;
  close_out out

            
let main () =
  Printexc.record_backtrace true;

  let speclist = 
    [ "-w", Arg.Set warnings, "Activate warnings";
      "-v", Arg.Set_int verbose, "Set verbosity level";
      "-bsize", Arg.Int (fun n -> block_size := n), "Specify the block size";
      "-ksize", Arg.Int (fun n -> key_size   := n), "Specify the key size";
      "-verif", Arg.Set verif, "Activate verification";
      "-check-tbl", Arg.Set check_tbl, "Activate verification of tables";
      "-no-type-check", Arg.Clear type_check, "Deactivate type checking";
      "-no-inlining", Arg.Clear inlining, "Deactivate inlining opti";
      "-inline-all", Arg.Clear inline_all, "Force inlining of every node";
      "-no-CSE-CP", Arg.Clear cse_cp, "Deactive CSE and CP opti";
      "-no-sched", Arg.Clear scheduling, "Deactivate scheduling opti";
      "-no-arr", Arg.Clear array_opti, "Deactivate array opti";
      "-no-share", Arg.Clear share_var, "Deactivate variable sharing";
      "-no-precalc-tbl", Arg.Clear precal_tbl, "Don't use pre-computed tables";
      "-arch", Arg.String (fun s -> arch := str_to_arch s), "Set architecture";
      "-bench", Arg.Set bench, "Generate benchmark runtime";
      "-ortho", Arg.Set ortho, "Perform data orthogonalization";
      "-no-ortho", Arg.Clear ortho, "Don't perform data orthogonalization";
      "-openmp", Arg.Set_int openmp, "Set the number of core to use";
      "-o", Arg.Set_string output, "Set the output filename";
    ] in
  let usage_msg = "Usage: usuba [switches] [files]" in
  let compile s =
    let prog = Parse_file.parse_file s in
    let conf = { block_size = !block_size;
                 key_size   = !key_size;
                 warnings   = !warnings;
                 verbose    = !verbose;
                 verif      = !verif;
                 type_check = !type_check;
                 check_tbl  = !check_tbl;
                 inlining   = !inlining;
                 inline_all = !inline_all;
                 cse_cp     = !cse_cp;
                 scheduling = !scheduling;
                 array_opti = !array_opti;
                 share_var  = !share_var;
                 precal_tbl = !precal_tbl;
                 archi      = !arch;
                 bench      = !bench;
                 ortho      = !ortho;
                 openmp     = !openmp;
               } in

    if !type_check then
     if not (Type_checker.is_typed prog) then
       raise (Error "Unsound program");
    if !verif then Gen_z3.verify prog s conf;
    print_c s prog conf in
      
  
  Arg.parse speclist compile usage_msg
    

let () = main ()
