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
#define STD
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
  DATATYPE *key_cst   = ALLOC(KEY_SIZE);

  for (int i = 0; i < 64; i++)
    if (key_std >> i & 1)
      key_ortho[63-i] = key_cst[63-i] = SET_ALL_ONE();
    else
      key_ortho[63-i] = key_cst[63-i] = SET_ALL_ZERO();


  // Reading the input file
  FILE* fh_in = fopen(\"input.txt\",\"rb\");
  FILE* fh_out = fopen(\"output.txt\",\"wb\");
  
  // Allocating various stuffs
  DATATYPE *plain_ortho  = ALLOC(BLOCK_SIZE);
  DATATYPE *cipher_ortho = ALLOC(BLOCK_SIZE);
  unsigned long *plain_std = ALLOC(REG_SIZE);


  while(fread(plain_std, 8, REG_SIZE, fh_in)) {

    for (int i = 0; i < REG_SIZE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    ORTHOGONALIZE(plain_std, plain_ortho);
    
    memcpy(key_ortho,key_cst,KEY_SIZE*sizeof *key_cst);
    %s(plain_ortho, key_ortho, cipher_ortho);
    
    UNORTHOGONALIZE(cipher_ortho,plain_std);
    
    for (int i = 0; i < REG_SIZE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    fwrite(plain_std, 8, REG_SIZE, fh_out);
  }

  fclose(fh_in);
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
