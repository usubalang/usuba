Usuba
===

Usuba is a programming language to write bitsliced code. It compiles
optimized to C code (+ intrinsics).

---

## Presentation

Go to our [website](https://usubalang.github.io/usuba/) to find more about Usuba.

In particular, the following blog articles are a good introduction:

  - [Usuba - The Genesis](https://usubalang.github.io/usuba/2020/01/07/usuba-genesis.html) explains the motivation behind Usuba.

  - [Bitslicing](https://usubalang.github.io/usuba/2020/01/14/bitslicing.html) presents the bitslicing technique, which is the basis of Usuba.


To go into more details, read our published papers about Usuba:

  * Darius Mercadier, Pierre-Evariste Dagand. [Usuba: High-Throughput and Constant-Time Ciphers, by Construction](https://dariusmercadier.com/assets/documents/usuba-pldi19.pdf), PLDI 2019.

  * Darius Mercadier, Pierre-Évariste Dagand, Lionel Lacassagne, Gilles Muller, [Usuba, Optimizing & Trustworthy Bitslicing Compiler](https://dariusmercadier.com/assets/documents/usuba-wpmvp18.pdf), WPMVP 2018.


Finally, some additional resources that could be useful:

  * Timeless: [One-page presentation of Usuba](https://dariusmercadier.com/assets/documents/overview-usuba.pdf)

  * June 2019: [Technical presentation of Usuba @PLDI'19](https://dariusmercadier.com/assets/documents/slides-pldi-jun19.pdf)

  * February 2019: [High-level presentation of Usuba @Inria's Junior Seminar](https://dariusmercadier.com/assets/documents/inria-junior-seminar-feb19.pdf)



## Development setup

Usuba is written in OCaml. To compile and run Usuba, you will need to install [Opam](https://opam.ocaml.org/doc/Install.html), the OCaml package manager, on your system.

If you have never used Opam before, you need to initialize it (otherwise, skip this step):

```
$ opam init
```

To automatically bring up its dependencies,  setup a local Opam distribution, using the following commands:

```
$ opam switch create . --deps-only --with-doc --with-test
$ eval $(opam env)
```

To build the compiler, type:

```
$ make
```

If everything goes well, you can interact with the compiler with

```
$ ./usubac -help
```

To run all the tests, type:

```
$ make test
```

A minimal development & benchmark environment is specified in the
Docker file `./docker/Dockerfile` starting from a `Bullseye` Debian
distribution. You can either use this image through

```sh
cd docker; make build && make bench
```

or take inspiration from it to reproduce the build environment on your
local machine.

## A few examples

A few examples of Usuba codes:
 * [bitslice DES](https://github.com/usubalang/examples/samples/usuba/des.ua) (and the generated [C code](https://github.com/usubalang/examples/samples/C/des.c)),
 * [bitslice AES](https://github.com/usubalang/examples/samples/usuba/aes.ua) (and the generated [C code](samples/C/aes.c)),
 * [n-slice AES](https://github.com/usubalang/examples/samples/usuba/aes_kasper.ua) (and the generated [C code](https://github.com/usubalang/examples/samples/C/aes_kasper.c)),
 * [32-slice Serpent](https://github.com/usubalang/examples/samples/usuba/serpent.ua) (and the generated [C code](https://github.com/usubalang/examples/samples/C/serpent.c)),
 * [32-slice Chacha20](https://github.com/usubalang/examples/samples/usuba/chacha20.ua) (and the
   generated [C code](https://github.com/usubalang/examples/samples/C/chacha20.c)).


If you are familiar with Perl, an easy way to see the compiler an
action is to look at the scripts in the
directory [checks/correctness](checks/correctness) that compile a few
Usuba codes, run them and make sure they produce the expected results.


## Compiling

To compile an Usuba file (`.ua`), you need to invoke `./usubac
<options> <source.ua>` (the Usuba source file must be the last argument).
I strongly recommand always using the flag `-no-sched` when doing pure
bitslicing (it disables a few experimental options, and reduces the
amount of code loaded). The option `-no-arr-entry` might also be
usefull for small functions (combined with `-no-arr`).
The list of flags can be obtained by running `./usubac -help`.

For instance, to compile a bitslice AES:

    ./usubac -B -o aes.c -no-sched examples/samples/usuba/aes.ua

The C code generated by Usuba uses macros to achieve genericity. This
macros are loaded with the instruction `#include "XXX.h"` at the
begining of the C files generated, where `XXX` is one of `STD`, `SSE`,
`AVX` (which should be `AVX2`), `AVX512`, `Neon`, `AltiVec`. Those
headers are located in the directory [arch](arch).

## For contributors

If you change some types in `Config.conf` or `Usuba_AST`, you should create a branch for these changes only since they're not supposed to change the behaviour of passes. Once this is done, update the `unit_tests` submodule with:

-
   ```sh
   ./scripts/run-selected.sh -- -dump-steps ast -dump-steps-dir unit_tests/rsc
   ```
  This will populate the `rsc` dir
- Go in `unit_tests` and execute:
   ```sh
   ./generate.sh --steps-dir rsc
   ```

This way, the unit_tests will be able to check that your work on the rest of usuba doesn't break the expected behaviour and you can start working on a new branch with algorithmic changes.
