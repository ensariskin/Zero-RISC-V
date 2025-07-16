.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x17, h0_start
jalr x0, x17, 0
h0_start:
                  li x7, 0x40000100
                  csrw 0x301, x7
kernel_sp:        
                  la x4, kernel_stack_end

trap_vec_init:    
                  la x7, mtvec_handler
                  ori x7, x7, 1
                  csrw 0x305, x7 # MTVEC

mepc_setup:       
                  la x7, init
                  csrw 0x341, x7

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x7, 0x1800
                  csrw 0x300, x7 # MSTATUS
                  li x7, 0x0
                  csrw 0x304, x7 # MIE
                  mret
init:             
                  li x0, 0xf3188f4f
                  li x1, 0x80000000
                  li x2, 0x80000000
                  li x3, 0xb4e8a264
                  li x5, 0x0
                  li x6, 0x0
                  li x7, 0x0
                  li x8, 0x80000000
                  li x9, 0x0
                  li x10, 0x7
                  li x11, 0x0
                  li x12, 0xf597c6b2
                  li x13, 0x0
                  li x14, 0xf
                  li x16, 0xfd365e5a
                  li x17, 0x0
                  li x18, 0xcd332247
                  li x19, 0x80000000
                  li x20, 0x418144ff
                  li x21, 0x80000000
                  li x22, 0x0
                  li x23, 0xf4cac30d
                  li x24, 0x0
                  li x25, 0x0
                  li x26, 0x19cd072f
                  li x27, 0x6
                  li x28, 0x3
                  li x29, 0x0
                  li x30, 0x0
                  li x31, 0x1691430b
                  la x15, user_stack_end
main:             li           t1, 0xffffffff #start riscv_int_numeric_corner_stream_27
                  li           t2, 0xd67a93bd
                  li           a3, 0x0
                  li           ra, 0xffffffff
                  li           s10, 0x0
                  li           s5, 0x80000000
                  li           s9, 0x4e0ef879
                  li           t3, 0x9e61f401
                  li           s1, 0x116ca4b3
                  li           t0, 0xffffffff
                  lui          s1, 1089
                  sub          s5, s1, s1
                  lui          s1, 1089
                  auipc        s1, 736371
                  add          s5, t3, s9
                  nop
                  sub          s5, s1, s1
                  sub          s5, s1, s1
                  sub          s5, s1, s1
                  sub          s5, s1, s1
                  auipc        s1, 736371
                  nop
                  add          s5, t3, s9
                  add          s5, t3, s9
                  auipc        s1, 736371
                  lui          s1, 1089
                  lui          s1, 1089
                  add          s5, t3, s9 #end riscv_int_numeric_corner_stream_27
                  li           a1, 0x0 #start riscv_int_numeric_corner_stream_17
                  li           sp, 0xffffffff
                  li           s0, 0xffffffff
                  li           s7, 0xffffffff
                  li           a2, 0x0
                  li           s8, 0xfb61d392
                  li           s4, 0x85e05ddb
                  li           s1, 0x0
                  li           t1, 0x80000000
                  li           s9, 0x792fe52c
                  addi         s4, s8, -1859
                  auipc        a1, 736371
                  sub          s7, s1, sp
                  addi         s4, s8, -1859
                  add          s7, s8, s9
                  auipc        a1, 736371
                  auipc        a1, 736371
                  add          s7, s8, s9
                  addi         s4, s8, -1859
                  sub          s7, s1, sp
                  addi         s4, s8, -1859
                  sub          s7, s1, sp
                  lui          a1, 1089
                  auipc        a1, 736371
                  nop
                  auipc        a1, 736371
                  addi         s4, s8, -1859
                  add          s7, s8, s9
                  sub          s7, s1, sp
                  auipc        a1, 736371 #end riscv_int_numeric_corner_stream_17
                  li           sp, 0x0 #start riscv_int_numeric_corner_stream_1
                  li           s4, 0xffffffff
                  li           s3, 0x80000000
                  li           s5, 0x95705836
                  li           s2, 0xd76c1fe3
                  li           s1, 0xffffffff
                  li           t3, 0x0
                  li           t0, 0x278f88a7
                  li           gp, 0x0
                  li           t6, 0xffffffff
                  sub          s1, gp, sp
                  add          s5, t3, s3
                  addi         s5, t3, -1859
                  addi         s5, t3, -1859
                  nop
                  add          s5, t3, s3
                  addi         s5, t3, -1859
                  lui          s1, 1089
                  auipc        s1, 736371
                  auipc        s1, 736371
                  lui          s1, 1089
                  lui          s1, 1089
                  addi         s5, t3, -1859
                  sub          s1, gp, sp
                  add          s5, t3, s3
                  nop
                  auipc        s1, 736371
                  addi         s5, t3, -1859
                  add          s5, t3, s3
                  sub          s1, gp, sp
                  nop
                  add          s5, t3, s3
                  add          s5, t3, s3
                  sub          s1, gp, sp
                  add          s5, t3, s3
                  nop
                  lui          s1, 1089
                  add          s5, t3, s3
                  add          s5, t3, s3 #end riscv_int_numeric_corner_stream_1
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_10
                  li           t2, 0x80000000
                  li           s6, 0x0
                  li           s8, 0xffffffff
                  li           s11, 0xffffffff
                  li           gp, 0x80000000
                  li           a2, 0xba5c6934
                  li           ra, 0xffffffff
                  li           s4, 0x0
                  li           t4, 0x46d80b17
                  auipc        gp, 736371
                  sub          t2, s11, gp
                  addi         t2, t3, -1859
                  nop
                  addi         t2, t3, -1859
                  auipc        gp, 736371
                  lui          gp, 1089
                  nop
                  lui          gp, 1089
                  sub          t2, s11, gp
                  add          a2, s8, s11
                  lui          gp, 1089
                  lui          gp, 1089
                  addi         t2, t3, -1859
                  nop
                  auipc        gp, 736371
                  addi         t2, t3, -1859
                  lui          gp, 1089
                  lui          gp, 1089
                  lui          gp, 1089
                  lui          gp, 1089
                  sub          t2, s11, gp #end riscv_int_numeric_corner_stream_10
                  li           ra, 0xffffffff #start riscv_int_numeric_corner_stream_29
                  li           t2, 0x14d02de1
                  li           gp, 0xffffffff
                  li           s3, 0xd9c47cc0
                  li           a3, 0x95ced5bd
                  li           s11, 0x80000000
                  li           s1, 0xffffffff
                  li           t6, 0x80000000
                  li           s2, 0xffffffff
                  li           s9, 0x80000000
                  addi         a3, a3, -1859
                  auipc        a3, 736371
                  auipc        a3, 736371
                  lui          t2, 1089
                  addi         a3, a3, -1859
                  addi         a3, a3, -1859
                  add          s2, t6, s11
                  addi         a3, a3, -1859
                  addi         a3, a3, -1859
                  nop
                  nop
                  addi         a3, a3, -1859
                  sub          t2, s1, gp
                  sub          t2, s1, gp
                  nop
                  lui          t2, 1089
                  sub          t2, s1, gp
                  sub          t2, s1, gp
                  add          s2, t6, s11
                  addi         a3, a3, -1859
                  nop
                  sub          t2, s1, gp #end riscv_int_numeric_corner_stream_29
                  li           t1, 0x0 #start riscv_int_numeric_corner_stream_24
                  li           s3, 0x24382e7e
                  li           s11, 0x0
                  li           a2, 0x0
                  li           t2, 0x80000000
                  li           s9, 0x0
                  li           a3, 0x80000000
                  li           sp, 0x9dba28e2
                  li           a1, 0x0
                  li           ra, 0x0
                  nop
                  addi         s9, s9, -1859
                  lui          a1, 1089
                  addi         s9, s9, -1859
                  auipc        a1, 736371
                  lui          a1, 1089
                  add          a2, s11, s11
                  addi         s9, s9, -1859
                  add          a2, s11, s11
                  auipc        a1, 736371
                  nop
                  auipc        a1, 736371
                  add          a2, s11, s11
                  sub          s9, ra, sp
                  nop #end riscv_int_numeric_corner_stream_24
                  li           s10, 0xffffffff #start riscv_int_numeric_corner_stream_32
                  li           a4, 0x80000000
                  li           s1, 0xffffffff
                  li           s8, 0x0
                  li           t1, 0x5d6b2607
                  li           s2, 0xf7eb1a87
                  li           a0, 0xfef2ba0
                  li           a2, 0x80000000
                  li           s4, 0x0
                  li           t0, 0xffffffff
                  auipc        a0, 736371
                  lui          t0, 1089
                  addi         s4, s8, -1859
                  sub          a0, t0, a0
                  addi         s4, s8, -1859
                  addi         s4, s8, -1859
                  addi         s4, s8, -1859
                  add          s4, s1, s10
                  lui          t0, 1089
                  addi         s4, s8, -1859
                  addi         s4, s8, -1859
                  nop
                  sub          a0, t0, a0
                  sub          a0, t0, a0
                  sub          a0, t0, a0
                  add          s4, s1, s10
                  sub          a0, t0, a0
                  add          s4, s1, s10
                  addi         s4, s8, -1859
                  lui          t0, 1089
                  auipc        a0, 736371
                  sub          a0, t0, a0
                  auipc        a0, 736371
                  auipc        a0, 736371
                  auipc        a0, 736371
                  addi         s4, s8, -1859
                  sub          a0, t0, a0
                  add          s4, s1, s10
                  auipc        a0, 736371 #end riscv_int_numeric_corner_stream_32
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_16
                  li           t4, 0x80000000
                  li           a1, 0x0
                  li           s3, 0x80000000
                  li           a4, 0x80000000
                  li           s7, 0x0
                  li           t5, 0xffffffff
                  li           s9, 0xffffffff
                  li           s2, 0x0
                  li           s10, 0x80000000
                  nop
                  sub          s2, s3, a4
                  lui          a1, 1089
                  auipc        a4, 736371
                  auipc        a4, 736371
                  lui          a1, 1089
                  auipc        a4, 736371
                  addi         t4, t4, -1859
                  lui          a1, 1089
                  add          a6, t4, s9
                  lui          a1, 1089
                  add          a6, t4, s9
                  addi         t4, t4, -1859
                  addi         t4, t4, -1859
                  auipc        a4, 736371
                  lui          a1, 1089
                  addi         t4, t4, -1859
                  addi         t4, t4, -1859
                  nop
                  auipc        a4, 736371
                  sub          s2, s3, a4
                  auipc        a4, 736371
                  sub          s2, s3, a4 #end riscv_int_numeric_corner_stream_16
                  li           a3, 0x0 #start riscv_int_numeric_corner_stream_20
                  li           t4, 0x0
                  li           s2, 0x8d18f659
                  li           s10, 0x1215ec19
                  li           t0, 0x0
                  li           t3, 0xffffffff
                  li           a2, 0xffffffff
                  li           s8, 0x80000000
                  li           s4, 0x31e19862
                  li           sp, 0xffffffff
                  add          a2, s8, s10
                  sub          sp, s4, sp
                  nop
                  auipc        sp, 736371
                  nop
                  sub          sp, s4, sp
                  lui          a3, 1089
                  addi         t0, t3, -1859
                  nop
                  sub          sp, s4, sp
                  nop
                  lui          a3, 1089
                  nop
                  lui          a3, 1089
                  auipc        sp, 736371 #end riscv_int_numeric_corner_stream_20
                  li           t3, 0x0 #start riscv_int_numeric_corner_stream_6
                  li           s9, 0x80000000
                  li           sp, 0x29fb17c5
                  li           s5, 0x5eb97f1f
                  li           s11, 0x376782e8
                  li           a2, 0xcaa90e73
                  li           s1, 0xffffffff
                  li           s8, 0xffffffff
                  li           t4, 0x80000000
                  li           ra, 0x0
                  auipc        s1, 736371
                  lui          s1, 1089
                  lui          s1, 1089
                  auipc        s1, 736371
                  auipc        s1, 736371
                  addi         s5, t3, -1859
                  auipc        s1, 736371
                  lui          s1, 1089
                  add          a2, t4, s11
                  addi         s5, t3, -1859
                  nop
                  lui          s1, 1089
                  addi         s5, t3, -1859
                  addi         s5, t3, -1859
                  sub          s5, s1, sp
                  sub          s5, s1, sp
                  add          a2, t4, s11
                  add          a2, t4, s11
                  add          a2, t4, s11
                  nop
                  addi         s5, t3, -1859 #end riscv_int_numeric_corner_stream_6
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_15
                  li           s9, 0x92fe65fa
                  li           s8, 0x80000000
                  li           s1, 0x3d8fa58c
                  li           a1, 0xffffffff
                  li           t5, 0xffffffff
                  li           t2, 0x80000000
                  li           t4, 0xee26092c
                  li           ra, 0x0
                  li           s3, 0x0
                  sub          s8, a1, a1
                  add          t3, t4, s9
                  add          t3, t4, s9
                  addi         t2, t3, -1859
                  add          t3, t4, s9
                  nop
                  lui          t2, 1089
                  add          t3, t4, s9
                  auipc        s1, 736371
                  sub          s8, a1, a1
                  auipc        s1, 736371
                  nop
                  addi         t2, t3, -1859
                  auipc        s1, 736371
                  sub          s8, a1, a1
                  auipc        s1, 736371
                  add          t3, t4, s9
                  nop
                  nop
                  lui          t2, 1089
                  add          t3, t4, s9 #end riscv_int_numeric_corner_stream_15
                  li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_0
                  li           s0, 0xb9c04cad
                  li           s11, 0x0
                  li           s4, 0x87da769f
                  li           a0, 0x0
                  li           a1, 0x0
                  li           s3, 0xffffffff
                  li           s7, 0x0
                  li           sp, 0x80000000
                  li           t1, 0x73d7e080
                  sub          s7, a1, sp
                  auipc        a0, 736371
                  sub          s7, a1, sp
                  lui          a1, 1089
                  sub          s7, a1, sp
                  lui          a1, 1089
                  addi         t1, s0, -1859
                  add          s4, s0, s11
                  nop
                  auipc        a0, 736371
                  sub          s7, a1, sp
                  auipc        a0, 736371
                  auipc        a0, 736371
                  auipc        a0, 736371
                  add          s4, s0, s11
                  sub          s7, a1, sp
                  nop
                  addi         t1, s0, -1859
                  nop
                  add          s4, s0, s11
                  add          s4, s0, s11
                  nop
                  addi         t1, s0, -1859
                  addi         t1, s0, -1859
                  add          s4, s0, s11
                  nop
                  auipc        a0, 736371
                  nop
                  nop #end riscv_int_numeric_corner_stream_0
                  li           a3, 0x80000000 #start riscv_int_numeric_corner_stream_19
                  li           a4, 0x0
                  li           a0, 0x80000000
                  li           a6, 0x80000000
                  li           s10, 0x80000000
                  li           ra, 0xffffffff
                  li           s3, 0xffffffff
                  li           s0, 0x0
                  li           t6, 0xffffffff
                  li           s6, 0x80000000
                  nop
                  add          s6, s0, s10
                  nop
                  lui          a3, 1089
                  sub          a4, s3, a0
                  auipc        a0, 736371
                  auipc        a0, 736371
                  auipc        a0, 736371
                  auipc        a0, 736371
                  sub          a4, s3, a0
                  add          s6, s0, s10
                  addi         a6, a3, -1859
                  sub          a4, s3, a0
                  auipc        a0, 736371
                  auipc        a0, 736371 #end riscv_int_numeric_corner_stream_19
                  li           a0, 0x0 #start riscv_int_numeric_corner_stream_36
                  li           a6, 0xffffffff
                  li           a3, 0x0
                  li           t1, 0x80000000
                  li           t0, 0x80000000
                  li           sp, 0x5b26fd
                  li           s6, 0xffffffff
                  li           a2, 0x80000000
                  li           a4, 0xffffffff
                  li           s7, 0xffffffff
                  addi         a6, a3, -1859
                  addi         a6, a3, -1859
                  nop
                  nop
                  lui          a3, 1089
                  lui          a3, 1089
                  nop
                  sub          t1, a3, a0
                  sub          t1, a3, a0
                  nop
                  lui          a3, 1089
                  lui          a3, 1089
                  sub          t1, a3, a0
                  nop
                  nop
                  addi         a6, a3, -1859
                  addi         a6, a3, -1859
                  lui          a3, 1089
                  add          s7, a4, a0
                  lui          a3, 1089
                  add          s7, a4, a0
                  auipc        a0, 736371
                  add          s7, a4, a0
                  lui          a3, 1089
                  nop
                  auipc        a0, 736371
                  addi         a6, a3, -1859 #end riscv_int_numeric_corner_stream_36
                  li           t1, 0x0 #start riscv_int_numeric_corner_stream_37
                  li           t2, 0x0
                  li           s7, 0x3fa8188f
                  li           ra, 0x80000000
                  li           a6, 0x482abf78
                  li           a1, 0x80000000
                  li           t0, 0x16394408
                  li           t6, 0xffffffff
                  li           t4, 0x0
                  li           s6, 0x0
                  nop
                  lui          a1, 1089
                  addi         t2, t4, -1859
                  auipc        a1, 736371
                  nop
                  nop
                  auipc        a1, 736371
                  lui          a1, 1089
                  addi         t2, t4, -1859
                  lui          a1, 1089
                  lui          a1, 1089
                  lui          a1, 1089
                  sub          t1, a1, a1
                  lui          a1, 1089
                  nop #end riscv_int_numeric_corner_stream_37
                  li           t2, 0x0 #start riscv_int_numeric_corner_stream_4
                  li           s3, 0x4e2b6077
                  li           ra, 0xffffffff
                  li           a2, 0x80000000
                  li           t6, 0xffffffff
                  li           sp, 0x80000000
                  li           s5, 0xffffffff
                  li           gp, 0x80000000
                  li           a3, 0xffffffff
                  li           t1, 0x0
                  lui          a3, 1089
                  lui          a3, 1089
                  addi         s5, a3, -1859
                  add          t6, a2, s3
                  sub          a2, ra, sp
                  nop
                  nop
                  nop
                  sub          a2, ra, sp
                  lui          a3, 1089
                  lui          a3, 1089
                  lui          a3, 1089
                  nop
                  sub          a2, ra, sp
                  add          t6, a2, s3
                  sub          a2, ra, sp
                  nop
                  add          t6, a2, s3
                  nop
                  lui          a3, 1089
                  nop
                  sub          a2, ra, sp
                  add          t6, a2, s3
                  addi         s5, a3, -1859
                  add          t6, a2, s3
                  lui          a3, 1089 #end riscv_int_numeric_corner_stream_4
                  li           a3, 0x0 #start riscv_int_numeric_corner_stream_30
                  li           s6, 0xf5f26f66
                  li           t4, 0x80000000
                  li           t2, 0x9abf547a
                  li           s0, 0x15a36f41
                  li           s2, 0xffffffff
                  li           s7, 0x0
                  li           s8, 0x0
                  li           sp, 0xffffffff
                  li           t6, 0xf40bb4
                  addi         t4, t4, -1859
                  add          s6, s8, s8
                  auipc        sp, 736371
                  add          s6, s8, s8
                  auipc        sp, 736371
                  addi         t4, t4, -1859
                  auipc        sp, 736371
                  auipc        sp, 736371
                  add          s6, s8, s8
                  lui          t2, 1089
                  auipc        sp, 736371
                  addi         t4, t4, -1859
                  nop
                  lui          t2, 1089
                  add          s6, s8, s8
                  add          s6, s8, s8
                  addi         t4, t4, -1859
                  lui          t2, 1089
                  auipc        sp, 736371
                  auipc        sp, 736371
                  lui          t2, 1089
                  sub          t2, t4, sp
                  auipc        sp, 736371
                  sub          t2, t4, sp
                  nop
                  add          s6, s8, s8
                  addi         t4, t4, -1859 #end riscv_int_numeric_corner_stream_30
                  li           a1, 0x0 #start riscv_int_numeric_corner_stream_38
                  li           s2, 0xffffffff
                  li           t5, 0xffffffff
                  li           s7, 0xffffffff
                  li           gp, 0xffffffff
                  li           s4, 0x0
                  li           s6, 0x80000000
                  li           t2, 0x80000000
                  li           s10, 0x80000000
                  li           sp, 0x80000000
                  sub          t2, s7, a1
                  add          s7, s4, a1
                  addi         s10, s4, -1859
                  auipc        t2, 736371
                  lui          t2, 1089
                  auipc        t2, 736371
                  nop
                  sub          t2, s7, a1
                  add          s7, s4, a1
                  nop
                  auipc        t2, 736371
                  addi         s10, s4, -1859
                  sub          t2, s7, a1
                  lui          t2, 1089
                  add          s7, s4, a1 #end riscv_int_numeric_corner_stream_38
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  add          a6, t4, s9
                  and          a0, gp, a2
                  lui          a1, 1089
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  lui          a1, 1089
                  auipc        a0, 736371
                  nop
                  lui          a1, 1089
                  or           s7, ra, t6
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  nop
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  nop
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  nop
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  nop
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  add          a6, t4, s9
                  nop
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  nop
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  nop
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  nop
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  nop
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  auipc        a0, 736371
                  lui          a1, 1089
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  nop
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  nop
                  andi         sp, s11, -1769
                  nop
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  nop
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  nop
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  nop
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  nop
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  nop
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  nop
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  nop
                  nop
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  nop
                  lui          a1, 1089
                  add          a6, t4, s9
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  nop
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  nop
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  nop
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  nop
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  lui          a1, 1089
                  lui          a1, 1089
                  nop
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  lui          a1, 1089
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  nop
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  nop
                  lui          a1, 1089
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  lui          a1, 1089
                  lui          a1, 1089
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  nop
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  lui          a1, 1089
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  lui          a1, 1089
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  nop
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  lui          a1, 1089
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  lui          a1, 1089
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  lui          a1, 1089
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  nop
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  nop
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  nop
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  nop
                  srl          s10, sp, gp
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  lui          a1, 1089
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  lui          a1, 1089
                  nop
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  nop
                  sltiu        a1, s6, -1603
                  nop
                  slli         t0, s6, 8
                  nop
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  nop
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  nop
                  nop
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  lui          a1, 1089
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  auipc        a0, 736371
                  nop
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  lui          a1, 1089
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  nop
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  nop
                  auipc        a0, 736371
                  lui          a1, 1089
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  nop
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  lui          a1, 1089
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  lui          a1, 1089
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  nop
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  add          a6, t4, s9
                  lui          a1, 1089
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  nop
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  lui          a1, 1089
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  lui          a1, 1089
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  auipc        a0, 736371
                  lui          a1, 1089
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  nop
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  nop
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  or           s7, ra, t6
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  nop
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  lui          a1, 1089
                  and          a0, gp, a2
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  lui          a1, 1089
                  and          a0, gp, a2
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  nop
                  add          a6, t4, s9
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  nop
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  nop
                  nop
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  lui          a1, 1089
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  nop
                  or           s7, ra, t6
                  and          a0, gp, a2
                  nop
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  nop
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  nop
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  add          a6, t4, s9
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  lui          a1, 1089
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  nop
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  lui          a1, 1089
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  nop
                  slli         t0, s6, 8
                  lui          a1, 1089
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  nop
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  nop
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  nop
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  nop
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  nop
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  lui          a1, 1089
                  sub          a1, s9, gp
                  nop
                  or           s7, ra, t6
                  or           s7, ra, t6
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  lui          a1, 1089
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  lui          a1, 1089
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  nop
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  lui          a1, 1089
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  li           s4, 0x5344e2cc #start riscv_int_numeric_corner_stream_11
                  li           s9, 0x80000000
                  li           t5, 0xffffffff
                  li           a6, 0x77267337
                  li           s5, 0xffffffff
                  li           t1, 0x80000000
                  li           s3, 0x80000000
                  li           t0, 0x0
                  li           s8, 0x830b9746
                  li           s2, 0xffffffff
                  nop
                  lui          t0, 1089
                  add          t5, s8, s9
                  add          t5, s8, s9
                  sub          t1, s4, t1
                  lui          t0, 1089
                  add          t5, s8, s9
                  nop
                  add          t5, s8, s9
                  addi         s4, s9, -1859
                  add          t5, s8, s9
                  auipc        t1, 736371
                  sub          t1, s4, t1
                  addi         s4, s9, -1859
                  sub          t1, s4, t1
                  nop
                  nop
                  auipc        t1, 736371
                  lui          t0, 1089
                  nop
                  nop
                  addi         s4, s9, -1859
                  lui          t0, 1089
                  sub          t1, s4, t1
                  sub          t1, s4, t1
                  sub          t1, s4, t1 #end riscv_int_numeric_corner_stream_11
                  nop
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sra          t5, s0, a7
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  nop
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  nop
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  lui          a1, 1089
                  slt          gp, t0, s5
                  nop
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  lui          a1, 1089
                  nop
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  lui          a1, 1089
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  nop
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  nop
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  nop
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  lui          a1, 1089
                  auipc        a0, 736371
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  nop
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  nop
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  nop
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  nop
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  nop
                  slli         t0, s6, 8
                  nop
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  nop
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  li           t0, 0xbaea02e4 #start riscv_int_numeric_corner_stream_14
                  li           t2, 0x0
                  li           a1, 0x80000000
                  li           s1, 0x0
                  li           s2, 0x3d58554a
                  li           s10, 0x80000000
                  li           s8, 0xfc297c1c
                  li           a6, 0x80000000
                  li           a0, 0x82d4b204
                  li           a4, 0xffffffff
                  sub          t2, s1, a0
                  lui          s1, 1089
                  lui          s1, 1089
                  nop
                  lui          s1, 1089
                  sub          t2, s1, a0
                  sub          t2, s1, a0
                  auipc        a1, 736371
                  addi         s8, s1, -1859
                  nop
                  sub          t2, s1, a0
                  lui          s1, 1089
                  auipc        a1, 736371
                  addi         s8, s1, -1859
                  nop
                  sub          t2, s1, a0
                  sub          t2, s1, a0
                  lui          s1, 1089 #end riscv_int_numeric_corner_stream_14
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  nop
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  nop
                  or           s7, ra, t6
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  nop
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  nop
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  nop
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  auipc        a0, 736371
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  nop
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  nop
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  nop
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  add          a6, t4, s9
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  nop
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  auipc        a0, 736371
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  nop
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  nop
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  nop
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  nop
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  nop
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  nop
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  li           ra, 0x80000000 #start riscv_int_numeric_corner_stream_25
                  li           s1, 0x9c72aaa0
                  li           s7, 0xffffffff
                  li           a1, 0x0
                  li           s0, 0x0
                  li           t2, 0x80000000
                  li           s2, 0x80000000
                  li           gp, 0x80000000
                  li           t0, 0xffffffff
                  li           t6, 0xffffffff
                  nop
                  addi         t0, t0, -1859
                  add          s7, t6, s2
                  sub          s0, ra, gp
                  sub          s0, ra, gp
                  auipc        a1, 736371
                  addi         t0, t0, -1859
                  addi         t0, t0, -1859
                  nop
                  sub          s0, ra, gp
                  nop
                  nop
                  auipc        a1, 736371
                  addi         t0, t0, -1859
                  lui          s1, 1089 #end riscv_int_numeric_corner_stream_25
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  nop
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  li           s6, 0x80000000 #start riscv_int_numeric_corner_stream_2
                  li           a2, 0xffffffff
                  li           s9, 0x370bf059
                  li           t2, 0x0
                  li           t1, 0x0
                  li           sp, 0x0
                  li           a1, 0x32e85902
                  li           s4, 0x80000000
                  li           t6, 0x0
                  li           gp, 0x0
                  sub          s6, a1, a1
                  add          s9, t6, s9
                  addi         s4, s9, -1859
                  lui          t2, 1089
                  addi         s4, s9, -1859
                  add          s9, t6, s9
                  auipc        a1, 736371
                  auipc        a1, 736371
                  sub          s6, a1, a1
                  addi         s4, s9, -1859
                  addi         s4, s9, -1859
                  add          s9, t6, s9
                  lui          t2, 1089
                  add          s9, t6, s9
                  auipc        a1, 736371 #end riscv_int_numeric_corner_stream_2
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  nop
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  auipc        a0, 736371
                  nop
                  lui          a1, 1089
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  nop
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  lui          a1, 1089
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  lui          a1, 1089
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  nop
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  auipc        a0, 736371
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  lui          a1, 1089
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  nop
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  lui          a1, 1089
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  nop
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  and          a0, gp, a2
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  nop
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  nop
                  lui          a1, 1089
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  srl          s10, sp, gp
                  lui          a1, 1089
                  nop
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  nop
                  sra          t5, s0, a7
                  lui          a1, 1089
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  nop
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  sll          s1, tp, s7
                  lui          a1, 1089
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  lui          a1, 1089
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  nop
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  lui          a1, 1089
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  lui          a1, 1089
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  nop
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  li           s0, 0xffffffff #start riscv_int_numeric_corner_stream_22
                  li           s8, 0x9502b9e3
                  li           s5, 0xffffffff
                  li           a6, 0x80000000
                  li           t4, 0x0
                  li           a0, 0x80000000
                  li           s9, 0xffffffff
                  li           sp, 0xffffffff
                  li           s1, 0xffffffff
                  li           s6, 0x0
                  lui          a0, 1089
                  add          s1, s8, s9
                  nop
                  auipc        s1, 736371
                  nop
                  addi         s5, s8, -1859
                  nop
                  auipc        s1, 736371
                  nop
                  nop
                  auipc        s1, 736371
                  addi         s5, s8, -1859
                  add          s1, s8, s9
                  nop
                  sub          sp, s6, sp #end riscv_int_numeric_corner_stream_22
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  nop
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  lui          a1, 1089
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  nop
                  or           s7, ra, t6
                  nop
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  nop
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  nop
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  nop
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  nop
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  lui          a1, 1089
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  or           s7, ra, t6
                  lui          a1, 1089
                  or           s7, ra, t6
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  lui          a1, 1089
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  nop
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  auipc        a0, 736371
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  auipc        a0, 736371
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  and          a0, gp, a2
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  auipc        a0, 736371
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  lui          a1, 1089
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  nop
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  add          a6, t4, s9
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  nop
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  nop
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  and          a0, gp, a2
                  auipc        a0, 736371
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  nop
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  add          a6, t4, s9
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  nop
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  auipc        a0, 736371
                  nop
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  lui          a1, 1089
                  nop
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  add          a6, t4, s9
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  nop
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  nop
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  nop
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  lui          a1, 1089
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  nop
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  nop
                  ori          s7, a7, 1695
                  nop
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  nop
                  auipc        a0, 736371
                  nop
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  nop
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  lui          a1, 1089
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  lui          a1, 1089
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  nop
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  nop
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  nop
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  nop
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  nop
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  nop
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  nop
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  lui          a1, 1089
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  nop
                  add          a6, t4, s9
                  and          a0, gp, a2
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  add          a6, t4, s9
                  add          a6, t4, s9
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  nop
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  nop
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  lui          a1, 1089
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  nop
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  nop
                  auipc        a0, 736371
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  lui          a1, 1089
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  nop
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  lui          a1, 1089
                  sll          s1, tp, s7
                  nop
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  nop
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  nop
                  srai         s7, t5, 16
                  lui          a1, 1089
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  nop
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  nop
                  sltiu        a1, s6, -1603
                  nop
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  nop
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  nop
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  nop
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  lui          a1, 1089
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  li           t1, 0xde5f1c54 #start riscv_int_numeric_corner_stream_13
                  li           s7, 0xffffffff
                  li           a4, 0xeaef8c1d
                  li           s1, 0x0
                  li           ra, 0x80000000
                  li           sp, 0x0
                  li           t3, 0x154d5cbd
                  li           t2, 0xe6003e8f
                  li           s4, 0xffffffff
                  li           s3, 0x80000000
                  addi         t3, t3, -1859
                  add          s7, a4, s3
                  add          s7, a4, s3
                  sub          t2, s1, sp
                  nop
                  lui          s1, 1089
                  nop
                  sub          t2, s1, sp
                  add          s7, a4, s3
                  add          s7, a4, s3
                  add          s7, a4, s3
                  auipc        s1, 736371
                  sub          t2, s1, sp
                  nop
                  sub          t2, s1, sp
                  add          s7, a4, s3
                  auipc        s1, 736371
                  sub          t2, s1, sp
                  add          s7, a4, s3
                  lui          s1, 1089
                  auipc        s1, 736371
                  addi         t3, t3, -1859
                  lui          s1, 1089 #end riscv_int_numeric_corner_stream_13
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  lui          a1, 1089
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  nop
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  nop
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  lui          a1, 1089
                  lui          a1, 1089
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  lui          a1, 1089
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  nop
                  sll          s1, tp, s7
                  nop
                  sub          a1, s9, gp
                  lui          a1, 1089
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  nop
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  lui          a1, 1089
                  srli         a4, a1, 5
                  nop
                  and          a0, gp, a2
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  nop
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  add          a6, t4, s9
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  nop
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  nop
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  srli         a4, a1, 5
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  lui          a1, 1089
                  srli         a4, a1, 5
                  nop
                  auipc        a0, 736371
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  nop
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  lui          a1, 1089
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  nop
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  lui          a1, 1089
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  nop
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  lui          a1, 1089
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  auipc        a0, 736371
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  lui          a1, 1089
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  lui          a1, 1089
                  add          a6, t4, s9
                  lui          a1, 1089
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  and          a0, gp, a2
                  and          a0, gp, a2
                  or           s7, ra, t6
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  lui          a1, 1089
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  nop
                  nop
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  nop
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  nop
                  srl          s10, sp, gp
                  lui          a1, 1089
                  nop
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  nop
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  lui          a1, 1089
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  nop
                  lui          a1, 1089
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  nop
                  srai         s7, t5, 16
                  lui          a1, 1089
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  nop
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  lui          a1, 1089
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  add          a6, t4, s9
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  auipc        a0, 736371
                  lui          a1, 1089
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  nop
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  lui          a1, 1089
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  nop
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  nop
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  nop
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  nop
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  lui          a1, 1089
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  nop
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  nop
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  lui          a1, 1089
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  lui          a1, 1089
                  lui          a1, 1089
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  lui          a1, 1089
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  nop
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  lui          a1, 1089
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  nop
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  nop
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  lui          a1, 1089
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  lui          a1, 1089
                  sra          t5, s0, a7
                  nop
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  nop
                  nop
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  nop
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  nop
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  nop
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  nop
                  srl          s10, sp, gp
                  lui          a1, 1089
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  nop
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  nop
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  nop
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  nop
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  and          a0, gp, a2
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  nop
                  sltiu        a1, s6, -1603
                  nop
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  or           s7, ra, t6
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  nop
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  li           a0, 0xffffffff #start riscv_int_numeric_corner_stream_26
                  li           s1, 0xa145e4c6
                  li           s2, 0x80000000
                  li           t4, 0xb72010fa
                  li           a1, 0x80000000
                  li           a2, 0x0
                  li           a3, 0xffffffff
                  li           t3, 0xffffffff
                  li           s9, 0x3f7a3e0
                  li           s0, 0xffffffff
                  lui          a3, 1089
                  auipc        a3, 736371
                  addi         a2, a3, -1859
                  add          a3, s9, s9
                  add          a3, s9, s9
                  addi         a2, a3, -1859
                  add          a3, s9, s9
                  addi         a2, a3, -1859
                  auipc        a3, 736371
                  nop
                  sub          s0, s1, a0
                  sub          s0, s1, a0
                  auipc        a3, 736371
                  nop
                  add          a3, s9, s9
                  addi         a2, a3, -1859
                  nop
                  lui          a3, 1089
                  lui          a3, 1089
                  auipc        a3, 736371
                  add          a3, s9, s9
                  add          a3, s9, s9
                  sub          s0, s1, a0
                  lui          a3, 1089
                  nop
                  sub          s0, s1, a0
                  addi         a2, a3, -1859
                  auipc        a3, 736371 #end riscv_int_numeric_corner_stream_26
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  or           s7, ra, t6
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  nop
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  nop
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  nop
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  or           s7, ra, t6
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  nop
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  nop
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  nop
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  nop
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  nop
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  nop
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  nop
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  nop
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  nop
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  nop
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  nop
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  or           s7, ra, t6
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  nop
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  nop
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  nop
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  nop
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  lui          a1, 1089
                  sub          a1, s9, gp
                  nop
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  nop
                  xori         a2, s10, -1144
                  nop
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  nop
                  nop
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  or           s7, ra, t6
                  lui          a1, 1089
                  nop
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  lui          a1, 1089
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  lui          a1, 1089
                  auipc        a0, 736371
                  li           s0, 0xffffffff #start riscv_int_numeric_corner_stream_39
                  li           t6, 0x78f9b6f6
                  li           s1, 0xe3b31be6
                  li           s3, 0x0
                  li           s6, 0x80000000
                  li           a0, 0x80000000
                  li           t2, 0x0
                  li           s10, 0x80000000
                  li           s9, 0xe70dd52a
                  li           sp, 0x127523b5
                  addi         t2, s9, -1859
                  add          s0, t6, s9
                  sub          s6, s3, sp
                  nop
                  lui          s1, 1089
                  sub          s6, s3, sp
                  auipc        a0, 736371
                  nop
                  lui          s1, 1089
                  addi         t2, s9, -1859
                  auipc        a0, 736371
                  lui          s1, 1089
                  auipc        a0, 736371
                  addi         t2, s9, -1859
                  auipc        a0, 736371 #end riscv_int_numeric_corner_stream_39
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  add          a6, t4, s9
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  nop
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  nop
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  nop
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  nop
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  nop
                  slli         t0, s6, 8
                  nop
                  lui          a1, 1089
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  lui          a1, 1089
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  nop
                  sub          a1, s9, gp
                  nop
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  nop
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  lui          a1, 1089
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  nop
                  lui          a1, 1089
                  add          a6, t4, s9
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  nop
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  nop
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  and          a0, gp, a2
                  auipc        a0, 736371
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  auipc        a0, 736371
                  nop
                  srli         a4, a1, 5
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  nop
                  lui          a1, 1089
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  nop
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  nop
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  nop
                  nop
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  nop
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  nop
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  nop
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  nop
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  auipc        a0, 736371
                  and          a0, gp, a2
                  lui          a1, 1089
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  nop
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  nop
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  nop
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  nop
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  nop
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  auipc        a0, 736371
                  nop
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  nop
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  li           t2, 0xffffffff #start riscv_int_numeric_corner_stream_5
                  li           t6, 0x80000000
                  li           a0, 0x34056235
                  li           t1, 0xffffffff
                  li           a4, 0x80000000
                  li           sp, 0x0
                  li           t0, 0xffffffff
                  li           s9, 0x0
                  li           s3, 0x80000000
                  li           t5, 0x0
                  add          s3, s9, s9
                  nop
                  add          s3, s9, s9
                  add          s3, s9, s9
                  add          s3, s9, s9
                  auipc        a0, 736371
                  sub          t2, s9, a0
                  auipc        a0, 736371
                  add          s3, s9, s9
                  add          s3, s9, s9
                  lui          t2, 1089
                  nop
                  addi         t2, s9, -1859
                  sub          t2, s9, a0
                  sub          t2, s9, a0
                  add          s3, s9, s9
                  nop #end riscv_int_numeric_corner_stream_5
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  nop
                  lui          a1, 1089
                  nop
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  nop
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  lui          a1, 1089
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  nop
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  lui          a1, 1089
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  or           s7, ra, t6
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  lui          a1, 1089
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  auipc        a0, 736371
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  nop
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  add          a6, t4, s9
                  nop
                  auipc        a0, 736371
                  li           s9, 0x80000000 #start riscv_int_numeric_corner_stream_33
                  li           gp, 0xffffffff
                  li           s1, 0x0
                  li           t2, 0xffffffff
                  li           s2, 0xffffffff
                  li           t3, 0x80000000
                  li           sp, 0x0
                  li           t0, 0x80000000
                  li           s3, 0x80000000
                  li           a2, 0x0
                  auipc        s1, 736371
                  nop
                  nop
                  sub          s1, gp, sp
                  add          t3, t3, s9
                  add          t3, t3, s9
                  sub          s1, gp, sp
                  auipc        s1, 736371
                  addi         t0, t3, -1859
                  addi         t0, t3, -1859
                  nop
                  nop
                  lui          s1, 1089
                  sub          s1, gp, sp
                  sub          s1, gp, sp
                  lui          s1, 1089 #end riscv_int_numeric_corner_stream_33
                  nop
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  nop
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  lui          a1, 1089
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  lui          a1, 1089
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  nop
                  lui          a1, 1089
                  or           s7, ra, t6
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  nop
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  lui          a1, 1089
                  or           s7, ra, t6
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  nop
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  li           s4, 0x80000000 #start riscv_int_numeric_corner_stream_28
                  li           a1, 0xffffffff
                  li           a0, 0x0
                  li           sp, 0x80000000
                  li           a4, 0x60d8b944
                  li           s5, 0x80000000
                  li           t6, 0x308687b1
                  li           a3, 0x126d7019
                  li           t3, 0xb7ba2c5b
                  li           ra, 0xffffffff
                  nop
                  auipc        a1, 736371
                  lui          a1, 1089
                  lui          a1, 1089
                  addi         s5, a3, -1859
                  addi         s5, a3, -1859
                  add          t3, t3, a1
                  sub          s5, ra, sp
                  add          t3, t3, a1
                  sub          s5, ra, sp
                  nop
                  nop
                  addi         s5, a3, -1859
                  addi         s5, a3, -1859
                  auipc        a1, 736371
                  sub          s5, ra, sp
                  sub          s5, ra, sp
                  sub          s5, ra, sp
                  addi         s5, a3, -1859
                  lui          a1, 1089
                  auipc        a1, 736371 #end riscv_int_numeric_corner_stream_28
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  lui          a1, 1089
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  lui          a1, 1089
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  nop
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  nop
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  nop
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  lui          a1, 1089
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  nop
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  nop
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  nop
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  nop
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  nop
                  andi         sp, s11, -1769
                  nop
                  lui          a1, 1089
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  nop
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  nop
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  lui          a1, 1089
                  li           a3, 0x80000000 #start riscv_int_numeric_corner_stream_34
                  li           s2, 0x0
                  li           a4, 0x80000000
                  li           t4, 0x0
                  li           t6, 0xffffffff
                  li           gp, 0x80000000
                  li           s11, 0xffffffff
                  li           sp, 0x0
                  li           a0, 0x80000000
                  li           a1, 0x80000000
                  nop
                  sub          a3, gp, a0
                  add          s11, a3, s11
                  auipc        a1, 736371
                  add          s11, a3, s11
                  sub          a3, gp, a0
                  sub          a3, gp, a0
                  sub          a3, gp, a0
                  sub          a3, gp, a0
                  sub          a3, gp, a0
                  nop
                  nop
                  add          s11, a3, s11
                  addi         a4, t4, -1859
                  add          s11, a3, s11
                  nop
                  nop
                  auipc        a1, 736371
                  nop
                  auipc        a1, 736371
                  sub          a3, gp, a0
                  addi         a4, t4, -1859
                  add          s11, a3, s11
                  lui          a1, 1089
                  addi         a4, t4, -1859
                  lui          a1, 1089
                  sub          a3, gp, a0
                  nop
                  nop #end riscv_int_numeric_corner_stream_34
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  nop
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  nop
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  add          a6, t4, s9
                  or           s7, ra, t6
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  nop
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  nop
                  lui          a1, 1089
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  nop
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  li           ra, 0x0 #start riscv_int_numeric_corner_stream_9
                  li           a3, 0x80000000
                  li           s5, 0x80000000
                  li           t5, 0x69d1a0c0
                  li           a4, 0x1182b474
                  li           t4, 0x80000000
                  li           sp, 0x0
                  li           s0, 0x80000000
                  li           t1, 0x0
                  li           a6, 0xffffffff
                  addi         s5, t4, -1859
                  sub          sp, s5, sp
                  add          t4, t5, a6
                  lui          a3, 1089
                  nop
                  sub          sp, s5, sp
                  add          t4, t5, a6
                  lui          a3, 1089
                  add          t4, t5, a6
                  lui          a3, 1089
                  auipc        s0, 736371
                  auipc        s0, 736371
                  lui          a3, 1089
                  auipc        s0, 736371
                  lui          a3, 1089 #end riscv_int_numeric_corner_stream_9
                  or           s7, ra, t6
                  lui          a1, 1089
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  nop
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  lui          a1, 1089
                  slt          gp, t0, s5
                  nop
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  nop
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  lui          a1, 1089
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  lui          a1, 1089
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  lui          a1, 1089
                  and          a0, gp, a2
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  nop
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  nop
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  lui          a1, 1089
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  nop
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  lui          a1, 1089
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  nop
                  lui          a1, 1089
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  lui          a1, 1089
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  lui          a1, 1089
                  and          a0, gp, a2
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  lui          a1, 1089
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  or           s7, ra, t6
                  auipc        a0, 736371
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  nop
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  nop
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  nop
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  nop
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  nop
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  nop
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  lui          a1, 1089
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  nop
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  nop
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  and          a0, gp, a2
                  nop
                  nop
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  li           s10, 0x0 #start riscv_int_numeric_corner_stream_21
                  li           t2, 0xffffffff
                  li           s7, 0xffffffff
                  li           a1, 0x80000000
                  li           s3, 0x0
                  li           s4, 0x80000000
                  li           a4, 0x0
                  li           a6, 0xffffffff
                  li           t5, 0xffffffff
                  li           s6, 0xffffffff
                  nop
                  lui          a4, 1089
                  lui          a4, 1089
                  sub          s3, s4, a1
                  addi         t2, s4, -1859
                  addi         t2, s4, -1859
                  nop
                  lui          a4, 1089
                  lui          a4, 1089
                  nop
                  addi         t2, s4, -1859
                  addi         t2, s4, -1859
                  nop
                  nop
                  sub          s3, s4, a1
                  auipc        t2, 736371
                  auipc        t2, 736371
                  auipc        t2, 736371
                  add          s3, a6, s10
                  auipc        t2, 736371 #end riscv_int_numeric_corner_stream_21
                  nop
                  nop
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  nop
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  lui          a1, 1089
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  lui          a1, 1089
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  nop
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  nop
                  auipc        a0, 736371
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  nop
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  nop
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  nop
                  lui          a1, 1089
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  nop
                  xor          sp, a1, tp
                  nop
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  lui          a1, 1089
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  lui          a1, 1089
                  nop
                  lui          a1, 1089
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  nop
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  lui          a1, 1089
                  nop
                  lui          a1, 1089
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  or           s7, ra, t6
                  lui          a1, 1089
                  sub          a1, s9, gp
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  or           s7, ra, t6
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  li           a2, 0x0 #start riscv_int_numeric_corner_stream_18
                  li           s6, 0xe8a564ef
                  li           t6, 0xffffffff
                  li           t0, 0xffffffff
                  li           a3, 0xffffffff
                  li           s4, 0x912dad3f
                  li           s5, 0x0
                  li           s7, 0x8d91ebf2
                  li           t1, 0x4a358cb
                  li           s2, 0xffffffff
                  auipc        a3, 736371
                  sub          t1, s5, t1
                  add          t6, t6, s2
                  nop
                  auipc        a3, 736371
                  lui          a3, 1089
                  auipc        a3, 736371
                  sub          t1, s5, t1
                  lui          a3, 1089
                  lui          a3, 1089
                  auipc        a3, 736371
                  add          t6, t6, s2
                  nop
                  lui          a3, 1089
                  addi         a3, a3, -1859
                  nop
                  lui          a3, 1089
                  nop
                  add          t6, t6, s2 #end riscv_int_numeric_corner_stream_18
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  nop
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  nop
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  nop
                  nop
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  add          a6, t4, s9
                  add          a6, t4, s9
                  and          a0, gp, a2
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  nop
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  nop
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  lui          a1, 1089
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  nop
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  and          a0, gp, a2
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  nop
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  lui          a1, 1089
                  and          a0, gp, a2
                  nop
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  lui          a1, 1089
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  lui          a1, 1089
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  nop
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  lui          a1, 1089
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  nop
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  lui          a1, 1089
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  nop
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  lui          a1, 1089
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  add          a6, t4, s9
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  lui          a1, 1089
                  srai         s7, t5, 16
                  nop
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  lui          a1, 1089
                  auipc        a0, 736371
                  or           s7, ra, t6
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  nop
                  lui          a1, 1089
                  or           s7, ra, t6
                  nop
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  lui          a1, 1089
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  lui          a1, 1089
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  nop
                  lui          a1, 1089
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  nop
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  nop
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  add          a6, t4, s9
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  li           sp, 0x267a0bf0 #start riscv_int_numeric_corner_stream_3
                  li           a1, 0x8f9e642a
                  li           s6, 0x0
                  li           a2, 0x0
                  li           a3, 0x80000000
                  li           s1, 0x9ad853a6
                  li           t2, 0x80000000
                  li           s10, 0x80000000
                  li           t5, 0x80000000
                  li           s11, 0x80000000
                  add          s11, a2, s11
                  auipc        a1, 736371
                  addi         a3, a3, -1859
                  lui          a1, 1089
                  addi         a3, a3, -1859
                  sub          s1, s1, sp
                  auipc        a1, 736371
                  add          s11, a2, s11
                  addi         a3, a3, -1859
                  add          s11, a2, s11
                  sub          s1, s1, sp
                  addi         a3, a3, -1859
                  nop
                  addi         a3, a3, -1859
                  addi         a3, a3, -1859
                  auipc        a1, 736371
                  lui          a1, 1089
                  sub          s1, s1, sp
                  nop
                  add          s11, a2, s11 #end riscv_int_numeric_corner_stream_3
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  lui          a1, 1089
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  lui          a1, 1089
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  nop
                  lui          a1, 1089
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  or           s7, ra, t6
                  add          a6, t4, s9
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  nop
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  nop
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  auipc        a0, 736371
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  nop
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  nop
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  nop
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  nop
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  lui          a1, 1089
                  lui          a1, 1089
                  lui          a1, 1089
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  nop
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  lui          a1, 1089
                  nop
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  lui          a1, 1089
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  nop
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  nop
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  lui          a1, 1089
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  auipc        a0, 736371
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  auipc        a0, 736371
                  nop
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  lui          a1, 1089
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  or           s7, ra, t6
                  nop
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  nop
                  or           s7, ra, t6
                  nop
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  nop
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  lui          a1, 1089
                  and          a0, gp, a2
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  nop
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  nop
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  nop
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  nop
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  add          a6, t4, s9
                  nop
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  lui          a1, 1089
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  and          a0, gp, a2
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  nop
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  nop
                  ori          s7, a7, 1695
                  lui          a1, 1089
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  nop
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  lui          a1, 1089
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  li           a2, 0x80000000 #start riscv_int_numeric_corner_stream_35
                  li           t5, 0xc464a77d
                  li           s2, 0xffffffff
                  li           t4, 0x0
                  li           s10, 0x80000000
                  li           s4, 0x2e1e6fdc
                  li           s7, 0x0
                  li           a6, 0x80000000
                  li           s5, 0xffffffff
                  li           a4, 0xffffffff
                  add          t5, t5, s10
                  lui          a4, 1089
                  nop
                  lui          a4, 1089
                  nop
                  nop
                  sub          s2, s5, a2
                  addi         s4, t4, -1859
                  addi         s4, t4, -1859
                  addi         s4, t4, -1859
                  add          t5, t5, s10
                  auipc        a2, 736371
                  auipc        a2, 736371
                  auipc        a2, 736371
                  addi         s4, t4, -1859 #end riscv_int_numeric_corner_stream_35
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  nop
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  nop
                  nop
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  sll          s1, tp, s7
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  lui          a1, 1089
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  nop
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  nop
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  nop
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  li           s6, 0x0 #start riscv_int_numeric_corner_stream_31
                  li           ra, 0xffffffff
                  li           a3, 0xe4983842
                  li           t0, 0xffffffff
                  li           sp, 0xffffffff
                  li           a6, 0xffffffff
                  li           s10, 0x0
                  li           s7, 0x0
                  li           s0, 0x41ff2c8a
                  li           t3, 0xffffffff
                  lui          t0, 1089
                  auipc        s0, 736371
                  lui          t0, 1089
                  auipc        s0, 736371
                  lui          t0, 1089
                  auipc        s0, 736371
                  auipc        s0, 736371
                  auipc        s0, 736371
                  sub          sp, ra, sp
                  sub          sp, ra, sp
                  addi         t3, t3, -1859
                  add          t0, t3, s10
                  sub          sp, ra, sp
                  sub          sp, ra, sp
                  lui          t0, 1089
                  lui          t0, 1089
                  nop #end riscv_int_numeric_corner_stream_31
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  nop
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  or           s7, ra, t6
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  srl          s10, sp, gp
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  lui          a1, 1089
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  nop
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  srai         s7, t5, 16
                  lui          a1, 1089
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  nop
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  lui          a1, 1089
                  nop
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  nop
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  nop
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  nop
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  nop
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  add          a6, t4, s9
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  lui          a1, 1089
                  add          a6, t4, s9
                  add          a6, t4, s9
                  or           s7, ra, t6
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  add          a6, t4, s9
                  nop
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  nop
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  and          a0, gp, a2
                  and          a0, gp, a2
                  lui          a1, 1089
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  nop
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  nop
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sltiu        a1, s6, -1603
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  nop
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_7
                  li           a4, 0x80000000
                  li           s7, 0xffffffff
                  li           s6, 0xffffffff
                  li           t1, 0xffffffff
                  li           s2, 0xffffffff
                  li           sp, 0x80000000
                  li           s10, 0x0
                  li           s3, 0xffffffff
                  li           a6, 0x0
                  sub          t1, t1, sp
                  lui          a4, 1089
                  add          s7, a6, s10
                  addi         s2, a6, -1859
                  lui          a4, 1089
                  lui          a4, 1089
                  lui          a4, 1089
                  add          s7, a6, s10
                  sub          t1, t1, sp
                  add          s7, a6, s10
                  lui          a4, 1089
                  add          s7, a6, s10
                  sub          t1, t1, sp
                  add          s7, a6, s10
                  lui          a4, 1089
                  add          s7, a6, s10
                  nop
                  add          s7, a6, s10
                  add          s7, a6, s10
                  add          s7, a6, s10 #end riscv_int_numeric_corner_stream_7
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  and          a0, gp, a2
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  li           s9, 0x80000000 #start riscv_int_numeric_corner_stream_8
                  li           s10, 0x0
                  li           t3, 0xffffffff
                  li           sp, 0xeb5f80ca
                  li           s11, 0x80000000
                  li           t0, 0x0
                  li           t2, 0xbfbf86ff
                  li           t1, 0xffffffff
                  li           s0, 0x80000000
                  li           a2, 0xffffffff
                  addi         t0, t3, -1859
                  nop
                  add          t0, s11, s11
                  sub          t2, s11, sp
                  add          t0, s11, s11
                  lui          t2, 1089
                  add          t0, s11, s11
                  nop
                  lui          t2, 1089
                  nop
                  addi         t0, t3, -1859
                  lui          t2, 1089
                  nop
                  addi         t0, t3, -1859
                  add          t0, s11, s11 #end riscv_int_numeric_corner_stream_8
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  nop
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  nop
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  li           a4, 0x80000000 #start riscv_int_numeric_corner_stream_23
                  li           s4, 0xffffffff
                  li           a6, 0x80000000
                  li           t6, 0x80000000
                  li           a1, 0xffffffff
                  li           a0, 0x80000000
                  li           ra, 0xffffffff
                  li           s3, 0x0
                  li           gp, 0x0
                  li           s8, 0xb9502c3
                  add          ra, s8, s8
                  sub          gp, ra, gp
                  nop
                  nop
                  add          ra, s8, s8
                  addi         a4, s8, -1859
                  sub          gp, ra, gp
                  auipc        a1, 736371
                  add          ra, s8, s8
                  auipc        a1, 736371
                  lui          gp, 1089
                  auipc        a1, 736371
                  auipc        a1, 736371
                  sub          gp, ra, gp
                  add          ra, s8, s8
                  add          ra, s8, s8 #end riscv_int_numeric_corner_stream_23
                  sub          a1, s9, gp
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  nop
                  and          a0, gp, a2
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  lui          a1, 1089
                  srl          s10, sp, gp
                  lui          a1, 1089
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  nop
                  nop
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  or           s7, ra, t6
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  srl          s10, sp, gp
                  slli         t0, s6, 8
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  and          a0, gp, a2
                  nop
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  or           s7, ra, t6
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  nop
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  slt          gp, t0, s5
                  nop
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  lui          a1, 1089
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  lui          a1, 1089
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  lui          a1, 1089
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  nop
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  nop
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  nop
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  li           s10, 0xe6a119dd #start riscv_int_numeric_corner_stream_12
                  li           s7, 0x0
                  li           a1, 0x0
                  li           gp, 0x0
                  li           t3, 0x0
                  li           t4, 0x0
                  li           t5, 0xd311d2a0
                  li           t0, 0xaeac6750
                  li           s5, 0x3d9d86c9
                  li           s4, 0xec0c0827
                  auipc        t0, 736371
                  add          s5, s5, a1
                  auipc        t0, 736371
                  auipc        t0, 736371
                  auipc        t0, 736371
                  sub          a1, a1, a1
                  addi         t4, t4, -1859
                  nop
                  nop
                  lui          t0, 1089
                  sub          a1, a1, a1
                  add          s5, s5, a1
                  auipc        t0, 736371
                  add          s5, s5, a1
                  nop
                  lui          t0, 1089
                  sub          a1, a1, a1 #end riscv_int_numeric_corner_stream_12
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  nop
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  nop
                  nop
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  slt          gp, t0, s5
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  lui          a1, 1089
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  lui          a1, 1089
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  nop
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  nop
                  nop
                  nop
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  sub          a1, s9, gp
                  lui          a1, 1089
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  nop
                  sltiu        a1, s6, -1603
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  nop
                  sll          s1, tp, s7
                  ori          s7, a7, 1695
                  or           s7, ra, t6
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  slti         t6, a2, 1362
                  sub          a1, s9, gp
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  nop
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  lui          a1, 1089
                  srl          s10, sp, gp
                  ori          s7, a7, 1695
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  nop
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  nop
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  add          a6, t4, s9
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  nop
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  lui          a1, 1089
                  slt          gp, t0, s5
                  or           s7, ra, t6
                  srli         a4, a1, 5
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  slt          gp, t0, s5
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  slti         t6, a2, 1362
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  and          a0, gp, a2
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  xor          sp, a1, tp
                  lui          a1, 1089
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  nop
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  sra          t5, s0, a7
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  sub          a1, s9, gp
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  srli         a4, a1, 5
                  lui          a1, 1089
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  nop
                  nop
                  lui          a1, 1089
                  add          a6, t4, s9
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  add          a6, t4, s9
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  nop
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  nop
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  lui          a1, 1089
                  slt          gp, t0, s5
                  andi         sp, s11, -1769
                  and          a0, gp, a2
                  lui          a1, 1089
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  xor          sp, a1, tp
                  auipc        a0, 736371
                  auipc        a0, 736371
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  xor          sp, a1, tp
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  nop
                  nop
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  nop
                  lui          a1, 1089
                  xor          sp, a1, tp
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  sra          t5, s0, a7
                  nop
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  slli         t0, s6, 8
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sub          a1, s9, gp
                  auipc        a0, 736371
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  srli         a4, a1, 5
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  sltu         s10, a7, s0
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  srli         a4, a1, 5
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  sll          s1, tp, s7
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sltu         s10, a7, s0
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  srli         a4, a1, 5
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  sub          a1, s9, gp
                  or           s7, ra, t6
                  lui          a1, 1089
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  srai         s7, t5, 16
                  or           s7, ra, t6
                  and          a0, gp, a2
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  slti         t6, a2, 1362
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  nop
                  and          a0, gp, a2
                  and          a0, gp, a2
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  lui          a1, 1089
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  nop
                  srli         a4, a1, 5
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  and          a0, gp, a2
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  add          a6, t4, s9
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  xori         a2, s10, -1144
                  sltu         s10, a7, s0
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  srai         s7, t5, 16
                  nop
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  srai         s7, t5, 16
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  xor          sp, a1, tp
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  or           s7, ra, t6
                  add          a6, t4, s9
                  andi         sp, s11, -1769
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  srl          s10, sp, gp
                  or           s7, ra, t6
                  sltiu        a1, s6, -1603
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  srai         s7, t5, 16
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  sub          a1, s9, gp
                  sll          s1, tp, s7
                  slt          gp, t0, s5
                  xor          sp, a1, tp
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  sltu         s10, a7, s0
                  sra          t5, s0, a7
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  nop
                  sub          a1, s9, gp
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  xor          sp, a1, tp
                  lui          a1, 1089
                  sub          a1, s9, gp
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  slti         t6, a2, 1362
                  addi         t2, t3, -1859
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  nop
                  nop
                  nop
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  srl          s10, sp, gp
                  sra          t5, s0, a7
                  and          a0, gp, a2
                  xor          sp, a1, tp
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  sll          s1, tp, s7
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  sub          a1, s9, gp
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  nop
                  or           s7, ra, t6
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  sltiu        a1, s6, -1603
                  srli         a4, a1, 5
                  nop
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  nop
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  srli         a4, a1, 5
                  sltu         s10, a7, s0
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  or           s7, ra, t6
                  auipc        a0, 736371
                  srl          s10, sp, gp
                  add          a6, t4, s9
                  sra          t5, s0, a7
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  xor          sp, a1, tp
                  addi         t2, t3, -1859
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  add          a6, t4, s9
                  and          a0, gp, a2
                  srai         s7, t5, 16
                  ori          s7, a7, 1695
                  sra          t5, s0, a7
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  nop
                  sltu         s10, a7, s0
                  xori         a2, s10, -1144
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  and          a0, gp, a2
                  sll          s1, tp, s7
                  srai         s7, t5, 16
                  auipc        a0, 736371
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  auipc        a0, 736371
                  sltiu        a1, s6, -1603
                  slli         t0, s6, 8
                  nop
                  sra          t5, s0, a7
                  sltu         s10, a7, s0
                  addi         t2, t3, -1859
                  nop
                  nop
                  or           s7, ra, t6
                  nop
                  or           s7, ra, t6
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  slti         t6, a2, 1362
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  andi         sp, s11, -1769
                  slli         t0, s6, 8
                  or           s7, ra, t6
                  nop
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  sub          a1, s9, gp
                  sub          a1, s9, gp
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  auipc        a0, 736371
                  add          a6, t4, s9
                  xor          sp, a1, tp
                  srli         a4, a1, 5
                  nop
                  slt          gp, t0, s5
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  sll          s1, tp, s7
                  nop
                  slti         t6, a2, 1362
                  slli         t0, s6, 8
                  sltu         s10, a7, s0
                  xor          sp, a1, tp
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  sub          a1, s9, gp
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  ori          s7, a7, 1695
                  addi         t2, t3, -1859
                  add          a6, t4, s9
                  slli         t0, s6, 8
                  sra          t5, s0, a7
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  add          a6, t4, s9
                  or           s7, ra, t6
                  nop
                  sra          t5, s0, a7
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  auipc        a0, 736371
                  sub          a1, s9, gp
                  slt          gp, t0, s5
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  xori         a2, s10, -1144
                  lui          a1, 1089
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  sll          s1, tp, s7
                  slli         t0, s6, 8
                  and          a0, gp, a2
                  ori          s7, a7, 1695
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  addi         t2, t3, -1859
                  slli         t0, s6, 8
                  slti         t6, a2, 1362
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  xori         a2, s10, -1144
                  and          a0, gp, a2
                  slli         t0, s6, 8
                  xor          sp, a1, tp
                  slli         t0, s6, 8
                  sll          s1, tp, s7
                  sra          t5, s0, a7
                  andi         sp, s11, -1769
                  slt          gp, t0, s5
                  slt          gp, t0, s5
                  add          a6, t4, s9
                  srl          s10, sp, gp
                  sltiu        a1, s6, -1603
                  srl          s10, sp, gp
                  xori         a2, s10, -1144
                  auipc        a0, 736371
                  slli         t0, s6, 8
                  xori         a2, s10, -1144
                  srli         a4, a1, 5
                  nop
                  slli         t0, s6, 8
                  add          a6, t4, s9
                  srli         a4, a1, 5
                  xori         a2, s10, -1144
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  or           s7, ra, t6
                  or           s7, ra, t6
                  srl          s10, sp, gp
                  srli         a4, a1, 5
                  nop
                  srl          s10, sp, gp
                  xor          sp, a1, tp
                  or           s7, ra, t6
                  slti         t6, a2, 1362
                  ori          s7, a7, 1695
                  and          a0, gp, a2
                  srl          s10, sp, gp
                  srai         s7, t5, 16
                  xori         a2, s10, -1144
                  slti         t6, a2, 1362
                  and          a0, gp, a2
                  and          a0, gp, a2
                  add          a6, t4, s9
                  slti         t6, a2, 1362
                  add          a6, t4, s9
                  addi         t2, t3, -1859
                  sll          s1, tp, s7
                  lui          a1, 1089
                  sra          t5, s0, a7
                  slt          gp, t0, s5
                  srl          s10, sp, gp
                  slti         t6, a2, 1362
                  sltu         s10, a7, s0
                  or           s7, ra, t6
                  sll          s1, tp, s7
                  slti         t6, a2, 1362
                  andi         sp, s11, -1769
                  sltu         s10, a7, s0
                  nop
                  andi         sp, s11, -1769
                  xori         a2, s10, -1144
                  sub          a1, s9, gp
                  ori          s7, a7, 1695
                  srli         a4, a1, 5
                  sll          s1, tp, s7
                  and          a0, gp, a2
                  auipc        a0, 736371
                  ori          s7, a7, 1695
                  andi         sp, s11, -1769
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  addi         t2, t3, -1859
                  nop
                  sub          a1, s9, gp
                  sra          t5, s0, a7
                  sra          t5, s0, a7
                  sltiu        a1, s6, -1603
                  xori         a2, s10, -1144
                  or           s7, ra, t6
                  or           s7, ra, t6
                  addi         t2, t3, -1859
                  nop
                  sltiu        a1, s6, -1603
                  andi         sp, s11, -1769
                  srli         a4, a1, 5
                  sltiu        a1, s6, -1603
                  auipc        a0, 736371
                  slt          gp, t0, s5
                  and          a0, gp, a2
                  sltiu        a1, s6, -1603
                  and          a0, gp, a2
                  andi         sp, s11, -1769
                  ori          s7, a7, 1695
                  sltu         s10, a7, s0
                  lui          a1, 1089
                  xori         a2, s10, -1144
                  sra          t5, s0, a7
                  srli         a4, a1, 5
                  slt          gp, t0, s5
                  srai         s7, t5, 16
                  add          a6, t4, s9
                  sltiu        a1, s6, -1603
                  sra          t5, s0, a7
                  lui          a1, 1089
                  addi         t2, t3, -1859
                  sra          t5, s0, a7
                  addi         t2, t3, -1859
                  slt          gp, t0, s5
                  addi         t2, t3, -1859
                  or           s7, ra, t6
                  sub          a1, s9, gp
                  slli         t0, s6, 8
                  auipc        a0, 736371
                  andi         sp, s11, -1769
                  srai         s7, t5, 16
                  addi         t2, t3, -1859
                  srl          s10, sp, gp
                  auipc        a0, 736371
                  or           s7, ra, t6
                  nop
                  la x17, test_done
                  jalr x0, x17, 0
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
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_2:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_3:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_4:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_5:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_6:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_7:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_8:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_9:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_10:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_11:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_12:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_13:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_14:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

mmode_intr_vector_15:
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x17, test_done
                  jalr x0, x17, 0

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
                  addi x4, x4, -4
                  sw  x15, (x4)
                  add x15, x4, zero
                  addi x15, x15, -128
                  sw  x1, 4(x15)
                  sw  x2, 8(x15)
                  sw  x3, 12(x15)
                  sw  x4, 16(x15)
                  sw  x5, 20(x15)
                  sw  x6, 24(x15)
                  sw  x7, 28(x15)
                  sw  x8, 32(x15)
                  sw  x9, 36(x15)
                  sw  x10, 40(x15)
                  sw  x11, 44(x15)
                  sw  x12, 48(x15)
                  sw  x13, 52(x15)
                  sw  x14, 56(x15)
                  sw  x15, 60(x15)
                  sw  x16, 64(x15)
                  sw  x17, 68(x15)
                  sw  x18, 72(x15)
                  sw  x19, 76(x15)
                  sw  x20, 80(x15)
                  sw  x21, 84(x15)
                  sw  x22, 88(x15)
                  sw  x23, 92(x15)
                  sw  x24, 96(x15)
                  sw  x25, 100(x15)
                  sw  x26, 104(x15)
                  sw  x27, 108(x15)
                  sw  x28, 112(x15)
                  sw  x29, 116(x15)
                  sw  x30, 120(x15)
                  sw  x31, 124(x15)
                  add x4, x15, zero
                  csrr x7, 0x341 # MEPC
                  csrr x7, 0x342 # MCAUSE
                  li x2, 0x3 # BREAKPOINT
                  beq x7, x2, ebreak_handler
                  li x2, 0x8 # ECALL_UMODE
                  beq x7, x2, ecall_handler
                  li x2, 0x9 # ECALL_SMODE
                  beq x7, x2, ecall_handler
                  li x2, 0xb # ECALL_MMODE
                  beq x7, x2, ecall_handler
                  li x2, 0x1
                  beq x7, x2, instr_fault_handler
                  li x2, 0x5
                  beq x7, x2, load_fault_handler
                  li x2, 0x7
                  beq x7, x2, store_fault_handler
                  li x2, 0xc
                  beq x7, x2, pt_fault_handler
                  li x2, 0xd
                  beq x7, x2, pt_fault_handler
                  li x2, 0xf
                  beq x7, x2, pt_fault_handler
                  li x2, 0x2 # ILLEGAL_INSTRUCTION
                  beq x7, x2, illegal_instr_handler
                  csrr x2, 0x343 # MTVAL
                  1: la x17, test_done
                  jalr x1, x17, 0

ecall_handler:    
                  la x7, _start
                  sw x0, 0(x7)
                  sw x1, 4(x7)
                  sw x2, 8(x7)
                  sw x3, 12(x7)
                  sw x4, 16(x7)
                  sw x5, 20(x7)
                  sw x6, 24(x7)
                  sw x7, 28(x7)
                  sw x8, 32(x7)
                  sw x9, 36(x7)
                  sw x10, 40(x7)
                  sw x11, 44(x7)
                  sw x12, 48(x7)
                  sw x13, 52(x7)
                  sw x14, 56(x7)
                  sw x15, 60(x7)
                  sw x16, 64(x7)
                  sw x17, 68(x7)
                  sw x18, 72(x7)
                  sw x19, 76(x7)
                  sw x20, 80(x7)
                  sw x21, 84(x7)
                  sw x22, 88(x7)
                  sw x23, 92(x7)
                  sw x24, 96(x7)
                  sw x25, 100(x7)
                  sw x26, 104(x7)
                  sw x27, 108(x7)
                  sw x28, 112(x7)
                  sw x29, 116(x7)
                  sw x30, 120(x7)
                  sw x31, 124(x7)
                  la x17, write_tohost
                  jalr x0, x17, 0

instr_fault_handler:
                  add x15, x4, zero
                  lw  x1, 4(x15)
                  lw  x2, 8(x15)
                  lw  x3, 12(x15)
                  lw  x4, 16(x15)
                  lw  x5, 20(x15)
                  lw  x6, 24(x15)
                  lw  x7, 28(x15)
                  lw  x8, 32(x15)
                  lw  x9, 36(x15)
                  lw  x10, 40(x15)
                  lw  x11, 44(x15)
                  lw  x12, 48(x15)
                  lw  x13, 52(x15)
                  lw  x14, 56(x15)
                  lw  x15, 60(x15)
                  lw  x16, 64(x15)
                  lw  x17, 68(x15)
                  lw  x18, 72(x15)
                  lw  x19, 76(x15)
                  lw  x20, 80(x15)
                  lw  x21, 84(x15)
                  lw  x22, 88(x15)
                  lw  x23, 92(x15)
                  lw  x24, 96(x15)
                  lw  x25, 100(x15)
                  lw  x26, 104(x15)
                  lw  x27, 108(x15)
                  lw  x28, 112(x15)
                  lw  x29, 116(x15)
                  lw  x30, 120(x15)
                  lw  x31, 124(x15)
                  addi x15, x15, 128
                  add x4, x15, zero
                  lw  x15, (x4)
                  addi x4, x4, 4
                  mret

load_fault_handler:
                  add x15, x4, zero
                  lw  x1, 4(x15)
                  lw  x2, 8(x15)
                  lw  x3, 12(x15)
                  lw  x4, 16(x15)
                  lw  x5, 20(x15)
                  lw  x6, 24(x15)
                  lw  x7, 28(x15)
                  lw  x8, 32(x15)
                  lw  x9, 36(x15)
                  lw  x10, 40(x15)
                  lw  x11, 44(x15)
                  lw  x12, 48(x15)
                  lw  x13, 52(x15)
                  lw  x14, 56(x15)
                  lw  x15, 60(x15)
                  lw  x16, 64(x15)
                  lw  x17, 68(x15)
                  lw  x18, 72(x15)
                  lw  x19, 76(x15)
                  lw  x20, 80(x15)
                  lw  x21, 84(x15)
                  lw  x22, 88(x15)
                  lw  x23, 92(x15)
                  lw  x24, 96(x15)
                  lw  x25, 100(x15)
                  lw  x26, 104(x15)
                  lw  x27, 108(x15)
                  lw  x28, 112(x15)
                  lw  x29, 116(x15)
                  lw  x30, 120(x15)
                  lw  x31, 124(x15)
                  addi x15, x15, 128
                  add x4, x15, zero
                  lw  x15, (x4)
                  addi x4, x4, 4
                  mret

store_fault_handler:
                  add x15, x4, zero
                  lw  x1, 4(x15)
                  lw  x2, 8(x15)
                  lw  x3, 12(x15)
                  lw  x4, 16(x15)
                  lw  x5, 20(x15)
                  lw  x6, 24(x15)
                  lw  x7, 28(x15)
                  lw  x8, 32(x15)
                  lw  x9, 36(x15)
                  lw  x10, 40(x15)
                  lw  x11, 44(x15)
                  lw  x12, 48(x15)
                  lw  x13, 52(x15)
                  lw  x14, 56(x15)
                  lw  x15, 60(x15)
                  lw  x16, 64(x15)
                  lw  x17, 68(x15)
                  lw  x18, 72(x15)
                  lw  x19, 76(x15)
                  lw  x20, 80(x15)
                  lw  x21, 84(x15)
                  lw  x22, 88(x15)
                  lw  x23, 92(x15)
                  lw  x24, 96(x15)
                  lw  x25, 100(x15)
                  lw  x26, 104(x15)
                  lw  x27, 108(x15)
                  lw  x28, 112(x15)
                  lw  x29, 116(x15)
                  lw  x30, 120(x15)
                  lw  x31, 124(x15)
                  addi x15, x15, 128
                  add x4, x15, zero
                  lw  x15, (x4)
                  addi x4, x4, 4
                  mret

ebreak_handler:   
                  csrr  x7, 0x341
                  addi  x7, x7, 4
                  csrw  0x341, x7
                  add x15, x4, zero
                  lw  x1, 4(x15)
                  lw  x2, 8(x15)
                  lw  x3, 12(x15)
                  lw  x4, 16(x15)
                  lw  x5, 20(x15)
                  lw  x6, 24(x15)
                  lw  x7, 28(x15)
                  lw  x8, 32(x15)
                  lw  x9, 36(x15)
                  lw  x10, 40(x15)
                  lw  x11, 44(x15)
                  lw  x12, 48(x15)
                  lw  x13, 52(x15)
                  lw  x14, 56(x15)
                  lw  x15, 60(x15)
                  lw  x16, 64(x15)
                  lw  x17, 68(x15)
                  lw  x18, 72(x15)
                  lw  x19, 76(x15)
                  lw  x20, 80(x15)
                  lw  x21, 84(x15)
                  lw  x22, 88(x15)
                  lw  x23, 92(x15)
                  lw  x24, 96(x15)
                  lw  x25, 100(x15)
                  lw  x26, 104(x15)
                  lw  x27, 108(x15)
                  lw  x28, 112(x15)
                  lw  x29, 116(x15)
                  lw  x30, 120(x15)
                  lw  x31, 124(x15)
                  addi x15, x15, 128
                  add x4, x15, zero
                  lw  x15, (x4)
                  addi x4, x4, 4
                  mret

illegal_instr_handler:
                  csrr  x7, 0x341
                  addi  x7, x7, 4
                  csrw  0x341, x7
                  add x15, x4, zero
                  lw  x1, 4(x15)
                  lw  x2, 8(x15)
                  lw  x3, 12(x15)
                  lw  x4, 16(x15)
                  lw  x5, 20(x15)
                  lw  x6, 24(x15)
                  lw  x7, 28(x15)
                  lw  x8, 32(x15)
                  lw  x9, 36(x15)
                  lw  x10, 40(x15)
                  lw  x11, 44(x15)
                  lw  x12, 48(x15)
                  lw  x13, 52(x15)
                  lw  x14, 56(x15)
                  lw  x15, 60(x15)
                  lw  x16, 64(x15)
                  lw  x17, 68(x15)
                  lw  x18, 72(x15)
                  lw  x19, 76(x15)
                  lw  x20, 80(x15)
                  lw  x21, 84(x15)
                  lw  x22, 88(x15)
                  lw  x23, 92(x15)
                  lw  x24, 96(x15)
                  lw  x25, 100(x15)
                  lw  x26, 104(x15)
                  lw  x27, 108(x15)
                  lw  x28, 112(x15)
                  lw  x29, 116(x15)
                  lw  x30, 120(x15)
                  lw  x31, 124(x15)
                  addi x15, x15, 128
                  add x4, x15, zero
                  lw  x15, (x4)
                  addi x4, x4, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x7, 0x300 # MSTATUS;
                  csrr  x7, 0x304 # MIE;
                  csrr  x7, 0x344 # MIP;
                  csrrc x7, 0x344, x7 # MIP;
                  add x15, x4, zero
                  lw  x1, 4(x15)
                  lw  x2, 8(x15)
                  lw  x3, 12(x15)
                  lw  x4, 16(x15)
                  lw  x5, 20(x15)
                  lw  x6, 24(x15)
                  lw  x7, 28(x15)
                  lw  x8, 32(x15)
                  lw  x9, 36(x15)
                  lw  x10, 40(x15)
                  lw  x11, 44(x15)
                  lw  x12, 48(x15)
                  lw  x13, 52(x15)
                  lw  x14, 56(x15)
                  lw  x15, 60(x15)
                  lw  x16, 64(x15)
                  lw  x17, 68(x15)
                  lw  x18, 72(x15)
                  lw  x19, 76(x15)
                  lw  x20, 80(x15)
                  lw  x21, 84(x15)
                  lw  x22, 88(x15)
                  lw  x23, 92(x15)
                  lw  x24, 96(x15)
                  lw  x25, 100(x15)
                  lw  x26, 104(x15)
                  lw  x27, 108(x15)
                  lw  x28, 112(x15)
                  lw  x29, 116(x15)
                  lw  x30, 120(x15)
                  lw  x31, 124(x15)
                  addi x15, x15, 128
                  add x4, x15, zero
                  lw  x15, (x4)
                  addi x4, x4, 4
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
