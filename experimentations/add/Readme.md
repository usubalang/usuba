Bitslice addition benchmark
---

**TD;DR: bitslice is between 2 and 5 times slower than packed addition.**

This small experiment compares a bitslice addition to a packed
addition on SSE registers. The bitslice addition is implemented an
adder circuit.

Run the experiment with `./run.pl`.

On my Intel Skylake i5-6500, with Clang 7.0.0, the results are:

|    **addition type**   |  **cycles/loop** |  **cycles/add** |
| ---------------------- | ---------------- | --------------- |
|  8-bit        bitslice |  14.79 (+- 0.03) |  0.12 (+- 0.00) |
|  8-bit   packed_single |   1.00 (+- 0.00) |  0.06 (+- 0.00) |
|  8-bit packed_parallel |   1.00 (+- 0.00) |  0.02 (+- 0.00) |
| 16-bit        bitslice |  33.32 (+- 0.07) |  0.26 (+- 0.00) |
| 16-bit   packed_single |   1.00 (+- 0.00) |  0.13 (+- 0.00) |
| 16-bit packed_parallel |   1.00 (+- 0.00) |  0.04 (+- 0.00) |
| 32-bit        bitslice |  74.62 (+- 0.08) |  0.58 (+- 0.00) |
| 32-bit   packed_single |   1.00 (+- 0.00) |  0.25 (+- 0.00) |
| 32-bit packed_parallel |   1.00 (+- 0.00) |  0.08 (+- 0.00) |


Where `bitslice` is the sofware implemented carry-ripple adder,
`packed_single` is native SSE packed addition, and `packed_parallel`
is an improvement of `packed_single` where 3 additions can be done in
parallel. Each version does some number of additions in parallel _per
addition_: the packed_single and packed_parallel versions do 4/8/16
additions in parallel, and the bitslice version always does 128
additions in parallel. The cycles/add are therefore simply the
cycles/loop divided by the number of parallel additions.


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

`packed_single` does a single addition in a loop, with a dependency
between each iteration. The loop therefore contains 3 instructions: an
SSE add, an increment, and a conditional jump. This 3 instructions
should be doable in a single cycle, and this is what we observe.

### parallel packed addition

The `packed_parallel` version does 3 independent addition per loop,
and therefore has a maximum theoretical throughput of 0.33. This is
what we get; as expected. Can't get any better.

**Fun fact**: at some point I force some unrolling by Clang (I don't
remember why but my performances were not as expected, and I thought
more unrolling would help). Turns out it harms performances. TODO: add
more explanations.


### bitslice addition

For an addition _n_-bits, the bitslice adder contains _n_ adders, each
of them doing 5 bitwise operations. Since about 3 operations can be
done every cycles, the expected performances are _n * 5/3_ cycles for
each _n_-bit addition. We get the following numbers experimentally:

 - 8-bit, expected: 8 * 5/3 = 13.3; got: 15.02
 
 - 16-bit, expected: 16 * 5/3 = 26.5; got: 33.34
 
 - 32-bit, expected: 32 * 5/3 = 53.3; got: 74.64
 
For the 8-bit adder, it's fairly close to what we expect. A slight
overhead comming from a bit of spilling and maybe some dependencies
between the full adders.

The 16 and 32-bit adders are respectively about 17% and 23% slower
than expected. I am fairly confident that this comes from the
spilling: about half of their assembly instructions are `move`.



## TODO

 - run `perf`
 
 - run `vtune`

 - run `iaca` or `llvm-mca`
