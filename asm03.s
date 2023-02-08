section .text
	global _start

_start:
	push ebp
	mov ebp, esp
	cmp byte [ebp + 4], 2
	jne exit

	mov ebx, 1
	mov ecx, msg
	mov edx, 1
	mov eax, 0x04
	int 0x80

exit:
	mov ebx, 0
	mov eax, 0x01
	int 0x80


section .data
	msg: db "1337", 0x0a
	len: equ $-msg
