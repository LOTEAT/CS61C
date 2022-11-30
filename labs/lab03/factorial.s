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
    # MY SOLUTIONE HERE
    # non recursive
    addi t0, a0, -1
loop:
    mul a0, a0, t0
    addi t0, t0, -1
    bne t0, x0, loop
    ret


# factorial:
#     # MY SOLUTIONE HERE
#     # recursive
#     li t0, 1
#     # if n == 1 then this program should return 1
#     beq a0, t0, finish
#     addi sp, sp, -8
#     # save a0 and ra
#     sw a0, 4(sp)
#     sw ra, 0(sp)
#     # n minus 1
#     addi a0, a0, -1
#     jal ra, factorial
#     # load a0 and ra
#     lw t0, 4(sp)
#     mul a0, a0, t0
#     lw ra, 0(sp)
#     addi sp, sp, 8

# finish:
#     jr ra

    
    