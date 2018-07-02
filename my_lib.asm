
.data
;DB  -  1 byte
;DW  -  2 bytes
;DD  -  4 bytes  
;EAX - 4 bytes
;AX  - 2 bytes
;AL,AM - 1 bytes
;int - 4 bytes
;char - 1 byte

;v DD 0 dup(32)

format_intreg DB "%d",0
format_test DB "-%d-",0
format1 DB 10,13,"%d %d %d",0
intreg DD 0
new_line DB 10,0
sir_verif1 DD   3, 5, 7, 9,11,13,15,17,19,21,23,25,27,29,31,33,35,37
sir_verif2 DD   3, 6, 7,10,11,14,15,18,19,22,23,26,27,30,31,34,35,38
sir_verif3 DD   5, 6, 7,12,13,14,15,20,21,22,23,28,29,30,31,36,37,38
sir_verif4 DD   9,10,11,12,13,14,15,24,25,26,27,28,29,30,31
sir_verif5 DD  17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 
sir_verif6 DD  33,34,35,36,37,38
hemming_seq DD 39 dup(0)
parity DD 6 dup(0)
v DD 32 dup(0)

;aici declaram date

.code
hemming PROC
	push EBP
	mov EBP, ESP
	pusha
	mov EBX, [EBP+8]  ;primul parametru
	mov ECX,0
	
	spargere_in_biti:
	cmp ECX,32
	;pusha
	jge end_spargere_in_biti
	mov EDX,EBX
	and EDX,1
	push EBX ;;;
	mov EBX,124
	mov EAX,ECX
	push ECX ;;
	mov ECX,4
	push EDX ;
	mul ECX
	pop EDX  ;
	pop ECX  ;;
	sub EBX,EAX
	
	; pusha
	; push EBX
	; push offset format_test
	; call printf
	; add esp,8
	; popa 
	
	mov [v+EBX],EDX
	pop EBX  ;;;
	inc ECX
	shr EBX,1
	jmp spargere_in_biti
end_spargere_in_biti:

	; push offset new_line
	; call printf
	; add esp,4
	popa
	
	pusha
	mov ECX,0
; test_spargere_in_biti:
	; cmp ECX,32
	; jge end_test_spargere_in_biti
	; pusha
	; push [v+ECX*4]
	; push offset format_intreg
	; call printf
	; add esp,8
	; popa
	; inc ECX
	; jmp test_spargere_in_biti
; end_test_spargere_in_biti:
	
	; push offset new_line
	; call printf
	; add esp,4
	popa
	
	xor EDI,EDI
	mov ECX,2
	mov [hemming_seq+4],ECX
umplere_hemming:
	cmp ECX,39
	JGE end_umplere_hemming
	cmp ECX,2
	JE  fill_2
	cmp ECX,4
	JE  fill_2
	cmp ECX,8
	JE  fill_2
	cmp ECX,16
	JE  fill_2
	cmp ECX,32
	JE  fill_2
not_fill_2:
	mov EAX,[v+EDI*4]
	inc EDI
	mov [hemming_seq+ECX*4],EAX
	inc ECX
	JMP umplere_hemming
fill_2:
	mov EAX,2
	mov [hemming_seq+ECX*4],EAX
	inc ECX
	JMP umplere_hemming
end_umplere_hemming:
	
	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
	; mov ECX,1
; test_hemming:
	; cmp ECX,39
	; jge end_test_hemming
	; pusha
	; push [hemming_seq+ECX*4]
	; push offset format_intreg
	; call printf
	; add esp,8
	; popa
	; inc ECX
	; jmp test_hemming
; end_test_hemming:
	
	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
		
	xor ECX,ECX
	xor EAX,EAX
	
parity_bit_1:
	cmp ECX,18
	jge end_parity_bit_1
	mov EBX, [sir_verif1+ECX*4]
	xor EAX,[hemming_seq+EBX*4]
	; pusha
	; push EAX
	; push offset format_test
	; call printf
	; add esp,8
	; popa
	inc ECX
	jmp parity_bit_1
end_parity_bit_1:
	mov [hemming_seq+4],EAX
	
	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
		
	xor ECX,ECX
	xor EAX,EAX
	
parity_bit_2:
	cmp ECX,18
	jge end_parity_bit_2
	mov EBX, [sir_verif2+ECX*4]
	xor EAX,[hemming_seq+EBX*4]
	; pusha
	; push EAX
	; push offset format_test
	; call printf
	; add esp,8
	; popa
	inc ECX
	jmp parity_bit_2
end_parity_bit_2:
	mov [hemming_seq+8],EAX


	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
		
	xor ECX,ECX
	xor EAX,EAX

parity_bit_3:
	cmp ECX,18
	jge end_parity_bit_3
	mov EBX, [sir_verif3+ECX*4]
	xor EAX,[hemming_seq+EBX*4]
	; pusha
	; push EAX
	; push offset format_test
	; call printf
	; add esp,8
	; popa
	inc ECX
	jmp parity_bit_3
end_parity_bit_3:
	mov [hemming_seq+16],EAX
	
	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
		
	xor ECX,ECX
	xor EAX,EAX
	
parity_bit_4:
	cmp ECX,15
	jge end_parity_bit_4
	mov EBX, [sir_verif4+ECX*4]
	xor EAX,[hemming_seq+EBX*4]
	; pusha
	; push EAX
	; push offset format_test
	; call printf
	; add esp,8
	; popa
	inc ECX
	jmp parity_bit_4
end_parity_bit_4:
	mov [hemming_seq+32],EAX
	
	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
		
	xor ECX,ECX
	xor EAX,EAX

parity_bit_5:
	cmp ECX,15
	jge end_parity_bit_5
	mov EBX, [sir_verif5+ECX*4]
	xor EAX,[hemming_seq+EBX*4]
	; pusha
	; push EAX
	; push offset format_test
	; call printf
	; add esp,8
	; popa
	inc ECX
	jmp parity_bit_5
end_parity_bit_5:
	mov [hemming_seq+64],EAX
	
; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
		
	xor ECX,ECX
	xor EAX,EAX

parity_bit_6:
	cmp ECX,6
	jge end_parity_bit_6

	mov EBX, [sir_verif6+ECX*4]
	xor EAX,[hemming_seq+EBX*4]
	; pusha
	; push EAX
	; push offset format_test
	; call printf
	; add esp,8
	; popa
	inc ECX
	jmp parity_bit_6
end_parity_bit_6:
	mov [hemming_seq+128],EAX
	
	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa
	
	; mov ECX,1
; test_hemming1:
	; cmp ECX,39
	; jge end_test_hemming1
	; pusha
	; push [hemming_seq+ECX*4]
	; push offset format_intreg
	; call printf
	; add esp,8
	; popa
	; inc ECX
	; jmp test_hemming1
; end_test_hemming1:

	; pusha
	; push offset new_line
	; call printf
	; add esp,4
	; popa

	mov ESP, EBP
	pop EBP
	lea EAX, hemming_seq
	ret 4
hemming ENDP


hemming_verif proc

	push EBP
	mov EBP, ESP
	
	; pusha
	; push [EAX]
	; push offset format_intreg
	; call printf
	; add esp,8
	; popa
	
	; mov ECX,1
; test11:
	 ; cmp ECX,39
	 ; JGE end_test11
	
	 ; pusha
	 ; push [hemming_test+ECX*4]
	 ; push offset format_intreg
	 ; call printf
	 ; add esp,8
	 ; popa
	 ; inc ECX
	 ; jmp test11
; end_test11:
	
	xor ECX,ECX
	xor EAX,EAX
test_bit_1:
	 cmp ECX,18
	 JGE end_test_bit_1
	 mov EBX,[sir_verif1+ECX*4]
	 xor EAX, [hemming_test+EBX*4]
	 inc ECX
	 jmp test_bit_1
end_test_bit_1:
	xor EAX,[hemming_test+4]
	JZ no_err1
	mov EBX,1
	add hemming_wrong_bit,EBX
no_err1:

	xor ECX,ECX
	xor EAX,EAX
test_bit_2:
	 cmp ECX,18
	 JGE end_test_bit_2
	 mov EBX,[sir_verif2+ECX*4]
	 xor EAX, [hemming_test+EBX*4]
	 inc ECX
	 jmp test_bit_2
end_test_bit_2:
	xor EAX,[hemming_test+8]
	JZ no_err2
	mov EBX,2
	add hemming_wrong_bit,EBX
no_err2:

	xor ECX,ECX
	xor EAX,EAX
test_bit_3:
	 cmp ECX,18
	 JGE end_test_bit_3
	 mov EBX,[sir_verif3+ECX*4]
	 xor EAX, [hemming_test+EBX*4]
	 inc ECX
	 jmp test_bit_3
end_test_bit_3:
	xor EAX,[hemming_test+16]
	JZ no_err3
	mov EBX,4
	add hemming_wrong_bit,EBX
no_err3:

	xor ECX,ECX
	xor EAX,EAX
test_bit_4:
	 cmp ECX,15
	 JGE end_test_bit_4
	 mov EBX,[sir_verif4+ECX*4]
	 xor EAX, [hemming_test+EBX*4]
	 inc ECX
	 jmp test_bit_4
end_test_bit_4:
	xor EAX,[hemming_test+32]
	JZ no_err4
	mov EBX,8
	add hemming_wrong_bit,EBX
no_err4:

	xor ECX,ECX
	xor EAX,EAX
test_bit_5:
	 cmp ECX,15
	 JGE end_test_bit_5
	 mov EBX,[sir_verif5+ECX*4]
	 xor EAX, [hemming_test+EBX*4]
	 inc ECX
	 jmp test_bit_5
end_test_bit_5:
	xor EAX,[hemming_test+64]
	JZ no_err5
	mov EBX,16
	add hemming_wrong_bit,EBX
no_err5:

	xor ECX,ECX
	xor EAX,EAX
test_bit_6:
	 cmp ECX,6
	 JGE end_test_bit_6
	 mov EBX,[sir_verif6+ECX*4]
	 xor EAX, [hemming_test+EBX*4]
	 inc ECX
	 jmp test_bit_6
end_test_bit_6:
	xor EAX,[hemming_test+128]
	JZ no_err6
	mov EBX,32
	add hemming_wrong_bit,EBX
no_err6:

	CMP hemming_wrong_bit,0
	JE no_error_display
	CMP hemming_wrong_bit,0
	JNE error_display

no_error_display:
	pusha
	push offset format_no_error_display
	call printf
	add esp,4
	popa
jmp to_return

error_display:
	pusha
	push hemming_wrong_bit
	push offset format_error_display
	call printf
	add esp,8
	popa
jmp to_return

to_return:
	mov ESP, EBP
	pop EBP
	ret 
hemming_verif endp

