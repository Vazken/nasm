;UHCL FALL 2017, 10/ 28/ 2017
;main.asm
;By: Raphael Rodriguez
;Objective: User enters the number of integers, N. Program asks user to enter N numbers display the sum
;NASM 32-bit under Windows
;This program makes calls to C library functions _printf, _scanf and _ExitProcess@4
;compile: nasm -f elf main.asm
;link: gcc main.o
;----------------end of the heading------------------------------

extern	_printf
extern	_putchar
extern _getchar
extern _ExitProcess@4
SECTION .data
	msg1:	dd	"Enter characters from a to z, when done enter 0: ",0
	msg2:	dd	"Your characters manipulated: ",0
	formatoutStr: db "%s", 0
SECTION .text
global _main
_main:
        push msg1
		call _printf
		add esp, 4
		xor edi,edi
L1:
		call _getchar			; user enters characters
		add esp,8
		cmp al,'0'
		JZ print
		cmp al,'a'
		JNAE upper
		cmp al,'z'
		JNBE done
		and al,11011111b
		jmp done
upper:
		cmp al,'A'
		JNAE done
		cmp al,'Z'
		JNBE done
		or al,00100000b
done:
		mov byte [ebx + edi],al
		inc edi
		jmp L1
print:
		push eax
		push msg2
		call _printf
		add esp, 4
		pop eax

		push ebx
		push formatoutStr
		call _printf
		add esp, 4

exit:	
		push    dword 0
        call    _ExitProcess@4
	