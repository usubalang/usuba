
CC = clang
CFLAGS = -Wall -Wextra
HEADERS = ../../../arch

all:
	$(CC) -O3 -I $(HEADERS) $(CFLAGS) main.c sbox.c sbox_fd.c -o main

test: all
	@./main

clean:
	$(RM) main
