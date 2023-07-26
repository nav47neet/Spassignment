section .bss
    num resb 1         ; Reserve space for the input number
    result resw 1      ; Reserve space to store the result

section .text
    global _start

_start:
    ; Display prompt to enter the number
    mov eax, 4         ; Linux syscall number for sys_write
    mov ebx, 1         ; File descriptor for stdout (1)
    mov ecx, prompt    ; Pointer to the prompt message
    mov edx, prompt_len ; Length of the prompt message
    int 0x80           ; Invoke the syscall

    ; Read the input number from the user
    ; For Artix Linux, we'll use x86 Linux syscall for reading from stdin
    mov eax, 3         ; Linux syscall number for sys_read
    mov ebx, 0         ; File descriptor for stdin (0)
    mov ecx, num       ; Buffer to store the input
    mov edx, 1         ; Number of bytes to read (1 byte for a single digit)
    int 0x80           ; Invoke the syscall

    ; Convert the ASCII input to an integer
    movzx eax, byte [num] ; Load the ASCII digit from 'num' and zero-extend it to eax
    sub eax, '0'      ; Convert ASCII to integer

    ; The input number is now in the AL register

    ; Call the Fibonacci function
    push eax          ; Save the input number on the stack
    call fibonacci
    add esp, 4        ; Clean up the stack after the function call

    ; Display the result
    ; Use system-specific code to display the result
    ; For Artix Linux, we'll use x86 Linux syscall for writing to stdout
    mov eax, 4        ; Linux syscall number for sys_write
    mov ebx, 1        ; File descriptor for stdout (1)
    mov ecx, result   ; Pointer to the result
    mov edx, 4        ; Length of the data to be written (4 bytes for a 16-bit integer)
    int 0x80          ; Invoke the syscall

    ; Exit the program
    ; Add system-specific code here to exit the program gracefully
    ; For Artix Linux, we'll use x86 Linux syscall for exiting the program
    mov eax, 1         ; syscall number for sys_exit
    xor ebx, ebx       ; exit status (0 in this case)
    int 0x80          ; invoke the syscall

    ; This code should never be reached, but it's added to satisfy linker requirements
    ret

fibonacci:
    ; Check for the base cases (fib(0) = 0, fib(1) = 1)
    cmp eax, 0
    je fib_zero
    cmp eax, 1
    je fib_one

    ; Recursive case: Calculate fib(n) = fib(n-1) + fib(n-2)

    ; Save the current value of eax (n) on the stack
    push eax

    ; Calculate fib(n-1) recursively by setting eax to n-1 and calling the function again
    dec eax             ; n-1
    call fibonacci

    ; Save the result of fib(n-1) in edx and restore eax (n)
    mov edx, [result]   ; fib(n-1)
    pop eax             ; Restore eax (n)

    ; Calculate fib(n-2) recursively by setting eax to n-2 and calling the function again
    sub eax, 2          ; n-2
    call fibonacci

    ; Add fib(n-1) and fib(n-2) to get fib(n)
    add [result], edx   ; fib(n) = fib(n-1) + fib(n-2)

    ret

fib_zero:
    ; The Fibonacci number for input 0 is 0
    mov word [result], 0
    ret

fib_one:
    ; The Fibonacci number for input 1 is 1
    mov word [result], 1
    ret

section .data
    prompt db "Enter a single-digit number: ", 0x0a ; The prompt message
    prompt_len equ $ - prompt ; Length of the prompt message