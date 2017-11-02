CC     = clang
CFLAGS = -O3 -march=native -I../arch


all: verif bench

verif: aes.c verif.c
	$(CC) $(CFLAGS) -o verif verif.c

bench: aes.c bench.c
	$(CC) $(CFLAGS) -o bench bench.c

aes: .FORCE
	cd .. ; ./usubac -no-runtime -no-inlining -no-share -no-sched -no-arr -check-tbl -o AES/aes.c samples/usuba/aes.ua
	perl -i -pe 's/cipher__(\d+)__/cipher[$$1]/' aes.c

.FORCE:

clean:
	rm -f verif bench output.txt
