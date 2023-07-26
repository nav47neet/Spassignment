section .bss
    num resb 1         ; Reserve space for the input number
    result resw 1      ; Reserve space to store the result

section .text
    global _start
    global fibonacci

_start:
    ; Display prompt to enter the number
    ; (Remaining code remains the same)

fibonacci:
    ; Check for the base cases (fib(0) = 0, fib(1) = 1)
    cmp al, 0
    jz fib_zero
    cmp al, 1
    jz fib_one

    ; Initialize the first two Fibonacci numbers
    mov cx, 0 ; Fib(0)
    mov dx, 1 ; Fib(1)

    ; Loop to calculate the Fibonacci number
    mov bx, 2 ; Start the loop from index 2
fib_loop:
    ; Calculate the next Fibonacci number (Fib(bx) = Fib(bx-1) + Fib(bx-2))
    add cx, dx

    ; Shift the previous Fibonacci numbers for the next iteration
    mov ax, dx
    mov dx, cx

    ; Increment the loop counter and check if we have reached the desired index
    inc bx
    cmp bx, eax
    jnz fib_loop

    ; Store the result in the result variable (global variable)
    mov [result], cx

    ret

fib_zero:
    ; The Fibonacci number for input 0 is 0
    mov word [result], 0
    jmp done

fib_one:
    ; The Fibonacci number for input 1 is 1
    mov word [result], 1

done:
    ret