section .data
	result db 8 dup(' ')

section .text
	global _start

_start:
	mov ebp, esp
	add ebp, 8

	mov eax, [ebp]
	xor ebx, ebx

.loop:
	mov cl, byte [eax]
	cmp cl, 0
	je .done_converting
	sub cl, 0x30
	imul ebx, 10
	add ebx, ecx
	inc eax
	jmp .loop

.done_converting:
	xor ecx, ecx
	xor eax, eax

.add_below:
	cmp ecx, ebx
	je .done_adding
	add eax, ecx
	inc ecx
	jmp .add_below

.done_adding:
	mov ebx, 10
	xor ecx, ecx

.to_decimal:
	xor edx, edx
	div ebx
	push edx 	
	inc ecx 
	cmp eax, 0
	jne .to_decimal

	xor edx, edx

.to_string:
	pop eax
	dec ecx		 ; pop stack until last digit
	add al, 0x30 ; print '4' not 4 so we need ascii number
	mov byte [result + edx], al ; mov char to result string
	inc edx
	cmp ecx, 0
	jne .to_string

	mov byte [result + edx], 0x0a ; add line feed at the end

	mov ebx, 0x01
	mov ecx, result
	mov eax, 0x04
	int 0x80

	mov ebx, 0
	mov eax, 0x01
	int 0x80