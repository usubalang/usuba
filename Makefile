all:
	make -C src

check: all
	perl check_des.pl
