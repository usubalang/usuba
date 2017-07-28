open Usuba_AST
open Utils
open Printf
open Usuba_print

let c_file = "soundcheck_c"

let rename_c (name:string) : string =
  Str.global_replace (Str.regexp "'") "__" name
       
let typ_length (typ:typ) : int =
  match typ with
  | Bool -> 1
  | Int n -> n
  | _ -> raise (Error ("Invalid type: " ^ (typ_to_str typ)))


let gen_c_code (prog:prog) (normalized:prog) (c_prog:string) : unit =
  let (filename,out) = Filename.open_temp_file "sound_check" ".c" in
  print_endline filename;
  fprintf out "%s" c_prog;

  let orig_main = last prog.nodes in
  let inputs = List.map (fun (id,typ,_) -> id,typ_length typ) orig_main.p_in in
  let outputs = List.map (fun (id,typ,_) -> id,typ_length typ) orig_main.p_out in

  (* Opening the main *)
  fprintf out
"\n\nint main (int argc, char** argv) {\n\n";
  (* Declaring variables *)
  List.iter (fun (id,size) -> fprintf out "  unsigned long %s[%d];\n" id size ) inputs;
  List.iter (fun (id,size) -> fprintf out "  unsigned long %s[%d];\n" id size ) outputs;
  (* Initializing inputs *)
  let size_prev = ref 0 in
  List.iter (fun (id,size) ->
             fprintf out
"  for (int i = 0; i < %d; i++) { %s[i] = atol(argv[i+1+%d]); }\n" size id !size_prev;
             size_prev := !size_prev + size
            ) inputs;
  (* Calling the entry point *)
  fprintf out "\n  %s (%s,%s);\n\n" (rename_c (last normalized.nodes).id)
          (join "," (List.map fst inputs))
          (join "," (List.map fst outputs));
  (* Printing the outputs *)
  List.iter (fun (id,size) ->
             fprintf out
"  for (int i = 0; i < %d; i++) { printf(\"%%d\",1 & (int)%s[i]); }\n" size id
            ) outputs;
  (* Closing the main *)
  fprintf out "\n  return 0;\n}";
  close_out out;

  (* Compiling the file *)
  let _ = Sys.command("gcc -O3 -march=native " ^ filename ^ " -o " ^ c_file) in
  ()
  
 
let check_soundness (prog:prog) (normalized:prog) (c_prog:string) : unit =
  (* Generating the executable from the C code *)
  gen_c_code prog normalized c_prog

             
  
  (* (if true then *)
  (*    let res = Interp.interp_prog normalized [true;true;true;true;true;true] in *)
  (*    print_bool_list res); *)
  (* fprintf out "%s" (Usuba_to_c.prog_to_c prog normalized); *)
  (* close_out out *)
  
