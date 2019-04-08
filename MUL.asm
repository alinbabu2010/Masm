assume cs:code,ds:data
data segment
    s1 db 0ah,"Enter Ist number: $"
    s2 db 0ah,"Enter 2nd number: $"
    s3 db 0ah,"The product is :$"
data ends
code segment
start: mov ax,data
       mov ds,ax
       lea dx, s1
       mov ah, 09h
       int 21h
       mov bx, 0
start1: mov ah, 01h
       int 21h
       cmp al,0dh 
       jz next1
       mov ah,0
       sub al,30h 
       push ax
       mov ax,10d
       mul bx 
       pop bx
       add bx,ax 
       jmp start1
next1: push bx
       lea dx,s2
       mov ah,09h
       int 21h
       mov bx,0
start2: mov ah,01h
       int 21h
       cmp al,0dh
       jz next2
       mov ah,0
       sub al,30h 
       push ax
       mov ax,10d
       mul bx 
       pop bx
       add bx,ax 
       jmp start2
next2: pop ax
       mul bx 
       push ax
       lea dx,s3
       mov ah,09h
       int 21h 
       pop ax
       mov cx,0
       mov dx,0
       mov bx,10d 
       break: div bx 
       push dx
       mov dx,0
       inc cx
       or ax,ax 
       jnz break  
       print: pop dx
       add dl,30h
       mov ah,02h
       int 21h
       loop print
       mov ah,4ch
       int 21h
code ends
end start