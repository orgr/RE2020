main:
        lea     ecx, [esp+4]
        and     esp, -16
        push    DWORD PTR [ecx-4]
        push    ebp
        mov     ebp, esp
        push    ecx
        sub     esp, 292
        mov     DWORD PTR [ebp-12], 0
        jmp     L13
L14:
        mov     eax, DWORD PTR [ebp-12]
        mov     DWORD PTR [ebp-296+eax*4], 0
        add     DWORD PTR [ebp-12], 1
L13:
        cmp     DWORD PTR [ebp-12], 4
        jle     L14
        jmp     L15
L19:
        lea     eax, [ebp-275]
        push    eax
        call    chomp
        add     esp, 4
        lea     eax, [ebp-275]

        push    0x0             # push null
        push    0x64616F72      # push d,a,o,r
        mov     ebx, esp

        push    ebx
        push    eax
        call    strcmpr
        add     esp, 8
        test    eax, eax
        jne     L16
        mov     eax, DWORD PTR [ebp-296]
        add     eax, 1
        mov     DWORD PTR [ebp-296], eax
        mov     eax, DWORD PTR [ebp-292]
        add     eax, 1
        mov     DWORD PTR [ebp-292], eax
        jmp     L15
L16:
        lea     eax, [ebp-275]

        push    0x0000746E                      # push 0,0,t,n
        push    0x656D656C                      # push e,m,e,l
        push    0x74746573                      # push t,t,e,s
        mov     ebx, esp

        push    ebx
        push    eax
        call    strcmpr
        add     esp, 8
        test    eax, eax
        jne     L17
        mov     eax, DWORD PTR [ebp-296]
        add     eax, 1
        mov     DWORD PTR [ebp-296], eax
        mov     eax, DWORD PTR [ebp-292]
        add     eax, 1
        mov     DWORD PTR [ebp-292], eax
        mov     eax, DWORD PTR [ebp-288]
        add     eax, 1
        mov     DWORD PTR [ebp-288], eax
        mov     eax, DWORD PTR [ebp-284]
        add     eax, 1
        mov     DWORD PTR [ebp-284], eax
        jmp     L15
L17:
        lea     eax, [ebp-275]
       
        push    0x0                     # push null
        push    0x79746963              # push y,t,i,c
        mov     ebx, esp

        push    ebx        
        push    eax
        call    strcmpr
        add     esp, 8
        test    eax, eax
        jne     L18
        mov     eax, DWORD PTR [ebp-284]
        add     eax, 2
        mov     DWORD PTR [ebp-284], eax
        mov     eax, DWORD PTR [ebp-280]
        add     eax, 3
        mov     DWORD PTR [ebp-280], eax
        jmp     L15
L18:
        lea     eax, [ebp-275]

        push    0x00746E65              # push 0,t,n,e
        push    0x6D706F6C              # push m,p,o,l
        push    0x65766564              # push e,v,e,d
        mov     ebx, esp

        push    ebx
        push    eax
        call    strcmpr
        add     esp, 8
        test    eax, eax
        jne     L15
        mov     eax, DWORD PTR [ebp-288]
        add     eax, 1
        mov     DWORD PTR [ebp-288], eax
        mov     eax, DWORD PTR [ebp-284]
        add     eax, 1
        mov     DWORD PTR [ebp-284], eax
        mov     eax, DWORD PTR [ebp-280]
        add     eax, 1
        mov     DWORD PTR [ebp-280], eax
L15:
        push 0x00007325         # pushing ",s,%,"
        mov ebx, esp            # this will be the address pointing to the string "%s"

        sub     esp, 8
        lea     eax, [ebp-275]
        push    eax             # pushing input variable for scanf
        push ebx
        call GetScanF
        call eax
        add esp, 4

        add     esp, 16
        cmp     eax, -1
        jne     L19
        mov     DWORD PTR [ebp-16], 0
        jmp     L20
L22:
        push    0x0             # pushing \0
        mov     ebx, esp        

        mov     DWORD PTR [ebp-20], ebx
        mov     eax, DWORD PTR [ebp-16]
        mov     eax, DWORD PTR [ebp-296+eax*4]
        cmp     eax, 9
        jg      L21

        push    0x30            # pushing null, '0'
        mov     ebx, esp

        mov     DWORD PTR [ebp-20], ebx
L21:
        mov     eax, DWORD PTR [ebp-16]
        mov     eax, DWORD PTR [ebp-296+eax*4]
        sub     esp, 4

        push    0x00000020                      # push 0,space
        push    0x64257325                      # push d,%,s,%
        mov     ebx, esp

        push    eax
        push    DWORD PTR [ebp-20]
        push    ebx
        
        call GetPrintF
        call eax
        add     esp, 16
        add     DWORD PTR [ebp-16], 1
L20:
        cmp     DWORD PTR [ebp-16], 4
        jle     L22
        mov     eax, 0
        mov     ecx, DWORD PTR [ebp-4]
        leave
        lea     esp, [ecx-4]
        ret

GetScanF:

        push ebp            # store ebp
        mov ebp, esp

        push 0x0                # pushing null
        push 0x41797261         # pushing A,y,r,a
        push 0x7262694c         # pushing r,b,i,L
        push 0x64616f4c         # pushing d,a,o,L
        push esp            # push pointer for "LoadLibraryA"

        call FindFunction   # call FindFunction("LoadLibraryA")
        add esp, 0x14       # clear stack

        push 0x00006c6c         # pushing null,l,l
        push 0x642e7472         # pushing d,,t,r
        push 0x6376736d         # pushing c,v,s,m
        push esp

        call eax            # call LoadLibrary("msvcrtdll")
        add esp, 0x0c       # clear stack (note arguments are cleared already)

        push eax            # store module handle for msvcrt
        push 0x00007373         # pushing null,s,s
        push 0x65726464         # pushing e,r,d,d
        push 0x41636f72         # pushing A,c,o,r
        push 0x50746547         # pushing P,t,e,G
        push esp            # push pointer for "GetProcAddress"

        call FindFunction   # call FindFunction("GetProcAddress")
        add esp, 0x14       # clear stack
        pop ebx             # restore module handle for msvcrt

        push 0x00000066         # pushing null,f
        push 0x6e616373         # pushing n,a,c,s
        push esp            # push pointer for "scanf"
        push ebx            # push module handle for msvcrt

        call eax            # call GetProcAddress(msvcrt, "scanf")
        add esp, 0x08       # clear stack (note arguments are cleared already)

        pop ebp             # restore ebp
        ret                 # return

GetPrintF:
        push ebp            # store ebp
        mov ebp, esp

        push 0x0                # pushing null
        push 0x41797261         # pushing A,y,r,a
        push 0x7262694c         # pushing r,b,i,L
        push 0x64616f4c         # pushing d,a,o,L
        push esp            # push pointer for "LoadLibraryA"

        call FindFunction   # call FindFunction("LoadLibraryA")
        add esp, 0x14       # clear stack

        push 0x00006c6c         # pushing null,l,l
        push 0x642e7472         # pushing d,,t,r
        push 0x6376736d         # pushing c,v,s,m
        push esp

        call eax            # call LoadLibrary("msvcrtdll")
        add esp, 0x0c       # clear stack (note arguments are cleared already)

        push eax            # store module handle for msvcrt
        push 0x00007373         # pushing null,s,s
        push 0x65726464         # pushing e,r,d,d
        push 0x41636f72         # pushing A,c,o,r
        push 0x50746547         # pushing P,t,e,G
        push esp            # push pointer for "GetProcAddress"

        call FindFunction   # call FindFunction("GetProcAddress")
        add esp, 0x14       # clear stack
        pop ebx             # restore module handle for msvcrt

        push 0x00006674         # pushing null,f,t
        push 0x6e697270         # pushing n,i,r,p
        push esp            # push pointer for "printf"
        push ebx            # push module handle for msvcrt

        call eax            # call GetProcAddress(msvcrt, "printf")
        add esp, 0x08       # clear stack (note arguments are cleared already)

        pop ebp             # restore ebp
        ret                 # return

strcmpr:
        push    ebp
        mov     ebp, esp
        cmp     DWORD PTR [ebp+8], 0
        je      L2
        cmp     DWORD PTR [ebp+12], 0
        jne     L5
L2:
        mov     eax, 1
        jmp     L4
L7:
        add     DWORD PTR [ebp+8], 1
        add     DWORD PTR [ebp+12], 1
L5:
        mov     eax, DWORD PTR [ebp+8]
        movzx   eax, BYTE PTR [eax]
        test    al, al
        je      L6
        mov     eax, DWORD PTR [ebp+12]
        movzx   eax, BYTE PTR [eax]
        test    al, al
        je      L6
        mov     eax, DWORD PTR [ebp+8]
        movzx   edx, BYTE PTR [eax]
        mov     eax, DWORD PTR [ebp+12]
        movzx   eax, BYTE PTR [eax]
        cmp     dl, al
        je      L7
L6:
        mov     eax, DWORD PTR [ebp+8]
        movzx   edx, BYTE PTR [eax]
        mov     eax, DWORD PTR [ebp+12]
        movzx   eax, BYTE PTR [eax]
        cmp     dl, al
        setne   al
        movzx   eax, al
L4:
        pop     ebp
        ret
chomp:
        push    ebp
        mov     ebp, esp
        jmp     L9
L11:
        add     DWORD PTR [ebp+8], 1
L9:
        mov     eax, DWORD PTR [ebp+8]
        movzx   eax, BYTE PTR [eax]
        test    al, al
        je      L10
        mov     eax, DWORD PTR [ebp+8]
        movzx   eax, BYTE PTR [eax]
        cmp     al, 10
        je      L10
        mov     eax, DWORD PTR [ebp+8]
        movzx   eax, BYTE PTR [eax]
        cmp     al, 13
        jne     L11
L10:
        mov     eax, DWORD PTR [ebp+8]
        mov     BYTE PTR [eax], 0
        nop
        pop     ebp
        ret

FindFunction:
