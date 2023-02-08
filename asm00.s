
section .text
	global _start

_start:
	mov eax, 1 	; syscall id for => exit
	mov ebx, 0 	; int error_code
	int 0x80 	; syscall
