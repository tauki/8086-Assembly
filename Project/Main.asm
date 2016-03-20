;********************************************************
;*              8086 Assembly program                   *
;*                                                      *
;*                  Group Project                       *
;*               Course Code: CSE341                    *
;*                 BRAC University                      *
;*                                                      *
;* Group Members:                                       *
;*----------------                                      *
;*                                                      *
;* Tauki Tahmid                                         *
;* ID: 15101051                                         *
;*                                                      *
;* Samin -------                                        *
;* ID: --------                                         *
;*                                                      *
;*                                                      *
;* Project:                                             *
;*----------                                            *
;* Status: Ongoing                                      *
;*                                                      *
;* #1 - Printing fibonacci till n'th count              *
;* #2 - Checking if entered number is a HappyNumber     *
;* #3 - Checking if entered number is a PerfectNumber   *
;*                                                      *
;*                                                      *
;********************************************************

Title <> Main

; declarations
include 'emu8086.inc'

.model small
.stack 100h

.data
  userInput_main dw  0
  userInput_secondary dw 0

.code   
  mov ax,@data
  mov ds,ax
  
  ;defining functions inherited from emu8086.inc
  DEFINE_SCAN_NUM
  DEFINE_PRINT_STRING
  DEFINE_PRINT_NUM
  DEFINE_PRINT_NUM_UNS  
  DEFINE_PTHIS
  DEFINE_CLEAR_SCREEN
  DEFINE_GET_STRING
  
  
;*****************************************************************************************************
;* procedure #0 (main)                                                                               *
;*                                                                                                   *
;* The program will prompt for what number'th program to exicute                                     *
;* ie. if userInput is #1, the program will execute the first program which is printing fibonacci    *
;*                                                                                                   *
;* Program will exit upon entering -1 when asked                                                     *
;*                                                                                                   *
;* #calling procedure: call main                                                                     *
;* #Defining procedure: define_main                                                                  *
;*                                                                                                   *
;*****************************************************************************************************
  
  main proc
   
    printn "Input 1 for Fibonacci"
    printn "Input 2 For HappyNumber"
    printn "Input 3 For PerfectNumber"
    printn "Input -1 to terminate the program"
    
    ;getting number in CX.
    call scan_num       
    
    ;moving curser to the nextLine
    call newLine
    
    ;storing the input in "input"
    mov userInput_main, cx
   
    ;deciding which proc to call (or if)
    cmp userInput_main, -1
    je call End
    
    ;to call Fibonacci
    cmp userInput_main, 1
    je call Fibonacci
    
    ;to call HappyNumber
    cmp userInput_main, 2
    je call HappyNumber
    
    ;to call PerfectNumber
    cmp userInput_main, 3
    je call PerfectNumber 
    
    ;if number is not valid
    call NotValid
    call main
    
    End:
      call clear_screen
      call reset_reg
      printn "Are you sure you want to close the program? (y/n)"
       
      input:        
        mov ah, 1
        int 21h
        mov cl, al
        
        mov al, 0
        int 21h
        cmp al, 13
        je finished
        
        cmp al, 8
        je remove
        jmp wrong
       
        
      remove:
        mov ah, 2
        mov dl, 8
        int 21h
        mov dl, 32
        int 21h
        mov dl, 8
        int 21h
        
        jmp input
        
        
      wrong:
        call clear_screen
        printn "Wrong Input, enter either n or y : "
        jmp input
        
        
      noEnd:
        call clear_screen
        printn "Returning to the program"
        call clear_screen
        call main
      
        
      finished:
        cmp cl, 'n'
        je noEnd
        
        mov ah,4ch 
        int 21h
        
  endp main


;*****************************************************************************************************
;* procedure #1                                                                                      *  
;*                                                                                                   *
;* This procedure will prompt for the n'th number                                                    *
;* ie. if userInput is 10, the program will print the fibonacci series till 10'th numbers            *
;*                                                                                                   *
;* #calling procedure: call Fibonacci                                                                *
;* #Defining procedure: define_Fibonacci                                                             *
;*                                                                                                   *
;*****************************************************************************************************

  Fibonacci proc
    call clear_Screen
    call Reset_reg
    
    
    call newLine
    call main  
  endp Fibonacci


;*****************************************************************************************************
;* procedure #2                                                                                      *
;*                                                                                                   *
;* The program will prompt for a number to check if the number is HappyNumber                        *
;* ie. if userInput is 10, the program will check if 10 is a HappyNumber                             *
;*                                                                                                   *
;* #calling procedure: call HappyNumber                                                              *
;* #Defining procedure: define_HappyNumber                                                           *
;*                                                                                                   *
;*****************************************************************************************************

  HappyNumber proc
    call clear_Screen
    call Reset_reg
    
    
    call newLine
    call main
  endp HappyNumber 


;*****************************************************************************************************
;* procedure #3                                                                                      *
;*                                                                                                   *
;* The program will prompt for a number to check if the number is a PerfectNumber                    *
;* ie. if userInput is 10, the program will check if 10 is a PerfectNumber                           *
;*                                                                                                   *
;* #calling procedure: call PerfectNumber                                                            *
;* #Defining procedure: define_PerfectNumber                                                         *
;*                                                                                                   *
;*****************************************************************************************************

  PerfectNumber proc
    call clear_Screen
    call Reset_reg
    
    
    call newLine
    call main
  endp PerfectNumber


;*****************************************************************************************************
;* Procedure NotValid                                                                                *
;*                                                                                                   *
;* This procedure will be called upon invalid userInput (!(1,2,3))                                   *
;* The program will clear the screen                                                                 *
;* prompt "Invalid Input"                                                                            *
;* And return to the calling procedure, so you'll have to re-direct your desired way indirectly                                                                               *
;*                                                                                                   *
;* #calling procedure: call NotValid                                                                 *
;* #Defining procedure: define_NotValid                                                              *
;*                                                                                                   *
;*****************************************************************************************************

  NotValid proc
    call reset_reg
    call clear_screen
    printn "Invalid Input"
    ret
  endp NotValid
 
  
;*****************************************************************************************************
;* Procedure Reset_reg                                                                               *
;*                                                                                                   *
;* This procedure will reset the value of each general purpose register                              *
;* And then, return to the calling procedure                                                         *
;*                                                                                                   *
;* #calling procedure: call reset                                                                    *
;* #Defining procedure: define_reset                                                                 *
;*                                                                                                   *
;*****************************************************************************************************

  Reset_reg proc
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov dx, 0
    ret
  endp Reset_reg
  
  
;*****************************************************************************************************
;* Procedure newLine                                                                                 *
;*                                                                                                   *
;* This procedure will move the curser to the next line and to the left-most edge                    *
;* And then, return to the calling procedure                                                         *
;*                                                                                                   *
;* #calling procedure: call newLine                                                                  *
;* #Defining procedure: define_newLine                                                               *
;*                                                                                                   *
;*****************************************************************************************************

  newLine proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
  endp newLine


;******************************************************
;*                                                    *
;*               END OF THE PROGRAM                   *
;*                                                    *
;******************************************************
END main
