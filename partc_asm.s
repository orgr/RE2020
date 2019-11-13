.file   "partc.s"
.intel_syntax noprefix
.def    ___main;        .scl    2;      .type   32;     .endef
.section .rdata,"dr"
.section        .text.startup,"x"
.globl  _main
.def    _main;  .scl    2;      .type   32;     .endef



chomp:
        push    ebp
        mov     ebp, esp
        jmp     .L2
.L4:
        add     DWORD PTR [ebp+8], 1
.L2:
        mov     eax, DWORD PTR [ebp+8]
        movzx   eax, BYTE PTR [eax]
        test    al, al
        je      .L3
        mov     eax, DWORD PTR [ebp+8]
        movzx   eax, BYTE PTR [eax]
        cmp     al, 10
        je      .L3
        mov     eax, DWORD PTR [ebp+8]
        movzx   eax, BYTE PTR [eax]
        cmp     al, 13
        jne     .L4
.L3:
        mov     eax, DWORD PTR [ebp+8]
        mov     BYTE PTR [eax], 0
        nop
        pop     ebp
        ret
.LC0:
        .string "road"
.LC1:
        .string "settlement"
.LC2:
        .string "city"
.LC3:
        .string "development"
.LC4:
        .string "%s"
.LC5:
        .string ""
.LC6:
        .string "0"
.LC7:
        .string "%s%d "
main:
        lea     ecx, [esp+4]
        and     esp, -16
        push    DWORD PTR [ecx-4]
        push    ebp
        mov     ebp, esp
        push    ecx
        sub     esp, 292
        mov     DWORD PTR [ebp-12], 0
        jmp     .L6
.L7:
        mov     eax, DWORD PTR [ebp-12]
        mov     DWORD PTR [ebp-296+eax*4], 0
        add     DWORD PTR [ebp-12], 1
.L6:
        cmp     DWORD PTR [ebp-12], 4
        jle     .L7
        jmp     .L8
.L12:
        lea     eax, [ebp-275]
        push    eax
        call    chomp
        add     esp, 4
        sub     esp, 8
        lea     eax, [ebp-275]
        push    eax
        push    OFFSET FLAT:.LC0
        call    strcmp
        add     esp, 16
        test    eax, eax
        jne     .L9
        mov     eax, DWORD PTR [ebp-296]
        add     eax, 1
        mov     DWORD PTR [ebp-296], eax
        mov     eax, DWORD PTR [ebp-292]
        add     eax, 1
        mov     DWORD PTR [ebp-292], eax
        jmp     .L8
.L9:
        sub     esp, 8
        lea     eax, [ebp-275]
        push    eax
        push    OFFSET FLAT:.LC1
        call    strcmp
        add     esp, 16
        test    eax, eax
        jne     .L10
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
        jmp     .L8
.L10:
        sub     esp, 8
        lea     eax, [ebp-275]
        push    eax
        push    OFFSET FLAT:.LC2
        call    strcmp
        add     esp, 16
        test    eax, eax
        jne     .L11
        mov     eax, DWORD PTR [ebp-284]
        add     eax, 2
        mov     DWORD PTR [ebp-284], eax
        mov     eax, DWORD PTR [ebp-280]
        add     eax, 3
        mov     DWORD PTR [ebp-280], eax
        jmp     .L8
.L11:
        sub     esp, 8
        lea     eax, [ebp-275]
        push    eax
        push    OFFSET FLAT:.LC3
        call    strcmp
        add     esp, 16
        test    eax, eax
        jne     .L8
        mov     eax, DWORD PTR [ebp-288]
        add     eax, 1
        mov     DWORD PTR [ebp-288], eax
        mov     eax, DWORD PTR [ebp-284]
        add     eax, 1
        mov     DWORD PTR [ebp-284], eax
        mov     eax, DWORD PTR [ebp-280]
        add     eax, 1
        mov     DWORD PTR [ebp-280], eax
.L8:
        sub     esp, 8
        lea     eax, [ebp-275]
        push    eax             # pushing input variable for scanf
        #push    OFFSET FLAT:.LC4
        #call    __isoc99_scanf

        push 0x00007325         # pushing ",s,%,"
        mov ebx, esp            # this will be the address pointing to the string "%s"
        push ebx
        call GetScanF
        call eax

        add     esp, 16
        cmp     eax, -1
        jne     .L12
        mov     DWORD PTR [ebp-16], 0
        jmp     .L13
.L15:
        mov     DWORD PTR [ebp-20], OFFSET FLAT:.LC5
        mov     eax, DWORD PTR [ebp-16]
        mov     eax, DWORD PTR [ebp-296+eax*4]
        cmp     eax, 9
        jg      .L14
        mov     DWORD PTR [ebp-20], OFFSET FLAT:.LC6
.L14:
        mov     eax, DWORD PTR [ebp-16]
        mov     eax, DWORD PTR [ebp-296+eax*4]
        sub     esp, 4
        push    eax
        push    DWORD PTR [ebp-20]
        push    OFFSET FLAT:.LC7

        #call    printf
        ###
        call GetPrintF
        call eax
        ###
        add     esp, 16
        add     DWORD PTR [ebp-16], 1
.L13:
        cmp     DWORD PTR [ebp-16], 4
        jle     .L15
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
        push 0x642e7472         # pushing d,.,t,r
        push 0x6376736d         # pushing c,v,s,m
        push esp

        call eax            # call LoadLibrary("msvcrt.dll")
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
        push 0x642e7472         # pushing d,.,t,r
        push 0x6376736d         # pushing c,v,s,m
        push esp

        call eax            # call LoadLibrary("msvcrt.dll")
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

FindFunction:
        push   ebp
        mov    ebp,esp
        sub    esp,0x1c
        xor    eax,eax
        mov    DWORD PTR [ebp-0x4],eax
        mov    DWORD PTR [ebp-0x8],eax
        mov    DWORD PTR [ebp-0xc],eax
        mov    DWORD PTR [ebp-0x10],eax
        mov    DWORD PTR [ebp-0x14],eax
        mov    DWORD PTR [ebp-0x18],eax
        mov    DWORD PTR [ebp-0x1c],eax
        mov    edx,DWORD PTR [ebp+0x8]
        mov    DWORD PTR [ebp-0x14],edx
        mov    eax,fs:0x30
        mov    eax,DWORD PTR [eax+0xc]
        mov    eax,DWORD PTR [eax+0x14]
        mov    eax,DWORD PTR [eax]
        mov    eax,DWORD PTR [eax]
        mov    eax,DWORD PTR [eax+0x10]
        mov    ebx,eax
        mov    eax,DWORD PTR [ebx+0x3c]
        add    eax,ebx
        mov    eax,DWORD PTR [eax+0x78]
        add    eax,ebx
        mov    ecx,DWORD PTR [eax+0x14]
        mov    DWORD PTR [ebp-0x4],ecx
        mov    ecx,DWORD PTR [eax+0x1c]
        add    ecx,ebx
        mov    DWORD PTR [ebp-0x8],ecx
        mov    ecx,DWORD PTR [eax+0x20]
        add    ecx,ebx
        mov    DWORD PTR [ebp-0xc],ecx
        mov    ecx,DWORD PTR [eax+0x24]
        add    ecx,ebx
        mov    DWORD PTR [ebp-0x10],ecx
        xor    eax,eax
        xor    ecx,ecx
L1:
        mov    esi,DWORD PTR [ebp-0x14]
        mov    edi,DWORD PTR [ebp-0xc]
        cld
        mov    edi,DWORD PTR [edi+eax*4]
        add    edi,ebx
        mov    cx,0x8
        repz cmps BYTE PTR ds:[esi],BYTE PTR es:[edi]
        je     L2
        inc    eax
        cmp    eax,DWORD PTR [ebp-0x4]
        jmp    L1
L2:
        mov    ecx,DWORD PTR [ebp-0x10]
        mov    edx,DWORD PTR [ebp-0x8]
        mov    ax,WORD PTR [ecx+eax*2]
        mov    eax,DWORD PTR [edx+eax*4]
        add    eax,ebx
        add    esp,0x1c
        pop    ebp
        ret
