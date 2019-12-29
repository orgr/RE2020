// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"
#include <cstdio>
#include <WinSock2.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>


DWORD IATOffset = 0xA29C;

typedef void(__stdcall* Func)(SOCKET, char*, int, int);
Func RealRecv;

void decryptSecurePipe(char* buf, int len) {
	std::vector<char> input(buf, buf + len);
	char a, b, c, d, resChar;
	int tmpCharA, tmpCharB;
	
	bool extendedChar;
	std::string result;

	int i = 0;
	while (i < input.size())
	{
		a = input[i];
		b = i + 1 < input.size() ? input[i + 1] : 0;
		c = i + 2 < input.size() ? input[i + 2] : 0;
		d = i + 3 < input.size() ? input[i + 3] : 0;
		if (a == 0 && b == 0 && c == 0 && d == 0)
		{
			break;
		}
		/*if (a == '\n')
		{
			std::cout << result << std::endl;
			result.clear();
			i++;
			continue;
		}*/

		extendedChar = (c == '+' || c == '-');

		tmpCharA = a - '0';
		tmpCharB = b - '0';

		if (b == 'J') {
			tmpCharB = 0xA;
		}
		else if (b == 'Q')
		{
			tmpCharB = 0xB;
		}
		else if (b == 'K')
		{
			tmpCharB = 0xC;
		}
		else if (b == 'A')
		{
			tmpCharB = 0x1;
		}

		if (extendedChar)
		{
			if (c == '+')
			{
				tmpCharB = b + d - (2 * '0');
			}
			else if (c == '-')
			{
				tmpCharB = b - d;
			}

			i += 4;
		}
		else
		{
			i += 2;
		}

		//std::cout << "(" << tmpCharA << "," << tmpCharB << ")";
		tmpCharA = tmpCharA * 16 + tmpCharB;
		if (tmpCharA < 0)
		{
			result.append("\n");
			continue;
		}
		resChar = (char)tmpCharA;
		result.append(std::string(1, resChar));
	}
	std::cout << result;
	//strcpy_s(buf, result.size(), result.c_str());
}

void fakeRecv(SOCKET s, char* buf, int len, int flags) {
	decryptSecurePipe(buf, len);
	return RealRecv(s, buf, len, flags);
}

void setIATHook()
{
	LPVOID f;
	HMODULE h = GetModuleHandle(L"client.exe");
	HMODULE ws2_32 = GetModuleHandle(L"ws2_32.dll");
	CHAR JmpOpcode2[8] = "\xB8\x90\x90\x90\x90\xFF\xE0";
	DWORD lpProtect = 0;
	LPVOID JumpTo;
	LPVOID IAT;
	if ((h == NULL) || (ws2_32 == NULL))
		return;
	f = GetProcAddress(ws2_32, "recv");
	if (f == NULL)
		return;
	RealRecv = (Func) f;
	IAT = h + IATOffset / 4;
	VirtualProtect((char*)IAT, 0x4, PAGE_EXECUTE_READWRITE, &lpProtect);
	JumpTo = (LPVOID)((char*)&fakeRecv);

	memcpy(IAT, &JumpTo, 0x4);
	memcpy(JmpOpcode2 + 1, &f, 0x4);
	VirtualProtect((char*)fakeRecv, 0x100, PAGE_EXECUTE_READWRITE, &lpProtect);
	memcpy((char*)&fakeRecv + 0x1f, &JmpOpcode2, 0x7);
}

BOOL APIENTRY DllMain(HMODULE hModule,
	DWORD  ul_reason_for_call,
	LPVOID lpReserved
)
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		setIATHook();
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}