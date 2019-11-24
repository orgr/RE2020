	.file	"partb.c"
	.intel_syntax noprefix
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
ROAD:
	.ascii "road\0"
SETTLEMENT:
	.ascii "settlement\0"
CITY:
	.ascii "city\0"
DEVELOPMENT:
	.ascii "development\0"
	.section	.text.startup,"x"
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
FORMAT:
	.ascii "%s\0"
_main:
	push	ebp
	mov	ebp, esp
	push	esi
	push	ebx
	
	sub	esp, 16
	call	___main
    mov eax, DWORD PTR [ebp+12]
    mov edx, DWORD PTR [eax+4]
    mov DWORD PTR [esp+4], edx
    mov	DWORD PTR [esp], OFFSET FLAT:FORMAT
	call	_printf
	
	add	esp, 16
	xor	eax, eax
	pop	ebx
	pop	esi
	pop	ebp
	ret
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
    .def	_
