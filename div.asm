DATA SEGMENT
    MESS1 DB 0AH,0DH,'ENTER THE DIVIDEND:','$'
    MESS2 DB 0AH,0DH,'ENTER THE DIVISOR:','$'
    MESS3 DB 0AH,0DH,'DIVISION IS :','$'
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
    START:  MOV AX,DATA
            MOV DS,AX
            LEA DX,MESS1
            MOV AH,09H
            INT 21H
            CALL READ
            MOV BX,DX
            LEA DX,MESS2
            MOV AH,09H
            INT 21H
            CALL READ
            MOV SI,DX
            MOV DX,0000H
            MOV AX,BX
            DIV SI
            MOV BX,AX
            MOV AX,0000H
            DIV SI
            MOV SI,AX
            CALL DISP
            MOV AH,4CH
            INT 21H
            READ PROC NEAR 
            PUBLIC READ
            MOV CH,02H
    R3:     MOV AH,01H
            INT 21H
            MOV CL,04H
            MOV DL,AL
            SUB DL,30H
            CMP DL,0AH
            JC R1 
            SUB DL,07H
    R1:     SHL DL,CL
            MOV AH,01H
            INT 21H
            SUB AL,30H
            CMP AL,0AH
            JC R2
            SUB AL,07H
            AND AL,0FH
    R2:     OR DL,AL
            DEC CH
            JZ R4
            MOV DH,DL
            JMP R3
    R4:     RET
            READ ENDP
            DISP PROC NEAR 
            PUBLIC DISP
            LEA DX,MESS3
            MOV AH,09H
            INT 21H
            MOV CH,02H
            MOV CL,04H
            MOV DL,BH
            SHR DL,CL
            CMP DL,0AH
            JC L1
            ADD DL,07H
    L1:     ADD DL,30H
            MOV AH,06H
            INT 21H
            AND BH,0FH
            CMP BH,0AH
            JC L2
            ADD BH,07H
    L2:     ADD BH,30H
            MOV DL,BH
            MOV AH,06H
            INT 21H
    BACK:   MOV DL,BL
            SHR DL,CL
            CMP DL,0AH
            JC L3 
            ADD DL,07H
    L3:     ADD DL,30H
            MOV AH,06H
            INT 21H
            AND BL,0FH
            CMP BL,0AH
            JC L4
            ADD BL,07H
    L4:     ADD BL,30H
            MOV DL,BL
            MOV AH,06H
            INT 21H
            DEC CH
            JZ NXT
            MOV DL,'.'
            MOV AH,06H
            INT 21H
            MOV BX,SI
            MOV BL,BH
            JMP BACK  
    NXT:    RET
    DISP ENDP
CODE ENDS
END START
