CC     = clang
CFLAGS = -O3 -march=native -I../arch

USUBA_OPTS = -no-runtime -no-sched -check-tbl -no-share -no-arr

all: verif bench

verif: aes.c verif.c
	$(CC) $(CFLAGS) -o verif verif.c

bench: aes.c bench.c
	$(CC) $(CFLAGS) -o bench bench.c

aes: .FORCE
	cd .. ; ./usubac $(USUBA_OPTS) -o AES/aes.c samples/usuba/aes.ua
	perl -i -pe 's/cipher__(\d+)__/cipher[$$1]/' aes.c

.FORCE:

clean:
	rm -f verif bench output.txt
