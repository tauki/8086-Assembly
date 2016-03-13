;This program only takes input of single digit numbers
;The algorithm is implemented, for more than one digit, couple of things will need to change

TITLE <> GCD

mov ah, 1   
int 21h
sub al, 30h
mov bl, al  ; bl --> a

; moving courser to the next line
mov dl, 0Dh
mov ah, 2
int 21h
mov dl, 0Ah 
int 21h

mov ah, 1   
int 21h
sub al, 30h
mov bh, al  ; bh --> b

; bh, bl%bh

Start:
    cmp bh, 0
    je end
    mov al, bl ; al --> a to mod
    mov ah, 0
    div bh 
    mov bl, bh
    mov bh, ah
    jmp Start  
    
end:
    mov dl, 0Dh
    mov ah, 2
    int 21h
    mov dl, 0Ah 
    int 21h
    mov dl, bl
    add dl, 30h
    int 21h
    
    mov ah, 4ch
    mov al, 00h
    int 21h
    end

; Euclidean algorithm    
    
;function gcd(a,b)
;    while b != 0
;        t = b;
;        b = a%b;
;        a = t;
;    return a;

;//

; Recursive implementation of Euclidean algorithm

;function gcd(a, b)
;    if b = 0
;       return a; 
;    else
;       return gcd(b, a mod b);
;