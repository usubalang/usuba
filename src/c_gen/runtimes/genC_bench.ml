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

/* auxiliary functions */
%s

/* main function */
%s

/* runtime */

#define BLOCK_SIZE %d
#define KEY_SIZE   %d

#ifndef NB_LOOP
#define NB_LOOP 16
#endif

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


  // Reading the input file
  FILE* fh_in = fopen(\"input.txt\",\"rb\");
  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  // Allocating various stuffs
  DATATYPE *plain_ortho  = ALLOC(REG_SIZE);
  DATATYPE *cipher_ortho = ALLOC(REG_SIZE);
  uint64_t *plain_std = ALLOC(size);

  // Storing the input file
  if (fread(plain_std,size,1,fh_in) != 1) {
     fprintf(stderr, \"Read error.\");
     exit(EXIT_FAILURE);
  }
  fclose(fh_in);

  clock_t timer = clock();
  for (int u = 0; u < NB_LOOP; u++) {
    for (int x = 0; x < size/8; x += CHUNK_SIZE) {
  
      uint64_t* loc_std = plain_std + x;
    
      for (int i = 0; i < CHUNK_SIZE; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);

      ORTHOGONALIZE(loc_std, plain_ortho);
    
      for (int i = 0; i < CHUNK_SIZE / REG_SIZE; i++) {

        memcpy(key_ortho,key_cst,KEY_SIZE*sizeof *key_cst);
        %s(&plain_ortho[i*BLOCK_SIZE], key_ortho, &cipher_ortho[i*BLOCK_SIZE]);

      }
    
      UNORTHOGONALIZE(cipher_ortho,loc_std);

      for (int i = 0; i < CHUNK_SIZE; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
    }
  }
  timer = clock() - timer;

  clock_t ortho_ck = clock();
  for (int u = 0; u < 16; u++)
    for (int x = 0; x < size/8; x += CHUNK_SIZE) {
      uint64_t* loc_std = plain_std + x;
      ORTHOGONALIZE(loc_std, plain_ortho);
      UNORTHOGONALIZE(plain_ortho,loc_std);
    }
  ortho_ck = clock() - ortho_ck;

  double speed = size*NB_LOOP/((double)timer/CLOCKS_PER_SEC)/1e6;
  double ortho_time = speed * ortho_ck / timer;
  printf(\"%%.2f %%.2f\\n\",speed,ortho_time);
  
  FILE* fh_out = fopen(\"output.txt\",\"wb\");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);

  return 0;
}"
  (if conf.archi = Std then conf.bit_per_reg else 64)
  (int_of_float (log(float_of_int (if conf.archi = Std then conf.bit_per_reg else 64)) /. log(2.0)))
  (if conf.ortho then "ORTHO" else "NO_ORTHO")
  (c_header conf.archi)
  (join "\n\n" prog_c)
  entry
  conf.block_size
  conf.key_size
  (rename List.(nth prog.nodes (length prog.nodes -1)).id.name)
