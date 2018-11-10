org 100h 

section .text 

start: 
		; clear screen
		mov ax,0003h
		int 10h 
		; get user input
		mov ah,09
		mov dx, msg
		int 21h
getChar:	
		mov ah, 01
		int 0x21
		cmp al, 13
		JNZ getChar
		
		mov     AH, 0x4C
        mov     AL, 0                           ; return code 0
        int     0x21

section .data 
		msg: db "Enter Passport ID: $"
		usrInput: db 0
        ; put data items here 

section .bss 

        ; put uninitialized data here