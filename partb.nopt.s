	.file	"partb.c"
	.intel_syntax noprefix
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 4
LC0:
	.ascii "Guess a number between 1 and 100\0"
LC1:
	.ascii "Enter your guess: \0"
LC2:
	.ascii "%c\0"
LC3:
	.ascii "Too big, try again.\0"
LC4:
	.ascii "Too small, try again.\0"
LC5:
	.ascii "Correct! you win!\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	call	___main
	mov	DWORD PTR [esp], 0
	call	_time
	mov	DWORD PTR [esp], eax
	call	_srand
	call	_rand
	mov	ecx, eax
	mov	edx, 1374389535
	mov	eax, ecx
	imul	edx
	sar	edx, 5
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	imul	eax, eax, 100
	sub	ecx, eax
	mov	eax, ecx
	add	eax, 1
	mov	DWORD PTR [ebp-4], eax
	mov	DWORD PTR [ebp-8], -1
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	_puts
L6:
	mov	DWORD PTR [esp], OFFSET FLAT:LC1
	call	_printf
	lea	eax, [ebp-8]
	call	_scanf
	mov	eax, DWORD PTR [ebp-8]
	cmp	eax, DWORD PTR [ebp-4]
	jle	L2
	mov	DWORD PTR [esp], OFFSET FLAT:LC3
	call	_puts
	jmp	L3
L2:
	mov	eax, DWORD PTR [ebp-8]
	cmp	eax, DWORD PTR [ebp-4]
	jge	L4
	mov	DWORD PTR [esp], OFFSET FLAT:LC4
	call	_puts
	jmp	L3
L4:
	mov	DWORD PTR [esp], OFFSET FLAT:LC5
	call	_puts
L3:
L8:
	mov	eax, 0
	leave
	ret
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_time;	.scl	2;	.type	32;	.endef
	.def	_srand;	.scl	2;	.type	32;	.endef
	.def	_rand;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
