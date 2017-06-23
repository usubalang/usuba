all:
	clang -O3 -march=native test_kwan.c -o kwan
	clang -O3 -march=native des_run.c -o des_run
	clang -O3 make_input.c -o make_input

clean:
	rm -f kwan make_input
	rm -f input.txt output.txt
	rm -f *~
