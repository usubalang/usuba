Bitslice addition benchmark
---

This small experiment compares a bitslice addition to a packed
addition on SSE registers. The bitslice addition is implemented an
adder circuit.

Run the experiment with `./run.pl`.

On my Intel Skylake i5-6500, the results are:

```
 8-bit addition:
   bitslice: 0.12  (+- 0.01)
     packed: 0.06  (+- 0.00)
16-bit addition:
   bitslice: 0.27  (+- 0.01)
     packed: 0.13  (+- 0.00)
32-bit addition:
   bitslice: 0.59  (+- 0.02)
     packed: 0.26  (+- 0.01)
```
