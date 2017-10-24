all:
	cp ../../bench/input.txt .
	cd ../..; \
	  ./usubac -arch avx -o experimentations/maqao/des.c samples/usuba/des.ua
	clang -O3 -march=native -I../../arch -o des des.c

clean:
	rm -f *.txt
	rm -f des.c
	rm -f des
