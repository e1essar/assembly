section .text

global _start

_start:

    mov eax, [x]
    mov ebx, [y]
    
    cmp eax, 0
    jl l1
    cmp ebx, 0
    jl l1
    jmp no
    l1:
    mul eax
    xor edx, edx
    xchg eax, ebx
    mul eax
    xor edx, edx
    add eax, ebx
    cmp eax, 4
    jg l2
    jmp no
    l2:
    mov eax, [x]
    mov ebx, [y]
    cmp eax, 2
    jge l3
    cmp eax, a
    jle l3
    cmp ebx, 2
    jge l3
    cmp ebx, a
    jle l3
    jmp yes
    l3:
    jmp no
    
    no:
    
    mov     ecx, msg1
    mov     edx, len1
    mov     ebx, 1
    mov     eax, 4
    int     0x80
    
    jmp exit
    
    yes:
    
    mov     ecx, msg
    mov     edx, len
    mov     ebx, 1
    mov     eax, 4
    int     0x80
    
    exit:

    mov     eax, 1
    int     0x80

section .data
    x dw 2
    y dw 0
    a dw -2
    msg db  "Yes"
    len equ $ - msg
    msg1 db  "No"
    len1 equ $ - msg1
