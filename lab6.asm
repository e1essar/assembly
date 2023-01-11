section .text

global _start

_start:
   
    mov esi, A
    mov edi, 0
    mov ecx, [len]
    mov ebx, min
    
    L:
        mov eax, [esi + 4 * edi]
        cmp eax, ebx
        jge newMin
            mov ebx, eax
        newMin:
        inc edi
    loop L

    mov [min], ebx
    
    mov esi, A
    mov edi, 0
    mov ecx, [len]
    mov ebx, min
    
    L2:
        mov eax, [esi + 4 * edi]
        sub eax, ebx
        mov [esi + 4 * edi], eax
        inc edi
    loop L2
    
    
    
    mov esi, A
    mov edi, 0
   
    mov eax, [esi + 4 * edi]
    add eax, '0'
    mov [v], eax
        
    mov edx, 1  
    mov ecx, v
    mov ebx, 1 
    mov eax, 4 
    int 0x80 

    mov eax, 1
    int 0x80

section .data
    A dd 4, 5, 4, 8, 9, 10, 7, 6, 4, 0
    len dd 10
    min dd 0
    v dd 0
