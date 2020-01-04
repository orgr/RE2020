// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"
#include <Shlwapi.h>
#include <stdio.h>
#include <iostream>

#pragma warning(disable : 4996)

//const char* query = "\nfrom django.db.models import *; codes = Code.query.all();";
//const char* query = "\nprint([code for code in Event.query.filter_by(key='ROBBER_CAPTURED').first().codes if not code.used][0].code);#";
const char* query = "\nprint('ROBBER_CAPTURED');#";
LPVOID hooked_function;

DWORD IATOffset = 0x91F0;
typedef BOOL(__stdcall* Func)(HANDLE,
							  LPVOID,
							  DWORD,
							  LPDWORD,
							  LPOVERLAPPED);
Func RealReadFile;

BOOL FakeReadFile(HANDLE       hFile,
	                  LPVOID       lpBuffer,
	                  DWORD        nNumberOfBytesToRead,
	                  LPDWORD      lpNumberOfBytesRead,
	                  LPOVERLAPPED lpOverlapped)
{
	BOOL Result = RealReadFile(hFile, lpBuffer, nNumberOfBytesToRead, lpNumberOfBytesRead, lpOverlapped);
	printf("%s", lpBuffer);
	return Result;
}

const char* CreateQuery()
{
	return query;
}

__declspec(naked) void PythonCommandsHook()
{
	static LPVOID originalRet;

	__asm {
		call 	CreateQuery

		push    ebp
		mov     ebp, esp
		push	edi
		push	esi
		push	ebx
		add 	esp, 0FFFFFF80h

		mov 	ebx, eax; The pointer to the updated query will be in eax
		lea 	eax, [ebp - 80h]

		mov		ecx, hooked_function
		add		ecx, 11h
		jmp		ecx
	}
}
__declspec(naked) void PythonCommandsHookEnd() {}



void SetoPythonCommandsHook() {
	HMODULE prog = GetModuleHandle(L"codes.exe");
	CHAR  JmpOpcode[7] = "\xE9\x90\x90\x90\x90\x90";
	DWORD lpProtect = 0;
	LPVOID JumpTo;
	if (prog == NULL) {
		return;
	}
	hooked_function = (char*)prog + 0x1410;

	JumpTo = (LPVOID)((char*)&PythonCommandsHook - ((char*)hooked_function + 5));
	memcpy(JmpOpcode + 1, &JumpTo, 0x4);
	VirtualProtect((char*)hooked_function, 0x6, PAGE_EXECUTE_READWRITE, &lpProtect);
	memcpy((char*)hooked_function, &JmpOpcode, 0x6);
	VirtualProtect((char*)hooked_function, 0x6, PAGE_EXECUTE_READ, &lpProtect);
}


void SetReadFileIATHook() {
	LPVOID f;
	HMODULE h = GetModuleHandle(L"codes.exe");
	HMODULE kernel32 = GetModuleHandle(L"kernel32.dll");
	CHAR JmpOpcode2[8] = "\xB8\x90\x90\x90\x90\xFF\xE0";
	DWORD lpProtect = 0;
	LPVOID JumpTo;
	LPVOID IAT;
	if ((h == NULL) || (kernel32 == NULL))
		return;
	f = GetProcAddress(kernel32, "ReadFile");
	if (f == NULL)
		return;
	RealReadFile = (Func)f;
	IAT = h + IATOffset / 4;
	VirtualProtect((char*)IAT, 0x4, PAGE_EXECUTE_READWRITE, &lpProtect);
	JumpTo = (LPVOID)((char*)&FakeReadFile);

	memcpy(IAT, &JumpTo, 0x4);
	memcpy(JmpOpcode2 + 1, &f, 0x4);
	VirtualProtect((char*)FakeReadFile, 0x100, PAGE_EXECUTE_READWRITE, &lpProtect);
	memcpy((char*)&FakeReadFile + 0x1f, &JmpOpcode2, 0x7);
}

BOOL APIENTRY DllMain(HMODULE hModule,
	DWORD  ul_reason_for_call,
	LPVOID lpReserved
)
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		SetoPythonCommandsHook();
		SetReadFileIATHook();
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}