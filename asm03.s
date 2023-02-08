section .text
	global _start

_start:
	mov ebx, [esp + 4]
	cmp ebx, 2
	jne exit

	mov ebx, 1
	mov ecx, msg
	mov edx, len
	mov eax, 0x04
	int 0x80

exit:
	mov ebx, 0
	mov eax, 0x01
	int 0x80


section .data
	msg: db "1337", 0x0a
	; cmpstr: db "42", 0x0a
	len: equ $-msg