all:
	make -C src

check: all
	perl check_des.pl

clean:
	rm -f usubac
	make clean -C src
