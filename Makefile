all:
	make -C src

check: all
	perl check_des.pl

clean:
	make clean -C src
