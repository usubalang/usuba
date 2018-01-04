
int init_p_arr[] = { 58, 50, 42, 34, 26, 18, 10, 2, 60, 52, 44, 36, 28, 20, 12, 4,
                     62, 54, 46, 38, 30, 22, 14, 6, 64, 56, 48, 40, 32, 24, 16, 8,
                     57, 49, 41, 33, 25, 17, 9, 1, 59, 51, 43, 35, 27, 19, 11, 3,
                     61, 53, 45, 37, 29, 21, 13, 5, 63, 55, 47, 39, 31, 23, 15, 7 };
void init_p(uint64_t plaintext, uint32_t* right, uint32_t* left) {
  *left = *right = 0;
  for (int i = 0; i < 32; i++) {
    *left  |= ((plaintext >> init_p_arr[i]) & 1) << i;
    *right |= ((plaintext >> init_p_arr[i+32]) & 1) << i;
  }
}

void des_single (uint32_t left, uint32_t right, uint32_t key[6]) {
  
}


void des(uint64_t plaintext, uint32_t[16][6] key) {
  uint32_t right, left;
  init_p(plaintext,&right,&left);
}
