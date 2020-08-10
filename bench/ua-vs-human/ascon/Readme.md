Comparison of the performance of an Usuba-generated Ascon implementation and the reference speed-optimized implementation
===

## Performances

```
Usuba: 3.73   +-0.05
Ref  : 4.96   +-0.07  (x1.33)

Usuba no inter: 4.22   +-0.07  (x1.13)
Usuba no sched: 4.65   +-0.08  (x1.25)
```

## Correctness

The current benchmark does not check for correctness. However, the
Usubac compiler checks for the correctness of the Ascon cipher in its
continuous integration tests.

If you want to check to the codes running here are indeed correct, do
the following:

Add the line 
  
  ```c
  printf("%16lx %16lx %16lx %16lx %16lx\n",
         s.x0, s.x1, s.x2, s.x3, s.x4);
  ```
  
to the file `ascon-ref.c` right after the call to `P12()`. 
  
Add the line 

  ```c
  printf("%16lx %16lx %16lx %16lx %16lx\n",
         output__[0], output__[1], output__[2],
         output__[3], output__[4]);
  ```
  
to the file `ascon-ua.c` right after the call to `ascon12__`.
  
Then compile those files using:

  ```
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 ascon-ref.c -o ascon-ref
  
  clang -O3 -march=native -fno-tree-vectorize -fno-slp-vectorize ../../../experimentations/bench_generic/bench.c -I ../../../arch -D WARMUP=10000 -D NB_RUN=1000000 ascon-ua.c -o ascon-ua
  ```

And then run them using:

  ```
  ./ascon-ref | head -n 1
  ./ascon-ua  | head -n 1
  ```

Both should output the same thing:

  ```
  78ea7ae5cfebb108 9b9bfb8513b560f7 6937f83e03d11a50 3fe53f36f2c1178c  45d648e4def12c9
  ```
