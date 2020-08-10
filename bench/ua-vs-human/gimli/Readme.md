Comparison of the performance of an Usuba-generated Gimli implementation and the reference speed-optimized implementations
===

## Performances

## Correctness

The current benchmark does not check for correctness. However, the
Usubac compiler checks for the correctness of the Pyjamask cipher in
its continuous integration tests.

If you want to check to the codes running here are indeed correct, do
the following:

Add the lines
  
  ```c
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      printf("%08x ", state[i*4+j]);
    }
    printf("\n");
  }
  ```
  
to the file `gimli-ref-sse.c` right after the call to `gimli()`. 
  
Add the lines

  ```c
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 4; j++) {
      uint32_t *tmp = (uint32_t*) &stateR__[i][j];
      printf("%08x ", tmp[0]);
    }
    printf("\n");
  }
  ```
  
to the file `gimli-ua-sse.c` right after the call to `gimli__`.
  
Then compile those files using:

  ```
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 gimli-ref-sse.c -o gimli-ref-sse
  
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 gimli-ua-sse.c -o gimli-ua-sse
  ```

And then run them using:

  ```
  ./gimli-ref | head -n 3
  ./gimli-ua  | head -n 3
  ```

Both should output the same thing:

  ```
  6467d8c4 07dcf83b 3b0bb0d4 1b21364c 
  083431dc 0efbbe8e 0054e884 648bd955 
  4a5db42e ca0641cb 8673d2c2 2e30d809
  ```
