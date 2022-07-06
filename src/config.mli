val data_dir : string
val arch_dir : string
val tightprove_cache : string
val sage : string
val tightprove : string

type arch = Std | MMX | SSE | AVX | AVX512 | Neon | AltiVec
type slicing = H | V | B

(* The compiler's configuration *)
type config = {
  output : string; (* Base output file *)
  warning_as_error : bool; (* Doesn't do anything... I think *)
  verbose : int;
  (* 5 = prints which passes are getting executed,
   * 100 = prints the Usuba program after each pass *)
  path : string list; (* Path to search for "include" directives *)
  type_check : bool; (* Enables type-checking *)
  check_tbl : bool; (* Enables verification of tables to circuit conversion *)
  auto_inline : bool; (* Lets Usuba chose which nodes to inline or not *)
  light_inline : bool; (* Inlines only nodes marked with _inline *)
  inline_all : bool; (* Inlines all nodes *)
  heavy_inline : bool; (* Inline every nodes except for _no_inline ones *)
  no_inline : bool; (* Disables all inlining *)
  compact_mono : bool; (* Enables compact monomorphization *)
  fold_const : bool; (* Enables constant folding *)
  cse : bool; (* Enables CSE *)
  copy_prop : bool; (* Enables Copy propagation *)
  loop_fusion : bool; (* Enables loop fusion *)
  pre_schedule : bool; (* Enables bistlice scheduling *)
  scheduling : bool; (* Enables mslice scheduling *)
  schedule_n : int; (* Look-behind window for mslice scheduling *)
  share_var : bool; (* Enables variable reuse *)
  linearize_arr : bool; (* Enables array linearization *)
  precal_tbl : bool; (* Enables the use of precomputed lookup tables *)
  archi : arch; (* Selects the architecture to target *)
  bits_per_reg : int; (* Number of bits per register *)
  no_arr : bool; (* Removes all arrays (except in parameters) *)
  arr_entry : bool; (* Removes arrays from parameters *)
  unroll : bool; (* Unrolls all loops *)
  interleave : int; (* Interleaving granularity *)
  inter_factor : int; (* Interleaving factor *)
  fdti : string; (* *)
  lazylift : bool; (* Enables lazy lifting *)
  slicing_set : bool;
      (* If true, it means a slicing direction is selected,
         and slicing_type (below) contains it *)
  slicing_type : slicing; (* Slicing direction *)
  m_set : bool;
      (* If true, it means a word size is selected,
         and m_val (below) contains it *)
  m_val : int; (* word size *)
  tightPROVE : bool; (* Enables tightPROVE masking verification *)
  tightprove_dir : string; (* Tightprove's output directory *)
  maskVerif : bool; (* Enables maskVerif code generation *)
  masked : bool; (* Enables masking by using special AND/OR/NOT/XOR macros *)
  ua_masked : bool;
      (* Enables masking within Usuba; only a custom
         AND macro is needed *)
  shares : int; (* Number of shares for masking *)
  gen_bench : bool; (* Generates a benchmarking function *)
  keep_tables : bool;
      (* Keeps tables as tables rather than converting
         them into circuits *)
  compact : bool;
  (* (broken) Generates loops when unfolding
     operators instead of a list of equations. *)
  (* Benchmarking flags (for automatic selection of best opti to use or not) *)
  bench_inline : bool; (* Inlining: inline_all vs auto_inline vs _no_inline *)
  bench_inter : bool; (* Interleaving: which factor? (0, 2, 3) *)
  bench_bitsched : bool; (* Bitslice schedule: yes or no *)
  bench_msched : bool; (* Mslice schedule: yes or no *)
  bench_sharevar : bool; (* Share var: yes or no *)
  dump_sexp : bool;
      (* Dump a s-expression corresponding to the compiled usuba program *)
}

val pp_config : Format.formatter -> config -> unit
