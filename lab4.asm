section .text

global _start

_start:
    
    mov ebx, [n]
    mov edx, 0
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
    
    mov ecx, msg
    mov edx, len
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    jmp end
    
    exit:
    
    mov eax, [z]
    add eax, '0'
    mov [z], eax

    mov ecx, z
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    end:

    mov     eax, 1
    int     0x80

section .data
    n dd 54
    x dd 1
    y dd 2
    z dd 0
    msg db  "NO"
    len equ $ - msg
    msg1 db  "YES"
    len1 equ $ - msg
