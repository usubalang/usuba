Kivilinna's runtime with Usuba primitive code.  

All this lines should yield `OK` (with some warnings):  

```
clang -D KIVI_ORIG -Wall -Wextra -I . -O3 -march=native -I ../../arch -o main_verif main_verif.c usuba-kivi-mix/{stream.c,aes.c,aes_asm_bitslice_avx.S} && ./aes_ctr.pl && ./main_verif && diff out_c.txt out_pl.txt && echo "OK"
clang -D USUBA -Wall -Wextra -I . -O3 -march=native -I ../../arch -o main_verif main_verif.c usuba-kivi-mix/{stream.c,aes.c,aes_asm_bitslice_avx.S} && ./aes_ctr.pl && ./main_verif && diff out_c.txt out_pl.txt && echo "OK"
clang -D KIVI -Wall -Wextra -I . -O3 -march=native -I ../../arch -o main_verif main_verif.c usuba-kivi-mix/{stream.c,aes.c,aes_asm_bitslice_avx.S} && ./aes_ctr.pl && ./main_verif && diff out_c.txt out_pl.txt && echo "OK"
```

`KIVI_ORIG` : Kivilinna's code, as is. (see [kivi_orig.S](verif/aes/usuba-kivi-mix/kivi_orig.S)).  
`USUBA` : Usuba code, fixed by hand (stack alignment, return values on xmm0-7). (see [usuba.s](verif/aes/usuba-kivi-mix/usuba.s)).  
`KIVI` : Kivi round, inside a C loop, fixed by hand (return values on xmm0-7). (see [kivi.s](verif/aes/usuba-kivi-mix/kivi.s))  


The base for `usuba.s` and `kivi.s` was generated with `clang -O3 -march=native -I ../../arch -D MACRO -S sse-experimental/aes.c` (`s/MACRO/KIVI/` for `kivi.s`).
