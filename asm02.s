
section .text
	global _start

_start:
	mov ebx, 0
	mov ecx, str
	mov edx, 2
	mov eax, 0x03
	int 0x80

	cmp byte [str], 0x34
	jne notuniverse
	cmp byte [str+1], 0x32
	jne notuniverse

universe:
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	mov eax, 0x04
	int 0x80

	mov ebx, 0
	jmp exit

notuniverse:
	mov ebx, 1

exit:
	mov eax, 0x01
	int 0x80


section .data
	msg: db "1337", 10
	len: equ $-msg
	str: db 2
