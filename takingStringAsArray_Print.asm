Title <> Taking ONE String input as array 

;charecter limit 100-1 (chars + one enter)

include 'emu8086.inc' 



.model small
.stack 100h  


.data  

    array db 100  dup (0)

.code   

    mov ax,@data
    mov ds,ax

main proc
    mov cl, 0Dh
    Start:
    
    mov ah, 1
    int 21h
    
    mov array[si], al
    inc si
    cmp al, cl
    je print
    jmp start
    
    
    print:
        mov si, 0
        mov ah, 2
        mov dl, 10  
        int 21h
        mov dl, 13
        int 21h
        process:  
                        
            mov ah, 2
            mov dl, array[si]
            cmp cl, dl
            je end
            inc si
            int 21h
            jmp process 
            
            ;INSTEAD PROCESS, I COULD DO THE FOLLOWING
            ;LEA DX, ARRAY
            ;MOV AH, 09H
            ;INT 21H
    
    end:
       mov ah,4ch 
       int 21h     
    
        

   
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS  
DEFINE_PTHIS


