all:
	make -C src

check: all
	perl check_des.pl

test_all: all
	perl -e '!/\.dev\./ && system "./src/main.native $$_" for glob "tests/usuba/*.ua"'
