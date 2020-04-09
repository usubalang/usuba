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
their ciphers using a combination of english (too ambiguous) and
pseudo-codes (ill-suited to describe mathematical operations) while
providing reference implementations in C (too low-level). Thus,
Cryptol is a programming language for speficying cryptographic
algorithms, from protocols and modes of operations down to
primitives. It covers a broder range than Usuba, which focuses solely
on primitives. 

While Usuba programs are designed to act as specifications of ciphers,
they remain implementations, in the sense that Usuba's operators and
constructions are driven by existing CPU architectures. Cryptol on the
other hands removes the architectural aspects altogether, and strives
to offer very high-level abstractions. As such, Cryptol natively
supports polynomials and field arithmetics, allowing it to express
more naturally than Usuba ciphers like AES. For instance, AES's
multiplication in GF(2<sup>8</sup>) modulo the irreducible polynome
<i>x<sup>8</sup> + x<sup>4</sup> + x<sup>3</sup> + x + 1</i> can be
written in Cryptol as:

```
irreducible = <| x^^8 + x^^4 + x^^3 + x + 1 |>

gf28Mult : (GF28, GF28) -> GF28
gf28Mult (x, y) = pmod(pmult x y) irreducible
```

Cryptol basic types are bitvectors, similar to Usuba's
<code>u<i>n</i></code> types, which can be grouped in tuples, similar
to what Usuba offers. However, where tuples are at the core of Usuba's
programs, Cryptol's main construction is sequences, which, unlike
tuples, contains elements of the same type. Several builtins allow to
construct and manipulate sequences: comprehensions, enumerations,
infinite sequences, indexing and appending operators. Furthermore, in
Cryptol, bitvectors can be specified using boolean sequences, whereas
Usuba does not allow bit-manipulation of words, which would not be
efficient on most CPU architectures. For instance, the expression

```
[True, False, True, False, True, False]
```

constructs the integer 42, and the indexing operation `@` can be with
the same effect on the literal 42 or on this sequence: `42 @ 2`
returns `True`, like `[True, False, True, False, True, False] @ 2`
does.


The Cryptol language is much richer than Usuba, and include features
like records, strings, user-defined types, predicates, modules,
first-class type variables and lambda expressions. Focusing on
symmetric primitives in Usuba, we strived to keep the language as
simple (yet expressive) as possible, and did not require those
constructions, which may prove useful when specifying asymmetric
primitives, protocols and modes of operation.


Another aspect of Cryptol is that it allows programmers to write
correctness properties within their codes, and asserts their validity
using SMT solvers (Z3 [2] by default). An example of such a property
is found in Cryptol's reference AES implementation:

```
property AESCorrect msg key = aesDecrypt (aesEncrypt (msg, key), key) == msg
```

which states that decrypting a ciphertext encrypted with AES yield the
original plaintext. When the SMT solver fails to prove properties in
reasonable time, Cryptol can to random testing: it tests the property
on a given number of random inputs and observes if it holds. Usuba is
weaker than Cryptol on that regard: while it performs some checking
(it does exhaustive testing on lookup tables and their corresponding
circuits for instance, and can ensure the correctness of some
optimization passes using translation validation), it does not offer
constructions to express and validate properties.

Overall, Cryptol is much more complete than Usuba, in the sense that
it can be used for any cryptographic algorithm, while Usuba is
restricted to symmetric primitives. Another major difference, is that
while Cryptol's main goal is to provide a language for specifying and
verifying cryptography, Usuba focuses on performances and offer only
high-level constructions that it is able to compile to efficient
code. Furthermore, the automatic slicing and masking done by Usuba are
missing in Cryptol.


### CAO

CAO [3,4] is another domain-specific programming language (DSL) for
cryptography, which focuses on primitives. Like Usuba, CAO started
from the observation that writing primitives in C either leads to poor
performances because the C compiler is unable to optimize them well,
or to un-maintainable code because optimizations are done by hand.

The level of abstractions provided by CAO is similar to Usuba, unlike
Cryptol, which provided very high-level mathematical-oriented
constructions: functions, `for` loops, standard C operators (`+`, `-`,
`*`, ...), ranges to index multiples elements of a vector,
concatenation of vectors... CAO also has a `map` builtin, which
describes mapping from inputs to outputs of a permutation, in a style
similar to Usuba's `perm` nodes.

However, whereas Usuba's main target is symmetric cryptography, CAO is
more oriented toward asymmetric (public-key) cryptography, and thus
offers many abstractions for finite field arithmetics. For instance,
one can define a type `f` for AES's values like:

```
typedef f := gf[2 ** 8] over $ ** 8 + $ ** 4 + $ ** 3 + $ + 1
```

AES's Mixcolumn can then be written in a more mathematical way in CAO
than in Usuba: while the latter required the programmer to manually
provide equations, the former allows the use of arithmetic operators
to compute in GF(2<sup>8</sup>).

To support public-key cryptography, CAO also provides conditionals in
the language. However, to prevent timing attacks, variables can be
annotated with `secret`: the compiler will emit an error if a
conditional branch is done on a `secret` value. Such a mechanism is
not needed in Usuba, where branches on non-static values cannot be
expressed at all.

Because of the exotic types introduced when dealing with public-key
cryptography (first-order polynomials, very large integers of some
finite fields...), CAO applies some optimizations to its programs
before generating C code. For instance, C compilers' strength
reduction pass (replacing "strong" operations by "weaker" once, for
instance replacing a multiplication by several additions) will not
handle finite field arithmetics, but CAO's does.

CAO also tries to offer a way for programs to be resilient against
side-channel attacks, by providing an operator `?`, which introduces
fresh randomness. However, introducing randomness throughout the
computation [5] is not proven to be secured. CAO thus uses Hidden
Markov Models to try and break it. This is weaker than Usuba's
automatic masking, but was done years provable security against
side-channel attacks became a must [6]. 


### FaCT

FaCT [7] is a C-style DSL for cryptography, which generates
proved-constant-time LLVM Intermediate Represendation (IR) code. FaCT
allows developpers to write cryptographic code without having to
resort to programming "tricks" to make it constant-time, like masking
conditionals, or using flags instead of early-return. Those tricks
obfuscate the code, and implementing them wrong can lead to unexpected
weaknesses [8].

Instead, FaCT allows the developpers to write C-style code, where
secret values are annotated with the keyword `secret` in their
definition. The compiler then takes care of transforming any
non-constant-time idioms using those values into constant-time
ones. Those idioms include early routine termination, conditional
branching, and memory accesses. 

FaCT's transformations which remove vulnerable constructions are
proven to produce constant-time code. However, because LLVM could
still introduce vulnerability (for instance by optimizing branchless
statements with conditional branches), they rely on dudect [9] to
ensure that the final assembly is empirically constant-time.

While FaCT achieves the same result as Usuba, constant-time
cryptographic codes, their use-cases are different. The constructions
that FaCT makes constant-time are found in protocols (_eg._ TLS) or
asymmetric primitives (_eg._ RSA), whereas Usuba focuses on symmetric
cryptography. Furthermore, Usuba is higher-level than FaCT: the later
can almost be straight-forwardly compiled to C, which Usuba requires
more normalization, especially when automatically bitslicing
programs. Both languages however achieve similar performances as
hand-tuned codes, even though Usuba implements several optimizations
itself while FaCT mostly relies on LLVM's optimize.


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
C. In the paper presentnig dSCADL [10], better performances for dSCADL
than Cryptol are reported, but it is unclear how fair the benchmark
is, since in the code they provide [11], the Cryptol codes include
correctness proofs which are done using a SMT-solver.

Finally, dSCADL allows the use of secret values in conditionals, as
well as lookup in tables at secret indices, making the produced codes
potentially vulnerable to timing attacks.


### A Domain Specific Language for Cryptography

Giovanni Agosta and Gerardo Pelosi proposed in [12] a domain specific
language for cryptography. This DSL was not named, but we shall call
it ADSLFC (**A** **D**omain **S**pecific **L**anguage **F**or
**C**ryptography) in the following, for simplicity. ADSLFC is based on
Python in the hope that developers will find it easy to use, and will
easily assimilate the syntax (unlike Cryptol for instance, which uses
haskell-like syntax, which may be harder to understand for most
programmers). Finally, ADSLFC is compiled to Python (but the authors
mention as future work that they would like to compile to C as well),
in order to allow for and easy interoperability with C/C++.

The base type of ADSLFC is `int`, which represents a signed integer of
unlimited precision. This type can then be refined by specifying its
size (`int.32` for a 32-bit integer for instance), or made unsigned
using the `u.` prefix. The TEA cipher for instance takes as input
values of type `u.int.32`, similar to Usuba's `u32`.  Vectors can be
used to represent either (possibly multi-dimentional) arrays of
integers or polynomials. To deal with finite field arithmetics, a `mod
x` anotation can be added to a type, meaning that operations on this
type are done modulo `x`.

Standard arithmetic operators are provided for integers (addition,
multiplication, exponentiation...), as well as bitwise operators, and
an operator to call a S-box (represented as a vector used as a lookup
table). Additional operators are available to manipulate vectors:
concatenation, indexing, replication, transposition... The features of
the language are thus similar to Usuba's, with added constructions to
deal with finite field arithmetics and polynomials. No example of
ADSLFC using those constructions are available, but AES and most
public-key ciphers should be written in a more natural way in ADSLFC
than in Usuba.

Finally, ADSLFC was designed to allow fast prototyping and
development, with seemingly no regard for performances, unlike Usuba,
for which speed is a crucial aspect. No performances numbers are
provided in [12], but since ADSLFC compiles to Python, and no
optimizations are mentioned in [12], we can expect the generated codes
to be slower than Usuba's highly optimized C codes.


### BSC

BSC [13] is the only bitslicing compiler (besides Usuba) we know
of. The initial design of Usuba [14], which did not support m-slicing
was largely inspired from BSC: lookup tables and permutations reused
BSC's syntax, and the types were similar: booleans are arrays. Usuba's
tuples are also inspired from BSC's vectors: in BSC, a vector of size
_n_ can be destructed into two vectors of size _i_ and _j_ (such that
_i + j = n_) using the syntax `[a # b] = c` (where `a`, `b` and `c`
are vectors of size `i`, `j` and `n`), which is equivalent to Usuba's
`(a, b) = n`. Finally, we reused in Usuba the algorithm used by BSC to
convert lookup tables into circuits.

BSC, however, remained a basic prototype and does not perform any
optimization but copy propagation (removing assigment of a variable to
another). Furthermore, BSC does not offer loop constructions, and
inlines every function, producing unnecessary large
codes. Benchmarking BSC against Usuba on DES shows that Usuba is about
10% faster, mainly thanks to its scheduling algorithm.

BSC does not support m-slicing, which is to be expected since
m-slicing was introduced by [14] and [15], 8 and 9 years after the
development of BSC.


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
