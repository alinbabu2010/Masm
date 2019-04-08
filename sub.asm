assume cs:code,ds:data
data segment
     str1 db 0ah, "Enter the first number: $"
     str2 db 0ah, "Enter the second number: $"
     str3 db 0ah, "Result= $"
     num1 db 04 dup(?)
     num2 db 04 dup(?)
     num3 db 04 dup(9)

data ends

code segment
        
    start:	mov ax,data
            mov ds,ax
            
            
            ;displaying str1
            mov ah,09h
            lea dx,str1
            int 21h
            
            ;reading num1 4 digits
            mov cl,04h
            lea si,num1	
            
    readnum1:  mov ah,01h
      		int 21h
      		mov [si],al
      		inc si
      		loop readnum1
      		dec si
      		
      		;displaying str2
      		lea dx,str2
      		mov ah,09h
      		int 21h
      		
      		;reading num2 4 digits
      		lea di,num2
      		mov cl,04h
      		
    readnum2:  mov ah,01h
       		int 21h
       		mov [di],al
       		inc di
       		loop readnum2
       		dec di

        ;substracting the numbers   		
       		mov cl,04h
       		clc
    substract: mov bh,[si]
     		mov bl,[di]
     		sbb bh,bl
     		mov al,bh
     		mov ah,00h
     		aas
     		mov [si],al
     		dec si
     		dec di
     		loop substract
     		
     		;displaying str3
     		lea dx,str3
     		mov ah,09h
     		int 21h
     		
     		jnc next;no borrow if the result is positive
     		
     		mov cl,04h
     		lea si,num1
     		lea di,num3
     		clc	
     		
    loop1:  mov bh,[di]
      		mov bl,[si]
      		sbb bh,bl
      		mov al,bh
      		mov ah,00h
      		aas
      		mov [si],al
      		inc si
      		inc di
     	    loop loop1
     	    
     	    
     	    lea si,num1
     	    cmp si,00h
     	    jz last
     	    mov cl,04h
     	    add si,03h
     loop2: mov al,[si]
            add al,01h
            mov ah,00h
            aaa
            mov [si],al
            jnc last
     	    dec si
     	    loop loop2
     	    
       last:mov dl,'-'
     	    mov ah,02h
     	    int 21h
     		
    next:  lea si,num1
           mov cl,04h
    display:  mov ah,02h
            mov dl,[si]
            add dl,30h
            int 21h
            inc si 			
            loop display
            mov ah,4ch
            int 21h
 code ends
 end start