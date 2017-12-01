CFLAGS = -fopenmp -O3 -std=gnu11 -mvsx -maltivec -mabi=altivec
CC     = gcc

all: *.c *.h
	$(CC) $(CFLAGS) -o des-bench   des-bench.c

clean:
	rm -f des-bench output.txt
