
CC = clang
CFLAGS = -Wall -Wextra
HEADERS = ../../arch

all:
	$(CC) -I $(HEADERS) $(CFLAGS) main.c fdti.c -o fdti
	$(CC) -I $(HEADERS) $(CFLAGS) main.c tifd.c -o tifd

test: all
	@echo "Testing FDTI"
	./fdti
	@echo "Testing TIFD"
	./tifd

clean:
	$(RM) fdti tifd
