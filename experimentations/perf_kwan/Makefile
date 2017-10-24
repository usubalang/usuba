all:
	clang -O3 -march=native kwan_bench.c -o kwan
	clang -O3 -march=native des_bench.c -o des
	clang -O3 make_input.c -o make_input

clean:
	rm -f kwan make_input
	rm -f input.txt output.txt
	rm -f *~
