// dllinjector.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>

#include <windows.h>
#include <stdio.h>
#include <tlhelp32.h>
#include <Shlwapi.h>

#define DLL_PATH "Client.dll"
//#define DLL_PATH "C:\\Users\\Or\\Desktop\\Reverse Engineering\\hook1dll\\hook1dll\\Debug\\HOOK1DLL.dll"
//#define PROCESS_NAME "C:\\Users\\Or\\Desktop\\Reverse Engineering\\exercises_repo\\ex3\\2nd stage\\client.exe"
#define true 1
#define false 0


BOOL dllInjector(const char* dllpath, DWORD pID);


int main(int argc, char* argv[])
{

	// Create Process SUSPENDED
	PROCESS_INFORMATION pi;
	STARTUPINFOA Startup;
	ZeroMemory(&Startup, sizeof(Startup));
	ZeroMemory(&pi, sizeof(pi));
	char* processName = argv[1];
	CreateProcessA(processName, LPSTR("< DMSG"), NULL, NULL, NULL, CREATE_SUSPENDED, NULL, NULL, &Startup, &pi);

	if (!(dllInjector(DLL_PATH, pi.dwProcessId)))
		return 1;

	Sleep(1000); // Let the DLL finish loading
	ResumeThread(pi.hThread);
	return 0;
}

BOOL dllInjector(const char* dllpath, DWORD pID)
{
	HANDLE pHandle;
	LPVOID remoteString;
	LPVOID remoteLoadLib;

	pHandle = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pID);

	if (!pHandle)
		return false;

	remoteLoadLib = (LPVOID)GetProcAddress(GetModuleHandle(TEXT("kernel32.dll")), "LoadLibraryA");

	remoteString = (LPVOID)VirtualAllocEx(pHandle, NULL, strlen(DLL_PATH) + 1, MEM_RESERVE | MEM_COMMIT, PAGE_READWRITE);
	WriteProcessMemory(pHandle, (LPVOID)remoteString, dllpath, strlen(dllpath), NULL);
	if (NULL == CreateRemoteThread(pHandle, NULL, NULL, (LPTHREAD_START_ROUTINE)remoteLoadLib, (LPVOID)remoteString, NULL, NULL)) {
		return false;
	}
	CloseHandle(pHandle);

	return true;
}
