TARGET = test_full_usuba_des test_kwan_usuba_des test_kwan_des test_no_ortho_full_usuba test_no_ortho_kwan_usuba test_no_ortho_kwan test_256 test_no_ortho_256 test_64_simd test_no_ortho_64_simd test_64 test_no_ortho_64
LIBS =
CC = gcc
CFLAGS = -Wall -Wextra -march=native -O3 -mavx2
V = 0

.PHONY: default all clean

default: $(TARGET)
all: default


test_full_usuba_des:
	$(CC) $(CFLAGS) test_full_usuba_des.c  -o $@

test_kwan_usuba_des:
	$(CC) $(CFLAGS) test_kwan_usuba_des.c  -o $@

test_kwan_des:
	$(CC) $(CFLAGS) test_kwan_des.c  -o $@

test_no_ortho_full_usuba:
	$(CC) $(CFLAGS) test_no_ortho_full_usuba.c  -o $@

test_no_ortho_kwan_usuba:
	$(CC) $(CFLAGS) test_no_ortho_kwan_usuba.c  -o $@

test_no_ortho_kwan:
	$(CC) $(CFLAGS) test_no_ortho_kwan.c  -o $@

test_256:
	$(CC) $(CFLAGS) test_256.c  -o $@

test_no_ortho_256:
	$(CC) $(CFLAGS) test_no_ortho_256.c  -o $@

test_64_simd:
	$(CC) $(CFLAGS) test_64_simd.c  -o $@

test_no_ortho_64_simd:
	$(CC) $(CFLAGS) test_no_ortho_64_simd.c  -o $@

test_64:
	$(CC) $(CFLAGS) test_64.c  -o $@

test_no_ortho_64:
	$(CC) $(CFLAGS) test_no_ortho_64.c  -o $@

make_input:
	$(CC) $(CFLAGS) make_input.c -o $@


.PRECIOUS: $(TARGET)

clean:
	-rm -f *.o
	-rm -f *~
	-rm -f $(TARGET)
