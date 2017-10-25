DES = samples/usuba/des.ua

all:
	cd ../..; \
	 ./usubac -arch neon -bench -o bench/neon/C/bench-neon-ortho.c $(DES); \
	 ./usubac -arch std -bench -o bench/neon/C/bench-u64-ortho.c $(DES); \
	 ./usubac -arch neon -bench -no-ortho -o bench/neon/C/bench-neon-no-ortho.c $(DES); \
	 ./usubac -arch std -bench -no-ortho -o bench/neon/C/bench-u64-no-ortho.c $(DES) \
#	 ./usubac -arch std  -o bench/neon/C/std-u64.c $(DES); \
#	 ./usubac -arch neon -o bench/neon/C/std-neon.c $(DES); 

clean:
	rm -f C/*.c
