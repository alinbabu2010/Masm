data segment
    mess1 db 0ah,0dh,'Enter the dividend:','$'
    mess2 db 0ah,0dh,'Enter the divisor:','$'
    mess3 db 0ah,0dh,'Division is :','$'
data ends
code segment
assume cs:code,ds:data
start:  mov ax,data
        mov ds,ax
        lea dx,mess1
        mov ah,09h
        int 21h
        call read
        mov bx,dx
        lea dx,mess2
        mov ah,09h
        int 21h
        call read
        mov si,dx
        mov dx,0000h
        mov ax,bx
        div si
        mov bx,ax
        mov ax,0000h
        div si
        mov si,ax
        call disp
        mov ah,4ch
        int 21h
        read proc near 
        public read
        mov ch,02h
r3:     mov ah,01h
        int 21h
        mov cl,04h
        mov dl,al
        sub dl,30h
        cmp dl,0ah
        jc r1 
        sub dl,07h
r1:     shl dl,cl
        mov ah,01h
        int 21h
        sub al,30h
        cmp al,0ah
        jc r2
        sub al,07h
        and al,0fh
r2:     or dl,al
        dec ch
        jz r4
        mov dh,dl
        jmp r3
r4:     ret
        read endp
        disp proc near 
        public disp
        lea dx,mess3
        mov ah,09h
        int 21h
        mov ch,02h
        mov cl,04h
        mov dl,bh
        shr dl,cl
        cmp dl,0ah
        jc l1
        add dl,07h
l1:     add dl,30h
        mov ah,06h
        int 21h
        and bh,0fh
        cmp bh,0ah
        jc l2
        add bh,07h
l2:     add bh,30h
        mov dl,bh
        mov ah,06h
        int 21h
back:   mov dl,bl
        shr dl,cl
        cmp dl,0ah
        jc l3 
        add dl,07h
l3:     add dl,30h
        mov ah,06h
        int 21h
        and bl,0fh
        cmp bl,0ah
        jc l4
        add bl,07h
l4:     add bl,30h
        mov dl,bl
        mov ah,06h
        int 21h
        dec ch
        jz nxt
        mov dl,'.'
        mov ah,06h
        int 21h
        mov bx,si
        mov bl,bh
        jmp back  
nxt:    ret
        disp endp
code ends
end start