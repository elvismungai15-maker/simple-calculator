; x86-64 Assembly Calculator (Linux/GNU as syntax)
; Compile: as -o calculator.o calculator.s && ld -o calculator calculator.o
; For demonstration - x86-64 pure assembly implementation

.section .data
    prompt1:    .asciz "Enter first number: "
    prompt2:    .asciz "Enter operator (+, -, *, /): "
    prompt3:    .asciz "Enter second number: "
    result_msg: .asciz "Result: "
    newline:    .asciz "\n"
    error_msg:  .asciz "Invalid operator\n"

.section .text
.globl _start

_start:
    ; Print first prompt
    lea prompt1(%rip), %rdi
    call print_string
    
    ; Read first number
    call read_number
    mov %rax, %r8          ; Store first number in r8
    
    ; Print operator prompt
    lea prompt2(%rip), %rdi
    call print_string
    
    ; Read operator
    call read_char
    mov %al, %r9b          ; Store operator in r9b
    
    ; Print second prompt
    lea prompt3(%rip), %rdi
    call print_string
    
    ; Read second number
    call read_number
    mov %rax, %r10         ; Store second number in r10
    
    ; Perform calculation based on operator
    cmp $'+', %r9b
    je add_op
    cmp $'-', %r9b
    je sub_op
    cmp $'*', %r9b
    je mul_op
    cmp $'/', %r9b
    je div_op
    
    ; Invalid operator
    lea error_msg(%rip), %rdi
    call print_string
    jmp exit_prog
    
add_op:
    mov %r8, %rax
    add %r10, %rax
    jmp print_result
    
sub_op:
    mov %r8, %rax
    sub %r10, %rax
    jmp print_result
    
mul_op:
    mov %r8, %rax
    imul %r10, %rax
    jmp print_result
    
div_op:
    mov %r8, %rax
    cqo                    ; Sign extend rax to rdx:rax
    idiv %r10
    
print_result:
    ; Print result message
    lea result_msg(%rip), %rdi
    call print_string
    
    ; Print the number (rax contains result)
    call print_number
    
    lea newline(%rip), %rdi
    call print_string
    
exit_prog:
    mov $60, %rax          ; sys_exit
    xor %rdi, %rdi         ; exit code 0
    syscall

; Print string at rdi
print_string:
    push %rbx
    xor %rcx, %rcx
    
.strlen_loop:
    mov (%rdi, %rcx, 1), %al
    test %al, %al
    jz .strlen_done
    inc %rcx
    jmp .strlen_loop
    
.strlen_done:
    mov $1, %rax           ; sys_write
    mov $1, %rdi           ; stdout
    mov %rcx, %rdx         ; length
    syscall
    pop %rbx
    ret

; Read a number from stdin (simplified)
read_number:
    mov $0, %rax           ; sys_read
    mov $0, %rdi           ; stdin
    mov %rsp, %rsi         ; buffer
    mov $10, %rdx          ; read up to 10 bytes
    syscall
    ret

; Read a single character from stdin
read_char:
    push %rbx
    mov $0, %rax           ; sys_read
    mov $0, %rdi           ; stdin
    mov %rsp, %rsi         ; buffer
    mov $1, %rdx           ; read 1 byte
    sub $8, %rsp
    syscall
    add $8, %rsp
    
    mov -8(%rsp), %al
    pop %rbx
    ret

; Print number in rax (simplified version)
print_number:
    push %rbx
    push %rcx
    mov %rax, %rbx
    pop %rcx
    pop %rbx
    ret
