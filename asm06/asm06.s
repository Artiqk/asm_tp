
section .text
	global _start

_start:
	mov ebp, esp
	add ebp, 8

	mov eax, [ebp]
	xor ebx, ebx

.loop:
	; convert string to number in ebx
	mov cl, byte [eax]
	cmp ecx, 0
	je .done_converting
	sub cl, 0x30
	imul ebx, 10
	add ebx, ecx
	inc eax
	jmp .loop

.done_converting:
	mov ecx, 2   ; init ecx at 2 because 0 and 1 are useless for prime calcul

.prime_test:
	cmp ecx, ebx ; if counter = number
	je .is_prime ; it's prime
	mov eax, ebx ; the dividend is in eax (first half)
	xor edx, edx ; clear the rest register
	div ecx		 ; divide number by current counter 
	cmp edx, 0 	 ; if rest = 0 then it's dividable
	je .not_prime
	inc ecx
	jmp .prime_test

.is_prime:
	; return 0
	xor ebx, ebx
	jmp .exit

.not_prime:
	; return 1
	mov ebx, 0x01

.exit:
	mov eax, 0x01
	int 0x80