CFLAGS = -O3 -march=native -I../../../arch
CC     = clang

all: des-orig des-new

des-orig:
	$(CC) $(CFLAGS) -o des-orig des-orig.c

des-new:
	$(CC) $(CFLAGS) -o des-new des-new.c

clean:
	rm -f des-orig des-new output.txt
