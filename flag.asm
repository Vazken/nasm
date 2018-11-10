;UHCL FALL 2017, 12/10/2017
;flags.asm
;BY: Ricardo Washington
;Objective: Drawing a Flag using Nasm Assembly
;NASM 32-bit under Windows
;This program makes calls to Windows API funtions
;Compile: nasm -fobj flag.asm
;Link: alink -oPE flag.obj
extern GetStdHandle 
extern WriteFile 
extern AllocConsole 
extern SetConsoleTitleA 
extern SetConsoleTextAttribute
extern Sleep 
extern ExitProcess 
 
import GetStdHandle kernel32.dll 
import WriteFile kernel32.dll 
import AllocConsole kernel32.dll 
import SetConsoleTitleA kernel32.dll 
import SetConsoleTextAttribute kernel32.dll 
import Sleep kernel32.dll 
import ExitProcess kernel32.dll 

section .text use32  
..start: 
call [AllocConsole] 

push dword the_title  
call [SetConsoleTitleA] 

push dword -11 
call [GetStdHandle]  
mov dword [hStdOut], eax 

xor esi,esi
push dword[colors + esi]
push dword [hStdOut]
call [SetConsoleTextAttribute]
updateColor:
mov edi,dword [colorCount]
push dword[colors + edi]
push dword [hStdOut]
call [SetConsoleTextAttribute]
mov dword [lopCount],10
L1:
    mov eax, msg_len  
    sub eax, msg 
    dec eax 
    mov dword [msg_len], eax 

    push dword 0 
    push dword nBytes 
    push dword [msg_len] 
    push dword msg 
    push dword [hStdOut] 

    call [WriteFile]
    push dword 100
    call [Sleep]
    dec dword [lopCount]
    jnz L1
    add dword [colorCount],4
    cmp dword [colorCount], 12
    JNZ updateColor
    push dword 5000
    call [Sleep] 


xor eax, eax 
push eax 
call [ExitProcess] 


section .data 
the_title                  db "Flag", 0 
msg                        db 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 219,219, 13, 10, 0 
msg_len                    dd 0 
lopCount				   dd 0
colorCount                 dd 0
colors                     dd 0x70, 0x74, 0x76  ; Germany
;colors                     dd 0x74,0x76, 0x7A ; africa
section .bss 
hStdOut                    resd 1 
nBytes                     resd 1 