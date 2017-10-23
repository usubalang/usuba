
open Usuba_AST
open Printf
open Utils

let block_size  = ref 64
let key_size    = ref 64
let warnings    = ref false
let verbose     = ref 1
let verif       = ref false
let type_check  = ref true
let clock_check = ref true
let check_tbl   = ref false
                     
let inlining    = ref true
let inline_all  = ref false
let cse_cp      = ref true
let scheduling  = ref true
let array_opti  = ref true
let share_var   = ref true
let precal_tbl  = ref true
                     
let arch        = ref Std
let bit_per_reg = ref 64
let bench       = ref false
let ortho       = ref true
let openmp      = ref 1
let output      = ref ""


let str_to_arch = function
  | "std"     -> Std
  | "mmx"     -> MMX
  | "sse"     -> SSE
  | "avx"     -> AVX
  | "avx512"  -> AVX512
  | "neon"    -> Neon
  | "altivec" -> AltiVec
  | x -> raise (Error ("Invalid archi: " ^ x))

let bits_in_arch = function
  | Std      -> 64
  | MMX      -> 64
  | SSE      -> 128
  | AVX      -> 256
  | AVX512   -> 512
  | Neon     -> 128
  | AltiVec  -> raise (Error "No idea how much bits in AltiVec")

let gen_output_filename (file_in: string) : string =
  let full_name = match (String.split_on_char '.' file_in) with
    | []   -> file_in
    | x::_ ->  x in
  let path = String.split_on_char '/' full_name in
  let out_name = List.nth path (List.length path - 1) in
  "samples/C/" ^ out_name ^ ".c"
               
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
      "-no-clock-check", Arg.Clear type_check, "Deactivate clock checking";
      "-no-checks", Arg.Unit (fun () -> type_check := false;
                                        clock_check := false),
                    "Deactivate both type and clock checking";
      "-no-inlining", Arg.Clear inlining, "Deactivate inlining opti";
      "-inline-all", Arg.Set inline_all, "Force inlining of every node";
      "-no-CSE-CP", Arg.Clear cse_cp, "Deactive CSE and CP opti";
      "-no-sched", Arg.Clear scheduling, "Deactivate scheduling opti";
      "-no-arr", Arg.Clear array_opti, "Deactivate array opti";
      "-no-share", Arg.Clear share_var, "Deactivate variable sharing";
      "-no-precalc-tbl", Arg.Clear precal_tbl, "Don't use pre-computed tables";
      "-arch", Arg.String (fun s -> arch := str_to_arch s), "Set architecture";
      "-bits-per-reg", Arg.Set_int bit_per_reg, "Set number of bits to use in the registers (with -arch std only, needs to be a multiple of 2)";
      "-bench", Arg.Set bench, "Generate benchmark runtime";
      "-ortho", Arg.Set ortho, "Perform data orthogonalization";
      "-no-ortho", Arg.Clear ortho, "Don't perform data orthogonalization";
      "-openmp", Arg.Set_int openmp, "Set the number of core to use";
      "-o", Arg.Set_string output, "Set the output filename";
    ] in
  let usage_msg = "Usage: usuba [switches] [files]" in
  let compile s =
    let prog = Parse_file.parse_file s in
    let bits_per_reg = if !bit_per_reg <> 64 then !bit_per_reg
                       else bits_in_arch !arch in
    let conf = { block_size  = !block_size;
                 key_size    = !key_size;
                 warnings    = !warnings;
                 verbose     = !verbose;
                 verif       = !verif;
                 type_check  = !type_check;
                 clock_check = !clock_check;
                 check_tbl   = !check_tbl;
                 inlining    = !inlining;
                 inline_all  = !inline_all;
                 cse_cp      = !cse_cp;
                 scheduling  = !scheduling;
                 array_opti  = !array_opti;
                 share_var   = !share_var;
                 precal_tbl  = !precal_tbl;
                 archi       = !arch;
                 bit_per_reg = bits_per_reg; (* local var! *)
                 bench       = !bench;
                 ortho       = !ortho;
                 openmp      = !openmp;
               } in

    if conf.archi = Std && conf.bit_per_reg mod 2 <> 0 then
      raise (Error ("Invalid -fix-size " ^ (string_of_int conf.bit_per_reg)));

    if !type_check then
     if not (Type_checker.is_typed prog) then
       raise (Error "Unsound program: bad types");
    if !clock_check then
      if not (Clock_checker.is_clocked prog) then
        raise (Error "Unsound program: bad clocks");
    if !verif then Gen_z3.verify prog s conf;
    print_c s prog conf in
      
  
  Arg.parse speclist compile usage_msg
    

let () = main ()
