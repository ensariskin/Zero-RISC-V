.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x13, h0_start
jalr x0, x13, 0
h0_start:
                  li x22, 0x40000100
                  csrw 0x301, x22
kernel_sp:        
                  la x18, kernel_stack_end

trap_vec_init:    
                  la x22, mtvec_handler
                  ori x22, x22, 1
                  csrw 0x305, x22 # MTVEC

mepc_setup:       
                  la x22, init
                  csrw 0x341, x22

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x22, 0x1800
                  csrw 0x300, x22 # MSTATUS
                  li x22, 0x0
                  csrw 0x304, x22 # MIE
                  mret
init:             
                  li x0, 0x80000000
                  li x1, 0x80000000
                  li x2, 0x3530a4b5
                  li x3, 0x0
                  li x4, 0x4094c27a
                  li x5, 0x0
                  li x6, 0x80000000
                  li x7, 0x7
                  li x8, 0xb8b07fe5
                  li x9, 0x0
                  li x10, 0x80000000
                  li x11, 0x80000000
                  li x12, 0x80000000
                  li x13, 0xf392b9e5
                  li x14, 0xf386aed7
                  li x15, 0xf1198f41
                  li x16, 0x80000000
                  li x17, 0x0
                  li x20, 0xfbe8d0be
                  li x21, 0x1
                  li x22, 0x160c1b1f
                  li x23, 0xfa66a054
                  li x24, 0xfd1d68b6
                  li x25, 0xdf433e3d
                  li x26, 0xfc5c73f4
                  li x27, 0xf9bec817
                  li x28, 0xfafda8b3
                  li x29, 0x5
                  li x30, 0xf79f9eb9
                  li x31, 0x8
                  la x19, user_stack_end
main:             li           s1, 0xd9162d49 #start riscv_int_numeric_corner_stream_37
                  li           s6, 0xffffffff
                  li           t2, 0xcdc2e910
                  li           gp, 0xffffffff
                  li           s11, 0x80000000
                  li           ra, 0xcaf16898
                  li           t6, 0x80000000
                  li           s4, 0x1587eef3
                  li           s10, 0xffffffff
                  li           a7, 0xffffffff
                  nop
                  addi         gp, t2, 579
                  sub          s1, s4, s4
                  add          t2, s6, t6
                  addi         gp, t2, 579
                  lui          t6, 533900
                  addi         gp, t2, 579
                  nop
                  add          t2, s6, t6
                  auipc        t2, 1017573
                  sub          s1, s4, s4
                  sub          s1, s4, s4
                  sub          s1, s4, s4
                  lui          t6, 533900
                  sub          s1, s4, s4
                  lui          t6, 533900
                  auipc        t2, 1017573
                  sub          s1, s4, s4
                  sub          s1, s4, s4
                  add          t2, s6, t6
                  auipc        t2, 1017573
                  auipc        t2, 1017573
                  add          t2, s6, t6
                  sub          s1, s4, s4 #end riscv_int_numeric_corner_stream_37
                  li           s11, 0x1e44c96e #start riscv_int_numeric_corner_stream_27
                  li           t4, 0xeea7c526
                  li           s10, 0xffffffff
                  li           t2, 0xffffffff
                  li           a0, 0x0
                  li           a4, 0xffffffff
                  li           a2, 0xffffffff
                  li           gp, 0xffffffff
                  li           tp, 0x57b703cc
                  li           sp, 0xb1648273
                  nop
                  nop
                  lui          s11, 533900
                  add          a0, t2, s11
                  lui          s11, 533900
                  add          a0, t2, s11
                  addi         gp, t2, 579
                  lui          s11, 533900
                  auipc        tp, 1017573
                  sub          t2, t4, a2
                  auipc        tp, 1017573
                  add          a0, t2, s11
                  nop
                  addi         gp, t2, 579
                  add          a0, t2, s11 #end riscv_int_numeric_corner_stream_27
                  li           t2, 0x0 #start riscv_int_numeric_corner_stream_2
                  li           a4, 0xbd2819f4
                  li           s6, 0x0
                  li           s10, 0x0
                  li           s1, 0xffffffff
                  li           s0, 0x0
                  li           a1, 0x80000000
                  li           s4, 0x80000000
                  li           a6, 0x0
                  li           a7, 0x80000000
                  addi         a1, t2, 579
                  sub          t2, a1, s4
                  addi         a1, t2, 579
                  add          t2, t2, a1
                  add          t2, t2, a1
                  auipc        a4, 1017573
                  addi         a1, t2, 579
                  sub          t2, a1, s4
                  nop
                  nop
                  addi         a1, t2, 579
                  auipc        a4, 1017573
                  nop
                  nop
                  addi         a1, t2, 579
                  addi         a1, t2, 579
                  add          t2, t2, a1
                  addi         a1, t2, 579
                  addi         a1, t2, 579
                  add          t2, t2, a1
                  add          t2, t2, a1 #end riscv_int_numeric_corner_stream_2
                  li           s10, 0xffffffff #start riscv_int_numeric_corner_stream_18
                  li           a6, 0x0
                  li           tp, 0x0
                  li           a7, 0x80000000
                  li           a0, 0xa3a6317f
                  li           s1, 0x0
                  li           s7, 0xf58b12ad
                  li           a4, 0x8e31ea84
                  li           a1, 0x0
                  li           t3, 0x80000000
                  addi         a1, s7, 579
                  add          s7, s7, a1
                  addi         a1, s7, 579
                  addi         a1, s7, 579
                  sub          a4, a1, t3
                  addi         a1, s7, 579
                  add          s7, s7, a1
                  auipc        tp, 1017573
                  add          s7, s7, a1
                  addi         a1, s7, 579
                  nop
                  auipc        tp, 1017573
                  add          s7, s7, a1
                  auipc        tp, 1017573
                  addi         a1, s7, 579
                  add          s7, s7, a1 #end riscv_int_numeric_corner_stream_18
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_12
                  li           a0, 0x0
                  li           s8, 0xaf0714f2
                  li           t4, 0x0
                  li           sp, 0xc2a9beed
                  li           ra, 0x18f474ab
                  li           a7, 0xc389962a
                  li           s9, 0xa68b19a8
                  li           s10, 0xffffffff
                  li           a4, 0x0
                  auipc        t4, 1017573
                  nop
                  sub          ra, ra, s8
                  nop
                  sub          ra, ra, s8
                  sub          ra, ra, s8
                  auipc        t4, 1017573
                  lui          t4, 533900
                  lui          t4, 533900
                  auipc        t4, 1017573
                  add          s9, sp, t5
                  addi         t5, sp, 579
                  nop
                  add          s9, sp, t5
                  addi         t5, sp, 579 #end riscv_int_numeric_corner_stream_12
                  li           s7, 0xffffffff #start riscv_int_numeric_corner_stream_33
                  li           sp, 0xffffffff
                  li           t1, 0x0
                  li           s0, 0xffffffff
                  li           a2, 0x80000000
                  li           t6, 0xffffffff
                  li           s6, 0x0
                  li           s4, 0xf915e36e
                  li           a7, 0x80000000
                  li           ra, 0x0
                  add          s4, t6, t6
                  auipc        t1, 1017573
                  addi         ra, s7, 579
                  add          s4, t6, t6
                  lui          t6, 533900
                  addi         ra, s7, 579
                  sub          t1, s7, a2
                  addi         ra, s7, 579
                  addi         ra, s7, 579
                  nop
                  addi         ra, s7, 579
                  auipc        t1, 1017573
                  sub          t1, s7, a2
                  auipc        t1, 1017573
                  addi         ra, s7, 579
                  auipc        t1, 1017573
                  add          s4, t6, t6
                  addi         ra, s7, 579
                  addi         ra, s7, 579
                  addi         ra, s7, 579
                  sub          t1, s7, a2 #end riscv_int_numeric_corner_stream_33
                  li           a7, 0xd6a2a931 #start riscv_int_numeric_corner_stream_20
                  li           t2, 0x5bea3019
                  li           sp, 0x80000000
                  li           a0, 0x0
                  li           s10, 0xe06ad732
                  li           s11, 0x80000000
                  li           a5, 0xffffffff
                  li           s0, 0x2b743fbb
                  li           s5, 0x0
                  li           s9, 0x80000000
                  add          a5, s5, s11
                  sub          s9, sp, s0
                  sub          s9, sp, s0
                  auipc        s5, 1017573
                  add          a5, s5, s11
                  lui          a5, 533900
                  add          a5, s5, s11
                  add          a5, s5, s11
                  add          a5, s5, s11
                  lui          a5, 533900
                  sub          s9, sp, s0
                  add          a5, s5, s11
                  auipc        s5, 1017573
                  add          a5, s5, s11
                  sub          s9, sp, s0 #end riscv_int_numeric_corner_stream_20
                  li           s7, 0xffffffff #start riscv_int_numeric_corner_stream_0
                  li           s11, 0x80000000
                  li           s5, 0x80000000
                  li           s10, 0x0
                  li           s4, 0x0
                  li           s9, 0xffffffff
                  li           s8, 0xffffffff
                  li           a6, 0x2748c92a
                  li           t1, 0xffffffff
                  li           t3, 0x80000000
                  lui          s7, 533900
                  nop
                  nop
                  sub          t1, s11, t3
                  add          s7, s7, s11
                  addi         s5, s7, 579
                  sub          t1, s11, t3
                  add          s7, s7, s11
                  add          s7, s7, s11
                  lui          s7, 533900
                  lui          s7, 533900
                  nop
                  auipc        t1, 1017573
                  sub          t1, s11, t3
                  sub          t1, s11, t3
                  auipc        t1, 1017573
                  auipc        t1, 1017573
                  add          s7, s7, s11
                  add          s7, s7, s11
                  auipc        t1, 1017573
                  addi         s5, s7, 579
                  nop
                  auipc        t1, 1017573
                  auipc        t1, 1017573
                  addi         s5, s7, 579 #end riscv_int_numeric_corner_stream_0
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_8
                  li           a2, 0xa37f4621
                  li           t3, 0x8a34d5c5
                  li           gp, 0x80000000
                  li           t6, 0x80000000
                  li           ra, 0x80000000
                  li           t5, 0x0
                  li           tp, 0x2b8072c5
                  li           s0, 0x80000000
                  li           a5, 0x0
                  sub          tp, t3, t3
                  auipc        tp, 1017573
                  sub          tp, t3, t3
                  auipc        tp, 1017573
                  addi         a5, tp, 579
                  lui          t6, 533900
                  auipc        tp, 1017573
                  add          a6, a2, t5
                  auipc        tp, 1017573
                  addi         a5, tp, 579
                  addi         a5, tp, 579
                  nop
                  auipc        tp, 1017573
                  sub          tp, t3, t3
                  add          a6, a2, t5
                  lui          t6, 533900
                  nop #end riscv_int_numeric_corner_stream_8
                  li           s0, 0xffffffff #start riscv_int_numeric_corner_stream_31
                  li           s7, 0xffffffff
                  li           s4, 0x0
                  li           sp, 0x80000000
                  li           t0, 0x80000000
                  li           ra, 0x80000000
                  li           t3, 0x0
                  li           s5, 0xffffffff
                  li           s8, 0x60c1fbf
                  li           a5, 0x22e16915
                  add          s4, a5, a5
                  auipc        t0, 1017573
                  nop
                  nop
                  lui          a5, 533900
                  add          s4, a5, a5
                  sub          a5, a5, t3
                  lui          a5, 533900
                  add          s4, a5, a5
                  lui          a5, 533900
                  nop
                  addi         s5, s5, 579
                  add          s4, a5, a5
                  auipc        t0, 1017573
                  sub          a5, a5, t3
                  addi         s5, s5, 579
                  nop
                  addi         s5, s5, 579
                  auipc        t0, 1017573 #end riscv_int_numeric_corner_stream_31
                  li           s9, 0x83db52e2 #start riscv_int_numeric_corner_stream_34
                  li           a7, 0xeb620e87
                  li           s7, 0x0
                  li           s6, 0x992132d3
                  li           t6, 0xf247ccc7
                  li           ra, 0x2b26bf1
                  li           tp, 0xffffffff
                  li           s8, 0xc63d813
                  li           a4, 0x80000000
                  li           t1, 0x80000000
                  sub          s7, t6, tp
                  nop
                  sub          s7, t6, tp
                  add          s7, s7, t6
                  addi         ra, s7, 579
                  addi         ra, s7, 579
                  auipc        tp, 1017573
                  add          s7, s7, t6
                  lui          t6, 533900
                  auipc        tp, 1017573
                  add          s7, s7, t6
                  auipc        tp, 1017573
                  sub          s7, t6, tp
                  add          s7, s7, t6
                  auipc        tp, 1017573
                  sub          s7, t6, tp
                  nop
                  auipc        tp, 1017573
                  addi         ra, s7, 579 #end riscv_int_numeric_corner_stream_34
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_16
                  li           s9, 0x0
                  li           gp, 0xffffffff
                  li           t1, 0x78f3984b
                  li           s5, 0x1f969fe2
                  li           a5, 0xffffffff
                  li           tp, 0x80000000
                  li           a4, 0x0
                  li           t2, 0xdfb3e1ee
                  li           t4, 0xffffffff
                  addi         gp, s5, 579
                  addi         gp, s5, 579
                  lui          t4, 533900
                  lui          t4, 533900
                  add          gp, t2, a5
                  lui          t4, 533900
                  lui          t4, 533900
                  auipc        tp, 1017573
                  nop
                  auipc        tp, 1017573
                  addi         gp, s5, 579
                  addi         gp, s5, 579
                  add          gp, t2, a5
                  lui          t4, 533900
                  lui          t4, 533900 #end riscv_int_numeric_corner_stream_16
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_11
                  li           t6, 0x0
                  li           gp, 0xffffffff
                  li           t4, 0xffffffff
                  li           t0, 0xffffffff
                  li           a1, 0x80000000
                  li           t5, 0xffffffff
                  li           t3, 0x80000000
                  li           s6, 0xafd48e5b
                  li           s4, 0xffffffff
                  sub          a5, t4, t3
                  sub          a5, t4, t3
                  sub          a5, t4, t3
                  addi         gp, t0, 579
                  lui          t4, 533900
                  lui          t4, 533900
                  addi         gp, t0, 579
                  add          a1, t3, a1
                  nop
                  add          a1, t3, a1
                  sub          a5, t4, t3
                  auipc        t0, 1017573
                  lui          t4, 533900
                  lui          t4, 533900
                  nop
                  lui          t4, 533900
                  nop
                  nop
                  addi         gp, t0, 579
                  sub          a5, t4, t3
                  lui          t4, 533900
                  sub          a5, t4, t3
                  lui          t4, 533900
                  lui          t4, 533900
                  sub          a5, t4, t3
                  sub          a5, t4, t3
                  nop
                  auipc        t0, 1017573
                  auipc        t0, 1017573
                  auipc        t0, 1017573 #end riscv_int_numeric_corner_stream_11
                  li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_35
                  li           s10, 0xffffffff
                  li           s6, 0x0
                  li           gp, 0x80000000
                  li           s11, 0x95040528
                  li           s7, 0x80000000
                  li           sp, 0xf817d9c8
                  li           a2, 0x80000000
                  li           a7, 0xffffffff
                  li           s5, 0x80000000
                  add          sp, s7, s11
                  auipc        a2, 1017573
                  lui          s11, 533900
                  addi         gp, s7, 579
                  nop
                  addi         gp, s7, 579
                  addi         gp, s7, 579
                  nop
                  addi         gp, s7, 579
                  addi         gp, s7, 579
                  lui          s11, 533900
                  lui          s11, 533900
                  addi         gp, s7, 579
                  addi         gp, s7, 579
                  add          sp, s7, s11
                  lui          s11, 533900
                  sub          a2, s11, a2
                  add          sp, s7, s11
                  auipc        a2, 1017573
                  sub          a2, s11, a2
                  sub          a2, s11, a2
                  auipc        a2, 1017573
                  nop
                  lui          s11, 533900 #end riscv_int_numeric_corner_stream_35
                  li           s10, 0xffffffff #start riscv_int_numeric_corner_stream_30
                  li           a0, 0xffffffff
                  li           t6, 0xffffffff
                  li           s4, 0x0
                  li           s7, 0x80000000
                  li           s11, 0x530e8c4b
                  li           a4, 0x0
                  li           a6, 0x80000000
                  li           s1, 0x80000000
                  li           ra, 0x80000000
                  add          s7, s4, s11
                  addi         s1, s7, 579
                  add          s7, s4, s11
                  sub          s7, t6, s4
                  sub          s7, t6, s4
                  sub          s7, t6, s4
                  sub          s7, t6, s4
                  lui          t6, 533900
                  sub          s7, t6, s4
                  auipc        a4, 1017573
                  auipc        a4, 1017573
                  sub          s7, t6, s4
                  add          s7, s4, s11
                  nop
                  addi         s1, s7, 579
                  nop #end riscv_int_numeric_corner_stream_30
                  li           s5, 0x0 #start riscv_int_numeric_corner_stream_9
                  li           s8, 0x80341f12
                  li           a2, 0x80000000
                  li           t1, 0x0
                  li           s7, 0xe70b83f5
                  li           t4, 0xffffffff
                  li           s10, 0x0
                  li           a6, 0x92c10ee
                  li           s1, 0x3c5a42ae
                  li           s0, 0x80000000
                  auipc        t1, 1017573
                  lui          t4, 533900
                  sub          s7, t4, a2
                  add          t1, s10, s10
                  lui          t4, 533900
                  add          t1, s10, s10
                  lui          t4, 533900
                  add          t1, s10, s10
                  addi         s1, s7, 579
                  nop
                  addi         s1, s7, 579
                  auipc        t1, 1017573
                  sub          s7, t4, a2
                  add          t1, s10, s10
                  lui          t4, 533900
                  auipc        t1, 1017573
                  nop
                  add          t1, s10, s10
                  sub          s7, t4, a2
                  addi         s1, s7, 579
                  add          t1, s10, s10
                  add          t1, s10, s10
                  add          t1, s10, s10 #end riscv_int_numeric_corner_stream_9
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_10
                  li           a4, 0x334f1b2a
                  li           t5, 0x80000000
                  li           t2, 0x0
                  li           s9, 0x94bf4832
                  li           t4, 0x80000000
                  li           t6, 0x80000000
                  li           s8, 0x80000000
                  li           a5, 0xf62d35c
                  li           t1, 0x80000000
                  auipc        t1, 1017573
                  lui          t4, 533900
                  addi         a5, t2, 579
                  addi         a5, t2, 579
                  addi         a5, t2, 579
                  addi         a5, t2, 579
                  lui          t4, 533900
                  addi         a5, t2, 579
                  nop
                  auipc        t1, 1017573
                  auipc        t1, 1017573
                  nop
                  auipc        t1, 1017573
                  sub          t4, t1, s8
                  sub          t4, t1, s8 #end riscv_int_numeric_corner_stream_10
                  li           s11, 0xffffffff #start riscv_int_numeric_corner_stream_4
                  li           s4, 0xffffffff
                  li           a6, 0x0
                  li           s1, 0xffffffff
                  li           tp, 0x0
                  li           t3, 0x80121065
                  li           a2, 0x80000000
                  li           s9, 0xffffffff
                  li           t4, 0xa2faebbf
                  li           s0, 0x0
                  addi         s1, s4, 579
                  nop
                  lui          s11, 533900
                  lui          s11, 533900
                  add          a2, s1, s11
                  nop
                  auipc        tp, 1017573
                  addi         s1, s4, 579
                  nop
                  addi         s1, s4, 579
                  auipc        tp, 1017573
                  sub          s0, s11, s4
                  add          a2, s1, s11
                  sub          s0, s11, s4
                  lui          s11, 533900 #end riscv_int_numeric_corner_stream_4
                  li           t2, 0x0 #start riscv_int_numeric_corner_stream_26
                  li           sp, 0x80000000
                  li           s6, 0x0
                  li           s10, 0xffffffff
                  li           t6, 0x80000000
                  li           t3, 0x0
                  li           a6, 0x2cbc6e52
                  li           t4, 0x80000000
                  li           s8, 0x0
                  li           s0, 0x0
                  sub          t2, t6, t3
                  addi         t4, s6, 579
                  addi         t4, s6, 579
                  lui          t6, 533900
                  sub          t2, t6, t3
                  add          t2, s6, t6
                  addi         t4, s6, 579
                  nop
                  addi         t4, s6, 579
                  auipc        t2, 1017573
                  add          t2, s6, t6
                  nop
                  addi         t4, s6, 579
                  addi         t4, s6, 579
                  auipc        t2, 1017573
                  add          t2, s6, t6
                  nop
                  nop
                  addi         t4, s6, 579
                  sub          t2, t6, t3
                  addi         t4, s6, 579
                  add          t2, s6, t6 #end riscv_int_numeric_corner_stream_26
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_15
                  li           t6, 0x0
                  li           t5, 0x1435c7ee
                  li           a5, 0xffffffff
                  li           t0, 0x80000000
                  li           s0, 0x0
                  li           s6, 0xffffffff
                  li           s10, 0x80000000
                  li           t4, 0xffffffff
                  li           a7, 0xffffffff
                  auipc        t0, 1017573
                  addi         a7, t0, 579
                  lui          a5, 533900
                  add          s0, a2, a5
                  nop
                  nop
                  lui          a5, 533900
                  add          s0, a2, a5
                  addi         a7, t0, 579
                  auipc        t0, 1017573
                  auipc        t0, 1017573
                  addi         a7, t0, 579
                  lui          a5, 533900
                  lui          a5, 533900
                  lui          a5, 533900 #end riscv_int_numeric_corner_stream_15
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  lui          t4, 533900
                  lui          t4, 533900
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  nop
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  nop
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  nop
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  lui          t4, 533900
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  nop
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  nop
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  lui          t4, 533900
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  nop
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  nop
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  nop
                  add          s6, t3, a1
                  add          s6, t3, a1
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  nop
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  nop
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  nop
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  or           t5, s0, ra
                  lui          t4, 533900
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  lui          t4, 533900
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  nop
                  lui          t4, 533900
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  nop
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  lui          t4, 533900
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  nop
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  nop
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  nop
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  nop
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  lui          t4, 533900
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  nop
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  nop
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  nop
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  lui          t4, 533900
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  nop
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  slt          s1, tp, t6
                  nop
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  lui          t4, 533900
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  nop
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  nop
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  nop
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  nop
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  lui          t4, 533900
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  lui          t4, 533900
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  nop
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  nop
                  nop
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  nop
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  lui          t4, 533900
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  nop
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  nop
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  lui          t4, 533900
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  nop
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  lui          t4, 533900
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  nop
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  nop
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  nop
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  nop
                  add          s6, t3, a1
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  lui          t4, 533900
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  nop
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  nop
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  and          a6, gp, s6
                  lui          t4, 533900
                  nop
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  nop
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  lui          t4, 533900
                  lui          t4, 533900
                  srai         a7, s9, 9
                  lui          t4, 533900
                  add          s6, t3, a1
                  lui          t4, 533900
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  lui          t4, 533900
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  nop
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  nop
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  nop
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  lui          t4, 533900
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  lui          t4, 533900
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  nop
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  lui          t4, 533900
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  lui          t4, 533900
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  nop
                  lui          t4, 533900
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  lui          t4, 533900
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  nop
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  nop
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  or           t5, s0, ra
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  nop
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  nop
                  nop
                  nop
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  nop
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  nop
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  lui          t4, 533900
                  or           t5, s0, ra
                  nop
                  lui          t4, 533900
                  sra          a6, gp, s7
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  lui          t4, 533900
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  lui          t4, 533900
                  lui          t4, 533900
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  lui          t4, 533900
                  add          s6, t3, a1
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  nop
                  sub          s11, t3, t3
                  nop
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  lui          t4, 533900
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  nop
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  lui          t4, 533900
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  nop
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  nop
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  nop
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  nop
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  lui          t4, 533900
                  nop
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  nop
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  lui          t4, 533900
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  nop
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  nop
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  nop
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  lui          t4, 533900
                  add          s6, t3, a1
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  and          a6, gp, s6
                  lui          t4, 533900
                  nop
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  lui          t4, 533900
                  or           t5, s0, ra
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  nop
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  lui          t4, 533900
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  nop
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  lui          t4, 533900
                  lui          t4, 533900
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  nop
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  lui          t4, 533900
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  nop
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  nop
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  nop
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  nop
                  and          a6, gp, s6
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  nop
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  nop
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  lui          t4, 533900
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  nop
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  nop
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  lui          t4, 533900
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  lui          t4, 533900
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  nop
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  lui          t4, 533900
                  nop
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  nop
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  nop
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  lui          t4, 533900
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  nop
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  and          a6, gp, s6
                  nop
                  nop
                  lui          t4, 533900
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  nop
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  nop
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  lui          t4, 533900
                  or           t5, s0, ra
                  nop
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  nop
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  nop
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  nop
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  nop
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  lui          t4, 533900
                  or           t5, s0, ra
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  nop
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  nop
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  li           a7, 0xffffffff #start riscv_int_numeric_corner_stream_29
                  li           a1, 0x33685aa7
                  li           t3, 0x0
                  li           t2, 0xffffffff
                  li           gp, 0x13fc61f
                  li           s9, 0x13d5eba6
                  li           s7, 0x0
                  li           t6, 0x80000000
                  li           a5, 0x14ebc11
                  li           a2, 0x0
                  sub          t3, a7, a2
                  lui          a5, 533900
                  add          s7, s7, t6
                  auipc        a2, 1017573
                  sub          t3, a7, a2
                  auipc        a2, 1017573
                  auipc        a2, 1017573
                  nop
                  lui          a5, 533900
                  add          s7, s7, t6
                  add          s7, s7, t6
                  add          s7, s7, t6
                  auipc        a2, 1017573
                  auipc        a2, 1017573
                  addi         gp, s7, 579
                  sub          t3, a7, a2
                  auipc        a2, 1017573
                  sub          t3, a7, a2
                  add          s7, s7, t6
                  nop
                  nop
                  add          s7, s7, t6
                  nop
                  lui          a5, 533900 #end riscv_int_numeric_corner_stream_29
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  nop
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  nop
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  nop
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  lui          t4, 533900
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  nop
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  nop
                  or           t5, s0, ra
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  lui          t4, 533900
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  lui          t4, 533900
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  nop
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  lui          t4, 533900
                  nop
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  lui          t4, 533900
                  add          s6, t3, a1
                  lui          t4, 533900
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  lui          t4, 533900
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  lui          t4, 533900
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  nop
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  or           t5, s0, ra
                  li           t0, 0x0 #start riscv_int_numeric_corner_stream_23
                  li           a6, 0xed956f28
                  li           a0, 0xffffffff
                  li           a7, 0x2175f05f
                  li           s6, 0xf6ee04af
                  li           a2, 0xffffffff
                  li           s1, 0x0
                  li           sp, 0xffffffff
                  li           tp, 0x0
                  li           s5, 0x80000000
                  sub          t0, s6, a2
                  addi         t0, s5, 579
                  add          a2, s1, s6
                  add          a2, s1, s6
                  sub          t0, s6, a2
                  add          a2, s1, s6
                  auipc        tp, 1017573
                  add          a2, s1, s6
                  addi         t0, s5, 579
                  lui          s1, 533900
                  sub          t0, s6, a2
                  sub          t0, s6, a2
                  addi         t0, s5, 579
                  addi         t0, s5, 579
                  add          a2, s1, s6 #end riscv_int_numeric_corner_stream_23
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  nop
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  lui          t4, 533900
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  lui          t4, 533900
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  nop
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  nop
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  add          s6, t3, a1
                  and          a6, gp, s6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  nop
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  lui          t4, 533900
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  nop
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  lui          t4, 533900
                  slt          s1, tp, t6
                  lui          t4, 533900
                  lui          t4, 533900
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  nop
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  and          a6, gp, s6
                  nop
                  lui          t4, 533900
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  lui          t4, 533900
                  auipc        tp, 1017573
                  lui          t4, 533900
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  nop
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  nop
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  nop
                  nop
                  srli         t4, t3, 14
                  lui          t4, 533900
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  nop
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  lui          t4, 533900
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  nop
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  nop
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  nop
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_6
                  li           t1, 0x80000000
                  li           gp, 0x80000000
                  li           s11, 0x80000000
                  li           t3, 0x8f2129cf
                  li           a2, 0x0
                  li           a1, 0x0
                  li           s9, 0xd13db41f
                  li           tp, 0x0
                  li           s10, 0x80000000
                  nop
                  nop
                  addi         s1, t1, 579
                  sub          t1, s9, t3
                  lui          a1, 533900
                  lui          a1, 533900
                  lui          a1, 533900
                  nop
                  addi         s1, t1, 579
                  lui          a1, 533900
                  add          gp, tp, s10
                  sub          t1, s9, t3
                  lui          a1, 533900
                  nop
                  addi         s1, t1, 579 #end riscv_int_numeric_corner_stream_6
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  lui          t4, 533900
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  nop
                  lui          t4, 533900
                  nop
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  lui          t4, 533900
                  slli         a4, s2, 6
                  nop
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  nop
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  nop
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  lui          t4, 533900
                  nop
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  or           t5, s0, ra
                  lui          t4, 533900
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  lui          t4, 533900
                  nop
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  nop
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  nop
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  nop
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  nop
                  nop
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  nop
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  nop
                  xori         s8, a3, 1278
                  nop
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  lui          t4, 533900
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  nop
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  add          s6, t3, a1
                  and          a6, gp, s6
                  nop
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  nop
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  nop
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  nop
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  lui          t4, 533900
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  lui          t4, 533900
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  nop
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  nop
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  nop
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  nop
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  lui          t4, 533900
                  slli         a4, s2, 6
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  nop
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  lui          t4, 533900
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  lui          t4, 533900
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  nop
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  nop
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  nop
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  nop
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  nop
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  nop
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  nop
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  lui          t4, 533900
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  nop
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  or           t5, s0, ra
                  add          s6, t3, a1
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  lui          t4, 533900
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  lui          t4, 533900
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  lui          t4, 533900
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  nop
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  nop
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  lui          t4, 533900
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  nop
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  nop
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  lui          t4, 533900
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  nop
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  nop
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  nop
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  nop
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  nop
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  lui          t4, 533900
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  nop
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  add          s6, t3, a1
                  or           t5, s0, ra
                  add          s6, t3, a1
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  nop
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  nop
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  lui          t4, 533900
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  nop
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  lui          t4, 533900
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  lui          t4, 533900
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  nop
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  nop
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  and          a6, gp, s6
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  lui          t4, 533900
                  auipc        tp, 1017573
                  lui          t4, 533900
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  lui          t4, 533900
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  lui          t4, 533900
                  lui          t4, 533900
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  nop
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  nop
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  nop
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  nop
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  nop
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  lui          t4, 533900
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  nop
                  or           t5, s0, ra
                  and          a6, gp, s6
                  lui          t4, 533900
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  lui          t4, 533900
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  add          s6, t3, a1
                  lui          t4, 533900
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  lui          t4, 533900
                  slti         t5, s10, -598
                  nop
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  or           t5, s0, ra
                  or           t5, s0, ra
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  or           t5, s0, ra
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  lui          t4, 533900
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  lui          t4, 533900
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  nop
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  nop
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  nop
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  nop
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  nop
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  lui          t4, 533900
                  sub          s11, t3, t3
                  lui          t4, 533900
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  lui          t4, 533900
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  lui          t4, 533900
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  lui          t4, 533900
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  nop
                  ori          s1, zero, -637
                  nop
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  nop
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  lui          t4, 533900
                  slt          s1, tp, t6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  lui          t4, 533900
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  nop
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  lui          t4, 533900
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  li           a2, 0x0 #start riscv_int_numeric_corner_stream_38
                  li           gp, 0x1fd2c7e7
                  li           t1, 0xffffffff
                  li           s10, 0x4ba8d8f2
                  li           ra, 0xffffffff
                  li           s11, 0xb4e31145
                  li           s0, 0x8caa14d6
                  li           s9, 0xffffffff
                  li           a7, 0x80000000
                  li           t2, 0x0
                  sub          gp, s11, a2
                  lui          s11, 533900
                  addi         gp, t2, 579
                  add          gp, t2, s11
                  nop
                  addi         gp, t2, 579
                  auipc        a2, 1017573
                  addi         gp, t2, 579
                  addi         gp, t2, 579
                  lui          s11, 533900
                  auipc        a2, 1017573
                  auipc        a2, 1017573
                  addi         gp, t2, 579
                  nop
                  add          gp, t2, s11 #end riscv_int_numeric_corner_stream_38
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  nop
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  add          s6, t3, a1
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  lui          t4, 533900
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  nop
                  nop
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  nop
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  add          s6, t3, a1
                  lui          t4, 533900
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  nop
                  slli         a4, s2, 6
                  lui          t4, 533900
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  lui          t4, 533900
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  nop
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  lui          t4, 533900
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  nop
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  lui          t4, 533900
                  nop
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  nop
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  nop
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  lui          t4, 533900
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  lui          t4, 533900
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  lui          t4, 533900
                  ori          s1, zero, -637
                  nop
                  nop
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  nop
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  nop
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  nop
                  slli         a4, s2, 6
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  nop
                  nop
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  nop
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  lui          t4, 533900
                  nop
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  nop
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  lui          t4, 533900
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  lui          t4, 533900
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  nop
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  lui          t4, 533900
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  nop
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  nop
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  li           s6, 0x985895b5 #start riscv_int_numeric_corner_stream_22
                  li           t5, 0x0
                  li           s10, 0x80000000
                  li           s0, 0x6b655b87
                  li           s4, 0xa373b2f8
                  li           gp, 0x0
                  li           a6, 0x80000000
                  li           t2, 0xa6c03187
                  li           a4, 0xffffffff
                  li           s8, 0x0
                  lui          t2, 533900
                  nop
                  add          s10, s4, s10
                  nop
                  add          s10, s4, s10
                  lui          t2, 533900
                  nop
                  auipc        a4, 1017573
                  addi         gp, t2, 579
                  add          s10, s4, s10
                  add          s10, s4, s10
                  nop
                  add          s10, s4, s10
                  sub          a4, s10, s4
                  lui          t2, 533900
                  add          s10, s4, s10
                  auipc        a4, 1017573
                  nop
                  auipc        a4, 1017573
                  sub          a4, s10, s4
                  lui          t2, 533900
                  sub          a4, s10, s4
                  lui          t2, 533900 #end riscv_int_numeric_corner_stream_22
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  nop
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  lui          t4, 533900
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  nop
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  nop
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  nop
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  lui          t4, 533900
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  li           a4, 0xffffffff #start riscv_int_numeric_corner_stream_36
                  li           t1, 0xa14397b1
                  li           tp, 0xffffffff
                  li           gp, 0x86642898
                  li           t3, 0xffffffff
                  li           a2, 0x0
                  li           a7, 0x51de391d
                  li           a6, 0xb01e0a7b
                  li           t5, 0xffffffff
                  li           sp, 0xc7746fdd
                  nop
                  addi         gp, t1, 579
                  sub          tp, t3, t3
                  addi         gp, t1, 579
                  sub          tp, t3, t3
                  addi         gp, t1, 579
                  lui          gp, 533900
                  nop
                  add          a4, gp, t5
                  addi         gp, t1, 579
                  addi         gp, t1, 579
                  addi         gp, t1, 579
                  nop
                  addi         gp, t1, 579
                  add          a4, gp, t5
                  lui          gp, 533900
                  nop #end riscv_int_numeric_corner_stream_36
                  lui          t4, 533900
                  nop
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  li           s6, 0xffffffff #start riscv_int_numeric_corner_stream_28
                  li           a7, 0x0
                  li           ra, 0x80000000
                  li           a0, 0xffffffff
                  li           s0, 0x477199e7
                  li           s1, 0xffffffff
                  li           t2, 0xffffffff
                  li           s9, 0xffffffff
                  li           t0, 0x0
                  li           s5, 0xffffffff
                  nop
                  auipc        t0, 1017573
                  addi         a7, s5, 579
                  nop
                  sub          s9, s6, s0
                  addi         a7, s5, 579
                  nop
                  sub          s9, s6, s0
                  add          s5, s9, a0
                  auipc        t0, 1017573
                  lui          s9, 533900
                  lui          s9, 533900
                  lui          s9, 533900
                  nop
                  addi         a7, s5, 579
                  nop
                  lui          s9, 533900
                  sub          s9, s6, s0 #end riscv_int_numeric_corner_stream_28
                  srl          t5, s11, s6
                  nop
                  nop
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  nop
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  nop
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  nop
                  or           t5, s0, ra
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  nop
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  lui          t4, 533900
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  lui          t4, 533900
                  lui          t4, 533900
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  nop
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  lui          t4, 533900
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_5
                  li           s6, 0x80000000
                  li           t5, 0x887f2064
                  li           s0, 0xa8274860
                  li           s9, 0xffffffff
                  li           a0, 0x93b5f57b
                  li           ra, 0xffffffff
                  li           s10, 0xe3b098b6
                  li           sp, 0x0
                  li           a6, 0x5abe0f40
                  addi         s6, s6, 579
                  lui          gp, 533900
                  addi         s6, s6, 579
                  lui          gp, 533900
                  auipc        s6, 1017573
                  addi         s6, s6, 579
                  nop
                  add          s6, s6, a0
                  add          s6, s6, a0
                  auipc        s6, 1017573
                  lui          gp, 533900
                  auipc        s6, 1017573
                  sub          ra, s9, a6
                  addi         s6, s6, 579
                  addi         s6, s6, 579 #end riscv_int_numeric_corner_stream_5
                  sll          a7, s4, s3
                  lui          t4, 533900
                  lui          t4, 533900
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  nop
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  and          a6, gp, s6
                  or           t5, s0, ra
                  nop
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  nop
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  nop
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  lui          t4, 533900
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sub          s11, t3, t3
                  lui          t4, 533900
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  lui          t4, 533900
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  lui          t4, 533900
                  lui          t4, 533900
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  nop
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  or           t5, s0, ra
                  nop
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  nop
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  nop
                  add          s6, t3, a1
                  nop
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  nop
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  nop
                  auipc        tp, 1017573
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  nop
                  nop
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  nop
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  nop
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  nop
                  auipc        tp, 1017573
                  nop
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  nop
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  nop
                  slti         t5, s10, -598
                  lui          t4, 533900
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  lui          t4, 533900
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  nop
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  nop
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  nop
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  lui          t4, 533900
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  lui          t4, 533900
                  srai         a7, s9, 9
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_39
                  li           s5, 0x80000000
                  li           ra, 0x6a7affb3
                  li           s11, 0x30d8e10f
                  li           t2, 0x0
                  li           gp, 0x80000000
                  li           s8, 0x80000000
                  li           t0, 0x0
                  li           t6, 0x80000000
                  li           tp, 0x0
                  addi         gp, s5, 579
                  add          s5, t2, t6
                  sub          s8, tp, tp
                  auipc        tp, 1017573
                  lui          a5, 533900
                  lui          a5, 533900
                  add          s5, t2, t6
                  addi         gp, s5, 579
                  auipc        tp, 1017573
                  addi         gp, s5, 579
                  sub          s8, tp, tp
                  lui          a5, 533900
                  addi         gp, s5, 579
                  sub          s8, tp, tp
                  sub          s8, tp, tp
                  auipc        tp, 1017573
                  sub          s8, tp, tp
                  auipc        tp, 1017573
                  nop
                  sub          s8, tp, tp
                  add          s5, t2, t6
                  addi         gp, s5, 579
                  nop
                  sub          s8, tp, tp
                  nop
                  sub          s8, tp, tp #end riscv_int_numeric_corner_stream_39
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  lui          t4, 533900
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  nop
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  nop
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  lui          t4, 533900
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  nop
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  lui          t4, 533900
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  lui          t4, 533900
                  slti         t5, s10, -598
                  lui          t4, 533900
                  nop
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  nop
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  nop
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  lui          t4, 533900
                  nop
                  lui          t4, 533900
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  nop
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  nop
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  nop
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  nop
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  nop
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  lui          t4, 533900
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  lui          t4, 533900
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  nop
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  nop
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_1
                  li           s9, 0x0
                  li           s1, 0x80000000
                  li           gp, 0x80000000
                  li           s0, 0x37f042c9
                  li           a6, 0x80000000
                  li           s8, 0xffffffff
                  li           s11, 0xd6b4bbe8
                  li           ra, 0xffffffff
                  li           a5, 0xffffffff
                  lui          a5, 533900
                  auipc        a5, 1017573
                  lui          a5, 533900
                  add          a5, gp, t6
                  add          a5, gp, t6
                  lui          a5, 533900
                  auipc        a5, 1017573
                  lui          a5, 533900
                  add          a5, gp, t6
                  nop
                  sub          ra, a6, a6
                  lui          a5, 533900
                  nop
                  addi         a5, gp, 579
                  auipc        a5, 1017573
                  addi         a5, gp, 579
                  add          a5, gp, t6 #end riscv_int_numeric_corner_stream_1
                  lui          t4, 533900
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  li           t6, 0x97494288 #start riscv_int_numeric_corner_stream_17
                  li           s0, 0xbdca8845
                  li           t4, 0x0
                  li           t5, 0x5e2ffc97
                  li           s9, 0x0
                  li           s10, 0xffffffff
                  li           t0, 0x906963ca
                  li           s11, 0x4b9c682d
                  li           s6, 0xffffffff
                  li           s8, 0xffffffff
                  lui          s11, 533900
                  lui          s11, 533900
                  add          s0, t0, t5
                  addi         t0, s6, 579
                  sub          s6, t4, s8
                  add          s0, t0, t5
                  nop
                  add          s0, t0, t5
                  addi         t0, s6, 579
                  auipc        t0, 1017573
                  auipc        t0, 1017573
                  add          s0, t0, t5
                  sub          s6, t4, s8
                  auipc        t0, 1017573
                  lui          s11, 533900
                  auipc        t0, 1017573
                  auipc        t0, 1017573
                  add          s0, t0, t5
                  nop #end riscv_int_numeric_corner_stream_17
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  nop
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  nop
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  nop
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  nop
                  lui          t4, 533900
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  nop
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  lui          t4, 533900
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  nop
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  nop
                  lui          t4, 533900
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  nop
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  li           a6, 0x0 #start riscv_int_numeric_corner_stream_14
                  li           a5, 0x0
                  li           t5, 0x80000000
                  li           t6, 0xffffffff
                  li           s5, 0x0
                  li           ra, 0xffffffff
                  li           a2, 0xffffffff
                  li           a4, 0xffffffff
                  li           s1, 0x80000000
                  li           s8, 0x0
                  auipc        a2, 1017573
                  addi         ra, s5, 579
                  add          s5, s5, t6
                  lui          a5, 533900
                  addi         ra, s5, 579
                  addi         ra, s5, 579
                  sub          a4, t6, a2
                  auipc        a2, 1017573
                  auipc        a2, 1017573
                  addi         ra, s5, 579
                  sub          a4, t6, a2
                  lui          a5, 533900
                  addi         ra, s5, 579
                  auipc        a2, 1017573
                  addi         ra, s5, 579
                  auipc        a2, 1017573
                  nop
                  auipc        a2, 1017573
                  nop
                  sub          a4, t6, a2
                  nop
                  addi         ra, s5, 579
                  lui          a5, 533900 #end riscv_int_numeric_corner_stream_14
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  nop
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  nop
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  nop
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  nop
                  and          a6, gp, s6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  nop
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  lui          t4, 533900
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  lui          t4, 533900
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  nop
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  nop
                  auipc        tp, 1017573
                  lui          t4, 533900
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  lui          t4, 533900
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  lui          t4, 533900
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  nop
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  lui          t4, 533900
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  nop
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  lui          t4, 533900
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  nop
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  nop
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  lui          t4, 533900
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  lui          t4, 533900
                  nop
                  srl          t5, s11, s6
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  nop
                  li           s4, 0x1528cbf #start riscv_int_numeric_corner_stream_13
                  li           a0, 0x0
                  li           t5, 0xffffffff
                  li           t0, 0xaad6c7ad
                  li           a4, 0x80000000
                  li           a2, 0x80000000
                  li           s9, 0xffffffff
                  li           tp, 0xffffffff
                  li           a7, 0x0
                  li           t4, 0xffffffff
                  add          s9, t5, t5
                  add          s9, t5, t5
                  sub          a4, a4, a2
                  lui          t4, 533900
                  add          s9, t5, t5
                  nop
                  lui          t4, 533900
                  nop
                  lui          t4, 533900
                  lui          t4, 533900
                  lui          t4, 533900
                  sub          a4, a4, a2
                  nop
                  sub          a4, a4, a2
                  auipc        tp, 1017573
                  lui          t4, 533900
                  auipc        tp, 1017573
                  add          s9, t5, t5 #end riscv_int_numeric_corner_stream_13
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  lui          t4, 533900
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  nop
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  lui          t4, 533900
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  nop
                  or           t5, s0, ra
                  nop
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  nop
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  and          a6, gp, s6
                  add          s6, t3, a1
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  lui          t4, 533900
                  nop
                  lui          t4, 533900
                  li           sp, 0xd18bd60f #start riscv_int_numeric_corner_stream_24
                  li           t5, 0x0
                  li           t6, 0xffffffff
                  li           s11, 0xffffffff
                  li           s6, 0x7388682d
                  li           t1, 0x0
                  li           a1, 0x0
                  li           a5, 0x0
                  li           gp, 0xffffffff
                  li           s4, 0x0
                  nop
                  addi         gp, s6, 579
                  nop
                  lui          a5, 533900
                  add          s11, s4, a1
                  auipc        t1, 1017573
                  addi         gp, s6, 579
                  lui          a5, 533900
                  lui          a5, 533900
                  addi         gp, s6, 579
                  auipc        t1, 1017573
                  lui          a5, 533900
                  add          s11, s4, a1
                  addi         gp, s6, 579
                  auipc        t1, 1017573
                  add          s11, s4, a1
                  nop
                  addi         gp, s6, 579 #end riscv_int_numeric_corner_stream_24
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  lui          t4, 533900
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  lui          t4, 533900
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  lui          t4, 533900
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  lui          t4, 533900
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  lui          t4, 533900
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  lui          t4, 533900
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  nop
                  or           t5, s0, ra
                  lui          t4, 533900
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  nop
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  nop
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  nop
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  nop
                  sll          a7, s4, s3
                  lui          t4, 533900
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  lui          t4, 533900
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  lui          t4, 533900
                  lui          t4, 533900
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  lui          t4, 533900
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  nop
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  add          s6, t3, a1
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  lui          t4, 533900
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  lui          t4, 533900
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  add          s6, t3, a1
                  lui          t4, 533900
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  lui          t4, 533900
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  add          s6, t3, a1
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  nop
                  sub          s11, t3, t3
                  nop
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  nop
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  nop
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  nop
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  nop
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  nop
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  nop
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  lui          t4, 533900
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  lui          t4, 533900
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  nop
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  or           t5, s0, ra
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  nop
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  nop
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  nop
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  lui          t4, 533900
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  nop
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  lui          t4, 533900
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  nop
                  nop
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  or           t5, s0, ra
                  or           t5, s0, ra
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  lui          t4, 533900
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  lui          t4, 533900
                  slt          s1, tp, t6
                  nop
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  lui          t4, 533900
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  nop
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  lui          t4, 533900
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  lui          t4, 533900
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  lui          t4, 533900
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  lui          t4, 533900
                  nop
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  nop
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  lui          t4, 533900
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  nop
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  lui          t4, 533900
                  or           t5, s0, ra
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  nop
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  lui          t4, 533900
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  nop
                  xor          s9, tp, s10
                  nop
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  lui          t4, 533900
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  nop
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  nop
                  nop
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  nop
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  li           a0, 0xffffffff #start riscv_int_numeric_corner_stream_25
                  li           s1, 0x80000000
                  li           sp, 0x0
                  li           a6, 0x80000000
                  li           t2, 0x24914c8b
                  li           s8, 0xffffffff
                  li           a5, 0xe576499a
                  li           a7, 0x7a4433e0
                  li           ra, 0x0
                  li           s10, 0x80000000
                  nop
                  auipc        t2, 1017573
                  add          t2, t2, a5
                  lui          a5, 533900
                  addi         t2, t2, 579
                  lui          a5, 533900
                  sub          t2, a5, s8
                  add          t2, t2, a5
                  addi         t2, t2, 579
                  addi         t2, t2, 579
                  addi         t2, t2, 579
                  lui          a5, 533900
                  lui          a5, 533900
                  auipc        t2, 1017573
                  auipc        t2, 1017573
                  sub          t2, a5, s8 #end riscv_int_numeric_corner_stream_25
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  nop
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  nop
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  nop
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  lui          t4, 533900
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  nop
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  nop
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  nop
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  lui          t4, 533900
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  nop
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  nop
                  auipc        tp, 1017573
                  nop
                  add          s6, t3, a1
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  nop
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  lui          t4, 533900
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  nop
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  nop
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  lui          t4, 533900
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  lui          t4, 533900
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  nop
                  nop
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  or           t5, s0, ra
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  lui          t4, 533900
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  nop
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  lui          t4, 533900
                  sub          s11, t3, t3
                  nop
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  nop
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  add          s6, t3, a1
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  nop
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  nop
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  nop
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  lui          t4, 533900
                  add          s6, t3, a1
                  nop
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  nop
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  nop
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  nop
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  nop
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  nop
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  lui          t4, 533900
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  nop
                  lui          t4, 533900
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  nop
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  nop
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  nop
                  nop
                  nop
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  lui          t4, 533900
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  lui          t4, 533900
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  nop
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  nop
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  nop
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  lui          t4, 533900
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  lui          t4, 533900
                  srli         t4, t3, 14
                  lui          t4, 533900
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  lui          t4, 533900
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  lui          t4, 533900
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  add          s6, t3, a1
                  add          s6, t3, a1
                  add          s6, t3, a1
                  nop
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  and          a6, gp, s6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  lui          t4, 533900
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  nop
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  nop
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  lui          t4, 533900
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  li           tp, 0xbc771df0 #start riscv_int_numeric_corner_stream_32
                  li           a2, 0x900b2ed9
                  li           a4, 0x80000000
                  li           s1, 0xeb62da5e
                  li           t5, 0xffffffff
                  li           s11, 0x80000000
                  li           s9, 0x80000000
                  li           s7, 0xffffffff
                  li           s10, 0x80000000
                  li           s6, 0x90814ff4
                  add          s7, s7, s11
                  auipc        tp, 1017573
                  nop
                  add          s7, s7, s11
                  addi         s1, s7, 579
                  add          s7, s7, s11
                  nop
                  sub          a4, s9, a2
                  sub          a4, s9, a2
                  add          s7, s7, s11
                  nop
                  lui          s11, 533900
                  lui          s11, 533900
                  add          s7, s7, s11
                  sub          a4, s9, a2
                  nop
                  lui          s11, 533900
                  nop
                  add          s7, s7, s11
                  lui          s11, 533900
                  addi         s1, s7, 579 #end riscv_int_numeric_corner_stream_32
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  lui          t4, 533900
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  lui          t4, 533900
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  lui          t4, 533900
                  xor          s9, tp, s10
                  lui          t4, 533900
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  nop
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  nop
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  lui          t4, 533900
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  nop
                  andi         s1, ra, -1875
                  nop
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  or           t5, s0, ra
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  nop
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  nop
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  nop
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  lui          t4, 533900
                  and          a6, gp, s6
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  slti         t5, s10, -598
                  lui          t4, 533900
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  lui          t4, 533900
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  lui          t4, 533900
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  nop
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  nop
                  nop
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  lui          t4, 533900
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  nop
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  lui          t4, 533900
                  srai         a7, s9, 9
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  nop
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  lui          t4, 533900
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  nop
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  lui          t4, 533900
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  nop
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  nop
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  nop
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  nop
                  nop
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  lui          t4, 533900
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  lui          t4, 533900
                  add          s6, t3, a1
                  nop
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  lui          t4, 533900
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  nop
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  lui          t4, 533900
                  add          s6, t3, a1
                  or           t5, s0, ra
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  lui          t4, 533900
                  nop
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  nop
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  srai         a7, s9, 9
                  nop
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  lui          t4, 533900
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  nop
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  nop
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  nop
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  or           t5, s0, ra
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  xor          s9, tp, s10
                  nop
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  lui          t4, 533900
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  nop
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  and          a6, gp, s6
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  and          a6, gp, s6
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  nop
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  nop
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  nop
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  sltu         s11, a5, gp
                  lui          t4, 533900
                  nop
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  lui          t4, 533900
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  lui          t4, 533900
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  nop
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  lui          t4, 533900
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  nop
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  add          s6, t3, a1
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  nop
                  srli         t4, t3, 14
                  nop
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  nop
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  lui          t4, 533900
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  lui          t4, 533900
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  lui          t4, 533900
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  nop
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  lui          t4, 533900
                  nop
                  andi         s1, ra, -1875
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  nop
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  ori          s1, zero, -637
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  nop
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  nop
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  lui          t4, 533900
                  auipc        tp, 1017573
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  lui          t4, 533900
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  lui          t4, 533900
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  lui          t4, 533900
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  nop
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  lui          t4, 533900
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  nop
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  nop
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  or           t5, s0, ra
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  lui          t4, 533900
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  xori         s8, a3, 1278
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  srl          t5, s11, s6
                  nop
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  nop
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  nop
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  nop
                  slli         a4, s2, 6
                  nop
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  nop
                  slli         a4, s2, 6
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  li           s5, 0x0 #start riscv_int_numeric_corner_stream_3
                  li           t5, 0x0
                  li           s0, 0x5ae6d0be
                  li           s10, 0xa2240707
                  li           ra, 0xf9e18861
                  li           sp, 0xf956cbb1
                  li           s6, 0x0
                  li           s9, 0xf8ccf010
                  li           a2, 0x0
                  li           s11, 0xffffffff
                  sub          s5, s11, a2
                  lui          s11, 533900
                  lui          s11, 533900
                  lui          s11, 533900
                  auipc        a2, 1017573
                  lui          s11, 533900
                  lui          s11, 533900
                  lui          s11, 533900
                  auipc        a2, 1017573
                  add          s5, s6, t5
                  nop
                  auipc        a2, 1017573
                  lui          s11, 533900
                  sub          s5, s11, a2
                  add          s5, s6, t5
                  lui          s11, 533900
                  addi         ra, s6, 579 #end riscv_int_numeric_corner_stream_3
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  nop
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  nop
                  nop
                  slti         t5, s10, -598
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  sll          a7, s4, s3
                  lui          t4, 533900
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  srli         t4, t3, 14
                  lui          t4, 533900
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  nop
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  sra          a6, gp, s7
                  sltiu        a0, t6, 516
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  nop
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  nop
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  li           a5, 0x80000000 #start riscv_int_numeric_corner_stream_19
                  li           ra, 0xd0523006
                  li           a1, 0x80000000
                  li           t6, 0xac067d7d
                  li           t0, 0x0
                  li           s9, 0x80000000
                  li           s0, 0x0
                  li           a7, 0x0
                  li           s5, 0x61fd64ef
                  li           s7, 0x80000000
                  nop
                  addi         s7, s7, 579
                  nop
                  lui          a5, 533900
                  add          s5, s7, t6
                  addi         s7, s7, 579
                  auipc        t0, 1017573
                  lui          a5, 533900
                  nop
                  auipc        t0, 1017573
                  add          s5, s7, t6
                  nop
                  lui          a5, 533900
                  addi         s7, s7, 579
                  auipc        t0, 1017573
                  nop #end riscv_int_numeric_corner_stream_19
                  auipc        tp, 1017573
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  nop
                  auipc        tp, 1017573
                  nop
                  add          s6, t3, a1
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  sltiu        a0, t6, 516
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  lui          t4, 533900
                  add          s6, t3, a1
                  nop
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  sll          a7, s4, s3
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  nop
                  srai         a7, s9, 9
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  nop
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  srli         t4, t3, 14
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  nop
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  sltiu        a0, t6, 516
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  add          s6, t3, a1
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  nop
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  ori          s1, zero, -637
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  srl          t5, s11, s6
                  xor          s9, tp, s10
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  li           a4, 0x8ed28935 #start riscv_int_numeric_corner_stream_21
                  li           t0, 0xc046a00a
                  li           s7, 0xffffffff
                  li           s8, 0xffffffff
                  li           s5, 0x915a478d
                  li           s4, 0x5d8809e4
                  li           s1, 0x80000000
                  li           a0, 0xffffffff
                  li           s6, 0xde7c62d5
                  li           a1, 0x57ca1689
                  addi         s1, s7, 579
                  auipc        t0, 1017573
                  addi         s1, s7, 579
                  nop
                  addi         s1, s7, 579
                  add          s7, s7, a4
                  sub          s7, a1, s4
                  sub          s7, a1, s4
                  addi         s1, s7, 579
                  nop
                  auipc        t0, 1017573
                  auipc        t0, 1017573
                  lui          a1, 533900
                  addi         s1, s7, 579
                  nop
                  sub          s7, a1, s4
                  auipc        t0, 1017573
                  lui          a1, 533900
                  add          s7, s7, a4 #end riscv_int_numeric_corner_stream_21
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  nop
                  or           t5, s0, ra
                  nop
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  ori          s1, zero, -637
                  nop
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  nop
                  sll          a7, s4, s3
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  lui          t4, 533900
                  srli         t4, t3, 14
                  nop
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  lui          t4, 533900
                  slli         a4, s2, 6
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  lui          t4, 533900
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  lui          t4, 533900
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  nop
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  nop
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  nop
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  ori          s1, zero, -637
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  srai         a7, s9, 9
                  lui          t4, 533900
                  srli         t4, t3, 14
                  nop
                  and          a6, gp, s6
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  sub          s11, t3, t3
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  nop
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  lui          t4, 533900
                  nop
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  ori          s1, zero, -637
                  nop
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  or           t5, s0, ra
                  xor          s9, tp, s10
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  auipc        tp, 1017573
                  lui          t4, 533900
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  and          a6, gp, s6
                  ori          s1, zero, -637
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  and          a6, gp, s6
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  nop
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  sra          a6, gp, s7
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  sltu         s11, a5, gp
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  and          a6, gp, s6
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  nop
                  xor          s9, tp, s10
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  slli         a4, s2, 6
                  nop
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  slli         a4, s2, 6
                  addi         s5, s5, 579
                  lui          t4, 533900
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srl          t5, s11, s6
                  nop
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  nop
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  slti         t5, s10, -598
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  xori         s8, a3, 1278
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  sub          s11, t3, t3
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  slti         t5, s10, -598
                  lui          t4, 533900
                  srai         a7, s9, 9
                  or           t5, s0, ra
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  sll          a7, s4, s3
                  addi         s5, s5, 579
                  auipc        tp, 1017573
                  xori         s8, a3, 1278
                  slti         t5, s10, -598
                  lui          t4, 533900
                  srai         a7, s9, 9
                  lui          t4, 533900
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  or           t5, s0, ra
                  or           t5, s0, ra
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  nop
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  sra          a6, gp, s7
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sra          a6, gp, s7
                  nop
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  add          s6, t3, a1
                  sll          a7, s4, s3
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  auipc        tp, 1017573
                  nop
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  sra          a6, gp, s7
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  add          s6, t3, a1
                  srli         t4, t3, 14
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  xori         s8, a3, 1278
                  addi         s5, s5, 579
                  lui          t4, 533900
                  sub          s11, t3, t3
                  auipc        tp, 1017573
                  or           t5, s0, ra
                  add          s6, t3, a1
                  and          a6, gp, s6
                  lui          t4, 533900
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  sll          a7, s4, s3
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  nop
                  srl          t5, s11, s6
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  lui          t4, 533900
                  sltiu        a0, t6, 516
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  slli         a4, s2, 6
                  xori         s8, a3, 1278
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  addi         s5, s5, 579
                  slt          s1, tp, t6
                  nop
                  sll          a7, s4, s3
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  xor          s9, tp, s10
                  sltu         s11, a5, gp
                  ori          s1, zero, -637
                  nop
                  sltu         s11, a5, gp
                  sll          a7, s4, s3
                  add          s6, t3, a1
                  lui          t4, 533900
                  slt          s1, tp, t6
                  nop
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  lui          t4, 533900
                  ori          s1, zero, -637
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  srai         a7, s9, 9
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  sltu         s11, a5, gp
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  nop
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  nop
                  srai         a7, s9, 9
                  ori          s1, zero, -637
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  andi         s1, ra, -1875
                  sltiu        a0, t6, 516
                  andi         s1, ra, -1875
                  sra          a6, gp, s7
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  ori          s1, zero, -637
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  slt          s1, tp, t6
                  srl          t5, s11, s6
                  addi         s5, s5, 579
                  srai         a7, s9, 9
                  lui          t4, 533900
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  sltiu        a0, t6, 516
                  sra          a6, gp, s7
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  and          a6, gp, s6
                  nop
                  sra          a6, gp, s7
                  and          a6, gp, s6
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  or           t5, s0, ra
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  srai         a7, s9, 9
                  lui          t4, 533900
                  lui          t4, 533900
                  and          a6, gp, s6
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  xor          s9, tp, s10
                  sub          s11, t3, t3
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  sltiu        a0, t6, 516
                  add          s6, t3, a1
                  sub          s11, t3, t3
                  andi         s1, ra, -1875
                  srl          t5, s11, s6
                  slti         t5, s10, -598
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  lui          t4, 533900
                  sub          s11, t3, t3
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  slti         t5, s10, -598
                  lui          t4, 533900
                  slt          s1, tp, t6
                  slt          s1, tp, t6
                  auipc        tp, 1017573
                  auipc        tp, 1017573
                  addi         s5, s5, 579
                  andi         s1, ra, -1875
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  sra          a6, gp, s7
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  sra          a6, gp, s7
                  xori         s8, a3, 1278
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  and          a6, gp, s6
                  srli         t4, t3, 14
                  slli         a4, s2, 6
                  and          a6, gp, s6
                  add          s6, t3, a1
                  slti         t5, s10, -598
                  sltu         s11, a5, gp
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  sub          s11, t3, t3
                  slt          s1, tp, t6
                  slti         t5, s10, -598
                  or           t5, s0, ra
                  lui          t4, 533900
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  nop
                  slt          s1, tp, t6
                  addi         s5, s5, 579
                  srli         t4, t3, 14
                  slt          s1, tp, t6
                  sltu         s11, a5, gp
                  and          a6, gp, s6
                  slt          s1, tp, t6
                  srli         t4, t3, 14
                  addi         s5, s5, 579
                  srl          t5, s11, s6
                  sll          a7, s4, s3
                  xor          s9, tp, s10
                  lui          t4, 533900
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  srai         a7, s9, 9
                  lui          t4, 533900
                  addi         s5, s5, 579
                  addi         s5, s5, 579
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  slli         a4, s2, 6
                  auipc        tp, 1017573
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  addi         s5, s5, 579
                  xor          s9, tp, s10
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  ori          s1, zero, -637
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  ori          s1, zero, -637
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  lui          t4, 533900
                  xori         s8, a3, 1278
                  nop
                  or           t5, s0, ra
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  nop
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  lui          t4, 533900
                  auipc        tp, 1017573
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  add          s6, t3, a1
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  ori          s1, zero, -637
                  lui          t4, 533900
                  lui          t4, 533900
                  or           t5, s0, ra
                  srli         t4, t3, 14
                  and          a6, gp, s6
                  slli         a4, s2, 6
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  and          a6, gp, s6
                  add          s6, t3, a1
                  lui          t4, 533900
                  or           t5, s0, ra
                  slt          s1, tp, t6
                  sll          a7, s4, s3
                  sll          a7, s4, s3
                  andi         s1, ra, -1875
                  sltu         s11, a5, gp
                  andi         s1, ra, -1875
                  nop
                  xori         s8, a3, 1278
                  nop
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  nop
                  andi         s1, ra, -1875
                  lui          t4, 533900
                  srl          t5, s11, s6
                  andi         s1, ra, -1875
                  xori         s8, a3, 1278
                  lui          t4, 533900
                  srli         t4, t3, 14
                  xori         s8, a3, 1278
                  sltiu        a0, t6, 516
                  srai         a7, s9, 9
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  auipc        tp, 1017573
                  nop
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  slli         a4, s2, 6
                  ori          s1, zero, -637
                  xor          s9, tp, s10
                  slti         t5, s10, -598
                  srl          t5, s11, s6
                  srai         a7, s9, 9
                  sltiu        a0, t6, 516
                  sltu         s11, a5, gp
                  or           t5, s0, ra
                  xori         s8, a3, 1278
                  sltu         s11, a5, gp
                  srli         t4, t3, 14
                  slti         t5, s10, -598
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  nop
                  ori          s1, zero, -637
                  addi         s5, s5, 579
                  slti         t5, s10, -598
                  xori         s8, a3, 1278
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  sltiu        a0, t6, 516
                  xor          s9, tp, s10
                  srli         t4, t3, 14
                  sub          s11, t3, t3
                  sltiu        a0, t6, 516
                  or           t5, s0, ra
                  addi         s5, s5, 579
                  or           t5, s0, ra
                  or           t5, s0, ra
                  add          s6, t3, a1
                  andi         s1, ra, -1875
                  or           t5, s0, ra
                  auipc        tp, 1017573
                  slt          s1, tp, t6
                  srai         a7, s9, 9
                  sra          a6, gp, s7
                  slt          s1, tp, t6
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  sra          a6, gp, s7
                  nop
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  slti         t5, s10, -598
                  srai         a7, s9, 9
                  sltu         s11, a5, gp
                  li           s6, 0xffffffff #start riscv_int_numeric_corner_stream_7
                  li           a6, 0x2830d0bb
                  li           s5, 0x80000000
                  li           sp, 0xd3ac7a85
                  li           gp, 0x0
                  li           s1, 0x80000000
                  li           a1, 0x73a51a7
                  li           s7, 0x80000000
                  li           t0, 0xffffffff
                  li           a7, 0x0
                  auipc        t0, 1017573
                  auipc        t0, 1017573
                  add          s6, a1, a1
                  auipc        t0, 1017573
                  add          s6, a1, a1
                  nop
                  auipc        t0, 1017573
                  auipc        t0, 1017573
                  lui          a1, 533900
                  addi         t0, s5, 579
                  add          s6, a1, a1
                  add          s6, a1, a1
                  lui          a1, 533900
                  sub          t0, a6, a6
                  addi         t0, s5, 579 #end riscv_int_numeric_corner_stream_7
                  sltu         s11, a5, gp
                  slt          s1, tp, t6
                  sub          s11, t3, t3
                  or           t5, s0, ra
                  andi         s1, ra, -1875
                  sub          s11, t3, t3
                  srl          t5, s11, s6
                  slli         a4, s2, 6
                  slti         t5, s10, -598
                  sll          a7, s4, s3
                  xori         s8, a3, 1278
                  srl          t5, s11, s6
                  sltu         s11, a5, gp
                  nop
                  sltiu        a0, t6, 516
                  sll          a7, s4, s3
                  lui          t4, 533900
                  lui          t4, 533900
                  slti         t5, s10, -598
                  add          s6, t3, a1
                  slli         a4, s2, 6
                  andi         s1, ra, -1875
                  andi         s1, ra, -1875
                  slli         a4, s2, 6
                  slt          s1, tp, t6
                  add          s6, t3, a1
                  xor          s9, tp, s10
                  and          a6, gp, s6
                  srl          t5, s11, s6
                  nop
                  andi         s1, ra, -1875
                  addi         s5, s5, 579
                  nop
                  ori          s1, zero, -637
                  add          s6, t3, a1
                  or           t5, s0, ra
                  and          a6, gp, s6
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  lui          t4, 533900
                  srl          t5, s11, s6
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  srai         a7, s9, 9
                  add          s6, t3, a1
                  srai         a7, s9, 9
                  xori         s8, a3, 1278
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  addi         s5, s5, 579
                  sll          a7, s4, s3
                  auipc        tp, 1017573
                  add          s6, t3, a1
                  auipc        tp, 1017573
                  ori          s1, zero, -637
                  sltu         s11, a5, gp
                  sltu         s11, a5, gp
                  sub          s11, t3, t3
                  xor          s9, tp, s10
                  or           t5, s0, ra
                  slli         a4, s2, 6
                  la x13, test_done
                  jalr x0, x13, 0
test_done:        
                  li gp, 1
                  ecall
write_tohost:     
                  sw gp, tohost, t5

_exit:            
                  j write_tohost

instr_end:        
                  nop

.section .data
.align 6; .global tohost; tohost: .dword 0;
.align 6; .global fromhost; fromhost: .dword 0;
.section .user_stack,"aw",@progbits;
.align 2
user_stack_start:
.rept 4999
.4byte 0x0
.endr
user_stack_end:
.4byte 0x0
.align 2
kernel_instr_start:
.text
mmode_intr_vector_1:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_2:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_3:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_4:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_5:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_6:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_7:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_8:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_9:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_10:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_11:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_12:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_13:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_14:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

mmode_intr_vector_15:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x342 # MCAUSE
                  srli x22, x22, 0x1f
                  beqz x22, 1f
                  j mmode_intr_handler
                  1: la x13, test_done
                  jalr x0, x13, 0

.align           4
mtvec_handler:    
                  .option norvc;
                  j mmode_exception_handler
                  j mmode_intr_vector_1
                  j mmode_intr_vector_2
                  j mmode_intr_vector_3
                  j mmode_intr_vector_4
                  j mmode_intr_vector_5
                  j mmode_intr_vector_6
                  j mmode_intr_vector_7
                  j mmode_intr_vector_8
                  j mmode_intr_vector_9
                  j mmode_intr_vector_10
                  j mmode_intr_vector_11
                  j mmode_intr_vector_12
                  j mmode_intr_vector_13
                  j mmode_intr_vector_14
                  j mmode_intr_vector_15

mmode_exception_handler:
                  addi x18, x18, -4
                  sw  x19, (x18)
                  add x19, x18, zero
                  addi x19, x19, -128
                  sw  x1, 4(x19)
                  sw  x2, 8(x19)
                  sw  x3, 12(x19)
                  sw  x4, 16(x19)
                  sw  x5, 20(x19)
                  sw  x6, 24(x19)
                  sw  x7, 28(x19)
                  sw  x8, 32(x19)
                  sw  x9, 36(x19)
                  sw  x10, 40(x19)
                  sw  x11, 44(x19)
                  sw  x12, 48(x19)
                  sw  x13, 52(x19)
                  sw  x14, 56(x19)
                  sw  x15, 60(x19)
                  sw  x16, 64(x19)
                  sw  x17, 68(x19)
                  sw  x18, 72(x19)
                  sw  x19, 76(x19)
                  sw  x20, 80(x19)
                  sw  x21, 84(x19)
                  sw  x22, 88(x19)
                  sw  x23, 92(x19)
                  sw  x24, 96(x19)
                  sw  x25, 100(x19)
                  sw  x26, 104(x19)
                  sw  x27, 108(x19)
                  sw  x28, 112(x19)
                  sw  x29, 116(x19)
                  sw  x30, 120(x19)
                  sw  x31, 124(x19)
                  add x18, x19, zero
                  csrr x22, 0x341 # MEPC
                  csrr x22, 0x342 # MCAUSE
                  li x17, 0x3 # BREAKPOINT
                  beq x22, x17, ebreak_handler
                  li x17, 0x8 # ECALL_UMODE
                  beq x22, x17, ecall_handler
                  li x17, 0x9 # ECALL_SMODE
                  beq x22, x17, ecall_handler
                  li x17, 0xb # ECALL_MMODE
                  beq x22, x17, ecall_handler
                  li x17, 0x1
                  beq x22, x17, instr_fault_handler
                  li x17, 0x5
                  beq x22, x17, load_fault_handler
                  li x17, 0x7
                  beq x22, x17, store_fault_handler
                  li x17, 0xc
                  beq x22, x17, pt_fault_handler
                  li x17, 0xd
                  beq x22, x17, pt_fault_handler
                  li x17, 0xf
                  beq x22, x17, pt_fault_handler
                  li x17, 0x2 # ILLEGAL_INSTRUCTION
                  beq x22, x17, illegal_instr_handler
                  csrr x17, 0x343 # MTVAL
                  1: la x13, test_done
                  jalr x1, x13, 0

ecall_handler:    
                  la x22, _start
                  sw x0, 0(x22)
                  sw x1, 4(x22)
                  sw x2, 8(x22)
                  sw x3, 12(x22)
                  sw x4, 16(x22)
                  sw x5, 20(x22)
                  sw x6, 24(x22)
                  sw x7, 28(x22)
                  sw x8, 32(x22)
                  sw x9, 36(x22)
                  sw x10, 40(x22)
                  sw x11, 44(x22)
                  sw x12, 48(x22)
                  sw x13, 52(x22)
                  sw x14, 56(x22)
                  sw x15, 60(x22)
                  sw x16, 64(x22)
                  sw x17, 68(x22)
                  sw x18, 72(x22)
                  sw x19, 76(x22)
                  sw x20, 80(x22)
                  sw x21, 84(x22)
                  sw x22, 88(x22)
                  sw x23, 92(x22)
                  sw x24, 96(x22)
                  sw x25, 100(x22)
                  sw x26, 104(x22)
                  sw x27, 108(x22)
                  sw x28, 112(x22)
                  sw x29, 116(x22)
                  sw x30, 120(x22)
                  sw x31, 124(x22)
                  la x13, write_tohost
                  jalr x0, x13, 0

instr_fault_handler:
                  add x19, x18, zero
                  lw  x1, 4(x19)
                  lw  x2, 8(x19)
                  lw  x3, 12(x19)
                  lw  x4, 16(x19)
                  lw  x5, 20(x19)
                  lw  x6, 24(x19)
                  lw  x7, 28(x19)
                  lw  x8, 32(x19)
                  lw  x9, 36(x19)
                  lw  x10, 40(x19)
                  lw  x11, 44(x19)
                  lw  x12, 48(x19)
                  lw  x13, 52(x19)
                  lw  x14, 56(x19)
                  lw  x15, 60(x19)
                  lw  x16, 64(x19)
                  lw  x17, 68(x19)
                  lw  x18, 72(x19)
                  lw  x19, 76(x19)
                  lw  x20, 80(x19)
                  lw  x21, 84(x19)
                  lw  x22, 88(x19)
                  lw  x23, 92(x19)
                  lw  x24, 96(x19)
                  lw  x25, 100(x19)
                  lw  x26, 104(x19)
                  lw  x27, 108(x19)
                  lw  x28, 112(x19)
                  lw  x29, 116(x19)
                  lw  x30, 120(x19)
                  lw  x31, 124(x19)
                  addi x19, x19, 128
                  add x18, x19, zero
                  lw  x19, (x18)
                  addi x18, x18, 4
                  mret

load_fault_handler:
                  add x19, x18, zero
                  lw  x1, 4(x19)
                  lw  x2, 8(x19)
                  lw  x3, 12(x19)
                  lw  x4, 16(x19)
                  lw  x5, 20(x19)
                  lw  x6, 24(x19)
                  lw  x7, 28(x19)
                  lw  x8, 32(x19)
                  lw  x9, 36(x19)
                  lw  x10, 40(x19)
                  lw  x11, 44(x19)
                  lw  x12, 48(x19)
                  lw  x13, 52(x19)
                  lw  x14, 56(x19)
                  lw  x15, 60(x19)
                  lw  x16, 64(x19)
                  lw  x17, 68(x19)
                  lw  x18, 72(x19)
                  lw  x19, 76(x19)
                  lw  x20, 80(x19)
                  lw  x21, 84(x19)
                  lw  x22, 88(x19)
                  lw  x23, 92(x19)
                  lw  x24, 96(x19)
                  lw  x25, 100(x19)
                  lw  x26, 104(x19)
                  lw  x27, 108(x19)
                  lw  x28, 112(x19)
                  lw  x29, 116(x19)
                  lw  x30, 120(x19)
                  lw  x31, 124(x19)
                  addi x19, x19, 128
                  add x18, x19, zero
                  lw  x19, (x18)
                  addi x18, x18, 4
                  mret

store_fault_handler:
                  add x19, x18, zero
                  lw  x1, 4(x19)
                  lw  x2, 8(x19)
                  lw  x3, 12(x19)
                  lw  x4, 16(x19)
                  lw  x5, 20(x19)
                  lw  x6, 24(x19)
                  lw  x7, 28(x19)
                  lw  x8, 32(x19)
                  lw  x9, 36(x19)
                  lw  x10, 40(x19)
                  lw  x11, 44(x19)
                  lw  x12, 48(x19)
                  lw  x13, 52(x19)
                  lw  x14, 56(x19)
                  lw  x15, 60(x19)
                  lw  x16, 64(x19)
                  lw  x17, 68(x19)
                  lw  x18, 72(x19)
                  lw  x19, 76(x19)
                  lw  x20, 80(x19)
                  lw  x21, 84(x19)
                  lw  x22, 88(x19)
                  lw  x23, 92(x19)
                  lw  x24, 96(x19)
                  lw  x25, 100(x19)
                  lw  x26, 104(x19)
                  lw  x27, 108(x19)
                  lw  x28, 112(x19)
                  lw  x29, 116(x19)
                  lw  x30, 120(x19)
                  lw  x31, 124(x19)
                  addi x19, x19, 128
                  add x18, x19, zero
                  lw  x19, (x18)
                  addi x18, x18, 4
                  mret

ebreak_handler:   
                  csrr  x22, 0x341
                  addi  x22, x22, 4
                  csrw  0x341, x22
                  add x19, x18, zero
                  lw  x1, 4(x19)
                  lw  x2, 8(x19)
                  lw  x3, 12(x19)
                  lw  x4, 16(x19)
                  lw  x5, 20(x19)
                  lw  x6, 24(x19)
                  lw  x7, 28(x19)
                  lw  x8, 32(x19)
                  lw  x9, 36(x19)
                  lw  x10, 40(x19)
                  lw  x11, 44(x19)
                  lw  x12, 48(x19)
                  lw  x13, 52(x19)
                  lw  x14, 56(x19)
                  lw  x15, 60(x19)
                  lw  x16, 64(x19)
                  lw  x17, 68(x19)
                  lw  x18, 72(x19)
                  lw  x19, 76(x19)
                  lw  x20, 80(x19)
                  lw  x21, 84(x19)
                  lw  x22, 88(x19)
                  lw  x23, 92(x19)
                  lw  x24, 96(x19)
                  lw  x25, 100(x19)
                  lw  x26, 104(x19)
                  lw  x27, 108(x19)
                  lw  x28, 112(x19)
                  lw  x29, 116(x19)
                  lw  x30, 120(x19)
                  lw  x31, 124(x19)
                  addi x19, x19, 128
                  add x18, x19, zero
                  lw  x19, (x18)
                  addi x18, x18, 4
                  mret

illegal_instr_handler:
                  csrr  x22, 0x341
                  addi  x22, x22, 4
                  csrw  0x341, x22
                  add x19, x18, zero
                  lw  x1, 4(x19)
                  lw  x2, 8(x19)
                  lw  x3, 12(x19)
                  lw  x4, 16(x19)
                  lw  x5, 20(x19)
                  lw  x6, 24(x19)
                  lw  x7, 28(x19)
                  lw  x8, 32(x19)
                  lw  x9, 36(x19)
                  lw  x10, 40(x19)
                  lw  x11, 44(x19)
                  lw  x12, 48(x19)
                  lw  x13, 52(x19)
                  lw  x14, 56(x19)
                  lw  x15, 60(x19)
                  lw  x16, 64(x19)
                  lw  x17, 68(x19)
                  lw  x18, 72(x19)
                  lw  x19, 76(x19)
                  lw  x20, 80(x19)
                  lw  x21, 84(x19)
                  lw  x22, 88(x19)
                  lw  x23, 92(x19)
                  lw  x24, 96(x19)
                  lw  x25, 100(x19)
                  lw  x26, 104(x19)
                  lw  x27, 108(x19)
                  lw  x28, 112(x19)
                  lw  x29, 116(x19)
                  lw  x30, 120(x19)
                  lw  x31, 124(x19)
                  addi x19, x19, 128
                  add x18, x19, zero
                  lw  x19, (x18)
                  addi x18, x18, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x22, 0x300 # MSTATUS;
                  csrr  x22, 0x304 # MIE;
                  csrr  x22, 0x344 # MIP;
                  csrrc x22, 0x344, x22 # MIP;
                  add x19, x18, zero
                  lw  x1, 4(x19)
                  lw  x2, 8(x19)
                  lw  x3, 12(x19)
                  lw  x4, 16(x19)
                  lw  x5, 20(x19)
                  lw  x6, 24(x19)
                  lw  x7, 28(x19)
                  lw  x8, 32(x19)
                  lw  x9, 36(x19)
                  lw  x10, 40(x19)
                  lw  x11, 44(x19)
                  lw  x12, 48(x19)
                  lw  x13, 52(x19)
                  lw  x14, 56(x19)
                  lw  x15, 60(x19)
                  lw  x16, 64(x19)
                  lw  x17, 68(x19)
                  lw  x18, 72(x19)
                  lw  x19, 76(x19)
                  lw  x20, 80(x19)
                  lw  x21, 84(x19)
                  lw  x22, 88(x19)
                  lw  x23, 92(x19)
                  lw  x24, 96(x19)
                  lw  x25, 100(x19)
                  lw  x26, 104(x19)
                  lw  x27, 108(x19)
                  lw  x28, 112(x19)
                  lw  x29, 116(x19)
                  lw  x30, 120(x19)
                  lw  x31, 124(x19)
                  addi x19, x19, 128
                  add x18, x19, zero
                  lw  x19, (x18)
                  addi x18, x18, 4
                  mret;

kernel_instr_end: nop
.section .kernel_stack,"aw",@progbits;
.align 2
kernel_stack_start:
.rept 3999
.4byte 0x0
.endr
kernel_stack_end:
.4byte 0x0
