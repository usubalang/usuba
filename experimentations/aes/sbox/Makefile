
CC      = clang
CFLAGS  = -march=native -O3
HEADERS = -I ../../../arch
ARCH    = SSE
_MCA    = $(if $(MCA),-D _MCA)

TARGETS_EXE = kivi ua_macro ua_fun ua_fun_inline
TARGETS_ASM = $(TARGETS_EXE:=.s)
TARGETS = $(TARGETS_ASM) $(TARGETS_EXE)

all: $(TARGETS)

$(TARGETS_EXE): % : sbox.c %.c
	$(CC) $(CFLAGS) $(HEADERS) $(_MCA) -D $(ARCH) -D $@ -o $@ $<

$(TARGETS_ASM): % : $(%.c:.c=.s) sbox.c
	$(CC) $(CFLAGS) $(HEADERS) $(_MCA) -D $(ARCH) -D $(subst .s,,$@) -S -o $@ $<

clean:
	$(RM) $(TARGETS)
	$(RM) *~
