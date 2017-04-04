TARGET = make_input test_des
LIBS =
CC = gcc
CFLAGS = -Wall -Wextra -march=native -O3
V = 0

.PHONY: default all clean

default: $(TARGET)
all: default

test: all
	@echo "Generating input file..."
	./make_input
	@echo "Running DES..."
	./test_des
	@echo "Done."

make_input:
	$(CC) $(CFLAGS) make_input.c -o $@

test_des:
	$(CC) $(CFLAGS) test_des.c -o $@

.PRECIOUS: $(TARGET)

clean:
	-rm -f *.o
	-rm -f $(TARGET)
