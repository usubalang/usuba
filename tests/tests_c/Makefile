TARGET = make_input 64icc 64clang 128icc 128clang 256icc 256clang 64icc.s 64clang.s 128icc.s 128clang.s 256icc.s 256clang.s
CFLAGS = -Wall -Wextra -march=native -O3 -fstrict-aliasing
ICCFLAGS = -restrict -no-vec
CLANGFLAGS = -fno-vectorize

default: $(TARGET)
all: default

make_input:
	gcc $(CFLAGS) make_input.c -o $@
	./make_input

64icc:
	icc $(CFLAGS) $(ICCFLAGS) test_64.c -o $@
64clang:
	clang $(CFLAGS) $(CLANGFLAGS) test_64.c -o $@
64icc.s:
	icc $(CFLAGS) $(ICCFLAGS) des_ua_kwan_Std64.c -S -o $@
64clang.s:
	clang $(CFLAGS) $(CLANGFLAGS) des_ua_kwan_Std64.c -S -o $@


128icc:
	icc $(CFLAGS) $(ICCFLAGS) test_128.c -o $@
128clang:
	clang $(CFLAGS) $(CLANGFLAGS) test_128.c -o $@
128icc.s:
	icc $(CFLAGS) $(ICCFLAGS) des_ua_kwan_SSE128.c -S -o $@
128clang.s:
	clang $(CFLAGS) $(CLANGFLAGS) des_ua_kwan_SSE128.c -S -o $@

256icc:
	icc $(CFLAGS) $(ICCFLAGS) test_256.c -o $@
256clang:
	clang $(CFLAGS) $(CLANGFLAGS) test_256.c -o $@
256icc.s:
	icc $(CFLAGS) $(ICCFLAGS) des_ua_kwan_AVX256.c -S -o $@
256clang.s:
	clang $(CFLAGS) $(CLANGFLAGS) des_ua_kwan_AVX256.c -S -o $@


clean:
	rm -f $(TARGET)
	rm -f *~
	rm *.txt
