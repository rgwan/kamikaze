.section .init
.global main

/* set stack pointer */
nop
nop
lui sp, %hi(1*1024)
addi sp, sp, %lo(1*1024)

/* call main */
jal ra, main

/* break */
ebreak
