Comparison of the performance of an Usuba-generated Gift implementation and the reference implementation
===

## Performances



## Correctness

The current benchmark does not check for correctness. However, the
Usubac compiler checks for the correctness of the Gift cipher in its
continuous integration tests.

If you want to check to the codes running here are indeed correct, do
the following:

Add the line 
  
  ```c
  printf("%08x %08x %08x %08x\n", P__[0], P__[1], P__[2], P__[3]);
  ```
  
to the file `gift-ref.c` right after the call to `giftb128()`. 
  
Add the line 

  ```c
  printf("%08x %08x %08x %08x\n", C__[0], C__[1], C__[2], C__[3]);
  ```
  
to the file `gift-ua.c` right after the call to `gift__`.
  
Then compile those files using:

  ```
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 gift-ref.c -o gift-ref
  
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 gift-ua.c -o gift-ua
  ```

And then run them using:

  ```
  ./gift-ref | head -n 1
  ./gift-ua  | head -n 1
  ```

Both should output the same thing:

  ```
  5e8e3a2e 1697a77d cc0b89dc d97a64ee
  ```
