
all:
	TI=3 make -C aes_sbox
	TI=3 make -C des_sbox_1

test:
	@echo DES sbox 1:
	TI=3 make test -C aes_sbox
	@echo "-----------------"
	@echo AES sbox:
	TI=3 make test -C des_sbox_1
	@echo "-----------------"

clean:
	make clean -C aes_sbox
	make clean -C des_sbox_1
