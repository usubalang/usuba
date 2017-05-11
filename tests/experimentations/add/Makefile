TARGET = add_8 add_16 add_32
#CFLAGS = -Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -inline-max-size=10000 -inline-max-total-size=10000 -O3
CFLAGS = # making sure the compiler doesn't try to optimize the assembly
CC = icc

default: $(TARGET)
all: default

add_8:
	$(CC) $(CFLAGS) add_8.s -o $@

add_16:
	$(CC) $(CFLAGS) add_16.s -o $@

add_32:
	$(CC) $(CFLAGS) add_32.s -o $@


clean:
	-rm -f $(TARGET)
