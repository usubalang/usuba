
all:
	make -C sbox_aes_kasper
	make -C sbox1_des

test:
	@echo AES sbox 1:
	make test -C sbox_aes_kasper
	@echo "-----------------"
	@echo DES sbox:
	make test -C sbox1_des
	@echo "-----------------"

clean:
	make clean -C sbox_aes_kasper
	make clean -C sbox1_des
