CC     = clang
CFLAGS = -O3 -march=native -I../../../arch

all: camellia

camellia: camellia.c
	$(CC) $(CFLAGS) -o camellia camellia.c

.FORCE:

clean:
	rm -f output.txt camellia
