Custom headers for SKIVA backed
---

## TL;DR

If you just need to run your SKIVA code, include `FAME.h` and define
the following configuration macros:

 - `TI`: the number of shares of the masking (1, 2, 4)

 - `FD`: the number of redundant slices (1, 2, 4)

 - `PIPELINED`: if defined, uses temporal redundancy

 - `CORRECT`: if defined, does fault correction by majority voting

 - `X86`: if defined, loads macros to execute on X86 (ie, without
   custom hardware)

 - `NO_CUSTOM_INSTR`: if defined, doesn't use custom instructions

 - `GCC_SUPPORT`: if defined, uses normal C instructions instead of
   custom ones, so that gcc can optimize them as it pleases. This
   simulates (ish) what would happen if we patched gcc to be aware
   of the semantics of our new instructions.

 - `CHEATY_CUSTOM`: if defined, uses normal assembly instructions
   instead of custom ones. This is just a trick to benchmark more
   realistic performances: the custom instructions are buggy
   (performance-wise) on the benchmark board, and using normal
   instruction instead gives more realistic performances.

 - `COPROC_RAND`: if defined, assumes the presence of a coprocessor
   generating 32 random bits every `RANDOM_DELAY` cycles.

 - `RANDOM_DELAY`: see `COPROC_RAND`

 - `CST_RAND`: if defined, assumes the presence of a coprocessor
   generating random bits faster than we consume them (ie, we can
   just read from a register without worrying ourselves with the
   availability of new random bytes).
    

## Organization of the headers

The headers are organized as follows. Note that the order in which
each header is imported matters: `FAME_TI.h` relies on `FAME_rand.h`
and `FAME_FD.h`, which relies on `FAME_instrs.h`.


 - `FAME.h`: the "entry point" header, load the other headers as
   needed, to eventually have the following macros defined: `AND`,
   `OR`, `NOT`, `XOR`, which are all you need to run AES. It also
   defines macros corresponding to all custom instructions (`SUBROT`,
   `FTCHK`, ...), as well as the `RAND` macro, and specific macros
   for each TI/FD (`TI_AND_2`, `TI_AND_4`, ...).
   
 - `FAME_instrs.h`: the "entry points" for the definition of the
   custom instructions. Depending on the configuration macros, this
   will either emulate them in software or use inline assembly to
   call the custom instructions.
   
   + `custom_instrs_soft.h`: defines the "advanced" custom
     instructions (TIBS, SUBROT, FTCHK) using software emulation.
     
   + `custom_instrs_hard.h`: defines the "advanced" custom
     instructions (TIBS, SUBROT, FTCHK) using inline assembly (and
     therefore produces code that calls the real instructions).
     
 - `FAME_rand.h`: defines the `RAND` macro.
   
 - `FAME_FD.h`: defines the macros `FD_AND_x`, `FD_OR_x`, `FD_XOR_x`,
   `FD_NOT_x` for x in 1, 2, 4.

 - `FAME_TI.h`: defines the macros `TI_AND_x`, `TI_OR_x`, `TI_XOR_x`,
   `TI_NOT_x` for x in 1, 2, 4.


## Testing

You can test that the header `FAME.h` is correct by running
`test_FAME.c`. This will test all the custom instructions for all
values of FD and TI (1, 2, 4). To compile and run it on x86:

    clang -Wall -Wextra test_FAME.c -D TI=1 -D FD=1 -D X86 -o test_FAME
    ./test_FAME

To compile it for SKIVA, you'd typically use our patch gaisler-gcc:

    sparc-gaisler-elf-gcc -Wall -Wextra test_FAME.c -D TI=1 -D FD=1 -o test_FAME
    
And then load it on the board and run it.

If everything works as expected, it should only print:

    Starting test.
    All right
