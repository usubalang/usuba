---
layout: post
title: Usubac back-end
date: "2020-03-04 00:00:00"
description: The backend of Usubac
lang: en
locale: en_US
author: Darius Mercadier
excerpt: 
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

### Interleaving


#### Principle

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


#### Example

Rectangle's S-box for instance can be written in C using the following
macro:

```c
int sbox_circuit(a0,a1,a2,a3) {                 \
  int t0, t1, t2;                               \
  t0 = ~a1;                                     \
  t1 = a2 ^ a3;                                 \
  t2 = a3 | t0;                                 \
  t2 = a0 ^ t2;                                 \
  a0 = a0 & t0;                                 \
  a0 = a0 ^ t1;                                 \
  t0 = a1 ^ a2;                                 \
  a1 = a2 ^ t2;                                 \
  a3 = t1 & t2;                                 \
  a3 = t0 ^ a3;                                 \
  t0 = a0 | t0;                                 \
  a2 = t2 ^ t0;                                 \
  }
```

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

```c
int sbox_circuit_interleaved(a0,a1,a2,a3,a0_2,a1_2,a2_2,a3_2) {  \
    int t0, t1, t2;                                         \
                           int t0_2, t1_2, t2_2;            \
    t0 = ~a1;                                               \
                           t0_2 = ~a1_2;                    \
    t1 = a2 ^ a3;                                           \
                           t1_2 = a2_2 ^ a3_2;              \
    t2 = a3 | t0;                                           \
                           t2_2 = a3_2 | t0_2;              \
    t2 = a0 ^ t2;                                           \
                           t2_2 = a0_2 ^ t2_2;              \
    a0 = a0 & t0;                                           \
                           a0_2 = a0_2 & t0_2;              \
    a0 = a0 ^ t1;                                           \
                           a0_2 = a0_2 ^ t1_2;              \
    t0 = a1 ^ a2;                                           \
                           t0_2 = a1_2 ^ a2_2;              \
    a1 = a2 ^ t2;                                           \
                           a1_2 = a2_2 ^ t2_2;              \
    a3 = t1 & t2;                                           \
                           a3_2 = t1_2 & t2_2;              \
    a3 = t0 ^ a3;                                           \
                           a3_2 = t0_2 ^ a3_2;              \
    t0 = a0 | t0;                                           \
                           t0_2 = a0_2 | t0_2;              \
    a2 = t2 ^ t0;                                           \
                           a2_2 = t2_2 ^ t0_2;              \
  }
```

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
is required because of the expected port saturation: if we hope that
the S-box without interleaving to use ports 0, 1, 5 and 6 of the CPU
for 3 cycles, this leaves no free port to perform the jump at the end
of the loop. In practice, since the non-interleaved S-box does not
saturate the ports, this doesn't change its performances. However,
unrolling increases the performances of the 2-interleaved S-box -which
puts more pressure on the execution ports- by 14%.


#### Implementation


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

On Serpent, we observe that the throughput of 2 interleaved ciphers is
21.75% higher than the throughput of a single cipher, while increasing
the code size by 29.3%. Similarly for Rectangle, the throughput
increases by 27.62% at the expense of a 19.2% increase in code
size. Ace: slightly better? Ascon: slightly better? Clyde: better?

Note on GP & auto-vectorization.

### Inlining

The decision of inlining nodes is partly justified by the usual
reasoning applied by C compilers: a function call implies a
significant overhead that, for very frequently called functions (such
as S-boxes, in our case) makes it worth the increase in code size. In
fact, all the compilers we have tested (excepted GCC in some
situations) are able to spot the fact that S-boxes, for example,
benefit from being inlined.  Usubac is only a helping hand here,
making sure that the user does not observe a performance regression
because of what could only be characterized as a bug in the C
compiler’s heuristics.

Bitslicing, however, sends the inlining heuristics of C compilers
astray. A bitsliced node compiles to a C function taking hundreds of
variables as inputs and outputs. For instance, the round function in
DES takes 120 arguments once bitsliced. Calling such a function
requires the caller to push hundreds of variables onto the stack while
the callee has to go through the stack to retrieve them, leading to a
significant execution overhead but also a growth in code size. C
compilers naturally avoid inlining this function because its code is
quite large, missing the fact that calling it actually becomes a
bottleneck.

On DES, inlining results in a 44.8% improvement in throughput while
actually reducing code size by 9.1%. Similarly, a bitsliced
implementation of AES (automatically obtained from the more efficient
hsliced version) is 24.24% more efficient with inlining at the expense
of a 24.8% increase in code size.  Because the AES round function is
significantly larger than its number of input variables, we notice an
increase of code size. However, increasing code size is hardly a
performance issue in our setting: our code is executed in a
straight-line sequence, with few to no control flow instructions. As a
result, whatever big the resulting binary is, instruction prefetch
allows us to amortize the few cache misses over the whole cache lines.

Besides, inlining offers more opportunities for scheduling. For
instance, symmetric cipher are usually composed of a sequence of 10 to
20 applications of a single round function.  Inlining this function
enables Usubac to schedule instructions across rounds, so as to
increase ILP.



### Scheduling bitsliced code

Our scheduling algorithm differs significantly depending on whether we
are scheduling bitsliced or m-sliced code. In a bitsliced program, the
single, major bottleneck is register pressure: a significant portion
of the execution time is spent spilling registers to and from the
stack. On DES, about 1 in 5 instructions deals with spilling.  The
role of scheduling is therefore to minimize register pres- sure as
much as possible.


One might expect the C compiler to already minimize register
pressure. However, it is well known that combining reg- ister
allocation and instruction scheduling is NP-hard [2], and modern C
compilers use heuristics to get the best possible approximations in
most cases. In the bistlicing setting, where hundreds of variables are
alive at the same time, those heuristics often prove to be
inefficient, and miss opportunities to lower the spilling.

Our scheduling algorithm follows:

```python
def Schedule(prog)
    for each function call funCall of prog do
        for each variable v in funCall's arguments do
            if v's definition is not scheduled yet then
                schedule v's definition next
        schedule funCall next
        for each variable v defined by funCall do
            for each equation eqn of prog using v do
                if eqn is ready to be scheduled then
                    schedule eqn next
```

This algorithm focuses on reducing the live ranges of function calls
arguments and return values –regardless of whether those functions
will be inlined or not–. The reasonning behind it is as
follows. According tothe x86-64 calling conventions, the first 8
arguments of function calls are passed in registers. It is therefore
profitable to schedule the instructions computing those arguments
close to the function call, thus removing the need to spill them only
to reload them later into registers. As for return values, they are
returned by reference in a structure (since x86-64 calling conventions
do not allow functions to return more than one value), which amounts
to having spilled them already. However, by moving instructions that
uses them right after the function call, we increase the potential
benefits of inlining: the return values will not need to be spilled
but instead will be allowed to stay in registers as their live ranges
will now be much shorter.

On bitsliced DES, combining scheduling and inlining increases
throughput by 6.77% compared to the inlined code and reduces code size
by 9.9% whereas, on bitsliced AES, throughput is increased by 2.49%
and code size reduced by 3.4%. This witnesses the fact that the
scheduling performed by Usubac is able to reduce unnecessary spilling,
which was not spotted by C compilers. Overall, combining inlining and
scheduling results in a net 45.8% increase in throughput compared to
baseline. Similarly, on bitsliced AES, throughput is globally improved
by 26.22%.

### Scheduling m-sliced code

Unlike bitsliced code, m-sliced programs have much lower register
pressure. Spilling is less of an issue, the latency of the few
resulting load and store operations being hidden by the CPU
pipeline. Instead, the challenge consists in being able to saturate
the parallel CPU execution units. To do so, one must increase ILP,
taking into account the availability of specialized execution
units. For instance, hsliced code will rely on SIMD shuffle
instructions (vpshufb) that can be executed on a single execution unit
on current Skylake architecture. Performing a sequence of shuffles is
extremely detrimental to performance: the execution of the shuffles
(and their respective dependencies) becomeserialized, bottlenecking
the dedicated execution unit.

One might think that the out-of-order nature of modern CPU would
alleviate this issue, allowing the processor to execute independent
instructions ahead in the execution streams. C compilers (such as ICC
and Clang) seems to adopt this policy: groups of shuffle in the source
code will be scheduled as-is in the resulting assembly. Only GCC
statically schedules independent (for example, arithmetic)
instructions in-between shuffles in the generated assembly. However,
due to the bulky nature of sliced code, we observe that the
reservation station is quickly saturated, preventing actual
out-of-order execution.

We statically increase ILP in Usubac by maintaining a look-behind
window of the previous 16 instructions (which corresponds to the
maximal number of registers available on Intel platforms without
AVX512) while scheduling. To schedule an instruction, we search among
the remaining instructions one with no data hazard with the
instructions in the look-behind window, and that would execute on a
different execution unit. If no such instruction can be found, we
reduce the size of the look-behind window, and, utlimately just
schedule any instruction that is ready.

This scheduling algorithm increased the throughput of hsliced AES by
2.43%, and of vsliced Chacha20 by 9.09%.  Inspecting the generated
assembly, we notice that, in both cases, the impact of data hazards
have been minimized by reorganizing computations within each rounds.

Inlining is instrumental in improving the quality of scheduling in
this setting too: it allows instructions to flow freely across node
calls. For instance, a round of Chacha20 is specified in terms of 2
half-rounds, which we naturally implement with two nodes. Thanks to
inlining, we can afford to define a node, hence increasing
readability, knowing that, performance-wise, it is transparent.

Whereas inlining allows scheduling to improve the code quality within
a single round, symmetric ciphers usually combine ten or more
iterations of a given round. For instance, Chacha20 performs 10
iterations of a double round, and AES performs between 10 and 14
rounds. In Usuba, these iterations are naturally expressed with a
grouped definition, using the forall declaration.

Usubac can choose between expanding the forall declaration –unrolling
the loop at the expense of code size– or to translate it into a C for
loop. The loop bounds being statically known, the C compiler could
also decide to fully unroll this loop. However, the size of the loop
body being significant, compilers prefer to avoid unrolling it, a
sound decision in general since code locality ought to be preserved.
Since we have perfect locality anyway, code size is not an issue in
our setting. We may thus profitably unroll all the rounds into a
single straight-line program: scheduling is thus able to re-order
instructions across distinct encryption rounds. On AES
(resp. Chacha20), this yields a 3.22% (resp. 3.63%) speedup compared
to an implementation performing intra-round scheduling only, at the
expense of a 31.90% (resp. 19.40%) increase in code size.


### Remark

It would be tempting to integrate the above optimizations as a
domain-specific backend for, say, LLVM [3].  We conjecture that the
resulting compiler would not be radically different nor significantly
faster than Usuba. First, our optimizations are complementary to those
performed by the C compiler (_e.g._, inlining). They would be
expressed almost as-is over LLVM-IR. Second, Table 2 will show that
there is no silver bullet among compilers: we are currently free to
pick the absolute best compiler, even if closed source. Third, going
the extra mile and targeting C simplifies integration in existing code
bases, as witnessed by the incorporation of the C files produced by
HACL* [4] into the Firefox and Wireguard projects. This allows the
cryptographical primitives to potentially outlive the DSL. In the
following, we evaluate the performance of the code generated by our
compiler.


---

## References

[1] M. Matsui, [How Far Can We Go on the x64 Processors?](https://www.iacr.org/archive/fse2006/40470344/40470344.pdf), FSE, 2006.

[2] R. Motwani _et al._, [Combining register allocation and instruction scheduling](https://pdfs.semanticscholar.org/1b7d/20b856fd420f93525e70a876853f08560e38.pdf), 1995.

[3] C. Lattner, V. Adve, [LLVM: A Compilation Framework for Lifelong Program Analysis & Transformation](https://llvm.org/pubs/2003-09-30-LifelongOptimizationTR.pdf), CGO, 2004.

[4] J.-K. Zinzindohoué _et al_, [HACL*, A Verified Modern Crytographic Library](https://hal.inria.fr/hal-01588421v2/document), ACM Conference on Computer and Communications Security, 2017.
