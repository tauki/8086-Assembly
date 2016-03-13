TITLE ADDING TWO ARRAY
include 'emu8086.inc'
              
.model small
         
.stack 100h
        
.data 
        
    a dw 5 dup(0)  
    b dw 5 dub(0)
        
.code 
        
    mov ax,@data
    mov ds,ax
         
    mov si,0
    mov bl,0
          
    input1: 
        
        cmp bl,5
        je reset1
        inc bl
        
        call scan_num
        mov a[si],cx 
        inc si
        inc si 
        
        mov ah,2
        mov dl,13
        int 21h  
        
        
        mov ah,2
        mov dl,10
        int 21h
        
        jmp input1
        
    reset1:
        mov si,0
        mov bl,0
        jmp input2
                  
    input2: 
        
        cmp bl,5
        je reset2
        inc bl
        
        call scan_num
        mov b[si],cx 
        inc si
        inc si 
        
        mov ah,2
        mov dl,13
        int 21h  
        
        
        mov ah,2
        mov dl,10
        int 21h
        
        jmp input2
         
         
    reset2:
        mov si,0
        mov bl,0 
        jmp print
        
          
    print: 
        
        cmp bl,5
        je end_print
        inc bl
         
        mov ax, a[si] 
        add ax, b[si]
        call print_num
        inc si 
        inc si
        
        mov ah,2
        mov dl,13
        int 21h  
        
        
        mov ah,2
        mov dl,10
        int 21h
        
        jmp print
        
        
        end_print: 
         
         
        define_scan_num 
        define_print_num
        define_print_num_uns