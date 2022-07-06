open Usuba_AST

(* Number of times to repeat benchmarks when comparing several programs *)
let repeat = 30

let bench_code =
  "#include <stdio.h>\n\
   #include <stdlib.h>\n\
   #include <stdint.h>\n\
   #include <x86intrin.h>\n\n\
   #ifndef NB_RUN\n\
   #define NB_RUN 10000000\n\
   #endif\n\n\
   #ifndef WARMING\n\
   #define WARMING 1000\n\
   #endif\n\n\
   uint32_t bench_speed();\n\n\
   int main() {\n\n\
  \  /* Getting number of encrypted bytes */\n\
  \  uint64_t encrypted = bench_speed();\n\n\
  \  /* Warming up caches */\n\
  \  for (int i = 0; i < WARMING; i++)\n\
  \    bench_speed();\n\n\
  \  /* The actual benchmark */\n\
  \  unsigned int garbage;\n\
  \  uint64_t timer = __rdtscp(&garbage);\n\
  \  for (int i = 0; i < NB_RUN; i++)\n\
  \    bench_speed();\n\
  \  timer = __rdtscp(&garbage) - timer;\n\n\
  \  /* Printing the result */\n\
  \  printf(\"%.2f\", (double)timer / (NB_RUN * encrypted));\n\
   }"

(* Returns the name of the executable generated for |prog|. *)
let compile (arch : Config.arch) (bitslice : bool) (prog : prog) : string =
  let conf = { Utils.default_conf with gen_bench = true; archi = arch } in
  let c_prog = GenC_standalone.gen_runtime prog prog conf "" in

  let bin_filename = Filename.temp_file "usuba-perf-bench" "" in
  let c_filename = bin_filename ^ ".c" in
  let out = open_out c_filename in

  Printf.fprintf out "%s\n\n%s" bench_code c_prog;
  close_out out;

  let compile_cmd =
    Printf.sprintf
      "clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize -D \
       NB_RUN=%d -I %s %s -o %s"
      (if bitslice then 100_000 else 1_000_000)
      Config.arch_dir c_filename bin_filename
  in
  ignore (Sys.command compile_cmd);

  bin_filename

(* Runs |bin|, reads its performance on its stdout, and returns it. *)
let get_perf (bin : string) : float =
  let in_chan = Unix.open_process_in bin in
  let res = float_of_string (input_line in_chan) in
  ignore (Unix.close_process_in in_chan);
  res

(* Removes the first and last two elements from *)
let remove_start_end (l : 'a list) : 'a list =
  let rec remove_start l n =
    if n == 0 then l else remove_start (List.tl l) (n - 1)
  in
  let remove_end l n = List.rev (remove_start (List.rev l) n) in
  remove_start (remove_end l 2) 2

(* Returns the performances of each program of |progs|. *)
let compare_perfs (progs : prog list) (conf : Config.config) : float list =
  let bitslice =
    Utils.get_type_dir List.(hd (hd (hd progs).nodes).p_in).vd_typ = Bslice
  in
  let binaries = List.map (compile conf.archi bitslice) progs in

  let perfs = List.map (fun _ -> ref []) progs in

  (* Acquiring the measurements *)
  for _ = 1 to repeat do
    List.iter2 (fun bin perf -> perf := get_perf bin :: !perf) binaries perfs
  done;

  (* Removing extremes *)
  List.iter
    (fun perf -> perf := remove_start_end (List.sort compare !perf))
    perfs;

  (* Computing (and returning) averages *)
  List.map
    (fun perf ->
      let len = float_of_int (List.length !perf) in
      List.fold_left (fun a b -> a +. b) 0. !perf /. len)
    perfs
