A small experiment to see how CSE, CP, CF reduces code size of bitsliced codes.

Results (ran on the 16.06.2020):


|       cipher |   # with    |  # without  |  factor  |
|--------------|-------------|-------------|----------|
|       ACE-bs |      54,911 |     223,872 |  4.08    |
|       AES-bs |      25,168 |      31,776 |  1.26    |
|     Ascon-bs |      24,624 |      47,488 |  1.93    |
|     Clyde-bs |      13,655 |      30,912 |  2.26    |
|          DES |       8,448 |      12,224 |  1.45    |
|      Gift-bs |      16,937 |      62,240 |  3.67    |
|     Gimli-bs |      26,499 |      57,024 |  2.15    |
|    Photon-bs |      47,248 |     172,688 |  3.65    |
|      Present |       8,992 |      11,040 |  1.23    |
|  Pyjamask-bs |      25,188 |     183,040 |  7.27    |
| Rectangle-bs |       6,464 |       8,128 |  1.26    |
|    Skinny-bs |      29,761 |     191,680 |  6.44    |
|     Spongent |      87,024 |     156,897 |  1.80    |
| Subterranean |      10,296 |      19,034 |  1.85    |

Factor total: 2.88
