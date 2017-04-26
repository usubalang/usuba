TARGET = cmp cmp.s
CFLAGS = -Wall -Wextra -O3 -march=native -Wno-parentheses -fno-inline -fno-tree-vectorize
CFLAGS_clang = -Wall -Wextra -O3 -march=native -Wno-bitwise-op-parentheses -fno-vectorize -fno-inline
CC = gcc

default: $(TARGET)
all: default

cmp:
	$(CC) $(CFLAGS) cmp_add_AVX.c -o $@

cmp.s:
	$(CC) $(CFLAGS) -S cmp_add_AVX.c -o $@ 


clean:
	-rm -f $(TARGET)
	-rm -f *~
