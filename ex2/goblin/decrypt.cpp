// decrypt.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <vector>
#include <cmath>
#include <sstream>
#include <cstring>

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

unsigned int string2ByteArray(char* input, int input_len);
void long2Block(unsigned long input, int input_len, std::vector<char> *result);
void encryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, unsigned int *keys, int idx);
void decryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, unsigned int *keys, int idx);

int main(int argc, char** argv)
{
    char* key = argv[KEY];
    char* encrypted_password = argv[ENCRYPTED_PASSWORD];
    unsigned int rounds = (unsigned int)strtol(argv[ROUNDS], nullptr, 0x10);
    unsigned int delta = MAX_LONG_32;
    unsigned long pass = strtoul(encrypted_password, 0, 0x10);
    unsigned int key_0 = string2ByteArray(key, blockSize);
    unsigned int key_1 = string2ByteArray(key + blockSize, blockSize);
    unsigned int key_2 = string2ByteArray(key + 2 * blockSize, blockSize);
    unsigned int key_3 = string2ByteArray(key + 3 * blockSize, blockSize);
    unsigned int key_blocks[4] = {key_0, key_1, key_2, key_3};

    unsigned pass_0 = (unsigned int)(pass / pow(256, 4));
    unsigned pass_1 = (unsigned int)(pass % (long)(pow(256, 4)));

	for (int j = rounds - 1; j >= 0; --j)
	{
		decryptRound(&pass_0, &pass_1, delta, key_blocks, j);
	}

	std::vector<char> res_0;
	std::vector<char> res_1;
	long2Block(pass_0, blockSize, &res_0);
	long2Block(pass_1, blockSize, &res_1);

	res_0.insert( res_0.end(), res_1.begin(), res_1.end());
	for (char &it : res_0)
    {
		std::cout << it;
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


unsigned int string2ByteArray(char* input, int input_len)
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
	return (unsigned int)result;
}


void encryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, unsigned int *keys, int idx)
{
	delta = (idx + 1) * delta;
	*pass_0 = ( (((*pass_1 << 4) + keys[0]) ^ (*pass_1 + delta)) ^ ((*pass_1 >> 5) + keys[1]) ) + *pass_0;
	*pass_1 = ( (((*pass_0 << 4) + keys[2]) ^ (*pass_0 + delta)) ^ ((*pass_0 >> 5) + keys[3]) ) + *pass_1;
}


void decryptRound(unsigned int *pass_0, unsigned int *pass_1, unsigned int delta, unsigned int *keys, int idx)
{
	delta = (idx + 1) * delta;
	*pass_1 -= ( (((*pass_0 << 4) + keys[2]) ^ (*pass_0 + delta)) ^ ((*pass_0 >> 5) + keys[3]) );
	*pass_0 -= ( (((*pass_1 << 4) + keys[0]) ^ (*pass_1 + delta)) ^ ((*pass_1 >> 5) + keys[1]) );
}
