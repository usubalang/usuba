open Usuba_AST
open Nodes_to_c
open Utils
       

(* Note: this isn't a general function, but it will do for now *)       
let gen_runtime (orig:prog) (prog:prog) (conf:config) : string =
  
  let entry = List.(def_to_c (nth orig.nodes (length orig.nodes -1))
                             (nth prog.nodes (length prog.nodes -1))
                             true) in
  let prog_c = map_no_end (fun x -> def_to_c x x false) prog.nodes in

Printf.sprintf 
"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* defining \"BENCH\" or \"STD\" */
/* (will impact the .h functions loaded by the .h) */
#define BENCH
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

int main() {

  // Hardcoding a key for now...
  unsigned long key_std = 0x133457799BBCDFF1;
  DATATYPE *key_ortho = ALLOC(KEY_SIZE);

  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = SET_ALL_ONE();
    else
      key_ortho[63-i] = SET_ALL_ZERO();


  // Reading the input file
  FILE* fh_in = fopen(\"input.txt\",\"rb\");
  fseek(fh_in,0,SEEK_END);
  long size = ftell(fh_in);
  rewind(fh_in);
  
  // Allocating various stuffs
  DATATYPE *plain_ortho  = ALLOC(BLOCK_SIZE);
  DATATYPE *cipher_ortho = ALLOC(BLOCK_SIZE);
  unsigned long *plain_std = ALLOC(size);

  // Storing the input file
  fread(plain_std,size,1,fh_in);
  fclose(fh_in);

  clock_t timer = clock();
  for (int u = 0; u < 16; u++) {
    for (int x = 0; x < size/8; x += REG_SIZE) {
  
      unsigned long* loc_std = plain_std + x;
    
      for (int i = 0; i < REG_SIZE; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);

      ORTHOGONALIZE(loc_std, plain_ortho);
    
      %s(plain_ortho, key_ortho, cipher_ortho);
    
      UNORTHOGONALIZE(cipher_ortho,loc_std);
    
      for (int i = 0; i < REG_SIZE; i++)
        loc_std[i] = __builtin_bswap64(loc_std[i]);
    }
  }
  printf(\"%%f\\n\",((double)clock()-timer)/CLOCKS_PER_SEC);
  
  FILE* fh_out = fopen(\"output.txt\",\"wb\");
  fwrite(plain_std,size,1,fh_out);
  fclose(fh_out);

  return 0;
}"
  (if conf.ortho then "ORTHO" else "NO_ORTHO")
  (c_header conf.archi)
  (join "\n\n" prog_c)
  entry
  conf.block_size
  conf.key_size
  (rename List.(nth prog.nodes (length prog.nodes -1)).id)
