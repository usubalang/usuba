#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdint.h>

#define ROUND			12
#define min(x,y) ((x)<(y)?(x):(y))
#define max(x,y) ((x)>(y)?(x):(y))

#define D				8


typedef uint8_t	byte;
typedef uint32_t	u32;
typedef uint64_t	u64;
typedef uint32_t CWord;
typedef u32 tword;


#define S				4
const byte ReductionPoly = 0x3;
const byte WORDFILTER = ((byte) 1<<S)-1;
int DEBUG = 0;

/* to be completed for one time pass mode */
unsigned long long MessBitLen = 0;

const byte RC[D][12] = {
	{1, 3, 7, 14, 13, 11, 6, 12, 9, 2, 5, 10},
	{0, 2, 6, 15, 12, 10, 7, 13, 8, 3, 4, 11},
	{2, 0, 4, 13, 14, 8, 5, 15, 10, 1, 6, 9},
	{6, 4, 0, 9, 10, 12, 1, 11, 14, 5, 2, 13},
	{14, 12, 8, 1, 2, 4, 9, 3, 6, 13, 10, 5},
	{15, 13, 9, 0, 3, 5, 8, 2, 7, 12, 11, 4},
	{13, 15, 11, 2, 1, 7, 10, 0, 5, 14, 9, 6},
	{9, 11, 15, 6, 5, 3, 14, 4, 1, 10, 13, 2}
};

const byte MixColMatrix[D][D] = {
	{ 2,  4,  2, 11,  2,  8,  5,  6},
	{12,  9,  8, 13,  7,  7,  5,  2},
	{ 4,  4, 13, 13,  9,  4, 13,  9},
	{ 1,  6,  5,  1, 12, 13, 15, 14},
	{15, 12,  9, 13, 14,  5, 14, 13},
	{ 9, 14,  5, 15,  4, 12,  9,  6},
	{12,  2,  2, 10,  3,  1,  1, 14},
	{15,  1, 13, 10,  5, 10,  2,  3}
};

byte sbox[16] = {12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2};

byte FieldMult(byte a, byte b)
{
	byte x = a, ret = 0;
	int i;
	for(i = 0; i < S; i++) {
		if((b>>i)&1) ret ^= x;
		if((x>>(S-1))&1) {
			x <<= 1;
			x ^= ReductionPoly;
		}
		else x <<= 1;
	}
	return ret&WORDFILTER;
}


void AddKey(byte state[D][D], int round)
{
	int i;
	for(i = 0; i < D; i++)
		state[i][0] ^= RC[i][round];
}

void SubCell(byte state[D][D])
{
	int i,j;
	for(i = 0; i < D; i++)
		for(j = 0; j <  D; j++)
			state[i][j] = sbox[state[i][j]];
}

void ShiftRow(byte state[D][D])
{
	int i, j;
	byte tmp[D];
	for(i = 1; i < D; i++) {
		for(j = 0; j < D; j++)
			tmp[j] = state[i][j];
		for(j = 0; j < D; j++)
			state[i][j] = tmp[(j+i)%D];
	}
}

void MixColumn(byte state[D][D])
{
	int i, j, k;
	byte tmp[D];
	for(j = 0; j < D; j++){
		for(i = 0; i < D; i++) {
			byte sum = 0;
			for(k = 0; k < D; k++)
				sum ^= FieldMult(MixColMatrix[i][k], state[k][j]);
			tmp[i] = sum;
		}
		for(i = 0; i < D; i++)
			state[i][j] = tmp[i];
	}
}

void Permutation(byte state[D][D], int R)
{
  int i;
  for(i = 0; i < R; i++) {
    AddKey(state, i);
    SubCell(state);
    ShiftRow(state);
    MixColumn(state);
  }
}

/* Additional functions */
uint32_t bench_speed() {
  /* inputs */
  uint8_t state[8][8] = { 0 };
  /* fun call */
  Permutation(state,12);

  /* Returning the number of encrypted bytes */
  return 32;
}
