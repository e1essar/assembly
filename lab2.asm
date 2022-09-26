section .text

global _start

_start:

    mov eax, [x] 
    cmp eax, 0
    jle L1
    ;if (x>0 && y>0) NO else L1
    mov eax, [y] 
    cmp eax, 0
    jle L1
    
    jmp NO
    
    L1:
    mov eax, [x]
    imul eax
    mov ebx, eax
    mov eax, [y]
    imul eax
    add eax, ebx
    
    cmp eax, 4 ;if (x*x+y*y < 4) NO else L2
    jge L2
    
    jmp NO
    
    L2:
    mov eax, [x]
    cmp eax, 2 ;if
    jg L3
    
    cmp eax, -2
    jl L3
    
    mov eax, [y]
    cmp eax, 2
    jg L3
    
    cmp eax, -2
    jl L3
    
    jmp YES
    
    L3:
    jmp NO
    
    YES:
    
    mov     ecx, msgYes
    mov     edx, lenYes
    mov     ebx, 1
    mov     eax, 4
    int     0x80
    
    jmp exit
    
    NO:
    
    mov     ecx, msgNo
    mov     edx, lenNo
    mov     ebx, 1
    mov     eax, 4
    int     0x80
    
    exit:

    mov     eax, 1
    int     0x80

section .data
    x dd 3
    y dd 0
    msgYes db  "Yes"
    lenYes equ $ - msgYes
    msgNo db  "No"
    lenNo equ $ - msgNo
