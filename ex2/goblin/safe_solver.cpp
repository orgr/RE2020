#include <iostream>
#include <windows.h>

#define SUPER_SECRET_PIPE_NAME "\\\\.\\pipe\\SuperSecretPipe"
#define BUFFER_SIZE 0x400
int main()
{

	TCHAR writeBuffer[BUFFER_SIZE]{};
	TCHAR readBuffer[BUFFER_SIZE];
	LPCSTR pipeName = SUPER_SECRET_PIPE_NAME;
	DWORD bytesToRead;
	bool fSuccess;
	fSuccess = CallNamedPipeA(
		pipeName,
		writeBuffer,
		BUFFER_SIZE * sizeof(TCHAR),
		readBuffer,
		BUFFER_SIZE * sizeof(TCHAR),
		&bytesToRead,
		20*1000);
	
	Sleep(5 * 1000);
	if (fSuccess)
	{
		std::cout << readBuffer;
	}
	else
	{
		std::cout << "Error " << GetLastError();
	}
    
}
