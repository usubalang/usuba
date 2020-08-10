Comparison of the performance of an Usuba-generated Pyjamask implementation and the reference speed-optimized implementation
===

## Performances

```
Usuba: 136.70   +-0.66
Ref  : 268.94   +-1.75  (x1.97)
```

## Correctness

The current benchmark does not check for correctness. However, the
Usubac compiler checks for the correctness of the Pyjamask cipher in
its continuous integration tests.

If you want to check to the codes running here are indeed correct, do
the following:

Add the line 
  
  ```c
  printf("%x %x %x %x\n", 
         plaintext__[0], plaintext__[1], plaintext__[2], plaintext__[3]);
  ```
  
to the file `pyjamask-ref.c` right after the call to `pyjamask_128()`. 
  
Add the line 

  ```c
  printf("%x %x %x %x\n", 
         ciphertext__[0], ciphertext__[1], ciphertext__[2], ciphertext__[3]);
  ```
  
to the file `pyjamask-ua.c` right after the call to `pyjamask__`.
  
Then compile those files using:

  ```
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 pyjamask-ref.c -o pyjamask-ref
  
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 pyjamask-ua.c -o pyjamask-ua
  ```

And then run them using:

  ```
  ./pyjamask-ref | head -n 1
  ./pyjamask-ua  | head -n 1
  ```

Both should output the same thing:

  ```
  0 0 ffffffff ffffffff
  ```

(which looks strange, but that's because we are using 0s as the key I
think)
