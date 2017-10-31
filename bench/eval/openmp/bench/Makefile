CFLAGS = -std=gnu11 -fopenmp -O3 -march=native -Iarch
CC     = gcc

all: *.c
	$(CC) $(CFLAGS) -o des-bench des-bench.c

clean:
	rm -f des-bench output.txt

