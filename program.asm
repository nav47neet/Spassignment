section .bss
    num resb 1         
    result resw 1      

section .text
    global _start

_start:
    ; Display prompt to enter the number
    mov eax, 4         
    mov ebx, 1         
    mov ecx, prompt    
    mov edx, prompt_len
    int 0x80           

    
    mov eax, 3         
    mov ebx, 0         
    mov ecx, num       
    mov edx, 1        
    int 0x80          

    
    movzx eax, byte [num] 
    sub eax, '0'     

   

    
    push eax          
    call fibonacci
    add esp, 4       

    
    mov eax, 4        
    mov ebx, 1        
    mov ecx, result  
    mov edx, 4        
    int 0x80          

   
    mov eax, 1         
    xor ebx, ebx       
    int 0x80          

  

fibonacci:
    
    cmp eax, 0
    je fib_zero
    cmp eax, 1
    je fib_one

    

    
    push eax

   
    dec eax             
    call fibonacci

   
    mov edx, [result]   
    pop eax             
    
    sub eax, 2         
    call fibonacci

  
    add [result], edx   

    ret

fib_zero:
   
    mov word [result], 0
    ret

fib_one:
   
    mov word [result], 1
    ret

section .data
    prompt db "Enter a single-digit number: ", 0x0a 
    prompt_len equ $ - prompt 