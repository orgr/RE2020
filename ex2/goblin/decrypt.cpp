// decrypt.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <vector>
#pragma warning(disable : 4996)
const int blockSize = 4;

enum args
{
	SELF_NAME,
	ROUNDS,
	DELTA,
	ENCRYPTED_PASSWORD,
	KEY
};

std::vector<char> StringToBytes(char* input);
void runRound(char input[2 * blockSize], char* output, long delta, char* key);

int main(int argc, char** argv)
{
	long rounds = strtol(argv[ROUNDS], 0, 0x10);
	long delta = strtol(argv[DELTA], 0, 0x10);
	char* key = argv[KEY];
	char* encrypted_password = argv[ENCRYPTED_PASSWORD];

	char result[8];

	for (int i = 0; i < rounds; i++)
	{
		runRound(encrypted_password, result, delta, key);
		strncpy(encrypted_password, result, sizeof(char) * 2 * blockSize);
	}

	return 0;
}


unsigned long string2ByteArray(char* input, int input_len)
{
	std::vector<char> bytes;
	int i = 0;
	for (int i = 0; i < input_len; i++)
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


void runRound(char input[2 * blockSize], char* output, long delta, char* key)
{
	unsigned long hexString;
	hexString = string2ByteArray(input, blockSize);
	std::cout << hexString;

}

