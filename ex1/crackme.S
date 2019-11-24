	.file	"crackme.c"
	.intel_syntax noprefix
	.text
	.globl	_arg
	.bss
	.align 4
_arg:
	.space 4
	.comm	_mark, 64, 5
	.section .rdata,"dr"
LC0:
	.ascii "Error #%d: %s\12\0"
	.text
	.globl	_check_error
	.def	_check_error;	.scl	2;	.type	32;	.endef
_check_error:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	cmp	DWORD PTR [ebp+8], 0
	je	L3
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [esp], eax
	call	_sqlite3_errmsg
	mov	DWORD PTR [esp+12], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp+8], eax
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC0
	mov	eax, DWORD PTR __imp___iob
	add	eax, 64
	mov	DWORD PTR [esp], eax
	call	_fprintf
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [esp], eax
	call	_sqlite3_close
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp], eax
	call	_exit
L3:
	nop
	leave
	ret
	.section .rdata,"dr"
LC1:
	.ascii "ADMIN\0"
LC2:
	.ascii "1\0"
LC3:
	.ascii "Admin\0"
LC4:
	.ascii "%10s\0"
LC5:
	.ascii "-----\0"
LC6:
	.ascii " | \0"
	.text
	.globl	_select_callback
	.def	_select_callback;	.scl	2;	.type	32;	.endef

_sqlite3_errmsg:
_sqlite3_close:
_sqlite3_open:
_sqlite3_exec:

_select_callback:
	push	ebp
	mov	ebp, esp
	sub	esp, 12
	mov	DWORD PTR [ebp-4], 0
	jmp	L5
L11:
	mov	eax, DWORD PTR [ebp-4]
	lea	edx, [0+eax*4]
	mov	eax, DWORD PTR [ebp+20]
	add	eax, edx
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC1
	mov	DWORD PTR [esp], eax
	call	_strcmp
	test	eax, eax
	jne	L6
	mov	eax, DWORD PTR [ebp-4]
	lea	edx, [0+eax*4]
	mov	eax, DWORD PTR [ebp+16]
	add	eax, edx
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC2
	mov	DWORD PTR [esp], eax
	call	_strcmp
	test	eax, eax
	jne	L7
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC3
	mov	DWORD PTR [esp], OFFSET FLAT:LC4
	call	_printf
	jmp	L9
L7:
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC5
	mov	DWORD PTR [esp], OFFSET FLAT:LC4
	call	_printf
	jmp	L9
L6:
	mov	eax, DWORD PTR [ebp-4]
	lea	edx, [0+eax*4]
	mov	eax, DWORD PTR [ebp+16]
	add	eax, edx
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC4
	call	_printf
L9:
	mov	eax, DWORD PTR [ebp+12]
	sub	eax, 1
	cmp	DWORD PTR [ebp-4], eax
	jge	L10
	mov	DWORD PTR [esp], OFFSET FLAT:LC6
	call	_printf
L10:
	add	DWORD PTR [ebp-4], 1
L5:
	mov	eax, DWORD PTR [ebp-4]
	cmp	eax, DWORD PTR [ebp+12]
	jl	L11
	mov	DWORD PTR [esp], 10
	call	_putchar
	mov	eax, 0
	leave
	ret
	.section .rdata,"dr"
	.align 4
LC7:
	.ascii "select username, password from users where username='\0"
LC8:
	.ascii "users.db\0"
	.align 4
LC9:
	.ascii "Cannot open db. Please contact the IT guy\12\0"
	.text
	.globl	_db_access
	.def	_db_access;	.scl	2;	.type	32;	.endef
_db_access:
	push	ebp
	mov	ebp, esp
	push	edi
	sub	esp, 292
	mov	DWORD PTR [ebp-16], 0
	mov	DWORD PTR [ebp-8], OFFSET FLAT:LC7
	lea	eax, [ebp-16]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC8
	call	_sqlite3_open
	test	eax, eax
	jne	L14
	lea	edx, [ebp-276]
	mov	eax, 0
	mov	ecx, 64
	mov	edi, edx
	rep stosd
	mov	eax, DWORD PTR [ebp-8]
	mov	DWORD PTR [esp+4], eax
	lea	eax, [ebp-276]
	mov	DWORD PTR [esp], eax
	call	_strcat
	mov	eax, DWORD PTR _arg
	mov	DWORD PTR [esp+8], 11
	mov	DWORD PTR [esp+4], eax
	lea	eax, [ebp-276]
	mov	DWORD PTR [esp], eax
	call	_strncat
	lea	eax, [ebp-276]
	mov	ecx, -1
	mov	edx, eax
	mov	eax, 0
	mov	edi, edx
	repnz scasb
	mov	eax, ecx
	not	eax
	lea	edx, [eax-1]
	lea	eax, [ebp-276]
	add	eax, edx
	mov	WORD PTR [eax], 39
	mov	eax, DWORD PTR [ebp-16]
	lea	edx, [ebp-20]
	mov	DWORD PTR [esp+16], edx
	mov	DWORD PTR [esp+12], 0
	mov	DWORD PTR [esp+8], OFFSET FLAT:_select_callback
	lea	edx, [ebp-276]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	_sqlite3_exec
	mov	DWORD PTR [ebp-12], eax
	mov	eax, DWORD PTR [ebp-16]
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [ebp-12]
	mov	DWORD PTR [esp], eax
	call	_check_error
	mov	eax, DWORD PTR [ebp-16]
	mov	DWORD PTR [esp], eax
	call	_sqlite3_close
	jmp	L17
L14:
	mov	eax, DWORD PTR __imp___iob
	add	eax, 64
	mov	DWORD PTR [esp+12], eax
	mov	DWORD PTR [esp+8], 42
	mov	DWORD PTR [esp+4], 1
	mov	DWORD PTR [esp], OFFSET FLAT:LC9
	call	_fwrite
	mov	eax, DWORD PTR [ebp-16]
	mov	DWORD PTR [esp], eax
	call	_sqlite3_close
	mov	DWORD PTR [esp], 1
	call	_exit
L17:
	mov	eax, 0
	add	esp, 292
	pop	edi
	pop	ebp
	ret
	.globl	_divider
	.data
	.align 4
_divider:
	.long	80
	.text
	.globl	_rand_32
	.def	_rand_32;	.scl	2;	.type	32;	.endef
_rand_32:
	push	ebp
	mov	ebp, esp
	sub	esp, 8
	mov	eax, DWORD PTR [ebp+8]
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [ebp-4], eax
	mov	eax, DWORD PTR [ebp-4]
	imul	eax, eax, 1103515245
	mov	DWORD PTR [ebp-4], eax
	add	DWORD PTR [ebp-4], 12345
	mov	eax, DWORD PTR [ebp-4]
	shr	eax, 16
	and	eax, 2047
	mov	DWORD PTR [ebp-8], eax
	mov	eax, DWORD PTR [ebp-4]
	imul	eax, eax, 1103515245
	mov	DWORD PTR [ebp-4], eax
	add	DWORD PTR [ebp-4], 12345
	sal	DWORD PTR [ebp-8], 10
	mov	eax, DWORD PTR [ebp-4]
	shr	eax, 16
	and	eax, 1023
	mov	edx, eax
	mov	eax, DWORD PTR [ebp-8]
	xor	eax, edx
	mov	DWORD PTR [ebp-8], eax
	mov	eax, DWORD PTR [ebp-4]
	imul	eax, eax, 1103515245
	mov	DWORD PTR [ebp-4], eax
	add	DWORD PTR [ebp-4], 12345
	sal	DWORD PTR [ebp-8], 10
	mov	eax, DWORD PTR [ebp-4]
	shr	eax, 16
	and	eax, 1023
	mov	edx, eax
	mov	eax, DWORD PTR [ebp-8]
	xor	eax, edx
	mov	DWORD PTR [ebp-8], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	edx, DWORD PTR [ebp-4]
	mov	DWORD PTR [eax], edx
	mov	eax, DWORD PTR [ebp-8]
	leave
	ret
	.section .rdata,"dr"
LC10:
	.ascii "Level 4 Passed!\0"
LC11:
	.ascii "Points will be reduced\0"
	.text
	.globl	_handler
	.def	_handler;	.scl	2;	.type	32;	.endef
_handler:
	push	ebp
	mov	ebp, esp
	sub	esp, 8
	mov	eax, DWORD PTR [ebp+8]
	cmp	eax, 8
	jne	L21
	mov	DWORD PTR [esp], OFFSET FLAT:LC10
	call	_puts
	lea	eax, [ebp+8]
	mov	DWORD PTR [esp], eax
	call	_rand_32
	mov	DWORD PTR _divider, eax
	mov	DWORD PTR [esp+4], -1
	mov	DWORD PTR [esp], OFFSET FLAT:_mark
	call	_longjmp
L21:
	mov	DWORD PTR [esp], OFFSET FLAT:LC11
	call	_puts
	nop
	leave
	ret
	.section .rdata,"dr"
LC12:
	.ascii "Level 3 Passed!\0"
	.text
	.globl	__dummy_
	.def	__dummy_;	.scl	2;	.type	32;	.endef
__dummy_:
	push	ebp
	mov	ebp, esp
	sub	esp, 12
	mov	DWORD PTR [esp], OFFSET FLAT:LC12
	call	_puts
	mov	DWORD PTR [esp], OFFSET FLAT:_mark
	call	__setjmp
	mov	ecx, DWORD PTR _divider
	mov	eax, 236496
	mov	edx, 0
	div	ecx
	mov	DWORD PTR [ebp-4], eax
	mov	eax, DWORD PTR [ebp-4]
	sal	eax, 3
	mov	DWORD PTR [ebp-8], eax
	call	_db_access
	mov	DWORD PTR [esp], 0
	call	_exit
	.section .rdata,"dr"
LC13:
	.ascii "%08X \0"
	.text
	.globl	_printArray
	.def	_printArray;	.scl	2;	.type	32;	.endef
_printArray:
	push	ebp
	mov	ebp, esp
	sub	esp, 12
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [ebp-4], eax
	jmp	L25
L28:
	mov	eax, DWORD PTR [ebp-4]
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC13
	call	_printf
	mov	eax, DWORD PTR [ebp-4]
	sub	eax, DWORD PTR [ebp+12]
	sar	eax, 2
	add	eax, 1
	and	eax, 3
	test	eax, eax
	jne	L26
	mov	DWORD PTR [esp], 10
	call	_putchar
	jmp	L27
L26:
	mov	eax, DWORD PTR [ebp-4]
	add	eax, 4
	cmp	DWORD PTR [ebp+16], eax
	ja	L27
	mov	DWORD PTR [esp], 10
	call	_putchar
L27:
	add	DWORD PTR [ebp-4], 4
L25:
	mov	eax, DWORD PTR [ebp-4]
	cmp	eax, DWORD PTR [ebp+16]
	jb	L28
	nop
	leave
	ret
	.section .rdata,"dr"
LC14:
	.ascii "Level 1 Passed!\0"
	.text
	.globl	_level1
	.def	_level1;	.scl	2;	.type	32;	.endef
_level1:
	push	ebp
	mov	ebp, esp
	sub	esp, 4
	cmp	DWORD PTR [ebp+8], 1
	jle	L30
	mov	DWORD PTR [esp], OFFSET FLAT:LC14
	call	_puts
	jmp	L32
L30:
	mov	DWORD PTR [esp], 0
	call	_exit
L32:
	leave
	ret
	.section .rdata,"dr"
LC15:
	.ascii "%d %d\0"
LC16:
	.ascii "%X\0"
LC17:
	.ascii "Level 2 Passed!\0"
	.text
	.globl	_level2
	.def	_level2;	.scl	2;	.type	32;	.endef
_level2:
	push	ebp
	mov	ebp, esp
	sub	esp, 64
	mov	BYTE PTR [ebp-46], -95
	mov	BYTE PTR [ebp-45], 5
	mov	BYTE PTR [ebp-44], 38
	mov	BYTE PTR [ebp-43], -60
	mov	BYTE PTR [ebp-42], -73
	mov	BYTE PTR [ebp-41], 125
	mov	BYTE PTR [ebp-40], 31
	mov	BYTE PTR [ebp-39], 73
	mov	BYTE PTR [ebp-38], 26
	mov	DWORD PTR [ebp-4], 0
	jmp	L34
L35:
	lea	eax, [ebp+8]
	mov	DWORD PTR [esp], eax
	call	_rand_32
	mov	edx, eax
	mov	eax, edx
	sar	eax, 31
	shr	eax, 24
	add	edx, eax
	movzx	edx, dl
	sub	edx, eax
	mov	eax, edx
	mov	ecx, eax
	lea	edx, [ebp-37]
	mov	eax, DWORD PTR [ebp-4]
	add	eax, edx
	mov	BYTE PTR [eax], cl
	add	DWORD PTR [ebp-4], 1
L34:
	cmp	DWORD PTR [ebp-4], 8
	jle	L35
	lea	eax, [ebp-28]
	mov	DWORD PTR [esp+8], eax
	lea	eax, [ebp-24]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC15
	call	_scanf
	mov	eax, DWORD PTR [ebp-24]
	test	eax, eax
	js	L44
	mov	eax, DWORD PTR [ebp-24]
	mov	edx, eax
	lea	eax, [ebp-37]
	add	eax, edx
	and	eax, -4
	mov	DWORD PTR [ebp-16], eax
	mov	eax, DWORD PTR [ebp-28]
	mov	edx, eax
	lea	eax, [ebp-37]
	add	eax, edx
	and	eax, -4
	mov	DWORD PTR [ebp-20], eax
	mov	eax, DWORD PTR [ebp-20]
	mov	DWORD PTR [esp+8], eax
	mov	eax, DWORD PTR [ebp-16]
	mov	DWORD PTR [esp+4], eax
	lea	eax, [ebp-37]
	mov	DWORD PTR [esp], eax
	call	_printArray
	mov	eax, DWORD PTR [ebp-16]
	mov	DWORD PTR [ebp-8], eax
	jmp	L38
L39:
	lea	eax, [ebp-52]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC16
	call	_scanf
	mov	eax, DWORD PTR [ebp-8]
	mov	eax, DWORD PTR [eax]
	mov	edx, eax
	mov	eax, DWORD PTR [ebp-52]
	xor	eax, edx
	mov	edx, eax
	mov	eax, DWORD PTR [ebp-8]
	mov	DWORD PTR [eax], edx
	add	DWORD PTR [ebp-8], 4
L38:
	mov	eax, DWORD PTR [ebp-8]
	cmp	eax, DWORD PTR [ebp-20]
	jb	L39
	mov	DWORD PTR [ebp-12], 0
	jmp	L40
L42:
	lea	edx, [ebp-37]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, edx
	movzx	edx, BYTE PTR [eax]
	lea	ecx, [ebp-46]
	mov	eax, DWORD PTR [ebp-12]
	add	eax, ecx
	movzx	eax, BYTE PTR [eax]
	cmp	dl, al
	jne	L45
	add	DWORD PTR [ebp-12], 1
L40:
	cmp	DWORD PTR [ebp-12], 8
	jle	L42
	mov	DWORD PTR [esp], OFFSET FLAT:LC17
	call	_puts
	jmp	L33
L44:
	nop
	jmp	L33
L45:
	nop
L33:
	leave
	ret
	.def	___main;	.scl	2;	.type	32;	.endef
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	call	___main
	mov	DWORD PTR [esp+4], OFFSET FLAT:_handler
	mov	DWORD PTR [esp], 8
	call	_signal
	mov	DWORD PTR [ebp-4], OFFSET FLAT:__dummy_
	mov	eax, DWORD PTR [ebp+12]
	add	eax, 4
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp], eax
	call	_atoi
	mov	DWORD PTR [ebp-8], eax
	mov	eax, DWORD PTR [ebp+12]
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [ebp+8]
	mov	DWORD PTR [esp], eax
	call	_level1
	mov	eax, DWORD PTR [ebp-8]
	mov	DWORD PTR [esp], eax
	call	_level2
	mov	eax, DWORD PTR [ebp+12]
	mov	eax, DWORD PTR [eax+8]
	mov	DWORD PTR _arg, eax
	mov	eax, DWORD PTR [ebp+12]
	add	eax, 4
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp], eax
	call	_atoi
	mov	DWORD PTR [ebp-8], eax
	lea	eax, [ebp-8]
	mov	DWORD PTR [esp], eax
	call	_rand_32
	mov	edx, eax
	mov	eax, edx
	sar	eax, 31
	shr	eax, 24
	add	edx, eax
	movzx	edx, dl
	sub	edx, eax
	mov	eax, edx
	mov	edx, eax
	mov	eax, edx
	sar	eax, 31
	shr	eax, 29
	add	edx, eax
	and	edx, 7
	sub	edx, eax
	mov	eax, edx
	mov	DWORD PTR _divider, eax
	mov	eax, 0
	leave
	ret
	.ident	"GCC: (MinGW.org GCC-8.2.0-5) 8.2.0"
	.def	_sqlite3_errmsg;	.scl	2;	.type	32;	.endef
	.def	_fprintf;	.scl	2;	.type	32;	.endef
	.def	_sqlite3_close;	.scl	2;	.type	32;	.endef
	.def	_exit;	.scl	2;	.type	32;	.endef
	.def	_strcmp;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_putchar;	.scl	2;	.type	32;	.endef
	.def	_sqlite3_open;	.scl	2;	.type	32;	.endef
	.def	_strcat;	.scl	2;	.type	32;	.endef
	.def	_strncat;	.scl	2;	.type	32;	.endef
	.def	_sqlite3_exec;	.scl	2;	.type	32;	.endef
	.def	_fwrite;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_longjmp;	.scl	2;	.type	32;	.endef
	.def	__setjmp;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
	.def	_signal;	.scl	2;	.type	32;	.endef
	.def	_atoi;	.scl	2;	.type	32;	.endef



