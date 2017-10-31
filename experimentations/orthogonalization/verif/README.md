This folder contains two versions of DES: one with a 4x(64x64) orthogonalization
(des-orig.c), and another one with a 256x256 orthogonalization (des-new.c).
The script `run.pl`checks whether they both produce the same result. If so, our
"new" orthohonalization is correct.

Note that you could replace `input.txt` with any file, and the test should still
pass. (provided the size in byte of `input.txt` is a multiple of 1024*8).
