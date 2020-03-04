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

A first optimization consists in interleaving several executions of
the program. Usuba allows us to systematize this folklore programming
trick, popularized by Matsui [1]: for a cipher using a small number of
registers (for example, strictly below 8 general-purpose registers on
Intel), we can increase its instruction-level parallelism (ILP) by
interleaving several copies of a single cipher, each manipulating its
own independent set of variables. This can be understood as a static
form of hyper-threading, by which we (statically) interleave the
instruction stream of several parallel execution of a single
cipher. By increasing ILP, we reduce the impact of data hazards in the
deeply pipelined CPU architecture we are targeting. Note that this
technique is orthogonal from slicing (which exploits spatial
parallelism, in the registers) by exploiting temporal parallelism,
_i.e._ the fact that a modern CPU can dispatch multiple, independent
instructions to its parallel execution units. This technique naturally
fits within our parallel programming framework: we can implement it by
a straightforward Usuba0-to-Usuba0 translation.

The interleaving heuristic itself is retrospectively straight-forward:
the number of interleaved instances is set to be the number of CPU
registers available on the target architecture divided by the maximal
number of live registers in the given algorithm. For example, Serpent
and Rectangle use respectively 8 and 7 AVX registers at most, which
drives the compiler to pick an interleaving factor of 2 when
compiling. Choosing a larger factor would induce spilling, which is
highly detrimental to performance.

A second design decision concerns the size of the independent code
blocks to be interleaved. We have empirically observed that we can
adopt a coarse-grained approach: we chose to alternate between blocks
of 10 equations from each of the interleaved instances. The scheduling
performed by Usubac and the instruction scheduling later performed by
C compilers will do an excellent job at taking advantage of the
resulting ILP.

On Serpent, we observe that the throughput of 2 interleaved ciphers is
21.75% higher than the throughput of a single cipher, while increasing
the code size by 29.3%. Similarly for Rectangle, the throughput
increases by 27.62% at the expense of a 19.2% increase in code size.


---

## References

[1] M. Matsui, [How Far Can We Go on the x64 Processors?](https://www.iacr.org/archive/fse2006/40470344/40470344.pdf), FSE, 2006.
