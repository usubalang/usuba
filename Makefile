all:
	make -C src

test: all
	./run_checks.pl

clean:
	make clean -C src
