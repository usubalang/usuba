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
#include <omp.h>
#include <inttypes.h>
#include <stdint.h>

/* Do NOT change the order of those define/include */

/* defining \"BENCH\" or \"STD\" */
/* (will impact the .h functions loaded by the .h) */
#define BENCH
/* BITS_PER_REG, only defined for STD */
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

#ifndef NB_LOOPS
#define NB_LOOPS 1500 /* 1500 is calibrated for a 80 cores machine */
#endif

#define BLOCK_SIZE %d
#define KEY_SIZE   %d

/* This function comes from:
   https://gist.github.com/diabloneo/9619917 */
void timespec_diff(struct timespec *start, struct timespec *stop,
                   struct timespec *result)
{
    if ((stop->tv_nsec - start->tv_nsec) < 0) {
        result->tv_sec = stop->tv_sec - start->tv_sec - 1;
        result->tv_nsec = stop->tv_nsec - start->tv_nsec + 1000000000;
    } else {
        result->tv_sec = stop->tv_sec - start->tv_sec;
        result->tv_nsec = stop->tv_nsec - start->tv_nsec;
    }

    return;
}

void single_%s (uint64_t *buff_in, uint64_t* buff_out,
                 DATATYPE *key_in, uint64_t size) {
  DATATYPE plain_ortho[BLOCK_SIZE];
  DATATYPE cipher_ortho[BLOCK_SIZE];
  DATATYPE key_ortho[KEY_SIZE];
  memcpy(key_ortho,key_in,KEY_SIZE*sizeof(DATATYPE));

  int id = omp_get_thread_num();
  
  for (int a = 0; a < NB_LOOPS; a++)
  for (int i = 0; i < size; i += REG_SIZE) {
    uint64_t* plain_std  = &(buff_in[size*id+i]);
    uint64_t* cipher_std = &(buff_out[size*id+i]);
    
    for (int i = 0; i < REG_SIZE; i++)
      plain_std[i] = __builtin_bswap64(plain_std[i]);

    orthogonalize(plain_std, plain_ortho);

    %s(plain_ortho, key_ortho, cipher_ortho);

    unorthogonalize(cipher_ortho,cipher_std);
    
    for (int i = 0; i < REG_SIZE; i++)
      cipher_std[i] = __builtin_bswap64(cipher_std[i]);
  }
}

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
  
  uint64_t* buff_in  = ALLOC(size);
  uint64_t* buff_out = ALLOC(size);

  // Storing the input file
  if (fread(buff_in,size,1,fh_in) != 1) {
     fprintf(stderr, \"Read error.\");
     exit(EXIT_FAILURE);
  }
  fclose(fh_in);

  for (int i = 1; i <= %d; i += (1 < 10 ? 1 : 5)) {
    struct timespec ini;
    clock_gettime(CLOCK_MONOTONIC,&ini);
    #pragma omp parallel num_threads(i)
    {
      single_%s(buff_in,buff_out,key_ortho,size/i/sizeof(uint64_t));
    }
    struct timespec end;
    clock_gettime(CLOCK_MONOTONIC,&end);
    struct timespec res;
    timespec_diff(&ini,&end,&res);

    printf(\"%%2d : %%ld.%%ld\\n\",i,res.tv_sec,res.tv_nsec);
  }  

  FILE* fh_out = fopen(\"output.txt\",\"wb\");
  fwrite(buff_out,size,1,fh_out);
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
  (rename List.(nth prog.nodes (length prog.nodes -1)).id.name)
  conf.openmp
  (rename List.(nth prog.nodes (length prog.nodes -1)).id.name)
