; nasm -f elf64 inOrder.asm
; gcc -m64 -no-pie inOrder.o
extern printf
extern scanf
SECTION .data
	msg:	db	"Enter a string: ",0
	inOrder:	db	"IN ORDER", 0
    notInOrder: db "NOT IN ORDER", 0
	formatinString: db "%s", 0
    formatoutString: db "%s", 10, 0
SECTION .bss
    string resb 4
SECTION .text
global main
main:
        push rbp

        mov	rdi,formatoutString
        mov	rsi,msg
        xor	rax, rax
        call printf	

        mov rsi, string
        mov rdi, formatinString
        mov al, 0
        call scanf

		xor rdi,rdi
		xor rax,rax
        xor rdx, rdx
        
        mov al, byte [string + rdi]     ; AL HAS OLD VALUE
        mov dl, byte [string + rdi]     ; DL HAS NEW VALUE
lop:
        cmp dl, 0
		jz inOrderLbl
		cmp dl, al
		JL notInOrderLbl
		mov al, dl
        inc rdi
        mov dl, byte [string + rdi]
jmp lop

notInOrderLbl:		
        mov	rdi, formatoutString
        mov	rsi, notInOrder
        xor	rax, rax
        call printf
        jmp exitLbl
inOrderLbl:
        mov	rdi, formatoutString
        mov	rsi, inOrder
        xor	rax, rax
        call printf
exitLbl:
        pop rbp
		xor rax, rax
        ret