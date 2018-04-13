QHASM = ~/bin/qhasm/qhasm-amd64
MAQ = ~/bin/maq/maq

name = aes-ctr
type = sync
std = -ansi

srcdir = .
root := $(shell \
  cd "$(srcdir)"; root="$(srcdir)"; \
  while [ "`pwd`" != "/" ]; do \
    if [ -r "`pwd`/test/ecrypt-test.mk" ]; then  \
      echo $$root; exit; \
    fi; \
    cd ..; root="$$root"/..; \
  done; \
  echo ".")

include $(root)/test/ecrypt-test.mk

%.q: %.pq
	$(MAQ) $< > $@

%.s: %.q
	$(QHASM) < $< > $@

aes-ctr.s: process_bytes.s keysetup-vul.s sbox.s ivsetup.s consts.s
	cat $^ > aes-ctr.s
