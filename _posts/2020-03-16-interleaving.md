---
layout: post
title: Interleaving
date: "2020-03-16 00:00:00"
description: Usubac's interleaving optimization
lang: en
locale: en_US
author: Darius Mercadier
excerpt: A first optimization in Usubac consists in interleaving several executions of the program. For a cipher using a small number of registers (for example, strictly below 8 general-purpose registers on Intel), we can increase its instruction-level parallelism (ILP) by interleaving several copies of a single cipher, each manipulating its own independent set of variables.
comments: true
hidden: false
---

The back-end exclusively manipulates Usuba0 code, taking advantage of
referential transparency (any variable `x` in an expression can be
replaced by its definition) as well as the fact that we are dealing
with a non Turing-complete language (our programs are thus very
static). Optimizations carried out at this level are easier to write
but also more precise. The back-end is complementary with the
optimizations offered by C compilers. There is a significant semantic
gap between the user intents expressed in Usuba and their
straightforward sliced translations in C. This results in missed
optimization opportunities for the C compiler, of which we shall study
a few examples in the following. The back-end authoritatively performs
these optimizations at the level of Usuba0.


A first optimization consists in interleaving several executions of
the program. Usuba allows us to systematize this folklore programming
trick, popularized by Matsui [1]: for a cipher using a small number of
registers (for example, strictly below 8 general-purpose registers on
Intel), we can increase its instruction-level parallelism (ILP) by
interleaving several copies of a single cipher, each manipulating its
own independent set of variables. 

This can be understood as a static form of hyper-threading, by which
we (statically) interleave the instruction stream of several parallel
execution of a single cipher. By increasing ILP, we reduce the impact
of data hazards in the deeply pipelined CPU architecture we are
targeting. Note that this technique is orthogonal from slicing (which
exploits spatial parallelism, in the registers) by exploiting temporal
parallelism, _i.e._ the fact that a modern CPU can dispatch multiple,
independent instructions to its parallel execution units. This
technique naturally fits within our parallel programming framework: we
can implement it by a straightforward Usuba0-to-Usuba0 translation.


### Example

Rectangle's S-box for instance can be written in C using the following
macro:

<div class="language-c highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="kt">#define</span> <span class="nf">sbox_circuit</span><span class="p">(</span><span class="n">a0</span><span class="p">,</span><span class="n">a1</span><span class="p">,</span><span class="n">a2</span><span class="p">,</span><span class="n">a3</span><span class="p">)</span> <span class="p">{</span>                 \
  <span class="kt">int</span> <span class="n">t0</span><span class="p">,</span> <span class="n">t1</span><span class="p">,</span> <span class="n">t2</span><span class="p">;</span>                               \
  <span class="n">t0</span> <span class="o">=</span> <span class="o">~</span><span class="n">a1</span><span class="p">;</span>                                     \
  <span class="n">t1</span> <span class="o">=</span> <span class="n">a2</span> <span class="o">^</span> <span class="n">a3</span><span class="p">;</span>                                 \
  <span class="n">t2</span> <span class="o">=</span> <span class="n">a3</span> <span class="o">|</span> <span class="n">t0</span><span class="p">;</span>                                 \
  <span class="n">t2</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">^</span> <span class="n">t2</span><span class="p">;</span>                                 \
  <span class="n">a0</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">&amp;</span> <span class="n">t0</span><span class="p">;</span>                                 \
  <span class="n">a0</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">^</span> <span class="n">t1</span><span class="p">;</span>                                 \
  <span class="n">t0</span> <span class="o">=</span> <span class="n">a1</span> <span class="o">^</span> <span class="n">a2</span><span class="p">;</span>                                 \
  <span class="n">a1</span> <span class="o">=</span> <span class="n">a2</span> <span class="o">^</span> <span class="n">t2</span><span class="p">;</span>                                 \
  <span class="n">a3</span> <span class="o">=</span> <span class="n">t1</span> <span class="o">&amp;</span> <span class="n">t2</span><span class="p">;</span>                                 \
  <span class="n">a3</span> <span class="o">=</span> <span class="n">t0</span> <span class="o">^</span> <span class="n">a3</span><span class="p">;</span>                                 \
  <span class="n">t0</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">|</span> <span class="n">t0</span><span class="p">;</span>                                 \
  <span class="n">a2</span> <span class="o">=</span> <span class="n">t2</span> <span class="o">^</span> <span class="n">t0</span><span class="p">;</span>                                 \
  <span class="p">}</span>
</code></pre></div></div>

This implementation modifies its input (`a0`, `a1`, `a2` and `a3`)
in-place, and uses 3 temporary variables `t0`, `t1` and `t2`. It
contains 12 instructions, and we might therefore expect that it
executes in 3 cycles on a Skylake, saturating the 4 bitwise ports of
this CPU. However, it contains a lot of data dependencies: `t2 = a3 |
t0` needs to wait to `t0 = ~a1` to be computed; `t2 = a0 ^ t2` needs
to wait for `t2 = a3 | t0`; `a0 = a0 ^ t1` needs to wait for `a0 = a0
& t0`, and so on. Compiled with Clang 7.0.0, this codes executes in
about about 5.24 cycles. By interleaving two instances of this code,
the impact of data hazards is reduced:


<div class="language-c highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="kt">#define</span> <span class="nf">sbox_circuit_interleaved</span><span class="p">(</span><span class="n">a0</span><span class="p">,</span><span class="n">a1</span><span class="p">,</span><span class="n">a2</span><span class="p">,</span><span class="n">a3</span><span class="p">,</span><span class="n">a0_2</span><span class="p">,</span><span class="n">a1_2</span><span class="p">,</span><span class="n">a2_2</span><span class="p">,</span><span class="n">a3_2</span><span class="p">)</span> <span class="p">{</span>  \
    <span class="kt">int</span> <span class="n">t0</span><span class="p">,</span> <span class="n">t1</span><span class="p">,</span> <span class="n">t2</span><span class="p">;</span>        <span class="kt">int</span> <span class="n">t0_2</span><span class="p">,</span> <span class="n">t1_2</span><span class="p">,</span> <span class="n">t2_2</span><span class="p">;</span>            \
    <span class="n">t0</span> <span class="o">=</span> <span class="o">~</span><span class="n">a1</span><span class="p">;</span>              <span class="n">t0_2</span> <span class="o">=</span> <span class="o">~</span><span class="n">a1_2</span><span class="p">;</span>                    \
    <span class="n">t1</span> <span class="o">=</span> <span class="n">a2</span> <span class="o">^</span> <span class="n">a3</span><span class="p">;</span>          <span class="n">t1_2</span> <span class="o">=</span> <span class="n">a2_2</span> <span class="o">^</span> <span class="n">a3_2</span><span class="p">;</span>              \
    <span class="n">t2</span> <span class="o">=</span> <span class="n">a3</span> <span class="o">|</span> <span class="n">t0</span><span class="p">;</span>          <span class="n">t2_2</span> <span class="o">=</span> <span class="n">a3_2</span> <span class="o">|</span> <span class="n">t0_2</span><span class="p">;</span>              \
    <span class="n">t2</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">^</span> <span class="n">t2</span><span class="p">;</span>          <span class="n">t2_2</span> <span class="o">=</span> <span class="n">a0_2</span> <span class="o">^</span> <span class="n">t2_2</span><span class="p">;</span>              \
    <span class="n">a0</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">&amp;</span> <span class="n">t0</span><span class="p">;</span>          <span class="n">a0_2</span> <span class="o">=</span> <span class="n">a0_2</span> <span class="o">&amp;</span> <span class="n">t0_2</span><span class="p">;</span>              \
    <span class="n">a0</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">^</span> <span class="n">t1</span><span class="p">;</span>          <span class="n">a0_2</span> <span class="o">=</span> <span class="n">a0_2</span> <span class="o">^</span> <span class="n">t1_2</span><span class="p">;</span>              \
    <span class="n">t0</span> <span class="o">=</span> <span class="n">a1</span> <span class="o">^</span> <span class="n">a2</span><span class="p">;</span>          <span class="n">t0_2</span> <span class="o">=</span> <span class="n">a1_2</span> <span class="o">^</span> <span class="n">a2_2</span><span class="p">;</span>              \
    <span class="n">a1</span> <span class="o">=</span> <span class="n">a2</span> <span class="o">^</span> <span class="n">t2</span><span class="p">;</span>          <span class="n">a1_2</span> <span class="o">=</span> <span class="n">a2_2</span> <span class="o">^</span> <span class="n">t2_2</span><span class="p">;</span>              \
    <span class="n">a3</span> <span class="o">=</span> <span class="n">t1</span> <span class="o">&amp;</span> <span class="n">t2</span><span class="p">;</span>          <span class="n">a3_2</span> <span class="o">=</span> <span class="n">t1_2</span> <span class="o">&amp;</span> <span class="n">t2_2</span><span class="p">;</span>              \
    <span class="n">a3</span> <span class="o">=</span> <span class="n">t0</span> <span class="o">^</span> <span class="n">a3</span><span class="p">;</span>          <span class="n">a3_2</span> <span class="o">=</span> <span class="n">t0_2</span> <span class="o">^</span> <span class="n">a3_2</span><span class="p">;</span>              \
    <span class="n">t0</span> <span class="o">=</span> <span class="n">a0</span> <span class="o">|</span> <span class="n">t0</span><span class="p">;</span>          <span class="n">t0_2</span> <span class="o">=</span> <span class="n">a0_2</span> <span class="o">|</span> <span class="n">t0_2</span><span class="p">;</span>              \
    <span class="n">a2</span> <span class="o">=</span> <span class="n">t2</span> <span class="o">^</span> <span class="n">t0</span><span class="p">;</span>          <span class="n">a2_2</span> <span class="o">=</span> <span class="n">t2_2</span> <span class="o">^</span> <span class="n">t0_2</span><span class="p">;</span>              \
  <span class="p">}</span>
</code></pre></div></div>

This code contains twice the S-box code (visually separated to make it
clearer): one implementation computes the S-box on `a0`, `a1`, `a2`
and `a3` while the other computes it on a second input, `a0_2`,
`a1_2`, `a2_2` and `a3_2`. This code runs in 7 cycles; or 3.5 cycles
per S-box, which is much closer to the ideal 3 cycles/S-box. We shall
call it 2-interleaved.

Despite the interleaving, some data dependencies remain, and it may be
tempting to interleave a third execution of the S-box. However, since
each S-box requires 7 registers (4 for the input, and 3 temporaries),
this would require 21 registers, and only 16 are available. Still, we
benchmarked this 3-interleaved S-box, and it executes 12.92 cycles, or
4.3 cycles/S-box; which is slower than the 2-interleaved one, but
still faster than without interleaved at all. Inspecting the assembly
code reveals that in the 3-interleaved S-box, 4 values are spilled,
thus requiring 8 additional `move` operations (4 stores and 4
loads). The 2-interleaved S-box does not contain any spilling.


**Remark.** In order to benchmark the S-box, we put it in a loop that
we unrolled 10 times (using Clang's `unroll` pragma). This unrolling
is required because of the expected port saturation: if the S-box
without interleaving was to use ports 0, 1, 5 and 6 of the CPU for 3
cycles, this would leave no free port to perform the jump at the end
of the loop. In practice, since the non-interleaved S-box does not
saturate the ports, this doesn't change its performances. However,
unrolling increases the performances of the 2-interleaved S-box -which
puts more pressure on the execution ports- by 14%.


### Initial benchmark

To benchmark our interleaving optimization, we considered 10 ciphers
which looked like "reasonable" candidates for interleaving, since
their register pressure was relatively low. We started by generating
non-interleaved and 2-interleaved implementations on general purpose
registers for each of them to compare them. We compiled the generated
codes with Clang 7.0.0. The results are shown in the following table:

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-wa1i{font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-amwm{font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-yla0{font-weight:bold;text-align:left;vertical-align:middle}
.tg .tg-fymr{font-weight:bold;border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>

<center>

<table class="tg" style="undefined;table-layout: fixed; width: 518px; margin-top: 40px; margin-bottom: 40px">
<colgroup>
<col style="width: 114px">
<col style="width: 144px">
<col style="width: 141px">
<col style="width: 119px">
</colgroup>
  <tr>
    <th class="tg-wa1i" rowspan="2">cipher</th>
    <th class="tg-amwm" colspan="2">Instructions per cycle</th>
    <th class="tg-yla0" rowspan="2">Interleaving (x2)<br>speedup</th>
  </tr>
  <tr>
    <td class="tg-fymr">without interleaving</td>
    <td class="tg-fymr">with interleaving x2</td>
  </tr>
  <tr>
    <td class="tg-0pky">ace</td>
    <td class="tg-0pky">2.90</td>
    <td class="tg-0pky">3.69</td>
    <td class="tg-0lax">1.23</td>
  </tr>
  <tr>
    <td class="tg-0pky">ascon</td>
    <td class="tg-0pky">2.89</td>
    <td class="tg-0pky">3.30</td>
    <td class="tg-0lax">1.15</td>
  </tr>
  <tr>
    <td class="tg-0pky">chacha20</td>
    <td class="tg-0pky">3.55</td>
    <td class="tg-0pky">3.95</td>
    <td class="tg-0lax">0.95</td>
  </tr>
  <tr>
    <td class="tg-0pky">clyde</td>
    <td class="tg-0pky">3.89</td>
    <td class="tg-0pky">3.93</td>
    <td class="tg-0lax">0.97</td>
  </tr>
  <tr>
    <td class="tg-0pky">gift</td>
    <td class="tg-0pky">3.57</td>
    <td class="tg-0pky">3.54</td>
    <td class="tg-0lax">0.94</td>
  </tr>
  <tr>
    <td class="tg-0pky">gimli</td>
    <td class="tg-0pky">3.82</td>
    <td class="tg-0pky">3.86</td>
    <td class="tg-0lax">0.87</td>
  </tr>
  <tr>
    <td class="tg-0pky">pyjamask</td>
    <td class="tg-0pky">3.36</td>
    <td class="tg-0pky">3.49</td>
    <td class="tg-0lax">1.07</td>
  </tr>
  <tr>
    <td class="tg-0pky">rectangle</td>
    <td class="tg-0pky">2.61</td>
    <td class="tg-0pky">3.40</td>
    <td class="tg-0lax">1.25</td>
  </tr>
  <tr>
    <td class="tg-0pky">serpent</td>
    <td class="tg-0pky">2.65</td>
    <td class="tg-0pky">3.60</td>
    <td class="tg-0lax">1.35</td>
  </tr>
  <tr>
    <td class="tg-0pky">xoodoo</td>
    <td class="tg-0pky">3.92</td>
    <td class="tg-0pky">3.79</td>
    <td class="tg-0lax">0.85</td>
  </tr>
</table>

</center>

Interleaving is more beneficial on ciphers with low instructions per
cycle (IPC). In all cases, the reason for the low IPC is data
hazards. The 2-interleaved implementations reduce the impact of those
data hazards, and bring the IPC up while increasing the
performances. We will examine each case one by one in the next section.


### Factor and grain

We now know that interleaving can indeed increase performances of
ciphers containing a lot of data dependencies. In order to optimize
this interleaving, we parametrized Usubac's algorithms by both a
factor and a grain. The factor corresponds to how many implementations
are interleaved, while the grain describes the granularity at which
instructions are interleaved. For instance, the Rectangle
2-interleaved S-box above has a factor of 2 and a granularity of 1
since instructions from the first and the second S-box are interleaved
one by one. A granularity of 2 would be the following code:

```c
t0 = ~a1;                                               \
t1 = a2 ^ a3;                                           \
                       t0_2 = ~a1_2;                    \
                       t1_2 = a2_2 ^ a3_2;              \
t2 = a3 | t0;                                           \
t2 = a0 ^ t2;                                           \
                       t2_2 = a3_2 | t0_2;              \
                       t2_2 = a0_2 ^ t2_2;              \
a0 = a0 & t0;                                           \
a0 = a0 ^ t1;                                           \
                       a0_2 = a0_2 & t0_2;              \
                       a0_2 = a0_2 ^ t1_2;              \
t0 = a1 ^ a2;                                           \
a1 = a2 ^ t2;                                           \
                       t0_2 = a1_2 ^ a2_2;              \
                       a1_2 = a2_2 ^ t2_2;              \
```

And a granularity of 4 would be:

```c
t0 = ~a1;                                               \
t1 = a2 ^ a3;                                           \
t2 = a3 | t0;                                           \
t2 = a0 ^ t2;                                           \
                       t0_2 = ~a1_2;                    \
                       t1_2 = a2_2 ^ a3_2;              \
                       t2_2 = a3_2 | t0_2;              \
                       t2_2 = a0_2 ^ t2_2;              \
a0 = a0 & t0;                                           \
a0 = a0 ^ t1;                                           \
t0 = a1 ^ a2;                                           \
a1 = a2 ^ t2;                                           \
                       a0_2 = a0_2 & t0_2;              \
                       a0_2 = a0_2 ^ t1_2;              \
                       t0_2 = a1_2 ^ a2_2;              \
                       a1_2 = a2_2 ^ t2_2;              \
```

The user can use the flags `-inter-factor <n>` and `-inter-grain <n>`
to instruct Usubac to generate a code using a given interleaving
factor and grain.

The grain is only up to a function call or loop, since we do not
duplicate function calls but rather the arguments in a function
call. For instance, the following Usuba code (extracted from our
Chacha20 implementation):

```lustre
state[0,4,8,12]  := QR(state[0,4,8,12]);
state[1,5,9,13]  := QR(state[1,5,9,13]);
state[2,6,10,14] := QR(state[2,6,10,14]);
```

Is 2-interleaved as (with `QR`'s definition being modified
accordingly):

```lustre
(state[0,4,8,12],state_2[0,4,8,12])  := QR(state[0,4,8,12],state_2[0,4,8,12]);
(state[1,5,9,13],state_2[1,5,9,13])  := QR(state[1,5,9,13],state_2[1,5,9,13]);
(state[2,6,10,14],state_2[2,6,10,14]) := QR(state[2,6,10,14],state_2[2,6,10,14]);
```

Rather than:

```lustre
state[0,4,8,12]  := QR(state[0,4,8,12]);
state_2[0,4,8,12]  := QR(state_2[0,4,8,12]);
state[1,5,9,13]  := QR(state[1,5,9,13]);
state_2[0,4,8,12]  := QR(state_2[0,4,8,12]);
state[2,6,10,14] := QR(state[2,6,10,14]);
state_2[0,4,8,12]  := QR(state_2[0,4,8,12]);
```

(note that vector slices are not part of Usuba0, but we used them in
this example nevertheless for more clarity)

The rational being that interleaving is supposed to reduce pipeline
stalls within functions (resp. loops), and duplicating function calls
(resp. loops) would fail to achieve this.

To evaluate how the factor and the grain impact the performances of a
cipher, we generated implementations of 10 ciphers with different
factors (0 (without interleaving), 2, 3, 4 and 5), and different
grains (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 20, 30, 50, 100,
200). We used Usubac's `-unroll` and `-inline-all` flags to fully
unroll and inline the codes (this flags will be discussed in a later
post) in order to reduce the impact of loops and function calls from
our experiment. Overall, we generated 19.5 millions of lines of C code
in 700 files for this benchmark.

SIMD assembly instructions are larger than general purpose ones. Since
standard codes are made of loops and function calls, decoded
instructions are stored in the instruction cache (DSB). However, since
we fully inlined and unrolled the codes, the legacy pipeline (MITE) is
used to decode the instructions, and can only process up to 16 bytes
of instruction per cycle. AVX instructions can easily take 7 bytes (an
addition where one of the operand is a memory address for instance),
and 16 bytes often correspond to only 2 instructions; not enough to
fill the pipeline.

We therefore benchmarked our interleaved implementations on general
purpose registers rather than SIMD ones, and verified that the
front-end was indeed not a bottleneck.

We report the results in the form of graphs showing the throughput (in
cycles per bytes; lower is better) of each cipher depending on the
interleaving granularity for each interleaving factor.


**Remark.** When benchmarking interleaving on general purpose
registers, we were careful to disable Clang's auto-vectorization
(using `-fno-slp-vectorize -fno-vectorize`). Failing to do so produces
inconsistent results since Clang is able to partially vectorize some
implementations and not others. Furthermore, we would not be
benchmarking general purpose registers anymore since the vectorized
code would use SSE or AVX registers.

#### Ace


<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/ace-gp-small.png">
</p>


One of Ace's basic block is a function which computes `((x <<< 5) & x)
^ (x <<< 1)`. It contains 4 instructions, and yet cannot be done in
less than 3 cycles, because of its inner dependencies. Interleaving
this function twice means that it contains 8 instructions which cannot
execute in less than 3 cycles, wasting 4 port-cycle. Interleaving it 3
times or more allows it to fully sature its ports (_i.e._ run its 12
instructions in 3 cycles), and it is indeed 1.01x times faster than
the 2-interleaved implementation depsite containing more spilling, and
is 1.25x faster than the non-interleaved implementation.

Ace also contain other idioms which can limit the utilization the CPU,
like `0xfffffffe ^ ((rc >> i) & 1)` which also cannot execute in less
than 3 cycles despite containing only 3 instructions. Those idioms
benefit from interleaving as well.

Interleaving 4 or 5 times introduces some spilling which reduces the
performances, but minimizes the impact of data hazard enough to be
better than the non-interleaved implementation. For comparison, the
5-interleaved implementation does 27 times more reads/stores to/from
memory than the non-interleaved one and is still 1.16x faster.

In all cases, the granularity has a low impact. The reordering done by
clang, as well as the out-of-order nature of the CPU are able to
schedule the instructions in a way to reduce the impact of data
hazards. When the granularity increases too much (100 and 200), this
less the case, and performances start to decrease.


#### Rectangle

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/rectangle-gp-small.png">
</p>

We have already shown Rectangle's S-box in this post's
introduction. It contains 12 instructions, and could be executed in 4
cycles if it wasn't for their dependencies: its run time is actually
5.24 cycles. Interleaving 2 (resp. 3) times Rectangle gives a speedup
of x1.26 (resp. x1.13), regardless of the granularity. The number of
loads and stores in the 2-interleaved Rectangle implementation is
twice more than in the non-interleaved implementation: interleaving
introduced no spilling at all. On the other hand, the 3-interleaved
implementation contains 4 times more memory operations than the
non-interleaved one.

Interleaving 4 or 5 instances with a small granularity (less than 10)
introduces too much spilling which reduces performances. Increasing
the granularity reduces this spilling while still allowing the C
compiler to schedule the instructions in a way to reduce the impact of
data hazards. For instance, 5-interleaved Rectangle with a granularity
of 50 contains twice less memory loads and stores than with a
granularity of 2.




#### Serpent

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/serpent-gp-small.png">
</p>

Serpent only requires 5 registers (4 for the state and 1 temporary
register used in the S-box). Its linear layer contains 28 instructions
`xor`s and shifts, yet executes in 14 cycles due to data
dependencies. Likewise, the S-boxes were optimized by Osvik [2] to put
a very low pressure on the registers, at the expense of data
dependencies. For instance, the first S-box contains 17 instructions,
but executes in 8 cycles. This choice made sense back when there were
only 8 general purpose registers available, among which one was
reserved for the stack pointer, and one was use to keep a pointer to
the key, leaving only 6 registers available. 

Now that we have 16 registers available, interleaving several
implementations of Serpent makes sense and does greatly improve
performances as can be seen from the graph. Once again, interleaving
more than two implementation introduces spilling, and does not improve
performances.

On AVX however, all 16 registers are available for use: the stack
pointer and the pointer to the key are kept in general purpose
registers rather than AVX ones. 3-interleaving therefore introduces
less spilling than on GP registers, making it 1.05 times faster than
2-interleaving:

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/serpent-small.png">
</p>


The current best AVX implementation of Serpent is -to the best of our
knowledge- the one from the [Linux
kernel](https://github.com/torvalds/linux/blob/ac309e7744bee222df6de0122facaf2d9706fa70/arch/x86/crypto/serpent-avx2-asm_64.S),
written by Kivilinna [3], and only uses 2-interleaving. Kivilinna
mentions that he experimentally came to the conclusion that
interleaving at a granularity of 8 is optimal for the S-boxes and that
10 or 11 is optimal for the linear layer. Using Usuba, we are able to
systemize this experimental approach and we observe that with Clang,
the granularity as a very low impact on the performances.


#### Ascon


<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/ascon-gp-small.png">
</p>


Ascon is the trickiest of the ciphers we considered when it comes to
analyzing its interleaved performances. Its S-box contains 22
instructions with few enough data dependencies to allow it to run in
about 6 cycles, which is very close to saturate the CPU. Its linear
layer however is the following:

```lustre
node LinearLayer(state:u64x5) returns (stateR:u64x5)
let
  stateR[0] = state[0] ^ (state[0] >>> 19) ^ (state[0] >>> 28);
  stateR[1] = state[1] ^ (state[1] >>> 61) ^ (state[1] >>> 39);
  stateR[2] = state[2] ^ (state[2] >>> 1)  ^ (state[2] >>> 6);
  stateR[3] = state[3] ^ (state[3] >>> 10) ^ (state[3] >>> 17);
  stateR[4] = state[4] ^ (state[4] >>> 7)  ^ (state[4] >>> 41);
tel
```

This linear layer is not limited by data-dependencies, but by the
rotations: general purpose rotations can only be executed by ports 0
and 6. Only two rotations can be executed each cycle, and this code
can therefore not be executed in less than 7 cycles: 5 cycles for all
the rotations, followed by two additional cycles to finish computing
`stateR[4]` from the result of the rotations, each computing a single
`xor`.

There are two ways that Ascon can benefit from interleaving. First, if
the linear layer is executed two (resp. three) times simultaneously,
the last 2 extra cycles computing a single `xor` each become two
cycles computing two (resp. three) `xor`s each; saving one (resp. two)
cycle. Second, out-of-order execution can allow the S-box of one
instance of Ascon to execute while the linear layer of the other copy
executes, thus allowing a full saturation of the CPU despite the
rotations being only able to use ports 0 and 6.

To understand how interleaving impacts performances, we used Linux's
`perf` tool to get the IPC, numbers of loads and stores, and the
number of cycles where 1, 2, 3 or 4 instructions are executed:

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-lboi{border-color:inherit;text-align:left;vertical-align:middle}
.tg .tg-uzvj{font-weight:bold;border-color:inherit;text-align:center;vertical-align:middle}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<center>
<table class="tg" style="undefined;table-layout: fixed; width: 652px; margin-top: 40px; margin-bottom: 40px">
<colgroup>
<col style="width: 112px">
<col style="width: 110px">
<col style="width: 76px">
<col style="width: 110px">
<col style="width: 61px">
<col style="width: 61px">
<col style="width: 61px">
<col style="width: 61px">
</colgroup>
  <tr>
    <th class="tg-uzvj" rowspan="2">Interleaving</th>
    <th class="tg-uzvj" rowspan="2">Cycles/Bytes</th>
    <th class="tg-uzvj" rowspan="2">IPC</th>
    <th class="tg-uzvj" rowspan="2">#Loads/Stores<br>(normalized)</th>
    <th class="tg-uzvj" colspan="4">% of cycles where at least n µops are executed</th>
  </tr>
  <tr>
    <td class="tg-uzvj">1</td>
    <td class="tg-uzvj">2</td>
    <td class="tg-uzvj">3</td>
    <td class="tg-uzvj">4</td>
  </tr>
  <tr>
    <td class="tg-lboi">none</td>
    <td class="tg-lboi">4.85</td>
    <td class="tg-0pky">2.75</td>
    <td class="tg-lboi">1</td>
    <td class="tg-0pky">99.2</td>
    <td class="tg-0pky">92.6</td>
    <td class="tg-0pky">48.9</td>
    <td class="tg-0pky">15.5</td>
  </tr>
  <tr>
    <td class="tg-0pky">x2</td>
    <td class="tg-0pky">4.01</td>
    <td class="tg-0pky">3.29</td>
    <td class="tg-0pky">2.07</td>
    <td class="tg-0pky">99.9</td>
    <td class="tg-0pky">99.6</td>
    <td class="tg-0pky">72.7</td>
    <td class="tg-0pky">35.6</td>
  </tr>
  <tr>
    <td class="tg-lboi">x3</td>
    <td class="tg-lboi">3.92</td>
    <td class="tg-0pky">3.80</td>
    <td class="tg-lboi">9.69</td>
    <td class="tg-0pky">99.7</td>
    <td class="tg-0pky">98.7</td>
    <td class="tg-0pky">91.3</td>
    <td class="tg-0pky">63.9</td>
  </tr>
  <tr>
    <td class="tg-0pky">x4</td>
    <td class="tg-0pky">4.05</td>
    <td class="tg-0pky">3.50</td>
    <td class="tg-0pky">10.05</td>
    <td class="tg-0pky">99.7</td>
    <td class="tg-0pky">97.0</td>
    <td class="tg-0pky">79.6</td>
    <td class="tg-0pky">51.3</td>
  </tr>
  <tr>
    <td class="tg-0pky">x5</td>
    <td class="tg-0pky">4.13</td>
    <td class="tg-0pky">3.37</td>
    <td class="tg-0pky">10.63</td>
    <td class="tg-0pky">99.9</td>
    <td class="tg-0pky">96.7</td>
    <td class="tg-0pky">74.1</td>
    <td class="tg-0pky">43.7</td>
  </tr>
</table>
</center>

The non-interleaved code has a fairly low IPC of 2.75, and uses less
than 3 ports on half the cycles. Interleaving twice Ascon increases
the IPC to 3.29, and doubles the number of memory operations which
indicates that no spilling has been introduced. However, only 72% of
the cycles use 3 cycles or more, which is still no very
high. 3-interleaved Ascon suffers from a lot more spilling: it
contains about 10 times more memory operations than without
interleaving. However, it also brings the IPC up tp 3.80, and uses 3
ports or more on 91% of the cycles.

However, interleaving a fourth or a fifth copy of Ascon doesn't
increase performances further, which is not surprising since
3-interleaved Ascon already almost saturates the CPU
ports. Furthermore, 4 and 5-interleaved Ascon even reduces the port
usage, probably because too much time is spent waiting on memory
operations to be completed.




#### Pyjamask

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/pyjamask-gp-small.png">
</p>


The linear layer of Pyjamask multiplies each of the 4 32-bit of the
state by a 32x32 binary matrix. This operation is done bit by bit,
and, for each bit, 4 operations are needed; each of them depending on
the previous one. This means that for the whole matrix multiplication,
which makes up most of Pyjamask, only one instruction is executed per
cycle.

On general purpose registers, interleaving twice Pyjamask increases
performances 1.13 times, mainly thanks to the parallelism it allows in
this matrix multiplication. However, it is still not enough to fully
utilize the pipeline, which is why interleaving 3, 4 or 5 times is
more beneficial, despite the additional spilling it introduces.


This effect is even more noticeable on AVX registers, as can be seen
in the following table:

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-cly1{text-align:left;vertical-align:middle}
.tg .tg-wa1i{font-weight:bold;text-align:center;vertical-align:middle}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>
<center>
<table class="tg" style="undefined;table-layout: fixed; width: 499px; margin-top: 40px; margin-bottom: 40px">
<colgroup>
<col style="width: 125px">
<col style="width: 125px">
<col style="width: 125px">
<col style="width: 124px">
</colgroup>
  <tr>
    <th class="tg-wa1i">Interleaving</th>
    <th class="tg-wa1i">Cycles/Bytes</th>
    <th class="tg-wa1i">IPC</th>
    <th class="tg-wa1i">#Loads/Stores<br>(normalized)</th>
  </tr>
  <tr>
    <td class="tg-cly1">none</td>
    <td class="tg-cly1">54.13</td>
    <td class="tg-0lax">2.71</td>
    <td class="tg-cly1">1</td>
  </tr>
  <tr>
    <td class="tg-0lax">x2</td>
    <td class="tg-0lax">47.18</td>
    <td class="tg-0lax">2.94</td>
    <td class="tg-0lax">2.83</td>
  </tr>
  <tr>
    <td class="tg-cly1">x3</td>
    <td class="tg-cly1">41.35</td>
    <td class="tg-0lax">3.38</td>
    <td class="tg-cly1">9.8</td>
  </tr>
  <tr>
    <td class="tg-0lax">x4</td>
    <td class="tg-0lax">41.91</td>
    <td class="tg-0lax">3.36</td>
    <td class="tg-0lax">26.3</td>
  </tr>
  <tr>
    <td class="tg-0lax">x5</td>
    <td class="tg-0lax">42.67</td>
    <td class="tg-0lax">3.50</td>
    <td class="tg-0lax">67</td>
  </tr>
</table>
</center>

Interleaving twice increases performances by x1.18, while interleaving
three times increases performances by 1.31x, depsite increasing the
amount of memory operations by 9.8 (and thefore the amout of memory
operations per input by 3.3). Even the 5-interleaved version is more
efficient than the non-interleaved one, despite containing 66 times
more loads and stores.

Another factor explaining the speedup offered by interleaving on
Pyjamask is the fact that the matrix used in the matrix multiplication
is circular, and can therefore be computed at runtime using a simple
rotation. This matrix is the same for all interleaved copies of the
cipher, and the rotations can therefore be done only once for all of
them.


#### Other ciphers

On the other ciphers we benchmarked (Chacha20, Clyde, Gift, Gimli,
Xoodoo), interleaving made performances worse, as can be seen from the
graphs below. As shown in Section "Initial benchmark", all of those
ciphers have very high IPC, above 3.5. None of those cipher is bound
by data dependencies (except for Chacha20, on which we will come back
in the post about scheduling), and the main impact of interleaving is
to introduce spilling.

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/chacha20-gp-small.png">
</p>

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/clyde-gp-small.png">
</p>

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/gift-gp-small.png">
</p>

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/gimli-gp-small.png">
</p>

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/xoodoo-gp-small.png">
</p>


#### Overall impact of factor and granularity

All of the examples we considered show that large granularities (50
and above) reduce the impact of interleaving, regardless of whether it
was positive or negative. Most of the times, the granularity has
little to no impact on the performances, as long as it is
below 20. There are a few exceptions, which can be attributed to
either compiler or CPU effects, and can be seen on Clyde, Gift, and
Xoodoo. For instance, on Xoodoo 3-interleaved, granularities of 12 and
20 are 1.26 times than granularities of 10, 15 and 30. Using `perf`,
we can see that the implementations with a granularity of 10, 15 and
30 do 1.53 more memory accesses than the ones with a granularity of 12
and 20, hinting toward a compiler issue.


Determining the ideal interleaving factor for a given cipher is a
complex task because it depends both the register pressure and the
data dependencies. In some cases, like Pyjamask, introducing some
spilling in order to reduce the amount of data hazards is worth it,
while in other cases, like Rectangle, spilling deteriorates the
performances. Furthermore, while we can compute the maximum number of
live variables in an Usuba0 program, the C compiler is free to
schedule the generated C code how it sees fit, potentially reducing or
increasing the amount of live variables.


Fortunately, Usubac automates the interleaving optimization, which we
can leverage to releave the programer from the burden of determining
himself the optimal interleaving parameters. When ran with the option
`-auto-interleave`, Usubac automatically benchmarks several
interleaving factors (0, 2, 3 and 4) in order to find out which is
best. This suffers from the limitation of loosing some genericity in
the C code generated: we only test its optimality with one compiler on
one platform.

We do not benchmark the granularity when selecting the ideal
interleaving setup, since its influence on performances is
minimal. Furthermore, our scheduling algorithm (which will be
presented in a later post) strives to minimize the impact of data
dependencies and thus reduces even further the influence of the
granularity.



---

## References

[1] M. Matsui, [How Far Can We Go on the x64 Processors?](https://www.iacr.org/archive/fse2006/40470344/40470344.pdf), FSE, 2006.

[2] D. A. Osvik, [Speeding up Serpent](https://www.ii.uib.no/~osvik/pub/aes3.pdf), AES Candidate Conference, 2000.

[3] J. Kivilinna, [Block Ciphers: Fast Implementations on x86-64 Architecture](http://jultika.oulu.fi/files/nbnfioulu-201305311409.pdf), 2013.
