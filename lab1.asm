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
 
div  ebx; деление нашего числа на 10 
push edx; помещение остатка в стек(последней цифры числа)
inc  ecx; повышение счетчика ecx(количества цифр)
 
xor edx, edx ; обнуляем регистр
 
cmp  eax, 0; проверка целой части числа(== 0?)
jne continueDIV; если не равно 0 то цикл
 
fromStek:
pop edx;
mov [n]   , edx
add [n]   , byte 48
mov [buff], ecx ; запоминаем текущее количество итераций, так как , далее выводим символ и необходимо использовать регистр ecx
 
mov edx, 1  ; вывод остатков(числа)
mov ecx, n
mov ebx, 1
mov eax, 4
int 0x80

mov ecx, [buff]  ; помещение ecx в переменную для сохранения значения 
 
loop fromStek    ; цикл

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
 
div  ebx; деление нашего числа на 10 
push edx; помещение остатка в стек(последней цифры числа)
inc  ecx; повышение счетчика ecx(количества цифр)
 
xor edx, edx ; обнуляем регистр
 
cmp  eax, 0; проверка целой части числа(== 0?)
jne continueDIV1; если не равно 0 то цикл
 
fromStek1:
pop edx;
mov [n]   , edx
add [n]   , byte 48
mov [buff], ecx ; запоминаем текущее количество итераций, так как , далее выводим символ и необходимо использовать регистр ecx
 
mov edx, 1  ; вывод остатков(числа)
mov ecx, n
mov ebx, 1
mov eax, 4
int 0x80

mov ecx, [buff]  ; помещение ecx в переменную для сохранения значения 
 
loop fromStek1    ; цикл


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
