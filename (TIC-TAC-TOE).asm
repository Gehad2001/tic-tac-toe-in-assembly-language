;The tic-tac-toe game is played on a 3x3 grid the game by two players, who take turns.  
.DATA
T db ' ** TIC  TAC  TOE ** $'              ;STRINGS FRIST TITLE 
T_PLAYERS db ' Player 1(x) - player 2(O) $';STRINGS SECOND TITLE
;--------------------------------------------------------------------
; BOARD LINES
CN db ' | $'                               ;STRINGS
CR db ' | $'                               ;STRINGS
LINE1 db '|   |   |   | $'                 ;STRINGS
LINE2 db '-------------$'                  ;STRINGS                               
; -------------------------------------------------------------------
; CELL NUMBERS                       
CELL1 db '1$'   ; CELL NUMBER 1
CELL2 db '2$'   ; CELL NUMBER 2
CELL3 db '3$'   ; CELL NUMBER 3
CELL4 db '4$'   ; CELL NUMBER 4
CELL5 db '5$'   ; CELL NUMBER 5
CELL6 db '6$'   ; CELL NUMBER 6
CELL7 db '7$'   ; CELL NUMBER 7
CELL8 db '8$'   ; CELL NUMBER 8 
CELL9 db '9$'   ; CELL NUMBER 9
;---------------------------------------------------------------------
PLAYER db 50, '$'  ;asci of player 2;2+48=50 PLAYER2 ASCIE
counters db 0       
WON db 0           ; CHECK FLAGS FOR IF THE GAME IS WON
D_W db 0           ; CHECK FLAGS FOR IF THE GAME IS DRAWN
;--------------------------------------------------------------------
; INPUT SECTION PROMTS 
INP db '==>  Enter a Number : $'
TKN db 'This Number is choosen!Enter another number $' 
;---------------------------------------------------------------------
; CURRENT MARK (X/O)
CURVALUE db 88  ;value=x
;--------------------------------------------------------------------- 
;FINAL MESSAGES   
con  db 'congratulations,,,$'
PLAY db 'Player $'
Win db ' won the game!$'
DRW db '        The game is drawn!$'
WRONG db 'invlid number!enter avlid number$' 
;THIS LINE IS USED TO OVERWIRTE A LINE TO CLEAN THE AREA TO ENTER THE DATA
EMP db '                                                                       $'  
;-------------------------------------------------------------------- 
;data setment counters the constant represented by @data into AX. Direct Operands 2BYTE  
;It should always point to the location of your storage where you want to keep values 
.CODE
MAIN PROC
    MOV AX, @DATA             
    MOV DS, AX                                   
;-------------------------------------------------------------------   
 ;**Description**   
 ;change between two players 
 ;Compare ASCI PLAYER WITH PLAYER   
 ;if PLAYER =49 this mean the player (x) will play
 ;if PLAYER=50 this mean the player (o) will play
 ;input: the value of PLAYER 
 ;----------------------------------   
switch:                                
        CMP PLAYER, 49         
        JZ P2                   
        CMP PLAYER, 50          
        JZ P1
         ;X player1 will play in this case
        P1: MOV PLAYER, 49
            MOV CURVALUE, 88        
            JMP BOARD
         ;O  player2 will play in this case    
        P2: MOV PLAYER, 50
            MOV CURVALUE, 79         
            JMP BOARD  
; ----------------------------------------------------------------- 
 ;**Description** 
;print the statment of the wining_player 
;when the game is  ended and one player is win print "congratulations",
;then print the value of player (x)or(O) than print  " won the game!"  
;input :value of PLAYER to print the wining_player
; ------------------------------------------------        
wining_player:LEA DX, [con]                                            
            call    print          
            
            LEA DX, [PLAY]     ;PLAYER1 OR 2 ; PRINT WIN PLAYER
            call    print         
            
            LEA DX, [PLAYER]   ;PRINT 1 OR 2
            call    print
            
            LEA DX, [Win]      ;PRINT won the game!'
            call    print
            jmp EXIT             
; ----------------------------------------------------------------  
;**Description**
; it runs only the game is drow 
; PRINT 'The game is drawn!' then exit the game    
; ----------------------------------------------
    DRAW:   LEA DX, [DRW ]
            call    print
            jmp EXIT              
; ---------------------------------------------------------------- 
;**Description**
;THERE ARE 8 POSSIBLE WINNING COMBINATIONS
; CHECK IF WINNING CONDITION IS MET  
; The player who has formed a horizontal, vertical, or diagonal sequence of three marks wins.
;input:value of each cell 
; ----------------------------------------------------------------

CHECK:                                                                                                   
   CHECK1:  MOV AL, CELL1
            MOV BL, CELL2      ; CHECKING cell1, cell2, cell3 
            MOV CL, CELL3
            
            CMP AL, BL         ; if cell1=cell2 we will compare cell2 with cell3
            JNZ CHECK2         ;if cell1!=cell2 we jump on chech2
            
            CMP BL, CL
            JNZ CHECK2
            
            MOV WON, 1
            JMP BOARD
            
    CHECK2: MOV AL, CELL4
            MOV BL, CELL5     ; CHECKING cell4, cell5, cell6 
            MOV CL, CELL6     
            
            CMP AL, BL        ; if cell4=cell5 we will compare cell5 with cell6
            JNZ CHECK3        ;jump if zero flag =0
            
            CMP BL, CL
            JNZ CHECK3
            
            MOV WON, 1
            JMP BOARD
                  
    CHECK3: MOV AL, CELL7
            MOV BL, CELL8     ; CHECKING cell7, cell8, cell9
            MOV CL, CELL9
            
            CMP AL, BL
            JNZ CHECK4
            
            CMP BL, CL
            JNZ CHECK4 
            
            MOV WON, 1
            JMP BOARD
            
    CHECK4: MOV AL, CELL1
            MOV BL, CELL4      ; CHECKING cell1, cell4, cell7
            MOV CL, CELL7
            
            CMP AL, BL
            JNZ CHECK5
            
            CMP BL, CL
            JNZ CHECK5
        
            MOV WON, 1
            JMP BOARD        
       
    CHECK5: MOV AL, CELL2
            MOV BL, CELL5     ; CHECKING cell2, cell5,cell 8
            MOV CL, CELL8
            
            CMP AL, BL
            JNZ CHECK6
            
            CMP BL, CL
            JNZ CHECK6
        
            MOV WON, 1
            JMP BOARD
            
    CHECK6: MOV AL, CELL3
            MOV BL, CELL6     ; CHECKING cell3, cell6, cell9
            MOV CL, CELL9
            
            CMP AL, BL
            JNZ CHECK7
            
            CMP BL, CL
            JNZ CHECK7
        
            MOV WON, 1
            JMP BOARD
        
    CHECK7: MOV AL, CELL1
            MOV BL, CELL5     ; CHECKING cell1, cell5, cell9
            MOV CL, CELL9
            
            CMP AL, BL
            JNZ CHECK8
            
            CMP BL, CL
            JNZ CHECK8
        
            MOV WON, 1
            JMP BOARD  
                    
    CHECK8: MOV AL, CELL3
            MOV BL, CELL5     ; CHECKING cell3, cell5, cell7
            MOV CL, CELL7
            
            CMP AL, BL
            JNZ DRAWCHECK
            
            CMP BL, CL
            JNZ DRAWCHECK
            
            MOV WON, 1
            JMP BOARD
; ----------------------------------------------------------------  
;**Description**
;this check will compare if counters  <9 will jmp on switch to take anthor input from user 
; if counters=9 put 1 in d_w and jmp to board  
; after the check will print and jmp exit
; input: value of counters 
; ----------------------------------------------------------------         
    DRAWCHECK:
            MOV AL, counters  
            CMP AL, 9       
            JB  switch      ;jmp below
            
            MOV D_W, 1      ;put 1 in d_w and jmp to board
            JMP BOARD
            
            JMP EXIT        
; -----------------------------------------------------------------------------------------------
;**Description**
;draw the game board and ask the user for the coordinates of the next mark.
;draw horizontal, vertical, lines of 3x3 gride  
;CLEAR SCREEN every time when take input  to avoid overwrite  
;prit the title 
;JUMP wining_player function if WON=1
;JUMP DRAW function if D_W=1
;input:1- value of variables from data segment 
;      2- value of WON
;      3- value of D_W
; --------------------------------------------------------------------------------
    BOARD: 
        ; CLEAR SCREEN        
        MOV AX,0600H    ;SCROLL THE ENTIRE PAGE
        MOV BH,07H      ;NORMAL ATTRIBUTE
        MOV CX,0000H    ;ROW AND COLUMN OF TOP LEFT
        MOV DX,184FH    ;ROW AND COLUMN OF BOTTOM RIGHT
        INT 10H  
        
        MOV BH, 0
        MOV DH, 2
        MOV DL,25 
        CALL SETCURSOR    ; SET CURSOR
            
    LEA DX, T
    call    print    
                   
        MOV DH, 4
        MOV DL, 23
        CALL SETCURSOR   ; SET CURSOR
        
    LEA DX, T_PLAYERS
     call    print  
        
        MOV DH, 6
        MOV DL, 30        ; SET CURSOR
        CALL SETCURSOR
     
    LEA DX, LINE2
    call    print
          
        MOV DH, 7                
        MOV DL, 30
        CALL SETCURSOR     ; SET CURSOR
        
    LEA DX, LINE1
    call    print  
           
        MOV DH, 8
        MOV DL, 29          
        CALL SETCURSOR     ; SET CURSOR 
 
 ; CELL 1   
    LEA DX, [CR]
     call    print 
    
    LEA DX, [CELL1]
    call    print                     
    
    LEA DX, [CN]
     call    print 
    
 ; CELL 2  
    LEA DX, [CELL2]
     call    print 
     
    LEA DX, [CN]
    call    print 
    
  ; CELL 3   
    LEA DX, [CELL3 ]
    call    print 
    
    LEA DX, [CN]
     call    print 
   
        MOV DH, 9               ;row
        MOV DL, 30              ;column
        CALL SETCURSOR          ; SET CURSOR
        
    LEA DX, LINE1
     call    print  
       
        MOV DH, 10
        MOV DL, 30             ; SET CURSOR
        CALL SETCURSOR
        
    LEA DX, LINE2 
     call    print
            
        MOV DH, 11
        MOV DL, 30 
        CALL SETCURSOR        ; SET CURSOR
    
    LEA DX, LINE1
     call    print   
   
        MOV DH, 12            ; SET CURSOR
        MOV DL, 29 
        CALL SETCURSOR
  
 ; CELL 4 
    LEA DX, [CR ]
    call    print  
     
    LEA DX, [CELL4]
    call    print
    
    LEA DX, [CN]
    call    print
    
 ; CELL 5   
    LEA DX, [CELL5]
    call    print
    
    LEA DX, [CN]
    call    print
    
 ; CELL 6 
    LEA DX, [CELL6]
    call    print 
    
    LEA DX, [CN]
    call    print   
   
       
        MOV DH, 13
        MOV DL, 30 
        CALL SETCURSOR           ; SET CURSOR
        
    LEA DX, [LINE1]
    call    print 
        
      
        MOV DH, 14
        MOV DL, 30 
        CALL SETCURSOR           ; SET CURSOR
     
    LEA DX,[ LINE2 ]
     call    print 
           
        MOV DH, 15
        MOV DL, 30 
        CALL SETCURSOR           ; SET CURSOR
    
    LEA DX, [LINE1]
     call    print  
            
        MOV DH, 16 ;row
        MOV DL, 29 ;colum        ; SET CURSOR
        CALL SETCURSOR      
          
 ; CELL 7 
    LEA DX, [CR]
     call    print 
      
    LEA DX, [CELL7]
     call    print 
    
    LEA DX, [CN]
     call    print 
    
 ; CELL 8  
    LEA DX, [CELL8]
     call    print 
    
    LEA DX, [CN]
     call    print 
    
 ; CELL 9    
    LEA DX, [CELL9]
     call    print 
      
    LEA DX, [CN]
    call    print 
     
        MOV DH, 17
        MOV DL, 30 
        CALL SETCURSOR       ; SET CURSOR
      
    LEA DX,[LINE1]
    call    print 
      
        MOV DH, 18
        MOV DL, 30 
        CALL SETCURSOR      ; SET CURSOR
     
    LEA DX, [LINE2]
     call    print  
     
       
        MOV DH, 20
        MOV DL, 20 
        CALL SETCURSOR       ; SET CURSOR 
    
    CMP WON, 1
    JZ wining_player
    
    CMP D_W, 1
    JZ DRAW    
; --------------------------------------------------------------------------------
;**Description**  
;print which player to play (player's turn) 
;input:take the value of PLAYER 
; ---------------------------------------------------------------------------    
    INPUT: 
    LEA DX, [PLAY]         ;PRINT player
     call    print 
    
    MOV AH, 2              ;ah=2 to print char
    MOV DL, PLAYER         ;print value of player 1 or 2
    INT 21H
    
    JMP INPUT_POSITION    
;--------------------------------------------------------------------------------
;**Description** 
;input: take input from user
; INCREMENT COUNTER BY 1   
; CHECKING IF INPUT IS BETWEEN 1-9 jump to change position with x or o 
; if input isnot valid ; DECREMENTING counters BY 1 then jump error 
;--------------------------------------------------------------------------------
    INPUT_POSITION:     
    LEA DX, [INP]         ;take the offest of value
    call    print         ; PRINT"Enter a Number :"
    
    MOV AH, 1             ;read character from standard input, with echo, result is stored in AL.
    INT 21H 
           
    INC counters          ; INCREMENTING COUNTER BY 1
     
    MOV BL, AL 
    SUB BL, 48            ;TO CONVERT DECIMAL
        
    MOV CL, CURVALUE      
                          ; CHECKING IF INPUT IS BETWEEN 1-9
    CMP BL, 1
    JZ  CELL1U 
   
    CMP BL, 2
    JZ  CELL2U
    
    CMP BL, 3
    JZ  CELL3U
    
    CMP BL, 4
    JZ  CELL4U
    
    CMP BL, 5
    JZ  CELL5U
    
    CMP BL, 6
    JZ  CELL6U
    
    CMP BL, 7
    JZ  CELL7U
    
    CMP BL, 8
    JZ  CELL8U
        
    CMP BL, 9
    JZ  CELL9U
                                                                                 
    DEC counters                ; DECREMENTING counters BY 1, SINCE IT WAS INVALID
    JMP ERORR                   ; IF INPUT IS INVALID  
 ;-----------------------------------------------------------------------------------------
 ;**Description**   
 ;IF WE ENTER EXISTING NUMBER WILL PRINT"This Number is choosen!Enter another number" ANDEnter another number
 ; DECREMENTING counters BY 1 
 ;jump to  INPUT function to take another position 
  ;-----------------------------------------------------------------------------------------
    TAKEN:                      
        DEC counters
            
            MOV DH, 20           ;ROW
            MOV DL, 20  
            CALL SETCURSOR       ; SET CURSOR 
            
        LEA DX, [TKN]            ; get address of TKN in BX,THIS LINE IS USED TO OVERWIRTE A LINE TO CLEAN THE AREA TO ENTER THE DATA
         call    print           ; DISPLAY THAT THE CELL IS TAKEN
        
        MOV AH, 7                ; INPUT WITHOUT ECHO ENTER ANOTHER NUMBER
        INT 21H 
         
            MOV DH, 20           ;ROW
            MOV DL, 20           ;COLUMN
            CALL SETCURSOR       ; SET CURSOR 
            
        LEA DX,[EMP]             ; EMPTY LINE TO OVERWRITE ANOTHER LINE TO CLEAN THE SPACE
         call    print 
        
            MOV DH, 20           ;ROW
            MOV DL, 20 
            CALL SETCURSOR       ; SET CURSOR 
        
        JMP INPUT                
;-------------------------------------------------------------------------------- 
 ;**Description** 
 ;IF WE ENTER INVALID NUMBER WILL PRINT "invlid number!enter avlid number" AND RETURN AGIN TO ENTER VALID NUMBER  
 ;jump to  INPUT function to take another position 
;--------------------------------------------------------------------------------                                                                                                          
   ERORR:    
        MOV DH, 20
        MOV DL, 20 
        CALL SETCURSOR           ; SET CURSOR 
        
    LEA DX,[WRONG]               ; WRONG INPUT MESSAGE PRINT invlid number!enter avlid number
     call    print 
    
    MOV AH, 7                    ; INPUT WITHOUT ECHO
    INT 21H                      ; if there is no character in the keyboard buffer, the function waits until any key is pressed. 
          
        MOV DH, 20               ;ROW
        MOV DL, 20 
        CALL SETCURSOR           ; SET CURSOR 
        
    LEA DX, [EMP]                ; CLEARING THAT LINE
     call    print 
    
                
        MOV DH, 20               ;ROW
        MOV DL, 20 
        CALL SETCURSOR           ; SET CURSOR
    JMP INPUT    
;--------------------------------------------------------------------------------- 
;**Description** 
;this part is made for each cell to check if cell is already taken  
                                       
     CELL1U:CMP CELL1, 88                     ; CHECKING IF THE CELL IS ALREADY 'X'
            JZ TAKEN                          ;JUMP IF ZERO FLAG=1
            CMP CELL1, 79                     ; CHECKING IF THE CELL IS ALREADY 'O'
            JZ TAKEN                          ;JUMP IF ZERO FLAG=1
            
            MOV CELL1, CL
            JMP CHECK           
       
     CELL2U:CMP CELL2, 88                     ; CHECKING IF THE CELL IS ALREADY 'X'
            JZ TAKEN
            CMP CELL2, 79                     ; CHECKING IF THE CELL IS ALREADY 'O'
            JZ TAKEN 
            
            MOV CELL2, CL
            JMP CHECK 
            
     CELL3U:CMP CELL3, 88 
            JZ TAKEN
            CMP CELL3, 79  
            JZ TAKEN 
            
            MOV CELL3, CL
            JMP CHECK  
            
     CELL4U:CMP CELL4, 88  
            JZ TAKEN
            CMP CELL4, 79  
            JZ TAKEN 
            
            MOV CELL4, CL
            JMP CHECK
             
     CELL5U:CMP CELL5, 88  
            JZ TAKEN
            CMP CELL5, 79  
            JZ TAKEN 
            
            MOV CELL5, CL
            JMP CHECK 
            
     CELL6U:CMP CELL6, 88 
            JZ TAKEN
            CMP CELL6, 79  
            JZ TAKEN 
            
            MOV CELL6, CL
            JMP CHECK 
            
     CELL7U:CMP CELL7, 88  
            JZ TAKEN
            CMP CELL7, 79   
            JZ TAKEN 
            
            MOV CELL7, CL
            JMP CHECK 
            
     CELL8U:CMP CELL8, 88  
            JZ TAKEN
            CMP CELL8, 79   
            JZ TAKEN 
            
            MOV CELL8, CL
            JMP CHECK  
            
     CELL9U:CMP CELL9, 88  
            JZ TAKEN
            CMP CELL9, 79   
            JZ TAKEN 
            
            MOV CELL9, CL
            JMP CHECK   
;----------------------------------------------------------------------
;**Description** 
;print dx content output of a string at DX. String must be terminated by '$'. 
;input: value of dx register 
     
   print:mov     ah, 9
       int     21h  ;output of a string at DX. String must be terminated by '$'. 
       ret
;----------------------------------------------------------------------  
 ;**Description**  
 ;SET CURSOR in right position
 ;where 2 represents a function call for printing a character on the screen -request set cursor         
   SETCURSOR: MOV AH, 2   
              INT 10H      ;output of a string at DX. String must be terminated by '$'.
              ret
;----------------------------------------------------------------------  
 ;**Description** 
;this function we use it to exit from program         
    EXIT:       
    MOV AH, 4CH ;terminate the program and the control will go back to the operating system.
    INT 21H     ;return to the Operating System (DOS)
    MAIN ENDP
END MAIN        ;this is the program exit point