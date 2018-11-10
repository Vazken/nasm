; Assemble:	nasm -f elf -l printf.lst  printf1.asm
; Link:		gcc -o printf1  printf1.o
extern	_printf
extern _scanf
extern _ExitProcess@4
SECTION .data
	msg:	dd	"Enter a string of numbers separated by commas: ",0
	msg2:	dd	"The Sum of the array is: ",0
	
	formatinString: db "%s", 0
    formatoutString: db "%s", 10, 0
	
	formatinChar: db "%c", 0
    formatoutChar: db "%c", 10, 0
	
	formatinDec: db "%d", 0
    formatoutDec: db "%d", 10, 0
	
	string: times 4 db 0
SECTION .text                   ; Code section.
global _main		; the standard gcc entry point
_main:				; the program label for the entry point
        push msg
		call _printf
		add esp, 4

		
		push string ; address of integer1 (second parameter)
		push formatinString ; arguments are right to left (first parameter)
		call _scanf
		add esp,8
		
		
		xor edi,edi
		xor eax,eax
lop:
		cmp byte [string + edi],0
		jz done
		cmp byte [string + edi],','
		JZ comma
		
		sub byte [string + edi],48
		
		add al, byte [string + edi]
		
comma:
		inc edi
		jmp lop
		

done:		

		push eax
		push msg2
		call _printf
		add esp, 4
		pop eax
	
		push eax
		push formatoutDec
		call _printf
		add esp, 4	
		
		
		push    dword 0         ; Arg1: push exit code
        call    _ExitProcess@4
	