
section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, message
	mov edx, len
	int 0x80

	mov eax, 1;
	mov ebx, 0;
	int 0x80;

section .data

msg: db "1337", 10
len: equ $-msg