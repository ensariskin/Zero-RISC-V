.section .tohost, "aw", @progbits
.globl tohost
.align 4
tohost: .dword 0
.globl fromhost
.align 4
fromhost: .dword 0

.section .init, "ax"
.global _start
_start:
    .cfi_startproc
    la sp, __stack_top
    add s0, sp, zero
	#bitmask with bit 13 set to 1
	li t0, 0x2000
	#load value to mstatus CSR to set mstatus.FS to 1
	#csrrs x0, mstatus, t0
    jal x1, main

    li a0, 0
    j tohost_exit # just terminate with exit code 0
    .cfi_endproc

tohost_exit:
        slli a0, a0, 1
        ori a0, a0, 1

        li t1, 0x8010 # Our debug address
        li a1, 0x90

        la t0, tohost
        sw a0, 0(t0) #Terminate spike
        sw a1, 0(t1) #Terminate RTL
        1: j 1b # wait for termination
.end
