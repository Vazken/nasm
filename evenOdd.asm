; Assemble:	nasm -f elf -l printf.lst  printf1.asm
; Link:		gcc -o printf1  printf1.o
extern	_printf
extern _scanf
extern _ExitProcess@4
SECTION .data
	msg:	dd	"Enter a number: ",0
	evn:	dd	"Even",10,13,0
	od:	dd	"Odd",10,13,0
	formatin: db "%d", 0
    formatout: db "%d", 10, 0
	integer1: times 4 db 0
SECTION .text                   ; Code section.
global _main		; the standard gcc entry point
_main:				; the program label for the entry point
        push    msg	
        call    _printf
        add     esp, 12
		
		add esp, 4 ; remove parameters
		push integer1 ; address of integer1 (second parameter)
		push formatin ; arguments are right to left (first parameter)
		call _scanf
		
		mov eax,[integer1]
		and al,1
		cmp al,1
		JZ odd
		push    evn	
        call    _printf
        add     esp, 12
		jmp done
odd:
		push    od	
        call    _printf
        add     esp, 12
done:	
		push    dword 0         ; Arg1: push exit code
        call    _ExitProcess@4
	