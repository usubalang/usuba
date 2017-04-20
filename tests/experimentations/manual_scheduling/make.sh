clang -O3 test_kwan.c -o kwan
clang -O3 test_usuba.c -o usuba
clang -O3 test_uak_64std_ortho.c -o old_usuba
clang -O3 make_input.sh -o make_input
./make_input
