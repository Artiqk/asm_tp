
section .text
	global _start

_start:
	mov ebx, 0 		; int file_descriptor => 0 = stdin
	mov ecx, str 	; variable to store input
	mov edx, 2 		; length of the input
	mov eax, 0x03 	; syscall id for => read
	int 0x80

	cmp byte [str], 0x34 	; compare first character with "4"
	jne notuniverse			; if not equal => jump to notuniverse
	cmp byte [str+1], 0x32 	; compare second character with "2"
	jne notuniverse			; if not equal => jump to notuniverse

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
