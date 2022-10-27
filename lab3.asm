section .text

global _start

_start:

    mov eax, [n] ; eax = n
    mov ecx, 10 ; ecx = 10
    
    ; first of all, determine count of numbers in cycle
    
    whileN: cmp eax, 0 ; while(n!=0) countOfNumbers++, n=n/10
    je next ; n!=0
    inc ebx ; count++ (ebx is countOfNumbers)
    div ecx ; n=n/10 (clipping a remainder)
    xor edx, edx ; clear edx
    jmp whileN ; cycle
    next: ; end of the cycle
    
    ; ebx is count of numbers now
    ; check is it even or not to determine the sign of the series
    ; if count is even - sign will be -1, if not - 1
    
    mov eax, ebx ; eax = count of numbers (even or not)
    mov ebx, 1 ; ebx = 1 (for sign)
    mov ecx, 2 ; ecx = 2 (for checking even or not)
    div ecx ; count % 2
    cmp edx, 0 ; ==0?
    jne evenOr ; 
    mov ebx, -1 ; ebx = -1 (for sign)
    evenOr:
    mov [sign], ebx ; sign = ebx (determined sign)
    
    ; after that let's calculate the sum of the series
    ; if count of numbers is even last number will be negative
    ; we will use sign to define it
    
    mov eax, [n] ; eax = n (for calculating sum of the series)
    xor ebx, ebx ; clear
    mov ecx, 10 ; ecx = 10 (for determine numbers(remainders))
    xor edx, edx ; clear
    
    ; cycle while n is not over 
    ; let's pick remainders multiplied by current sign
    ; and add it to current sum everytime changing sign
    
    whileN1: cmp eax, 0 ; while(n!=0) sum = sum + (n%10)*sign, sign = sign * (-1), n = n/10
    je next1 ; n!=0
    div ecx ; eax = n/10, edx = n%10
    mov [n], eax ; n = eax (current n while it's over)
    mov eax, edx ; eax = edx (eax = n%10)
    mov ebx, [sign] ; ebx = sign (-1 or 1)
    mul ebx ; (n%10)*sign
    mov ebx, eax ; ebx = (n%10)*sign
    mov eax, [sum] ; eax = sum (at beginning sum = 0)
    add eax, ebx ; eax(sum) = currentSum + (n%10)*sign
    mov [sum], eax ; sum = eax(current sum)
    mov eax, [sign] ; eax = sign
    mov ebx, -1 ; ebx = -1
    mul ebx ; eax(sign) = currentSign*(-1) for changing sign of next num
    mov [sign], eax ; sign = eax
    mov eax, [n] ; eax = n
    xor edx, edx ; clear edx after operations
    jmp whileN1 ; cycle
    next1: ; end cycle
    
    mov ecx, msg ; message about sum
    mov edx, len
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    ;for output sum firstly let's check is it negative or positive
    
    mov eax, 0 ; eax = 0
    mov ebx, [sum] ; ebx = sum
    xor ecx, ecx
    xor edx, edx
    cmp ebx, 0 ; sum < 0
    jge negative ; if < 0
    sub eax, ebx ; eax = 0-(negativeSum)
    mov [sum], eax ; sum = eax
    
    mov ecx, minus ; output sign '-'
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    negative: ; end for negative
 
    ;output long number(sum) (in previous labs) 
 
    mov eax, [sum]
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
    mov [c], edx
    add [c], byte 48
    mov [buff], ecx 
 
    mov edx, 1  
    mov ecx, c
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov ecx, [buff]
 
    loop fromStek

    mov eax, 1
    int 0x80

section .data
    ;main variables
    n dd 1234 ; input natural number
    sum dd 0 ; sum
    sign dd 0 ; current sign
    
    ;for output long (negative) number
    minus dd '-'
    c dd 0
    buff dd 0
    msg db  "sum is "
    len equ $ - msg