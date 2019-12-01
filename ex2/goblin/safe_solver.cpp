#include <iostream>
#include <windows.h>

#define BUFFER_SIZE 0x400
#define INITIAL_SLEEP 5 // how many seconds to sleep before execution

#pragma once
#pragma warning(disable : 4996)

BOOL sendMessage(HANDLE&, LPCSTR);
VOID recieveReply(HANDLE&, char*);
int main()
{
	Sleep(INITIAL_SLEEP * 1000);
	// open dictionary file
	FILE* dictFile = fopen("dictionary.txt", "r");
	
	
		
	// Listen to goblin safe's pipe server
#pragma region Listen
	LPCSTR Goblin_pipeName = "\\\\.\\pipe\\SuperSecretPipe";
	
	HANDLE Goblin_hPipe;
	
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
#pragma endregion
	// Create local pipe server
#pragma region CreateLocal
	LPCSTR Local_pipeName = "\\\\.\\pipe\\SecretAnswerPipe";
	HANDLE Local_hPipe;
	bool Local_fConnected;
	Local_hPipe = CreateNamedPipeA(Local_pipeName, 3, 0, 1, BUFFER_SIZE, BUFFER_SIZE, 0x1D4C0, 0);
	Local_fConnected = ConnectNamedPipe(Local_hPipe, 0);
	// if a client connected fConnected would be 0
	if (!Local_fConnected) {
		std::cout << "client didnt connect" << std::endl;
		return -1;
	}

#pragma endregion
	
#pragma region SendPasswords
	char localPasswordBuffer[BUFFER_SIZE];
	char responseBuffer[BUFFER_SIZE];
	BOOL fSuccess;
	while (fgets(localPasswordBuffer, BUFFER_SIZE, dictFile)) {
		// send a password
		fSuccess = sendMessage(Goblin_hPipe, localPasswordBuffer);
		if (!fSuccess)
		{
			std::cout << TEXT("WriteFile to pipe failed. GLE=") << GetLastError() << std::endl;
			return -1;
		}
		else
		{
			recieveReply(Local_hPipe, responseBuffer);
			std::cout << "Recieved message: " << responseBuffer;
		}
	}

	
#pragma endregion

	std::cout << "\n<End of message, press ENTER to terminate connection and exit>";

	CloseHandle(Goblin_hPipe);
	CloseHandle(Local_hPipe);
	return 0;
}

#pragma region Helpers
BOOL sendMessage(HANDLE& hPipe, LPCSTR lpvMessage) {
	DWORD cbToWrite = (strlen(lpvMessage) + 1) * sizeof(TCHAR);
	DWORD cbWritten;
	std::cout << "Sending " << cbToWrite << " bytes --> message: " << lpvMessage;

	return WriteFile(
		hPipe,                  // pipe handle 
		lpvMessage,             // message 
		cbToWrite,              // message length 
		&cbWritten,             // bytes written 
		NULL);                  // not overlapped 
}

VOID recieveReply(HANDLE& hPipe, char* lpvResponse) {
	BOOL fSuccess;
	DWORD cbToRead;
	do
	{
		// Read from the pipe. 

		fSuccess = ReadFile(
			hPipe,    // pipe handle 
			lpvResponse,    // buffer to receive reply 
			BUFFER_SIZE * sizeof(TCHAR),  // size of buffer 
			&cbToRead,  // number of bytes read 
			NULL);    // not overlapped 

		if (!fSuccess && GetLastError() != ERROR_MORE_DATA)
			break;

	} while (!fSuccess);  // repeat loop if ERROR_MORE_DATA 

	if (!fSuccess)
	{
		std::cout << (TEXT("ReadFile from pipe failed. GLE=%d\n"), GetLastError());
		return;
	}
}
#pragma endregion