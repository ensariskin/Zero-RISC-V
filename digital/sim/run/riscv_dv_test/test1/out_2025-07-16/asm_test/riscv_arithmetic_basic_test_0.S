.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x24, h0_start
jalr x0, x24, 0
h0_start:
                  li x19, 0x40000100
                  csrw 0x301, x19
kernel_sp:        
                  la x11, kernel_stack_end

trap_vec_init:    
                  la x19, mtvec_handler
                  ori x19, x19, 0
                  csrw 0x305, x19 # MTVEC

mepc_setup:       
                  la x19, init
                  csrw 0x341, x19

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x19, 0x1800
                  csrw 0x300, x19 # MSTATUS
                  li x19, 0x0
                  csrw 0x304, x19 # MIE
                  mret
init:             
                  li x0, 0xf3d55730
                  li x1, 0xa
                  li x2, 0xf0866948
                  li x3, 0x32955e13
                  li x4, 0x5ff5171d
                  li x5, 0xba9fbdcc
                  li x6, 0x9
                  li x7, 0x3
                  li x8, 0xf848e281
                  li x9, 0x80000000
                  li x10, 0x0
                  li x12, 0x9e486ae8
                  li x13, 0xc
                  li x14, 0xf88255fa
                  li x15, 0x80000000
                  li x16, 0x0
                  li x17, 0x9
                  li x18, 0xfefbac2c
                  li x19, 0x8
                  li x20, 0x0
                  li x21, 0xb
                  li x22, 0x0
                  li x24, 0x0
                  li x25, 0x3dd16e89
                  li x26, 0x7
                  li x27, 0x80000000
                  li x28, 0xbe90a162
                  li x29, 0x0
                  li x30, 0xb
                  li x31, 0xf7c5a3db
                  la x23, user_stack_end
main:             li           s9, 0x9f6ae03 #start riscv_int_numeric_corner_stream_32
                  li           s5, 0x0
                  li           t6, 0xffffffff
                  li           a3, 0x0
                  li           sp, 0x80000000
                  li           a4, 0xffffffff
                  li           s1, 0xffffffff
                  li           a2, 0x0
                  li           t0, 0x0
                  li           t1, 0xffffffff
                  lui          s9, 965626
                  addi         sp, s1, -1616
                  auipc        a4, 928829
                  addi         sp, s1, -1616
                  lui          s9, 965626
                  add          t6, s9, s1
                  add          t6, s9, s1
                  addi         sp, s1, -1616
                  nop
                  add          t6, s9, s1
                  sub          s5, t6, s5
                  addi         sp, s1, -1616
                  auipc        a4, 928829
                  auipc        a4, 928829
                  add          t6, s9, s1
                  nop
                  add          t6, s9, s1
                  sub          s5, t6, s5
                  add          t6, s9, s1
                  lui          s9, 965626
                  lui          s9, 965626
                  sub          s5, t6, s5
                  auipc        a4, 928829
                  addi         sp, s1, -1616
                  lui          s9, 965626 #end riscv_int_numeric_corner_stream_32
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_20
                  li           a5, 0x0
                  li           t6, 0x465ad4fe
                  li           s4, 0x80000000
                  li           t2, 0x0
                  li           ra, 0xffffffff
                  li           t0, 0x94a43fc3
                  li           a4, 0x0
                  li           sp, 0x0
                  li           a0, 0x0
                  lui          s4, 965626
                  auipc        a4, 928829
                  lui          s4, 965626
                  add          a0, s4, a4
                  auipc        a4, 928829
                  add          a0, s4, a4
                  addi         ra, ra, -1616
                  lui          s4, 965626
                  auipc        a4, 928829
                  sub          ra, a0, t0
                  addi         ra, ra, -1616
                  addi         ra, ra, -1616
                  addi         ra, ra, -1616
                  sub          ra, a0, t0
                  auipc        a4, 928829
                  nop
                  auipc        a4, 928829
                  lui          s4, 965626
                  auipc        a4, 928829
                  sub          ra, a0, t0
                  nop
                  add          a0, s4, a4
                  add          a0, s4, a4 #end riscv_int_numeric_corner_stream_20
                  li           s6, 0x80000000 #start riscv_int_numeric_corner_stream_30
                  li           a3, 0x80000000
                  li           t2, 0x0
                  li           gp, 0xe8144baf
                  li           t3, 0x80000000
                  li           t6, 0x5aac8199
                  li           s10, 0xffffffff
                  li           sp, 0xffffffff
                  li           s1, 0x5f67d320
                  li           a5, 0x0
                  sub          s1, s10, a3
                  add          a5, s10, a3
                  nop
                  addi         s10, s1, -1616
                  addi         s10, s1, -1616
                  sub          s1, s10, a3
                  nop
                  sub          s1, s10, a3
                  nop
                  auipc        s10, 928829
                  nop
                  add          a5, s10, a3
                  sub          s1, s10, a3
                  addi         s10, s1, -1616
                  sub          s1, s10, a3 #end riscv_int_numeric_corner_stream_30
                  li           a7, 0xffffffff #start riscv_int_numeric_corner_stream_7
                  li           t5, 0x0
                  li           gp, 0x14f72f0c
                  li           s3, 0x0
                  li           a2, 0x1b7ef3f0
                  li           s10, 0xf45922d7
                  li           a3, 0xffffffff
                  li           s1, 0x80000000
                  li           a6, 0x347e61d1
                  li           s0, 0x80000000
                  sub          s10, s0, a3
                  addi         a6, a6, -1616
                  add          a3, s10, s1
                  nop
                  lui          a6, 965626
                  sub          s10, s0, a3
                  sub          s10, s0, a3
                  lui          a6, 965626
                  nop
                  sub          s10, s0, a3
                  sub          s10, s0, a3
                  lui          a6, 965626
                  auipc        t5, 928829
                  addi         a6, a6, -1616
                  nop
                  add          a3, s10, s1 #end riscv_int_numeric_corner_stream_7
                  li           s9, 0xffffffff #start riscv_int_numeric_corner_stream_39
                  li           a0, 0x80000000
                  li           t5, 0x75d85c04
                  li           t3, 0x0
                  li           s6, 0x80000000
                  li           t4, 0x80000000
                  li           a3, 0xd57028ac
                  li           a2, 0xffffffff
                  li           s3, 0x3d798ca7
                  li           a4, 0x0
                  sub          a3, t5, a3
                  addi         a0, s9, -1616
                  add          t4, t3, a3
                  sub          a3, t5, a3
                  auipc        t5, 928829
                  add          t4, t3, a3
                  auipc        t5, 928829
                  addi         a0, s9, -1616
                  sub          a3, t5, a3
                  auipc        t5, 928829
                  nop
                  sub          a3, t5, a3
                  lui          a2, 965626
                  auipc        t5, 928829
                  auipc        t5, 928829
                  sub          a3, t5, a3
                  sub          a3, t5, a3
                  sub          a3, t5, a3
                  nop
                  sub          a3, t5, a3
                  auipc        t5, 928829
                  addi         a0, s9, -1616
                  lui          a2, 965626
                  auipc        t5, 928829 #end riscv_int_numeric_corner_stream_39
                  li           s9, 0x687246f5 #start riscv_int_numeric_corner_stream_18
                  li           ra, 0x80000000
                  li           t2, 0x147c1820
                  li           a4, 0x5d4a00f7
                  li           a6, 0xffffffff
                  li           s10, 0xffffffff
                  li           s5, 0x80000000
                  li           sp, 0xffffffff
                  li           tp, 0x80000000
                  li           gp, 0x80000000
                  sub          ra, s10, s5
                  auipc        a4, 928829
                  nop
                  nop
                  add          a4, s9, a4
                  addi         sp, ra, -1616
                  nop
                  sub          ra, s10, s5
                  sub          ra, s10, s5
                  nop
                  nop
                  addi         sp, ra, -1616
                  lui          a6, 965626
                  addi         sp, ra, -1616
                  lui          a6, 965626
                  nop
                  addi         sp, ra, -1616
                  sub          ra, s10, s5
                  addi         sp, ra, -1616
                  add          a4, s9, a4
                  add          a4, s9, a4
                  add          a4, s9, a4
                  addi         sp, ra, -1616
                  add          a4, s9, a4 #end riscv_int_numeric_corner_stream_18
                  li           t6, 0x70247a5e #start riscv_int_numeric_corner_stream_10
                  li           a2, 0xffffffff
                  li           a4, 0x6b9577fa
                  li           t4, 0x80000000
                  li           a0, 0x80000000
                  li           s10, 0xffffffff
                  li           s3, 0xffffffff
                  li           s0, 0xffffffff
                  li           a3, 0xffffffff
                  li           t1, 0x7e787d5c
                  sub          s10, s10, a3
                  auipc        a4, 928829
                  addi         a0, s0, -1616
                  nop
                  sub          s10, s10, a3
                  addi         a0, s0, -1616
                  add          a0, t1, a3
                  add          a0, t1, a3
                  addi         a0, s0, -1616
                  auipc        a4, 928829
                  sub          s10, s10, a3
                  sub          s10, s10, a3
                  lui          a2, 965626
                  auipc        a4, 928829
                  auipc        a4, 928829
                  nop
                  sub          s10, s10, a3
                  nop
                  lui          a2, 965626
                  nop
                  sub          s10, s10, a3 #end riscv_int_numeric_corner_stream_10
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_29
                  li           t2, 0x0
                  li           t4, 0x3af3a960
                  li           s10, 0x0
                  li           a0, 0x80000000
                  li           a3, 0x0
                  li           s9, 0x0
                  li           tp, 0xffffffff
                  li           s11, 0x80000000
                  li           s0, 0x80000000
                  addi         s9, s0, -1616
                  addi         s9, s0, -1616
                  addi         s9, s0, -1616
                  add          s0, tp, a3
                  lui          s9, 965626
                  add          s0, tp, a3
                  lui          s9, 965626
                  addi         s9, s0, -1616
                  auipc        s10, 928829
                  lui          s9, 965626
                  sub          s10, s10, a3
                  nop
                  addi         s9, s0, -1616
                  nop
                  auipc        s10, 928829
                  nop
                  lui          s9, 965626 #end riscv_int_numeric_corner_stream_29
                  li           t2, 0xffffffff #start riscv_int_numeric_corner_stream_22
                  li           gp, 0x0
                  li           t5, 0x0
                  li           t3, 0x0
                  li           a5, 0xffffffff
                  li           s4, 0x0
                  li           s3, 0x1bb24a9a
                  li           a7, 0xffffffff
                  li           a2, 0x80000000
                  li           sp, 0x80000000
                  sub          s3, t5, a2
                  addi         s3, a7, -1616
                  auipc        t5, 928829
                  add          a5, t3, t3
                  auipc        t5, 928829
                  auipc        t5, 928829
                  addi         s3, a7, -1616
                  addi         s3, a7, -1616
                  nop
                  add          a5, t3, t3
                  sub          s3, t5, a2
                  addi         s3, a7, -1616
                  auipc        t5, 928829
                  addi         s3, a7, -1616
                  lui          a7, 965626
                  auipc        t5, 928829
                  add          a5, t3, t3
                  auipc        t5, 928829
                  sub          s3, t5, a2
                  nop
                  sub          s3, t5, a2
                  auipc        t5, 928829
                  add          a5, t3, t3
                  addi         s3, a7, -1616
                  auipc        t5, 928829
                  addi         s3, a7, -1616 #end riscv_int_numeric_corner_stream_22
                  li           s4, 0xca7c293c #start riscv_int_numeric_corner_stream_9
                  li           sp, 0x21b21439
                  li           ra, 0x80000000
                  li           s3, 0xffffffff
                  li           t3, 0xffffffff
                  li           t6, 0x80000000
                  li           s10, 0xffffffff
                  li           t4, 0x80000000
                  li           t5, 0x80000000
                  li           t1, 0x0
                  sub          ra, s10, t4
                  addi         s10, ra, -1616
                  addi         s10, ra, -1616
                  addi         s10, ra, -1616
                  lui          ra, 965626
                  addi         s10, ra, -1616
                  addi         s10, ra, -1616
                  addi         s10, ra, -1616
                  nop
                  add          t6, t4, t3
                  lui          ra, 965626
                  addi         s10, ra, -1616
                  auipc        t5, 928829
                  sub          ra, s10, t4
                  nop
                  auipc        t5, 928829
                  nop
                  lui          ra, 965626
                  auipc        t5, 928829
                  nop
                  lui          ra, 965626
                  addi         s10, ra, -1616
                  addi         s10, ra, -1616
                  auipc        t5, 928829
                  sub          ra, s10, t4
                  lui          ra, 965626
                  add          t6, t4, t3
                  nop #end riscv_int_numeric_corner_stream_9
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_21
                  li           a7, 0x80000000
                  li           s5, 0x80000000
                  li           s2, 0x80000000
                  li           s3, 0x6f487d87
                  li           s6, 0x0
                  li           a5, 0x288f0447
                  li           a4, 0xffffffff
                  li           s9, 0x6c29549f
                  li           t4, 0xd32ed9b8
                  lui          t3, 965626
                  addi         s9, a7, -1616
                  sub          s5, s6, s5
                  add          a4, t3, a5
                  nop
                  auipc        a4, 928829
                  addi         s9, a7, -1616
                  lui          t3, 965626
                  addi         s9, a7, -1616
                  add          a4, t3, a5
                  add          a4, t3, a5
                  auipc        a4, 928829
                  lui          t3, 965626
                  sub          s5, s6, s5
                  nop #end riscv_int_numeric_corner_stream_21
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_12
                  li           s1, 0x0
                  li           s6, 0xddb02a36
                  li           gp, 0x80000000
                  li           s4, 0x0
                  li           t4, 0xb7d9ba78
                  li           t3, 0x973b27b9
                  li           t5, 0xffffffff
                  li           ra, 0xffffffff
                  li           a4, 0x80000000
                  nop
                  nop
                  auipc        t5, 928829
                  lui          s1, 965626
                  addi         s1, ra, -1616
                  sub          t6, s1, t4
                  addi         s1, ra, -1616
                  nop
                  auipc        t5, 928829
                  add          t6, s6, s1
                  add          t6, s6, s1
                  sub          t6, s1, t4
                  sub          t6, s1, t4
                  nop
                  lui          s1, 965626
                  auipc        t5, 928829
                  add          t6, s6, s1
                  lui          s1, 965626
                  add          t6, s6, s1
                  sub          t6, s1, t4
                  add          t6, s6, s1
                  sub          t6, s1, t4
                  lui          s1, 965626
                  sub          t6, s1, t4
                  add          t6, s6, s1
                  sub          t6, s1, t4
                  sub          t6, s1, t4 #end riscv_int_numeric_corner_stream_12
                  li           t1, 0xffffffff #start riscv_int_numeric_corner_stream_5
                  li           t2, 0xffffffff
                  li           s2, 0x0
                  li           a5, 0x7d57e5c0
                  li           a0, 0xffffffff
                  li           a6, 0x0
                  li           t3, 0x0
                  li           a3, 0x0
                  li           s10, 0xffffffff
                  li           s11, 0x80000000
                  add          a5, s11, a3
                  addi         s10, a6, -1616
                  add          a5, s11, a3
                  sub          s11, a0, a3
                  addi         s10, a6, -1616
                  add          a5, s11, a3
                  nop
                  add          a5, s11, a3
                  sub          s11, a0, a3
                  addi         s10, a6, -1616
                  addi         s10, a6, -1616
                  nop
                  auipc        t3, 928829
                  add          a5, s11, a3
                  add          a5, s11, a3
                  nop
                  auipc        t3, 928829
                  addi         s10, a6, -1616
                  addi         s10, a6, -1616
                  lui          a6, 965626
                  auipc        t3, 928829
                  lui          a6, 965626 #end riscv_int_numeric_corner_stream_5
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_35
                  li           gp, 0x80000000
                  li           s2, 0xd5aee4d
                  li           s1, 0x3ba71c14
                  li           s5, 0xffffffff
                  li           t3, 0x8963349e
                  li           s0, 0x80000000
                  li           a0, 0x2755686
                  li           a4, 0xffffffff
                  li           s3, 0xffffffff
                  auipc        a4, 928829
                  nop
                  sub          s3, s0, s5
                  lui          s1, 965626
                  addi         gp, s0, -1616
                  add          a0, a4, s1
                  add          a0, a4, s1
                  add          a0, a4, s1
                  auipc        a4, 928829
                  lui          s1, 965626
                  sub          s3, s0, s5
                  lui          s1, 965626
                  nop
                  nop
                  auipc        a4, 928829
                  sub          s3, s0, s5
                  nop
                  addi         gp, s0, -1616
                  sub          s3, s0, s5
                  lui          s1, 965626 #end riscv_int_numeric_corner_stream_35
                  li           s3, 0xffffffff #start riscv_int_numeric_corner_stream_23
                  li           s2, 0x782739cf
                  li           s11, 0x0
                  li           s10, 0x80000000
                  li           tp, 0x80000000
                  li           a4, 0xffffffff
                  li           s5, 0x0
                  li           t6, 0x0
                  li           a6, 0xffffffff
                  li           s6, 0xff9375ca
                  addi         s11, a6, -1616
                  add          s10, tp, a4
                  add          s10, tp, a4
                  sub          tp, s10, s5
                  lui          tp, 965626
                  addi         s11, a6, -1616
                  sub          tp, s10, s5
                  nop
                  sub          tp, s10, s5
                  sub          tp, s10, s5
                  addi         s11, a6, -1616
                  nop
                  lui          tp, 965626
                  auipc        a4, 928829
                  lui          tp, 965626 #end riscv_int_numeric_corner_stream_23
                  li           s3, 0x0 #start riscv_int_numeric_corner_stream_27
                  li           s2, 0x0
                  li           a5, 0xe7533d31
                  li           a0, 0x58722fef
                  li           s9, 0xf4fd35fd
                  li           gp, 0x80000000
                  li           s0, 0xca6e424d
                  li           t5, 0x0
                  li           t2, 0x81370f77
                  li           t6, 0xffffffff
                  add          s0, t5, a5
                  auipc        t5, 928829
                  auipc        t5, 928829
                  nop
                  lui          s0, 965626
                  nop
                  nop
                  sub          a5, a0, a5
                  add          s0, t5, a5
                  auipc        t5, 928829
                  addi         a0, s0, -1616
                  addi         a0, s0, -1616
                  lui          s0, 965626
                  lui          s0, 965626
                  sub          a5, a0, a5 #end riscv_int_numeric_corner_stream_27
                  li           a4, 0xffffffff #start riscv_int_numeric_corner_stream_14
                  li           ra, 0x0
                  li           tp, 0xffffffff
                  li           s4, 0x80000000
                  li           t1, 0x9f468bb4
                  li           a6, 0x0
                  li           s0, 0xa3181b3d
                  li           s1, 0xffffffff
                  li           s9, 0x80000000
                  li           gp, 0xdb262b36
                  sub          s1, s0, a4
                  sub          s1, s0, a4
                  addi         s0, ra, -1616
                  addi         s0, ra, -1616
                  addi         s0, ra, -1616
                  addi         s0, ra, -1616
                  addi         s0, ra, -1616
                  nop
                  lui          a6, 965626
                  sub          s1, s0, a4
                  nop
                  add          s9, s4, s1
                  add          s9, s4, s1
                  sub          s1, s0, a4
                  sub          s1, s0, a4
                  sub          s1, s0, a4
                  sub          s1, s0, a4 #end riscv_int_numeric_corner_stream_14
                  li           s4, 0x80000000 #start riscv_int_numeric_corner_stream_17
                  li           a7, 0xffffffff
                  li           tp, 0xb86f3b16
                  li           a5, 0xffffffff
                  li           ra, 0xffffffff
                  li           s5, 0x0
                  li           s11, 0x5e97e0aa
                  li           t0, 0xffffffff
                  li           s10, 0xffffffff
                  li           sp, 0x80000000
                  nop
                  add          s10, a7, s10
                  lui          s4, 965626
                  sub          s11, s10, t0
                  auipc        s10, 928829
                  add          s10, a7, s10
                  add          s10, a7, s10
                  auipc        s10, 928829
                  lui          s4, 965626
                  nop
                  nop
                  auipc        s10, 928829
                  auipc        s10, 928829
                  add          s10, a7, s10
                  nop #end riscv_int_numeric_corner_stream_17
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  nop
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  lui          a7, 965626
                  and          sp, t3, s7
                  or           a7, gp, a1
                  lui          a7, 965626
                  lui          a7, 965626
                  or           a7, gp, a1
                  nop
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  lui          a7, 965626
                  lui          a7, 965626
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  lui          a7, 965626
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  lui          a7, 965626
                  nop
                  lui          a7, 965626
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  lui          a7, 965626
                  nop
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  lui          a7, 965626
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  nop
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  nop
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  nop
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  nop
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  lui          a7, 965626
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  nop
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  li           a5, 0xffffffff #start riscv_int_numeric_corner_stream_25
                  li           s10, 0x0
                  li           t4, 0x0
                  li           sp, 0x6fa8e26e
                  li           tp, 0x80000000
                  li           s9, 0xffffffff
                  li           a3, 0xffffffff
                  li           s11, 0x80000000
                  li           s0, 0xffffffff
                  li           s2, 0x80000000
                  lui          s9, 965626
                  add          a5, s11, a3
                  nop
                  lui          s9, 965626
                  add          a5, s11, a3
                  nop
                  lui          s9, 965626
                  nop
                  sub          t4, s10, a3
                  lui          s9, 965626
                  lui          s9, 965626
                  sub          t4, s10, a3
                  sub          t4, s10, a3
                  nop
                  sub          t4, s10, a3
                  lui          s9, 965626
                  nop
                  lui          s9, 965626
                  auipc        s10, 928829
                  lui          s9, 965626
                  auipc        s10, 928829
                  add          a5, s11, a3
                  lui          s9, 965626
                  addi         s2, s0, -1616
                  add          a5, s11, a3
                  nop
                  nop
                  nop
                  addi         s2, s0, -1616 #end riscv_int_numeric_corner_stream_25
                  or           a7, gp, a1
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  nop
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  lui          a7, 965626
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  li           s3, 0x80000000 #start riscv_int_numeric_corner_stream_28
                  li           a3, 0x0
                  li           t6, 0x0
                  li           s2, 0x5bfdaded
                  li           s9, 0x0
                  li           a2, 0x0
                  li           s5, 0x80000000
                  li           a6, 0x0
                  li           s1, 0xffffffff
                  li           s6, 0xffffffff
                  lui          a6, 965626
                  lui          a6, 965626
                  add          t6, s9, s1
                  nop
                  lui          a6, 965626
                  addi         s3, a6, -1616
                  auipc        a2, 928829
                  lui          a6, 965626
                  sub          s9, s6, s5
                  auipc        a2, 928829
                  add          t6, s9, s1
                  add          t6, s9, s1
                  lui          a6, 965626
                  addi         s3, a6, -1616
                  nop
                  auipc        a2, 928829
                  sub          s9, s6, s5 #end riscv_int_numeric_corner_stream_28
                  nop
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  nop
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  lui          a7, 965626
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  nop
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  or           a7, gp, a1
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  nop
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  lui          a7, 965626
                  auipc        t5, 928829
                  add          t2, s0, a1
                  lui          a7, 965626
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  nop
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  nop
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  lui          a7, 965626
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  lui          a7, 965626
                  ori          s0, s11, 853
                  nop
                  nop
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  lui          a7, 965626
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  lui          a7, 965626
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  nop
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  lui          a7, 965626
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  and          sp, t3, s7
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  nop
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  add          t2, s0, a1
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  nop
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  lui          a7, 965626
                  lui          a7, 965626
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  nop
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  lui          a7, 965626
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  nop
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  nop
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  nop
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  nop
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  nop
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  nop
                  xor          s0, t6, t0
                  nop
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  nop
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  nop
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  lui          a7, 965626
                  andi         sp, s2, -76
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  nop
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  or           a7, gp, a1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  lui          a7, 965626
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  nop
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  nop
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  slt          sp, s2, t2
                  lui          a7, 965626
                  nop
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  lui          a7, 965626
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  nop
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  nop
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  lui          a7, 965626
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  add          t2, s0, a1
                  nop
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  nop
                  nop
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  nop
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  lui          a7, 965626
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  lui          a7, 965626
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  lui          a7, 965626
                  lui          a7, 965626
                  add          t2, s0, a1
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  lui          a7, 965626
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  nop
                  nop
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  nop
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  nop
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  nop
                  lui          a7, 965626
                  add          t2, s0, a1
                  add          t2, s0, a1
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  nop
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  nop
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  nop
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  li           s5, 0x80000000 #start riscv_int_numeric_corner_stream_38
                  li           s0, 0xeb105bc4
                  li           t4, 0xffffffff
                  li           s4, 0x6af6a4ee
                  li           t5, 0xffffffff
                  li           a5, 0x1c8b2d31
                  li           t0, 0x80000000
                  li           a6, 0x0
                  li           a4, 0xffffffff
                  li           s1, 0x558082f4
                  add          a5, s1, s1
                  auipc        t5, 928829
                  nop
                  auipc        t5, 928829
                  add          a5, s1, s1
                  add          a5, s1, s1
                  nop
                  nop
                  add          a5, s1, s1
                  auipc        t5, 928829
                  nop
                  sub          s4, a5, s5
                  lui          a6, 965626
                  add          a5, s1, s1
                  addi         a6, a6, -1616
                  auipc        t5, 928829
                  auipc        t5, 928829
                  addi         a6, a6, -1616
                  addi         a6, a6, -1616
                  addi         a6, a6, -1616
                  auipc        t5, 928829
                  nop
                  nop
                  add          a5, s1, s1
                  sub          s4, a5, s5
                  add          a5, s1, s1
                  nop #end riscv_int_numeric_corner_stream_38
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  nop
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  lui          a7, 965626
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  lui          a7, 965626
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  nop
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  auipc        t5, 928829
                  lui          a7, 965626
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  lui          a7, 965626
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  lui          a7, 965626
                  and          sp, t3, s7
                  nop
                  nop
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  and          sp, t3, s7
                  or           a7, gp, a1
                  nop
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  nop
                  nop
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  and          sp, t3, s7
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  lui          a7, 965626
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  nop
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  nop
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  nop
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  lui          a7, 965626
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  or           a7, gp, a1
                  and          sp, t3, s7
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  nop
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  and          sp, t3, s7
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  nop
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  nop
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  or           a7, gp, a1
                  nop
                  nop
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  nop
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  lui          a7, 965626
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  or           a7, gp, a1
                  lui          a7, 965626
                  lui          a7, 965626
                  slti         s3, t1, 680
                  lui          a7, 965626
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  nop
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  nop
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  nop
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  lui          a7, 965626
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  nop
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  nop
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  nop
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  lui          a7, 965626
                  nop
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  lui          a7, 965626
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  lui          a7, 965626
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  nop
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  nop
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  nop
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  nop
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  lui          a7, 965626
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  lui          a7, 965626
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  and          sp, t3, s7
                  lui          a7, 965626
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  nop
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  nop
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  nop
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  nop
                  srai         tp, a4, 6
                  nop
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  lui          a7, 965626
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  lui          a7, 965626
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  or           a7, gp, a1
                  nop
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  lui          a7, 965626
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  lui          a7, 965626
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  nop
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  lui          a7, 965626
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  add          t2, s0, a1
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  nop
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  lui          a7, 965626
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  nop
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  lui          a7, 965626
                  lui          a7, 965626
                  or           a7, gp, a1
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  lui          a7, 965626
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  nop
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  nop
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  nop
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  lui          a7, 965626
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  lui          a7, 965626
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  nop
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  nop
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  nop
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  lui          a7, 965626
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  nop
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  lui          a7, 965626
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  lui          a7, 965626
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  nop
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  nop
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  nop
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  nop
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  nop
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  lui          a7, 965626
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  nop
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  nop
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  nop
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  lui          a7, 965626
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  lui          a7, 965626
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  li           a2, 0xef973535 #start riscv_int_numeric_corner_stream_6
                  li           s1, 0x80000000
                  li           t0, 0x0
                  li           t4, 0xffffffff
                  li           s3, 0xffffffff
                  li           a4, 0xffffffff
                  li           a7, 0x80000000
                  li           a5, 0x80000000
                  li           t1, 0x80000000
                  li           s0, 0xffffffff
                  nop
                  lui          a7, 965626
                  nop
                  addi         s3, a7, -1616
                  addi         s3, a7, -1616
                  addi         s3, a7, -1616
                  nop
                  sub          s3, a4, t0
                  auipc        a4, 928829
                  auipc        a4, 928829
                  sub          s3, a4, t0
                  nop
                  add          a5, s1, s1
                  sub          s3, a4, t0
                  add          a5, s1, s1
                  sub          s3, a4, t0
                  addi         s3, a7, -1616
                  add          a5, s1, s1
                  lui          a7, 965626
                  auipc        a4, 928829
                  addi         s3, a7, -1616
                  lui          a7, 965626
                  nop
                  lui          a7, 965626
                  auipc        a4, 928829
                  sub          s3, a4, t0
                  auipc        a4, 928829
                  sub          s3, a4, t0 #end riscv_int_numeric_corner_stream_6
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  lui          a7, 965626
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  lui          a7, 965626
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  nop
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  lui          a7, 965626
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  nop
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  nop
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  nop
                  ori          s0, s11, 853
                  nop
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  add          t2, s0, a1
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  lui          a7, 965626
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  lui          a7, 965626
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  lui          a7, 965626
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  li           t3, 0xa7b0416e #start riscv_int_numeric_corner_stream_37
                  li           s5, 0xffffffff
                  li           s6, 0xc627349b
                  li           t6, 0xd33fee34
                  li           sp, 0x5b5e8ebd
                  li           s1, 0xffffffff
                  li           t1, 0x8f62b69a
                  li           tp, 0x80000000
                  li           a5, 0x80000000
                  li           gp, 0xf16f867b
                  nop
                  add          a5, t3, a5
                  nop
                  addi         s1, s1, -1616
                  addi         s1, s1, -1616
                  nop
                  add          a5, t3, a5
                  sub          t3, s6, s5
                  nop
                  lui          s1, 965626
                  add          a5, t3, a5
                  add          a5, t3, a5
                  nop
                  auipc        t3, 928829
                  lui          s1, 965626
                  auipc        t3, 928829 #end riscv_int_numeric_corner_stream_37
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  lui          a7, 965626
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  auipc        t5, 928829
                  nop
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  lui          a7, 965626
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  nop
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  nop
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  nop
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  nop
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  nop
                  lui          a7, 965626
                  xor          s0, t6, t0
                  nop
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  lui          a7, 965626
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  lui          a7, 965626
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  nop
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  lui          a7, 965626
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  nop
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  add          t2, s0, a1
                  auipc        t5, 928829
                  auipc        t5, 928829
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  nop
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  nop
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  lui          a7, 965626
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  lui          a7, 965626
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  nop
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  nop
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  nop
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  nop
                  or           a7, gp, a1
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  lui          a7, 965626
                  ori          s0, s11, 853
                  nop
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  lui          a7, 965626
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  lui          a7, 965626
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  nop
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  nop
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  nop
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  nop
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  lui          a7, 965626
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  nop
                  and          sp, t3, s7
                  nop
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  lui          a7, 965626
                  slt          sp, s2, t2
                  nop
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  nop
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  nop
                  nop
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  lui          a7, 965626
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  nop
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  nop
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  lui          a7, 965626
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  nop
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  nop
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  lui          a7, 965626
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  nop
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  nop
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  nop
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  lui          a7, 965626
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  lui          a7, 965626
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  auipc        t5, 928829
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  nop
                  or           a7, gp, a1
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  nop
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  lui          a7, 965626
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  nop
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  nop
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  and          sp, t3, s7
                  nop
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  or           a7, gp, a1
                  and          sp, t3, s7
                  nop
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  lui          a7, 965626
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  nop
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  nop
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  nop
                  and          sp, t3, s7
                  add          t2, s0, a1
                  lui          a7, 965626
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  lui          a7, 965626
                  sll          s4, ra, s1
                  nop
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  nop
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  nop
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  lui          a7, 965626
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  lui          a7, 965626
                  slli         a0, a4, 0
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  nop
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  lui          a7, 965626
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  lui          a7, 965626
                  lui          a7, 965626
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  nop
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  lui          a7, 965626
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  lui          a7, 965626
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  auipc        t5, 928829
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  nop
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  lui          a7, 965626
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  lui          a7, 965626
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  nop
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  li           s2, 0x0 #start riscv_int_numeric_corner_stream_26
                  li           a0, 0xffffffff
                  li           a5, 0x0
                  li           a7, 0xffffffff
                  li           a4, 0x3b19a085
                  li           a3, 0x80000000
                  li           ra, 0x80000000
                  li           s9, 0xffffffff
                  li           a6, 0x80000000
                  li           t6, 0xffffffff
                  nop
                  add          a5, a0, a5
                  nop
                  nop
                  add          a5, a0, a5
                  auipc        a4, 928829
                  sub          s9, s2, a3
                  sub          s9, s2, a3
                  sub          s9, s2, a3
                  nop
                  addi         a6, ra, -1616
                  addi         a6, ra, -1616
                  add          a5, a0, a5
                  sub          s9, s2, a3
                  add          a5, a0, a5
                  nop
                  auipc        a4, 928829
                  lui          a7, 965626
                  addi         a6, ra, -1616
                  sub          s9, s2, a3
                  add          a5, a0, a5
                  add          a5, a0, a5
                  add          a5, a0, a5
                  nop
                  nop
                  lui          a7, 965626
                  nop
                  sub          s9, s2, a3
                  addi         a6, ra, -1616 #end riscv_int_numeric_corner_stream_26
                  nop
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  lui          a7, 965626
                  and          sp, t3, s7
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  lui          a7, 965626
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  nop
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  lui          a7, 965626
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  nop
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  nop
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  nop
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  nop
                  lui          a7, 965626
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  lui          a7, 965626
                  and          sp, t3, s7
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  nop
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  lui          a7, 965626
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  lui          a7, 965626
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  nop
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  lui          a7, 965626
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  and          sp, t3, s7
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  add          t2, s0, a1
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  li           s10, 0xbbb06c91 #start riscv_int_numeric_corner_stream_13
                  li           s9, 0x2aa24639
                  li           t3, 0xffffffff
                  li           t0, 0xd3963333
                  li           a6, 0xfbce9b4b
                  li           a4, 0x80000000
                  li           ra, 0xffffffff
                  li           t5, 0x80000000
                  li           s4, 0x3e1131ef
                  li           t6, 0x80000000
                  add          ra, s9, a4
                  nop
                  auipc        t5, 928829
                  auipc        t5, 928829
                  addi         a6, ra, -1616
                  add          ra, s9, a4
                  lui          a6, 965626
                  auipc        t5, 928829
                  lui          a6, 965626
                  add          ra, s9, a4
                  nop
                  lui          a6, 965626
                  nop
                  sub          ra, s10, t0
                  nop
                  addi         a6, ra, -1616
                  sub          ra, s10, t0
                  auipc        t5, 928829
                  auipc        t5, 928829 #end riscv_int_numeric_corner_stream_13
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  nop
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  nop
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  nop
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  nop
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  nop
                  nop
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  lui          a7, 965626
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  lui          a7, 965626
                  lui          a7, 965626
                  srli         s3, zero, 0
                  nop
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  nop
                  li           a4, 0x0 #start riscv_int_numeric_corner_stream_34
                  li           a6, 0x0
                  li           a5, 0xffffffff
                  li           sp, 0x0
                  li           s0, 0xffffffff
                  li           s10, 0xffffffff
                  li           t1, 0x0
                  li           a2, 0xd01e7930
                  li           t0, 0x80000000
                  li           s9, 0x0
                  add          s0, t1, a5
                  auipc        a4, 928829
                  addi         a6, a6, -1616
                  addi         a6, a6, -1616
                  sub          s10, s0, t0
                  lui          a6, 965626
                  addi         a6, a6, -1616
                  add          s0, t1, a5
                  lui          a6, 965626
                  add          s0, t1, a5
                  addi         a6, a6, -1616
                  add          s0, t1, a5
                  auipc        a4, 928829
                  add          s0, t1, a5
                  auipc        a4, 928829
                  lui          a6, 965626
                  lui          a6, 965626
                  auipc        a4, 928829 #end riscv_int_numeric_corner_stream_34
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  lui          a7, 965626
                  add          t2, s0, a1
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  nop
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  lui          a7, 965626
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  nop
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  lui          a7, 965626
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  auipc        t5, 928829
                  nop
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  nop
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  lui          a7, 965626
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  nop
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  nop
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  lui          a7, 965626
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  nop
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  lui          a7, 965626
                  slli         a0, a4, 0
                  lui          a7, 965626
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  lui          a7, 965626
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  nop
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  auipc        t5, 928829
                  nop
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  lui          a7, 965626
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  lui          a7, 965626
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  lui          a7, 965626
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  nop
                  li           s5, 0xdc705cc3 #start riscv_int_numeric_corner_stream_8
                  li           s6, 0x0
                  li           t1, 0x80000000
                  li           a6, 0xffffffff
                  li           t2, 0x80000000
                  li           t3, 0x6cd96d77
                  li           gp, 0xffffffff
                  li           tp, 0x0
                  li           a4, 0x79a7966
                  li           t6, 0xffffffff
                  nop
                  add          t6, t3, t3
                  nop
                  lui          a6, 965626
                  sub          gp, a4, s5
                  lui          a6, 965626
                  auipc        a4, 928829
                  addi         a6, a6, -1616
                  sub          gp, a4, s5
                  sub          gp, a4, s5
                  lui          a6, 965626
                  sub          gp, a4, s5
                  addi         a6, a6, -1616
                  lui          a6, 965626
                  nop
                  auipc        a4, 928829
                  lui          a6, 965626 #end riscv_int_numeric_corner_stream_8
                  andi         sp, s2, -76
                  nop
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  lui          a7, 965626
                  nop
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  nop
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  nop
                  and          sp, t3, s7
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  lui          a7, 965626
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  and          sp, t3, s7
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  nop
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  add          t2, s0, a1
                  or           a7, gp, a1
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  nop
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  lui          a7, 965626
                  nop
                  lui          a7, 965626
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  nop
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  lui          a7, 965626
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  nop
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  nop
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  lui          a7, 965626
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  nop
                  auipc        t5, 928829
                  lui          a7, 965626
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  nop
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  nop
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  lui          a7, 965626
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  lui          a7, 965626
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  nop
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  nop
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  nop
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  lui          a7, 965626
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  nop
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  lui          a7, 965626
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  add          t2, s0, a1
                  nop
                  sra          a4, s5, s6
                  nop
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  nop
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  nop
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  lui          a7, 965626
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  or           a7, gp, a1
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sll          s4, ra, s1
                  lui          a7, 965626
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  nop
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  lui          a7, 965626
                  nop
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  nop
                  nop
                  nop
                  and          sp, t3, s7
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  nop
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  nop
                  nop
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  nop
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sub          s10, s7, s5
                  nop
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  nop
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  lui          a7, 965626
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  nop
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  nop
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  nop
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  nop
                  nop
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  nop
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  lui          a7, 965626
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  auipc        t5, 928829
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  nop
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  nop
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  nop
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  li           s4, 0xffffffff #start riscv_int_numeric_corner_stream_0
                  li           a6, 0x80000000
                  li           s6, 0x80000000
                  li           a4, 0xffffffff
                  li           a0, 0x0
                  li           s3, 0x80000000
                  li           sp, 0xffffffff
                  li           a7, 0xffffffff
                  li           t3, 0xffffffff
                  li           ra, 0xffffffff
                  nop
                  sub          ra, sp, a4
                  add          t3, t3, a4
                  sub          ra, sp, a4
                  nop
                  sub          ra, sp, a4
                  sub          ra, sp, a4
                  add          t3, t3, a4
                  auipc        a4, 928829
                  lui          a6, 965626
                  auipc        a4, 928829
                  nop
                  addi         sp, ra, -1616
                  auipc        a4, 928829
                  add          t3, t3, a4
                  sub          ra, sp, a4
                  lui          a6, 965626
                  add          t3, t3, a4
                  lui          a6, 965626
                  nop
                  addi         sp, ra, -1616
                  lui          a6, 965626
                  add          t3, t3, a4 #end riscv_int_numeric_corner_stream_0
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  nop
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  nop
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  nop
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  nop
                  nop
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  nop
                  nop
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  nop
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  lui          a7, 965626
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  lui          a7, 965626
                  ori          s0, s11, 853
                  nop
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  lui          a7, 965626
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  and          sp, t3, s7
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  nop
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  nop
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  lui          a7, 965626
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  nop
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  add          t2, s0, a1
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  lui          a7, 965626
                  or           a7, gp, a1
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  lui          a7, 965626
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  lui          a7, 965626
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  nop
                  lui          a7, 965626
                  srai         tp, a4, 6
                  nop
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  lui          a7, 965626
                  slti         s3, t1, 680
                  nop
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  nop
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  nop
                  slt          sp, s2, t2
                  nop
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  nop
                  add          t2, s0, a1
                  nop
                  lui          a7, 965626
                  lui          a7, 965626
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  nop
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  nop
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  nop
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  nop
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  lui          a7, 965626
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  nop
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  nop
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  lui          a7, 965626
                  nop
                  add          t2, s0, a1
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  nop
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  nop
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  nop
                  lui          a7, 965626
                  nop
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  nop
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  nop
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  lui          a7, 965626
                  sll          s4, ra, s1
                  lui          a7, 965626
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  nop
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  lui          a7, 965626
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  nop
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  nop
                  lui          a7, 965626
                  lui          a7, 965626
                  ori          s0, s11, 853
                  lui          a7, 965626
                  slti         s3, t1, 680
                  lui          a7, 965626
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  nop
                  ori          s0, s11, 853
                  nop
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  lui          a7, 965626
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  or           a7, gp, a1
                  add          t2, s0, a1
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  lui          a7, 965626
                  auipc        t5, 928829
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  auipc        t5, 928829
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  lui          a7, 965626
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  nop
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  nop
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  nop
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  lui          a7, 965626
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  lui          a7, 965626
                  and          sp, t3, s7
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  nop
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  nop
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  nop
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  nop
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  lui          a7, 965626
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  lui          a7, 965626
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  li           a2, 0x80000000 #start riscv_int_numeric_corner_stream_2
                  li           a4, 0xffffffff
                  li           a3, 0xffffffff
                  li           t2, 0x80000000
                  li           t1, 0xffffffff
                  li           s10, 0x43fc808a
                  li           s5, 0x80000000
                  li           a6, 0xffffffff
                  li           s2, 0xffffffff
                  li           s6, 0x0
                  auipc        a4, 928829
                  auipc        a4, 928829
                  addi         s10, a6, -1616
                  nop
                  addi         s10, a6, -1616
                  auipc        a4, 928829
                  auipc        a4, 928829
                  addi         s10, a6, -1616
                  lui          a6, 965626
                  nop
                  lui          a6, 965626
                  sub          s5, s6, s5
                  nop
                  auipc        a4, 928829
                  lui          a6, 965626
                  add          a2, a2, a3 #end riscv_int_numeric_corner_stream_2
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  nop
                  sub          s10, s7, s5
                  nop
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  nop
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  nop
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  nop
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  nop
                  auipc        t5, 928829
                  or           a7, gp, a1
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  nop
                  nop
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  nop
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  nop
                  nop
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  lui          a7, 965626
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  lui          a7, 965626
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  nop
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  lui          a7, 965626
                  xori         s9, t0, 162
                  nop
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  lui          a7, 965626
                  nop
                  nop
                  nop
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  lui          a7, 965626
                  lui          a7, 965626
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  lui          a7, 965626
                  nop
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  auipc        t5, 928829
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  lui          a7, 965626
                  add          t2, s0, a1
                  nop
                  sll          s4, ra, s1
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  nop
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  lui          a7, 965626
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  nop
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  lui          a7, 965626
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  lui          a7, 965626
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  lui          a7, 965626
                  nop
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  lui          a7, 965626
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  nop
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  lui          a7, 965626
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  nop
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  lui          a7, 965626
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  nop
                  add          t2, s0, a1
                  lui          a7, 965626
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  nop
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  lui          a7, 965626
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  nop
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  nop
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  lui          a7, 965626
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  nop
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  nop
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  nop
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  nop
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  nop
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  nop
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  lui          a7, 965626
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  lui          a7, 965626
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  lui          a7, 965626
                  lui          a7, 965626
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  lui          a7, 965626
                  or           a7, gp, a1
                  lui          a7, 965626
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  and          sp, t3, s7
                  and          sp, t3, s7
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  nop
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  nop
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  lui          a7, 965626
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  nop
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  nop
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  lui          a7, 965626
                  sra          a4, s5, s6
                  lui          a7, 965626
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  nop
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  lui          a7, 965626
                  nop
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  nop
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  auipc        t5, 928829
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  nop
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  auipc        t5, 928829
                  lui          a7, 965626
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  nop
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  nop
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  lui          a7, 965626
                  li           t1, 0xffffffff #start riscv_int_numeric_corner_stream_33
                  li           a3, 0xb417be42
                  li           s2, 0xb96e9bdf
                  li           ra, 0x8e29a2ff
                  li           t4, 0x80000000
                  li           s1, 0xffffffff
                  li           a5, 0x80000000
                  li           t6, 0xffffffff
                  li           a0, 0x589e12af
                  li           t5, 0x0
                  sub          ra, a0, t4
                  sub          ra, a0, t4
                  addi         a0, ra, -1616
                  nop
                  add          a5, a0, s1
                  sub          ra, a0, t4
                  lui          ra, 965626
                  sub          ra, a0, t4
                  nop
                  auipc        t5, 928829
                  lui          ra, 965626
                  nop
                  auipc        t5, 928829
                  add          a5, a0, s1
                  add          a5, a0, s1 #end riscv_int_numeric_corner_stream_33
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  nop
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  lui          a7, 965626
                  nop
                  and          sp, t3, s7
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  nop
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  and          sp, t3, s7
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  li           t0, 0x5dff454b #start riscv_int_numeric_corner_stream_1
                  li           a7, 0x3d72b4ad
                  li           s2, 0x80000000
                  li           s3, 0xffffffff
                  li           s5, 0x80000000
                  li           s11, 0x0
                  li           sp, 0x80000000
                  li           gp, 0xffffffff
                  li           ra, 0x0
                  li           a2, 0x80000000
                  addi         sp, ra, -1616
                  lui          a7, 965626
                  sub          s11, s11, t0
                  auipc        a2, 928829
                  sub          s11, s11, t0
                  add          sp, s5, a2
                  addi         sp, ra, -1616
                  addi         sp, ra, -1616
                  sub          s11, s11, t0
                  nop
                  lui          a7, 965626
                  lui          a7, 965626
                  lui          a7, 965626
                  auipc        a2, 928829
                  lui          a7, 965626
                  lui          a7, 965626
                  lui          a7, 965626
                  lui          a7, 965626
                  auipc        a2, 928829
                  lui          a7, 965626
                  addi         sp, ra, -1616
                  addi         sp, ra, -1616
                  auipc        a2, 928829
                  add          sp, s5, a2
                  auipc        a2, 928829
                  addi         sp, ra, -1616
                  addi         sp, ra, -1616 #end riscv_int_numeric_corner_stream_1
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  nop
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  or           a7, gp, a1
                  auipc        t5, 928829
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  nop
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  and          sp, t3, s7
                  auipc        t5, 928829
                  lui          a7, 965626
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  nop
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  nop
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_11
                  li           s9, 0xd805e101
                  li           a5, 0xffffffff
                  li           a3, 0xffffffff
                  li           s0, 0x80000000
                  li           a2, 0x80000000
                  li           t1, 0x80000000
                  li           gp, 0x0
                  li           t2, 0x80000000
                  li           t6, 0x80000000
                  nop
                  sub          gp, s0, a3
                  sub          gp, s0, a3
                  add          a5, s11, a3
                  add          a5, s11, a3
                  addi         gp, s0, -1616
                  auipc        t1, 928829
                  sub          gp, s0, a3
                  lui          a2, 965626
                  auipc        t1, 928829
                  nop
                  add          a5, s11, a3
                  nop
                  add          a5, s11, a3
                  lui          a2, 965626
                  addi         gp, s0, -1616
                  add          a5, s11, a3
                  add          a5, s11, a3 #end riscv_int_numeric_corner_stream_11
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  nop
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  nop
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  auipc        t5, 928829
                  and          sp, t3, s7
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  lui          a7, 965626
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  nop
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  nop
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  nop
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  lui          a7, 965626
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  nop
                  or           a7, gp, a1
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  nop
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  nop
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  lui          a7, 965626
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  nop
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  lui          a7, 965626
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  lui          a7, 965626
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  nop
                  nop
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  lui          a7, 965626
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  nop
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  nop
                  sub          s10, s7, s5
                  lui          a7, 965626
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  li           s3, 0x0 #start riscv_int_numeric_corner_stream_4
                  li           t2, 0xffffffff
                  li           s0, 0x0
                  li           gp, 0x80000000
                  li           a2, 0x0
                  li           t1, 0x80000000
                  li           a4, 0x80000000
                  li           s10, 0xade29b85
                  li           s5, 0xffffffff
                  li           s1, 0x0
                  lui          s1, 965626
                  nop
                  addi         s3, s0, -1616
                  nop
                  addi         s3, s0, -1616
                  sub          s10, s0, s5
                  add          s1, a2, s1
                  add          s1, a2, s1
                  sub          s10, s0, s5
                  nop
                  auipc        a4, 928829
                  nop
                  nop
                  lui          s1, 965626
                  addi         s3, s0, -1616
                  sub          s10, s0, s5
                  nop
                  auipc        a4, 928829
                  lui          s1, 965626
                  addi         s3, s0, -1616
                  nop
                  sub          s10, s0, s5
                  addi         s3, s0, -1616
                  auipc        a4, 928829
                  nop
                  sub          s10, s0, s5
                  add          s1, a2, s1
                  auipc        a4, 928829
                  auipc        a4, 928829
                  addi         s3, s0, -1616 #end riscv_int_numeric_corner_stream_4
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  li           t6, 0x80000000 #start riscv_int_numeric_corner_stream_16
                  li           t5, 0x0
                  li           a6, 0x0
                  li           sp, 0x80000000
                  li           s2, 0x0
                  li           t1, 0x80000000
                  li           s0, 0x0
                  li           a4, 0xffffffff
                  li           tp, 0x0
                  li           s9, 0x9ba75c
                  auipc        t5, 928829
                  addi         s2, a6, -1616
                  nop
                  sub          s0, sp, tp
                  addi         s2, a6, -1616
                  auipc        t5, 928829
                  lui          a6, 965626
                  lui          a6, 965626
                  nop
                  nop
                  lui          a6, 965626
                  sub          s0, sp, tp
                  addi         s2, a6, -1616
                  lui          a6, 965626
                  sub          s0, sp, tp
                  add          s0, tp, a4
                  nop
                  add          s0, tp, a4
                  addi         s2, a6, -1616
                  nop
                  add          s0, tp, a4
                  sub          s0, sp, tp
                  auipc        t5, 928829
                  nop
                  add          s0, tp, a4
                  nop
                  auipc        t5, 928829
                  addi         s2, a6, -1616
                  add          s0, tp, a4 #end riscv_int_numeric_corner_stream_16
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  auipc        t5, 928829
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  nop
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  lui          a7, 965626
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  nop
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  nop
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  add          t2, s0, a1
                  nop
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  lui          a7, 965626
                  nop
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  lui          a7, 965626
                  nop
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  or           a7, gp, a1
                  or           a7, gp, a1
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  or           a7, gp, a1
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  nop
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  add          t2, s0, a1
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  nop
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  lui          a7, 965626
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  lui          a7, 965626
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  nop
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  nop
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  and          sp, t3, s7
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  lui          a7, 965626
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  nop
                  and          sp, t3, s7
                  lui          a7, 965626
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  lui          a7, 965626
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  nop
                  or           a7, gp, a1
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  lui          a7, 965626
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  nop
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  lui          a7, 965626
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  nop
                  sra          a4, s5, s6
                  lui          a7, 965626
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  and          sp, t3, s7
                  nop
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  nop
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  nop
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  or           a7, gp, a1
                  and          sp, t3, s7
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  and          sp, t3, s7
                  li           sp, 0x0 #start riscv_int_numeric_corner_stream_15
                  li           t4, 0x80000000
                  li           t6, 0x905988f1
                  li           a3, 0x80000000
                  li           t1, 0x47014089
                  li           t5, 0x3914c91b
                  li           s5, 0xffffffff
                  li           s0, 0x0
                  li           s2, 0x80000000
                  li           t3, 0xffffffff
                  auipc        t5, 928829
                  auipc        t5, 928829
                  addi         s2, s0, -1616
                  add          s0, t3, a3
                  nop
                  addi         s2, s0, -1616
                  sub          t3, t5, s5
                  add          s0, t3, a3
                  addi         s2, s0, -1616
                  nop
                  auipc        t5, 928829
                  add          s0, t3, a3
                  nop
                  add          s0, t3, a3
                  auipc        t5, 928829
                  nop
                  auipc        t5, 928829
                  addi         s2, s0, -1616
                  nop
                  add          s0, t3, a3
                  nop
                  addi         s2, s0, -1616
                  addi         s2, s0, -1616
                  sub          t3, t5, s5 #end riscv_int_numeric_corner_stream_15
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  nop
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  lui          a7, 965626
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  nop
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  nop
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  lui          a7, 965626
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  li           t1, 0xee544c9b #start riscv_int_numeric_corner_stream_31
                  li           a2, 0x0
                  li           gp, 0x80000000
                  li           s6, 0x7e05d00c
                  li           tp, 0xffffffff
                  li           t0, 0x0
                  li           t6, 0x80000000
                  li           ra, 0x0
                  li           a4, 0x80000000
                  li           t2, 0x80000000
                  auipc        a4, 928829
                  auipc        a4, 928829
                  add          ra, s6, a4
                  addi         gp, ra, -1616
                  nop
                  sub          gp, a2, t0
                  add          ra, s6, a4
                  sub          gp, a2, t0
                  addi         gp, ra, -1616
                  addi         gp, ra, -1616
                  sub          gp, a2, t0
                  addi         gp, ra, -1616
                  lui          a2, 965626
                  auipc        a4, 928829
                  addi         gp, ra, -1616
                  auipc        a4, 928829
                  nop
                  auipc        a4, 928829
                  auipc        a4, 928829
                  lui          a2, 965626
                  add          ra, s6, a4
                  lui          a2, 965626
                  add          ra, s6, a4 #end riscv_int_numeric_corner_stream_31
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  nop
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  lui          a7, 965626
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  nop
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  nop
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  nop
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  lui          a7, 965626
                  lui          a7, 965626
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  nop
                  lui          a7, 965626
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  nop
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  nop
                  srli         s3, zero, 0
                  lui          a7, 965626
                  nop
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  or           a7, gp, a1
                  nop
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  lui          a7, 965626
                  lui          a7, 965626
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  lui          a7, 965626
                  slti         s3, t1, 680
                  nop
                  nop
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  li           s1, 0xcb8343f9 #start riscv_int_numeric_corner_stream_3
                  li           s11, 0x0
                  li           ra, 0x5790cca1
                  li           a3, 0x0
                  li           t1, 0xc8c9d875
                  li           a7, 0x0
                  li           s0, 0x9775e4d2
                  li           s2, 0xffffffff
                  li           t2, 0xffffffff
                  li           t0, 0x0
                  addi         s2, ra, -1616
                  addi         s2, ra, -1616
                  sub          s2, s2, t0
                  lui          a7, 965626
                  add          a3, s11, s1
                  auipc        s0, 928829
                  add          a3, s11, s1
                  nop
                  nop
                  sub          s2, s2, t0
                  nop
                  lui          a7, 965626
                  addi         s2, ra, -1616
                  lui          a7, 965626
                  sub          s2, s2, t0
                  auipc        s0, 928829
                  lui          a7, 965626
                  addi         s2, ra, -1616
                  nop #end riscv_int_numeric_corner_stream_3
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  nop
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  nop
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  xor          s0, t6, t0
                  lui          a7, 965626
                  lui          a7, 965626
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  lui          a7, 965626
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  lui          a7, 965626
                  nop
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  nop
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  nop
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  nop
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  lui          a7, 965626
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  nop
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  nop
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  nop
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  nop
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  nop
                  sltiu        s6, t6, -959
                  nop
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  nop
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  auipc        t5, 928829
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  li           a7, 0x0 #start riscv_int_numeric_corner_stream_24
                  li           a6, 0xffffffff
                  li           s0, 0xffffffff
                  li           t5, 0xf2f28a3
                  li           ra, 0x0
                  li           a3, 0x518ebaa3
                  li           t0, 0xffffffff
                  li           s4, 0x76655d96
                  li           t1, 0x80000000
                  li           t2, 0x0
                  lui          a6, 965626
                  add          a3, s4, a3
                  addi         a6, ra, -1616
                  add          a3, s4, a3
                  auipc        t5, 928829
                  sub          a7, t5, t0
                  sub          a7, t5, t0
                  lui          a6, 965626
                  add          a3, s4, a3
                  add          a3, s4, a3
                  sub          a7, t5, t0
                  sub          a7, t5, t0
                  sub          a7, t5, t0
                  add          a3, s4, a3
                  lui          a6, 965626
                  auipc        t5, 928829
                  lui          a6, 965626
                  nop
                  lui          a6, 965626 #end riscv_int_numeric_corner_stream_24
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  srai         tp, a4, 6
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  lui          a7, 965626
                  slt          sp, s2, t2
                  lui          a7, 965626
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  nop
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  nop
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  nop
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  auipc        t5, 928829
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  add          t2, s0, a1
                  nop
                  add          t2, s0, a1
                  nop
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  nop
                  auipc        t5, 928829
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  nop
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  lui          a7, 965626
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  nop
                  nop
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  lui          a7, 965626
                  nop
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  lui          a7, 965626
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  nop
                  lui          a7, 965626
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  nop
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  lui          a7, 965626
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  and          sp, t3, s7
                  add          t2, s0, a1
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  lui          a7, 965626
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  nop
                  auipc        t5, 928829
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  and          sp, t3, s7
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  nop
                  and          sp, t3, s7
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  nop
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  lui          a7, 965626
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  nop
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  nop
                  sll          s4, ra, s1
                  lui          a7, 965626
                  lui          a7, 965626
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  lui          a7, 965626
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  nop
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  or           a7, gp, a1
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  and          sp, t3, s7
                  lui          a7, 965626
                  nop
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  sltiu        s6, t6, -959
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  nop
                  auipc        t5, 928829
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  lui          a7, 965626
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  nop
                  and          sp, t3, s7
                  lui          a7, 965626
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  nop
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  lui          a7, 965626
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  nop
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  lui          a7, 965626
                  ori          s0, s11, 853
                  lui          a7, 965626
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  lui          a7, 965626
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  add          t2, s0, a1
                  lui          a7, 965626
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  lui          a7, 965626
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  nop
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  nop
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  lui          a7, 965626
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  auipc        t5, 928829
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  lui          a7, 965626
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  nop
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  lui          a7, 965626
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  and          sp, t3, s7
                  lui          a7, 965626
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  nop
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  nop
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  nop
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  nop
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  nop
                  xori         s9, t0, 162
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  add          t2, s0, a1
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  nop
                  nop
                  andi         sp, s2, -76
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  nop
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  nop
                  add          t2, s0, a1
                  lui          a7, 965626
                  xori         s9, t0, 162
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  sltiu        s6, t6, -959
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  lui          a7, 965626
                  auipc        t5, 928829
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  auipc        t5, 928829
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  xor          s0, t6, t0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  nop
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  or           a7, gp, a1
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  sra          a4, s5, s6
                  lui          a7, 965626
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  srai         tp, a4, 6
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  srai         tp, a4, 6
                  andi         sp, s2, -76
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  lui          a7, 965626
                  auipc        t5, 928829
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  srli         s3, zero, 0
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  lui          a7, 965626
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  nop
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  sltu         t6, a6, a5
                  sub          s10, s7, s5
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  lui          a7, 965626
                  andi         sp, s2, -76
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  nop
                  auipc        t5, 928829
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  lui          a7, 965626
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  or           a7, gp, a1
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  nop
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  lui          a7, 965626
                  srai         tp, a4, 6
                  nop
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  lui          a7, 965626
                  add          t2, s0, a1
                  add          t2, s0, a1
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  lui          a7, 965626
                  sra          a4, s5, s6
                  sub          s10, s7, s5
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  sub          s10, s7, s5
                  nop
                  or           a7, gp, a1
                  nop
                  andi         sp, s2, -76
                  slt          sp, s2, t2
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  xor          s0, t6, t0
                  lui          a7, 965626
                  sub          s10, s7, s5
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  nop
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  lui          a7, 965626
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  lui          a7, 965626
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  srai         tp, a4, 6
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  nop
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  nop
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  or           a7, gp, a1
                  auipc        t5, 928829
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  lui          a7, 965626
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  nop
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  nop
                  nop
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  auipc        t5, 928829
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  auipc        t5, 928829
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  or           a7, gp, a1
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  lui          a7, 965626
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  nop
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  lui          a7, 965626
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  slti         s3, t1, 680
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  slti         s3, t1, 680
                  auipc        t5, 928829
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  xor          s0, t6, t0
                  lui          a7, 965626
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  nop
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  nop
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  nop
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  nop
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  add          t2, s0, a1
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  lui          a7, 965626
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  li           a4, 0x80000000 #start riscv_int_numeric_corner_stream_36
                  li           t0, 0xe416aa5f
                  li           a7, 0x0
                  li           s10, 0x80000000
                  li           t1, 0xce0bcf5b
                  li           a3, 0xffffffff
                  li           a6, 0xffffffff
                  li           t4, 0x0
                  li           s4, 0x0
                  li           a5, 0x80000000
                  auipc        a4, 928829
                  add          a4, s10, a3
                  addi         a7, a6, -1616
                  auipc        a4, 928829
                  auipc        a4, 928829
                  nop
                  nop
                  lui          a7, 965626
                  sub          s10, s10, t0
                  auipc        a4, 928829
                  addi         a7, a6, -1616
                  addi         a7, a6, -1616
                  add          a4, s10, a3
                  auipc        a4, 928829
                  lui          a7, 965626
                  add          a4, s10, a3
                  sub          s10, s10, t0
                  nop
                  add          a4, s10, a3
                  nop
                  add          a4, s10, a3
                  add          a4, s10, a3
                  lui          a7, 965626
                  addi         a7, a6, -1616 #end riscv_int_numeric_corner_stream_36
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  auipc        t5, 928829
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  ori          s0, s11, 853
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  lui          a7, 965626
                  xori         s9, t0, 162
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  srli         s3, zero, 0
                  nop
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  nop
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  nop
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  sub          s10, s7, s5
                  nop
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  ori          s0, s11, 853
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  andi         sp, s2, -76
                  srl          a4, s10, t4
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  slti         s3, t1, 680
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  ori          s0, s11, 853
                  srli         s3, zero, 0
                  and          sp, t3, s7
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  lui          a7, 965626
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  nop
                  or           a7, gp, a1
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  nop
                  nop
                  addi         s9, zero, -1616
                  slt          sp, s2, t2
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  srai         tp, a4, 6
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  nop
                  srl          a4, s10, t4
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  lui          a7, 965626
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  nop
                  and          sp, t3, s7
                  lui          a7, 965626
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  nop
                  slli         a0, a4, 0
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  or           a7, gp, a1
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  lui          a7, 965626
                  or           a7, gp, a1
                  and          sp, t3, s7
                  slt          sp, s2, t2
                  addi         s9, zero, -1616
                  add          t2, s0, a1
                  sub          s10, s7, s5
                  add          t2, s0, a1
                  lui          a7, 965626
                  xor          s0, t6, t0
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  sltu         t6, a6, a5
                  add          t2, s0, a1
                  nop
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  andi         sp, s2, -76
                  xori         s9, t0, 162
                  xori         s9, t0, 162
                  and          sp, t3, s7
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  lui          a7, 965626
                  or           a7, gp, a1
                  slt          sp, s2, t2
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  add          t2, s0, a1
                  auipc        t5, 928829
                  or           a7, gp, a1
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  sltiu        s6, t6, -959
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  lui          a7, 965626
                  and          sp, t3, s7
                  add          t2, s0, a1
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  sltu         t6, a6, a5
                  auipc        t5, 928829
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  srli         s3, zero, 0
                  addi         s9, zero, -1616
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  or           a7, gp, a1
                  auipc        t5, 928829
                  add          t2, s0, a1
                  nop
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  lui          a7, 965626
                  sra          a4, s5, s6
                  sltu         t6, a6, a5
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  lui          a7, 965626
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  and          sp, t3, s7
                  slti         s3, t1, 680
                  addi         s9, zero, -1616
                  or           a7, gp, a1
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  slt          sp, s2, t2
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  lui          a7, 965626
                  srl          a4, s10, t4
                  sltu         t6, a6, a5
                  addi         s9, zero, -1616
                  sra          a4, s5, s6
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  auipc        t5, 928829
                  nop
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  slt          sp, s2, t2
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  xor          s0, t6, t0
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  add          t2, s0, a1
                  sltu         t6, a6, a5
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  lui          a7, 965626
                  xori         s9, t0, 162
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  add          t2, s0, a1
                  lui          a7, 965626
                  lui          a7, 965626
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  srli         s3, zero, 0
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  sra          a4, s5, s6
                  lui          a7, 965626
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  auipc        t5, 928829
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  add          t2, s0, a1
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  sra          a4, s5, s6
                  xori         s9, t0, 162
                  lui          a7, 965626
                  slti         s3, t1, 680
                  srli         s3, zero, 0
                  srli         s3, zero, 0
                  nop
                  slti         s3, t1, 680
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  addi         s9, zero, -1616
                  and          sp, t3, s7
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  srai         tp, a4, 6
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  andi         sp, s2, -76
                  lui          a7, 965626
                  auipc        t5, 928829
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  addi         s9, zero, -1616
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  addi         s9, zero, -1616
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  nop
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  sub          s10, s7, s5
                  xor          s0, t6, t0
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  slt          sp, s2, t2
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  xori         s9, t0, 162
                  slli         a0, a4, 0
                  nop
                  or           a7, gp, a1
                  or           a7, gp, a1
                  auipc        t5, 928829
                  slti         s3, t1, 680
                  lui          a7, 965626
                  add          t2, s0, a1
                  ori          s0, s11, 853
                  xor          s0, t6, t0
                  srai         tp, a4, 6
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  xori         s9, t0, 162
                  add          t2, s0, a1
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  and          sp, t3, s7
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  slt          sp, s2, t2
                  ori          s0, s11, 853
                  lui          a7, 965626
                  and          sp, t3, s7
                  sra          a4, s5, s6
                  lui          a7, 965626
                  xor          s0, t6, t0
                  srl          a4, s10, t4
                  nop
                  lui          a7, 965626
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  slti         s3, t1, 680
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  slt          sp, s2, t2
                  srl          a4, s10, t4
                  sra          a4, s5, s6
                  add          t2, s0, a1
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  srai         tp, a4, 6
                  add          t2, s0, a1
                  or           a7, gp, a1
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  slli         a0, a4, 0
                  lui          a7, 965626
                  sub          s10, s7, s5
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  nop
                  xori         s9, t0, 162
                  srai         tp, a4, 6
                  and          sp, t3, s7
                  xor          s0, t6, t0
                  and          sp, t3, s7
                  addi         s9, zero, -1616
                  sub          s10, s7, s5
                  lui          a7, 965626
                  srl          a4, s10, t4
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  and          sp, t3, s7
                  add          t2, s0, a1
                  xor          s0, t6, t0
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  or           a7, gp, a1
                  xor          s0, t6, t0
                  lui          a7, 965626
                  sra          a4, s5, s6
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  add          t2, s0, a1
                  nop
                  slt          sp, s2, t2
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  slt          sp, s2, t2
                  xori         s9, t0, 162
                  sltu         t6, a6, a5
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  sltu         t6, a6, a5
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  sltiu        s6, t6, -959
                  addi         s9, zero, -1616
                  slli         a0, a4, 0
                  srli         s3, zero, 0
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  slli         a0, a4, 0
                  sltiu        s6, t6, -959
                  sra          a4, s5, s6
                  or           a7, gp, a1
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  auipc        t5, 928829
                  xor          s0, t6, t0
                  sub          s10, s7, s5
                  or           a7, gp, a1
                  and          sp, t3, s7
                  add          t2, s0, a1
                  nop
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  sltiu        s6, t6, -959
                  xori         s9, t0, 162
                  nop
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  srai         tp, a4, 6
                  srl          a4, s10, t4
                  ori          s0, s11, 853
                  add          t2, s0, a1
                  xori         s9, t0, 162
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  srli         s3, zero, 0
                  ori          s0, s11, 853
                  addi         s9, zero, -1616
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  and          sp, t3, s7
                  and          sp, t3, s7
                  nop
                  ori          s0, s11, 853
                  xori         s9, t0, 162
                  sra          a4, s5, s6
                  slli         a0, a4, 0
                  andi         sp, s2, -76
                  slli         a0, a4, 0
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  sub          s10, s7, s5
                  sra          a4, s5, s6
                  slti         s3, t1, 680
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  xor          s0, t6, t0
                  ori          s0, s11, 853
                  or           a7, gp, a1
                  andi         sp, s2, -76
                  slti         s3, t1, 680
                  slt          sp, s2, t2
                  nop
                  auipc        t5, 928829
                  srl          a4, s10, t4
                  andi         sp, s2, -76
                  srli         s3, zero, 0
                  sltu         t6, a6, a5
                  slt          sp, s2, t2
                  sub          s10, s7, s5
                  slli         a0, a4, 0
                  sra          a4, s5, s6
                  nop
                  or           a7, gp, a1
                  li           t6, 0x98722e1e #start riscv_int_numeric_corner_stream_19
                  li           s10, 0x80000000
                  li           sp, 0x6411f357
                  li           s5, 0x0
                  li           t2, 0xffffffff
                  li           a2, 0xede5a8ec
                  li           s0, 0xd98e82c3
                  li           a6, 0x60c72c2f
                  li           t1, 0x5ade6379
                  li           s6, 0x80000000
                  addi         s0, s0, -1616
                  nop
                  add          s0, a2, a2
                  add          s0, a2, a2
                  sub          s5, s6, s5
                  add          s0, a2, a2
                  nop
                  sub          s5, s6, s5
                  add          s0, a2, a2
                  addi         s0, s0, -1616
                  sub          s5, s6, s5
                  nop
                  auipc        a2, 928829
                  nop
                  auipc        a2, 928829
                  addi         s0, s0, -1616
                  nop
                  auipc        a2, 928829 #end riscv_int_numeric_corner_stream_19
                  sra          a4, s5, s6
                  sll          s4, ra, s1
                  ori          s0, s11, 853
                  slli         a0, a4, 0
                  srai         tp, a4, 6
                  slli         a0, a4, 0
                  auipc        t5, 928829
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  slti         s3, t1, 680
                  and          sp, t3, s7
                  sll          s4, ra, s1
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  andi         sp, s2, -76
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  sra          a4, s5, s6
                  srl          a4, s10, t4
                  auipc        t5, 928829
                  srli         s3, zero, 0
                  xor          s0, t6, t0
                  xori         s9, t0, 162
                  sll          s4, ra, s1
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  lui          a7, 965626
                  addi         s9, zero, -1616
                  auipc        t5, 928829
                  add          t2, s0, a1
                  auipc        t5, 928829
                  slli         a0, a4, 0
                  ori          s0, s11, 853
                  srl          a4, s10, t4
                  addi         s9, zero, -1616
                  srli         s3, zero, 0
                  add          t2, s0, a1
                  add          t2, s0, a1
                  and          sp, t3, s7
                  sltiu        s6, t6, -959
                  slti         s3, t1, 680
                  add          t2, s0, a1
                  sll          s4, ra, s1
                  sltiu        s6, t6, -959
                  ori          s0, s11, 853
                  nop
                  slti         s3, t1, 680
                  sub          s10, s7, s5
                  andi         sp, s2, -76
                  sll          s4, ra, s1
                  andi         sp, s2, -76
                  srai         tp, a4, 6
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  slli         a0, a4, 0
                  sltu         t6, a6, a5
                  sll          s4, ra, s1
                  sub          s10, s7, s5
                  lui          a7, 965626
                  add          t2, s0, a1
                  lui          a7, 965626
                  ori          s0, s11, 853
                  nop
                  sub          s10, s7, s5
                  sll          s4, ra, s1
                  srl          a4, s10, t4
                  and          sp, t3, s7
                  xori         s9, t0, 162
                  slti         s3, t1, 680
                  slti         s3, t1, 680
                  la x24, test_done
                  jalr x0, x24, 0
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
.align           2
mtvec_handler:    
                  addi x11, x11, -4
                  sw  x23, (x11)
                  add x23, x11, zero
                  addi x23, x23, -128
                  sw  x1, 4(x23)
                  sw  x2, 8(x23)
                  sw  x3, 12(x23)
                  sw  x4, 16(x23)
                  sw  x5, 20(x23)
                  sw  x6, 24(x23)
                  sw  x7, 28(x23)
                  sw  x8, 32(x23)
                  sw  x9, 36(x23)
                  sw  x10, 40(x23)
                  sw  x11, 44(x23)
                  sw  x12, 48(x23)
                  sw  x13, 52(x23)
                  sw  x14, 56(x23)
                  sw  x15, 60(x23)
                  sw  x16, 64(x23)
                  sw  x17, 68(x23)
                  sw  x18, 72(x23)
                  sw  x19, 76(x23)
                  sw  x20, 80(x23)
                  sw  x21, 84(x23)
                  sw  x22, 88(x23)
                  sw  x23, 92(x23)
                  sw  x24, 96(x23)
                  sw  x25, 100(x23)
                  sw  x26, 104(x23)
                  sw  x27, 108(x23)
                  sw  x28, 112(x23)
                  sw  x29, 116(x23)
                  sw  x30, 120(x23)
                  sw  x31, 124(x23)
                  add x11, x23, zero
                  csrr x19, 0x300 # MSTATUS
                  csrr x19, 0x342 # MCAUSE
                  srli x19, x19, 31
                  bne x19, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x19, 0x341 # MEPC
                  csrr x19, 0x342 # MCAUSE
                  li x10, 0x3 # BREAKPOINT
                  beq x19, x10, ebreak_handler
                  li x10, 0x8 # ECALL_UMODE
                  beq x19, x10, ecall_handler
                  li x10, 0x9 # ECALL_SMODE
                  beq x19, x10, ecall_handler
                  li x10, 0xb # ECALL_MMODE
                  beq x19, x10, ecall_handler
                  li x10, 0x1
                  beq x19, x10, instr_fault_handler
                  li x10, 0x5
                  beq x19, x10, load_fault_handler
                  li x10, 0x7
                  beq x19, x10, store_fault_handler
                  li x10, 0xc
                  beq x19, x10, pt_fault_handler
                  li x10, 0xd
                  beq x19, x10, pt_fault_handler
                  li x10, 0xf
                  beq x19, x10, pt_fault_handler
                  li x10, 0x2 # ILLEGAL_INSTRUCTION
                  beq x19, x10, illegal_instr_handler
                  csrr x10, 0x343 # MTVAL
                  1: la x24, test_done
                  jalr x1, x24, 0

ecall_handler:    
                  la x19, _start
                  sw x0, 0(x19)
                  sw x1, 4(x19)
                  sw x2, 8(x19)
                  sw x3, 12(x19)
                  sw x4, 16(x19)
                  sw x5, 20(x19)
                  sw x6, 24(x19)
                  sw x7, 28(x19)
                  sw x8, 32(x19)
                  sw x9, 36(x19)
                  sw x10, 40(x19)
                  sw x11, 44(x19)
                  sw x12, 48(x19)
                  sw x13, 52(x19)
                  sw x14, 56(x19)
                  sw x15, 60(x19)
                  sw x16, 64(x19)
                  sw x17, 68(x19)
                  sw x18, 72(x19)
                  sw x19, 76(x19)
                  sw x20, 80(x19)
                  sw x21, 84(x19)
                  sw x22, 88(x19)
                  sw x23, 92(x19)
                  sw x24, 96(x19)
                  sw x25, 100(x19)
                  sw x26, 104(x19)
                  sw x27, 108(x19)
                  sw x28, 112(x19)
                  sw x29, 116(x19)
                  sw x30, 120(x19)
                  sw x31, 124(x19)
                  la x24, write_tohost
                  jalr x0, x24, 0

instr_fault_handler:
                  add x23, x11, zero
                  lw  x1, 4(x23)
                  lw  x2, 8(x23)
                  lw  x3, 12(x23)
                  lw  x4, 16(x23)
                  lw  x5, 20(x23)
                  lw  x6, 24(x23)
                  lw  x7, 28(x23)
                  lw  x8, 32(x23)
                  lw  x9, 36(x23)
                  lw  x10, 40(x23)
                  lw  x11, 44(x23)
                  lw  x12, 48(x23)
                  lw  x13, 52(x23)
                  lw  x14, 56(x23)
                  lw  x15, 60(x23)
                  lw  x16, 64(x23)
                  lw  x17, 68(x23)
                  lw  x18, 72(x23)
                  lw  x19, 76(x23)
                  lw  x20, 80(x23)
                  lw  x21, 84(x23)
                  lw  x22, 88(x23)
                  lw  x23, 92(x23)
                  lw  x24, 96(x23)
                  lw  x25, 100(x23)
                  lw  x26, 104(x23)
                  lw  x27, 108(x23)
                  lw  x28, 112(x23)
                  lw  x29, 116(x23)
                  lw  x30, 120(x23)
                  lw  x31, 124(x23)
                  addi x23, x23, 128
                  add x11, x23, zero
                  lw  x23, (x11)
                  addi x11, x11, 4
                  mret

load_fault_handler:
                  add x23, x11, zero
                  lw  x1, 4(x23)
                  lw  x2, 8(x23)
                  lw  x3, 12(x23)
                  lw  x4, 16(x23)
                  lw  x5, 20(x23)
                  lw  x6, 24(x23)
                  lw  x7, 28(x23)
                  lw  x8, 32(x23)
                  lw  x9, 36(x23)
                  lw  x10, 40(x23)
                  lw  x11, 44(x23)
                  lw  x12, 48(x23)
                  lw  x13, 52(x23)
                  lw  x14, 56(x23)
                  lw  x15, 60(x23)
                  lw  x16, 64(x23)
                  lw  x17, 68(x23)
                  lw  x18, 72(x23)
                  lw  x19, 76(x23)
                  lw  x20, 80(x23)
                  lw  x21, 84(x23)
                  lw  x22, 88(x23)
                  lw  x23, 92(x23)
                  lw  x24, 96(x23)
                  lw  x25, 100(x23)
                  lw  x26, 104(x23)
                  lw  x27, 108(x23)
                  lw  x28, 112(x23)
                  lw  x29, 116(x23)
                  lw  x30, 120(x23)
                  lw  x31, 124(x23)
                  addi x23, x23, 128
                  add x11, x23, zero
                  lw  x23, (x11)
                  addi x11, x11, 4
                  mret

store_fault_handler:
                  add x23, x11, zero
                  lw  x1, 4(x23)
                  lw  x2, 8(x23)
                  lw  x3, 12(x23)
                  lw  x4, 16(x23)
                  lw  x5, 20(x23)
                  lw  x6, 24(x23)
                  lw  x7, 28(x23)
                  lw  x8, 32(x23)
                  lw  x9, 36(x23)
                  lw  x10, 40(x23)
                  lw  x11, 44(x23)
                  lw  x12, 48(x23)
                  lw  x13, 52(x23)
                  lw  x14, 56(x23)
                  lw  x15, 60(x23)
                  lw  x16, 64(x23)
                  lw  x17, 68(x23)
                  lw  x18, 72(x23)
                  lw  x19, 76(x23)
                  lw  x20, 80(x23)
                  lw  x21, 84(x23)
                  lw  x22, 88(x23)
                  lw  x23, 92(x23)
                  lw  x24, 96(x23)
                  lw  x25, 100(x23)
                  lw  x26, 104(x23)
                  lw  x27, 108(x23)
                  lw  x28, 112(x23)
                  lw  x29, 116(x23)
                  lw  x30, 120(x23)
                  lw  x31, 124(x23)
                  addi x23, x23, 128
                  add x11, x23, zero
                  lw  x23, (x11)
                  addi x11, x11, 4
                  mret

ebreak_handler:   
                  csrr  x19, 0x341
                  addi  x19, x19, 4
                  csrw  0x341, x19
                  add x23, x11, zero
                  lw  x1, 4(x23)
                  lw  x2, 8(x23)
                  lw  x3, 12(x23)
                  lw  x4, 16(x23)
                  lw  x5, 20(x23)
                  lw  x6, 24(x23)
                  lw  x7, 28(x23)
                  lw  x8, 32(x23)
                  lw  x9, 36(x23)
                  lw  x10, 40(x23)
                  lw  x11, 44(x23)
                  lw  x12, 48(x23)
                  lw  x13, 52(x23)
                  lw  x14, 56(x23)
                  lw  x15, 60(x23)
                  lw  x16, 64(x23)
                  lw  x17, 68(x23)
                  lw  x18, 72(x23)
                  lw  x19, 76(x23)
                  lw  x20, 80(x23)
                  lw  x21, 84(x23)
                  lw  x22, 88(x23)
                  lw  x23, 92(x23)
                  lw  x24, 96(x23)
                  lw  x25, 100(x23)
                  lw  x26, 104(x23)
                  lw  x27, 108(x23)
                  lw  x28, 112(x23)
                  lw  x29, 116(x23)
                  lw  x30, 120(x23)
                  lw  x31, 124(x23)
                  addi x23, x23, 128
                  add x11, x23, zero
                  lw  x23, (x11)
                  addi x11, x11, 4
                  mret

illegal_instr_handler:
                  csrr  x19, 0x341
                  addi  x19, x19, 4
                  csrw  0x341, x19
                  add x23, x11, zero
                  lw  x1, 4(x23)
                  lw  x2, 8(x23)
                  lw  x3, 12(x23)
                  lw  x4, 16(x23)
                  lw  x5, 20(x23)
                  lw  x6, 24(x23)
                  lw  x7, 28(x23)
                  lw  x8, 32(x23)
                  lw  x9, 36(x23)
                  lw  x10, 40(x23)
                  lw  x11, 44(x23)
                  lw  x12, 48(x23)
                  lw  x13, 52(x23)
                  lw  x14, 56(x23)
                  lw  x15, 60(x23)
                  lw  x16, 64(x23)
                  lw  x17, 68(x23)
                  lw  x18, 72(x23)
                  lw  x19, 76(x23)
                  lw  x20, 80(x23)
                  lw  x21, 84(x23)
                  lw  x22, 88(x23)
                  lw  x23, 92(x23)
                  lw  x24, 96(x23)
                  lw  x25, 100(x23)
                  lw  x26, 104(x23)
                  lw  x27, 108(x23)
                  lw  x28, 112(x23)
                  lw  x29, 116(x23)
                  lw  x30, 120(x23)
                  lw  x31, 124(x23)
                  addi x23, x23, 128
                  add x11, x23, zero
                  lw  x23, (x11)
                  addi x11, x11, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x19, 0x300 # MSTATUS;
                  csrr  x19, 0x304 # MIE;
                  csrr  x19, 0x344 # MIP;
                  csrrc x19, 0x344, x19 # MIP;
                  add x23, x11, zero
                  lw  x1, 4(x23)
                  lw  x2, 8(x23)
                  lw  x3, 12(x23)
                  lw  x4, 16(x23)
                  lw  x5, 20(x23)
                  lw  x6, 24(x23)
                  lw  x7, 28(x23)
                  lw  x8, 32(x23)
                  lw  x9, 36(x23)
                  lw  x10, 40(x23)
                  lw  x11, 44(x23)
                  lw  x12, 48(x23)
                  lw  x13, 52(x23)
                  lw  x14, 56(x23)
                  lw  x15, 60(x23)
                  lw  x16, 64(x23)
                  lw  x17, 68(x23)
                  lw  x18, 72(x23)
                  lw  x19, 76(x23)
                  lw  x20, 80(x23)
                  lw  x21, 84(x23)
                  lw  x22, 88(x23)
                  lw  x23, 92(x23)
                  lw  x24, 96(x23)
                  lw  x25, 100(x23)
                  lw  x26, 104(x23)
                  lw  x27, 108(x23)
                  lw  x28, 112(x23)
                  lw  x29, 116(x23)
                  lw  x30, 120(x23)
                  lw  x31, 124(x23)
                  addi x23, x23, 128
                  add x11, x23, zero
                  lw  x23, (x11)
                  addi x11, x11, 4
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
