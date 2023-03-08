section .data
	buf: db "42", 0x0a
	msg: db "1337", 0x0a
	len: equ $-msg

section .text
	global _start

_start:
	mov ebp, esp		; we can't read directly in esp so we mov in ebp
	cmp byte [ebp], 2 	; compare argc with 2 to make sure there is 2 arguments
	jne not_equal 		; if argc != 2 then jump to exit

	add ebp, 8 			; point to argv[0]
	mov edx, [ebp]		; mov argument to edx
	xor ecx, ecx

.loop:
	mov al, byte [edx] 			; we store character in al
	cmp byte [buf + ecx], 0x0a  ; if character is line feed
	je .equal
	cmp al, [buf + ecx]			; compare characters if argument is same as expected
	jne not_equal
	inc ecx 					; increase ecx for buf index
	inc edx 					; increase edx for arg index
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

not_equal:
	mov ebx, 1

exit:
	mov eax, 0x01
	int 0x80
