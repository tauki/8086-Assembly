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
;* Samin Azhan                                          *
;* ID: 14101005                                         *
;*                                                      *
;* Al Faysal Bin Asad                                   *
;* ID: 13101095                                         *
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
.stack 9999h

.data 
  ;global variable/ data declaration
  userInput_main dw  0 ; this variable is for the main function's use only
  userInput_secondary dw 0
  seconds dw 0
    second_count dw 0
  count dw 0 ; reset it to 0 after every use
  sum dw 0 
  
  ;data initializing segment for PerfectNumber
  a dw 100 dup(0)  
  
  ;dara initializing segment for FibonacciSeries
  first db 210 dup(0)
  second db 210 dup(0)
  temp db 210 dup(0) 
  carry db 0
  
  ;data initializing segment for HappyNumber

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
        print "Returning to the program "
        dots:
          mov seconds, 1
          call delay
          putc '.'
          inc count
          cmp count, 3
          jl dots
          mov count, 0
        call delay        
        call clear_screen
        call main
      
        
      finished:
        cmp cl, 'n'
        je noEnd
        
        call clear_screen
        print "Thank you for using this program!"
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
    mov si, 0
    initialize_array_fib:
        mov first[si], 0
        mov temp[si], 0
        mov second[si], 0
        inc si
        cmp si, 210
        jl initialize_array_fib
        jmp init_end    
         
    init_end:
    printn ""
    call scan_num
    call newLine
    
    printn "Printing fibonacci series till the defined'th value"
    call newLine
    
    mov userInput_secondary, cx
    cmp userInput_secondary, 0
    jle call NotValid
    cmp userInput_secondary, 9999
    jg call NotValid
    mov count, 0
    
    mov si, 209
    mov second[si], 1  
   
    mov si, 0
    jmp one
    
    process:
        call newLine
        call Reset_reg 
        mov cx, userInput_secondary
                
        cmp count, cx
        jge end_fib
        
        mov si, 209
        mov ax, 0
        mov di, 0
        move:
            
            mov ax, 0
            mov al, first[si]
            mov temp[si], al
            mov ax, 0
            mov al, second[si]
            mov first[si], al
            
            mov ax, 0
            mov al, temp[si]
            add al, second[si]
            add al, carry
            cmp al, 10
            jge setCarry_eg
            cmp al, 10
            jl setCarry_less
            
            setCarry_eg:
                sub al, 10
                mov carry, 1d
                jmp summing
            setCarry_less:
                mov carry, 0
                jmp summing
            summing:
                mov second[si], al
                     
            dec si
            
            cmp si, 0
            jg move 
            
            jmp dealZeros
        
        
        dealZeros:
            call Reset_reg
            mov si, 0 
            inc count
            jmp start_deal
        
        start_deal:        
                call Reset_reg
                cmp first[si], 0
                jg print_start
                inc si
                jmp start_deal
            
        print_start:
            cmp si, 210
            jge process
            mov ax, 0
            mov al, 0
            mov al, first[si]
            call print_num
            inc si
            jmp print_start    
    
    one:
        mov ax, 0
        call print_num
        inc count       
        jmp process
        
    end_fib:
        call newLine
        printn "Do you wan't to print any more fibonacci series?"
        printn "Press enter/input 0 to print more fibonacci series"
        printn "input -1 to terminate fibonacci"
        
        call scan_num
        cmp cx, 0
        je call Fibonacci
             
        cmp cx, -1
        je terminate
        
        call NotValid
        jmp end_fib
        
        terminate: 
            call newLine
            print "terminating fibonacci" 
            dot:
                mov seconds, 1
                call delay
                putc '.'
                inc count
                cmp count, 3
                jl dots
                mov count, 0
            call delay
            call clear_screen
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
    
    printn "Enter number to check if it is Perfect or not"
    
    CALL scan_num
    mov userInput_secondary, cx
    
    cmp userInput_secondary, 0
    JG begin
    call NotValid
    call clear_Screen
    call Reset_reg
    call PerfectNumber
    
    begin:
        mov SI,0
            
        initialize_array:    
            
            mov a[SI],0
            inc SI
            inc SI
            cmp SI,200
            JL initialize_array
            
        mov sum,0
        mov BX,1
        mov SI,0
        mov CX, userInput_secondary
        mov DX,0
        
        find_divisors:
            
            cmp BX,CX
            JGE check
            mov AX,userInput_secondary
            mov DX,0
            div BX        
            cmp DX,0        
            JE array_add
            inc BX
            JMP find_divisors
        
        array_add:
            mov a[SI],BX
            inc SI
            inc SI
            inc BX
            JMP find_divisors
            
        check:
            mov SI,0
            start_check:
                cmp a[SI],0
                JE  final_check
                mov BX,a[SI]
                add sum,BX
                inc SI
                inc SI
                JMP start_check    
            
        final_check:
            mov CX,userInput_secondary
            cmp CX,sum
            JE print_yes
            
            call newLine
            print "No, that is not a perfect number."
    
            JMP end_perfect
               
        print_yes:
            
            call newLine
            print "Yes! That is a perfect number."
    
            JMP end_perfect
            
        end_perfect:
            call newLine
            call newLine
            printn "Input enter to check more perfect numbers"
            printn "Input -1 to return the main program"
            
            call scan_num
            cmp cx,-1
            je call main
            
            cmp cx, 0
            je call PerfectNumber
            call NotValid
            jmp end_perfect
 
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


;*****************************************************************************************************
;* Procedure delay                                                                                   *
;*                                                                                                   *
;* This procedure interrupt the process for 1 second or 1 million micro-seconds                      *
;* Upon calling this, the program will wait for 1 second                                             *
;* And then it will return to the calling procedure to execute the next instruction                  *
;*                                                                                                   *
;* #calling procedure: call delay                                                                    *
;*  * initially, upon calling the procedure, it will set the second_count to 0 before beginning      *
;*    * reason: stupidity                                                                            *
;*  * use the defined variable seconds to set how long you want the program to delay (in seconds)    *
;*  * don't use the variable seconds for other purposes                                              *
;*  * the procedure will reset seconds to 0 everytime you call the it                                *
;*  * the procedure will reset second_count to 0 upon calling it after the delaying is done          *
;* #Defining procedure: define_delay                                                                 *
;*                                                                                                   *
;*****************************************************************************************************

delay proc
    mov second_count, 0
    mov bx, seconds
    start_delay:
      mov cx, 0Fh
      mov dx, 4240h
      mov ah, 86H
      int 15h
      inc second_count
      cmp second_count, bx
      jl start_delay
    mov second_count, 0
    mov seconds, 0
    ret 
endp delay
  
;******************************************************
;*                                                    *
;*               END OF THE PROGRAM                   *
;*                                                    *
;******************************************************
END main
