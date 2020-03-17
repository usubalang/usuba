---
layout: post
title: Interleaving
date: "2020-03-16 00:00:00"
description: Usubac's interleaving optimization
lang: en
locale: en_US
author: Darius Mercadier
excerpt: A first optimization in Usubac consists in interleaving several executions of the program. For a cipher using a small number of registers (for example, strictly below 8 general-purpose registers on Intel), we can increase its instruction-level parallelism (ILP) by interleaving several copies of a single cipher, each manipulating its own independent set of variables.
comments: false
hidden: true
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

We generated 2-interleaved and non-interleaved codes for 10 ciphers
which looked like "reasonable" candidates for interleaving: their
register pressure was relatively low. The results are shown in the
following table:

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
    <td class="tg-0lax">1.18</td>
  </tr>
  <tr>
    <td class="tg-0pky">ascon</td>
    <td class="tg-0pky">2.74</td>
    <td class="tg-0pky">3.24</td>
    <td class="tg-0lax">1.21</td>
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
    <td class="tg-0lax">0.99</td>
  </tr>
  <tr>
    <td class="tg-0pky">rectangle</td>
    <td class="tg-0pky">2.61</td>
    <td class="tg-0pky">3.40</td>
    <td class="tg-0lax">1.16</td>
  </tr>
  <tr>
    <td class="tg-0pky">serpent</td>
    <td class="tg-0pky">2.65</td>
    <td class="tg-0pky">3.60</td>
    <td class="tg-0lax">1.21</td>
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
data hazards, and bring the IPC up while increasing the performances.

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


#### Ace


<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/ace-gp-small.png">
</p>


One of Ace's basic block is a fonction which computes `((x <<< 5) & x)
^ (x <<< 1)`. It contains 4 instructions, and yet cannot be done in
less than 3 cycles, because of its inner dependencies. Interleaving
this function twice means that it contains 8 instructions which cannot
execute in less than 3 cycles, wasting 1 port for 1
cycle. Interleaving it 3 times or more allows it to fully sature its
ports, and it is indeed 1.01x times faster than the 2-interleaved
implementation depsite containing more spilling, and is 1.25x faster
than the non-interleaved implementation.

Ace also contain other idioms which can limit the utilization the CPU,
like `0xfffffffe ^ ((rc >> i) & 1)` which also cannot execute in less
than 3 cycles despite containing only 3 instructions.

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

#### Ascon

Ascon: **TODO**: find out what is happening. State represented as 5
64-bit integers. Desn't require lot's of temporaries => low register
pressure. Non-interleaved: IPC=2.65. 2-interleaved (grain=10),
IPC=2.96 (loads/store x2.5). 3-interleaved (grain=10), IPC=3.20
(loads/store = x9).


<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/ascon-gp-small.png">
</p>


#### Rectangle

Rectangle's Sbox contains 12 instructions, which could execute in 4
cycles. However, because of its dependencies, it cannot execute in
less than 5 cycles (this is also true on general purposes, even though
it could execute in 3 cycles). The register pressure is fairly low
(the state is stored on 4 registers, and 3 additional temporaries are
used by the S-box). The number of loads in the 2-interleaved assembly
is twice more than in the non-interleaved (meaning that interleaving
introduces no spilling at all). The 3-interleaved version contains
twice more loads than the 2-interleaved: some spilling has been
introduced. However, the improvement in the S-box makes up for the
spilling. The 4-interleaved and 5-interleaved codes contain even more
spilling, which explain why they don't behave as good. It is worth
noting that the non-interleaved version has an IPC of 2.61, while all
of the interleaved versions are above 3.4 IPC. In the case of the
5-interleaved version, one every three instruction reads or loads data
from/to memory.


#### Serpent

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/rectangle-gp-small.png">
</p>

Serpent only requires 5 registers (4 for the state and 1 temporary
register used in the S-box). Its linear layer contains 28 instructions
`xor`s and shifts, yet executes in 14 cycles due to data
dependencies. Likewise, the S-box are bound by data dependencies. For
instance, the first S-box contains 17 instructions, but executes in 8
cycles.

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/serpent-gp-small.png">
</p>


**Bearly improves:**



<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/clyde-gp-small.png">
</p>


**RECHECK**
Non-interleaved: 2.49 IPC -> slightly low. 2-interleaved (grain=10):
2.69 IPC. Memory loads & stores x4, meaning it introduces
spilling. Yet, the round function has a dependency, which interleaving
is able to erase at the cost of some spilling. Not very clear.

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/chacha20-gp-small.png">
</p>


**Doesn't improve:**

**RECHECK**

Gift: interleaving (x2) -> 10x more loads, 4.5x more
stores. (expected: 2x and 2x). Non-interleaved version is already at
3.5 instr/cycle (IPC). Interleaving introduces a lot of spilling,
reducing to 2.51 IPC.

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/gift-gp-small.png">
</p>


Pyjamask. Front-end bandwidth issue. Could be considered as a compiler
issue: the non-interleaved code tends to use the pattern `and` +
memory operand, while the interleaved one tends to do `move` +
`and`. The latter requires 7 bytes for the move + 4 for the and = 11
bytes, while the former requires only 7 bytes for the and. Hence,
front-end bandwidth limitation.

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/pyjamask-gp-small.png">
</p>


Xoodoo represents the block as a 3x4 32-bit matrix. Most operations
are done either on each column or on each row, _i.e._ repeated 3 or 4
times, meaning they can easily be parallelized. More inputs = more spilling.

<p align="center" style="margin-top:30px;margin-bottom:30px">
<img src="{{ site.baseurl }}/assets/images/blog/graphs-interleaving/xoodoo-gp-small.png">
</p>


**Remark.** When benchmarking interleaving on general purpose
registers, we were careful to disable Clang's auto-vectorization
(using `-fno-slp-vectorize -fno-vectorize`). Failing to do so produces
inconsistent results since Clang is able to partially vectorize some
implementations and not others. Furthermore, we would not be
benchmarking general purpose registers anymore since the vectorized
code would use SSE or AVX registers.





The interleaving heuristic itself is retrospectively straight-forward:
the number of interleaved instances is set to be the number of CPU
registers available on the target architecture divided by the maximal
number of live registers in the given algorithm. **TODO**: nuance or
remove: we don't know the number of live registers. -> Heuristic with
automatic benchmark? (sounds reasonable -> do it!)
For example, Serpent and Rectangle use respectively 8 and 7 AVX
registers at most, which drives the compiler to pick an interleaving
factor of 2 when compiling. Choosing a larger factor would induce
spilling, which is highly detrimental to performance.

A second design decision concerns the size of the independent code
blocks to be interleaved. We have empirically observed that we can
adopt a coarse-grained approach: we chose to alternate between blocks
of 10 equations from each of the interleaved instances. The scheduling
performed by Usubac and the instruction scheduling later performed by
C compilers will do an excellent job at taking advantage of the
resulting ILP. **TODO**: this almost doesn't matter with Usuba's
scheduling algorithm -> rephrase to state that? Or benchmark various
granularities, and add a plot. Maybe do both.


#### Benchmarking






---

## References

[1] M. Matsui, [How Far Can We Go on the x64 Processors?](https://www.iacr.org/archive/fse2006/40470344/40470344.pdf), FSE, 2006.

[2] R. Motwani _et al._, [Combining register allocation and instruction scheduling](https://pdfs.semanticscholar.org/1b7d/20b856fd420f93525e70a876853f08560e38.pdf), 1995.

[3] C. Lattner, V. Adve, [LLVM: A Compilation Framework for Lifelong Program Analysis & Transformation](https://llvm.org/pubs/2003-09-30-LifelongOptimizationTR.pdf), CGO, 2004.

[4] J.-K. Zinzindohoué _et al_, [HACL*, A Verified Modern Crytographic Library](https://hal.inria.fr/hal-01588421v2/document), ACM Conference on Computer and Communications Security, 2017.
