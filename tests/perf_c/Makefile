TARGET = test_uak_256 test_uak_256_no test_ua_256 test_ua_256_no test_uak_128 test_uak_128_no test_uak_64 test_uak_64_no test_uak_64std test_uak_64std_no test_kwan test_kwan_no
LIBS =
CC = clang
#CC = /opt/intel/compilers_and_libraries/linux/bin/intel64/icc
CFLAGS = -Wall -Wextra -march=native -O3
V = 0

.PHONY: default all clean

default: $(TARGET)
all: default


test_uak_256:
	gcc $(CFLAGS) test_uak_256_ortho.c -o $@

test_uak_256_no:
	$(CC) $(CFLAGS) test_uak_256_no.c -o $@

test_ua_256:
	gcc $(CFLAGS) test_ua_256_ortho.c -o $@

test_ua_256_no:
	$(CC) $(CFLAGS) test_ua_256_no.c -o $@

test_uak_128:
	gcc $(CFLAGS) test_uak_128_ortho.c -o $@

test_uak_128_no:
	$(CC) $(CFLAGS) test_uak_128_no.c -o $@

test_uak_64:
	$(CC) $(CFLAGS) test_uak_64_ortho.c -o $@

test_uak_64_no:
	$(CC) $(CFLAGS) test_uak_64_no.c -o $@

test_uak_64std:
	$(CC) $(CFLAGS) test_uak_64std_ortho.c -o $@

test_uak_64std_no:
	$(CC) $(CFLAGS) test_uak_64std_no.c -o $@

test_kwan:
	$(CC) $(CFLAGS) test_kwan_ortho.c -o $@

test_kwan_no:
	$(CC) $(CFLAGS) test_kwan_no.c -o $@


.PRECIOUS: $(TARGET)

clean:
	-rm -f *.o
	-rm -f *~
	-rm -f $(TARGET)
