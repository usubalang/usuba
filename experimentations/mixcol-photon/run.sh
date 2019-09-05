#!/bin/bash

cd ../..
./usubac -V -o experimentations/mixcol-photon/mixcol.c experimentations/mixcol-photon/mixcol.ua
./usubac -V -o experimentations/mixcol-photon/mixcol-u8.c experimentations/mixcol-photon/mixcol-u8.ua
cd experimentations/mixcol-photon
gcc -Wall -Wextra -I ../../arch -o main main.c
gcc -Wall -Wextra -I ../../arch -o main-u8 main-u8.c
./main
./main-u8
