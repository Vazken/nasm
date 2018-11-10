; Assemble:	nasm -f elf -l main.lst  main.asm
; Link:		gcc -o main  main.o
extern	_printf
extern _scanf
extern _gets
extern _ExitProcess@4
SECTION .data
	msg:	dd	"Enter a string to change it: ",0
	msg2:	dd	"Changed: ",0
	formatInString db "%s",0
	
    formatoutChar: db "%c", 0
	formatoutStr: db "%s", 0
	string: times 4 db 0
SECTION .text
global _main
_main:
        push msg
		call _printf
		add esp, 4

		push string
		call _gets
		add esp,8
		
		
		push eax
		push msg2
		call _printf
		add esp, 4
		pop eax	
		
		xor edi,edi
		xor eax,eax
lop:
		cmp byte [string + edi],0			; if string[i] == null stop looping
		JZ fin
		
		cmp byte [string + edi],'a'			; if string[i] < 'a'
		JNAE upper							; see if it's uppercase letter
		cmp byte [string + edi],'z'			; if string[i] > 'z'
		JNBE done							; it's not an alphabet letter loop
		and byte [string + edi],11011111b	; else it's a lowercase => make it upper by ANDing
		jmp done
upper:
		cmp byte [string + edi],'A'			; if string[i] < 'A'
		JNAE done								; it's not an alphabet letter loop again
		cmp byte [string + edi],'Z'			; if string[i] > 'Z'
		JNBE done								; loop again
		
		or byte [string + edi],00100000b	; else it's an uppercase => make it lowercase by ORing
done:
		inc edi								; get next character
jmp lop
	fin:	
		push string
		call _printf
		
		push    dword 0         ; Arg1: push exit code
        call    _ExitProcess@4
	