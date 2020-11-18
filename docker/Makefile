# Call
#
#     make ACTIVATION_SERIAL_NUMBER=XXXX-XXXXXXXX
#
# where XXXX-XXXXXXXX is a valid Intel serial key

.PHONY: all clean

all:
	docker build									\
		 --tag=usuba								\
	         --build-arg ACTIVATION_SERIAL_NUMBER=$(ACTIVATION_SERIAL_NUMBER)	\
		 .

clean:
	docker build									\
		 --tag=usuba								\
	         --build-arg ACTIVATION_SERIAL_NUMBER=$(ACTIVATION_SERIAL_NUMBER)	\
		 --no-cache								\
		 .
