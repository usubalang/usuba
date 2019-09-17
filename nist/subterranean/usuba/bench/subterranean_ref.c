#include <stdlib.h>
#include <stdint.h>

#define SUBTERRANEAN_SIZE 257

const unsigned int subterranean_pi_permutation[257] = {0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 144, 156, 168, 180, 192, 204, 216, 228, 240, 252, 7, 19, 31, 43, 55, 67, 79, 91, 103, 115, 127, 139, 151, 163, 175, 187, 199, 211, 223, 235, 247, 2, 14, 26, 38, 50, 62, 74, 86, 98, 110, 122, 134, 146, 158, 170, 182, 194, 206, 218, 230, 242, 254, 9, 21, 33, 45, 57, 69, 81, 93, 105, 117, 129, 141, 153, 165, 177, 189, 201, 213, 225, 237, 249, 4, 16, 28, 40, 52, 64, 76, 88, 100, 112, 124, 136, 148, 160, 172, 184, 196, 208, 220, 232, 244, 256, 11, 23, 35, 47, 59, 71, 83, 95, 107, 119, 131, 143, 155, 167, 179, 191, 203, 215, 227, 239, 251, 6, 18, 30, 42, 54, 66, 78, 90, 102, 114, 126, 138, 150, 162, 174, 186, 198, 210, 222, 234, 246, 1, 13, 25, 37, 49, 61, 73, 85, 97, 109, 121, 133, 145, 157, 169, 181, 193, 205, 217, 229, 241, 253, 8, 20, 32, 44, 56, 68, 80, 92, 104, 116, 128, 140, 152, 164, 176, 188, 200, 212, 224, 236, 248, 3, 15, 27, 39, 51, 63, 75, 87, 99, 111, 123, 135, 147, 159, 171, 183, 195, 207, 219, 231, 243, 255, 10, 22, 34, 46, 58, 70, 82, 94, 106, 118, 130, 142, 154, 166, 178, 190, 202, 214, 226, 238, 250, 5, 17, 29, 41, 53, 65, 77, 89, 101, 113, 125, 137, 149, 161, 173, 185, 197, 209, 221, 233, 245};
const unsigned int subterranean_io_bits_0[33] = {1, 176, 136, 35, 249, 134, 197, 234, 64, 213, 223, 184, 2, 95, 15, 70, 241, 11, 137, 211, 128, 169, 189, 111, 4, 190, 30, 140, 225, 22, 17, 165, 256};

/**
* Subterranean round function
* The input state is updated with the new state.
*/
void subterranean_round(unsigned char state[SUBTERRANEAN_SIZE]){
    unsigned int i;
    unsigned char temp_0, temp_1, temp_2, temp_3, temp_4, temp_5, temp_6, temp_7;
    unsigned char temp_state[SUBTERRANEAN_SIZE];

    /* Chi step*/
    for(i = 0; i < (SUBTERRANEAN_SIZE-2); i++){
        temp_state[i] = state[i] ^ ((1 ^ state[i+1]) & state[i+2]);
    }
    temp_state[i] = state[i] ^ ((1 ^ state[i+1]) & state[0]);
    i++;
    temp_state[i] = state[i] ^ ((1 ^ state[0]) & state[1]);

    /* Iota step*/
    temp_state[0] ^= 1;

    /* Theta step*/
    temp_0 = temp_state[0] ^ temp_state[3]  ^ temp_state[8];
    temp_1 = temp_state[1] ^ temp_state[4]  ^ temp_state[9];
    temp_2 = temp_state[2] ^ temp_state[5]  ^ temp_state[10];
    temp_3 = temp_state[3] ^ temp_state[6]  ^ temp_state[11];
    temp_4 = temp_state[4] ^ temp_state[7]  ^ temp_state[12];
    temp_5 = temp_state[5] ^ temp_state[8]  ^ temp_state[13];
    temp_6 = temp_state[6] ^ temp_state[9]  ^ temp_state[14];
    temp_7 = temp_state[7] ^ temp_state[10] ^ temp_state[15];
    for(i = 8; i < (SUBTERRANEAN_SIZE-8); i++){
        temp_state[i] = temp_state[i] ^ temp_state[i+3] ^ temp_state[i+8];
    }
    temp_state[i] = temp_state[i] ^ temp_state[i+3] ^ temp_state[0];
    i++;
    temp_state[i] = temp_state[i] ^ temp_state[i+3] ^ temp_state[1];
    i++;
    temp_state[i] = temp_state[i] ^ temp_state[i+3] ^ temp_state[2];
    i++;
    temp_state[i] = temp_state[i] ^ temp_state[i+3] ^ temp_state[3];
    i++;
    temp_state[i] = temp_state[i] ^ temp_state[i+3] ^ temp_state[4];
    i++;
    temp_state[i] = temp_state[i] ^ temp_state[0] ^ temp_state[5];
    i++;
    temp_state[i] = temp_state[i] ^ temp_state[1] ^ temp_state[6];
    i++;
    temp_state[i] = temp_state[i] ^ temp_state[2] ^ temp_state[7];
    temp_state[0] = temp_0;
    temp_state[1] = temp_1;
    temp_state[2] = temp_2;
    temp_state[3] = temp_3;
    temp_state[4] = temp_4;
    temp_state[5] = temp_5;
    temp_state[6] = temp_6;
    temp_state[7] = temp_7;


    /* Pi step*/
    for(i = 0; i < (SUBTERRANEAN_SIZE); i++){
        state[i] = temp_state[subterranean_pi_permutation[i]];
    }


}


/**
* Perform a duplex
*/
void subterranean_duplex(unsigned char state[SUBTERRANEAN_SIZE], const unsigned char * sigma, const unsigned char size){
    unsigned char j;
    /* s <= R(s) */
    subterranean_round(state);
    /* sbar <= sbar + sigma */
    for(j = 0; j < size; j++){
        state[subterranean_io_bits_0[j]] ^= sigma[j];
    }
    /* sbar <= sbar + (1||0*) */
    state[subterranean_io_bits_0[j]] ^= 1;
}

/**
* Perform a blank into the state
*/
void subterranean_blank(unsigned char state[SUBTERRANEAN_SIZE], const unsigned char r_calls){
    unsigned char i;
    /* for r times do duplex() */
    for(i = 0; i < r_calls; i++){
        subterranean_duplex(state, NULL, 0);
    }

}

/* Additional functions */
uint32_t bench_speed() {
  /* inputs */
  uint8_t state[257] = { 0 };
  /* fun call */
  subterranean_blank(state,8);

  /* Returning the number of encrypted bytes */
  return 257/8;
}
