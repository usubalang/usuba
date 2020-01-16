---
layout: post
title: Bitslicing
date: "2020-01-14 00:00:00"
description: Introduction to bitslicing
lang: en
locale: en_US
author: Darius Mercadier
excerpt: Bitslicing was initially introduced by Biham as an implementation trick to speed of software implementations of the DES cipher. The basic idea of bitslicing is to represent a n-bit data as 1 bit is n distinct registers, or, more generally, m n-bit data as n m-bit registers. This technique can thus be used to encrypt large amounts of data at once, especially when using SIMD registers.
comments: true
hidden: false
---
<!--
Missing:
 - bitslicing -> (very) high register pressure
-->

<!--
Intro
 - origin: DES by Biham
 - idea: 1 n-bit data -> n 1-bit registers
 - m data for parallelism
 - example (+- taken from slides):
   + transposition
   + xor
 - General principle n * m-bit -> m * n-bit
 - data origins (independent input)
-->

Bitslicing was initially introduced by Biham [1] as an implementation
trick to speed up software implementations of the
[DES](https://en.wikipedia.org/wiki/Data_Encryption_Standard)
cipher. The basic idea of bitslicing is to represent a _n_-bit data as
1 bit in _n_ distinct registers. On 64-bit registers, there are then
63 unused bits in each register, which can be filled in the same
fashion by taking 63 other independent _n_-bit data, and putting each
of their _n_ bits in one of the registers. Bitwise operators on 64-bit
(_e.g._ `and`, `or`, `xor`, `not`) then act as 64 parallel
operators. For instance, bitslicing 3-bit data requires 3
registers. The first bit of each data goes into the first register;
the second bit into the second register and the third bit into the
third register. Using 4-bit registers (for the sake of simplicity),
this can be applied to 4 data:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/bitslicing-example-small.png">
</p>

Once the data have this representation, doing a bitwise operation _o_
between two registers actually does _m_ independent _o_ (where _m_ is
the size of the registers; 4 in the previous example). For instance,
doing a `xor` between the first and third register above computes 4
`xor` at a time:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/bitslicing-example-xor-small.png">
</p>

The general idea of bitslicing is thus to transpose _m_ _n_-bit data
into _n_ _m_-bit registers (or variables). Then, standard _m_-bit
bitwise operations of the CPU can be used and each acts as _m_
parallel operation, allowing a cipher to effectively run _m_ times in
parallel.


In the following, we present various aspects of bitslicing: how to
scale bitslice code, how to efficiently compute permutations, how to
implement lookup table, why bitslice code is constant time, how to
transpose the data, and finally, how bitslicing deals with arithmetic
operations.


<!--
Scaling:
  - SIMD presentation
    + example paddb
  - embarrassingly parallel
  - wider registers -> more parallelism -> more throughput
    -> good with SIMD
  - standard code cannot always scale with SIMD
    (because of lookup tables)
-->
### Scaling

Modern high-end CPUs come with vector extensions, also called _SIMD_
for Single Instruction Multiple Data. The idea of SIMD is to do the
same operation on multiple data with a single instruction, thus
increasing throughput using data parallelism rather than
concurrency. SIMD instructions are made available to C developpers
thanks to functions called _intrinsics_. For instance, the C
intrinsics `_mm_add_pi8` generates a `paddb` assembly instruction,
which takes 2 64-bit MMX registers, and does 8 8-bit additions on
those registers:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/paddb-small.png">
</p>


Most non-embedded CPU architectures have SIMD extensions: 128-bit
AltiVec on PowerPC, 128-bit Neon on ARM, 64-bit MMX, 128-bit SSE,
256-bit AVX and 512-bit AVX-512 on Intel. While the initial goal of
SIMD is to speed up standard computations by providing parallel
arithmetic operations, we can use the bitwise operations and large
registers they provide to speed up bitslicing. Executing a bitslice
program on 512-bit registers will compute the same circuit on 512
independent data in parallel, thus readucing 8 times the cost per data
compared to 64-bit registers. Parallelizing direct (_i.e._ not
bitsliced) code in the same fashion using SIMD instructions is not
always possible: a lookup table cannot be parallelized for instance.

The overall time needed to execute the circuit, and thus the latency,
on the other hand remains constant no matter the registers used:
encrypting 64 inputs in parallel on 64-bit registers, or encrypting
512 inputs int parallel on 512bit registers will take roughly the same
amount of time. 

Finally, to make full use of SIMD extensions, hundreds of inputs must
be available to be encrypted in parallel. For instance, on AES, which
encrypts a 128-bit plaintext, in order to fill up 512-bit AVX-512
registers, 8 KB of data are required. And even if such amount of data
are available, bitslicing might not always work because some modes of
operations cannot be used, as shown below.


<!--
Mode of operation
 - definition: mode of operation of a cipher
   * example: ECB
   * example: CBC
 - limited to parallel modes in bitslicing
 - partial solution: 
   + encrypt independent data
   + use CTR
-->

### Modes of operation

A blockcipher can only encrypts a fixed amount of data, called a
block, of typically somewhere between 64 and 128 bits (for instance,
64 for DES, 80 for Rectangle, 128 for AES). When the plaintext is
longer than the block size, the cipher must be repeatedly called until
the whole plaintext is encrypted, using an algorithm called a _mode of
operation_. The simplest mode of operation is Electronic Codebook
(ECB), and consists in dividing the plaintext into blocks, and
encrypting them separately:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/ECB-small.png">
</p>

This mode of operation is not very secure because it lacks diffusion:
two identical blocks will be encrypted into the same ciphertext. This
can be exploited by an attacker to gain knowledge about the plaintext,
as can be seen from the following example (taken from
[Wikipedia](https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#ECB-weakness)):

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/ECB-example.png">
</p>


One of the better, and commonly used mode is Cipher Block Chaining
(CBC), which solves the weakness of ECB by xoring each plaintext with
the ciphertext produced by the encryption of the previous
plaintext. This proccessed is bootstraped by xoring the first
plaintext with an additional secret data called an _initialization
vector_:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/CBC-small.png">
</p>

However, because bitslicing encrypts many plaintexts in parallel, it
prevents the use of CBC, as well as any other mode that would rely on
using a ciphertext as an input for encrypting the next plaintext (like
Cipher Feedback (CFB) and Output Feedback (OFB)).

While this reduces the use cases for bitslicing, there are still two
ways of overcoming those issues:

 - In the case of a server encrypting a lot of independent data
   (coming from different clients), bitslicing can be done in such a
   way that each parallel data encrypted is independent from the
   others (_e.g._ all the data come from different clients). In
   pratice, it means that to fully exploit _n_-bit registers, _n_
   independent data must be encrypted, which may be hard to obtain in
   practice. Furthermore, this may incur a slight management overhead.
   
 - A parallel mode could be used instead, like Counter mode (CTR). CTR
   works by encrypting a counter rather than the plaintext directly,
   and then xoring the encrypted counter with the plaintext, as shown
   below:
   
   <p align="center">
   <img src="{{ site.baseurl }}/assets/images/blog/CTR-small.png">
   </p>
   
   Incrementing the counter can be done in parallel using SIMD
   instructions:
   
   ```c
   // Load 4 times the initial counter in a 128-bit SSE register
   __m128i counters   = _mm_set1_epi32(counter);
   // Load a SSE register with integers from 1 to 4
   __m128i increments = _mm_set_epi32(1, 2, 3, 4);
   // Increment each element of the counters register in parallel
   counters = _mm_add_epi32(counters, increments);
   // |counters| can now be transposed and encrypted in parallel
   ```
   
   CTR can thus be fully parallelized and therefore allows bitslicing
   to encrypt a lot of data from a single origin in parralel.

<!--
Compile-time permutations
 - permutations/shifts at compile-time
 - example: piccolo
   + circuit
   + naive code
   + optimized code
   + bitslice code
 - copy propagation -> static renaming of variables
 - optimized automatically in usuba
-->

### Compile-time permutations

Bitslicing allows shifts, rotations, and, more generally, any
bit-permutation to be done at compile time. Almost every cipher relies
on some form of a permutation to
provide
[diffusion](https://en.wikipedia.org/wiki/Confusion_and_diffusion)
(that is, to make sure that changing 1 bit in the plaintext changes
about half the bits of the ciphertext). For instance, Picollo [2] uses
the following 8-bit permutation:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/piccolo-perm.png">
</p>

A naive non-bitsliced C implementation would be:

```c
char permut(char x) {
    return ((x & 128) >> 6) |
           ((x & 64)  >> 2) |
           ((x & 32)  << 2) |
           ((x & 16)  >> 2) |
           ((x & 8)   << 2) |
           ((x & 4)   >> 2) |
           ((x & 2)   << 2) |
           ((x & 1)   << 6);
}
```

A clever developper (or a smart compiler) could notice that the three
right-shifts by 2 can be merged together: 
`((x & 16) >> 2) | ((x & 8) >> 2)` can be optimized to 
`(x & (16 | 8)) >> 2`. The same goes for the three left-shifts, and the 
permutation can therefore be written as (with the masks written in
binary for more simplicity):

```c
char permut(char x) {
    return ((x & 0b10000000) >> 6) |
           ((x & 0b01010100) >> 2) |
           ((x & 0b00101010) << 2) |
           ((x & 0b00000001) << 6);
}
```

Bitslicing allows to do even better: this permutation would be written
as simply 8 assignments in a bitsliced code:

```c
void permut(bool x0, bool x1, bool x2, bool x3, bool x4,
            bool x0, bool x1, bool x2, bool x3, bool x4,
            bool* y0, bool* y1, bool* y2, bool* y3, bool* y4,
            bool* y0, bool* y1, bool* y2, bool* y3, bool* y4) {
    *y0 = x2;
    *y1 = x7;
    *y2 = x4;
    *y3 = x1;
    *y4 = x6;
    *y5 = x3;
    *y6 = x0;
    *y7 = x5;
}
```

The C compiler can then inline this function, and get rid of the
assigments by
doing
[copy propagation](https://en.wikipedia.org/wiki/Copy_propagation),
thus effectively performing this permutation at compile time. (in the
case that you don't trust your C compiler to perform this task, fear
not: Usuba will do those optimizations itself)

<!--
Lookup tables
 - provide confusion (non-linerarity)
 - not doable in bitslicing
 - use circuit instead
   + example (rectangle)
 - generate circuit with karnaugh maps or BDD
 - SMT solvers? 
-->
### Lookup tables

Lookup tables are often used in ciphers to implement _Sboxes_, which
are functions providing non-linearity in ciphers; a desirable property
from a security perspective. Such tables cannot be used in bitslicing,
since each bit of the index would be in a different register. Instead,
equivalent circuits can be used, as illustrated in post [1: Usuba -
the genesis]({{ site.baseurl }}{% post_url 2020-01-07-usuba-genesis
%}). As a larger example, we can take Rectangle's lookup table [6],
defined as:

```c
char table[16] = { 
    6 , 5, 12, 10, 1, 14, 7, 9,
    11, 0, 3 , 13, 8, 15, 4, 2
};
```

It's a 4x4 lookup table: you need 4 bits to index its 16 elements, and
it returns integers on 4 bits (0 to 15). An equivalent circuit to this
table is:

```c
void table(bool  a0, bool  a1, bool  a2, bool  a3,
           bool* b0, bool* b1, bool* b2, bool* b3) {
    bool t1  = ~a1;
    bool t2  = a0 & t1;
    bool t3  = a2 ^ a3;
    *b0      = t2 ^ t3;
    bool t5  = a3 | t1;
    bool t6  = a0 ^ t5;
    *b1      = a2 ^ t6;
    bool t8  = a1 ^ a2;
    bool t9  = t3 & t6;
    *b3      = t8 ^ t9;
    bool t11 = *b0 | t8;
    b2       = t6 ^ t11;
}
```

Since this is a circuit, the 4 bits of the inputs and the outputs are
in 4 different variables. Using the principle of bitslicing, we can
use 64-bit variables (`uint64_t` in C) instead of `bool`, thus
computing the Sbox 64 times in parallel. Bitslicing can thus provide a
speedup compared to direct code: accessing to a data in the original
table will take about 1 cycle (assuming a cache hit), while doing the
12 instructions from the circuit above should take less than 10 cycles
to compute 64 times the Sbox (on 64-bit registers), thus costing about
0.15 cycles per Sbox.

Converting a lookup table into a circuit can be easily done using
[Karnaugh maps](https://en.wikipedia.org/wiki/Karnaugh_map) or [Binary
decision
diagrams](https://en.wikipedia.org/wiki/Binary_decision_diagram). However,
this would produce large circuits, containing much more instructions
than minimal circuits would. Brute-forcing is unlikely to yield any
results, as even a small 4x4 Sbox requires usually a circuit of about
12 instructions, and hundreds of billions of such circuits
exist. Heuristic can be added to the brute-force search in order to
reduce the complexity of the search [7], but this doesn't scale well
beyond 4x4 Sboxes. For larger Sboxes, like AES's 8x8 Sbox,
cryptographers often have to analyze the Sboxes' underlying
mathematical structure to optimize them, which becomes a tedious and
highly specialized job. Unfortunately, such a task is hard to
automatize, and is unavoidable to obtain good performances from
bitslicing a cipher with large Sboxes.

<!--
Constant-time
 - resilient against timing attacks
 - no conditional jumps
   + masking for conditions
     * example
   + overhead, but not a lot of conditionals in ciphers
 - no data-dependent memory access
   -> immune to cache-timing attacks
-->
### Constant-time

Bitsliced codes run in constant-time, and are thus resilient against
timing attacks. This main reason is that conditional jumps on secret
data prohibited: since _m_ data are being processed at once,
conditions must be emulated through masking by computing both branches
and recombining them. For instance,

```c
if (x) {
    a = b;
} else {
    a = c;
}
```

would be implemented in a bitsliced code as:

```c
a = (x & b) | (~x & c);
```

This would incur an overhead, but cryptographic primitives usually
avoid using conditionals. Furthermore, bitslicing also prevents any
memory access at an index depending on secret data, since each bit of
the index would be in different registers (as illustrated above on
Sboxes), thus making bitslicing immune to cache-timing attacks in
addition to more general timing attacks.

   
   
<!--
Transposition
 - expensive
 - naive algo:
   + pseudocode
   + complexity analysis: O(n)
 - improved algo
   + intuition
   + complexity: O(sqrt(nlogn))
   + experimental cost
 - encrypter & decrypter bitslice -> no need for transposition
-->
### Transposition

Transposing the data from a direct representation to a bitsliced one
is expensive. Naively, this would be done bit by bit, with the
following algorithm for a matrix of 64 64-bit registers (a similar
algorithm can be used for any matrix size):

```c
void naive_transposition(uint64_t data[64]) {
    // transposing |data| in a local array
    uint64_t transposed_data[64] = { 0 };
    for (int i = 0; i < 64; i++) {
        for (int j = 0; j < 64; j++) {
            transposed_data[j] |= ((data[i] >> j) & 1) << i;
        }
    }
    // copying the local array into |data|, thus transposing |data| in-place
    memcpy(data, transposed_data, 64 * sizeof(uint64_t));
}
```

This algorithm does 4 operations per bit of data (a left-shift `<<`, a
right-shift `>>`, a bitwise and `&` and a bitwise or `|`), thus having
a cost in _O(n)_ where _n_ is the size in bit of the input. Given that
modern ciphers can have a cost as low as half a cycle per byte (like
Chacha20 on AVX-512 for instance), spending 1 cycle per bit (8 cycles
per byte) transposing the data would make bitslicing too inefficient
to be used in practice. However, this transposition algorithm can be
improved (as shown by Knuth [3], and explained in details by Pornin
[4]) by observing that the transpose of a matrix can be reccursively
written as:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/transpose.png">
</p>

until there are only matrices of size 2x2 left (on a 64x64 matrix,
this takes 6 iterations). Swapping B and C is done with shifts and
`or`/`and` with masks. The key factor is than when doing this
operation recursively, the same shifts and masks will be applied on A
and B, and on C and D, thus saving a lot of operations over the naive
algorithm. When applied to a matrix of size _n_ x _n_, there are
_log(n)_ steps to get to 2x2 matrices, each of them doing _n_
operations to swap sub-matrices B and C. The total cost is therefore
_O(n*log(n))_ for a _n_ x _n_ matrix, or _O(sqrt(n*log(n)))_ for n
bits. As shown in [5], on a modern Intel computer, this amounts to
1.10 cycles per bits when _n = 16_ (_i.e._ transposing a 16x16
matrix), down to 0.09 cycles per bits when _n = 512_ (_i.e._
transposing a 512x512 matrix).

This algorithm allows the transposition to have a low cost when
compared to the whole cipher. Furthermore, in a setting where both the
encrypter and the decrypter use the same bitsliced algorithm,
transposing the data can be omitted altogether. Typically, this could
be the case when encrypting a hard drive.

<!--
Arithmetic operations
 - not possible in CPU
 -> re-implement as circuit
 - adder from full adders
   + full-adder
   + ripple-carry adder
   + theoretical cost in software
   + experimental cost: 2-5x times slower
 - multiplication too expensive
-->

### Arithmetic operations

Bitslicing prevents from using CPU arithmetic instructions (addition,
multiplication...), since each _n_-bit number is represented by 1 bit
in _n_ disctinct registers. Instead, bitslice programs must
reimplement binary arithmetic, using bitwise instructions, like
hardware manufacturers do.

For instance, an addition can be implemented in software using an
adder. The simplest adder is the [ripple-carry
adder](https://en.wikipedia.org/wiki/Adder_(electronics)#Ripple-carry_adder),
which works by chaining _n_ full adders to add two _n_-bit numbers. A
full adder takes two 1-bit inputs (A and B) and a carry (Cin), and
returns the sum of A and B (s) as well as the new carry (Cout):


<p align="center"> 
<img src="{{ site.baseurl }}/assets/images/blog/adder/adder.png">
</p>

A ripple-carry adder is simply a chain of such adders:

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/carry-ripple-adder-small.png">
</p>

Various techniques exist to build a better hardware adders than the
carry-ripple (_e.g._ [carry-lookahead
adder](https://en.wikipedia.org/wiki/Carry-lookahead_adder)), but they
do not apply to software, as will be detailed in a later article.

A software implementation of a _n_-bit carry-ripple adder thus
contains _n_ full adders, each doing 5 operations (3 `xor` and 2
`and`), for a total of _5n_ instructions. Since bitslicing still
applies, such a code would execute _m_ additions at once when ran on
_m_-bit registers (_e.g._ 64 on 64-bit registers, 128 on SSE
registers, 256 on AVX registers). The cost to do one _n_-bit addition
is therefore _5n/m_. On SSE registers, we can compare this adder with
the native packed addition instructions, which do _k_ _n_-bit
additions with a single instruction: 16 8-bit additions, or 8 16-bit
additions, or 4 32-bit additions, or 2 64-bit additions. On a Intel
Skylake i5-6500, native instructions are [2 to 5 times
faster](https://github.com/DadaIsCrazy/usuba/tree/master/experimentations/add)
than the software adder.

This slowdown by a factor or 5 could still be offset by other parts of
the programs, like permutations which would be done at compile-time as
mentionned above. However, implementing more complex operations like
multiplication is unlikely to ever be an option for bitsliced
code: while a _n_-bit adder requires _n*5_ instructions, implementing
a [binary multiplier](https://en.wikipedia.org/wiki/Binary_multiplier)
requires at least _n*n_ instructions.


<!-- 
Conclusion
 - bitslicing good in some settings:
   + no arithmetics
   + known efficient circuits for the sbox
   + permutations
 - However:
   + transposition is expensive
   + register pressure is high
 - m-slicing to solve the issues
-->
### Conclusion

Using bitslicing can significantly improve the throughput of a
cipher. This is especially true on CPU with SIMD extensions, which
provide wide registers, thus enabling lots of data-parallelism. The
gains in performances vary depending on the structure of the ciphers:
permutations will be free, lookup tables will have varying
performances depending on the size of the circuits needed to implement
them, and arithmetic operations will always be very
expensive. Transposition will have a non-negligeable cost, making
bitslicing a dubious technique for computing small circuits.

There is another issue with bitslicing: register pressure. A _n_-bit
input is turned into _n_ registers, but modern CPUs often only have 16
registers. Thus, a 128-bit input cannot be put into 128
registers. What will happen is a process called _spilling_: the data
be stored in 128 memory locations, and when some parts are actually
needed, they will be loaded into registers. For instance, on a fully
bitslice AES, about half the assembly instructions are `move`, moving
data from memory to registers and back.

To overcome the cost of spilling registers, and drawing inspiration
from existing adaptations of bitslicing [8], we propose a model called
_m_-slicing, which keeps the main properties of bitslicing
(constant-time, data parallelism scaling with register size), while
reducing register pressure, and allowing the use of more SIMD
instructions, like additions and multiplications.

<!-- <\!-- -->
<!-- Generalized bitslicing: m-slicing -->
<!--  - inspired by Kasper & Schwabe -->
<!--  - idea: n-bit input -> m k-bit registers with m>1 and k>1 -->
<!--  - example: Rectangle (re-use slide from PLDI) -->
<!--  - less registers pressure -->
<!--  - still scales with register size -->
<!--  - less expensive permutation -->
<!--  - can use (some) SIMD vector instructions -->
<!--  - two models (V/H-slicing) -->
<!--  - type-directed in Usuba -->
<!-- -\-> -->
<!-- ## mslicing -->

<!-- <p align="center"> -->
<!-- <img src="{{ site.baseurl }}/assets/images/blog/hslicing_oneway.png"> -->
<!-- </p> -->

<!-- <p align="center"> -->
<!-- <img src="{{ site.baseurl }}/assets/images/blog/hslicing_twoway.png"> -->
<!-- </p> -->

<!-- <\!-- -->
<!-- Horizontal slicing -->
<!--  - cf example from previous paragraph -->
<!--  - bits are splitted within the registers -->
<!--  - still cannot use arithmetic -->
<!--  - can use permutations -->
<!--    + example? (eg, vpshufb on AES's shiftrows?) -->
<!--  - best implementations of AES use hslicing -->
<!-- -\-> -->
<!-- ### Horizontal slicing -->

<!-- <\!-- -->
<!-- Vertical slicing -->
<!--  - =~ vectorization -->
<!--  - bits are packed together -->
<!--    * example: Rectangle (re-use slide from PLDI) -->
<!--  - can use arithmetic operations -->
<!--  - best implems of Serpent and Chacha use Vslicing -->
<!-- -\-> -->
<!-- ### Vertical slicing -->

<!-- <p align="center"> -->
<!-- <img src="{{ site.baseurl }}/assets/images/blog/vslicing_oneway.png"> -->
<!-- </p> -->

<!-- <p align="center"> -->
<!-- <img src="{{ site.baseurl }}/assets/images/blog/vslicing_twoway.png"> -->
<!-- </p> -->


<!-- <p align="center"> -->
<!-- <img src="{{ site.baseurl }}/assets/images/blog/slicings.png"> -->
<!-- </p> -->

<!--
Bitslicing as the basis for security countermeasures
 - constant-time
 - (higher-order) boolean masking
   * model: an attacker can probe n-1 intermediate values
   * n random bits such that x1 ^ x2 ^ ... ^ xn = x
   * can only use boolean operations
   * -> mixes well with bitslicing
   * automatically generated by Usuba
-->
<!-- ## Bitslicing for security? -->


---

## References

[1] E. Biham, [A fast new DES implementation in software](http://www.cs.technion.ac.il/users/wwwb/cgi-bin/tr-get.cgi/1997/CS/CS0891.pdf), FSE, 1997.

[2] K. Shibutani _et al._, [Piccolo: An Ultra-Lightweight Blockcipher](https://www.iacr.org/archive/ches2011/69170343/69170343.pdf), CHES, 2011.

[3] D.E. Knuth, [The Art of Computer Programming, Volume 3: (2Nd Ed.) Sorting and Searching](https://linuxnasm.be/media/pdf/donald-knuth/taocp/volume-3/taocp-vol3-sorting-searching.pdf), 1998.

[4] T. Pornin, [Implantation et optimisation des primitives cryptographiques](https://www.bolet.org/~pornin/2001-phd-pornin.pdf), 2001.

[5] D. Mercadier _et al_, [Usuba, Optimizing & Trustworthy Bitslicing Compiler](Usuba, Optimizing & Trustworthy Bitslicing Compiler), WPMVP, 2018.

[6] W. Zhang _et al_, [RECTANGLE: A Bit-slice Lightweight Block Cipher Suitable for Multiple Platforms](https://eprint.iacr.org/2014/084.pdf), 2014.

[7] D. A. Osvik, [Speeding up Serpent](https://www.ii.uib.no/~osvik/pub/aes3.pdf), 2000.

[8] E. Käsper, P. Schwabe, [Faster and Timing-Attack Resistant AES-GCM](https://www.esat.kuleuven.be/cosic/publications/article-1261.pdf), CHES, 2009.
