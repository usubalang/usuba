open Basic_utils
open Utils
open Usuba_AST

(* Number of times to repeat benchmarks when comparing several programs *)
let repeat = 10

let bench_code =
"#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <x86intrin.h>

#ifndef NB_RUN
#define NB_RUN 1000000
#endif

#ifndef WARMING
#define WARMING 1000
#endif

uint32_t bench_speed();

int main() {

  /* Getting number of encrypted bytes */
  uint64_t encrypted = bench_speed();

  /* Warming up caches */
  for (int i = 0; i < WARMING; i++)
    bench_speed();

  /* The actual benchmark */
  unsigned int garbage;
  uint64_t timer = __rdtscp(&garbage);
  for (int i = 0; i < NB_RUN; i++)
    bench_speed();
  timer = __rdtscp(&garbage) - timer;

  /* Printing the result */
  printf(\"%.2f\", (double)timer / (NB_RUN * encrypted));
}"


(* Returns the name of the executable generated for |prog|. *)
let compile (prog:prog) : string =
  let conf = { default_conf with gen_bench = true} in
  let c_prog = GenC_standalone.gen_runtime prog prog conf "" in

  let bin_filename = Filename.temp_file "usuba-perf-bench" "" in
  let c_filename   = bin_filename ^ ".c" in
  let out          = open_out c_filename in

  Printf.fprintf out "%s\n\n%s" bench_code c_prog;
  close_out out;

  let compile_cmd = Printf.sprintf "clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize -I %s %s -o %s"
                                   Config.arch_dir c_filename bin_filename in
  ignore(Sys.command compile_cmd);

  bin_filename


(* Runs |bin|, reads its performance on its stdout, and returns it. *)
let get_perf (bin:string) : float =
  let in_chan = Unix.open_process_in bin in
  float_of_string (input_line in_chan)


(* Returns the performances of each program of |progs|. *)
let compare_perfs (progs:prog list) : float list =
  let binaries = List.map compile progs in

  let perfs = List.map (fun _ -> ref 0.) progs in

  for i = 1 to repeat do
    List.iter2 (fun bin perf -> perf := !perf +. (get_perf bin)) binaries perfs;
  done;

  List.map (!) perfs
