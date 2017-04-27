TARGET = cmp cmp.s
CFLAGS = -Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -inline-max-size=10000 -inline-max-total-size=10000 -O3
CC = icc

default: $(TARGET)
all: default

cmp:
	$(CC) $(CFLAGS) cmp_add_AVX.c -o $@

cmp.s:
	$(CC) $(CFLAGS) -S cmp_add_AVX.c -o $@ 


clean:
	-rm -f $(TARGET)
	-rm -f *~
