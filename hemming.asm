.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
include my_lib.asm
extern exit: proc
extern printf : proc
extern scanf: proc
extern fprintf: proc
extern fopen : proc
extern fclose : proc
extern fscanf : proc
;extern hemming: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;DB  -  1 byte
;DW  -  2 bytes
;DD  -  4 bytes
;DQ  -  8 bytes  
;EAX - 4 bytes
;AX  - 2 bytes
;AL,AM - 1 bytes
;int - 4 bytes
;char - 1 byte
;format_intreg DB "%d",0
;format_test DB "-%d-",0
;format1 DB 10,13,"%d %d %d",0
;intreg DD 0
;new_line DB 13,10,0
mode_write DB "w",0
file_name1 DB "memorie1.txt",0
mode_read DB "r",0
file_name2 DB "memorie2.txt",0
format_test1 DB "%d",10,0
format_error_display DB "Error bit %d",0
format_no_error_display DB "No error",0
hemming_wrong_bit DD 0
hemming_test DD 0,1,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,0,1,1,0,1,0,0,1,1,0,0,1,1,1,0,1,1,0,0,1,0,1
; sir_verif1 DD   3, 5, 7, 9,11,13,15,17,19,21,23,25,27,29,31,33,35,37
; sir_verif2 DD   3, 6, 7,10,11,14,15,18,19,22,23,26,27,30,31,34,35,38
; sir_verif3 DD   5, 6, 7,12,13,14,15,20,21,22,23,28,29,30,31,36,37,38
; sir_verif4 DD   9,10,11,12,13,14,15,24,25,26,27,28,29,30,31
; sir_verif5 DD  17,18,19,20,21,22,23,24,25,26,27,28,29,30,31 
; sir_verif6 DD  33,34,35,36,37,38
MEMORIE DD 1024 dup(0)
MEMORIE_CODIFICATA DD 39936 dup(0)

.code


start:
	push offset mode_read
	push offset file_name1
	call fopen
	add esp,8
	
	xor ECX,ECX
	lea EBX,MEMORIE
	
	; pusha
	; push EBX
	; push offset format_intreg
	; call printf
	; add esp,8
	; popa
	
populare_memorie_1:
	 cmp ECX,1024
	 JGE end_populare_memorie_1
	 pusha
	 push EBX
	 push offset format_intreg
	 push EAX
	 call fscanf
	 add esp,12
	 popa
	 add EBX,4
	 INC ECX
	 jmp populare_memorie_1
end_populare_memorie_1:
		
	push EAX
	call fclose
	add esp,4
	
	; xor ECX,ECX
; citire_memorie:
	 ; cmp ECX,1024
	 ; JGE end_citire_memorie
	 ; pusha
	 ; push [MEMORIE+ECX*4]
	 ; push offset format_test1
	 ; call printf
	 ; add esp,8
	 ; popa
	 ; inc ECX
	 ; jmp citire_memorie
; end_citire_memorie:

	push offset mode_write
	push offset file_name2
	call fopen
	add esp,8
	push EAX ;pointerul la fisier e in EAX
	xor ECX,ECX
 afisare_memorii:
	 cmp ECX,1024
	 JGE end_afisare_memorii
	 mov EDX,4
	 mov EAX, ECX
	 mul EDX
	 add EAX,offset MEMORIE
	 ;push offset MEMORIE
	 pop EDX   ;;pointer la stiva
	 push EDX
	 push ECX
	 
	 push EAX
	 call hemming
	 
	 pop ECX
	 push ECX
	 pusha
	 
	 
	 ; pusha
	 ; push [hemming_seq+4]
	 ; push offset format_test1
	 ; call printf
	 ; add esp,8
	 ; popa
	 mov EDI,1
	populare_memorie_2:
	 cmp EDI,39
	 JGE end_populare_memorie_2
	 
	 ;mov EBX,[hemming_seq+EDI*4]
	 mov EAX,ECX
	 mov EDX,39
	 mul EDX
	
	 ;push EBX
	 mov EBX, EAX
	 mov EAX,EDI
	 mov EDX,4
	 mul EDX
	 add EBX, EAX
	 ;mov EAX,EBX
	 lea EAX,MEMORIE_CODIFICATA
	 add EAX,EBX	 
	 ;pop EBX
	 push EBX
	 mov EBX,[hemming_seq+EDI*4]
	 mov dword ptr[EAX],EBX	 
	 pop EBX
	 
	 ; lea EDX,MEMORIE_CODIFICATA
	 ; ADD EDX,EBX
	 
	 ; pusha
	 ; push [EDX]
	 ; push offset format_test1
	 ; call printf
	 ; add esp,8
	 ; popa
	 
	 inc EDI
	 jmp populare_memorie_2
	end_populare_memorie_2:
	 popa
	
	 ;pop ECX
	 ;pusha
	 ;push EDX
	 mov ECX,1
 	 etest:
		cmp ECX,39
		JGE end_etest
		pusha
		push [EAX+ECX*4]
		push offset format_intreg
		push EDX
		call fprintf
		add esp,12
		popa
	
		INC ECX
		jmp etest
	 end_etest:
	 pusha
		push offset new_line
		push EDX
		call fprintf
		add esp,8
	 popa
	 pop ECX
	 inc ECX
	 jmp afisare_memorii
 end_afisare_memorii:
	
	; xor ECX,ECX
 ; test_memorie_2:
	 ; CMP ECX,1024
	 ; JGE end_test_memorie_2
	 ; pusha
	 ; mov EDX,1
	; j_loop:
	 ; cmp EDX,39
	 ; JGE end_j_loop
	 ; pusha
	 ; mov EAX,ECX
	 ; mov EBX,39
	 ; push EDX
	 ; mul EBX
	 ; mov EBX,4
	 ; mul EBX
	 ; pop EDX
	 ; push ECX
	 ; mov ECX,EAX
	 ; mov EAX,EDX
	 ; mov EBX,4
	 ; push EDX
	 ; mul EBX
	 ; pop EDX
	 ; add ECX,EAX
	 ; mov EAX,ECX
	 ; pop ECX
	 ; ;add EAX,offset MEMORIE_CODIFICATA
	 ; push [MEMORIE_CODIFICATA+EAX]
	 ; push offset format_intreg
	 ; call printf
	 ; add esp,8
	 ; popa
	 ; inc EDX
	 ; jmp j_loop
	; end_j_loop:
	
	 ; push offset new_line
	 ; call printf
	 ; add esp,4
	 ; popa
	 ; inc ECX
	 ; jmp test_memorie_2
 ; end_test_memorie_2:
	
	call hemming_verif
	
	pop EAX
	push EAX
	call fclose
	add esp,4


	push 0
	call exit
end start
