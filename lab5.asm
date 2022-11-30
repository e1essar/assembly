section .text

global _start 

_start:

mov eax, 0  ; начальное значение eax  
mov ecx, [a]  ; занесение a и k в регистры для работы с ними 
mov edx, [k] 

cmp edx, 0 ; если k < 0, то некорректный ввод
jl ERROR

cmp edx, 1    ; если k=1, то результат будет равен n 
je One1

cmp ecx, 0 ; если a < 0, то результат будет зависеть от четности степени k
jl Minus

cmp ecx, 1    ; если a=1, то результат будет равняться «1» 
je One 

cmp edx, 0    ; если k=0, то результат будет равен 1 
je One 

jmp Miss ; если нет отрицательных и частных случаев то переходим к основному циклу

Minus: ; обработка отрицательного а

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

mov eax, [k] ; проверка четности k, при четном k минус у а исчезает, иначе - остается
mov ebx, 2
div ebx
cmp edx, 0
je EvenOrNot

mov edx, 1    ; вывод знака минуса
mov ecx, minus
mov ebx, 1 
mov eax, 4 
int 0x80 

EvenOrNot: ; превращение отрицательного а в положительное после вывода знака минуса если необходимо

xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx

mov eax, [a]
mov ebx, -1
mul ebx
mov [a], eax
mov eax, 0
mov ecx, [a]
mov edx, [k]

Miss:

Cycle2:         ; 2-ой цикл возведения в степень 

mov ebx, [a]; обновление ebx 
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
mov ecx, [a] ; обработка частного случая при k = 1 при отрицательном а
cmp ecx, 0
jl MinusRes

mov eax, [a]  ; результат a' 
jmp ende

MinusRes:

mov edx, 1 
mov ecx, minus
mov ebx, 1 
mov eax, 4 
int 0x80 

mov eax, [a]
mov ebx, -1
mul ebx

ende: 

mov [a], eax 

xor eax, eax 
xor ebx, ebx 
xor ecx,ecx 
xor edx,edx 

mov eax, [a]; занесение в регистр кода числа n 
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
mov [a]   , dl 
add [a]   , byte 48 
mov [buff], ecx ; запоминаем текущее количество итераций, так как , далее выводим символ и необходимо использовать регистр ecx 

mov edx, 1  ; вывод остатков(числа) 
mov ecx, a 
mov ebx, 1 
mov eax, 4 
int 0x80 

mov ecx, [buff]  ;помещение ecx в переменную для сохранения значения  

loop fromStek    ;цикл 

jmp  end 

ERROR: ;некорректный ввод 

mov edx, len 
mov ecx, msg 
mov ebx, 1 
mov eax, 4 
int 0x80 

jmp  end 

OVER: ;переполнение 

mov edx, len1 
mov ecx, msg1 
mov ebx, 1 
mov eax, 4 
int 0x80 

end:;конец 

mov eax, 1 
int 0x80

section .data 
a dd -3
k dd 4
minus dd '-'
buff dd 0 
msg db "НЕКОРРЕКТНЫЙ ВВОД" 
len equ $ - msg 
msg1 db "ПЕРЕПОЛНЕНИЕ" 
len1 equ $ - msg1 