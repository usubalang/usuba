Comparison of the performance of an Usuba-generated Xoodoo implementation and the reference implementation
===

## Performances


## Correctness

The current benchmark does not check for correctness. However, the
Usubac compiler checks for the correctness of the Pyjamask cipher in
its continuous integration tests.

If you want to check to the codes running here are indeed correct, do
the following:

Add the line 
  
  ```c
  for (int i = 0; i < 3; i++) {
    printf("%08x %08x %08x %08x\n",
           input__[i*4], input__[i*4+1], input__[i*4+2], input__[i*4+3]);
  }
  ```
  
to the file `xoodoo-ref.c` right after the call to `Xoodoo_Permute_12rounds()`. 
  
Add the line 

  ```c
  for (int i = 0; i < 3; i++) {
    printf("%08x %08x %08x %08x\n",
           output__[i][0], output__[i][1], output__[i][2], output__[i][3]);
  }
  ```
  
to the file `xoodoo-ua.c` right after the call to `xoodoo__`.
  
Then compile those files using:

  ```
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 xoodoo-ref.c -o xoodoo-ref
  
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 xoodoo-ua.c -o xoodoo-ua
  ```

And then run them using:

  ```
  ./xoodoo-ref | head -n 1
  ./xoodoo-ua  | head -n 1
  ```

Both should output the same thing:

  ```
  89d5d88d a963fcbf 1b232d19 ffa5a014
  36b18106 afc7c1fe aee57cbe a77540bd
  2e86e870 fef5b7c9 8b4fadf2 5e4f4062
  ```
