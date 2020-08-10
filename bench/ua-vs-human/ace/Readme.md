Comparison of the performance of an Usuba-generated Ace implementation and the reference speed-optimized implementation
===

## Performances

```
Arch: sse
Usuba: 10.35   +-0.05
Ref  : 18.06   +-0.11  (x1.75)

Usuba no unrolling: 12.60   +-0.08  (x1.22)


********************************************************************************

Arch: avx
Usuba: 4.55   +-0.02
Ref  : 9.24   +-0.03  (x2.03)

Usuba no unrolling: 6.90   +-0.05  (x1.52)


********************************************************************************

Arch: sse2
Usuba: 10.28   +-0.07
Ref  : 18.23   +-0.05  (x1.77)

Usuba no unrolling: 12.59   +-0.03  (x1.23)
```

## Correctness

The current benchmark does not check for correctness. However, the
Usubac compiler checks for the correctness of the AsconAce cipher in its
continuous integration tests.

If you want to check to the codes running here are indeed correct, do
the following:

Add the line 
  
  ```c
  for (int i = 0; i < 5; i++) {
    uint64_t* buff = (uint64_t*)(&output__[i]);
    printf("%lx %lx %lx %lx\n", buff[0], buff[1], buff[2], buff[3]);
  }
  ```
  
to the file `ace-ua-sse.c` right after the call to `ACE__()`. 
  
Add the line 

  ```c
  for (int i = 0; i < 5; i++) {
    uint64_t* buff = (uint64_t*)(&input__[i*2]);
    printf("%lx %lx %lx %lx\n", buff[0], buff[1], buff[2], buff[3]);
  }
  ```
  
to the file `ref-sse/ace.c` right after the call to `ace__`.
  
Then compile those files using:

  ```
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 ref-sse/ace.c -o ace-ref
  
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 ace-ua-sse.c -o ace-ua-sse
  ```

And then run them using:

  ```
  ./ace-ref | head -n 1
  ./ace-ua  | head -n 1
  ```

Both should output the same thing:

  ```
  5c93691a5c93691a 5c93691a5c93691a d5060935d5060935 d5060935d5060935
  dc19ce94dc19ce94 dc19ce94dc19ce94 7ead550d7ead550d 7ead550d7ead550d
  ac12bee1ac12bee1 ac12bee1ac12bee1 a64b670ea64b670e a64b670ea64b670e
  f516e8bef516e8be f516e8bef516e8be 1dfa60da1dfa60da 1dfa60da1dfa60da
  409892a4409892a4 409892a4409892a4 e4ccbc15e4ccbc15 e4ccbc15e4ccbc15
  ```
