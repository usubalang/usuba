CC = clang
CFLAGS = -Wall -Wextra -O3 -march=native
INC = -I ../../arch

all: encrypt

encrypt: encrypt.c aes.c aes_ecb.c aes_ctr.c key_sched.c
	$(CC) $(CFLAGS) $(INC) $^ -o $@

clean:
	$(RM) encrypt
