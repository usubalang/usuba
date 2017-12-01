CFLAGS = -O3 -std=gnu11 -mvsx -maltivec -mabi=altivec

all: *.c
	gcc $(CFLAGS) -o bench-vector-no-ortho      bench-vector-no-ortho.c
	gcc $(CFLAGS) -o bench-vector-ortho         bench-vector-ortho.c
	gcc $(CFLAGS) -o bench-u64-no-ortho         bench-u64-no-ortho.c
	gcc $(CFLAGS) -o bench-u64-ortho            bench-u64-ortho.c

clean:
	rm -f bench-vector-no-ortho bench-vector-ortho bench-u64-no-ortho bench-u64-ortho std-u64 output.txt

