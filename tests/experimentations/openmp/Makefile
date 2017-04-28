TARGET = run make_input
CC = gcc
CFLAGS = -Wall -Wextra -fopenmp -march=native -O3

default: $(TARGET)
all: default

run:
	$(CC) $(CFLAGS) main.c -o $@

make_input:
	$(CC) $(CFLAGS) make_input.c -o $@
	./make_input

clean:
	rm -f $(TARGET)
	rm -f *~
