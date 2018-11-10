; Assemble:	nasm -f elf -l main.lst  main.asm
; Link:		gcc -o main  main.o
extern	_printf
extern _scanf
extern _gets
extern _ExitProcess@4
SECTION .data
	msg:	dd	"Enter a string to reverse it: ",0
	msg2:	dd	"String Reversed: ",0
	
    formatoutChar: db "%c", 0
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
		
		xor edi,edi
		xor ecx,ecx
		xor eax,eax
		
		
lop:								; let's loop first time to find out the length
		cmp byte [string + edi],0
		jz done
		inc edi
jmp lop
		
done:
		push eax
		push msg2
		call _printf
		add esp, 4
		pop eax	
lop2:
		mov al,byte [string + edi]
		push eax
		push formatoutChar
		call _printf
		dec edi
		cmp edi,-1
JNZ lop2
		
		push    dword 0         ; Arg1: push exit code
        call    _ExitProcess@4
	