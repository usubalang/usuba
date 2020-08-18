---
layout: post
title: Future directions for Usuba
date: "2020-08-16 00:00:00"
description: 
lang: en
locale: en_US
author: Darius Mercadier
excerpt: 
comments: false
hidden: true
---



## mslicing on general purpose registers

In Section Monomorphization, we mentioned that the lack of x86-64
instruction to shift 4 16-bit works in a single 64-bit register
prevents us from parallelizing Rectangle's vsliced implementation on
general purpose registers. 

In practice though, the `_pdep_u64` intrinsic could be used to
interleave several inputs of vsliced Rectangle in the same 64-bit
register. This instructions take a register `a` and an integer `mask`
as parameters, and dispatches the bits of `a` to a new registers
following the pattern in `mask`. For instance, using `_pdep_u64` with
the mask `0x8888888888888888` would dispatch a 16-bit input of
Rectangle into a 64-bit register as follows:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/pdep_u64-1.png">
</p>

A second input of Rectangle could be dispatched into the next bits
using the mask `0x4444444444444444`:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/pdep_u64-2.png">
</p>

Repeating the process with two more inputs and the masks
`0x2222222222222222` and `0x1111111111111111`, and combining the
results (using a simple `or`) would produce a 64-bit register
containing 4 interleaved 16-bit inputs of Rectangle. Since Rectangle's
whole input is 64-bit, this process needs to be repeated 4
times. Then, regular shift and rotate instructions can be used to
independently rotate each input. For instance, a left-rotation by 2
can now be done by a simple left-rotation by 8:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/rectangle-std-inter.png">
</p>

In essence, this technique is similar to hslicing in its data layout,
but similar to vslicing in the instructions it offers. Bits of the
input are split along the horizontal direction of the registers, but
the lack of vector instructions on general purpose registers prevents
the use of `Shuffle`s, and requires using standard vsliced
instructions, except for arithmetic instructions. We leave for future
work the investigation of how this mode of slicing could be
incorporated within Usuba.



## Generalized mslicing

Recall the main computing nodes of Chacha20:

```lustre
node QR (a:u32, b:u32, c:u32, d:u32)
     returns (aR:u32, bR:u32, cR:u32, dR:u32)
let
    a := a + b;
    d := (d ^ a) <<< 16;
    c := c + d;
    b := (b ^ c) <<< 12;
    aR = a + b;
    dR = (d ^ aR) <<< 8;
    cR = c + dR;
    bR = (b ^ cR) <<< 7;
tel

node DR (state:u32x16) returns (stateR:u32x16)
let
    state[0,4,8,12]  := QR(state[0,4,8,12]);
    state[1,5,9,13]  := QR(state[1,5,9,13]);
    state[2,6,10,14] := QR(state[2,6,10,14]);
    state[3,7,11,15] := QR(state[3,7,11,15]);

    stateR[0,5,10,15] = QR(state[0,5,10,15]);
    stateR[1,6,11,12] = QR(state[1,6,11,12]);
    stateR[2,7,8,13]  = QR(state[2,7,8,13]);
    stateR[3,4,9,14]  = QR(state[3,4,9,14]);
tel
```

Within the node `DR`, the node `QR` is called 4 times on independent
inputs, and then 4 times again on independent inputs. Visually, we can
represent the first 4 calls to `DR` as:


<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:70%" src="{{ site.baseurl }}/assets/images/blog/chacha20-round.png">
</p>

In vslicing, each 32-bit work of the state would be mapped to an SIMD
register, and those registers would be filled with independent
inputs. For instance, on SSE, 4 states would be processed in parallel:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/chacha20-round-vslice.png">
</p>

The last 4 calls to `QR` in the second half of `DR` would then be:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/chacha20-round-vslice-2.png">
</p>

Using pure vslicing in that case however may not be optimal, because
16 registers are required, which leaves no unused registers for
temporary variables on SSE or AVX. In practice, at least one register
of the state will have to be spilled to memory.

Rather than parallelizing Chacha20 by filling SSE or AVX register with
independent inputs, it is possible to do the parallization for a
single instance on SSE registers (or two instances on AVX2). Since the
first 4 calls to `QR` operate on independent values, we an pack the 16
32-bit words of the state within 4 SSE (or AVX) registers, and a
single call to `QR` will compute it four times on a _single_ input:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/chacha20-round-par.png">
</p>

Three rotations are then needed to reorganize the data for the final 4
calls to `QR`:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/chacha20-round-par-2.png">
</p>

On SSE or AVX registers, those rotations would be done using Shuffle
instructions. Finally, a single call to `QR` computes the last 4
calls:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/chacha20-round-par-3.png">
</p>

This technique has the advantage over vslicing that it requires less
parallelism: on SSE (resp. AVX), 4 (resp. 8), it requires only 1
(resp. 2) independent inputs to reach the maximal throughput, while in
vslicing, it required 4 (resp. 8). Similarly, the latency is divided
by 4 compared to vslicing, which will speed up applications that
require encrypting less than 4 blocks.

The downside is that it requires additional shuffles to reorganize the
data withing each round and at the end of each round, which will slow
down the cipher compared to vslicing. Furthermore, recall from the
[Scheduling post]({{ site.baseurl }}{% post_url 2020-05-09-scheduling
%}) that Chacha20's quarter round (`QR`) is bound by
data-dependencies. In vslicing, 4 rounds needed to be computed, and
Usuba's scheduling algorithm was able to interleave them, thus
removing any stalls related to data dependencies. This is not possible
with this new implementation, since only two calls to `QR` remain,
both of which cannot be computed simultaneously.

However, the decrease in register pressure allows such an
implementation of Chacha20 to be implemented without any spilling,
which improves its performances. Furthermore, because this
implementation only uses 5 registers (4 for the state + 1 temporary),
it can be interleaved 3 times without introducing any spilling. This
interleaving would remove that data hazards from `QR`, like Usubac's
scheduling did for the vsliced implementation. The performances of
this spill-free 3-interleaved implementation (but containing
additional shuffles) would need to be compared to the classical
vsliced one.

We can see this technique as a generalization of mslicing, sharing
similarities with both hslicing and vslicing. One way to incorpore it
to Usuba would be to, instead of representing types with a direction
<i>D</i> and a word size <i>m</i>
(<code>u<i><sub>D</sub>m</i></code>), represent them with a word size
<i>m</i> and a vector size <i>V</i>
(<code>u<i>m</i><sup>V</sup></code>). The word size would correspond
to the size of the packed elements within SIMD registers, and the
vector size represent how many elements of the same input are packed
within the same input. For instance, Chacha20's new implementation
would represent its state into 4 values of type
<code>u<i>32</i><sup>4</sup></code>.

Using this representation, a vslice type
<code>u<i><sub>V</sub>m</i></code> would correspond to
<code>u<i>32</i><sup>1</sup></code>, while an hslice type
<code>u<i><sub>H</sub>m</i></code> would correspond to
<code>u<i>1</i><sup>m</sup></code>, and a bitslice type
<code>u<i><sub>D</sub>1</i></code> would unsurprisingly correspond to
<code>u<i>1</i><sup>1</sup></code>.

A type <code>u<i>m</i><sup>V</sup></code> would be valid only if the
targeted architecture offered SIMD vectors able to contain _V_ words
of size _m_. Arithmetic instructions would be possible between two
<code>u<i>m</i><sup>V</sup></code> values (provided that the
architecture offers instruction to perform _m_-bit arithmetics) and
shuffles would be allowed if the architectures offers instructions to
shuffle _m_-bit words.


## Peephole optimizations on AVX-512


`vpternlog`

 - for now, only used to replaced `xor`s and `or`s by Clang/GCC
 
 - example to optimize something
 
 
Old text:
 
Additionally,
Clang optimizes several `xor` and `or` of Serpent by combining them
into a single `vpternlog` instruction. This new AVX512 instruction
computes any three-operand binary function at once. The AVX2
implementation of Serpent thus contains 652 `or`s and 1408 `xor`s. Of
those 652 `or`s, 186 are used to emulate rotations (6 rotations per
round for 31 rounds), which leaves a total of `652 - 372 + 1408 =
1688` `xor`s and `or`s not use in rotations. On the other hand, the
AVX512 implementation contains 280 `or`s, 1336 `xor`s and 72
`vpternlog`, or a total of 1668.



## Optimizations for low-end CPUs

 - Stoffelen's scheduler


## Mode of operation

 - counter caching ref
 - counter caching with slicing


---
## References
