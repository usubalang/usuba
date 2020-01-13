TARGET = add_8 add_16 add_32
CFLAGS = -Wall -Wextra -msse4.2 -fno-tree-vectorize -fno-slp-vectorize -O3
CC = clang

default: $(TARGET)
all: default

asm: add_8.s add_16.s add_32.s

add_%: add_%.c
	$(CC) $(CFLAGS) $< -o $@

add_%.s: add_%.c
	$(CC) $(CFLAGS) $< -S -o $@

clean:
	$(RM) $(TARGET)
