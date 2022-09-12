section .text

global _start

_start:

mov eax, [A]
mov ebx, [B]
mov ecx, [C]

div ecx ;eax = A/C
xor edx, edx
xchg eax, ebx ;eax = B, ebx = A/C
div ecx ;eax = B/C
xor edx, edx
xchg eax, ebx ;eax = A/C, ebx = B/C
mul ebx ;eax = eax*ebx

mov [count], eax

mov edx, len
mov ecx, msg
mov ebx, 1
mov eax, 4
int 0x80

mov eax, [count]
xor ebx, ebx
xor ecx,ecx
xor edx,edx
    
mov ebx, 10;  
 
continueDIV:
 
    div  ebx 
    push edx
    inc  ecx
 
    xor edx, edx 
 
    cmp  eax, 0
    jne continueDIV
 
fromStek:
    pop edx;
    mov [n], edx
    add [n], byte 48
    mov [buff], ecx 
 
    mov edx, 1  
    mov ecx, n
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, [buff]  
 
    loop fromStek

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

mov eax, [A]
mov ebx, [B]
mov ecx, [C]

mul ebx
xor edx, edx
xchg eax, ebx
mov eax, [count]
mul ecx
xor edx, edx
mul ecx
xor edx, edx
xchg eax, ebx
sub eax, ebx
mov [count], eax

mov edx, len1
mov ecx, msg1
mov ebx, 1
mov eax, 4
int 0x80

mov eax, [count]

xor ebx, ebx
xor ecx,ecx
xor edx,edx
    
mov ebx, 10;  
 
continueDIV1:
 
    div  ebx
    push edx
    inc  ecx
 
    xor edx, edx 
 
    cmp  eax, 0
    jne continueDIV1
 
fromStek1:
    pop edx;
    mov [n], edx
    add [n], byte 48
    mov [buff], ecx 
 
    mov edx, 1  
    mov ecx, n
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, [buff]
 
    loop fromStek1


mov eax, 1
int 0x80

section .data
A dd 65
B dd 23
C dd 14
count dd 0
n dd 0
buff dd 0
msg db "count: "
len equ $ - msg
msg1 db " area: "
len1 equ $ - msg1
