
Compile and run with `./compile.pl`

`UA_MACRO`: usuba code with macros ([here](verif/aes/bench_aes/aes.c#L373))
`UA_KIVI`: kivi round with Usuba glue ([here](verif/aes/bench_aes/aes.c#L488))
`full_kivi` : copy-past (almost) AES from Kivilinna's code

`EXPANDED`: takes 8 parameters instead of 1 for the input (to be compatible with Kivi runtime).
`INDIRECT`: calls an intermediate function to suffer the same penalty as Kivilinna 
`DIRECT`: not `INDIRECT` (ie, standard, but I needed to name it)

Initial results:
```
      ua_KIVI_DIRECT_NOEXP : 714.90  [ 718.58, 711.22 ]
 ua_KIVI_INDIRECT_EXPANDED : 716.97  [ 717.89, 716.05 ]
                 full_kivi : 718.87  [ 720.33, 717.41 ]
   ua_MACRO_INDIRECT_NOEXP : 720.26  [ 717.38, 723.14 ]
     ua_MACRO_DIRECT_NOEXP : 720.44  [ 719.11, 721.78 ]
   ua_KIVI_DIRECT_EXPANDED : 720.63  [ 719.48, 721.79 ]
    ua_KIVI_INDIRECT_NOEXP : 732.25  [ 735.39, 729.10 ]
  ua_MACRO_DIRECT_EXPANDED : 747.90  [ 749.50, 746.30 ]
ua_MACRO_INDIRECT_EXPANDED : 753.85  [ 755.25, 752.45 ]
```
