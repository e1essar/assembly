global _start
section .data
n   dd 0
m dd 0
buff dd 0
msg db "Wrong input!"
len equ $ - msg
msg1 db "Overflow"
len1 equ $ - msg1
section .bss
strA resb 255
section .text
_start:
 
mov eax,3   ;input n and m
mov ebx,0
mov ecx, strA
mov edx, 255
int 0x80

 
xor eax,eax ;clear
xor ebx,ebx
xor edi,edi
xor edx,edx

mov edi,strA ;put adress of the first pos into edi
jo OVER ;overflow

mov ecx, 10  ;ecx = 10

L1: ;num to string
 
mov bl, [edi] 
inc edi 
 
cmp bl, '0';check input
jl NEXT
cmp bl, '9'
jg NEXT
 
sub bl, '0'
 
mul ecx  
jo OVER 
add eax, ebx  
 
mov [n], eax 
 
jmp L1

NEXT:
 
cmp ebx ,' ' ;end of input n 
je VD
jmp ERROR
 
VD:

xor eax, eax
xor edx, edx
xor ebx, ebx

L2:

mov bl, [edi] 
inc edi 
 
cmp bl, '0'
jl NEXT1
cmp bl, '9'
jg NEXT1
 
sub bl, '0'
 
mul ecx  
jo OVER 
add eax, ebx  
 
mov [m], eax 

jmp L2

NEXT1:
 
cmp ebx ,0xA
je VD1
jmp ERROR
 
VD1:

mov eax, 0  
mov ecx, [n] 
mov edx, [m]

cmp ecx, 1    ;some if's
je One
cmp edx, 1    
je One1
cmp edx, 0    
je One
Cycle2:         
mov ebx, [n]
mov eax, 0
Cycle1:         
dec ebx         
add eax, ecx  
jo OVER
cmp ebx, 0    
jg Cycle1
dec edx         
mov ecx, eax
cmp edx, 1   
jg Cycle2
jmp ende        
One:
mov eax, 1 
jmp ende      
One1:
mov eax, [n]  
ende:
mov [n], eax
 
xor eax, eax
xor ebx, ebx
xor ecx,ecx
xor edx,edx
 
mov eax, [n]

mov ebx, 10;  10 
 
continueDIV:
 
div  ebx
push edx
inc  ecx
 
xor edx, edx 
 
cmp  eax, 0
jne continueDIV
 
fromStek:
pop edx;
mov [n]   , dl
add [n]   , byte 48
mov [buff], ecx
 
mov edx, 1  
mov ecx, n
mov ebx, 1
mov eax, 4
int 0x80
 
mov ecx, [buff]   
 
loop fromStek    
 
jmp  end
 
ERROR:
mov edx, len
mov ecx, msg
mov ebx, 1
mov eax, 4
int 0x80
jmp  end

OVER:
mov edx, len1
mov ecx, msg1
mov ebx, 1
mov eax, 4
int 0x80
 
end:
mov eax, 1
int 0x80
