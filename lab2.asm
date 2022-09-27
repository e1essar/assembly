section .text

global _start

_start:

    mov eax, [x] ; eax = x
    mov ebx, [y] ; ebx = y
   
    ;if (x>0 && y>0) NO else L1 (elimination of 1st quarter)
    cmp eax, 0 ; x > 0 or !(x <= 0)
    jle L1     ; if not goto L1
    
    cmp ebx, 0 ; y > 0 or !(y <= 0)
    jle L1     ; if not goto L1
    
    jmp NO     ; if goto NO
    
    L1: 
    ;if (x*x+y*y < 4) NO else L2 (in-circle elimination)
    mov eax, [x] ; eax = x
    mul eax      ; eax = x*x
    mov ebx, eax ; ebx = x*x
    mov eax, [y] ; eax = y
    mul eax      ; eax = y*y
    add eax, ebx ; eax = x*x+y*y
    
    cmp eax, 4 ; x*x+y*y < 4
    jge L2     ; if not goto L2
       
    jmp NO     ; if goto NO
     
    L2:
    ;if (x <= 2 && x >= (-2) && y <= 2 && y >= (-2)) (in-square inclusion)
    mov eax, [x] ; eax = x
    cmp eax, 2   ; x <= 2
    jg L3        ; if not goto L3
    
    cmp eax, -2  ; x >= 2
    jl L3        ; if not goto L3
    
    mov eax, [y] ; eax = y
    cmp eax, 2   ; y <= 2
    jg L3        ; if not goto L3
    
    cmp eax, -2  ; y >= -2
    jl L3        ; if not goto L3
    
    jmp YES      ; if goto YES
    
    L3:
    jmp NO       ; goto NO
    
    YES:         ; message that point is in the area
    
    mov     ecx, msgYes
    mov     edx, lenYes
    mov     ebx, 1
    mov     eax, 4
    int     0x80
    
    jmp exit     ; goto exit
    
    NO:          ; message that point in not in the area
    
    mov     ecx, msgNo
    mov     edx, lenNo
    mov     ebx, 1
    mov     eax, 4
    int     0x80
    
    exit:

    mov     eax, 1
    int     0x80

section .data
    x dd 2
    y dd 2
    msgYes db  "Yes, the point is on the area"
    lenYes equ $ - msgYes
    msgNo db  "No, the point is not in the area"
    lenNo equ $ - msgNo
