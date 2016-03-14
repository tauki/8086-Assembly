;********************************************************
;*              8086 Assembly program                   *
;*                                                      *
;*                  Group Project                       *
;*               Course Code: CSE341                    *
;*                 BRAC University                      *
;*                                                      *
;* Group Members:                                       *
;*----------------                                      *
;*                                                       *
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
;********************************************************

Title <> LabProject
; declarations
include 'emu8086.inc'
.model small

.stack 100h

.data  
  input dw  0

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

;*****************************************************************************************************
;* Program #0 (main)                                                                                 *
;*                                                                                                   *
;* This program will prompt for what number'th program to exicute                                    *
;* ie. if userInput is #1, the program will execute the first program which is printing fibonacci    *
;*                                                                                                   *
;* Program will exit upon entering -1 when asked                                                      *
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
    mov ah,2
    mov dl,13
    int 21h 
    mov dl,10
    int 21h
    
    ;storing the input in "input"
    mov input, cx
   
    ;deciding which proc to call (or if)
    cmp cx, -1
    je call End
    
    ;to call Fibonacci
    mov cx, input
    cmp cx, 1
    je call Fibonacci
    
    ;to call HappyNumber
    mov cx, input
    cmp cx, 2
    je call HappyNumber
    
    ;to call PerfectNumber
    mov cx, input
    cmp cx, 3
    je call PerfectNumber 
    
    ;if number is not valid
    call NotValid
    
    ;incase this happens
    mov cx, 0
    call main
    
    End:
      mov ah,4ch 
      int 21h
  
endp main


;*****************************************************************************************************
;* Program #1                                                                                        *  
;*                                                                                                   *
;* This program will prompt for the n'th number                                                      *
;* ie. if userInput is 10, the program will print the fibonacci series containing 10 numbers         *
;*                                                                                                   *
;*****************************************************************************************************

  Fibonacci proc
    
    call main 
  endp Fibonacci


;*****************************************************************************************************
;* Program #2                                                                                        *
;*                                                                                                   *
;* This program will prompt for a number to check if the number is HappyNumber                       *
;* ie. if userInput is 10, the program will check if 10 is a HappyNumber                             *
;*                                                                                                   *
;*****************************************************************************************************

  HappyNumber proc
    
    call main
  endp HappyNumber 


;*****************************************************************************************************
;* Program #3                                                                                        *
;*                                                                                                   *
;* This program will prompt for a number to check if the number is a PerfectNumber                   *
;* ie. if userInput is 10, the program will check if 10 is a PerfectNumber                           *
;*                                                                                                   *
;*****************************************************************************************************

  PerfectNumber proc
    
    call main
  endp PerfectNumber


;*****************************************************************************************************
;* Procedure NotValid                 
;*
;* 
;* 
;*
;*****************************************************************************************************

  NotValid proc
    mov cx, 0
    call clear_screen
    printn "Invalid Input"
    call main
  endp NotValid


;*****************************************************************************************************
;* Procedure END                                                                                     *
;*                                                                                                   *
;* This Function will stop running the program and return control to the OS                          *
;*                                                                                                   *
;*****************************************************************************************************


;******************************************************
;*                                                    *
;*            END OF THE PROGRAM                      *
;*                                                    *
;******************************************************
