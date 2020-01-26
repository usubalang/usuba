Unrolling a 1-cycle loop reduces performances by 25% on Skylake
===

## Background

(related to [this stackoverflow question](https://stackoverflow.com/q/59883527/4990392))

I Started from the following C code:

```c
for (int i = 0; i < 2000000000; i++) {
    a += d;
    b += d;
    c += d;
}
```

This loop should take 1 cycle/iteration to execute: it does 3
"visible" additions, plus 1 additional addition to increment the
counter and 1 jump. Since the increment and the jump fuses together,
this loop should execute in 1 cycles, using ports 0, 1, 5 and 6 of the
CPU. Benchmarking this code shows such performances.

However, when unrolling this loop, performances are rather surprising:
usually, often 25% slower than expected. Furthermore, observing
performance counters shows surprising numbers: in some cases, uops
come from the MITE (legacy pipelined), and in other cases from the DSB
(uops cache). Macro fusion between the increment and the loop doesn't
happen always (and doesn't always benefits performances)..

Note that I'm benchmarking this on a Skylake with the LSD (Loop Stream
Detector) disabled (it was disabled by Intel due to a bug with
hyperthreading).

## Experimenting with the twice unrolled loop

I focused on the twice unrolled loop (just to start somewhere). The
assembly code I'm using is available in [add.s](add.s), and the loop
part is the following:

```asm
	movl	$2000000000, %esi
	.p2align	7, 0x90
.LBB0_1:
	addl	%edi, %edx
	addl	%edi, %ecx
	addl	%edi, %eax
    addl	%edi, %edx
	addl	%edi, %ecx
	addl	%edi, %eax
	addq	$-2, %rsi
	jne	.LBB0_1
```


This codes runs in about 2.5 cycles/iteration. However, aligning the
loop on 16 bytes rather than 128 (using `.p2align 4` instead of
`.p2align 7`) makes it run in 2 cycles/iterations. It's rather
surprising since a code aligned on 128 bytes _is_ aligned on 16 bytes
as well...

Furthermore, the code that runs in 2 cycles/iterations uses 8 uops per
iteration, which means that the jump and increment didn't fuse,
whereas the code that runs in 2.45 cycles/iteration uses 7 uops per
iteration, which means that fusion occured.

Starting from the code above, aligned on 128 bytes, I added 1 to 128
bytes of padding before the loop (using `nop`s) and ran `perf` to
measure mainly 3 metrics:

  - number of cycles
  
  - number of uops delivered by the MITE (legacy pipeline)
  
  - number of uops delivered by the DSB (uop cache)

You can inspect [run.pl](run.pl) that was used to run those tests, and
find the detailed results in [results.md](results.md).

Here are the "rules" guiding how the program behaves:

 - 1) The "usual" case is: 2.45 cycles/iteration, with a total of
   around 7 uops/iteration, all issued by the DSB. 7 uops per
   iteration means that fusion between the increment and the jump
   occured.

 - 2) Optimal performances (2 cycles/iteration) are achieved when
   there are 48 and 112 bytes of padding before the loop. In those
   cases, 8 uops are issued by the DSB per iteration, which means that
   fusion did _not_ occur. Since the jump instruction is 16 bytes
   after the start of the loop, the 48 and 112 bytes of padding mean
   that the jump instruction was aligned on 64 bytes.
   
 - 3) When the jump instruction is aligned on 32 bytes - 2 to 32
   bytes + 3 (and the previous bullet doesn't apply), the loop
   executes in 3 cycles/iteration. All uops (7/iteration) are issued
   by the MITE. If the jump is also aligned on 64 bytes - 1, there are
   2 DSB miss per iteration, otherwise, there is 1 DSB miss per
   iteration. There are 2 special cases with the rule:
   
   - 3.a) When the jump instruction is aligned on 32 bytes - 1, the
     loop executes in 4 cycles/iteration rather than 3.
     
   - 3.b) When the jump instruction is aligned on 32 bytes - 2, there
     are always 1 DSB miss per iteration (never 2).
   

Rule 2\ explains why aligning the loop on 16 bytes might be better
than aligning it on 32, 64 or 128: the jump _must_ be aligned on 64
bytes for the loop to execute in 2 cycles/iteration. This cannot
happen when the start of the loop is aligned on 32, 64 or 128 bytes
(since for instance, when the start is aligned on 32 bytes, the jump
is aligned on 32+16=48 bytes). On the other hand, if we get lucky, it
can happen when the start of the loop is aligned on 16
bytes. Inspecting (with `objdump -d`) the binary of the code twice
unrolled aligned on 16 bytes mentionned earlier (and which runs at 2
cycles/iteration) shows:

```
  [address] [encoded instruction]   [assembly instruction]
  4004b0:	01 fa                	add    %edi,%edx
  4004b2:	01 f9                	add    %edi,%ecx
  4004b4:	01 f8                	add    %edi,%eax
  4004b6:	01 fa                	add    %edi,%edx
  4004b8:	01 f9                	add    %edi,%ecx
  4004ba:	01 f8                	add    %edi,%eax
  4004bc:	48 83 c6 fe          	add    $0xfffffffffffffffe,%rsi
  4004c0:	75 ee                	jne    4004b0 <main+0x10>
```

The jump is at address `4004c0`, which is a multiple of 64, as
expected.



## TODO

 - Try to explain why fusion does or doesn't happen

 - MITE vs DSB, try to explain origin?
 
 - Example: 5-time unrolled code: p2align 4 = DSB; p2align 5 = MITE
