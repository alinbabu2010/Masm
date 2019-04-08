assume cs:code,ds:data
data segment
    str1 db 0ah,"Enter Ist number: $"
    str2 db 0ah,"Enter 2nd number: $"
    str3 db 0ah,"The sum is :$"
    num1 db 04 dup(?)
    num2 db 04 dup(?)
data ends

code segment
start: mov ax,data
       mov ds,ax
       lea si,num1
       lea dx,str1
       mov ah,09h
       int 21h
       mov cl,04h
loop1: mov ah,01h
       int 21h
       mov[si],al
       inc si
       loop loop1
       dec si
       
       lea di,num2
       lea dx,str2
       mov ah,09h
       int 21h
       mov cl,04h

loop2: mov ah,01h
       int 21h
       mov[di],al
       inc di
       loop loop2
       dec di
       clc
       mov cl,04h
       
loop3: mov bh,[di]
       mov bl,[si]
       adc bh,bl
       mov al,bh
       mov ah,00h
       aaa
       
       mov bh,al
       mov [si],bh
       dec si
       dec di
       loop loop3
       lea dx,str3
       mov ah,09h
       int 21h
       jnc next
       mov dl,31h
       mov ah,02h
       int 21h

next: mov cl,04h
      lea si,num1

loop4: mov dl,[si]
       add dl,30h
       mov ah,02h
       int 21h
       inc si
       loop loop4
       mov ah,4ch
       int 21h
       

code ends
end start
    