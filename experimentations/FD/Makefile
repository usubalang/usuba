
all:
	make -C aes_sbox
	make -C des_sbox_1

test:
	@echo DES sbox 1:
	make test -C aes_sbox
	@echo "-----------------"
	@echo AES sbox:
	make test -C des_sbox_1
	@echo "-----------------"

clean:
	make clean -C aes_sbox
	make clean -C des_sbox_1
