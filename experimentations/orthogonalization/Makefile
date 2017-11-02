TARGET = ortho simd
CFLAGS = -Wall -Wextra -fno-vectorize -fstrict-aliasing -march=native -O3
CC = clang

default: $(TARGET)
all: default

ortho: ortho.c
	$(CC) $(CFLAGS) ortho.c -o $@

simd: simd.c
	$(CC) $(CFLAGS) simd.c -o $@

clean:
	-rm -f $(TARGET)
