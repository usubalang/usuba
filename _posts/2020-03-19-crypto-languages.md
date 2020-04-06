---
layout: post
title: Languages for cryptography
date: "2020-03-19 00:00:00"
description: Presentation of some languages cryptography, and their differences/similarities with Usuba
lang: en
locale: en_US
author: Darius Mercadier
excerpt: 
comments: false
hidden: true
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
side-channel attacks became a thing [6]. 


### FaCT

### HaCL*

### Cryptoverif

### EasyCrypt

### Jasmin?

### Vale?

### qasm?

### CPPL ?

### BSS (pornin)



---

## References

[1] J. R. Lewis, B. Martin, [Cryptol: high assurance, retargetable crypto development and validation](https://cryptol.net/files/cryptol_whitepaper.pdf), 2003.

[2] L. De Moura, N. Bjørner, [Z3: An efficient SMT solver](https://link.springer.com/content/pdf/10.1007%2F978-3-540-78800-3_24.pdf), TACAS, 2008.

[3] M. Barbosa _et al._, [First Steps Toward a Cryptography-Aware Language and Compiler](https://eprint.iacr.org/2005/160.pdf), 2005.

[4] M. Barbosa _et al._, [Compiling CAO: From Cryptographic Specifications to C Implementations](https://haslab.uminho.pt/pfsilva/files/post14-ack.pdf), POST, 2014.

[5] E. Oswald, M. Aigner, [Randomized Addition-Subtraction Chains as a Countermeasure against Power Attacks](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.125.2275&rep=rep1&type=pdf), CHES, 2001.

[6] E. Prouff, M. Rivain, [Masking against Side-Channel Attacks: a Formal Security Proof](https://www.iacr.org/archive/eurocrypt2013/78810139/78810139.pdf), EuroCrypt, 2013.
