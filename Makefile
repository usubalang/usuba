.PHONY: all clean

# Directories
SRC_DIR := src
BIN_DIR := bin
SAMPLES_DIR := ../examples/samples
# MENHIR := menhir
# MENHIRFLAGS := --infer --explain
# INCLUDES := -I normalization -I optimization -I parsing -I c_gen -I verification -I c_gen/runtimes -I tests -I tightprove -I tightprove/parsing -I maskverif
DUNE := dune

MAIN := main

all:
	$(DUNE) build
	chmod +w _build/default/bin/cli/main.exe
	cp _build/default/bin/cli/main.exe usubac

# ./main.native -tests
# cp main.native ../usubac

clean:
	rm -f *~ .*~ usubac
	$(DUNE) clean

test: all
	./usubac -tests
	@echo $(SAMPLES_DIR)
	./run_checks.pl --samples $(SAMPLES_DIR)
