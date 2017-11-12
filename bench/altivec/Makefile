DES = samples/usuba/des.ua

all:
	cd ../..; \
	 ./usubac -arch altivec -bench -o bench/altivec/C/bench-vector-ortho.c $(DES); \
	 ./usubac -arch std     -bench -o bench/altivec/C/bench-u64-ortho.c $(DES); \
	 ./usubac -arch altivec -bench -no-ortho -o bench/altivec/C/bench-vector-no-ortho.c $(DES); \
	 ./usubac -arch std     -bench -no-ortho -o bench/altivec/C/bench-u64-no-ortho.c $(DES) 

clean:
	rm -f C/*.c
