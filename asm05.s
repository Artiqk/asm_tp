section .data
	result db 4 dup(' ') ; allocates 4 bytes for result

section .text
	global _start

_start:
	mov ebp, esp
	add ebp, 4
	mov edx, 0 ; counter for stop condition

.restart:
	mov ebx, 0 ; used to store char to int result
	add edx, 4
	mov eax, [ebp + edx] ; store in eax pointer to argument

.loop:
	mov cl, byte [eax] ; store value of pointer
	cmp cl, 0 ; test if character is \0
	je .done
	sub cl, 0x30 ; convert char to digit
	imul ebx, 10 ; 4 -> 40 then add 2
	add ebx, ecx
	inc eax ; point to next char 
	jmp .loop

.done:
	push ebx ; push converted int to stack 
	cmp edx, 8 ; if all arguments not read then restart
	jne .restart

	pop eax ; get both numbers from stack
	pop ecx
	add eax, ecx ; add 2 numbers

	xor edx, edx
	xor ecx, ecx
	mov ebx, 10

.to_decimal: 	; convert from hex to dec
	xor edx, edx
	div ebx 	; divide eax by ebx
	push edx 	; push the rest to the stack 
	; 42 / 10 : q = 4 r = 2
	;  4 / 10 : q : 0 r = 4
	inc ecx 	; counter for number of digit in the number
	cmp eax 	; if q = 0 then last digit was pushed
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

	; print the result
	mov ebx, 0x01
	mov ecx, result
	mov edx, 4
	mov eax, 0x04
	int 0x80


.exit:
	mov ebx, 0x00
	mov eax, 0x01
	int 0x80