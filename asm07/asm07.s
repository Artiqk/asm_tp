
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
	mov ebx, eax
	mov eax, 0x01
	int 0x80