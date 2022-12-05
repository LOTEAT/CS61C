.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi sp, sp, -4
    sw t0, 0(sp)
    sw t1, 4(sp)
    mv t0, a0
    addi t1, a0, -1
loop:
    mul t0, t0, t1
    addi t1, t1, -1
    bne t1, x0, loop
    mv a0, t0
    lw t0, 0(sp)
    lw t1, 4(sp)
    addi sp, sp, 4
    jr ra