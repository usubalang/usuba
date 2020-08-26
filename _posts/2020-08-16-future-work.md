---
layout: post
title: Future directions for Usuba
date: "2020-08-16 00:00:00"
description: 
lang: en
locale: en_US
author: Darius Mercadier
excerpt: We propose in this post some additional ideas to improve Usuba, such as extending vslicing and hslicing to allow parallelism even on general purpose registers, combining vslicing and hslicing to achieve an "hybrid" mslicing (useful to implement ciphers like Chacha20 and Gimli), incorporating modes of operations in Usuba rather than focussing solely on primitives, targeting other SIMD architectures (e.g. Neon and AltiVec), achieving end-to-end correctness of Usubac's pipeline, and, finally, targetting GPUs.
comments: true
hidden: false
---

Some future works were already discussed in previous posts:
implementing peephole optimizations for AVX512 (_e.g._ using
`vpternlog`) is discussed in the [Backend post]({{ site.baseurl }}{%
post_url 2020-06-06-backend %}), and improving the performances on
embedded devices (_e.g._ by targeting assembly rather than C) is
discussed in the [Tornado post]({{ site.baseurl }}{% post_url
2020-07-02-tornado %}). We propose in this post several additional
ideas to improve Usuba: extending vslicing and hslicing to allow
parallelism even on general purpose registers, combining vslicing and
hslicing to achieve an "hybrid" mslicing (useful to implement ciphers
like Chacha20 and Gimli), incorporating modes of operations in Usuba
rather than focussing solely on primitives, targeting other SIMD
architectures (_e.g._ Neon and AltiVec), achieving end-to-end
correctness of Usubac's pipeline, and, finally, targetting GPUs.
 

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
vsliced one. As shown in the [evaluation]({{ site.baseurl }}{%
post_url 2020-08-09-eval %}), the fastest implementation of Gimli on
AVX2 uses this technique, and is faster than Usuba's vsliced
implementation.

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


## AltiVec & Neon


We focused our evaluation on Intel SIMD, because of their wide
availability. Other architectures, such as AltiVec on PowerPC and Neon
on ARM, offer similar instructions as SSE and AVX. In particular, both
AltiVec and Neon provide 128-bit registers supporting 8/16/32/64-bit
arithmetic and shift instructions (used in vslicing), shuffles (used
in hslicing) and 128-bit bitwise instructions (used in all slicing
types). As a proof-of-concept, we thus implemented AltiVec and Neon
backends in Usubac.

The figure below shows the speedup offered by vector extensions on a
bitslice DES (including the transposition) on several architectures:
SKL is our Intel Xeon W-2155 (with 64-bit general purpose registers,
128-bit SSE, 256-bit AVX2, 512-bit AVX512), PowerPC is a PPC 970MP
(with 64-bit general purpose registers and 128-bit AltiVec), and ARMv7
is an ARMv7 Raspberry Pi3 (with 32-bit general purpose registers and
128-bit Neon). The performances have been normalized on each
architecture to evaluate the speedups of vector extensions rather than
the raw performances.

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:80%" src="{{ site.baseurl }}/assets/images/blog/perfs-neon-altivec-intel.png">
</p>

The speedups offered by SIMD extensions vary from one architecture to
the other. PowerPC's AltiVec offer 32-registers and 3-operand
instructions, and thus expectedly perform better than Intel's SSE
comparatively to a 64-bit baseline. ARM's Neon extensions only offer
16 registers on the other hand, resulting in a similar speedup as
Intel's AVX2 (note that ARMv7 has 32-bit registers whereas Skylake has
64-bit registers).

Still, the reality is more complex: Intel, ARM and PowerPC CPUs are
very different, each with their own pipelines, their own execution
units, their own instruction sets and their own latencies. We leave to
future work to conduct a proper evaluation of bitslicing and mslicing
on ARM and PowerPC, for which Usubac's Neon and AltiVec backend should
prove useful.



## Verification


Bugs in implementations of cryptographic primitives can have
devastating consequences [9,10,11,12]. To alleviate the risk of such
human errors, several recent projects aiming at generating
cryptographic codes have adopted approaches ensuring the functionnal
correctness of the code they produce [6,7,8].

The figure below illustrates how end-to-end functional correctness
could be added to the Usubac compiler. 

<p align="center" style="margin-top:30px;margin-bottom:30px;">
<img style="height:auto;width:auto;max-width:80%" src="{{ site.baseurl }}/assets/images/blog/verif-usuba-pipeline.png">
</p>

We propose to prove the correctness of the front-end by formaly
proving that each each normalization pass preserves the semantics of
the input program. Several work already showed how to prove the
correctness of normalization of dataflow languages [3,13,14].

For the backend (the optimizations), using _translation validation_
[4] might be more practical. The principle of translation validation
is to check wether the program after optimizations has the same
behavior as the program before the optimizations. This does not
guarantee that the compiler is correct, but it does guarantee that the
compilation of a given program is correct. However, translation
validation leads to a more easily extensible compiler than prooving
the correctness of each pass, since adding a new pass of optimization
does not impact the verification and does not require a proof of
correctness for this pass.

We already implemented a proof-of-concept translation validation for
the optimizations of the Usubac compiler. The principle is simple: we
extract two SMT from the pipeline, one before the optimizations, and
one after. We then feed them to the Z3 SMT solver [5], which checks
wether they are equivalent. Extraction of SMT equations from an Usuba0
program is straightforward thanks to our dataflow semantics: an Usuba0
program _is_ a set of equations.


The following Table reports the time (in second) that Z3 took to check
the equivalence of some Usuba program before and after
optimizations. Checking the equivalence between pre and
post-optimization Usuba0 program took from 3 secondes to 6000 secondes
to Z3. We have not analyzed why some ciphers are faster to verify for
Z3. Code size may have an impact (AES's code is much larger than any
other cipher we considered), but vslice Rectangle's code is much
smaller than its bitslice code, yet verification is slower. In any
case, our premilinary results show that this approach is practical and
require little investement.


<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-baqh{text-align:center;vertical-align:top}
.tg .tg-amwm{font-weight:bold;text-align:center;vertical-align:top}
</style>
<center>
<table class="tg" style="undefined;table-layout: fixed; width: 273px;margin-top:25px;margin-bottom:25px">
<colgroup>
<col style="width: 140px">
<col style="width: 133px">
</colgroup>
<thead>
  <tr>
    <th class="tg-amwm">cipher</th>
    <th class="tg-amwm">verification time</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-baqh">Rectangle (vslice)</td>
    <td class="tg-baqh">120 sec</td>
  </tr>
  <tr>
    <td class="tg-baqh">Rectangle (bitslice)</td>
    <td class="tg-baqh">51 sec</td>
  </tr>
  <tr>
    <td class="tg-baqh">DES (bitslice)</td>
    <td class="tg-baqh">3 sec</td>
  </tr>
  <tr>
    <td class="tg-baqh">AES (bitslice)</td>
    <td class="tg-baqh">6000 sec</td>
  </tr>
  <tr>
    <td class="tg-baqh">Chacha20 (vslice)</td>
    <td class="tg-baqh">3 sec</td>
  </tr>
  <tr>
    <td class="tg-baqh">Serpent (vslice)</td>
    <td class="tg-baqh">3 sec</td>
  </tr>
</tbody>
</table>
</center>

For additional confidence in the translation validation approach, a
certified SMT solver, like SMTCoq [17], could be used. (technically,
SMTCoq is not an SMT solver, but rather checks the correctness of
proof witnesses provided by SMT solvers)

Finally, translation from Usuba0 to imperative code can be formally
verified using existing techniques of the dataflow community [3]. We
could either target CompCert [15,16], a certified C compiler that
produces x86 assembly code. Or, if we decide to generate assembly code
ourselves (for better performances, as shown in the [Tornado post]({{
site.baseurl }}{% post_url 2020-07-02-tornado %})), we can draw
inspiration from CompCert's proofs and to generate Jasmin assembly
[7]. The Jasmin's certified compiler would then be used to generate
x86 assembly code.


## GPU

A lot of implementations of cryptographic algorithms on graphics
processing units (GPU) have been proposed in the last 15 years
[18,19,20,21,22], including some implementation of bitslice DES
[27,28,29] and bitslice AES [23,24,25,26,27]. Throughputs of more than
1 Tbits per seconds are reported for AES in [25]. The applications of
such high-throughput implementations include, among others, password
cracking [30,31], random number generation [32,33] or disk encryption
[34,35].

Both bitslice [25,26,27] and mslice [23,24] implementations of AES
have been demonstrated on GPUs. Additionally, Nishikawa _et al._ [24]
showed that GPUs offer a large design space: computation is broke down
into many threads, registers are a shared resource between threads, a
limited amount of thread can be executed simultaneously... Nishikawa
_et al._ [24] thus proposed an evaluation of the impact of some of
those parameters on an msliced AES. Usuba could improve upon their
work by automatically performing a more exhaustive evaluation of the
GPU parameters, in order to produce highly efficient GPU code for any
cipher.



---
## References

[1] D. J. Bernstein, P. Schwabe, [New AES Software Speed Records](cr.yp.to/aes-speed/aesspeed-20080908.pdf), INDOCRYPT, 2008.

[2] J. H. Park, D. H. Lee, [FACE: Fast AES CTR mode Encryption Techniques based on the Reuse of Repetitive Data](https://tches.iacr.org/index.php/TCHES/article/download/7283/6460), TCHES, 2018.
 
[3] T. Bourke _et al._, [A Formally Verified Compiler for Lustre](https://hal.inria.fr/hal-01512286/document), PLDI, 2017.

[4] A. Pnueli _et al._, [Translation validation](https://link.springer.com/content/pdf/10.1007/BFb0054170.pdf), TACAS, 1998.

[5] L. De Moura, N. Bjørner, [Z3: An efficient SMT solver](https://link.springer.com/content/pdf/10.1007/978-3-540-78800-3_24.pdf), TACAS, 2008.

[6] J. K. Zinzindohoué _et al._, [HACL*: A verified modern cryptographic library](https://eprint.iacr.org/2017/536.pdf), ACM Conference on Computer and Communications Security, 2017.

[7] J. B. Almeida _et al._, [Jasmin: High-Assurance and High-Speed Cryptography](https://acmccs.github.io/papers/p1807-almeidaA.pdf), CCS, 17.

[8] B. Bond _et al._, [Vale: Verifying High-Performance Cryptographic Assembly Code](https://www.usenix.org/system/files/conference/usenixsecurity17/sec17-bond.pdf), USENIX Security Symposium, 2017.

[9] B. B. Brumley _et al._, [Practical realisation and elimination of an ECC-related software bug attack](https://eprint.iacr.org/2011/633.pdf), CT-RSA, 2012.

[10] S. Gueron, V. Krasnov, [The fragility of AES-GCM authentication algorithm](https://eprint.iacr.org/2013/157.pdf), 2013.

[11] H. Boeck, [Wrong results with Poly1305 functions](https://mta.openssl.org/pipermail/openssl-dev/2016-March/006413.html), 2016.

[12] D. Benjamin, [poly1305-x86.pl produces incorrect output](https://mta.openssl.org/pipermail/openssl-dev/2016-March/006293.html), 2016.

[13] C. Auger _et al._, [A Formalization and Proof of a Modular Lustre Compiler](https://pdfs.semanticscholar.org/86e0/df88edcd0eda0bf38ccd41e537cb7154173a.pdf), 2012.

[14] C. Auger, [Compilation certifiée de SCADE/LUSTRE](https://tel.archives-ouvertes.fr/tel-00818169/file/VD2_AUGER_CEDRIC_07022013.pdf), 2013.

[15] S. Blazy _et al._, [Formal verification of a C compiler front-end](https://hal.inria.fr/inria-00106401/document), FM, 2006.

[16] X. Leroy, [Formal verification of a realistic compiler](https://dl.acm.org/doi/pdf/10.1145/1538788.1538814?casa_token=9OL3C95ukf0AAAAA:R0blUDnz0JJNE_BSlTEUvDMW353jwM5BY8-zNCwGuE_MUfsekOC6YL4CbTuobi4Dwyt9k2mLaezO), Communications of the ACM, 2009.

[17] M. Armand _et al._, [A modular integration of SAT/SMT solvers to Coq through proof witnesses](https://hal.inria.fr/file/index/docid/639130/filename/cpp11.pdf), CPP, 2011.

[18] S. A. Manavski _et al._, [CUDA compatible GPU as an efficient hardware accelerator for AES cryptography](http://www.manavski.com/downloads/PID505889.pdf), ICSPC, 2007.

[19] R. Szerwinski, T. Gïneysu, [Exploiting the Power of GPUs for Asymmetric Cryptography](https://link.springer.com/content/pdf/10.1007/978-3-540-85053-3_6.pdf), CHES, 2008.

[20] D. A. Osvik _et al._, [Fast Software AES Encryption](https://link.springer.com/content/pdf/10.1007/978-3-642-13858-4_5.pdf), FSE, 2010.

[21] O. Harrison, J. Waldron, [Efficient Acceleration of Asymmetric Cryptography on Graphics Hardware](https://nslab.kaist.ac.kr/courses/2015/cs710/paperlist/2-2.pdf), AFRICACRYPT, 2009.

[22] D. Cook _et al._, [CryptoGraphics: Secret key cryptography using graphics cards](https://users.dcc.uchile.cl/~voyanede/cc7515/lectura/gc_ctrsa.pdf), CT-RSA, 2005.

[23] R. K. Kim _et al._, [Bitsliced High-Performance AES-ECB on GPUs](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.696.781&rep=rep1&type=pdf), The New Codebreakers, 2016.

[24] N. Nishikawa _et al._, [Implementation of Bitsliced AES Encryption on CUDA-Enabled GPU](https://link.springer.com/chapter/10.1007/978-3-319-64701-2_20), NSS, 2017.

[25] O. Hajihassani _et al._, [Fast AES Implementation: A High-throughput Bitsliced Approach](https://ieeexplore.ieee.org/abstract/document/8691582/), IEEE Transactions on Parallel and Distributed Systems, 2019.

[26] B. Peccerillo _et al._, [Parallel bitsliced AES through PHAST: a single-source high-performance library for multi-cores and GPUs](https://link.springer.com/article/10.1007/s13389-017-0175-4), Journal of Cryptographic Engineering, 2019.

[27] J. Yang, J. Goodman, [Symmetric Key Cryptography on Modern Graphics Hardware](https://link.springer.com/content/pdf/10.1007/978-3-540-76900-2_15.pdf), ASIACRYPT, 2007.

[28] N. Dennier _et al._, [Improved Software Implementation of DES Using CUDA and OpenCL](https://core.ac.uk/download/pdf/13749299.pdf), 2011.

[29] G. Agosta _et al._, [Record setting software implementation of DES using CUDA](https://ieeexplore.ieee.org/abstract/document/5501641), 2010.

[30] L. Sprengers, [GPU-based password cracking](https://www.ru.nl/publish/pages/769526/thesis.pdf), 2011.

[31] M. Bakker, R. Van Der Jagt, [GPU-based password cracking](https://www.os3.nl/_media/2009-2010/courses/rp1/p34_report.pdf), 2010.

[32] S.K. Monfared _et al._, [High-performance Cryptographically Secure Pseudo-random Number Generation via Bitslicing](https://arxiv.org/pdf/1909.04750.pdf), 2019.

[33] W.K. Lee _et al._, [Fast implementation of block ciphers and PRNGs in Maxwell GPU architecture](https://link.springer.com/article/10.1007%2Fs10586-016-0536-2), Cluster Computing, 2016.

[34] G. Agosta _et al._, [Fast disk encryption through GPGPU acceleration](http://home.deib.polimi.it/barenghi/files/PDCAT2009.pdf), PDCAT, 2009.

[35] W. Sun _et al._, [GPUstore Harnessing GPU Computing for Storage Systems in the OS Kernel](https://dl.acm.org/doi/pdf/10.1145/2367589.2367595?casa_token=0FG9id7-ImQAAAAA:vFavPNGvp07IT9jYNW72EIigUMyiUbvwLEWg76YY-rT9B98LZ6I3tn9ubw39KfguCRkL4aMTyDbf), SYSTOR, 2012.
