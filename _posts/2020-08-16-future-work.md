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

Summary:

 - peephole optimizations on AVX512 using `vpternlog` for instance, cf Backend
 
 - targetting assembly to optimize masked implementations on embedded devices. cf Tornado

 - hybrid/generalized mslicing, cf here
 
 - mslicing on general purpose registers, cf here
 
 - incorporate mode of operation, cf here
 

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



## Mode of operation

One of the commonly used mode of operation is counter mode (CTR). In
this mode (as illustrated below), a counter is encrypted by the
primitive (rather than encrypting the plaintext directly), and the
output of the primitive is `xor`ed with a block of plaintext to
produce the ciphertext. The counter is incremented by one for each
subsequent block of the plaintext to encrypt.

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/CTR.png">
</p>

For 256 consecutives block to encrypt, only the last byte of the
counter changes, and the other remain contant. Hongjun Wu and later
Bernstein and Schwabe [1] observed that the last byte of AES's input
only impacts 4 bytes during the first round:

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:100%" src="{{ site.baseurl }}/assets/images/blog/AES-round-CTR.png">
</p>

The results of the first round of `AddRoundKey`, `SubBytes` and
`ShiftRows` on the first 15 bytes, as well as `MixColumns` on 12 bytes
can thus be cached and reused for 256 encryptions. Concretely, the
first round of AES only require computing `AddRoundKey` and `SubBytes`
on a single byte (`ShiftRows` does not require computation), and
`MixColumns` on 4 bytes instead of 16. Similarly, 12 of the 16
`AddRoundKey` and `SubBytes` of the second round can be
cached. Additionally, Park and Lee [2] showed that some values can be
pre-computed to speed up computation even further. Only 4 bytes of the
output of the first round depends on the last byte, which can take 256
values. Thus, it is possible to precompte all 256 possible values for
those 4 bytes (which can be stored a 1KB table (4 * 256 = 1KB)), and
reuse them until incremeting the counter changes the 6<sup>th</sup>
byte from the end of the counter (<i>b<sub>10</sub></i> on the figure
above, which is an input of the same `MixColumn` as
<i>b<sub>15</sub></i>), or once every 1 trillion block.


To integrate such optimizations in Usuba, we will have to broaden the
scope of Usuba to include modes of operations. Then, two approaches
could be used. The less ambitious one consists in manually
implementing counter-caching optimizations, which might be doable in a
way to speedup other ciphers than AES as well. The more ambitious and
powerful one is rely on the existing optimzer of Usuba to detect such
optimization opportunities. For instance, common subexpression
elimination should be able to factorize redundant computations from
one plaintext to the next one. Integrating pre-computing to the
existing optimizations of Usuba however would require more
investigations.




---
## References

[1] D. J. Bernstein, P. Schwabe, [New AES Software Speed Records](cr.yp.to/aes-speed/aesspeed-20080908.pdf), INDOCRYPT, 2008.

[2] J. H. Park, D. H. Lee, [FACE: Fast AES CTR mode Encryption Techniques based on the Reuse of Repetitive Data](https://tches.iacr.org/index.php/TCHES/article/download/7283/6460), TCHES, 2018.
