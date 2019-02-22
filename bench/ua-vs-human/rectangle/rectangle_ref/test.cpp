/** @file test.cpp
  * @brief 本文件包含对RECTANGLE密码算法的加密、解密、密钥编排算法的正确性测试和测试向量生成的函数定义。
  *
  * 正确性测试包括：
  *    - 单次运算示例（分别对 80-比特密钥、128-比特密钥）：
  *          - 对 1~16 组明文并行加密，得到 1~16 组密文输出
  *          - 对得到的 1~16 组密文输出并行解密，得到 1~16 组明文
  *      由于使用SSE、AVX指令集时，可以一次性的加密 8、16 个分组，
  *      加密不同个数的分组，所经过的代码路径不同，为了测试所有代码路径正确性，
  *      检验一次加密 1~16 个分组的正确性，测试数据向量的个数设为 16 个
  *    - 多次运算示例（分别对 80-比特密钥、128-比特密钥）：
  *          - 对 4 组示例中的每一组（固定密钥），循环加密 10 次，示例数据应包括明文输入、密钥输入以及每次加密的密文输出。
  *            然后对得到的 4 组密文中的每一组（固定密钥），循环解密 10 次，示例数据应包括密文输入、密钥输入以及每次解密的明文输出。
  *          - 对 4 组示例中的每一组（固定密钥），循环加密 10000 次，示例数据应包括明文输入、密钥输入以及最终加密的密文输出。
  *            然后对得到的 4 组密文中的每一组（固定密钥），循环解密 10000 次，示例数据应包括密文输入、密钥输入以及最终解密的明文输出。
  */
#include "test.h"

using namespace std;

/** 测试的向量分组个数
  * 由于使用AVX指令集时，可以一次性的加密16个分组，
  * 为了测试正确性，检验一次加密16个分组的正确性，测试向量的个数设为16个
  */
#define VN_DATA 16

/** 测试的不同密钥的个数 */
#define VN_KEY  2

/** VN_DATA 个测试向量 */
data_t test_vector_plain[VN_DATA][8] = 
{
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
	{0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,},
};

/** VN_KEY 个不同的 80-比特密钥 */
data_t test_vector_key80[VN_KEY][10] = 
{
	{0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,}, 
	{0xFF,0xFF,0xFF,0xFF, 0xFF,0xFF,0xFF,0xFF, 0xFF,0xFF,}, 
};

/** VN_KEY 个不同的 128-比特密钥 */
data_t test_vector_key128[VN_KEY][16] = 
{
	{0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00,}, 
	{0xFF,0xFF,0xFF,0xFF, 0xFF,0xFF,0xFF,0xFF, 0xFF,0xFF,0xFF,0xFF, 0xFF,0xFF,0xFF,0xFF,}, 
};

/** 加密函数将 test_vector_plain[VN_DATA][8]中的数据加密后，结果保存在test_cipher[VN_DATA][8]中。*/
data_t test_cipher[VN_DATA][8];
/** 解密函数将 test_cipher[VN_DATA][8]中的数据解密后，结果保存在test_plain[VN_DATA][8]中。*/
data_t test_plain[VN_DATA][8];

/** 取测试向量 @a x 的第 @a n 个16-比特字 */
#define word16_in(x,n)    (*((u16*)(x)+(n)))
/** 取测试向量 @a x 的第 @a n 个32-比特字 */
#define word32_in(x, n)   (*(((u32*)(x))+ n))

void test()
{
	ofstream fout_hex, fout_bit;
	string fn_hex, fn_bit;
	int out_len;

	/** 多次运算示例 */
#define VN 4

#if 1    
	/** 单次运算示例：测试 1~16 组明文的单次加解密运算，*/
	fn_hex = "test_vector_hex.txt"; /**> 测试结果以十六进制形式打印在这个文件中。 */
	fn_bit = "test_vector_bit.txt";	/**> 测试结果以二进制形式打印在这个文件中。 */

	fout_hex.open(fn_hex.c_str());
	fout_bit.open(fn_bit.c_str());


	for (int dn = 0; dn < VN_DATA; dn++)
	{
		fout_hex << endl;
		fout_hex << "========================================================================" << endl;
		fout_hex << "Test " << (dn+1) << " block(s)" << endl;
		fout_hex << "========================================================================" << endl;

		fout_bit << endl;
		fout_bit << "========================================================================" << endl;
		fout_bit << "Test " << (dn+1) << " block(s)" << endl;
		fout_bit << "========================================================================" << endl;

		for (int ki = 0; ki < VN_KEY; ki++)
		{
			fout_hex << "Enc K80:" << endl;
			fout_hex << setw(20) << "plaintext" << setw(24) << "key" << setw(20) << "ciphertext" << endl;
			fout_bit << "Enc K80:" << endl;
			fout_bit << setw(20) << "plaintext" << setw(24) << "key" << setw(20) << "ciphertext" << endl;
			rectangle_ecb_enc(test_vector_plain[0], (dn+1)*8, test_cipher[0], &out_len, test_vector_key80[ki], 80);
			for (int i=0; i<=dn; i++)
			{
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)(test_vector_plain[i]))[0];
				fout_hex << "  0x" << hex << setfill('0')
						<< setw(4) << ((u16*)(test_vector_key80[ki]))[4]
						<< setw(4) << ((u16*)(test_vector_key80[ki]))[3]
						<< setw(4) << ((u16*)(test_vector_key80[ki]))[2]
						<< setw(4) << ((u16*)(test_vector_key80[ki]))[1]
						<< setw(4) << ((u16*)(test_vector_key80[ki]))[0];
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_cipher[i])[0];
				fout_hex << setfill(' ') << dec << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 0)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 0))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 1)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 1))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 2)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 2))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 3)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 3))) << endl;
				fout_bit << "    " << setw(16) << " "
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 4)))
					<< "    " << setw(16) << " " << endl;
				fout_bit << endl;
			}
		
			fout_hex << "Dec K80:" << endl;
			fout_hex << setw(20) << "plaintext" << setw(24) << "key" << setw(20) << "ciphertext" << endl;
			fout_bit << "Dec K80:" << endl;
			fout_bit << setw(20) << "plaintext" << setw(24) << "key" << setw(20) << "ciphertext" << endl;
			rectangle_ecb_dec(test_cipher[0], (dn+1)*8, test_plain[0], &out_len, test_vector_key80[ki], 80);
			for (int i=0; i<=dn; i++)
			{
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_plain[i])[0];
				fout_hex << "  0x" << hex << setfill('0')
					 << setw(4) << ((u16*)(test_vector_key80[ki]))[4]
					 << setw(4) << ((u16*)(test_vector_key80[ki]))[3]
					 << setw(4) << ((u16*)(test_vector_key80[ki]))[2]
					 << setw(4) << ((u16*)(test_vector_key80[ki]))[1]
					 << setw(4) << ((u16*)(test_vector_key80[ki]))[0];
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_cipher[i])[0];
				fout_hex << setfill(' ') << dec << endl;
		
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 0)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 0)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 0))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 1)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 1)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 1))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 2)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 2)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 2))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 3)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 3)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 3))) << endl;
				fout_bit << "    " << setw(16) << " "
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i], 4)))
					<< "    " << setw(16) << " " << endl;
				fout_bit << endl;
			}
		
			fout_hex << "Enc K128:" << endl;
			fout_hex << setw(20) << "plaintext" << setw(36) << "key" << setw(20) << "ciphertext" << endl;
			fout_bit << "Enc K128:" << endl;
			fout_bit << setw(20) << "plaintext" << setw(36) << "key" << setw(20) << "ciphertext" << endl;
			rectangle_ecb_enc(test_vector_plain[0], (dn+1)*8, test_cipher[0], &out_len, test_vector_key128[ki], 128);
			for (int i=0; i<=dn; i++)
			{
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0];
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_key128[ki])[1] << setw(16) << ((u64*)(test_vector_key128[ki]))[0];
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_cipher[i])[0];
				fout_hex << setfill(' ') << dec << endl;
			
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 0)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 0))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 1)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 1))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 2)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 2))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 3)))
					<< "    " << setw(16) << *(new bitset<16>((u64)word16_in(test_cipher[i], 3))) << endl;
				fout_bit << endl;
			}
			fout_hex << "Dec K128:" << endl;
			fout_hex << setw(20) << "plaintext" << setw(36) << "key" << setw(20) << "ciphertext" << endl;
			fout_bit << "Dec K128:" << endl;
			fout_bit << setw(20) << "plaintext" << setw(36) << "key" << setw(20) << "ciphertext" << endl;
			rectangle_ecb_dec(test_cipher[0], (dn+1)*8, test_plain[0], &out_len, test_vector_key128[ki], 128);
			for (int i=0; i<=dn; i++)
			{
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_plain[i])[0];
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_key128[ki])[1] << setw(16) << ((u64*)(test_vector_key128[ki]))[0];
				fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_cipher[i])[0];
				fout_hex << setfill(' ') << dec << endl;
		
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 0)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 0)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 0))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 1)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 1)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 1))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 2)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 2)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 2))) << endl;
				fout_bit << "    " << setw(16) << *(new bitset<16>(word16_in(test_plain[i], 3)))
					<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[ki], 3)))
					<< "    " << setw(16) << *(new bitset<16>(word16_in(test_cipher[i], 3))) << endl;
				fout_bit << endl;
			}
		}
	}

	fout_hex << endl;
	fout_hex.close();
	fout_bit << endl;
	fout_bit.close();

	/** 测试 4 组示例，每组单独10次循环加解密运算 */
#define LOOPN 10

	fn_hex = "test10_vector_hex.txt";  /**> 测试结果以十六进制形式打印在这个文件中。 */
	fn_bit = "test10_vector_bit.txt";  /**> 测试结果以二进制形式打印在这个文件中。 */
	fout_hex.open(fn_hex.c_str());
	fout_bit.open(fn_bit.c_str());

	fout_hex << "Enc K80:" << endl;
	fout_hex << setw(24) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Enc K80:" << endl;
	fout_bit << setw(20) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex << "  0x" << hex << setfill('0')
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[4]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[3]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[2]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[1]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[0];
		fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)(test_vector_plain[i]))[0] << setfill(' ') << dec << endl;

		fout_bit 
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;

		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 4)))
			<< "    " << setw(16) << " " << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key80[i%VN_KEY], 80, 0, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Enc_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 80);
			fout_hex << setw(24) << setfill(' ') << j << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

			fout_bit << setw(20) << setfill(' ') << j   << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
			fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
			fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
			fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
			fout_bit << endl;
		}
	}
	fout_hex << "Dec K80:" << endl;
	fout_hex << setw(24) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Dec K80:" << endl;
	fout_bit << setw(20) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex << "  0x" << hex << setfill('0')
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[4]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[3]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[2]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[1]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[0];
		fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)(test_vector_plain[i]))[0] << setfill(' ') << dec << endl;

		fout_bit 
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;

		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 4)))
			<< "    " << setw(16) << " " << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key80[i%VN_KEY], 80, 1, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Dec_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 80);
			fout_hex << setw(24) << setfill(' ') << j << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

			fout_bit << setw(20) << setfill(' ') << j   << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
			fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
			fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
			fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
			fout_bit << endl;
		}
	}

	fout_hex << "Enc K128:" << endl;
	fout_hex << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Enc K128:" << endl;
	fout_bit << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex
			<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_key128[i%VN_KEY])[1] << setw(16) << ((u64*)(test_vector_key128[i%VN_KEY]))[0]
		<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << endl;

		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key128[i%VN_KEY], 128, 0, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Enc_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 128);
			fout_hex << setw(36) << setfill(' ') << j << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

			fout_bit << setw(36) << setfill(' ') << j   << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
			fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
			fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
			fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
			fout_bit << endl;
		}
	}
	fout_hex << "Dec K128:" << endl;
	fout_hex << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Dec K128:" << endl;
	fout_bit << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex
			<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_key128[i%VN_KEY])[1] << setw(16) << ((u64*)(test_vector_key128[i%VN_KEY]))[0]
		<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << endl;

		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key128[i%VN_KEY], 128, 1, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Dec_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 128);
			fout_hex << setw(36) << setfill(' ') << j << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

			fout_bit << setw(36) << setfill(' ') << j   << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
			fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
			fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
			fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
			fout_bit << endl;
		}
	}

	fout_hex << endl;
	fout_hex.close();
	fout_bit << endl;
	fout_bit.close();

#undef LOOPN

#endif
	/** 测试 4 组示例，每组单独 10000 次循环加解密运算 */
#define LOOPN 10000

	fn_hex = "test10000_vector_hex.txt";   /**> 测试结果以十六进制形式打印在这个文件中。 */
	fn_bit = "test10000_vector_bit.txt";   /**> 测试结果以二进制形式打印在这个文件中。 */
	fout_hex.open(fn_hex.c_str());
	fout_bit.open(fn_bit.c_str());

	fout_hex << "Enc K80:" << endl;
	fout_hex << setw(24) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Enc K80:" << endl;
	fout_bit << setw(20) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex << "  0x" << hex << setfill('0')
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[4]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[3]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[2]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[1]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[0];
		fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)(test_vector_plain[i]))[0] << setfill(' ') << dec << endl;

		fout_bit 
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;

		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 4)))
			<< "    " << setw(16) << " " << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key80[i%VN_KEY], 80, 0, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Enc_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 80);
		}
		fout_hex << setw(24) << setfill(' ') << " " << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;
	}
	fout_hex << "Dec K80:" << endl;
	fout_hex << setw(24) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Dec K80:" << endl;
	fout_bit << setw(20) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex << "  0x" << hex << setfill('0')
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[4]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[3]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[2]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[1]
		<< setw(4) << ((u16*)(test_vector_key80[i%VN_KEY]))[0];
		fout_hex << "  0x" << setw(16) << hex << setfill('0') << ((u64*)(test_vector_plain[i]))[0] << setfill(' ') << dec << endl;

		fout_bit 
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;

		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_key80[i%VN_KEY], 4)))
			<< "    " << setw(16) << " " << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key80[i%VN_KEY], 80, 1, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Dec_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 80);
		}
		fout_hex << setw(24) << setfill(' ') << " " << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit << setw(20) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;
	}

	fout_hex << "Enc K128:" << endl;
	fout_hex << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Enc K128:" << endl;
	fout_bit << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex
			<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_key128[i%VN_KEY])[1] << setw(16) << ((u64*)(test_vector_key128[i%VN_KEY]))[0]
		<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << endl;

		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key128[i%VN_KEY], 128, 0, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Enc_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 128);
		}
		fout_hex << setw(36) << setfill(' ') << " " << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;
	}
	fout_hex << "Dec K128:" << endl;
	fout_hex << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	fout_bit << "Dec K128:" << endl;
	fout_bit << setw(36) << "key" << setw(20) << "plain/ciphertext" << endl;
	for (int i=0; i<VN; i++)
	{
		fout_hex
			<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_key128[i%VN_KEY])[1] << setw(16) << ((u64*)(test_vector_key128[i%VN_KEY]))[0]
		<< "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << endl;

		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 0)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 1)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 2)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit
			<< "    " << setw(32) << *(new bitset<32>((u64)word32_in(test_vector_key128[i%VN_KEY], 3)))
			<< "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;

		ctx_t ctx;
		Key_Schedule(test_vector_key128[i%VN_KEY], 128, 1, ctx.key);
		for (int j = 1; j <= LOOPN; j++)
		{
			Crypt_Dec_Block(test_vector_plain[i], 8, test_vector_plain[i], &out_len, ctx.key, 128);
		}
		fout_hex << setw(36) << setfill(' ') << " " << "  0x" << setw(16) << hex << setfill('0') << ((u64*)test_vector_plain[i])[0] << setfill(' ') << dec << endl;

		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 0))) << endl;
		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 1))) << endl;
		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 2))) << endl;
		fout_bit << setw(36) << setfill(' ') << " " << "    " << setw(16) << *(new bitset<16>(word16_in(test_vector_plain[i], 3))) << endl;
		fout_bit << endl;
	}

	fout_hex << endl;
	fout_hex.close();
	fout_bit << endl;
	fout_bit.close();
}
