
CC      = clang
CFLAGS  = -march=native -O3
HEADERS = -I ../../../arch
ARCH    = SSE

TARGETS_EXE = kivi ua_macro ua_fun ua_fun_inline
TARGETS_ASM = $(TARGETS_EXE:=.s)
TARGETS = $(TARGETS_ASM) $(TARGETS_EXE)

all: $(TARGETS)

$(TARGETS_EXE): % : sbox.c %.c
	$(CC) $(CFLAGS) $(HEADERS) -D $(ARCH) -D $@ -o $@ $<

$(TARGETS_ASM): % : $(%.c:.c=.s) sbox.c
	$(CC) $(CFLAGS) $(HEADERS) -D $(ARCH) -D $(subst .s,,$@) -S -o $@ $<

clean:
	$(RM) $(TARGETS)
	$(RM) *~
