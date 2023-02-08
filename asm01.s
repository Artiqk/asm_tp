
section .text
	global _start

_start:
	mov eax, 0x04		; syscall id for => write
	mov ebx, 0x01		; int file_descriptor => 1 = stdout
	mov ecx, message	; string to print
	mov edx, len		; length of the string
	int 0x80			; syscall

	mov eax, 1;
	mov ebx, 0;
	int 0x80;

section .data

msg: db "1337", 0x0a	; declare string with \n
len: equ $-msg 			; calculate msg length