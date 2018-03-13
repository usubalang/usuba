open Usuba_AST
open Nodes_to_c
open Utils
       

(* Note: this isn't a general function, but it will do for now *)       
let gen_runtime (orig:prog) (prog:prog) (conf:config) : string =
  
  let entry = List.(def_to_c (nth orig.nodes (length orig.nodes -1))
                             (nth prog.nodes (length prog.nodes -1))
                             true conf) in
  let prog_c = map_no_end (fun x -> def_to_c x x false conf) prog.nodes in

Printf.sprintf 
"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdint.h>

/* Do NOT change the order of those define/include */

/* defining \"BENCH\" or \"STD\" */
/* (will impact the .h functions loaded by the .h) */
#define BENCH
#define BITS_PER_REG %d
#define LOG2_BITS_PER_REG %d
/* defining \"ORTHO\" or not */
#define %s
/* including the architecture specific .h */
#include \"%s\"


#ifndef INIT_RAND
#define INIT_RAND 5
#endif
uint64_t rand_ulong() {
  static uint64_t state = INIT_RAND;
  return state = state * 6364136223846793005 + 1442695040888963407;
}

/* auxiliary functions */
%s

/* main function */
%s

/* runtime */

#define BLOCK_SIZE %d
#define KEY_SIZE   %d

#define INPUT_SIZE 3E8

int main() {

  // Hardcoding a key for now...
  uint64_t key_std = 0x133457799BBCDFF1;
  DATATYPE *key_ortho = ALLOC(KEY_SIZE);
  DATATYPE *key_cst   = ALLOC(KEY_SIZE);

  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = key_cst[63-i] = SET_ALL_ONE();
    else
      key_ortho[63-i] = key_cst[63-i] = SET_ALL_ZERO();
  
  // Allocating various stuffs
  DATATYPE *plain_ortho  = ALLOC(BLOCK_SIZE);
  DATATYPE *cipher_ortho = ALLOC(BLOCK_SIZE);
  uint64_t *plain_std = ALLOC(REG_SIZE);
  for (int i = 0; i < REG_SIZE; i++) plain_std[i] = rand_ulong();

  clock_t timer = clock();
  clock_t ortho_ck = 0;
  for (int u = 0; u < INPUT_SIZE / (REG_SIZE * BLOCK_SIZE); u++) {

    for (int i = 0; i < REG_SIZE; i++) plain_std[i] ^= rand_ulong();

    ortho_ck -= clock();
    ORTHOGONALIZE(plain_std, plain_ortho);
    ortho_ck += clock();
    
    memcpy(key_ortho,key_cst,KEY_SIZE*sizeof *key_cst);
    %s(plain_ortho, key_ortho, cipher_ortho);

    ortho_ck -= clock();
    UNORTHOGONALIZE(cipher_ortho,plain_std);
    ortho_ck += clock(); 

  }
  timer = clock() - timer;
  double speed = INPUT_SIZE / (((double)clock()-timer)/CLOCKS_PER_SEC) / 1e6 / 8;
  double ortho_time = speed * ortho_ck / timer;
  printf(\"%%.2f %%.2f\\n\",speed,ortho_time);
  
  return 0;
}"
  (if conf.archi = Std then conf.bits_per_reg else 64)
  (int_of_float (log(float_of_int (if conf.archi = Std then conf.bits_per_reg else 64)) /. log(2.0)))
  (if conf.ortho then "ORTHO" else "NO_ORTHO")
  (c_header conf.archi)
  (join "\n\n" prog_c)
  entry
  conf.block_size
  conf.key_size
  (rename List.(nth prog.nodes (length prog.nodes -1)).id.name)
