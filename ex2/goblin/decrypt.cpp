// decrypt.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <vector>
#include <string>
#include <cmath>
#pragma warning(disable : 4996)
#define MAX_LONG_32 2147483647
const int blockSize = 4;

enum args
{
	SELF_NAME,
	ROUNDS,
	DELTA,
	ENCRYPTED_PASSWORD,
	KEY
};

unsigned long string2ByteArray(char* input, int input_len);
void long2Block(unsigned long input, int input_len, std::vector<char> *result);
void encryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, char* key, int idx);
void decryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, char* key, int idx);

int main(int argc, char** argv)
{
	unsigned int rounds = strtol(argv[ROUNDS], 0, 0x10);
	unsigned int delta = MAX_LONG_32;
	char* key = argv[KEY];
	char* encrypted_password = argv[ENCRYPTED_PASSWORD];
	unsigned int pass_0 = string2ByteArray(encrypted_password, blockSize);
	unsigned int pass_1 = string2ByteArray(encrypted_password + blockSize, blockSize);

	for (int j = rounds - 1; j >= 0; --j)
	{
		decryptRound(&pass_0, &pass_1, delta, key, j);
	}

	std::vector<char> res_0;
	std::vector<char> res_1;
	long2Block(pass_0, blockSize, &res_0);
	long2Block(pass_1, blockSize, &res_1);

	res_0.insert( res_0.end(), res_1.begin(), res_1.end());
	for (std::vector<char>::iterator it = res_0.begin() ; it != res_0.end(); ++it)
	{
		std::cout << *it;
	}

	return 0;
}


void long2Block(unsigned long input, int input_len, std::vector<char> *result) {
	for (int i = 0; i < input_len; ++i)
	{
		unsigned long tmp = (input - ((unsigned long)(input / pow(16, 2 * i + 2)) * pow(16, 2 * i + 2))) / (pow(256, i));
		input -= tmp;
		result->insert(result->begin(), char(tmp));
	}
}


unsigned long string2ByteArray(char* input, int input_len)
{
	std::vector<char> bytes;
	int i = 0;
	for (i = 0; i < input_len; i++)
	{
		bytes.push_back((char)*(input+i));
	}

	unsigned long result = 0;
	int j = 0;
	for (j=0; j < input_len; j++)
	{
		result += (bytes[j] << (4 * (input_len + 2 - (2*j))));
	}
	return result;
}


void encryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, char* key, int idx)
{
	unsigned int key_0 = string2ByteArray(key, blockSize);
	unsigned int key_1 = string2ByteArray(key + blockSize, blockSize);
	unsigned int key_2 = string2ByteArray(key + 2 * blockSize, blockSize);
	unsigned int key_3 = string2ByteArray(key + 3 * blockSize, blockSize);

	delta = (idx + 1) * delta;
	*pass_0 = ( (((*pass_1 << 4) + key_0) ^ (*pass_1 + delta)) ^ ((*pass_1 >> 5) + key_1) ) + *pass_0;
	*pass_1 = ( (((*pass_0 << 4) + key_2) ^ (*pass_0 + delta)) ^ ((*pass_0 >> 5) + key_3) ) + *pass_1;
}


void decryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, char* key, int idx) {
	unsigned int key_0 = string2ByteArray(key, blockSize);
	unsigned int key_1 = string2ByteArray(key + blockSize, blockSize);
	unsigned int key_2 = string2ByteArray(key + 2 * blockSize, blockSize);
	unsigned int key_3 = string2ByteArray(key + 3 * blockSize, blockSize);

	delta = (idx + 1) * delta;
	*pass_1 -= ( (((*pass_0 << 4) + key_2) ^ (*pass_0 + delta)) ^ ((*pass_0 >> 5) + key_3) );
	*pass_0 -= ( (((*pass_1 << 4) + key_0) ^ (*pass_1 + delta)) ^ ((*pass_1 >> 5) + key_1) );
}

