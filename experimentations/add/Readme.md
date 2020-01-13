Bitslice addition benchmark
---

**TD;DR: bitslice is between 2 and 5 times slower than packed addition.**

This small experiment compares a bitslice addition to a packed
addition on SSE registers. The bitslice addition is implemented an
adder circuit.

Run the experiment with `./run.pl`.

On my Intel Skylake i5-6500, with Clang 7.0.0, the results are (in
cycle/add):

```
 8-bit addition:
    bitslice: 0.11  (+- 0.00)
      packed: 0.06  (+- 0.00)
  packed_par: 0.03  (+- 0.00)
16-bit addition:
    bitslice: 0.25  (+- 0.00)
      packed: 0.12  (+- 0.00)
  packed_par: 0.05  (+- 0.00)
32-bit addition:
    bitslice: 0.55  (+- 0.00)
      packed: 0.24  (+- 0.00)
  packed_par: 0.11  (+- 0.00)
```

Where `bitslice` is the sofware implemented carry-ripple adder,
`packed` is native SSE packed addition, and `packed_par` is an
improvement of `packed` where 3 additions can be done in
parallel. Note that the costs are _per addition_: the packed and
packed_par versions do 4/8/16 additions in parallel, meaning that you
need to multiply the numbers above by 4/8/16 to get the time it took
to execute (ie, the latency). The bitslice version does 128 additions
in parallel, you therefore need to multiply the bitslice result by 128
to get the latency.

## Results

### Overall

Implementing an adder in software (carry-ripple adder to be precise)
is twice slower than using packed SIMD addition instructions when the
latter can be parallelized, and 5 times slower when the SIMD additions
can be parallelized.

For each experiment (packed, packed parallel, and bitsliced), a small
discussion follows, explaining why I beleive the results to be
(mostly) correct.

### packed addition

`packed` does a single addition in a loop, with a dependency between
each iteration. The maximal theoretical throughput is therefore
of 1. In practice, we get numbers that are pretty close:

 - for 8-bit add, 0.06*16 = 0.96
 
 - for 16-bit add, 0.12*8 = 0.96
 
 - for 32-bit add, 0.24*4 = 0.96

It's a bit weird that the numbers are below 1.

### parallel packed addition

The `packed_par` version does 3 independent addition per loop, and
therefore has a maximum theoretical throughput of 0.33. Its
experimental throughput is close to that number:

 - for 8-bit add, we are doing 16 additions at once, so 0.03*16 = 0.43
 
 - for 16-bit add, we are doing 8 additions at once, so 0.05*8 = 0.4
 
 - for 32-bit add, we are doing 4 additions at once, so 0.11*4 = 0.44
 
If I were to guess, I'd say that there is a small overhead because of
the loop itself. The initial loop contains 3 independent additions
(and should thus execute in one cycle). It is unrolled 5 times by
Clang. Thus, I'd expect penalty of one (or two?) cycle every 5 cycles,
or a 20% (to 40%) slowdown. 0.33 * 1.2 = 0.396; pretty close to our
0.4ish.
 
### bitslice addition

For an addition _n_-bits, the bitslice adder contains _n_ adders, each
of them doing 5 bitwise operations. Since about 3 operations can be
done every cycles, the expected performances are _n * 5/3_ cycles for
each _n_-bit addition. We get the following numbers experimentally
(the "128 * " come from the fact that we are doing 128 additions in
parallel):

 - 8-bit, 128 * 0.11 = 14.1 cycles/adder, vs expected = 8 * 5/3 = 13.3
 
 - 16-bit, 128 * 0.25 = 32 cycles/adder, vs expected = 16 * 5/3 = 26.5
 
 - 32-bit, 128 * 0.55 = 70 cycles/adder, vs expected = 32 * 5/3 = 53.3
 
For the 8-bit adder, it's fairly close to what we expect. A slight
overhead comming from a bit of spilling and maybe some dependencies
between the full adders.

The 16 and 32-bit adders are respectively about 17% and 23% slower
than expected. I am fairly confident that this comes from the
spilling: about half of their assembly instructions are `move`.




## TODO

 - run `perf`.

 - run `iaca` or `llvm-mca`.

 - force more unrolling for the `packed-par` version, and see if the
   throughput increases.
