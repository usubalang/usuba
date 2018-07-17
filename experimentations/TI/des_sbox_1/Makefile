
CC = clang
CFLAGS = -Wall -Wextra
HEADERS = ../../../arch

all:
	$(CC) -DTI=$(TI) -O3 -I $(HEADERS) $(CFLAGS) main.c sbox.c -o main

test: all
	@./main

clean:
	$(RM) main
