section .bss
	buf: resb 5

section .text
	global _start

_start:
	mov ebx, 0x00
	mov ecx, buf
	mov edx, 5
	mov eax, 0x03
	int 0x80

	xor ecx, ecx

.loop:
	; we need the last digit of the number entered so we look for line feed
	inc ecx
	mov al, byte [buf + ecx]
	cmp al, 0x0a 
	jne .loop

	; if current character is line feed then char - 1 is last digit
	mov al, byte [buf + ecx - 1]
	sub al, 0x30 ; convert digit character to hexadecimal value

	and eax, 1 ; 1011 & 0001 => 0001 | 1010 & 0001 => 0000
	cmp eax, 0 ; if LSB = 0 then number is even
	jne .odd

	mov ebx, 0x00
	jmp .exit

.odd:
	mov ebx, 0x01
	
.exit:
	mov eax, 0x01
	int 0x80