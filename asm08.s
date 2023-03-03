section .data
	binary db 10 dup(' ')
section .text
	global _start

_start:
	mov ebx, 0x2a
	mov ecx, 0

	mov eax, ebx
	mov ebx, 0x80

.to_binary:
	cmp ecx, 8
	je .write_bin
	div ebx
	add al, 0x30
	mov byte [binary + ecx], al
	inc ecx
	push edx
	xor edx, edx
	mov eax, ebx
	mov ebx, 0x02
	div ebx
	mov ebx, eax
	pop eax
	jmp .to_binary

.write_bin:
	mov ebx, 1
	mov ecx, binary
	mov edx, 10
	mov eax, 0x04
	int 0x80

.exit:
	mov ebx, 0x00
	mov eax, 0x01
	int 0x80