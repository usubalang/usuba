TARGET = add_8 add_16 add_16_wrong add_16_wrong2 add_16_wrong3 add_16_wrong4 add_32
#CFLAGS = -Wall -Wextra -march=native -Wno-parentheses -fno-tree-vectorize -fstrict-aliasing -inline-max-size=10000 -inline-max-total-size=10000 -O3
CFLAGS = # making sure the compiler doesn't try to optimize the assembly
CC = icc

default: $(TARGET)
all: default

add_8:
	$(CC) $(CFLAGS) add_8.s -o $@

add_16:
	$(CC) $(CFLAGS) add_16.s -o $@
add_16_wrong:
	$(CC) $(CFLAGS) add_16_wrong.s -o $@
add_16_wrong2:
	$(CC) $(CFLAGS) add_16_wrong2.s -o $@
add_16_wrong3:
	$(CC) $(CFLAGS) add_16_wrong3.s -o $@
add_16_wrong4:
	$(CC) $(CFLAGS) add_16_wrong4.s -o $@

add_32:
	$(CC) $(CFLAGS) add_32.s -o $@


clean:
	-rm -f $(TARGET)
