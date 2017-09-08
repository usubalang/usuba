TARGET = test_uak_256 test_uak_256_no test_ua_256 test_ua_256_no test_uak_128 test_uak_128_no test_uak_64std test_uak_64std_no test_kwan test_kwan_no make_input
LIBS =
CC = clang
#CC = /opt/intel/compilers_and_libraries/linux/bin/intel64/icc
CFLAGS = -Wall -Wextra -march=native -O3
V = 0

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: default all clean

default: $(TARGET) $(OBJECTS)
all: default

test_uak_256:
	$(CC) $(CFLAGS) test_uak_256.c -o $@

test_uak_256_no:
	$(CC) $(CFLAGS) test_uak_256_no.c -o $@

test_ua_256:
	$(CC) $(CFLAGS) test_ua_256.c -o $@

test_ua_256_no:
	$(CC) $(CFLAGS) test_ua_256_no.c -o $@

test_uak_128:
	$(CC) $(CFLAGS) test_uak_128.c -o $@

test_uak_128_no:
	$(CC) $(CFLAGS) test_uak_128_no.c -o $@

test_uak_64std:
	$(CC) $(CFLAGS) test_uak_64std.c -o $@

test_uak_64std_no:
	$(CC) $(CFLAGS) test_uak_64std_no.c -o $@

test_kwan:
	$(CC) $(CFLAGS) test_kwan.c -o $@

test_kwan_no:
	$(CC) $(CFLAGS) test_kwan_no.c -o $@


make_input:
	$(CC) $(CFLAGS) make_input.c -o $@

.PRECIOUS: $(TARGET)

clean:
	-rm -f *.o
	-rm -f *~
	-rm -f $(TARGET)
