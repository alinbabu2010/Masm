data segment
     arr dw 0000h,1111h,2222h,3333h,4444h,5555h,6666h,7777h,8888h,9999h
     len dw ($-arr)/2
     key equ 7777h
     msg1 db "Key is found at "
     res db "  Position",13,10," $"
     msg2 db 'Key not found!!!.$'
data ends
code segment 
    assume ds:data,cs:code
start:
      mov ax,data
      mov ds,ax
    
      mov bx,00
      mov dx,len
      mov cx,key
again: cmp bx,dx
       ja fail
       mov ax,bx
       add ax,dx
       shr ax,1
       mov si,ax
       add si,si
       cmp cx,arr[si]
       jae big
       dec ax
       mov dx,ax
       jmp again
big:   je success
       inc ax
       mov bx,ax
       jmp again
success: add al,01
         add al,'0'
         mov res,al
         lea dx,msg1
         jmp disp
fail: lea dx,msg2
disp: mov ah,09h
      int 21h
     
      mov ah,4ch
      int 21h     
code ends
end start