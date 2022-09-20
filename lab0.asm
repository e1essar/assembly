global _start
section .data
n   dd 0
m dd 0
buff dd 0
msg db "НЕКОРРЕКТНЫЙ ВВОД"
len equ $ - msg
msg1 db "ПЕРЕПОЛНЕНИЕ"
len1 equ $ - msg1
section .bss
strA resb 255
section .text
_start:
 
mov eax,3      ; ВВОД ЧИСЛА n и m
mov ebx,0
mov ecx, strA
mov edx, 255
int 0x80

 
xor eax,eax        ; ОЧИСТКА РЕГИСТРОВ
xor ebx,ebx
xor edi,edi
xor edx,edx

mov edi,strA ;заносим адрес на первый элемент в регистр edi
jo OVER ;проверка на переполнение

mov ecx, 10  ; в ecx 10

L1: ;цикл превращения строки в число
 
mov bl, [edi] ; занесение в регистр значения элемента массива
inc edi ; переход на следующий элемент
 
cmp bl, '0'; проверка на ввод именно цифр
jl NEXT
cmp bl, '9'
jg NEXT
 
sub bl, '0'
 
mul ecx  ; умножение eax на ecx 
jo OVER  ; проверка на переполнение
add eax, ebx  ; сложение eax и ebx
 
mov [n], eax ; занесение вводимого числа n из eax
 
jmp L1; цикл перевода (ввода) строки

NEXT:
 
cmp ebx ,' '; окончание ввода n
je VD
jmp ERROR;если введены не цифры, то переход на ошибку
 
VD:

xor eax, eax
xor edx, edx
xor ebx, ebx

L2:

mov bl, [edi] ; занесение в регистр значения элемента массива
inc edi ; переход на следующий элемент
 
cmp bl, '0'; проверка на ввод именно цифр
jl NEXT1
cmp bl, '9'
jg NEXT1
 
sub bl, '0'
 
mul ecx  ; умножение eax на ecx 
jo OVER  ; проверка на переполнение
add eax, ebx  ; сложение eax и ebx
 
mov [m], eax ; занесение вводимого числа m из eax
 
jmp L2; цикл перевода (ввода) строки

NEXT1:
 
cmp ebx ,0xA; окончание строки
je VD1
jmp ERROR;если введены не цифры, то переход на ошибку
 
VD1:

mov eax, 0  ; начальное значение eax 
mov ecx, [n]  ; занесение n и m в регистры для работы с ними
mov edx, [m]

cmp ecx, 1    ; если n=1, то результат будет равняться «1»
je One
cmp edx, 1    ; если m=1, то результат будет равен n
je One1
cmp edx, 0    ; если m=0, то результат будет равен 1
je One
Cycle2:         ; 2-ой цикл возведения в степень
mov ebx, [n]; обновление ebx
mov eax, 0
Cycle1:         ; 1-й цикл возведения в степень
dec ebx         ; уменьшение счетчика ebx
add eax, ecx  ; операция сложения
jo OVER
cmp ebx, 0    ; условие для 1-ого цикла
jg Cycle1
dec edx         ; уменьшение счетчика edx
mov ecx, eax
cmp edx, 1   ; условие для 2-ого цикла
jg Cycle2
jmp ende        ; прыжок на end
One:
mov eax, 1 ; результат 1
jmp ende       ; прыжок на end
One1:
mov eax, [n]  ; результат n'
ende:
mov [n], eax
 
xor eax, eax
xor ebx, ebx
xor ecx,ecx
xor edx,edx
 
mov eax, [n]; занесение в регистр кода числа n

mov ebx, 10;  10 
 
continueDIV:
 
div  ebx; деление нашего числа на 10 
push edx; помещение остатка в стек(последней цифры числа)
inc  ecx; повышение счетчика ecx(количества цифр)
 
xor edx, edx ; обнуляем регистр
 
cmp  eax, 0; проверка целой части числа(== 0?)
jne continueDIV; если не равно 0 то цикл
 
fromStek:
pop edx;
mov [n]   , dl
add [n]   , byte 48
mov [buff], ecx ; запоминаем текущее количество итераций, так как , далее выводим символ и необходимо использовать регистр ecx
 
mov edx, 1  ; вывод остатков(числа)
mov ecx, n
mov ebx, 1
mov eax, 4
int 0x80
 
mov ecx, [buff]  ; помещение ecx в переменную для сохранения значения 
 
loop fromStek    ; цикл
 
jmp  end
 
ERROR:;некорректный ввод
mov edx, len
mov ecx, msg
mov ebx, 1
mov eax, 4
int 0x80
jmp  end

OVER:;переполнение
mov edx, len1
mov ecx, msg1
mov ebx, 1
mov eax, 4
int 0x80
 
end:;конец
mov eax, 1
int 0x80
