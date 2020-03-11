TARGET = add_8 add_16 add_32
CFLAGS = -Wall -Wextra -fno-tree-vectorize -fno-tree-slp-vectorize -O3 -mllvm -align-all-blocks=5
ARCH_FLAG = -march=native
ARCH = SSE
CC = clang

default: $(TARGET)
all: default

asm: add_8.s add_16.s add_32.s

add_%: add.c
	$(CC) $(CFLAGS) $(ARCH_FLAG) -D $(ARCH) -D ADD$* $< -o $@

add_%.s: add.c
	$(CC) $(CFLAGS) $(ARCH_FLAG) -D $(ARCH) -D ADD$* $< -S -o $@

vtune: add_vtune_BITSLICE add_vtune_PACKED add_vtune_PARALLEL

add_vtune_%: add.c
	$(CC) $(CFLAGS) $(ARCH_FLAG) -D $(ARCH) -D ADD32 -D $* $< -o $@

iaca: add_iaca_BITSLICE add_iaca_PACKED add_iaca_PARALLEL

add_iaca_%: add.c
	$(CC) $(CFLAGS) $(ARCH_FLAG) -D $(ARCH) -D IACA_$* -D ADD32 $< -o $@

clean:
	$(RM) $(TARGET)
	$(RM) add_vtune_BITSLICE add_vtune_PACKED add_vtune_PARALLEL
	$(RM) add_8.s add_16.s add_32.s
	$(RM) add_iaca_BITSLICE add_iaca_PACKED add_iaca_PARALLEL
