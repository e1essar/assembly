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

lea edi, [s]
xor ecx, ecx
mov ebx, 10
div:
xor edx, edx
inc ecx
div ebx
add edx, '0'
push edx
test eax, eax
jnz div

mov [lenn], ecx
store:
pop eax
stosb
loop store

mov edx, len
mov ecx, msg
mov ebx, 1
mov eax, 4
int 0x80

mov eax, 4 ; вывожу строку
mov ebx, 1
mov ecx, s
mov edx, [lenn]

int 0x80

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

mov eax, [A]
mov ebx, [B]
mov ecx, [C]

mul ebx
xchg eax, ebx
mov eax, [count]
mul ecx
mul ecx
xchg eax, ebx
sub eax, ebx

lea edi, [s1]
xor ecx, ecx
mov ebx, 10
div1:
xor edx, edx
inc ecx
div ebx
add edx, '0'
push edx
test eax, eax
jnz div1

mov [lenn1], ecx
store1:
pop eax
stosb
loop store1

mov edx, len1
mov ecx, msg1
mov ebx, 1
mov eax, 4
int 0x80


mov eax, 4 ; вывожу строку
mov ebx, 1
mov ecx, s1
mov edx, [lenn1]
int 0x80

mov eax, 1
int 0x80

section .data
A dd 11
B dd 10
C dd 4
count dd 0
msg db "count: "
len equ $ - msg
msg1 db " area: "
len1 equ $ - msg1

section .bss
s resb 255
lenn resd 1
s1 resb 255
lenn1 resd 1