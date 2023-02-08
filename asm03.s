section .text
	global _start

_start:
	push ebp
	mov ebp, esp
	add ebp, 4
	cmp byte [ebp], 2
	jne exit

	mov edx, [ebp + 8]
	cmp byte [edx], 0x34
	jne exit
	cmp byte [edx + 1], 0x32
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
	len: equ $-msg
