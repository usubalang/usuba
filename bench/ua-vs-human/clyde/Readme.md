Comparison of the performance of an Usuba-generated Clyde implementation and the reference speed-optimized implementation
===

## Performances


## Correctness

The current benchmark does not check for correctness. However, the
Usubac compiler checks for the correctness of the Clyde cipher in its
continuous integration tests.

If you want to check to the codes running here are indeed correct, do
the following:

Add the line 
  
  ```c
  printf("%016lx %016lx\n", state__[0], state__[1]);
  ```
  
to the file `clyde-ref.c` right after the call to `clyde128_encrypt()`. 
  
Add the line 

  ```c
  printf("%016lx %016lx\n", cipher__[0], cipher__[1]);
  ```
  
to the file `clyde-ua.c` right after the call to `clyde128__`.
  
Then compile those files using:

  ```
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 clyde-ref.c -o clyde-ref
  
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 clyde-ua.c -o clyde-ua
  ```

And then run them using:

  ```
  ./clyde-ref | head -n 1
  ./clyde-ua  | head -n 1
  ```

Both should output the same thing:

  ```
  3abaaaaa85495d31 694e1f1d60b0ea23
  ```
