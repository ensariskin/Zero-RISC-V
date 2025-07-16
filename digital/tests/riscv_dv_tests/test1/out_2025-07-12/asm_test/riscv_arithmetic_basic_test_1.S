.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x20, h0_start
jalr x0, x20, 0
h0_start:
                  li x26, 0x40000100
                  csrw 0x301, x26
kernel_sp:        
                  la x23, kernel_stack_end

trap_vec_init:    
                  la x26, mtvec_handler
                  ori x26, x26, 1
                  csrw 0x305, x26 # MTVEC

mepc_setup:       
                  la x26, init
                  csrw 0x341, x26

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x26, 0x1800
                  csrw 0x300, x26 # MSTATUS
                  li x26, 0x0
                  csrw 0x304, x26 # MIE
                  mret
init:             
                  li x0, 0x80000000
                  li x1, 0x80000000
                  li x3, 0xc
                  li x4, 0x44d2597e
                  li x5, 0x0
                  li x6, 0x0
                  li x7, 0x0
                  li x8, 0xfa9b1179
                  li x9, 0xbb198275
                  li x10, 0x80000000
                  li x11, 0x887d450d
                  li x12, 0x72147571
                  li x13, 0xf010a4ed
                  li x14, 0x13f04348
                  li x15, 0x80000000
                  li x16, 0x50ca2c23
                  li x17, 0x0
                  li x18, 0x2e296b6e
                  li x19, 0x5
                  li x20, 0x0
                  li x21, 0x2
                  li x22, 0x80000000
                  li x24, 0x209e7102
                  li x25, 0x0
                  li x26, 0x0
                  li x27, 0xd
                  li x28, 0xffda5f1f
                  li x29, 0x7bbbedda
                  li x30, 0xfc94dfa5
                  li x31, 0x5
                  la x2, user_stack_end
main:             li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_30
                  li           s11, 0x80000000
                  li           s2, 0xbf484089
                  li           t1, 0xffffffff
                  li           tp, 0xffffffff
                  li           s3, 0xffffffff
                  li           s6, 0x80000000
                  li           t2, 0xd3f0e3a0
                  li           s5, 0xffffffff
                  li           a3, 0x6e359a8b
                  lui          s11, 79721
                  lui          s11, 79721
                  add          s11, t6, s11
                  add          s11, t6, s11
                  addi         tp, tp, 1497
                  add          s11, t6, s11
                  add          s11, t6, s11
                  nop
                  nop
                  addi         tp, tp, 1497
                  sub          s5, s11, s5
                  add          s11, t6, s11
                  nop
                  addi         tp, tp, 1497
                  lui          s11, 79721
                  nop
                  auipc        tp, 970582
                  lui          s11, 79721
                  lui          s11, 79721
                  lui          s11, 79721
                  auipc        tp, 970582
                  add          s11, t6, s11 #end riscv_int_numeric_corner_stream_30
                  li           s6, 0x80000000 #start riscv_int_numeric_corner_stream_2
                  li           s11, 0xffffffff
                  li           t6, 0xffffffff
                  li           t0, 0x0
                  li           s5, 0x5003cc09
                  li           s3, 0xedb858da
                  li           gp, 0x80000000
                  li           s2, 0x101f0206
                  li           s8, 0x0
                  li           s10, 0x80000000
                  addi         gp, t0, 1497
                  add          s5, s11, gp
                  sub          t6, t6, s5
                  auipc        t0, 970582
                  add          s5, s11, gp
                  lui          s10, 79721
                  auipc        t0, 970582
                  addi         gp, t0, 1497
                  nop
                  nop
                  auipc        t0, 970582
                  lui          s10, 79721
                  sub          t6, t6, s5
                  sub          t6, t6, s5
                  add          s5, s11, gp #end riscv_int_numeric_corner_stream_2
                  li           gp, 0x4166ff03 #start riscv_int_numeric_corner_stream_20
                  li           a6, 0x0
                  li           a2, 0xeb374be3
                  li           s0, 0xb8e79cd4
                  li           t6, 0xf728e103
                  li           s1, 0x203092e3
                  li           t3, 0x80000000
                  li           t4, 0xffffffff
                  li           tp, 0xc82a6af9
                  li           t1, 0x80000000
                  lui          t6, 79721
                  addi         a6, a6, 1497
                  addi         a6, a6, 1497
                  addi         a6, a6, 1497
                  sub          t6, t6, a6
                  addi         a6, a6, 1497
                  sub          t6, t6, a6
                  sub          t6, t6, a6
                  add          gp, t6, gp
                  sub          t6, t6, a6
                  addi         a6, a6, 1497
                  sub          t6, t6, a6
                  sub          t6, t6, a6
                  auipc        tp, 970582
                  addi         a6, a6, 1497
                  nop
                  nop
                  lui          t6, 79721
                  sub          t6, t6, a6
                  addi         a6, a6, 1497
                  add          gp, t6, gp #end riscv_int_numeric_corner_stream_20
                  li           s9, 0x0 #start riscv_int_numeric_corner_stream_23
                  li           a3, 0x80000000
                  li           a5, 0x80000000
                  li           t5, 0x4348ec66
                  li           t0, 0x80000000
                  li           a0, 0x80000000
                  li           gp, 0x0
                  li           a1, 0xde07d9af
                  li           t4, 0x0
                  li           s10, 0x1034f79d
                  addi         a0, t0, 1497
                  add          t0, a5, gp
                  sub          s9, t4, s9
                  nop
                  sub          s9, t4, s9
                  add          t0, a5, gp
                  lui          a0, 79721
                  sub          s9, t4, s9
                  auipc        t0, 970582
                  auipc        t0, 970582
                  lui          a0, 79721
                  sub          s9, t4, s9
                  nop
                  add          t0, a5, gp
                  sub          s9, t4, s9
                  add          t0, a5, gp
                  addi         a0, t0, 1497
                  lui          a0, 79721
                  sub          s9, t4, s9
                  sub          s9, t4, s9
                  lui          a0, 79721
                  nop
                  nop #end riscv_int_numeric_corner_stream_23
                  li           a0, 0x80000000 #start riscv_int_numeric_corner_stream_4
                  li           t3, 0x0
                  li           a3, 0x80000000
                  li           s5, 0xb2d32dbc
                  li           s10, 0xb850104d
                  li           tp, 0xa03106fb
                  li           t1, 0xffffffff
                  li           a4, 0x762c8ad9
                  li           t4, 0xffffffff
                  li           s9, 0xfcea52d6
                  sub          s5, t4, s5
                  nop
                  sub          s5, t4, s5
                  sub          s5, t4, s5
                  add          s5, tp, s5
                  add          s5, tp, s5
                  nop
                  auipc        tp, 970582
                  sub          s5, t4, s5
                  addi         a0, tp, 1497
                  nop
                  sub          s5, t4, s5
                  auipc        tp, 970582
                  add          s5, tp, s5
                  nop
                  sub          s5, t4, s5
                  sub          s5, t4, s5
                  addi         a0, tp, 1497
                  nop
                  add          s5, tp, s5
                  addi         a0, tp, 1497
                  addi         a0, tp, 1497
                  auipc        tp, 970582
                  lui          a0, 79721
                  auipc        tp, 970582
                  nop #end riscv_int_numeric_corner_stream_4
                  li           a2, 0x74257720 #start riscv_int_numeric_corner_stream_36
                  li           s10, 0x80000000
                  li           t6, 0x18bf6627
                  li           s2, 0x0
                  li           t2, 0x80000000
                  li           t4, 0x0
                  li           a0, 0x80000000
                  li           a4, 0x80000000
                  li           t3, 0x0
                  li           t1, 0xffffffff
                  nop
                  add          a0, t1, t4
                  sub          t4, t6, t3
                  auipc        t1, 970582
                  add          a0, t1, t4
                  add          a0, t1, t4
                  sub          t4, t6, t3
                  nop
                  nop
                  auipc        t1, 970582
                  nop
                  nop
                  auipc        t1, 970582
                  lui          a0, 79721
                  sub          t4, t6, t3
                  lui          a0, 79721
                  lui          a0, 79721
                  addi         s2, a2, 1497
                  sub          t4, t6, t3
                  auipc        t1, 970582 #end riscv_int_numeric_corner_stream_36
                  li           t5, 0xffffffff #start riscv_int_numeric_corner_stream_16
                  li           t2, 0x0
                  li           s9, 0x0
                  li           t3, 0xafd18901
                  li           s5, 0xffffffff
                  li           t6, 0xd0f27bd7
                  li           s10, 0x0
                  li           s1, 0x0
                  li           t4, 0xffffffff
                  li           gp, 0x77afc22a
                  nop
                  add          t6, t6, gp
                  addi         t3, s5, 1497
                  auipc        t2, 970582
                  auipc        t2, 970582
                  lui          s10, 79721
                  auipc        t2, 970582
                  lui          s10, 79721
                  add          t6, t6, gp
                  auipc        t2, 970582
                  nop
                  nop
                  sub          s9, t6, s5
                  nop
                  nop
                  nop
                  add          t6, t6, gp
                  nop
                  lui          s10, 79721 #end riscv_int_numeric_corner_stream_16
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_37
                  li           t0, 0xffffffff
                  li           t5, 0xdc3aba38
                  li           s2, 0x97709145
                  li           t6, 0x80000000
                  li           s6, 0x8fb72bfe
                  li           s8, 0x80000000
                  li           a6, 0x80000000
                  li           a3, 0x80000000
                  li           a1, 0x80000000
                  addi         a6, a6, 1497
                  auipc        tp, 970582
                  sub          t0, t6, a6
                  auipc        tp, 970582
                  add          t0, tp, a1
                  auipc        tp, 970582
                  nop
                  nop
                  addi         a6, a6, 1497
                  auipc        tp, 970582
                  add          t0, tp, a1
                  lui          a1, 79721
                  sub          t0, t6, a6
                  sub          t0, t6, a6
                  nop
                  lui          a1, 79721
                  lui          a1, 79721
                  addi         a6, a6, 1497
                  nop
                  addi         a6, a6, 1497
                  add          t0, tp, a1
                  sub          t0, t6, a6
                  add          t0, tp, a1
                  add          t0, tp, a1
                  auipc        tp, 970582
                  auipc        tp, 970582
                  add          t0, tp, a1
                  lui          a1, 79721 #end riscv_int_numeric_corner_stream_37
                  li           s5, 0xe4b349fc #start riscv_int_numeric_corner_stream_39
                  li           s0, 0xffffffff
                  li           s9, 0x0
                  li           a6, 0x924d3bac
                  li           s3, 0x0
                  li           s11, 0x80000000
                  li           t3, 0x0
                  li           a2, 0xffffffff
                  li           s1, 0x80000000
                  li           s2, 0xffffffff
                  sub          s5, a6, a6
                  nop
                  auipc        s5, 970582
                  addi         a6, a6, 1497
                  nop
                  auipc        s5, 970582
                  nop
                  sub          s5, a6, a6
                  auipc        s5, 970582
                  addi         a6, a6, 1497
                  addi         a6, a6, 1497
                  add          s5, s11, s3
                  nop
                  sub          s5, a6, a6
                  auipc        s5, 970582
                  add          s5, s11, s3
                  sub          s5, a6, a6 #end riscv_int_numeric_corner_stream_39
                  li           t3, 0xd71dc58b #start riscv_int_numeric_corner_stream_35
                  li           s0, 0x64c29543
                  li           s1, 0xffffffff
                  li           t4, 0xffffffff
                  li           t6, 0x7e102fe
                  li           a2, 0x80000000
                  li           s2, 0xffffffff
                  li           s6, 0x0
                  li           a6, 0x80000000
                  li           t5, 0x0
                  addi         a6, a6, 1497
                  lui          t6, 79721
                  sub          s1, t6, a6
                  auipc        a2, 970582
                  add          s6, t6, t4
                  nop
                  addi         a6, a6, 1497
                  auipc        a2, 970582
                  sub          s1, t6, a6
                  sub          s1, t6, a6
                  lui          t6, 79721
                  auipc        a2, 970582
                  auipc        a2, 970582
                  add          s6, t6, t4
                  sub          s1, t6, a6
                  sub          s1, t6, a6
                  nop
                  addi         a6, a6, 1497
                  auipc        a2, 970582 #end riscv_int_numeric_corner_stream_35
                  li           s3, 0x2edde973 #start riscv_int_numeric_corner_stream_1
                  li           t0, 0x80000000
                  li           a2, 0xf0fb9eb9
                  li           s10, 0xc6e04943
                  li           t1, 0x80000000
                  li           ra, 0xffffffff
                  li           t6, 0x80000000
                  li           a0, 0x0
                  li           s6, 0x0
                  li           s11, 0xdd3022a2
                  addi         t1, a2, 1497
                  sub          t6, s10, a2
                  auipc        t1, 970582
                  sub          t6, s10, a2
                  lui          a0, 79721
                  addi         t1, a2, 1497
                  nop
                  auipc        t1, 970582
                  sub          t6, s10, a2
                  lui          a0, 79721
                  add          s11, a0, s3
                  sub          t6, s10, a2
                  auipc        t1, 970582
                  addi         t1, a2, 1497
                  addi         t1, a2, 1497
                  nop
                  lui          a0, 79721
                  add          s11, a0, s3
                  sub          t6, s10, a2
                  lui          a0, 79721
                  addi         t1, a2, 1497
                  sub          t6, s10, a2
                  sub          t6, s10, a2 #end riscv_int_numeric_corner_stream_1
                  li           a7, 0x80000000 #start riscv_int_numeric_corner_stream_34
                  li           ra, 0x0
                  li           t4, 0x0
                  li           tp, 0xffffffff
                  li           s5, 0xffffffff
                  li           a6, 0xffffffff
                  li           t1, 0x1dfe59b3
                  li           t6, 0x80000000
                  li           a1, 0x33c9e2b6
                  li           s6, 0x80000000
                  nop
                  addi         tp, a7, 1497
                  nop
                  add          t6, t6, a1
                  nop
                  addi         tp, a7, 1497
                  nop
                  nop
                  nop
                  nop
                  auipc        tp, 970582
                  auipc        tp, 970582
                  auipc        tp, 970582
                  addi         tp, a7, 1497
                  addi         tp, a7, 1497
                  nop
                  addi         tp, a7, 1497
                  auipc        tp, 970582
                  auipc        tp, 970582
                  lui          a1, 79721
                  addi         tp, a7, 1497
                  sub          t6, a6, a6
                  auipc        tp, 970582
                  sub          t6, a6, a6
                  sub          t6, a6, a6
                  sub          t6, a6, a6 #end riscv_int_numeric_corner_stream_34
                  li           a7, 0x0 #start riscv_int_numeric_corner_stream_17
                  li           a2, 0xd70a8d14
                  li           t0, 0x58dfc1c2
                  li           a5, 0x80000000
                  li           ra, 0xa1ac17ed
                  li           s1, 0xa9f5dc53
                  li           t4, 0x80000000
                  li           s2, 0x80000000
                  li           gp, 0xffffffff
                  li           s5, 0x80000000
                  addi         a2, a7, 1497
                  add          t4, t4, gp
                  add          t4, t4, gp
                  add          t4, t4, gp
                  auipc        t0, 970582
                  sub          t4, t4, a7
                  sub          t4, t4, a7
                  addi         a2, a7, 1497
                  addi         a2, a7, 1497
                  sub          t4, t4, a7
                  nop
                  addi         a2, a7, 1497
                  sub          t4, t4, a7
                  add          t4, t4, gp
                  add          t4, t4, gp
                  nop
                  sub          t4, t4, a7
                  add          t4, t4, gp
                  addi         a2, a7, 1497
                  auipc        t0, 970582
                  auipc        t0, 970582
                  addi         a2, a7, 1497
                  add          t4, t4, gp
                  addi         a2, a7, 1497 #end riscv_int_numeric_corner_stream_17
                  li           a5, 0x80000000 #start riscv_int_numeric_corner_stream_32
                  li           a1, 0xbd8e3310
                  li           s8, 0x80000000
                  li           t6, 0xffffffff
                  li           ra, 0x0
                  li           s9, 0xffffffff
                  li           t3, 0x0
                  li           s5, 0x4d6252b0
                  li           a0, 0x0
                  li           tp, 0x80000000
                  sub          ra, t6, s5
                  sub          ra, t6, s5
                  add          t6, t6, a1
                  auipc        tp, 970582
                  nop
                  nop
                  lui          a1, 79721
                  add          t6, t6, a1
                  auipc        tp, 970582
                  sub          ra, t6, s5
                  add          t6, t6, a1
                  addi         ra, ra, 1497
                  lui          a1, 79721
                  sub          ra, t6, s5
                  nop #end riscv_int_numeric_corner_stream_32
                  li           s10, 0xb9717472 #start riscv_int_numeric_corner_stream_0
                  li           s9, 0x7ff7cf2c
                  li           s8, 0xffffffff
                  li           s0, 0x0
                  li           t6, 0x35dc866e
                  li           s6, 0x0
                  li           a4, 0xcee4fbc0
                  li           ra, 0x89a9aebe
                  li           t2, 0x0
                  li           a1, 0xffffffff
                  nop
                  nop
                  lui          a4, 79721
                  add          ra, t6, a1
                  lui          a4, 79721
                  nop
                  auipc        t2, 970582
                  auipc        t2, 970582
                  nop
                  auipc        t2, 970582
                  auipc        t2, 970582
                  add          ra, t6, a1
                  sub          t6, t6, s8
                  addi         ra, s8, 1497
                  add          ra, t6, a1
                  addi         ra, s8, 1497
                  auipc        t2, 970582 #end riscv_int_numeric_corner_stream_0
                  li           s5, 0x80000000 #start riscv_int_numeric_corner_stream_14
                  li           s3, 0x80000000
                  li           s11, 0x80000000
                  li           t1, 0xffffffff
                  li           tp, 0x0
                  li           s10, 0x80000000
                  li           gp, 0x0
                  li           t6, 0xffffffff
                  li           s1, 0x907132a4
                  li           a7, 0x0
                  lui          s10, 79721
                  auipc        tp, 970582
                  addi         s3, a7, 1497
                  auipc        tp, 970582
                  auipc        tp, 970582
                  nop
                  add          s5, s11, gp
                  sub          t6, t6, a7
                  sub          t6, t6, a7
                  auipc        tp, 970582
                  lui          s10, 79721
                  sub          t6, t6, a7
                  nop
                  add          s5, s11, gp
                  sub          t6, t6, a7
                  lui          s10, 79721
                  sub          t6, t6, a7
                  add          s5, s11, gp
                  auipc        tp, 970582
                  addi         s3, a7, 1497 #end riscv_int_numeric_corner_stream_14
                  li           s10, 0xffffffff #start riscv_int_numeric_corner_stream_33
                  li           ra, 0xffffffff
                  li           a2, 0x83ccb4e9
                  li           a6, 0xffffffff
                  li           t6, 0x80000000
                  li           t2, 0x80000000
                  li           gp, 0xffffffff
                  li           tp, 0xffffffff
                  li           s5, 0x80000000
                  li           a5, 0x0
                  addi         tp, a6, 1497
                  sub          t6, t6, a6
                  auipc        tp, 970582
                  lui          a5, 79721
                  auipc        tp, 970582
                  add          ra, t6, gp
                  lui          a5, 79721
                  add          ra, t6, gp
                  add          ra, t6, gp
                  lui          a5, 79721
                  add          ra, t6, gp
                  add          ra, t6, gp
                  add          ra, t6, gp
                  nop
                  lui          a5, 79721
                  lui          a5, 79721
                  sub          t6, t6, a6
                  sub          t6, t6, a6
                  add          ra, t6, gp
                  lui          a5, 79721
                  nop
                  addi         tp, a6, 1497
                  nop
                  auipc        tp, 970582
                  sub          t6, t6, a6
                  addi         tp, a6, 1497 #end riscv_int_numeric_corner_stream_33
                  li           a7, 0x0 #start riscv_int_numeric_corner_stream_31
                  li           s10, 0x80000000
                  li           t6, 0xffffffff
                  li           s2, 0xffffffff
                  li           a6, 0xffffffff
                  li           t4, 0xffffffff
                  li           s9, 0xffffffff
                  li           s6, 0x0
                  li           a3, 0x5dd271b9
                  li           s1, 0x0
                  lui          t6, 79721
                  nop
                  sub          s9, a6, a6
                  auipc        a3, 970582
                  sub          s9, a6, a6
                  lui          t6, 79721
                  add          t6, s6, s1
                  lui          t6, 79721
                  add          t6, s6, s1
                  add          t6, s6, s1
                  nop
                  nop
                  lui          t6, 79721
                  add          t6, s6, s1
                  nop #end riscv_int_numeric_corner_stream_31
                  li           ra, 0xffffffff #start riscv_int_numeric_corner_stream_25
                  li           a4, 0x66ed822e
                  li           t0, 0x80000000
                  li           s3, 0xffffffff
                  li           s5, 0x9ee237fc
                  li           a2, 0xffffffff
                  li           a1, 0x0
                  li           s2, 0xffffffff
                  li           s9, 0xffffffff
                  li           s8, 0x80000000
                  nop
                  sub          a4, s9, s5
                  auipc        t0, 970582
                  addi         s2, ra, 1497
                  nop
                  auipc        t0, 970582
                  lui          a1, 79721
                  nop
                  lui          a1, 79721
                  auipc        t0, 970582
                  auipc        t0, 970582
                  nop
                  auipc        t0, 970582
                  lui          a1, 79721
                  auipc        t0, 970582
                  auipc        t0, 970582
                  lui          a1, 79721
                  addi         s2, ra, 1497
                  sub          a4, s9, s5 #end riscv_int_numeric_corner_stream_25
                  li           a7, 0x5f89d699 #start riscv_int_numeric_corner_stream_38
                  li           s3, 0x80000000
                  li           t1, 0x0
                  li           s9, 0x0
                  li           t6, 0x80000000
                  li           s6, 0x80000000
                  li           gp, 0xffffffff
                  li           tp, 0xffffffff
                  li           s0, 0x0
                  li           s11, 0xa83c5dfc
                  nop
                  lui          s11, 79721
                  lui          s11, 79721
                  add          s11, s11, gp
                  sub          a7, t6, a7
                  auipc        tp, 970582
                  sub          a7, t6, a7
                  lui          s11, 79721
                  auipc        tp, 970582
                  auipc        tp, 970582
                  addi         a7, a7, 1497
                  lui          s11, 79721
                  addi         a7, a7, 1497
                  lui          s11, 79721
                  lui          s11, 79721
                  addi         a7, a7, 1497
                  auipc        tp, 970582
                  sub          a7, t6, a7
                  nop
                  addi         a7, a7, 1497
                  sub          a7, t6, a7
                  add          s11, s11, gp
                  sub          a7, t6, a7 #end riscv_int_numeric_corner_stream_38
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  lui          a4, 79721
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  add          a2, s9, a1
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  lui          a4, 79721
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  lui          a4, 79721
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  lui          a4, 79721
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  nop
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  add          a2, s9, a1
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  nop
                  auipc        tp, 970582
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  or           s5, s9, a5
                  lui          a4, 79721
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  nop
                  nop
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  add          a2, s9, a1
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  nop
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  nop
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  or           s5, s9, a5
                  nop
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  lui          a4, 79721
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  lui          a4, 79721
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  lui          a4, 79721
                  nop
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  nop
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  nop
                  nop
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  lui          a4, 79721
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  nop
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  nop
                  nop
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  nop
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  andi         t2, t2, 1466
                  nop
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  lui          a4, 79721
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  lui          a4, 79721
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  nop
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  and          t1, ra, s2
                  lui          a4, 79721
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  lui          a4, 79721
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  nop
                  nop
                  lui          a4, 79721
                  and          t1, ra, s2
                  auipc        tp, 970582
                  lui          a4, 79721
                  nop
                  or           s5, s9, a5
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  and          t1, ra, s2
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  nop
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  nop
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  nop
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  auipc        tp, 970582
                  lui          a4, 79721
                  and          t1, ra, s2
                  auipc        tp, 970582
                  or           s5, s9, a5
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  lui          a4, 79721
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  lui          a4, 79721
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  add          a2, s9, a1
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  nop
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  lui          a4, 79721
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  nop
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  lui          a4, 79721
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  and          t1, ra, s2
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  nop
                  nop
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  nop
                  nop
                  add          a2, s9, a1
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  nop
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  nop
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  nop
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  lui          a4, 79721
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  nop
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  and          t1, ra, s2
                  nop
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  nop
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  nop
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  nop
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  lui          a4, 79721
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  nop
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  nop
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  nop
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  nop
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  nop
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  lui          a4, 79721
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  nop
                  nop
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  auipc        tp, 970582
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  nop
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  add          a2, s9, a1
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  nop
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  nop
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  or           s5, s9, a5
                  nop
                  nop
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  lui          a4, 79721
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  lui          a4, 79721
                  slt          s8, s8, a4
                  nop
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  nop
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  lui          a4, 79721
                  add          a2, s9, a1
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  nop
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  nop
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  nop
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  nop
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  nop
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  nop
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  nop
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  nop
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  nop
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  nop
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  nop
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  nop
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  nop
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  nop
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  nop
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  lui          a4, 79721
                  add          a2, s9, a1
                  auipc        tp, 970582
                  auipc        tp, 970582
                  and          t1, ra, s2
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  nop
                  or           s5, s9, a5
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  nop
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  nop
                  auipc        tp, 970582
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  nop
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  nop
                  addi         t1, a7, 1497
                  nop
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  nop
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  and          t1, ra, s2
                  add          a2, s9, a1
                  or           s5, s9, a5
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  nop
                  add          a2, s9, a1
                  nop
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  nop
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  lui          a4, 79721
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  nop
                  nop
                  nop
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  add          a2, s9, a1
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  nop
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  lui          a4, 79721
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  lui          a4, 79721
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  nop
                  and          t1, ra, s2
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  nop
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  lui          a4, 79721
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  nop
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  lui          a4, 79721
                  srl          s9, s1, s6
                  nop
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  nop
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  lui          a4, 79721
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  nop
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  lui          a4, 79721
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  nop
                  nop
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  auipc        tp, 970582
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  add          a2, s9, a1
                  nop
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  nop
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  lui          a4, 79721
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  nop
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  lui          a4, 79721
                  slt          s8, s8, a4
                  nop
                  nop
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_8
                  li           s9, 0xfdf01d5a
                  li           ra, 0xffffffff
                  li           t6, 0xffffffff
                  li           s3, 0x0
                  li           t3, 0xffffffff
                  li           t0, 0xffffffff
                  li           s2, 0xd618f648
                  li           s5, 0xffffffff
                  li           t5, 0x0
                  addi         s2, ra, 1497
                  addi         s2, ra, 1497
                  nop
                  auipc        t0, 970582
                  lui          s3, 79721
                  nop
                  auipc        t0, 970582
                  sub          ra, t6, s5
                  sub          ra, t6, s5
                  sub          ra, t6, s5
                  sub          ra, t6, s5
                  add          s11, t5, s3
                  auipc        t0, 970582
                  sub          ra, t6, s5
                  nop
                  add          s11, t5, s3
                  add          s11, t5, s3
                  lui          s3, 79721
                  sub          ra, t6, s5
                  add          s11, t5, s3
                  add          s11, t5, s3
                  nop
                  add          s11, t5, s3
                  lui          s3, 79721
                  nop
                  nop
                  lui          s3, 79721
                  lui          s3, 79721 #end riscv_int_numeric_corner_stream_8
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  lui          a4, 79721
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  nop
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  nop
                  nop
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  nop
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  lui          a4, 79721
                  add          a2, s9, a1
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  lui          a4, 79721
                  nop
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  nop
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  lui          a4, 79721
                  srli         s6, s6, 10
                  nop
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  nop
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  nop
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  nop
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  nop
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  nop
                  lui          a4, 79721
                  nop
                  srl          s9, s1, s6
                  nop
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  nop
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  and          t1, ra, s2
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  lui          a4, 79721
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  or           s5, s9, a5
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  nop
                  xori         t0, s11, -1854
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  nop
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  lui          a4, 79721
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  lui          a4, 79721
                  nop
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  ori          t0, a2, 1565
                  nop
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  nop
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  auipc        tp, 970582
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  lui          a4, 79721
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  nop
                  andi         t2, t2, 1466
                  nop
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  nop
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  lui          a4, 79721
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  nop
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  nop
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  lui          a4, 79721
                  sll          a3, s5, s5
                  nop
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  nop
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  nop
                  slti         s8, a1, -205
                  lui          a4, 79721
                  sll          a3, s5, s5
                  nop
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  nop
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  or           s5, s9, a5
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  nop
                  add          a2, s9, a1
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  nop
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  nop
                  srli         s6, s6, 10
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  or           s5, s9, a5
                  lui          a4, 79721
                  lui          a4, 79721
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  nop
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  li           t2, 0xffffffff #start riscv_int_numeric_corner_stream_19
                  li           t4, 0x55f3b4cd
                  li           a5, 0x3f5c26a4
                  li           s6, 0xffffffff
                  li           a4, 0x80000000
                  li           t5, 0x80000000
                  li           s5, 0xffffffff
                  li           t0, 0x0
                  li           s0, 0xffffffff
                  li           a0, 0x80000000
                  add          s6, t4, t4
                  nop
                  add          s6, t4, t4
                  addi         s0, t0, 1497
                  auipc        t0, 970582
                  auipc        t0, 970582
                  addi         s0, t0, 1497
                  auipc        t0, 970582
                  add          s6, t4, t4
                  lui          a4, 79721
                  addi         s0, t0, 1497
                  addi         s0, t0, 1497
                  add          s6, t4, t4
                  sub          a5, t5, s5
                  nop
                  add          s6, t4, t4
                  lui          a4, 79721
                  sub          a5, t5, s5
                  add          s6, t4, t4
                  nop
                  nop
                  addi         s0, t0, 1497
                  nop
                  add          s6, t4, t4 #end riscv_int_numeric_corner_stream_19
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  add          a2, s9, a1
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  nop
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  nop
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  nop
                  xori         t0, s11, -1854
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  nop
                  or           s5, s9, a5
                  nop
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  nop
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  nop
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  nop
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  nop
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  nop
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  nop
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  lui          a4, 79721
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  nop
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  nop
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  nop
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  nop
                  nop
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  nop
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  nop
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  nop
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  nop
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  or           s5, s9, a5
                  nop
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  nop
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  or           s5, s9, a5
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  nop
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  nop
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  lui          a4, 79721
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  nop
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  nop
                  sltiu        gp, s8, 628
                  add          a2, s9, a1
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  nop
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  li           a6, 0x0 #start riscv_int_numeric_corner_stream_29
                  li           a5, 0x0
                  li           t3, 0xffffffff
                  li           t1, 0x0
                  li           s6, 0x0
                  li           s1, 0xffffffff
                  li           s2, 0x80000000
                  li           t5, 0xd7ae345c
                  li           t0, 0xa8a63e5e
                  li           t6, 0xffffffff
                  sub          t0, t6, a6
                  sub          t0, t6, a6
                  auipc        t1, 970582
                  lui          a5, 79721
                  nop
                  add          s2, t6, s1
                  auipc        t1, 970582
                  nop
                  add          s2, t6, s1
                  lui          a5, 79721
                  sub          t0, t6, a6
                  addi         a6, a6, 1497
                  lui          a5, 79721
                  sub          t0, t6, a6
                  sub          t0, t6, a6
                  lui          a5, 79721
                  auipc        t1, 970582 #end riscv_int_numeric_corner_stream_29
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  nop
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  nop
                  addi         t1, a7, 1497
                  nop
                  or           s5, s9, a5
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  nop
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  and          t1, ra, s2
                  or           s5, s9, a5
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  xor          a7, t0, s3
                  nop
                  ori          t0, a2, 1565
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  nop
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  add          a2, s9, a1
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  add          a2, s9, a1
                  nop
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  lui          a4, 79721
                  slli         s10, a0, 0
                  lui          a4, 79721
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  lui          a4, 79721
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  nop
                  srl          s9, s1, s6
                  nop
                  srai         ra, s0, 9
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  lui          a4, 79721
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  nop
                  nop
                  add          a2, s9, a1
                  auipc        tp, 970582
                  nop
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  nop
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  nop
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  lui          a4, 79721
                  nop
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  nop
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  lui          a4, 79721
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  auipc        tp, 970582
                  add          a2, s9, a1
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  lui          a4, 79721
                  lui          a4, 79721
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  auipc        tp, 970582
                  or           s5, s9, a5
                  or           s5, s9, a5
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  nop
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  lui          a4, 79721
                  or           s5, s9, a5
                  lui          a4, 79721
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  add          a2, s9, a1
                  nop
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  nop
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  lui          a4, 79721
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  nop
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  lui          a4, 79721
                  srl          s9, s1, s6
                  lui          a4, 79721
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  or           s5, s9, a5
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  nop
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  lui          a4, 79721
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  lui          a4, 79721
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  nop
                  add          a2, s9, a1
                  or           s5, s9, a5
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  nop
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  nop
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  nop
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  lui          a4, 79721
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  nop
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  nop
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  auipc        tp, 970582
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  nop
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  nop
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  nop
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  nop
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  nop
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  nop
                  nop
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  or           s5, s9, a5
                  nop
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  nop
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  nop
                  slli         s10, a0, 0
                  nop
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  lui          a4, 79721
                  nop
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  nop
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  nop
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  add          a2, s9, a1
                  nop
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  lui          a4, 79721
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  nop
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  nop
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  lui          a4, 79721
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  nop
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  lui          a4, 79721
                  nop
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  or           s5, s9, a5
                  nop
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  lui          a4, 79721
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  nop
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  nop
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  nop
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  nop
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  lui          a4, 79721
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  nop
                  nop
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  li           a6, 0xf8473187 #start riscv_int_numeric_corner_stream_13
                  li           s0, 0xffffffff
                  li           s11, 0xbde4a063
                  li           gp, 0x0
                  li           a5, 0xffffffff
                  li           a3, 0x0
                  li           t2, 0x197c12cb
                  li           s8, 0x80000000
                  li           ra, 0xffffffff
                  li           s6, 0xffffffff
                  add          s11, a5, gp
                  nop
                  add          s11, a5, gp
                  add          s11, a5, gp
                  nop
                  sub          t2, s11, a6
                  addi         a6, a6, 1497
                  add          s11, a5, gp
                  addi         a6, a6, 1497
                  add          s11, a5, gp
                  auipc        a3, 970582
                  lui          a5, 79721
                  auipc        a3, 970582
                  sub          t2, s11, a6
                  lui          a5, 79721
                  lui          a5, 79721
                  lui          a5, 79721
                  auipc        a3, 970582 #end riscv_int_numeric_corner_stream_13
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  lui          a4, 79721
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  nop
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  nop
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  lui          a4, 79721
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  nop
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  nop
                  xor          a7, t0, s3
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  nop
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  nop
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  nop
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  nop
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  nop
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  nop
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  nop
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  lui          a4, 79721
                  sub          a2, a7, s4
                  nop
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  nop
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  lui          a4, 79721
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  nop
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  nop
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  lui          a4, 79721
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  nop
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  nop
                  auipc        tp, 970582
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  nop
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  lui          a4, 79721
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  nop
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  or           s5, s9, a5
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  lui          a4, 79721
                  nop
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  and          t1, ra, s2
                  or           s5, s9, a5
                  or           s5, s9, a5
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  auipc        tp, 970582
                  nop
                  and          t1, ra, s2
                  or           s5, s9, a5
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  nop
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  nop
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  nop
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  nop
                  srli         s6, s6, 10
                  nop
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  nop
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  lui          a4, 79721
                  nop
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  nop
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  lui          a4, 79721
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  nop
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  nop
                  sra          s5, a1, a6
                  nop
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  nop
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  lui          a4, 79721
                  lui          a4, 79721
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  lui          a4, 79721
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  nop
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  nop
                  or           s5, s9, a5
                  nop
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  nop
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  lui          a4, 79721
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  nop
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  nop
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  nop
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  and          t1, ra, s2
                  and          t1, ra, s2
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  nop
                  sub          a2, a7, s4
                  lui          a4, 79721
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  or           s5, s9, a5
                  nop
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  nop
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  lui          a4, 79721
                  sub          a2, a7, s4
                  lui          a4, 79721
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  lui          a4, 79721
                  nop
                  slti         s8, a1, -205
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  or           s5, s9, a5
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  nop
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  nop
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  nop
                  auipc        tp, 970582
                  lui          a4, 79721
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  nop
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  nop
                  and          t1, ra, s2
                  lui          a4, 79721
                  xor          a7, t0, s3
                  nop
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  nop
                  srli         s6, s6, 10
                  lui          a4, 79721
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  and          t1, ra, s2
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  nop
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  lui          a4, 79721
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  nop
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  nop
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  nop
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  nop
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  nop
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  add          a2, s9, a1
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  nop
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  lui          a4, 79721
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  nop
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  and          t1, ra, s2
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  lui          a4, 79721
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  nop
                  slt          s8, s8, a4
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  nop
                  lui          a4, 79721
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  nop
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  lui          a4, 79721
                  srl          s9, s1, s6
                  lui          a4, 79721
                  nop
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  nop
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  nop
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  nop
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  nop
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  nop
                  sra          s5, a1, a6
                  lui          a4, 79721
                  auipc        tp, 970582
                  lui          a4, 79721
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  nop
                  lui          a4, 79721
                  auipc        tp, 970582
                  lui          a4, 79721
                  lui          a4, 79721
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  lui          a4, 79721
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  add          a2, s9, a1
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  add          a2, s9, a1
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  nop
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  nop
                  nop
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  lui          a4, 79721
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  nop
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  nop
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  nop
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  or           s5, s9, a5
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  nop
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  srli         s6, s6, 10
                  nop
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  nop
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  lui          a4, 79721
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  nop
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  and          t1, ra, s2
                  lui          a4, 79721
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  nop
                  auipc        tp, 970582
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  nop
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  nop
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  and          t1, ra, s2
                  or           s5, s9, a5
                  nop
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  nop
                  nop
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  nop
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  nop
                  sra          s5, a1, a6
                  nop
                  and          t1, ra, s2
                  and          t1, ra, s2
                  nop
                  nop
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  nop
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  auipc        tp, 970582
                  nop
                  nop
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  nop
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  nop
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  nop
                  nop
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  nop
                  nop
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  lui          a4, 79721
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  nop
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  lui          a4, 79721
                  and          t1, ra, s2
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  lui          a4, 79721
                  nop
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  lui          a4, 79721
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  lui          a4, 79721
                  srai         ra, s0, 9
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  nop
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  nop
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  nop
                  andi         t2, t2, 1466
                  nop
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  nop
                  sra          s5, a1, a6
                  lui          a4, 79721
                  xor          a7, t0, s3
                  lui          a4, 79721
                  or           s5, s9, a5
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  lui          a4, 79721
                  nop
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  nop
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  nop
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  nop
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  nop
                  auipc        tp, 970582
                  lui          a4, 79721
                  or           s5, s9, a5
                  and          t1, ra, s2
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  lui          a4, 79721
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  nop
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  nop
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  lui          a4, 79721
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  ori          t0, a2, 1565
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  lui          a4, 79721
                  and          t1, ra, s2
                  lui          a4, 79721
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  lui          a4, 79721
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  nop
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  lui          a4, 79721
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  nop
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  nop
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  nop
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  nop
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  nop
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  lui          a4, 79721
                  and          t1, ra, s2
                  nop
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  lui          a4, 79721
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  add          a2, s9, a1
                  nop
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  nop
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  nop
                  nop
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  lui          a4, 79721
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  or           s5, s9, a5
                  and          t1, ra, s2
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  nop
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  lui          a4, 79721
                  nop
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  nop
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  lui          a4, 79721
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  nop
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  nop
                  nop
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  auipc        tp, 970582
                  nop
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  nop
                  sra          s5, a1, a6
                  nop
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  nop
                  srl          s9, s1, s6
                  nop
                  srl          s9, s1, s6
                  nop
                  srai         ra, s0, 9
                  nop
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  or           s5, s9, a5
                  and          t1, ra, s2
                  or           s5, s9, a5
                  add          a2, s9, a1
                  or           s5, s9, a5
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  nop
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  nop
                  nop
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  lui          a4, 79721
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  lui          a4, 79721
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  nop
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  nop
                  and          t1, ra, s2
                  lui          a4, 79721
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  nop
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  nop
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  nop
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  lui          a4, 79721
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  lui          a4, 79721
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  nop
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  nop
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  and          t1, ra, s2
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  nop
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  nop
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  lui          a4, 79721
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  nop
                  sll          a3, s5, s5
                  lui          a4, 79721
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  lui          a4, 79721
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  nop
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  nop
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  nop
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  lui          a4, 79721
                  auipc        tp, 970582
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  nop
                  li           t6, 0x0 #start riscv_int_numeric_corner_stream_24
                  li           s8, 0x882787b7
                  li           s0, 0x80000000
                  li           t2, 0x3eb095c1
                  li           s5, 0x0
                  li           a3, 0x0
                  li           ra, 0x0
                  li           s11, 0x0
                  li           a2, 0xb9bebc0d
                  li           a4, 0xffffffff
                  add          s11, t6, s11
                  addi         ra, ra, 1497
                  addi         ra, ra, 1497
                  auipc        t2, 970582
                  lui          a4, 79721
                  lui          a4, 79721
                  auipc        t2, 970582
                  add          s11, t6, s11
                  nop
                  sub          t6, t6, s5
                  auipc        t2, 970582
                  add          s11, t6, s11
                  addi         ra, ra, 1497
                  add          s11, t6, s11
                  nop
                  add          s11, t6, s11
                  lui          a4, 79721
                  auipc        t2, 970582
                  auipc        t2, 970582
                  lui          a4, 79721
                  addi         ra, ra, 1497
                  auipc        t2, 970582 #end riscv_int_numeric_corner_stream_24
                  sra          s5, a1, a6
                  nop
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  lui          a4, 79721
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  nop
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  lui          a4, 79721
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  lui          a4, 79721
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  nop
                  nop
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  li           t1, 0x0 #start riscv_int_numeric_corner_stream_12
                  li           s11, 0xffffffff
                  li           t4, 0x80000000
                  li           ra, 0xad4f16af
                  li           s9, 0x80000000
                  li           a0, 0xffffffff
                  li           s8, 0x0
                  li           s5, 0xbf7a5bba
                  li           s10, 0xffffffff
                  li           t2, 0x80000000
                  lui          a0, 79721
                  nop
                  addi         ra, ra, 1497
                  add          s11, t4, s11
                  nop
                  nop
                  nop
                  addi         ra, ra, 1497
                  lui          a0, 79721
                  lui          a0, 79721
                  sub          t2, t4, s5
                  lui          a0, 79721
                  add          s11, t4, s11
                  auipc        t1, 970582
                  add          s11, t4, s11 #end riscv_int_numeric_corner_stream_12
                  srai         ra, s0, 9
                  lui          a4, 79721
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  nop
                  nop
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  lui          a4, 79721
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  add          a2, s9, a1
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  nop
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  nop
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  nop
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  auipc        tp, 970582
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  nop
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  nop
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  nop
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  nop
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  nop
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  nop
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  nop
                  or           s5, s9, a5
                  or           s5, s9, a5
                  auipc        tp, 970582
                  auipc        tp, 970582
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  lui          a4, 79721
                  lui          a4, 79721
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  li           s6, 0x0 #start riscv_int_numeric_corner_stream_5
                  li           s5, 0x80000000
                  li           t3, 0x4302a57d
                  li           ra, 0x0
                  li           t5, 0xffffffff
                  li           t6, 0x80000000
                  li           a1, 0x0
                  li           s0, 0xc84e662
                  li           t1, 0x88bd733
                  li           a7, 0x0
                  auipc        t1, 970582
                  lui          a1, 79721
                  addi         s0, a7, 1497
                  auipc        t1, 970582
                  auipc        t1, 970582
                  auipc        t1, 970582
                  lui          a1, 79721
                  nop
                  lui          a1, 79721
                  nop
                  nop
                  sub          ra, s0, a7
                  nop
                  sub          ra, s0, a7
                  sub          ra, s0, a7
                  sub          ra, s0, a7
                  addi         s0, a7, 1497
                  lui          a1, 79721
                  add          t6, t6, a1
                  lui          a1, 79721
                  add          t6, t6, a1
                  addi         s0, a7, 1497
                  add          t6, t6, a1
                  sub          ra, s0, a7
                  sub          ra, s0, a7
                  nop
                  lui          a1, 79721
                  add          t6, t6, a1
                  sub          ra, s0, a7
                  addi         s0, a7, 1497 #end riscv_int_numeric_corner_stream_5
                  auipc        tp, 970582
                  or           s5, s9, a5
                  lui          a4, 79721
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  nop
                  nop
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  nop
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  nop
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  nop
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  nop
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  nop
                  slt          s8, s8, a4
                  lui          a4, 79721
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  lui          a4, 79721
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  and          t1, ra, s2
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  nop
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  nop
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  nop
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  lui          a4, 79721
                  nop
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  nop
                  lui          a4, 79721
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  nop
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  auipc        tp, 970582
                  or           s5, s9, a5
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  nop
                  sll          a3, s5, s5
                  nop
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  nop
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  lui          a4, 79721
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  lui          a4, 79721
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  nop
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  lui          a4, 79721
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  nop
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  nop
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  add          a2, s9, a1
                  or           s5, s9, a5
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  lui          a4, 79721
                  nop
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  nop
                  ori          t0, a2, 1565
                  nop
                  srl          s9, s1, s6
                  nop
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  sll          a3, s5, s5
                  nop
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  nop
                  and          t1, ra, s2
                  and          t1, ra, s2
                  nop
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  nop
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  lui          a4, 79721
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  nop
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  auipc        tp, 970582
                  and          t1, ra, s2
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  nop
                  add          a2, s9, a1
                  auipc        tp, 970582
                  lui          a4, 79721
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  nop
                  lui          a4, 79721
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  nop
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  nop
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  lui          a4, 79721
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  lui          a4, 79721
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  nop
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  nop
                  lui          a4, 79721
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  nop
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  nop
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  li           s3, 0x0 #start riscv_int_numeric_corner_stream_18
                  li           t4, 0x8deda2be
                  li           a7, 0x8eeaaeac
                  li           ra, 0x0
                  li           t6, 0x80000000
                  li           t5, 0xcdc0ed67
                  li           t3, 0x80000000
                  li           a0, 0xffffffff
                  li           s0, 0x281d107b
                  li           s5, 0xffffffff
                  sub          ra, s0, a7
                  lui          a0, 79721
                  auipc        s5, 970582
                  addi         s0, a7, 1497
                  nop
                  add          s3, a0, s3
                  sub          ra, s0, a7
                  add          s3, a0, s3
                  nop
                  add          s3, a0, s3
                  lui          a0, 79721
                  nop
                  nop
                  add          s3, a0, s3
                  add          s3, a0, s3
                  nop
                  add          s3, a0, s3
                  nop
                  add          s3, a0, s3
                  sub          ra, s0, a7
                  auipc        s5, 970582
                  nop
                  sub          ra, s0, a7 #end riscv_int_numeric_corner_stream_18
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  auipc        tp, 970582
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  or           s5, s9, a5
                  nop
                  add          a2, s9, a1
                  nop
                  or           s5, s9, a5
                  nop
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  lui          a4, 79721
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  nop
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  nop
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  nop
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  nop
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  or           s5, s9, a5
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  nop
                  lui          a4, 79721
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  nop
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  nop
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  lui          a4, 79721
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  nop
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  nop
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  lui          a4, 79721
                  srli         s6, s6, 10
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  add          a2, s9, a1
                  auipc        tp, 970582
                  and          t1, ra, s2
                  nop
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  li           t3, 0x1d20db27 #start riscv_int_numeric_corner_stream_7
                  li           ra, 0x80000000
                  li           a1, 0x4fa495f2
                  li           a3, 0x0
                  li           s5, 0xffffffff
                  li           a7, 0x82953eac
                  li           s11, 0xffffffff
                  li           a0, 0xffffffff
                  li           a5, 0xee51c375
                  li           a2, 0xffffffff
                  add          s5, a5, a1
                  sub          a5, a0, a7
                  sub          a5, a0, a7
                  add          s5, a5, a1
                  sub          a5, a0, a7
                  add          s5, a5, a1
                  auipc        a2, 970582
                  lui          a1, 79721
                  addi         a0, a7, 1497
                  lui          a1, 79721
                  nop
                  nop
                  nop
                  add          s5, a5, a1
                  sub          a5, a0, a7
                  add          s5, a5, a1
                  auipc        a2, 970582
                  auipc        a2, 970582
                  lui          a1, 79721
                  lui          a1, 79721
                  addi         a0, a7, 1497
                  auipc        a2, 970582
                  sub          a5, a0, a7
                  nop #end riscv_int_numeric_corner_stream_7
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  nop
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  nop
                  slti         s8, a1, -205
                  lui          a4, 79721
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  lui          a4, 79721
                  nop
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  lui          a4, 79721
                  nop
                  and          t1, ra, s2
                  nop
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  nop
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  and          t1, ra, s2
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  lui          a4, 79721
                  and          t1, ra, s2
                  nop
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  nop
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  nop
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  nop
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  nop
                  nop
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  nop
                  slt          s8, s8, a4
                  lui          a4, 79721
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  and          t1, ra, s2
                  add          a2, s9, a1
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  nop
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  lui          a4, 79721
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  lui          a4, 79721
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  lui          a4, 79721
                  nop
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  nop
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  lui          a4, 79721
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  lui          a4, 79721
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  and          t1, ra, s2
                  nop
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  nop
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  nop
                  and          t1, ra, s2
                  auipc        tp, 970582
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  auipc        tp, 970582
                  nop
                  auipc        tp, 970582
                  auipc        tp, 970582
                  nop
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  nop
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  nop
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  nop
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  nop
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  nop
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  nop
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  nop
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  lui          a4, 79721
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  nop
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  nop
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  nop
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  li           t5, 0xffffffff #start riscv_int_numeric_corner_stream_27
                  li           t4, 0x0
                  li           s0, 0x4ac277a7
                  li           a6, 0x80000000
                  li           a4, 0xffffffff
                  li           s8, 0x80000000
                  li           t1, 0xb2209d28
                  li           a0, 0xfc1e5721
                  li           gp, 0x80000000
                  li           s3, 0xffffffff
                  add          gp, t4, s3
                  auipc        t1, 970582
                  lui          a0, 79721
                  sub          t4, t4, a6
                  lui          a0, 79721
                  nop
                  add          gp, t4, s3
                  sub          t4, t4, a6
                  auipc        t1, 970582
                  lui          a0, 79721
                  nop
                  nop
                  lui          a0, 79721
                  addi         t1, a6, 1497
                  lui          a0, 79721
                  sub          t4, t4, a6
                  nop
                  auipc        t1, 970582
                  add          gp, t4, s3
                  auipc        t1, 970582
                  sub          t4, t4, a6
                  add          gp, t4, s3
                  sub          t4, t4, a6
                  nop
                  sub          t4, t4, a6
                  nop
                  lui          a0, 79721
                  add          gp, t4, s3
                  lui          a0, 79721 #end riscv_int_numeric_corner_stream_27
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  nop
                  nop
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  nop
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  nop
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  auipc        tp, 970582
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  nop
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  nop
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  nop
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  or           s5, s9, a5
                  nop
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  srli         s6, s6, 10
                  nop
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  or           s5, s9, a5
                  nop
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  lui          a4, 79721
                  nop
                  and          t1, ra, s2
                  nop
                  srli         s6, s6, 10
                  nop
                  lui          a4, 79721
                  or           s5, s9, a5
                  nop
                  srai         ra, s0, 9
                  nop
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  nop
                  xor          a7, t0, s3
                  nop
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  nop
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  nop
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  slti         s8, a1, -205
                  nop
                  nop
                  and          t1, ra, s2
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  nop
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  lui          a4, 79721
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  auipc        tp, 970582
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  nop
                  addi         t1, a7, 1497
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  nop
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  lui          a4, 79721
                  or           s5, s9, a5
                  lui          a4, 79721
                  nop
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  nop
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  nop
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  nop
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  lui          a4, 79721
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  nop
                  nop
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  nop
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  lui          a4, 79721
                  or           s5, s9, a5
                  and          t1, ra, s2
                  and          t1, ra, s2
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  lui          a4, 79721
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  nop
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  nop
                  and          t1, ra, s2
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  nop
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  nop
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  nop
                  sra          s5, a1, a6
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  nop
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  nop
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  nop
                  addi         t1, a7, 1497
                  nop
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  nop
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  nop
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  nop
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  and          t1, ra, s2
                  auipc        tp, 970582
                  nop
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  nop
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  nop
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  nop
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  nop
                  lui          a4, 79721
                  nop
                  add          a2, s9, a1
                  lui          a4, 79721
                  and          t1, ra, s2
                  and          t1, ra, s2
                  lui          a4, 79721
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  nop
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  nop
                  auipc        tp, 970582
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  nop
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  nop
                  lui          a4, 79721
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  add          a2, s9, a1
                  nop
                  lui          a4, 79721
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  nop
                  sltu         s0, a6, sp
                  nop
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  nop
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  and          t1, ra, s2
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  or           s5, s9, a5
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  nop
                  or           s5, s9, a5
                  lui          a4, 79721
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  nop
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  li           s0, 0x0 #start riscv_int_numeric_corner_stream_22
                  li           t6, 0x28ba971b
                  li           gp, 0x80000000
                  li           a6, 0xc61ffd21
                  li           t1, 0x0
                  li           s10, 0xa01d06d6
                  li           t2, 0x0
                  li           s8, 0x0
                  li           a0, 0x80000000
                  li           t4, 0x0
                  sub          t4, t6, a6
                  nop
                  nop
                  addi         t1, a6, 1497
                  sub          t4, t6, a6
                  lui          a0, 79721
                  auipc        t1, 970582
                  auipc        t1, 970582
                  add          s8, t1, gp
                  add          s8, t1, gp
                  nop
                  auipc        t1, 970582
                  auipc        t1, 970582
                  auipc        t1, 970582
                  auipc        t1, 970582 #end riscv_int_numeric_corner_stream_22
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  or           s5, s9, a5
                  nop
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  lui          a4, 79721
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  nop
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  nop
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  lui          a4, 79721
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  nop
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  nop
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  lui          a4, 79721
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  nop
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  nop
                  add          a2, s9, a1
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  nop
                  sltu         s0, a6, sp
                  nop
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  lui          a4, 79721
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  nop
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  lui          a4, 79721
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  nop
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  lui          a4, 79721
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  nop
                  and          t1, ra, s2
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  nop
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  lui          a4, 79721
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  nop
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  add          a2, s9, a1
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  nop
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  nop
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  nop
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  nop
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  or           s5, s9, a5
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  lui          a4, 79721
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  lui          a4, 79721
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  and          t1, ra, s2
                  nop
                  nop
                  nop
                  nop
                  sll          a3, s5, s5
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  nop
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  nop
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  nop
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  nop
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  nop
                  sub          a2, a7, s4
                  lui          a4, 79721
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  lui          a4, 79721
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  nop
                  xor          a7, t0, s3
                  nop
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  nop
                  sra          s5, a1, a6
                  li           t1, 0x80000000 #start riscv_int_numeric_corner_stream_9
                  li           t2, 0x80000000
                  li           a4, 0xffffffff
                  li           gp, 0x1955f4f
                  li           s2, 0x6dc1dba8
                  li           ra, 0x80000000
                  li           s9, 0x80000000
                  li           t4, 0xffffffff
                  li           a7, 0xa2798c3f
                  li           s1, 0x0
                  add          ra, t4, gp
                  nop
                  sub          t2, t4, a7
                  addi         t1, a7, 1497
                  auipc        t1, 970582
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  auipc        t1, 970582
                  add          ra, t4, gp
                  add          ra, t4, gp
                  add          ra, t4, gp
                  sub          t2, t4, a7
                  auipc        t1, 970582
                  sub          t2, t4, a7
                  sub          t2, t4, a7
                  auipc        t1, 970582
                  lui          a4, 79721
                  sub          t2, t4, a7
                  sub          t2, t4, a7
                  auipc        t1, 970582
                  add          ra, t4, gp
                  addi         t1, a7, 1497
                  nop
                  add          ra, t4, gp
                  lui          a4, 79721
                  nop
                  auipc        t1, 970582
                  addi         t1, a7, 1497 #end riscv_int_numeric_corner_stream_9
                  nop
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  nop
                  and          t1, ra, s2
                  add          a2, s9, a1
                  slt          s8, s8, a4
                  li           s1, 0x802442d0 #start riscv_int_numeric_corner_stream_26
                  li           t0, 0x96960b58
                  li           a6, 0x80000000
                  li           a3, 0x80000000
                  li           t2, 0x0
                  li           s6, 0xffffffff
                  li           s2, 0xffffffff
                  li           ra, 0x86808a5
                  li           a5, 0xec2d035b
                  li           t1, 0xffffffff
                  addi         t1, a6, 1497
                  addi         t1, a6, 1497
                  sub          t0, s1, a6
                  nop
                  lui          a5, 79721
                  auipc        t1, 970582
                  nop
                  auipc        t1, 970582
                  nop
                  auipc        t1, 970582
                  addi         t1, a6, 1497
                  auipc        t1, 970582
                  lui          a5, 79721
                  addi         t1, a6, 1497
                  auipc        t1, 970582
                  add          ra, a5, t0
                  lui          a5, 79721
                  sub          t0, s1, a6
                  sub          t0, s1, a6
                  nop
                  auipc        t1, 970582
                  add          ra, a5, t0 #end riscv_int_numeric_corner_stream_26
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  nop
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  lui          a4, 79721
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  nop
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  nop
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  li           ra, 0xffffffff #start riscv_int_numeric_corner_stream_15
                  li           a3, 0xffffffff
                  li           s10, 0x0
                  li           s5, 0x0
                  li           s8, 0xffffffff
                  li           gp, 0x0
                  li           t6, 0xffffffff
                  li           t0, 0xa90598fb
                  li           s2, 0x80000000
                  li           tp, 0x80000000
                  lui          s10, 79721
                  add          ra, t6, gp
                  addi         s2, ra, 1497
                  lui          s10, 79721
                  add          ra, t6, gp
                  sub          t6, t6, s5
                  sub          t6, t6, s5
                  addi         s2, ra, 1497
                  addi         s2, ra, 1497
                  nop
                  auipc        tp, 970582
                  nop
                  nop
                  auipc        tp, 970582
                  auipc        tp, 970582
                  nop #end riscv_int_numeric_corner_stream_15
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  nop
                  lui          a4, 79721
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  nop
                  nop
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  nop
                  slt          s8, s8, a4
                  andi         t2, t2, 1466
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  nop
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  nop
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  nop
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  nop
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  nop
                  slti         s8, a1, -205
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  lui          a4, 79721
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  nop
                  lui          a4, 79721
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  lui          a4, 79721
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  lui          a4, 79721
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  nop
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  add          a2, s9, a1
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  nop
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  lui          a4, 79721
                  and          t1, ra, s2
                  or           s5, s9, a5
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  nop
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  nop
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  nop
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  nop
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  and          t1, ra, s2
                  or           s5, s9, a5
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  nop
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  nop
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  and          t1, ra, s2
                  nop
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  nop
                  slt          s8, s8, a4
                  nop
                  and          t1, ra, s2
                  and          t1, ra, s2
                  add          a2, s9, a1
                  nop
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  nop
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  or           s5, s9, a5
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  lui          a4, 79721
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  add          a2, s9, a1
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  nop
                  sub          a2, a7, s4
                  xor          a7, t0, s3
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  nop
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  nop
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  nop
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  lui          a4, 79721
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  nop
                  lui          a4, 79721
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  nop
                  add          a2, s9, a1
                  nop
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  lui          a4, 79721
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  nop
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  nop
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  nop
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  nop
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  nop
                  and          t1, ra, s2
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  sra          s5, a1, a6
                  nop
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  nop
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  add          a2, s9, a1
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  addi         t1, a7, 1497
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  nop
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  sll          a3, s5, s5
                  nop
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  nop
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  add          a2, s9, a1
                  add          a2, s9, a1
                  or           s5, s9, a5
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  nop
                  xor          a7, t0, s3
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  srai         ra, s0, 9
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  nop
                  lui          a4, 79721
                  srl          s9, s1, s6
                  nop
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  or           s5, s9, a5
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  nop
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  lui          a4, 79721
                  nop
                  add          a2, s9, a1
                  lui          a4, 79721
                  nop
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  slti         s8, a1, -205
                  nop
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  srl          s9, s1, s6
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  lui          a4, 79721
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_10
                  li           t2, 0x80000000
                  li           s11, 0xffffffff
                  li           t5, 0x80000000
                  li           t6, 0xffffffff
                  li           a4, 0xb2114fb1
                  li           s10, 0x619e9ea9
                  li           a3, 0x80000000
                  li           t3, 0xb02fc84e
                  li           s8, 0x77927ec6
                  sub          a3, t6, s8
                  auipc        t2, 970582
                  nop
                  sub          a3, t6, s8
                  sub          a3, t6, s8
                  lui          a4, 79721
                  nop
                  addi         s8, s8, 1497
                  auipc        t2, 970582
                  addi         s8, s8, 1497
                  auipc        t2, 970582
                  sub          a3, t6, s8
                  auipc        t2, 970582
                  lui          a4, 79721
                  nop #end riscv_int_numeric_corner_stream_10
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  nop
                  nop
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  lui          a4, 79721
                  or           s5, s9, a5
                  nop
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  nop
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  nop
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  lui          a4, 79721
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  lui          a4, 79721
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  nop
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  nop
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  lui          a4, 79721
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  slti         s8, a1, -205
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  li           t0, 0x80000000 #start riscv_int_numeric_corner_stream_28
                  li           a0, 0x0
                  li           ra, 0xffffffff
                  li           a3, 0x7245e9dc
                  li           s3, 0xffffffff
                  li           t2, 0xccc8977a
                  li           s2, 0xf7de8e9f
                  li           t6, 0x0
                  li           t1, 0x0
                  li           gp, 0xffffffff
                  lui          a0, 79721
                  sub          t0, a0, a3
                  lui          a0, 79721
                  sub          t0, a0, a3
                  sub          t0, a0, a3
                  nop
                  addi         s2, ra, 1497
                  nop
                  addi         s2, ra, 1497
                  nop
                  nop
                  nop
                  add          t6, a0, gp
                  addi         s2, ra, 1497
                  lui          a0, 79721
                  lui          a0, 79721
                  lui          a0, 79721
                  sub          t0, a0, a3
                  addi         s2, ra, 1497
                  lui          a0, 79721
                  addi         s2, ra, 1497
                  auipc        t1, 970582
                  addi         s2, ra, 1497
                  sub          t0, a0, a3
                  nop
                  auipc        t1, 970582
                  sub          t0, a0, a3
                  addi         s2, ra, 1497
                  nop
                  lui          a0, 79721 #end riscv_int_numeric_corner_stream_28
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  nop
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  auipc        tp, 970582
                  li           a1, 0x0 #start riscv_int_numeric_corner_stream_11
                  li           a7, 0x69bf8eef
                  li           ra, 0x6fdf7b70
                  li           a3, 0xffffffff
                  li           s5, 0x0
                  li           s8, 0xffffffff
                  li           s9, 0xffffffff
                  li           t1, 0xffffffff
                  li           a6, 0x0
                  li           t6, 0x78c04b66
                  add          t6, t6, a1
                  nop
                  add          t6, t6, a1
                  sub          ra, a6, a6
                  auipc        t1, 970582
                  nop
                  auipc        t1, 970582
                  add          t6, t6, a1
                  add          t6, t6, a1
                  add          t6, t6, a1
                  auipc        t1, 970582
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  sub          ra, a6, a6
                  addi         t1, a7, 1497
                  addi         t1, a7, 1497
                  sub          ra, a6, a6
                  sub          ra, a6, a6
                  lui          a1, 79721
                  sub          ra, a6, a6
                  add          t6, t6, a1
                  nop
                  sub          ra, a6, a6 #end riscv_int_numeric_corner_stream_11
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  nop
                  or           s5, s9, a5
                  nop
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  srai         ra, s0, 9
                  nop
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  nop
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  lui          a4, 79721
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  nop
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  lui          a4, 79721
                  lui          a4, 79721
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  nop
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  or           s5, s9, a5
                  lui          a4, 79721
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  nop
                  lui          a4, 79721
                  srai         ra, s0, 9
                  nop
                  nop
                  slti         s8, a1, -205
                  auipc        tp, 970582
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  nop
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  lui          a4, 79721
                  li           s3, 0xffffffff #start riscv_int_numeric_corner_stream_21
                  li           ra, 0xcda97f9b
                  li           tp, 0x0
                  li           s10, 0xffffffff
                  li           t4, 0xffffffff
                  li           s2, 0x0
                  li           t1, 0x80000000
                  li           gp, 0x80000000
                  li           t5, 0x0
                  li           s6, 0x0
                  add          s3, s10, gp
                  add          s3, s10, gp
                  auipc        tp, 970582
                  lui          s10, 79721
                  auipc        tp, 970582
                  lui          s10, 79721
                  sub          ra, s10, t4
                  lui          s10, 79721
                  add          s3, s10, gp
                  auipc        tp, 970582
                  nop
                  auipc        tp, 970582
                  lui          s10, 79721
                  sub          ra, s10, t4
                  lui          s10, 79721
                  nop
                  auipc        tp, 970582
                  sub          ra, s10, t4
                  nop
                  sub          ra, s10, t4
                  nop
                  sub          ra, s10, t4
                  auipc        tp, 970582
                  lui          s10, 79721
                  addi         s2, tp, 1497 #end riscv_int_numeric_corner_stream_21
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  and          t1, ra, s2
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  lui          a4, 79721
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  nop
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  lui          a4, 79721
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  nop
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  lui          a4, 79721
                  srai         ra, s0, 9
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  nop
                  sra          s5, a1, a6
                  nop
                  lui          a4, 79721
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  or           s5, s9, a5
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  li           t5, 0x1d31c760 #start riscv_int_numeric_corner_stream_3
                  li           s0, 0xa3a929ca
                  li           tp, 0x80000000
                  li           t6, 0x80000000
                  li           a2, 0x0
                  li           t4, 0x80000000
                  li           ra, 0x11413bed
                  li           s1, 0x0
                  li           s6, 0x0
                  li           s3, 0xffffffff
                  add          s3, t6, s3
                  sub          t6, s0, t4
                  lui          s3, 79721
                  addi         ra, tp, 1497
                  auipc        tp, 970582
                  sub          t6, s0, t4
                  nop
                  add          s3, t6, s3
                  auipc        tp, 970582
                  addi         ra, tp, 1497
                  sub          t6, s0, t4
                  add          s3, t6, s3
                  nop
                  add          s3, t6, s3
                  addi         ra, tp, 1497
                  auipc        tp, 970582
                  add          s3, t6, s3
                  auipc        tp, 970582
                  nop
                  lui          s3, 79721
                  add          s3, t6, s3
                  sub          t6, s0, t4
                  lui          s3, 79721
                  sub          t6, s0, t4
                  lui          s3, 79721
                  add          s3, t6, s3 #end riscv_int_numeric_corner_stream_3
                  slli         s10, a0, 0
                  addi         t1, a7, 1497
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  nop
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  lui          a4, 79721
                  srli         s6, s6, 10
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  lui          a4, 79721
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  nop
                  and          t1, ra, s2
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  nop
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  or           s5, s9, a5
                  add          a2, s9, a1
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  lui          a4, 79721
                  sll          a3, s5, s5
                  lui          a4, 79721
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  nop
                  andi         t2, t2, 1466
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  nop
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  nop
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  nop
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  sltu         s0, a6, sp
                  nop
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  nop
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  nop
                  slli         s10, a0, 0
                  srai         ra, s0, 9
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  auipc        tp, 970582
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  auipc        tp, 970582
                  nop
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  andi         t2, t2, 1466
                  addi         t1, a7, 1497
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  lui          a4, 79721
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  lui          a4, 79721
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  addi         t1, a7, 1497
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_6
                  li           a5, 0x80000000
                  li           s5, 0x0
                  li           gp, 0x0
                  li           a3, 0x0
                  li           s1, 0xac24bf5d
                  li           tp, 0xffffffff
                  li           s9, 0x3712f53b
                  li           s10, 0xffffffff
                  li           a2, 0xffffffff
                  auipc        tp, 970582
                  auipc        tp, 970582
                  auipc        tp, 970582
                  auipc        tp, 970582
                  auipc        tp, 970582
                  lui          a5, 79721
                  addi         gp, tp, 1497
                  add          t6, t6, gp
                  addi         gp, tp, 1497
                  lui          a5, 79721
                  lui          a5, 79721
                  sub          t6, t6, s9
                  sub          t6, t6, s9
                  sub          t6, t6, s9
                  auipc        tp, 970582 #end riscv_int_numeric_corner_stream_6
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  auipc        tp, 970582
                  lui          a4, 79721
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  nop
                  slt          s8, s8, a4
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  nop
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  slt          s8, s8, a4
                  xor          a7, t0, s3
                  nop
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  lui          a4, 79721
                  nop
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  nop
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  add          a2, s9, a1
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  addi         t1, a7, 1497
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  and          t1, ra, s2
                  ori          t0, a2, 1565
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  nop
                  nop
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  lui          a4, 79721
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  nop
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  addi         t1, a7, 1497
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  nop
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  andi         t2, t2, 1466
                  nop
                  ori          t0, a2, 1565
                  srai         ra, s0, 9
                  sub          a2, a7, s4
                  nop
                  lui          a4, 79721
                  addi         t1, a7, 1497
                  ori          t0, a2, 1565
                  nop
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  nop
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  sub          a2, a7, s4
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  srli         s6, s6, 10
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  nop
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  nop
                  or           s5, s9, a5
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  auipc        tp, 970582
                  sra          s5, a1, a6
                  lui          a4, 79721
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  sll          a3, s5, s5
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  nop
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  xor          a7, t0, s3
                  auipc        tp, 970582
                  nop
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  add          a2, s9, a1
                  nop
                  nop
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  and          t1, ra, s2
                  nop
                  sra          s5, a1, a6
                  lui          a4, 79721
                  slti         s8, a1, -205
                  srai         ra, s0, 9
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  ori          t0, a2, 1565
                  srl          s9, s1, s6
                  sltiu        gp, s8, 628
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  nop
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  and          t1, ra, s2
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  srai         ra, s0, 9
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  lui          a4, 79721
                  sltiu        gp, s8, 628
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  nop
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  and          t1, ra, s2
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  srl          s9, s1, s6
                  slti         s8, a1, -205
                  or           s5, s9, a5
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  or           s5, s9, a5
                  or           s5, s9, a5
                  nop
                  lui          a4, 79721
                  xor          a7, t0, s3
                  nop
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  slli         s10, a0, 0
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  nop
                  nop
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  nop
                  sub          a2, a7, s4
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  ori          t0, a2, 1565
                  or           s5, s9, a5
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  add          a2, s9, a1
                  lui          a4, 79721
                  sll          a3, s5, s5
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  lui          a4, 79721
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  andi         t2, t2, 1466
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  nop
                  lui          a4, 79721
                  slt          s8, s8, a4
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  nop
                  sub          a2, a7, s4
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  or           s5, s9, a5
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  andi         t2, t2, 1466
                  srai         ra, s0, 9
                  lui          a4, 79721
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  andi         t2, t2, 1466
                  srl          s9, s1, s6
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  lui          a4, 79721
                  slt          s8, s8, a4
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  sra          s5, a1, a6
                  nop
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slti         s8, a1, -205
                  nop
                  slli         s10, a0, 0
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  lui          a4, 79721
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  ori          t0, a2, 1565
                  sltu         s0, a6, sp
                  srl          s9, s1, s6
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  nop
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  nop
                  nop
                  slli         s10, a0, 0
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  ori          t0, a2, 1565
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  lui          a4, 79721
                  sub          a2, a7, s4
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  xori         t0, s11, -1854
                  sub          a2, a7, s4
                  srl          s9, s1, s6
                  addi         t1, a7, 1497
                  slti         s8, a1, -205
                  add          a2, s9, a1
                  slti         s8, a1, -205
                  and          t1, ra, s2
                  lui          a4, 79721
                  xor          a7, t0, s3
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  nop
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  ori          t0, a2, 1565
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  lui          a4, 79721
                  ori          t0, a2, 1565
                  and          t1, ra, s2
                  sltu         s0, a6, sp
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  auipc        tp, 970582
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  xori         t0, s11, -1854
                  slt          s8, s8, a4
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  slti         s8, a1, -205
                  xor          a7, t0, s3
                  slti         s8, a1, -205
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  add          a2, s9, a1
                  ori          t0, a2, 1565
                  ori          t0, a2, 1565
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  lui          a4, 79721
                  slt          s8, s8, a4
                  auipc        tp, 970582
                  nop
                  sub          a2, a7, s4
                  ori          t0, a2, 1565
                  sra          s5, a1, a6
                  nop
                  nop
                  auipc        tp, 970582
                  and          t1, ra, s2
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  andi         t2, t2, 1466
                  lui          a4, 79721
                  xor          a7, t0, s3
                  sltiu        gp, s8, 628
                  lui          a4, 79721
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  xor          a7, t0, s3
                  nop
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  slti         s8, a1, -205
                  addi         t1, a7, 1497
                  lui          a4, 79721
                  slt          s8, s8, a4
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  sll          a3, s5, s5
                  and          t1, ra, s2
                  addi         t1, a7, 1497
                  auipc        tp, 970582
                  sll          a3, s5, s5
                  sra          s5, a1, a6
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  nop
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  slli         s10, a0, 0
                  nop
                  addi         t1, a7, 1497
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  and          t1, ra, s2
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  sra          s5, a1, a6
                  sltu         s0, a6, sp
                  srli         s6, s6, 10
                  addi         t1, a7, 1497
                  slli         s10, a0, 0
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  xori         t0, s11, -1854
                  sll          a3, s5, s5
                  nop
                  srli         s6, s6, 10
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  sltiu        gp, s8, 628
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  add          a2, s9, a1
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  slti         s8, a1, -205
                  lui          a4, 79721
                  srli         s6, s6, 10
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  nop
                  sub          a2, a7, s4
                  auipc        tp, 970582
                  addi         t1, a7, 1497
                  xor          a7, t0, s3
                  nop
                  xor          a7, t0, s3
                  and          t1, ra, s2
                  xori         t0, s11, -1854
                  nop
                  sll          a3, s5, s5
                  lui          a4, 79721
                  add          a2, s9, a1
                  or           s5, s9, a5
                  slli         s10, a0, 0
                  slti         s8, a1, -205
                  sub          a2, a7, s4
                  srli         s6, s6, 10
                  slt          s8, s8, a4
                  sra          s5, a1, a6
                  sltiu        gp, s8, 628
                  sub          a2, a7, s4
                  or           s5, s9, a5
                  or           s5, s9, a5
                  auipc        tp, 970582
                  auipc        tp, 970582
                  add          a2, s9, a1
                  xori         t0, s11, -1854
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  slti         s8, a1, -205
                  slt          s8, s8, a4
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  nop
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  and          t1, ra, s2
                  auipc        tp, 970582
                  lui          a4, 79721
                  srl          s9, s1, s6
                  srai         ra, s0, 9
                  add          a2, s9, a1
                  nop
                  slli         s10, a0, 0
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  sltu         s0, a6, sp
                  slt          s8, s8, a4
                  addi         t1, a7, 1497
                  add          a2, s9, a1
                  srai         ra, s0, 9
                  sra          s5, a1, a6
                  srai         ra, s0, 9
                  sll          a3, s5, s5
                  srl          s9, s1, s6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  sub          a2, a7, s4
                  and          t1, ra, s2
                  nop
                  lui          a4, 79721
                  srai         ra, s0, 9
                  or           s5, s9, a5
                  add          a2, s9, a1
                  sltiu        gp, s8, 628
                  sltiu        gp, s8, 628
                  sll          a3, s5, s5
                  sub          a2, a7, s4
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  xori         t0, s11, -1854
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  xor          a7, t0, s3
                  sltu         s0, a6, sp
                  andi         t2, t2, 1466
                  auipc        tp, 970582
                  lui          a4, 79721
                  auipc        tp, 970582
                  slt          s8, s8, a4
                  lui          a4, 79721
                  and          t1, ra, s2
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  srli         s6, s6, 10
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  slt          s8, s8, a4
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  xor          a7, t0, s3
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  slti         s8, a1, -205
                  ori          t0, a2, 1565
                  lui          a4, 79721
                  sub          a2, a7, s4
                  sra          s5, a1, a6
                  xor          a7, t0, s3
                  or           s5, s9, a5
                  or           s5, s9, a5
                  add          a2, s9, a1
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  srli         s6, s6, 10
                  add          a2, s9, a1
                  nop
                  srli         s6, s6, 10
                  xori         t0, s11, -1854
                  sltiu        gp, s8, 628
                  and          t1, ra, s2
                  xor          a7, t0, s3
                  add          a2, s9, a1
                  nop
                  auipc        tp, 970582
                  sltu         s0, a6, sp
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  or           s5, s9, a5
                  and          t1, ra, s2
                  auipc        tp, 970582
                  andi         t2, t2, 1466
                  srli         s6, s6, 10
                  nop
                  sltu         s0, a6, sp
                  slli         s10, a0, 0
                  sltu         s0, a6, sp
                  and          t1, ra, s2
                  srli         s6, s6, 10
                  and          t1, ra, s2
                  sltiu        gp, s8, 628
                  sra          s5, a1, a6
                  xori         t0, s11, -1854
                  andi         t2, t2, 1466
                  xor          a7, t0, s3
                  lui          a4, 79721
                  or           s5, s9, a5
                  sltu         s0, a6, sp
                  sub          a2, a7, s4
                  xori         t0, s11, -1854
                  srai         ra, s0, 9
                  srli         s6, s6, 10
                  andi         t2, t2, 1466
                  and          t1, ra, s2
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  sll          a3, s5, s5
                  sltu         s0, a6, sp
                  add          a2, s9, a1
                  srl          s9, s1, s6
                  sll          a3, s5, s5
                  add          a2, s9, a1
                  slli         s10, a0, 0
                  sltiu        gp, s8, 628
                  or           s5, s9, a5
                  lui          a4, 79721
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  slli         s10, a0, 0
                  or           s5, s9, a5
                  srl          s9, s1, s6
                  or           s5, s9, a5
                  or           s5, s9, a5
                  sra          s5, a1, a6
                  slli         s10, a0, 0
                  sll          a3, s5, s5
                  slli         s10, a0, 0
                  and          t1, ra, s2
                  add          a2, s9, a1
                  or           s5, s9, a5
                  slt          s8, s8, a4
                  xori         t0, s11, -1854
                  sra          s5, a1, a6
                  nop
                  xor          a7, t0, s3
                  slt          s8, s8, a4
                  nop
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  auipc        tp, 970582
                  or           s5, s9, a5
                  srli         s6, s6, 10
                  sra          s5, a1, a6
                  auipc        tp, 970582
                  auipc        tp, 970582
                  auipc        tp, 970582
                  srai         ra, s0, 9
                  and          t1, ra, s2
                  sra          s5, a1, a6
                  srl          s9, s1, s6
                  sltu         s0, a6, sp
                  nop
                  srai         ra, s0, 9
                  la x20, test_done
                  jalr x0, x20, 0
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
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_2:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_3:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_4:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_5:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_6:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_7:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_8:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_9:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_10:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_11:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_12:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_13:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_14:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

mmode_intr_vector_15:
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x342 # MCAUSE
                  srli x26, x26, 0x1f
                  beqz x26, 1f
                  j mmode_intr_handler
                  1: la x20, test_done
                  jalr x0, x20, 0

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
                  addi x23, x23, -4
                  sw  x2, (x23)
                  add x2, x23, zero
                  addi x2, x2, -128
                  sw  x1, 4(x2)
                  sw  x2, 8(x2)
                  sw  x3, 12(x2)
                  sw  x4, 16(x2)
                  sw  x5, 20(x2)
                  sw  x6, 24(x2)
                  sw  x7, 28(x2)
                  sw  x8, 32(x2)
                  sw  x9, 36(x2)
                  sw  x10, 40(x2)
                  sw  x11, 44(x2)
                  sw  x12, 48(x2)
                  sw  x13, 52(x2)
                  sw  x14, 56(x2)
                  sw  x15, 60(x2)
                  sw  x16, 64(x2)
                  sw  x17, 68(x2)
                  sw  x18, 72(x2)
                  sw  x19, 76(x2)
                  sw  x20, 80(x2)
                  sw  x21, 84(x2)
                  sw  x22, 88(x2)
                  sw  x23, 92(x2)
                  sw  x24, 96(x2)
                  sw  x25, 100(x2)
                  sw  x26, 104(x2)
                  sw  x27, 108(x2)
                  sw  x28, 112(x2)
                  sw  x29, 116(x2)
                  sw  x30, 120(x2)
                  sw  x31, 124(x2)
                  add x23, x2, zero
                  csrr x26, 0x341 # MEPC
                  csrr x26, 0x342 # MCAUSE
                  li x19, 0x3 # BREAKPOINT
                  beq x26, x19, ebreak_handler
                  li x19, 0x8 # ECALL_UMODE
                  beq x26, x19, ecall_handler
                  li x19, 0x9 # ECALL_SMODE
                  beq x26, x19, ecall_handler
                  li x19, 0xb # ECALL_MMODE
                  beq x26, x19, ecall_handler
                  li x19, 0x1
                  beq x26, x19, instr_fault_handler
                  li x19, 0x5
                  beq x26, x19, load_fault_handler
                  li x19, 0x7
                  beq x26, x19, store_fault_handler
                  li x19, 0xc
                  beq x26, x19, pt_fault_handler
                  li x19, 0xd
                  beq x26, x19, pt_fault_handler
                  li x19, 0xf
                  beq x26, x19, pt_fault_handler
                  li x19, 0x2 # ILLEGAL_INSTRUCTION
                  beq x26, x19, illegal_instr_handler
                  csrr x19, 0x343 # MTVAL
                  1: la x20, test_done
                  jalr x1, x20, 0

ecall_handler:    
                  la x26, _start
                  sw x0, 0(x26)
                  sw x1, 4(x26)
                  sw x2, 8(x26)
                  sw x3, 12(x26)
                  sw x4, 16(x26)
                  sw x5, 20(x26)
                  sw x6, 24(x26)
                  sw x7, 28(x26)
                  sw x8, 32(x26)
                  sw x9, 36(x26)
                  sw x10, 40(x26)
                  sw x11, 44(x26)
                  sw x12, 48(x26)
                  sw x13, 52(x26)
                  sw x14, 56(x26)
                  sw x15, 60(x26)
                  sw x16, 64(x26)
                  sw x17, 68(x26)
                  sw x18, 72(x26)
                  sw x19, 76(x26)
                  sw x20, 80(x26)
                  sw x21, 84(x26)
                  sw x22, 88(x26)
                  sw x23, 92(x26)
                  sw x24, 96(x26)
                  sw x25, 100(x26)
                  sw x26, 104(x26)
                  sw x27, 108(x26)
                  sw x28, 112(x26)
                  sw x29, 116(x26)
                  sw x30, 120(x26)
                  sw x31, 124(x26)
                  la x20, write_tohost
                  jalr x0, x20, 0

instr_fault_handler:
                  add x2, x23, zero
                  lw  x1, 4(x2)
                  lw  x2, 8(x2)
                  lw  x3, 12(x2)
                  lw  x4, 16(x2)
                  lw  x5, 20(x2)
                  lw  x6, 24(x2)
                  lw  x7, 28(x2)
                  lw  x8, 32(x2)
                  lw  x9, 36(x2)
                  lw  x10, 40(x2)
                  lw  x11, 44(x2)
                  lw  x12, 48(x2)
                  lw  x13, 52(x2)
                  lw  x14, 56(x2)
                  lw  x15, 60(x2)
                  lw  x16, 64(x2)
                  lw  x17, 68(x2)
                  lw  x18, 72(x2)
                  lw  x19, 76(x2)
                  lw  x20, 80(x2)
                  lw  x21, 84(x2)
                  lw  x22, 88(x2)
                  lw  x23, 92(x2)
                  lw  x24, 96(x2)
                  lw  x25, 100(x2)
                  lw  x26, 104(x2)
                  lw  x27, 108(x2)
                  lw  x28, 112(x2)
                  lw  x29, 116(x2)
                  lw  x30, 120(x2)
                  lw  x31, 124(x2)
                  addi x2, x2, 128
                  add x23, x2, zero
                  lw  x2, (x23)
                  addi x23, x23, 4
                  mret

load_fault_handler:
                  add x2, x23, zero
                  lw  x1, 4(x2)
                  lw  x2, 8(x2)
                  lw  x3, 12(x2)
                  lw  x4, 16(x2)
                  lw  x5, 20(x2)
                  lw  x6, 24(x2)
                  lw  x7, 28(x2)
                  lw  x8, 32(x2)
                  lw  x9, 36(x2)
                  lw  x10, 40(x2)
                  lw  x11, 44(x2)
                  lw  x12, 48(x2)
                  lw  x13, 52(x2)
                  lw  x14, 56(x2)
                  lw  x15, 60(x2)
                  lw  x16, 64(x2)
                  lw  x17, 68(x2)
                  lw  x18, 72(x2)
                  lw  x19, 76(x2)
                  lw  x20, 80(x2)
                  lw  x21, 84(x2)
                  lw  x22, 88(x2)
                  lw  x23, 92(x2)
                  lw  x24, 96(x2)
                  lw  x25, 100(x2)
                  lw  x26, 104(x2)
                  lw  x27, 108(x2)
                  lw  x28, 112(x2)
                  lw  x29, 116(x2)
                  lw  x30, 120(x2)
                  lw  x31, 124(x2)
                  addi x2, x2, 128
                  add x23, x2, zero
                  lw  x2, (x23)
                  addi x23, x23, 4
                  mret

store_fault_handler:
                  add x2, x23, zero
                  lw  x1, 4(x2)
                  lw  x2, 8(x2)
                  lw  x3, 12(x2)
                  lw  x4, 16(x2)
                  lw  x5, 20(x2)
                  lw  x6, 24(x2)
                  lw  x7, 28(x2)
                  lw  x8, 32(x2)
                  lw  x9, 36(x2)
                  lw  x10, 40(x2)
                  lw  x11, 44(x2)
                  lw  x12, 48(x2)
                  lw  x13, 52(x2)
                  lw  x14, 56(x2)
                  lw  x15, 60(x2)
                  lw  x16, 64(x2)
                  lw  x17, 68(x2)
                  lw  x18, 72(x2)
                  lw  x19, 76(x2)
                  lw  x20, 80(x2)
                  lw  x21, 84(x2)
                  lw  x22, 88(x2)
                  lw  x23, 92(x2)
                  lw  x24, 96(x2)
                  lw  x25, 100(x2)
                  lw  x26, 104(x2)
                  lw  x27, 108(x2)
                  lw  x28, 112(x2)
                  lw  x29, 116(x2)
                  lw  x30, 120(x2)
                  lw  x31, 124(x2)
                  addi x2, x2, 128
                  add x23, x2, zero
                  lw  x2, (x23)
                  addi x23, x23, 4
                  mret

ebreak_handler:   
                  csrr  x26, 0x341
                  addi  x26, x26, 4
                  csrw  0x341, x26
                  add x2, x23, zero
                  lw  x1, 4(x2)
                  lw  x2, 8(x2)
                  lw  x3, 12(x2)
                  lw  x4, 16(x2)
                  lw  x5, 20(x2)
                  lw  x6, 24(x2)
                  lw  x7, 28(x2)
                  lw  x8, 32(x2)
                  lw  x9, 36(x2)
                  lw  x10, 40(x2)
                  lw  x11, 44(x2)
                  lw  x12, 48(x2)
                  lw  x13, 52(x2)
                  lw  x14, 56(x2)
                  lw  x15, 60(x2)
                  lw  x16, 64(x2)
                  lw  x17, 68(x2)
                  lw  x18, 72(x2)
                  lw  x19, 76(x2)
                  lw  x20, 80(x2)
                  lw  x21, 84(x2)
                  lw  x22, 88(x2)
                  lw  x23, 92(x2)
                  lw  x24, 96(x2)
                  lw  x25, 100(x2)
                  lw  x26, 104(x2)
                  lw  x27, 108(x2)
                  lw  x28, 112(x2)
                  lw  x29, 116(x2)
                  lw  x30, 120(x2)
                  lw  x31, 124(x2)
                  addi x2, x2, 128
                  add x23, x2, zero
                  lw  x2, (x23)
                  addi x23, x23, 4
                  mret

illegal_instr_handler:
                  csrr  x26, 0x341
                  addi  x26, x26, 4
                  csrw  0x341, x26
                  add x2, x23, zero
                  lw  x1, 4(x2)
                  lw  x2, 8(x2)
                  lw  x3, 12(x2)
                  lw  x4, 16(x2)
                  lw  x5, 20(x2)
                  lw  x6, 24(x2)
                  lw  x7, 28(x2)
                  lw  x8, 32(x2)
                  lw  x9, 36(x2)
                  lw  x10, 40(x2)
                  lw  x11, 44(x2)
                  lw  x12, 48(x2)
                  lw  x13, 52(x2)
                  lw  x14, 56(x2)
                  lw  x15, 60(x2)
                  lw  x16, 64(x2)
                  lw  x17, 68(x2)
                  lw  x18, 72(x2)
                  lw  x19, 76(x2)
                  lw  x20, 80(x2)
                  lw  x21, 84(x2)
                  lw  x22, 88(x2)
                  lw  x23, 92(x2)
                  lw  x24, 96(x2)
                  lw  x25, 100(x2)
                  lw  x26, 104(x2)
                  lw  x27, 108(x2)
                  lw  x28, 112(x2)
                  lw  x29, 116(x2)
                  lw  x30, 120(x2)
                  lw  x31, 124(x2)
                  addi x2, x2, 128
                  add x23, x2, zero
                  lw  x2, (x23)
                  addi x23, x23, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x26, 0x300 # MSTATUS;
                  csrr  x26, 0x304 # MIE;
                  csrr  x26, 0x344 # MIP;
                  csrrc x26, 0x344, x26 # MIP;
                  add x2, x23, zero
                  lw  x1, 4(x2)
                  lw  x2, 8(x2)
                  lw  x3, 12(x2)
                  lw  x4, 16(x2)
                  lw  x5, 20(x2)
                  lw  x6, 24(x2)
                  lw  x7, 28(x2)
                  lw  x8, 32(x2)
                  lw  x9, 36(x2)
                  lw  x10, 40(x2)
                  lw  x11, 44(x2)
                  lw  x12, 48(x2)
                  lw  x13, 52(x2)
                  lw  x14, 56(x2)
                  lw  x15, 60(x2)
                  lw  x16, 64(x2)
                  lw  x17, 68(x2)
                  lw  x18, 72(x2)
                  lw  x19, 76(x2)
                  lw  x20, 80(x2)
                  lw  x21, 84(x2)
                  lw  x22, 88(x2)
                  lw  x23, 92(x2)
                  lw  x24, 96(x2)
                  lw  x25, 100(x2)
                  lw  x26, 104(x2)
                  lw  x27, 108(x2)
                  lw  x28, 112(x2)
                  lw  x29, 116(x2)
                  lw  x30, 120(x2)
                  lw  x31, 124(x2)
                  addi x2, x2, 128
                  add x23, x2, zero
                  lw  x2, (x23)
                  addi x23, x23, 4
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
