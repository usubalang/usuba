.PHONY: all clean

bench:
	docker run usuba

run:
	docker run -ti usuba /bin/bash

build:
	docker build									\
		 --tag=usuba								\
		 .

clean:
	docker build									\
		 --tag=usuba								\
		 --no-cache								\
		 .
