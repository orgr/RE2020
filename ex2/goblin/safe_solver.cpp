#include <iostream>
#include <windows.h>
#include "safe_solver.h"

#define SUPER_SECRET_PIPE_NAME 
#define BUFFER_SIZE 0x400

#pragma once

int main()
{
	Sleep(3000);

	// Listen to goblin safe's pipe server
	LPCSTR Goblin_pipeName = "\\\\.\\pipe\\SuperSecretPipe";
	TCHAR Goblin_writeBuffer[BUFFER_SIZE]{};
	TCHAR Goblin_readBuffer[BUFFER_SIZE];
	DWORD Goblin_cbToRead;
	HANDLE Goblin_hPipe;
	bool Goblin_fSuccess;
	
	while (true)
	{
		Goblin_hPipe = CreateFileA(Goblin_pipeName, GENERIC_WRITE, 0, 0, 3, 0x80, 0);

		if (Goblin_hPipe != INVALID_HANDLE_VALUE)
		{
			break;
		}

		// Exit if an error other than ERROR_PIPE_BUSY occurs. 

		if (GetLastError() != ERROR_PIPE_BUSY)
		{
			std::cout << "Could not open pipe. GLE=" << GetLastError() << std::endl;
			return -1;
		}

		// All pipe instances are busy, so wait for 20 seconds. 

		if (!WaitNamedPipeA(Goblin_pipeName, 20000))
		{
			std::cout << "Could not open pipe: 20 second wait timed out." << std::endl;
			return -1;
		}

	}

	// Create a local pipe server
	LPCSTR Local_pipeName = "\\\\.\\pipe\\SecretAnswerPipe";
	TCHAR Local_writeBuffer[BUFFER_SIZE]{};
	TCHAR Local_readBuffer[BUFFER_SIZE];
	HANDLE Local_hPipe;
	bool Local_fConnected;
	Local_hPipe = CreateNamedPipeA(Local_pipeName, 3, 0, 1, BUFFER_SIZE, BUFFER_SIZE, 0x1D4C0, 0);
	Local_fConnected = ConnectNamedPipe(Local_hPipe, 0);
	// if a client connected fConnected would be 0
	if (!Local_fConnected) {
		std::cout << "client didnt connect" << std::endl;
		return -1;
	}

	
	
	// Send a message (try a password from the dictionary) to the pipe server. 

	LPCSTR lpvMessage = "MESSAGE";
	DWORD cbToWrite = (strlen(lpvMessage) + 1) * sizeof(TCHAR);
	DWORD cbWritten;
	std::cout << (TEXT("Sending %d byte message: \"%s\"\n"), cbToWrite, lpvMessage);

	Goblin_fSuccess = WriteFile(
		Goblin_hPipe,                  // pipe handle 
		lpvMessage,             // message 
		cbToWrite,              // message length 
		&cbWritten,             // bytes written 
		NULL);                  // not overlapped 

	if (!Goblin_fSuccess)
	{
		std::cout << TEXT("WriteFile to pipe failed. GLE=") << GetLastError() << std::endl;
		return -1;
	}

	printf("\nMessage sent to server, receiving reply as follows:\n");

	do
	{
		// Read from the pipe. 

		Goblin_fSuccess = ReadFile(
			Goblin_hPipe,    // pipe handle 
			Goblin_readBuffer,    // buffer to receive reply 
			BUFFER_SIZE * sizeof(TCHAR),  // size of buffer 
			&Goblin_cbToRead,  // number of bytes read 
			NULL);    // not overlapped 

		if (!Goblin_fSuccess && GetLastError() != ERROR_MORE_DATA)
			break;

		std::cout << Goblin_readBuffer;
	} while (!Goblin_fSuccess);  // repeat loop if ERROR_MORE_DATA 

	if (!Goblin_fSuccess)
	{
		std::cout << (TEXT("ReadFile from pipe failed. GLE=%d\n"), GetLastError());
		return -1;
	}

	std::cout << "\n<End of message, press ENTER to terminate connection and exit>";

	CloseHandle(Goblin_hPipe);
	return 0;
}
