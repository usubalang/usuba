I used this directory to work on SIMD orthogonalization.
I know have a working algorithm that you can find in `ortho.c`,
or alternatively in `arch/AVX.h`.

This directory contains now the code to benchmark the execution
time of both scalar and SIMD orthogonalization. To do so, run:

    make
    ./ortho       <- that's the scalar ortho
    ./simd        <- that's the SIMD ortho

It will yield the CPU cycles needed to perform an orthogonalization.


For your curiosity, if you want to convince yourself that the SIMD
orthogonalization works, you can run the function `check_ortho()`
in the main of `ortho.c` (the line is commented for now), and you'll
see the transposition of a triangular matrix (thanks Lionel for the 
idea!). Caution: to be readable, your terminal needs to be able
to display 256 characters per line! (so... reduce the font size!).
