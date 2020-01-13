Bitslice addition benchmark
---

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
improvement of `packed` where 3 additions can be done in parallel.

The results seems reasonable, in particular since `packed`, which does
a single addition in a loop has a throughput of about 1 (which is the
theoretical maximum since there is a dependency between each
addition):

 - for 8-bit add, we are doing 16 additions at once, so 0.06*16 = 0.96
 
 - for 16-bit add, we are doing 8 additions at once, so 0.12*8 = 0.96
 
 - for 32-bit add, we are doing 4 additions at once, so 0.24*4 = 0.96
 
Furthermore, the `packed_par`, which has a maximum theoretical
throughput of 0.33 is close to that number:

 - for 8-bit add, we are doing 16 additions at once, so 0.03*16 = 0.43
 
 - for 16-bit add, we are doing 8 additions at once, so 0.05*8 = 0.4
 
 - for 32-bit add, we are doing 4 additions at once, so 0.11*4 = 0.44
 
If I were to guess, I'd say that there is a small overhead because of
the loop. The initial loop contains 3 independent additions (and
should thus execute in one cycle). It is unrolled 5 times by
Clang. Thus, I'd expect a penalty cycle (or two?) every 5 cycles, or a
20% slowdown. 0.33 * 1.2 = 0.396; pretty close to our 0.4ish.
 

Finally, regarding the bitslice addition, I don't have much to
say. Given that the performances of the two other codes are
reasonable, I would trust the numbers we have for this addition.
