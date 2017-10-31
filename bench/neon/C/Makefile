CFLAGS = -O3 -std=gnu11 -mfpu=neon -flax-vector-conversions 

all: *.c
	gcc $(CFLAGS) -o bench-neon-no-ortho      bench-neon-no-ortho.c
	gcc $(CFLAGS) -o bench-neon-ortho         bench-neon-ortho.c
	gcc $(CFLAGS) -o bench-u64-no-ortho       bench-u64-no-ortho.c
	gcc $(CFLAGS) -o bench-u64-ortho          bench-u64-ortho.c

clean:
	rm -f bench-neon-no-ortho bench-neon-ortho std-neon bench-u64-no-ortho bench-u64-ortho std-u64  output.txt

