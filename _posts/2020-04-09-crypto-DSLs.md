---
layout: post
title: DSLs for cryptography
date: "2020-04-09 00:00:00"
description: Presentation of some languages cryptography, and their differences/similarities with Usuba
lang: en
locale: en_US
author: Darius Mercadier
excerpt: Cryptol started from the observation that due to the lack of standard for specifying cryptographic algorithms, papers described their ciphers using a combination of english (too ambiguous) and pseudo-codes (ill-suited to describe mathematical operations) while providing reference implementations in C (too low-level)
comments: true
hidden: false
---


### Cryptol 

Cryptol [1] started from the observation that due to the lack of
standard for specifying cryptographic algorithms, papers described
their ciphers using a combination of english (which Cryptol's author
deem "ambiguous") and pseudo-codes (which tends to "obscure the
underlying mathematics") while providing reference implementations in
C ("far too low-level"). Thus, Cryptol is a programming language for
speficying cryptographic algorithms, from protocols and modes of
operations down to primitives. It covers a broder range than Usuba,
which focuses solely on primitives.

Usuba's design and abstractions were driven by existing CPU
architectures, but still aims at providing a semantics abstract enough
to allow reasoning on combinational circuits. Often, ciphers are
specified at this level of abstraction, but not always: AES for
instance is defined in terms of operations in a finite field. Cryptol
handles well this type of cipher, by providing high-level mathematical
abstractions, even when they do not trivially map to any commonly used
hardware. As such, Cryptol natively supports polynomials and field
arithmetics, allowing it to express naturally ciphers like AES. For
instance, AES's multiplication in GF(2<sup>8</sup>) modulo the
irreducible polynome <i>x<sup>8</sup> + x<sup>4</sup> +
x<sup>3</sup> + x + 1</i> can be written in Cryptol as:

```
irreducible = <| x^^8 + x^^4 + x^^3 + x + 1 |>

gf28Mult : (GF28, GF28) -> GF28
gf28Mult (x, y) = pmod(pmult x y) irreducible
```

Cryptol basic types are bitvectors, similar to Usuba's
<code>u<i>n</i></code> types, which can be grouped in tuples, similar
to what Usuba offers. However, where tuples are at the core of Usuba's
programs, Cryptol's main construction is sequences, which, unlike
tuples, contain elements of the same type. Several operators allow to
manipulate sequences: comprehensions, enumerations, infinite
sequences, indexing and appending operators. Furthermore, bitvectors
can be specified using boolean sequences. For instance, the expression

```
[True, False, True, False, True, False]
```

constructs the integer 42, and the indexing operation `@` can be with
the same effect on the literal 42 or on this sequence: `42 @ 2`
returns `True`, like `[True, False, True, False, True, False] @ 2`
does. Usuba does not allow bit-manipulation of words, which would not
be efficient on most CPU architectures.


The Cryptol language is more expressive than Usuba, and include
features like records, strings, user-defined types, predicates,
modules, first-class type variables and lambda expressions. By
focusing on symmetric primitives in Usuba, we strived to keep the
language as simple (yet expressive) as possible, and did not require
those constructions.


Another aspect of Cryptol is that it allows programmers to write
correctness properties within their codes, and asserts their validity
using SMT solvers (Z3 [2] by default). An example of such a property
is found in Cryptol's reference AES implementation:

```
property AESCorrect msg key = aesDecrypt (aesEncrypt (msg, key), key) == msg
```

which states that decrypting a ciphertext encrypted with AES yields
the original plaintext. When the SMT solver fails to prove properties
in reasonable time, Cryptol falls back to random testing: it tests the
property on a given number of random inputs and checks whether it
holds. Usuba does not offer such features at this stage, even though
it still performs some checking (it does exhaustive testing on lookup
tables and their corresponding circuits for instance, and can ensure
the correctness of some optimization passes using translation
validation).

Overall, Cryptol is a very expressive language for cryptography, but
falls short on the performance aspect. With Usuba we restricted the
problem tackled by Cryptol to only symmetric primitives in order to
focus on performances, and adopted a bottom-up view, offering only
high-level constructions that we are able to compile to efficient
code. Furthermore, the automatic slicing and masking done by Usuba are
missing in Cryptol.


### CAO

CAO [3,4] is a domain-specific programming language (DSL) that focuses
on cryptographic primitives. Like Usuba, CAO started from the
observation that writing primitives in C either leads to poor
performances because the C compiler is unable to optimize them well,
or to unmaintainable code because optimizations are done by hand.

The level of abstractions provided by CAO is similar to Usuba and
unlike Cryptol: functions, `for` loops, standard C operators (`+`,
`-`, `*`, ...), ranges to index multiples elements of a vector,
concatenation of vectors... CAO also has a `map` operator, which
describes mapping from inputs to outputs of a permutation, in a style
similar to Usuba's `perm` nodes.

However, whereas Usuba's main target is symmetric cryptography, CAO is
more oriented toward asymmetric (public-key) cryptography, and thus
offers many abstractions for finite field arithmetics. For instance,
one can define a type `f` for AES's values like:

```
typedef f := gf[2 ** 8] over $ ** 8 + $ ** 4 + $ ** 3 + $ + 1
```

AES's Mixcolumn can then be written at a higher level in CAO than in
Usuba, allowing the programming to dirrectly appeal to operators in
GF(2<sup>8</sup>), which Usuba does not provide.

To support public-key cryptography, CAO also provides conditionals in
the language. However, to prevent timing attacks, variables can be
annotated as being `secret`: the compiler will emit an error if a
conditional depends on a `secret` value. Such a mechanism is not
needed in Usuba, where conditionals on non-static values cannot be
expressed at all.

Because of the exotic types introduced when dealing with public-key
cryptography (first-order polynomials, very large integers of some
finite fields...), CAO applies several optimizations to its programs
before generating C code. For instance, C compilers' strength
reduction pass (replacing "strong" operations by "weaker" once, for
instance replacing a multiplication by several additions) will not
handle finite field arithmetics, but CAO's does.

CAO also tries to offer a way for programs to be resilient against
side-channel attacks, by providing an operator `?`, which introduces
fresh randomness. However, since introducing randomness throughout the
computation is not proven to be secured [5], CAO uses Hidden Markov
Models to try and break it. Usuba integrates recent progresses in
provable countermeasures against side-channel attacks [6], thus
providing a stronger security.


### FaCT

FaCT [7] is a C-style DSL for cryptography, which generates provably
constant-time LLVM Intermediate Represendation (IR) code. FaCT allows
developpers to write cryptographic code without having to resort to
programming "tricks" to make it constant-time, like masking
conditionals, or using flags instead of early-return. Those tricks
obfuscate the code, and an error can lead to devastating security
issues [8].

Instead, FaCT allows the developpers to write C-style code, where
secret values are annotated with the keyword `secret`. The compiler
then takes care of transforming any non constant-time idiom into
constant-time ones. It thus automatically detects and secures unsafe
early routine terminations, conditional branches, and memory accesses.

FaCT's transformations are proven to produce constant-time
code. However, because LLVM could still introduce vulnerability (for
instance by optimizing branchless statements with conditional
branches), they rely on dudect [9] to ensure that the final assembly
is empirically constant-time. Moreover, FaCT has a notion of _public
safety_ to ensure the memory safety as well as the lack of buffer
overflows/underflows and undefined behaviors. FaCT ensures the public
safety of a program using the Z3 SMT solver.

FaCT and Usuba differ in their use-cases. FaCT targets protocols
(_e.g._, TLS) and asymmetric primitives (_e.g._, RSA), whereas Usuba
focuses on symmetric cryptography. Furthermore, Usuba is higher-level
than FaCT: the later can almost be straight-forwardly compiled to C
and requires the developer to explicitely use vector instructions when
he wants them, while Usuba requires more normalization (especially
when automatically bitslicing programs) and automatically generates
SIMD codes. Both languages however achieve similar performances as
hand-tuned codes, even though Usuba implements several optimizations
itself while FaCT mostly relies on LLVM's optimizer.


### dSCADL

dSCADL [10,11] is a **d**ata flow based **S**ymmetric
**C**ryptographic **A**lgorithm **D**escription **L**anguage. The
language is meant to allow developper to write symmetric primitives
with a simple language, which should be intuitive to use, while still
offering good performances. 

dSCADL's variables are either scalars or cubes. Scalars are integers,
either used in the control flow like loop indices, or to represent any
mono-dimensional (potentially secret) data. Cubes by opposition are
used for multi-dimensional data, for instance to represent AES's state
as a matrix. To compare with Usuba's types, scalars encompass Usuba's
`Nat` and <code>u<i>m</i></code>, while cubes are similar to Usuba's
arrays. dSCADL provides operators to manipulate cubes, like point-wise
arithmetic and substitution, matrix multiplication, row and column
concatenation. Those cube operators allow dSCADL's AES implementation
to be higher level that Usuba's, as MixColumn (the matrix
multiplication) is done with a simple operator, expanded by the
compiler to lower-level operations.

However, dSCADL compiles to OCaml code and then links with a runtime
library, making it much slower than Usuba, which compiles directly to
C. In the paper presenting dSCADL [10], better performances for dSCADL
than Cryptol are reported, but it is unclear how fair the benchmark
is, since in the code they provide [11], the Cryptol codes include
correctness proofs which are done using a SMT-solver at compile-time
rather than at run-time.

Finally, dSCADL allows the use of secret values in conditionals, as
well as lookup in tables at secret indices, making the produced codes
potentially vulnerable to timing attacks.


### ADSLFC

Giovanni Agosta and Gerardo Pelosi [12] proposed a domain specific
language for cryptography. This DSL was not named, but we shall call
it ADSLFC (**A** **D**omain **S**pecific **L**anguage **F**or
**C**ryptography) in the following, for simplicity. ADSLFC is based on
Python in the hope that developers will find it easy to use, and will
easily assimilate the syntax (unlike Cryptol for instance, which they
deem "much harder to understand for a non-specialized user [than C]"
in [12], Section 4). Finally, ADSLFC is compiled to Python (but the
authors mention as future work that they would like to compile to C as
well), in order to allow for and easy interoperability with C/C++.

The base type of ADSLFC is `int`, which represents a signed integer of
unlimited precision. This type can then be refined by specifying its
size (`int.32` for a 32-bit integer for instance), or made unsigned
using the `u.` prefix. The TEA cipher for instance takes as input
values of type `u.int.32`, similar to Usuba's `u32`.  Vectors can be
used to represent either arrays (possibly multi-dimentional) of
integers or polynomials. To deal with finite field arithmetics, a `mod
x` (where `x` is a polynomial) anotation can be added to a type,
meaning that operations on this type are done modulo `x`.

Standard arithmetic operators are provided for integers (addition,
multiplication, exponentiation...), as well as bitwise operators, and
an operator to call a S-box (represented as a vector used as a lookup
table). Additional operators are available to manipulate vectors:
concatenation, indexing, replication, transposition... The features of
the language are thus similar to Usuba's, with added constructions to
deal with finite field arithmetics and polynomials. 

Finally, ADSLFC was designed to allow fast prototyping and
development, with seemingly no regard for performances, unlike Usuba,
for which speed is a crucial aspect. No performances numbers are
provided in the original paper [12], but since ADSLFC compiles to
Python, and no performance-related optimizations are mentioned, we can
expect the generated codes to be slower than Usuba's highly optimized
C codes.


### BSC

BSC [13] is a direct ancestor of Usuba. The initial design of Usuba
[14], which did not support m-slicing, was largely inspired by BSC:
lookup tables and permutations originated from BSC, and the types
(booleans and vectors of booleans) were similar. Usuba's tuples are
also inspired from BSC's vectors: in BSC, a vector of size _n_ can be
destructed into two vectors of size _i_ and _j_ (such that _i + j =
n_) using the syntax `[a # b] = c` (where `a`, `b` and `c` are vectors
of size `i`, `j` and `n`), which is equivalent to Usuba's `(a, b) =
n`. Finally, Usuba borrows from BSC the algorithm to convert lookup
tables into circuits.

Usuba improves upon BSC by expanding the range of optimizations beyond
mere copy propagation. Furthermore, BSC does not offer loop
constructions, and inlines every function, producing unnecessary large
codes. Benchmarking BSC against Usuba on DES (the only available
example of BSC code) shows that Usuba is about 10% faster, mainly
thanks to its scheduling algorithm.

Similarly, m-slicing was only introduced almost a decade after BSC
[14,15], and most SIMD extensions post-date BSC: SSE instructions sets
were developped between 1999 (SSE) and 2008 (SSE4.2), AVX dates from
2008, AVX2 from 2012 and AVX512 from 2016. Usuba shows that both
m-slicing and vectorization are nonetheless compatible with the
programming model pionered by BSC.


---

## References

[1] J. R. Lewis, B. Martin, [Cryptol: high assurance, retargetable crypto development and validation](https://cryptol.net/files/cryptol_whitepaper.pdf), 2003.

[2] L. De Moura, N. Bjørner, [Z3: An efficient SMT solver](https://link.springer.com/content/pdf/10.1007%2F978-3-540-78800-3_24.pdf), TACAS, 2008.

[3] M. Barbosa _et al._, [First Steps Toward a Cryptography-Aware Language and Compiler](https://eprint.iacr.org/2005/160.pdf), 2005.

[4] M. Barbosa _et al._, [Compiling CAO: From Cryptographic Specifications to C Implementations](https://haslab.uminho.pt/pfsilva/files/post14-ack.pdf), POST, 2014.

[5] E. Oswald, M. Aigner, [Randomized Addition-Subtraction Chains as a Countermeasure against Power Attacks](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.125.2275&rep=rep1&type=pdf), CHES, 2001.

[6] E. Prouff, M. Rivain, [Masking against Side-Channel Attacks: a Formal Security Proof](https://www.iacr.org/archive/eurocrypt2013/78810139/78810139.pdf), EuroCrypt, 2013.

[7] S. Cauligi _et al._, [FaCT: A DSL for Timing-Sensitive Computation](https://ranjitjhala.github.io/static/fact_dsl.pdf), PLDI, 2019.

[8] N. J. AlFardan, K. G. Paterson, [Lucky Thirteen: Breaking the TLS and DTLS Record Protocols](https://www.ieee-security.org/TC/SP2013/papers/4977a526.pdf), IEEESSP, 2013.

[9] O. Reparaz _et al._, [Dude, is my code constant time?](https://eprint.iacr.org/2016/1123.pdf), DATE, 2017.

[10] J. Rao _et al._, [dSCADL: A Data Flow based Symmetric Cryptographic Algorithm Description Language](https://ieeexplore.ieee.org/document/8989331), CCET, 2019.

[11] J. Rao, [dSCAL github](https://github.com/rynxr/SCADL), accessed 08/04/2020.

[12] G. Agosta, G. Pelosi, [A Domain Specific Language for Cryptography](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.206.5258&rep=rep1&type=pdf), FDL, 2007.

[13] T. Pornin, [Implantation et optimisation des primitives cryptographiques](https://www.bolet.org/~pornin/2001-phd-pornin.pdf) (implementation and optimization of cryptographic primitives), PhD thesis, 2001.

[14] D. Mercadier _et al._, [Usuba: Optimizing & Trustworthy Bitslicing Compiler](https://hal.archives-ouvertes.fr/hal-01657259/document), WPMVP@PPoPP, 2018.

[15] R. Könighofer, [A Fast and Cache-Timing Resistant Implementation of the AES](https://link.springer.com/content/pdf/10.1007/978-3-540-79263-5_12.pdf), CT-RSA, 2008.

[16] E. Käsper, P. Schwabe, [Faster and Timing-Attack Resistant AES-GCM](https://www.esat.kuleuven.be/cosic/publications/article-1261.pdf), CHES, 2009.
