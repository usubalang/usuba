
The files `fdti.c` and `tifd.c` were generated using the following commands:

```
./usubac -fdti fdti -o experimentations/FDTI/fdti.c -bits-per-reg 32 -no-inlining -no-sched samples/usuba/half_adder.ua
./usubac -fdti tifd -o experimentations/FDTI/tifd.c -bits-per-reg 32 -no-inlining -no-sched samples/usuba/half_adder.ua
```

And then, the macro `L_ROTATE` was manually modified inside them:

```
#undef L_ROTATE
#define L_ROTATE(x,n,c) (x << 1) | ((x >> 2)&1)

```

And `_tmp9_` was manually set to `_tmp8_` inside the function `adder__` of `fdti.c`.
