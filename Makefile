.PHONY: all clean configure

# Directories
SRC_DIR := src
BIN_DIR := bin
SAMPLES_DIR := ../examples/samples
DUNE := dune

MAIN := main

all:
	@if [ ! -f ./src/config.ml ]; then \
		echo "config.ml was not found.";\
		echo "./configure will be executed but you can/should rerun it if your directories are not located in the same places"; \
		./configure; \
	fi
	@echo $(FILE_EXISTS)
	$(DUNE) build bin/cli/main.exe
	chmod +w _build/default/bin/cli/main.exe
	cp _build/default/bin/cli/main.exe usubac

clean:
	rm -f *~ .*~ usubac
	$(DUNE) clean

test: all
	ulimit -s unlimited
	@echo $(SAMPLES_DIR)
	dune build @runtest
	./tests/test_parsing.sh --path $(SAMPLES_DIR)
	./run_checks.pl --samples $(SAMPLES_DIR)

unit-test: all
	dune build @runtest
