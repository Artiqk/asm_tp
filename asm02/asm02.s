section .data
	buf: db "42", 0x0a
	msg: db "1337", 0x0a
	len: equ $-msg

section .bss
	str: resb 10 ; allocate 2 bytes for str

section .text
	global _start

_start:
	mov ebx, 0 		; int file_descriptor => 0 = stdin
	mov ecx, str 	; variable to store input
	mov edx, 2 		; length of the input
	mov eax, 0x03 	; syscall id for => read
	int 0x80

	xor ecx, ecx

.loop:
	mov al, [buf + ecx]			; move buf character to al register
	cmp al, 0x0a		
	je .equal 					; jump if character is a line feed
	cmp byte [str + ecx], al	; compare every characters of str and buf using ecx as index
	jne .not_equal				; if one character is not equal => jump to .not_equal
	inc ecx
	jmp .loop

.equal:
	; print msg
	mov ebx, 0x01
	mov ecx, msg
	mov edx, len
	mov eax, 0x04
	int 0x80

	mov ebx, 0
	jmp exit

.not_equal:
	mov ebx, 1

exit:
	mov eax, 0x01
	int 0x80
