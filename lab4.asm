section .text

global _start

_start:
    
    mov ebx, [n]
    
    A1:
    mov eax, 0
    mov [y], eax
    mov [z], eax
    mov ecx, [x]
    cmp ecx, ebx
    jge A2
    
    B1:
    mov eax, 0
    mov [z], eax
    mov ecx, [y]
    cmp ecx, ebx
    jge B2
    
    C1: 
    mov edx, [z]
    cmp edx, ebx
    jge C2
    
    mov eax, [x]
    mul eax
    mov ecx, eax
    mov eax, [y]
    mul eax
    add eax, ecx
    mov ecx, eax
    mov eax, [z]
    mul eax
    add eax, ecx
    mov ebx, [n]
    cmp eax, ebx
    jne D
    jmp exit
    D:
    
    mov edx, [z]
    inc edx
    mov [z], edx
    
    jmp C1
    C2:
    
    mov ecx, [y]
    inc ecx
    mov [y], ecx
    
    jmp B1
    B2:
    
    mov ecx, [x]
    inc ecx
    mov [x], ecx
    
    jmp A1
    A2:
    
    mov ecx, msg
    mov edx, len
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    jmp end
    
    exit:
    
    mov eax, [x]
    xor ebx, ebx
    xor ecx,ecx
    xor edx,edx
    
    mov ebx, 10;  
 
    XcontinueDIV:
 
    div  ebx
    push edx
    inc  ecx
 
    xor edx, edx 
 
    cmp  eax, 0
    jne XcontinueDIV
 
    XfromStek:
    pop edx;
    mov [c], edx
    add [c], byte 48
    mov [buff], ecx 
 
    mov edx, 1  
    mov ecx, c
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, [buff]
 
    loop XfromStek
    
    mov edx, 1  
    mov ecx, space
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    mov eax, [y]
    xor ebx, ebx
    xor ecx,ecx
    xor edx,edx
    
    mov ebx, 10;  
 
    YcontinueDIV:
 
    div  ebx
    push edx
    inc  ecx
 
    xor edx, edx 
 
    cmp  eax, 0
    jne YcontinueDIV
 
    YfromStek:
    pop edx;
    mov [c], edx
    add [c], byte 48
    mov [buff], ecx 
 
    mov edx, 1  
    mov ecx, c
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, [buff]
 
    loop YfromStek
    
    mov edx, 1  
    mov ecx, space
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    mov eax, [z]
    xor ebx, ebx
    xor ecx,ecx
    xor edx,edx
    
    mov ebx, 10;  
 
    ZcontinueDIV:
 
    div  ebx
    push edx
    inc  ecx
 
    xor edx, edx 
 
    cmp  eax, 0
    jne ZcontinueDIV
 
    ZfromStek:
    pop edx;
    mov [c], edx
    add [c], byte 48
    mov [buff], ecx 
 
    mov edx, 1  
    mov ecx, c
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, [buff]
 
    loop ZfromStek
    
    end:

    mov     eax, 1
    int     0x80

section .data
    n dd 300
    x dd 0
    y dd 0
    z dd 0
    
    space dd ' '
    c dd 0
    buff dd 0
    msg db  "NO SQUARES"
    len equ $ - msg
