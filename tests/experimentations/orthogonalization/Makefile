TARGET = ortho
CFLAGS = -Wall -Wextra -fno-vectorize -fstrict-aliasing -march=native -O3
CC = clang

default: $(TARGET)
all: default

ortho:
	$(CC) $(CFLAGS) ortho.c -o $@

test32:
	$(CC) $(CFLAGS) test32.c -o $@

simd:
	$(CC) $(CFLAGS) simd.c -o $@

clean:
	-rm -f $(TARGET)
