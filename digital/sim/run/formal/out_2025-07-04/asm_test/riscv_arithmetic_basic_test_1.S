.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x25, h0_start
jalr x0, x25, 0
h0_start:
                  li x29, 0x40000100
                  csrw 0x301, x29
kernel_sp:        
                  la x13, kernel_stack_end

trap_vec_init:    
                  la x29, mtvec_handler
                  ori x29, x29, 1
                  csrw 0x305, x29 # MTVEC

mepc_setup:       
                  la x29, init
                  csrw 0x341, x29

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x29, 0x1800
                  csrw 0x300, x29 # MSTATUS
                  li x29, 0x0
                  csrw 0x304, x29 # MIE
                  mret
init:             
                  li x0, 0xd
                  li x1, 0xff8a514a
                  li x2, 0x81245927
                  li x3, 0x80000000
                  li x4, 0x4
                  li x5, 0x2
                  li x6, 0xb242e5fa
                  li x7, 0x80000000
                  li x8, 0xff6114fd
                  li x9, 0x9
                  li x10, 0x80000000
                  li x12, 0x80000000
                  li x14, 0x14589727
                  li x15, 0x1
                  li x16, 0x0
                  li x17, 0x80000000
                  li x18, 0x891e1e34
                  li x19, 0x9b5a55be
                  li x20, 0x1
                  li x21, 0xc6156220
                  li x22, 0x0
                  li x23, 0x62ae955a
                  li x24, 0xf36d003c
                  li x25, 0xf2e41fd6
                  li x26, 0x0
                  li x27, 0xa4c2a222
                  li x28, 0xe
                  li x29, 0x0
                  li x30, 0xfcd8f805
                  li x31, 0xce099aff
                  la x11, user_stack_end
main:             li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_33
                  li           t5, 0xd4fff6e9
                  li           a4, 0x80000000
                  li           s0, 0xffffffff
                  li           s10, 0xffffffff
                  li           a0, 0x80000000
                  li           s11, 0xffffffff
                  li           a7, 0x8d9c3ae7
                  li           s1, 0x80000000
                  li           a2, 0xffffffff
                  addi         a4, a4, 1891
                  lui          t5, 142675
                  nop
                  addi         a4, a4, 1891
                  add          t5, a7, s11
                  sub          s10, s11, s0
                  auipc        t5, 883493
                  nop
                  add          t5, a7, s11
                  auipc        t5, 883493
                  auipc        t5, 883493
                  sub          s10, s11, s0
                  nop
                  nop
                  add          t5, a7, s11
                  addi         a4, a4, 1891
                  lui          t5, 142675
                  nop
                  nop
                  auipc        t5, 883493
                  add          t5, a7, s11
                  lui          t5, 142675 #end riscv_int_numeric_corner_stream_33
                  li           a5, 0x80000000 #start riscv_int_numeric_corner_stream_29
                  li           ra, 0x9430be91
                  li           s3, 0x80000000
                  li           gp, 0x0
                  li           s0, 0x0
                  li           a6, 0x0
                  li           a7, 0x80000000
                  li           t2, 0x0
                  li           t4, 0xffffffff
                  li           s7, 0xffffffff
                  add          s0, s0, a5
                  addi         a6, a6, 1891
                  addi         a6, a6, 1891
                  addi         a6, a6, 1891
                  lui          s7, 142675
                  lui          s7, 142675
                  lui          s7, 142675
                  lui          s7, 142675
                  auipc        t4, 883493
                  add          s0, s0, a5
                  nop
                  sub          s0, s0, s0
                  nop
                  add          s0, s0, a5
                  auipc        t4, 883493
                  auipc        t4, 883493
                  lui          s7, 142675
                  auipc        t4, 883493
                  sub          s0, s0, s0
                  add          s0, s0, a5
                  lui          s7, 142675
                  sub          s0, s0, s0
                  lui          s7, 142675
                  addi         a6, a6, 1891
                  lui          s7, 142675
                  add          s0, s0, a5
                  addi         a6, a6, 1891
                  addi         a6, a6, 1891
                  lui          s7, 142675 #end riscv_int_numeric_corner_stream_29
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_20
                  li           a0, 0x0
                  li           s11, 0x0
                  li           t5, 0x964a9609
                  li           ra, 0x0
                  li           s5, 0x0
                  li           s1, 0xffffffff
                  li           a6, 0x80000000
                  li           s2, 0x38e7aa00
                  li           sp, 0x2123f32b
                  addi         t5, tp, 1891
                  auipc        t5, 883493
                  add          t5, s2, s11
                  nop
                  addi         t5, tp, 1891
                  nop
                  sub          a0, s11, sp
                  addi         t5, tp, 1891
                  lui          t5, 142675
                  nop
                  nop
                  auipc        t5, 883493
                  sub          a0, s11, sp
                  auipc        t5, 883493
                  sub          a0, s11, sp
                  sub          a0, s11, sp
                  sub          a0, s11, sp
                  auipc        t5, 883493 #end riscv_int_numeric_corner_stream_20
                  li           t0, 0x80000000 #start riscv_int_numeric_corner_stream_1
                  li           t2, 0x0
                  li           s2, 0xffffffff
                  li           s6, 0xed54df2a
                  li           t5, 0xffffffff
                  li           gp, 0x80000000
                  li           sp, 0x80000000
                  li           ra, 0xffffffff
                  li           tp, 0xffffffff
                  li           a7, 0xffffffff
                  add          s2, t0, t5
                  addi         t5, tp, 1891
                  nop
                  nop
                  addi         t5, tp, 1891
                  add          s2, t0, t5
                  add          s2, t0, t5
                  sub          s2, gp, tp
                  lui          t5, 142675
                  sub          s2, gp, tp
                  auipc        t5, 883493
                  auipc        t5, 883493
                  auipc        t5, 883493
                  sub          s2, gp, tp
                  nop #end riscv_int_numeric_corner_stream_1
                  li           a0, 0x0 #start riscv_int_numeric_corner_stream_5
                  li           t6, 0x80000000
                  li           tp, 0x0
                  li           t4, 0xffffffff
                  li           s11, 0xa9d6b575
                  li           s2, 0xffffffff
                  li           t5, 0x80000000
                  li           sp, 0xffffffff
                  li           s6, 0x0
                  li           s10, 0xffffffff
                  sub          s10, a0, tp
                  auipc        s6, 883493
                  sub          s10, a0, tp
                  auipc        s6, 883493
                  add          t6, a0, s11
                  add          t6, a0, s11
                  lui          t5, 142675
                  nop
                  add          t6, a0, s11
                  nop
                  sub          s10, a0, tp
                  addi         t5, tp, 1891
                  add          t6, a0, s11
                  lui          t5, 142675
                  add          t6, a0, s11
                  add          t6, a0, s11
                  add          t6, a0, s11
                  lui          t5, 142675
                  add          t6, a0, s11
                  auipc        s6, 883493
                  sub          s10, a0, tp #end riscv_int_numeric_corner_stream_5
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_38
                  li           s2, 0x0
                  li           a0, 0x80000000
                  li           s0, 0xffffffff
                  li           s6, 0x0
                  li           t1, 0x167e91e2
                  li           tp, 0xc3d9e6c3
                  li           a7, 0x80000000
                  li           t6, 0xffffffff
                  li           a5, 0x80000000
                  sub          a6, a0, s0
                  addi         s6, t1, 1891
                  auipc        t6, 883493
                  auipc        t6, 883493
                  add          t6, s0, a5
                  add          t6, s0, a5
                  nop
                  addi         s6, t1, 1891
                  add          t6, s0, a5
                  nop
                  add          t6, s0, a5
                  add          t6, s0, a5
                  auipc        t6, 883493
                  addi         s6, t1, 1891
                  auipc        t6, 883493
                  sub          a6, a0, s0
                  sub          a6, a0, s0
                  auipc        t6, 883493
                  add          t6, s0, a5
                  nop
                  sub          a6, a0, s0
                  nop
                  auipc        t6, 883493
                  lui          s6, 142675
                  add          t6, s0, a5 #end riscv_int_numeric_corner_stream_38
                  li           a5, 0x80000000 #start riscv_int_numeric_corner_stream_0
                  li           s1, 0x0
                  li           a4, 0x80000000
                  li           t1, 0xcc94f63
                  li           a6, 0x0
                  li           ra, 0x0
                  li           t5, 0xc9073cec
                  li           s6, 0xcc6f4a7d
                  li           tp, 0x80000000
                  li           s10, 0x847b9c4d
                  auipc        t5, 883493
                  add          t5, s6, a5
                  sub          s10, s10, ra
                  auipc        t5, 883493
                  nop
                  auipc        t5, 883493
                  addi         t5, tp, 1891
                  addi         t5, tp, 1891
                  lui          t5, 142675
                  nop
                  auipc        t5, 883493
                  auipc        t5, 883493
                  auipc        t5, 883493
                  sub          s10, s10, ra
                  auipc        t5, 883493
                  nop
                  addi         t5, tp, 1891 #end riscv_int_numeric_corner_stream_0
                  li           s11, 0xffffffff #start riscv_int_numeric_corner_stream_30
                  li           a2, 0x80000000
                  li           s7, 0x80000000
                  li           t4, 0x0
                  li           t6, 0x0
                  li           s10, 0x80000000
                  li           t3, 0x80000000
                  li           s8, 0x80000000
                  li           t2, 0x80000000
                  li           a5, 0xffffffff
                  add          t3, s10, a5
                  sub          s11, s7, a2
                  lui          s7, 142675
                  addi         t3, s10, 1891
                  nop
                  lui          s7, 142675
                  addi         t3, s10, 1891
                  add          t3, s10, a5
                  lui          s7, 142675
                  add          t3, s10, a5
                  lui          s7, 142675
                  addi         t3, s10, 1891
                  auipc        s7, 883493
                  nop
                  nop #end riscv_int_numeric_corner_stream_30
                  li           t4, 0xffffffff #start riscv_int_numeric_corner_stream_34
                  li           s0, 0x80000000
                  li           s6, 0xffffffff
                  li           a2, 0xffffffff
                  li           t0, 0x0
                  li           s5, 0x0
                  li           s4, 0x0
                  li           a6, 0x0
                  li           t3, 0xffffffff
                  li           t5, 0x0
                  auipc        s6, 883493
                  addi         t4, s4, 1891
                  addi         t4, s4, 1891
                  add          s6, t5, t5
                  addi         t4, s4, 1891
                  addi         t4, s4, 1891
                  auipc        s6, 883493
                  auipc        s6, 883493
                  nop
                  auipc        s6, 883493
                  auipc        s6, 883493
                  add          s6, t5, t5
                  addi         t4, s4, 1891
                  addi         t4, s4, 1891
                  nop #end riscv_int_numeric_corner_stream_34
                  li           sp, 0x80000000 #start riscv_int_numeric_corner_stream_4
                  li           t6, 0x80000000
                  li           t4, 0x0
                  li           a0, 0x80000000
                  li           s11, 0x80000000
                  li           t3, 0x80000000
                  li           s3, 0xffffffff
                  li           ra, 0xffffffff
                  li           s8, 0xffffffff
                  li           a7, 0x80000000
                  nop
                  addi         t3, t3, 1891
                  lui          s11, 142675
                  add          t6, a0, s11
                  add          t6, a0, s11
                  add          t6, a0, s11
                  addi         t3, t3, 1891
                  nop
                  nop
                  nop
                  add          t6, a0, s11
                  add          t6, a0, s11
                  sub          s8, s8, sp
                  auipc        t6, 883493
                  addi         t3, t3, 1891
                  addi         t3, t3, 1891
                  add          t6, a0, s11
                  sub          s8, s8, sp
                  add          t6, a0, s11
                  lui          s11, 142675
                  nop
                  nop
                  lui          s11, 142675
                  lui          s11, 142675
                  nop
                  addi         t3, t3, 1891
                  add          t6, a0, s11
                  addi         t3, t3, 1891
                  add          t6, a0, s11 #end riscv_int_numeric_corner_stream_4
                  li           a0, 0xa6bc0144 #start riscv_int_numeric_corner_stream_17
                  li           a5, 0xffffffff
                  li           t5, 0xffffffff
                  li           a6, 0x0
                  li           sp, 0x0
                  li           s7, 0x0
                  li           s0, 0xffffffff
                  li           s8, 0x0
                  li           t6, 0xffffffff
                  li           a4, 0xffffffff
                  sub          a6, a0, s0
                  auipc        s7, 883493
                  sub          a6, a0, s0
                  nop
                  auipc        s7, 883493
                  nop
                  sub          a6, a0, s0
                  lui          t5, 142675
                  add          s0, a4, a5
                  sub          a6, a0, s0
                  add          s0, a4, a5
                  add          s0, a4, a5
                  sub          a6, a0, s0
                  auipc        s7, 883493
                  lui          t5, 142675 #end riscv_int_numeric_corner_stream_17
                  li           a0, 0xb5a3de8f #start riscv_int_numeric_corner_stream_25
                  li           s11, 0x80000000
                  li           s0, 0x80000000
                  li           a2, 0x80000000
                  li           tp, 0x80000000
                  li           a5, 0xffffffff
                  li           sp, 0x80000000
                  li           t6, 0xffffffff
                  li           s8, 0xffffffff
                  li           s10, 0x0
                  addi         a5, tp, 1891
                  sub          t6, s10, s0
                  add          tp, a0, a5
                  nop
                  addi         a5, tp, 1891
                  nop
                  addi         a5, tp, 1891
                  auipc        t6, 883493
                  lui          t6, 142675
                  nop
                  sub          t6, s10, s0
                  addi         a5, tp, 1891
                  add          tp, a0, a5
                  add          tp, a0, a5
                  addi         a5, tp, 1891 #end riscv_int_numeric_corner_stream_25
                  li           s10, 0x0 #start riscv_int_numeric_corner_stream_35
                  li           t5, 0xffffffff
                  li           s4, 0x80000000
                  li           t6, 0x94ce9ea1
                  li           s2, 0x21ebc43
                  li           s8, 0xa87ce262
                  li           s11, 0x0
                  li           t1, 0x80000000
                  li           s6, 0x80000000
                  li           a2, 0x0
                  sub          s11, s2, t1
                  addi         t5, s4, 1891
                  sub          s11, s2, t1
                  add          t6, a2, t5
                  add          t6, a2, t5
                  nop
                  nop
                  auipc        s6, 883493
                  lui          t5, 142675
                  sub          s11, s2, t1
                  auipc        s6, 883493
                  sub          s11, s2, t1
                  add          t6, a2, t5
                  add          t6, a2, t5
                  addi         t5, s4, 1891 #end riscv_int_numeric_corner_stream_35
                  li           t1, 0x0 #start riscv_int_numeric_corner_stream_10
                  li           a6, 0x0
                  li           s11, 0x0
                  li           ra, 0xba6bc59
                  li           a4, 0x0
                  li           s3, 0x8cc29adf
                  li           sp, 0xffffffff
                  li           s8, 0xba397c38
                  li           s2, 0x0
                  li           a0, 0x9649381a
                  add          s11, s2, s11
                  sub          a6, s11, sp
                  auipc        a4, 883493
                  add          s11, s2, s11
                  lui          s11, 142675
                  auipc        a4, 883493
                  sub          a6, s11, sp
                  sub          a6, s11, sp
                  sub          a6, s11, sp
                  addi         a4, t1, 1891
                  lui          s11, 142675
                  auipc        a4, 883493
                  nop
                  add          s11, s2, s11
                  auipc        a4, 883493
                  add          s11, s2, s11
                  add          s11, s2, s11
                  add          s11, s2, s11
                  nop
                  add          s11, s2, s11
                  addi         a4, t1, 1891
                  sub          a6, s11, sp
                  auipc        a4, 883493
                  addi         a4, t1, 1891
                  add          s11, s2, s11
                  nop
                  lui          s11, 142675
                  addi         a4, t1, 1891 #end riscv_int_numeric_corner_stream_10
                  li           t6, 0x2d31129b #start riscv_int_numeric_corner_stream_3
                  li           ra, 0xffffffff
                  li           a2, 0xffffffff
                  li           s1, 0x188b9fe0
                  li           gp, 0x80000000
                  li           t1, 0x70445f3f
                  li           a5, 0x7db61fc4
                  li           t4, 0x752b4050
                  li           t5, 0x0
                  li           s3, 0x80000000
                  addi         a5, t1, 1891
                  sub          t6, a5, ra
                  sub          t6, a5, ra
                  add          t6, t1, t5
                  sub          t6, a5, ra
                  lui          t5, 142675
                  lui          t5, 142675
                  addi         a5, t1, 1891
                  sub          t6, a5, ra
                  addi         a5, t1, 1891
                  add          t6, t1, t5
                  sub          t6, a5, ra
                  add          t6, t1, t5
                  addi         a5, t1, 1891
                  add          t6, t1, t5
                  nop
                  nop
                  sub          t6, a5, ra
                  sub          t6, a5, ra
                  add          t6, t1, t5
                  addi         a5, t1, 1891
                  auipc        t4, 883493
                  nop
                  auipc        t4, 883493
                  sub          t6, a5, ra
                  nop #end riscv_int_numeric_corner_stream_3
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  nop
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  nop
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  lui          t5, 142675
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  nop
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  nop
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  lui          t5, 142675
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  lui          t5, 142675
                  nop
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  nop
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  or           s7, t3, s11
                  lui          t5, 142675
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  add          t6, t1, a5
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  nop
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  nop
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  nop
                  nop
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  nop
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  nop
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  nop
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  add          t6, t1, a5
                  lui          t5, 142675
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  lui          t5, 142675
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  nop
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  lui          t5, 142675
                  nop
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  lui          t5, 142675
                  nop
                  nop
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  or           s7, t3, s11
                  li           gp, 0x0 #start riscv_int_numeric_corner_stream_9
                  li           a6, 0x0
                  li           t6, 0x80000000
                  li           a7, 0x80000000
                  li           ra, 0x80000000
                  li           t0, 0x86d50669
                  li           tp, 0xffffffff
                  li           s11, 0xe32a9a92
                  li           s3, 0x74b20028
                  li           a5, 0xffffffff
                  nop
                  add          a6, s3, t6
                  addi         a6, a6, 1891
                  auipc        t6, 883493
                  lui          s11, 142675
                  auipc        t6, 883493
                  sub          s11, a6, ra
                  auipc        t6, 883493
                  auipc        t6, 883493
                  addi         a6, a6, 1891
                  auipc        t6, 883493
                  sub          s11, a6, ra
                  lui          s11, 142675
                  nop
                  auipc        t6, 883493
                  lui          s11, 142675
                  addi         a6, a6, 1891
                  addi         a6, a6, 1891
                  auipc        t6, 883493
                  sub          s11, a6, ra
                  auipc        t6, 883493 #end riscv_int_numeric_corner_stream_9
                  andi         sp, a5, -1334
                  nop
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  nop
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  nop
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  nop
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  lui          t5, 142675
                  nop
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  nop
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_26
                  li           ra, 0x80000000
                  li           s1, 0x80000000
                  li           s5, 0x0
                  li           s7, 0xe4608c54
                  li           s11, 0x80000000
                  li           t2, 0x80000000
                  li           s2, 0x47f870fc
                  li           t0, 0x80000000
                  li           a7, 0x16fc8b35
                  addi         s2, s2, 1891
                  lui          s7, 142675
                  nop
                  add          tp, s2, s11
                  nop
                  nop
                  nop
                  addi         s2, s2, 1891
                  add          tp, s2, s11
                  add          tp, s2, s11
                  lui          s7, 142675
                  nop
                  lui          s7, 142675
                  add          tp, s2, s11
                  sub          s11, s2, ra
                  nop
                  nop
                  lui          s7, 142675
                  lui          s7, 142675 #end riscv_int_numeric_corner_stream_26
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  lui          t5, 142675
                  add          t6, t1, a5
                  lui          t5, 142675
                  nop
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  lui          t5, 142675
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  lui          t5, 142675
                  nop
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  nop
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  nop
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  nop
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  lui          t5, 142675
                  nop
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  lui          t5, 142675
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  nop
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  nop
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_21
                  li           sp, 0x966e04ad
                  li           t5, 0x80000000
                  li           s8, 0x0
                  li           t4, 0x80000000
                  li           t1, 0xffffffff
                  li           s6, 0x0
                  li           s4, 0x80000000
                  li           a5, 0x0
                  li           t2, 0x0
                  sub          sp, s8, sp
                  lui          t5, 142675
                  nop
                  nop
                  nop
                  add          t5, s6, t5
                  add          t5, s6, t5
                  add          t5, s6, t5
                  nop
                  auipc        s6, 883493
                  nop
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  sub          sp, s8, sp
                  lui          t5, 142675
                  auipc        s6, 883493 #end riscv_int_numeric_corner_stream_21
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  or           s7, t3, s11
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  nop
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  nop
                  lui          t5, 142675
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  nop
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  lui          t5, 142675
                  auipc        s7, 883493
                  nop
                  lui          t5, 142675
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  li           sp, 0xffffffff #start riscv_int_numeric_corner_stream_6
                  li           s0, 0x6d926dc6
                  li           t6, 0xffffffff
                  li           s3, 0xd6ba9f69
                  li           s11, 0xffffffff
                  li           t4, 0x80000000
                  li           t5, 0xffffffff
                  li           t3, 0x0
                  li           s7, 0x0
                  li           s5, 0x80000000
                  lui          t5, 142675
                  sub          s11, s3, sp
                  addi         t5, t3, 1891
                  sub          s11, s3, sp
                  add          t6, s0, t5
                  lui          t5, 142675
                  lui          t5, 142675
                  auipc        t4, 883493
                  nop
                  nop
                  add          t6, s0, t5
                  add          t6, s0, t5
                  sub          s11, s3, sp
                  lui          t5, 142675
                  auipc        t4, 883493 #end riscv_int_numeric_corner_stream_6
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  nop
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  nop
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  nop
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  nop
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  nop
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  nop
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  nop
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  and          t6, a6, t6
                  li           s11, 0x74982c4a #start riscv_int_numeric_corner_stream_19
                  li           t6, 0xffffffff
                  li           ra, 0xffffffff
                  li           gp, 0x0
                  li           s10, 0xa350da04
                  li           t2, 0x0
                  li           t4, 0x80000000
                  li           s4, 0x80000000
                  li           s3, 0x36344d37
                  li           sp, 0xffffffff
                  addi         s4, s4, 1891
                  addi         s4, s4, 1891
                  addi         s4, s4, 1891
                  sub          s11, s3, sp
                  sub          s11, s3, sp
                  add          s10, s3, t6
                  sub          s11, s3, sp
                  auipc        t6, 883493
                  addi         s4, s4, 1891
                  lui          t6, 142675
                  add          s10, s3, t6
                  addi         s4, s4, 1891
                  sub          s11, s3, sp
                  lui          t6, 142675
                  add          s10, s3, t6
                  sub          s11, s3, sp
                  auipc        t6, 883493
                  auipc        t6, 883493
                  add          s10, s3, t6
                  sub          s11, s3, sp
                  auipc        t6, 883493
                  lui          t6, 142675
                  lui          t6, 142675
                  nop
                  nop
                  addi         s4, s4, 1891
                  add          s10, s3, t6
                  auipc        t6, 883493
                  sub          s11, s3, sp
                  auipc        t6, 883493 #end riscv_int_numeric_corner_stream_19
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  and          t6, a6, t6
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  nop
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  nop
                  sub          ra, s9, zero
                  nop
                  add          t6, t1, a5
                  nop
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  nop
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  lui          t5, 142675
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  nop
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  nop
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  nop
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  nop
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  nop
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  add          t6, t1, a5
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  and          t6, a6, t6
                  lui          t5, 142675
                  and          t6, a6, t6
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  nop
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  lui          t5, 142675
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  add          t6, t1, a5
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  nop
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  li           a2, 0x0 #start riscv_int_numeric_corner_stream_2
                  li           a5, 0xffffffff
                  li           a0, 0x0
                  li           s1, 0xffffffff
                  li           t3, 0x0
                  li           t4, 0x0
                  li           t1, 0x80000000
                  li           s8, 0x925c7388
                  li           s3, 0x80000000
                  li           s7, 0x0
                  add          t3, s7, a5
                  nop
                  addi         t3, t3, 1891
                  addi         t3, t3, 1891
                  lui          s7, 142675
                  auipc        s7, 883493
                  add          t3, s7, a5
                  sub          s8, s8, s1
                  lui          s7, 142675
                  add          t3, s7, a5
                  addi         t3, t3, 1891
                  addi         t3, t3, 1891
                  nop
                  addi         t3, t3, 1891
                  add          t3, s7, a5
                  nop
                  nop
                  nop
                  addi         t3, t3, 1891
                  nop
                  auipc        s7, 883493
                  add          t3, s7, a5
                  nop
                  nop
                  lui          s7, 142675
                  add          t3, s7, a5
                  add          t3, s7, a5
                  auipc        s7, 883493
                  auipc        s7, 883493
                  add          t3, s7, a5 #end riscv_int_numeric_corner_stream_2
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  nop
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  nop
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  nop
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  nop
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  lui          t5, 142675
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  add          t6, t1, a5
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  nop
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  or           s7, t3, s11
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  add          t6, t1, a5
                  li           a5, 0xffffffff #start riscv_int_numeric_corner_stream_13
                  li           tp, 0xffffffff
                  li           ra, 0x25ccc2b4
                  li           a7, 0x80000000
                  li           s4, 0x0
                  li           t3, 0x80000000
                  li           s11, 0xc52e0d00
                  li           s0, 0x5d0020c4
                  li           t0, 0xffffffff
                  li           a6, 0x80000000
                  nop
                  auipc        t3, 883493
                  addi         a5, s0, 1891
                  nop
                  add          t3, s4, s11
                  auipc        t3, 883493
                  addi         a5, s0, 1891
                  sub          a6, s0, ra
                  auipc        t3, 883493
                  addi         a5, s0, 1891
                  addi         a5, s0, 1891
                  add          t3, s4, s11
                  sub          a6, s0, ra
                  nop
                  nop
                  lui          s11, 142675
                  addi         a5, s0, 1891
                  addi         a5, s0, 1891
                  auipc        t3, 883493 #end riscv_int_numeric_corner_stream_13
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  and          t6, a6, t6
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  or           s7, t3, s11
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  lui          t5, 142675
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  nop
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  add          t6, t1, a5
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  nop
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  auipc        s7, 883493
                  lui          t5, 142675
                  and          t6, a6, t6
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  add          t6, t1, a5
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  lui          t5, 142675
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  lui          t5, 142675
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  nop
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  nop
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  nop
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  nop
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  lui          t5, 142675
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  nop
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  lui          t5, 142675
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  nop
                  or           s7, t3, s11
                  nop
                  or           s7, t3, s11
                  nop
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  nop
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  lui          t5, 142675
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  lui          t5, 142675
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  nop
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  lui          t5, 142675
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  nop
                  srai         s1, t1, 10
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  lui          t5, 142675
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  lui          t5, 142675
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  or           s7, t3, s11
                  nop
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  lui          t5, 142675
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  nop
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  nop
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  add          t6, t1, a5
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  nop
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  lui          t5, 142675
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  nop
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  nop
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  lui          t5, 142675
                  and          t6, a6, t6
                  nop
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  nop
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  lui          t5, 142675
                  slli         ra, gp, 5
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  lui          t5, 142675
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  lui          t5, 142675
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  auipc        s7, 883493
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  nop
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  and          t6, a6, t6
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  nop
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  nop
                  nop
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  lui          t5, 142675
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  nop
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  nop
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  nop
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  lui          t5, 142675
                  slli         ra, gp, 5
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  nop
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  nop
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  add          t6, t1, a5
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  nop
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  nop
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  nop
                  slti         t0, a3, 1843
                  nop
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  nop
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  nop
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  nop
                  nop
                  sltiu        zero, zero, 1250
                  nop
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  nop
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  lui          t5, 142675
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  nop
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  li           s1, 0xa7184b49 #start riscv_int_numeric_corner_stream_16
                  li           s4, 0x80000000
                  li           s2, 0xffffffff
                  li           a5, 0x0
                  li           a0, 0xffffffff
                  li           t0, 0x71dabdcc
                  li           s10, 0x80000000
                  li           a2, 0x0
                  li           t5, 0xffffffff
                  li           sp, 0xb0793f98
                  lui          t5, 142675
                  auipc        t5, 883493
                  auipc        t5, 883493
                  addi         t5, s4, 1891
                  auipc        t5, 883493
                  addi         t5, s4, 1891
                  nop
                  auipc        t5, 883493
                  add          t5, s2, a5
                  add          t5, s2, a5
                  nop
                  nop
                  add          t5, s2, a5
                  nop
                  sub          s10, a5, sp
                  lui          t5, 142675
                  add          t5, s2, a5
                  lui          t5, 142675
                  lui          t5, 142675
                  nop #end riscv_int_numeric_corner_stream_16
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  nop
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  nop
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  nop
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  and          t6, a6, t6
                  nop
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  lui          t5, 142675
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  lui          t5, 142675
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  lui          t5, 142675
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  nop
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  li           s0, 0xc8a44bf2 #start riscv_int_numeric_corner_stream_11
                  li           a5, 0x0
                  li           sp, 0x80000000
                  li           t6, 0x6b91f8a9
                  li           a4, 0x0
                  li           t4, 0x80000000
                  li           t2, 0xffffffff
                  li           s11, 0x6311a831
                  li           t1, 0x80000000
                  li           gp, 0xffffffff
                  nop
                  nop
                  addi         a4, t1, 1891
                  lui          t6, 142675
                  sub          gp, a5, s0
                  sub          gp, a5, s0
                  auipc        t6, 883493
                  addi         a4, t1, 1891
                  nop
                  addi         a4, t1, 1891
                  add          sp, t1, a5
                  addi         a4, t1, 1891
                  addi         a4, t1, 1891
                  auipc        t6, 883493
                  addi         a4, t1, 1891 #end riscv_int_numeric_corner_stream_11
                  ori          t0, t5, -208
                  lui          t5, 142675
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  nop
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  nop
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  or           s7, t3, s11
                  nop
                  nop
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  lui          t5, 142675
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  and          t6, a6, t6
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  lui          t5, 142675
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  add          t6, t1, a5
                  li           t0, 0xffffffff #start riscv_int_numeric_corner_stream_18
                  li           s3, 0x80000000
                  li           s11, 0x80000000
                  li           a0, 0xeaaf12a1
                  li           t2, 0x68411134
                  li           a4, 0xffffffff
                  li           gp, 0x0
                  li           t5, 0x0
                  li           t3, 0x0
                  li           a6, 0x0
                  nop
                  add          t5, s3, s11
                  addi         t5, t3, 1891
                  add          t5, s3, s11
                  add          t5, s3, s11
                  nop
                  add          t5, s3, s11
                  auipc        t5, 883493
                  lui          t5, 142675
                  nop
                  sub          a0, a0, gp
                  auipc        t5, 883493
                  auipc        t5, 883493
                  nop
                  nop
                  add          t5, s3, s11
                  add          t5, s3, s11
                  add          t5, s3, s11
                  addi         t5, t3, 1891
                  sub          a0, a0, gp #end riscv_int_numeric_corner_stream_18
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  nop
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  nop
                  lui          t5, 142675
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  nop
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  nop
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  and          t6, a6, t6
                  and          t6, a6, t6
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  and          t6, a6, t6
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  lui          t5, 142675
                  auipc        s7, 883493
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  nop
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  nop
                  nop
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  lui          t5, 142675
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  nop
                  lui          t5, 142675
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  lui          t5, 142675
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  nop
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  nop
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  nop
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  lui          t5, 142675
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  nop
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  nop
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  lui          t5, 142675
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  nop
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  li           t5, 0xffffffff #start riscv_int_numeric_corner_stream_36
                  li           gp, 0x80000000
                  li           s11, 0x80000000
                  li           sp, 0x790f13f8
                  li           s2, 0xe465b1c1
                  li           s0, 0xb0026337
                  li           t2, 0x80000000
                  li           a6, 0xe70dd4e4
                  li           t4, 0x28920f5c
                  li           s4, 0x8e3d3e5e
                  sub          s2, t2, s0
                  lui          t5, 142675
                  add          t5, s2, t5
                  nop
                  nop
                  add          t5, s2, t5
                  lui          t5, 142675
                  nop
                  nop
                  lui          t5, 142675
                  addi         t5, s4, 1891
                  add          t5, s2, t5
                  add          t5, s2, t5
                  lui          t5, 142675
                  lui          t5, 142675
                  auipc        t5, 883493 #end riscv_int_numeric_corner_stream_36
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  nop
                  nop
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  nop
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  lui          t5, 142675
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  nop
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  or           s7, t3, s11
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  li           t4, 0x0 #start riscv_int_numeric_corner_stream_22
                  li           a7, 0x0
                  li           s5, 0xffffffff
                  li           t0, 0x0
                  li           ra, 0x0
                  li           s10, 0xffffffff
                  li           s1, 0x0
                  li           a0, 0xffffffff
                  li           s8, 0x84b12eb
                  li           a5, 0x0
                  lui          s10, 142675
                  lui          s10, 142675
                  sub          s8, s10, a0
                  addi         a5, s8, 1891
                  addi         a5, s8, 1891
                  sub          s8, s10, a0
                  addi         a5, s8, 1891
                  auipc        t4, 883493
                  auipc        t4, 883493
                  auipc        t4, 883493
                  auipc        t4, 883493
                  lui          s10, 142675
                  nop
                  addi         a5, s8, 1891
                  auipc        t4, 883493
                  nop
                  auipc        t4, 883493
                  addi         a5, s8, 1891
                  lui          s10, 142675
                  auipc        t4, 883493
                  sub          s8, s10, a0
                  nop
                  add          s10, s5, a5 #end riscv_int_numeric_corner_stream_22
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  nop
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  lui          t5, 142675
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  nop
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  lui          t5, 142675
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  nop
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  nop
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  nop
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  nop
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  nop
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  nop
                  add          t6, t1, a5
                  lui          t5, 142675
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  auipc        s7, 883493
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  lui          t5, 142675
                  auipc        s7, 883493
                  nop
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  nop
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  and          t6, a6, t6
                  and          t6, a6, t6
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  and          t6, a6, t6
                  nop
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  nop
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  nop
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  nop
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  and          t6, a6, t6
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  or           s7, t3, s11
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  nop
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  nop
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  nop
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  nop
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  nop
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  add          t6, t1, a5
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  nop
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  nop
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  nop
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  nop
                  nop
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  lui          t5, 142675
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  lui          t5, 142675
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  lui          t5, 142675
                  lui          t5, 142675
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  nop
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  nop
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  nop
                  sll          s6, gp, a5
                  nop
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  nop
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  nop
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  nop
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  nop
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  nop
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  nop
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  nop
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  nop
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  lui          t5, 142675
                  or           s7, t3, s11
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  nop
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  and          t6, a6, t6
                  nop
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  lui          t5, 142675
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  nop
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  nop
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  nop
                  sll          s6, gp, a5
                  nop
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  nop
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  nop
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  lui          t5, 142675
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  lui          t5, 142675
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  nop
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_31
                  li           a2, 0xffffffff
                  li           t5, 0xffffffff
                  li           s0, 0x80000000
                  li           s2, 0xffffffff
                  li           s4, 0x0
                  li           s6, 0x0
                  li           sp, 0x80000000
                  li           a5, 0x9772d1f6
                  li           s8, 0xffffffff
                  sub          s2, s0, s0
                  auipc        t5, 883493
                  lui          t5, 142675
                  addi         t5, s4, 1891
                  auipc        t5, 883493
                  lui          t5, 142675
                  addi         t5, s4, 1891
                  nop
                  add          t5, s6, t5
                  lui          t5, 142675
                  sub          s2, s0, s0
                  sub          s2, s0, s0
                  nop
                  addi         t5, s4, 1891
                  addi         t5, s4, 1891
                  addi         t5, s4, 1891
                  auipc        t5, 883493
                  addi         t5, s4, 1891
                  sub          s2, s0, s0
                  add          t5, s6, t5
                  lui          t5, 142675
                  lui          t5, 142675
                  add          t5, s6, t5
                  addi         t5, s4, 1891
                  addi         t5, s4, 1891 #end riscv_int_numeric_corner_stream_31
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  nop
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  nop
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  nop
                  srli         zero, s5, 28
                  nop
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  nop
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  nop
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  lui          t5, 142675
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  nop
                  nop
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  lui          t5, 142675
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  add          t6, t1, a5
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  nop
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  nop
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  lui          t5, 142675
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  lui          t5, 142675
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  nop
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  nop
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  nop
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  nop
                  srli         zero, s5, 28
                  nop
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  nop
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  or           s7, t3, s11
                  and          t6, a6, t6
                  and          t6, a6, t6
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  nop
                  slt          a6, s5, zero
                  nop
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  nop
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  nop
                  nop
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  lui          t5, 142675
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  nop
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  lui          t5, 142675
                  lui          t5, 142675
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  nop
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  nop
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  lui          t5, 142675
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  nop
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  nop
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  nop
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  nop
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  add          t6, t1, a5
                  nop
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  nop
                  nop
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  nop
                  sll          s6, gp, a5
                  nop
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  nop
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  or           s7, t3, s11
                  add          t6, t1, a5
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_12
                  li           a4, 0xdb193ac5
                  li           t4, 0x80000000
                  li           a7, 0xe2edaad4
                  li           tp, 0x7109dd51
                  li           s8, 0xffffffff
                  li           s1, 0xffffffff
                  li           t2, 0xffffffff
                  li           ra, 0xd62f3c47
                  li           s4, 0xffffffff
                  addi         a4, s4, 1891
                  add          a4, a4, a4
                  auipc        t4, 883493
                  auipc        t4, 883493
                  lui          t4, 142675
                  lui          t4, 142675
                  sub          s8, s1, ra
                  nop
                  add          a4, a4, a4
                  addi         a4, s4, 1891
                  lui          t4, 142675
                  nop
                  auipc        t4, 883493
                  nop
                  addi         a4, s4, 1891
                  nop
                  addi         a4, s4, 1891
                  add          a4, a4, a4
                  addi         a4, s4, 1891
                  lui          t4, 142675
                  nop
                  addi         a4, s4, 1891
                  auipc        t4, 883493 #end riscv_int_numeric_corner_stream_12
                  nop
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  lui          t5, 142675
                  nop
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  and          t6, a6, t6
                  or           s7, t3, s11
                  nop
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  lui          t5, 142675
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  nop
                  auipc        s7, 883493
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  nop
                  slt          a6, s5, zero
                  nop
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  lui          t5, 142675
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  nop
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  lui          t5, 142675
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  nop
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  nop
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  nop
                  add          t6, t1, a5
                  or           s7, t3, s11
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  and          t6, a6, t6
                  lui          t5, 142675
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  nop
                  nop
                  lui          t5, 142675
                  lui          t5, 142675
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  lui          t5, 142675
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  nop
                  lui          t5, 142675
                  lui          t5, 142675
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  nop
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  lui          t5, 142675
                  xor          a5, t5, a4
                  lui          t5, 142675
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  nop
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  nop
                  lui          t5, 142675
                  sra          t3, t3, s11
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_37
                  li           gp, 0x6e405c3a
                  li           s3, 0x8ee2400c
                  li           t5, 0xffffffff
                  li           a6, 0x80000000
                  li           s7, 0x5ba32512
                  li           s1, 0x26176cf6
                  li           s10, 0x8920ec32
                  li           sp, 0x80000000
                  li           t6, 0xeff01c64
                  auipc        t6, 883493
                  nop
                  auipc        t6, 883493
                  lui          t5, 142675
                  addi         t5, t5, 1891
                  add          t6, s10, t5
                  auipc        t6, 883493
                  addi         t5, t5, 1891
                  lui          t5, 142675
                  add          t6, s10, t5
                  addi         t5, t5, 1891
                  sub          s10, s3, sp
                  addi         t5, t5, 1891
                  sub          s10, s3, sp
                  nop
                  nop
                  lui          t5, 142675 #end riscv_int_numeric_corner_stream_37
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  lui          t5, 142675
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  lui          t5, 142675
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  nop
                  or           s7, t3, s11
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  nop
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  lui          t5, 142675
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  nop
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  nop
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  lui          t5, 142675
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  nop
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  nop
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  nop
                  add          t6, t1, a5
                  nop
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  nop
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  nop
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  nop
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  auipc        s7, 883493
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  lui          t5, 142675
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  nop
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  nop
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  nop
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  lui          t5, 142675
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  lui          t5, 142675
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  lui          t5, 142675
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  nop
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  nop
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  or           s7, t3, s11
                  nop
                  nop
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  nop
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  nop
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  nop
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  nop
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  nop
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  lui          t5, 142675
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  auipc        s7, 883493
                  li           gp, 0x80000000 #start riscv_int_numeric_corner_stream_7
                  li           s4, 0x584c9005
                  li           t5, 0x2907fc61
                  li           a7, 0xffffffff
                  li           a4, 0x0
                  li           s3, 0xffffffff
                  li           s0, 0x9cd6f3f9
                  li           t6, 0x13fdf4f
                  li           ra, 0x10d77444
                  li           t3, 0x9324abf4
                  auipc        t5, 883493
                  auipc        t5, 883493
                  add          ra, a4, t5
                  auipc        t5, 883493
                  nop
                  sub          t5, s0, s0
                  lui          t5, 142675
                  sub          t5, s0, s0
                  nop
                  sub          t5, s0, s0
                  add          ra, a4, t5
                  lui          t5, 142675
                  addi         t5, t3, 1891
                  lui          t5, 142675
                  sub          t5, s0, s0
                  addi         t5, t3, 1891
                  auipc        t5, 883493
                  add          ra, a4, t5
                  sub          t5, s0, s0
                  add          ra, a4, t5
                  auipc        t5, 883493
                  nop #end riscv_int_numeric_corner_stream_7
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  nop
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  nop
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  li           s7, 0x80000000 #start riscv_int_numeric_corner_stream_39
                  li           s11, 0xffffffff
                  li           a4, 0x80000000
                  li           s10, 0x80000000
                  li           t0, 0x0
                  li           s3, 0xffffffff
                  li           t1, 0x80000000
                  li           sp, 0x9d11d265
                  li           t6, 0xffffffff
                  li           t4, 0x0
                  lui          s7, 142675
                  nop
                  nop
                  addi         a4, a4, 1891
                  addi         a4, a4, 1891
                  lui          s7, 142675
                  sub          s11, s3, sp
                  addi         a4, a4, 1891
                  addi         a4, a4, 1891
                  lui          s7, 142675
                  sub          s11, s3, sp
                  lui          s7, 142675
                  auipc        t4, 883493
                  auipc        t4, 883493
                  lui          s7, 142675
                  add          t6, a4, s11
                  auipc        t4, 883493
                  addi         a4, a4, 1891
                  add          t6, a4, s11
                  nop
                  nop
                  addi         a4, a4, 1891
                  addi         a4, a4, 1891
                  sub          s11, s3, sp
                  addi         a4, a4, 1891
                  addi         a4, a4, 1891
                  add          t6, a4, s11
                  sub          s11, s3, sp
                  auipc        t4, 883493 #end riscv_int_numeric_corner_stream_39
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  nop
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  lui          t5, 142675
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  lui          t5, 142675
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  add          t6, t1, a5
                  auipc        s7, 883493
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  lui          t5, 142675
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  nop
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  lui          t5, 142675
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  nop
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  srai         s1, t1, 10
                  lui          t5, 142675
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  nop
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  nop
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  nop
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  nop
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  nop
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  add          t6, t1, a5
                  nop
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  nop
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  lui          t5, 142675
                  lui          t5, 142675
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  nop
                  auipc        s7, 883493
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  li           t6, 0x0 #start riscv_int_numeric_corner_stream_32
                  li           s0, 0xffffffff
                  li           a5, 0xa2c991f2
                  li           gp, 0x80000000
                  li           s6, 0x0
                  li           t0, 0x80000000
                  li           s11, 0xffffffff
                  li           s1, 0x80000000
                  li           a7, 0x0
                  li           s3, 0xffffffff
                  sub          s11, s0, s0
                  lui          s6, 142675
                  sub          s11, s0, s0
                  sub          s11, s0, s0
                  auipc        t6, 883493
                  add          s6, s0, a5
                  sub          s11, s0, s0
                  lui          s6, 142675
                  nop
                  add          s6, s0, a5
                  nop
                  add          s6, s0, a5
                  auipc        t6, 883493
                  add          s6, s0, a5
                  auipc        t6, 883493
                  lui          s6, 142675
                  add          s6, s0, a5
                  sub          s11, s0, s0
                  lui          s6, 142675
                  lui          s6, 142675
                  nop #end riscv_int_numeric_corner_stream_32
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  lui          t5, 142675
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  add          t6, t1, a5
                  nop
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  lui          t5, 142675
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  lui          t5, 142675
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  lui          t5, 142675
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  nop
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  lui          t5, 142675
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  lui          t5, 142675
                  sll          s6, gp, a5
                  lui          t5, 142675
                  srli         zero, s5, 28
                  nop
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  nop
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  nop
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  lui          t5, 142675
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  nop
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  lui          t5, 142675
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  nop
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  lui          t5, 142675
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  nop
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  nop
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  nop
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  nop
                  add          t6, t1, a5
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  nop
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  lui          t5, 142675
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  lui          t5, 142675
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  nop
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  nop
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  nop
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  nop
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  nop
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  nop
                  ori          t0, t5, -208
                  lui          t5, 142675
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  nop
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  lui          t5, 142675
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  nop
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  nop
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  lui          t5, 142675
                  lui          t5, 142675
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  and          t6, a6, t6
                  lui          t5, 142675
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  nop
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  lui          t5, 142675
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  nop
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  nop
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  nop
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  lui          t5, 142675
                  slli         ra, gp, 5
                  lui          t5, 142675
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  lui          t5, 142675
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  nop
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  lui          t5, 142675
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  add          t6, t1, a5
                  nop
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  lui          t5, 142675
                  and          t6, a6, t6
                  nop
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  nop
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  nop
                  nop
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  lui          t5, 142675
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  nop
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  nop
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  nop
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  nop
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  or           s7, t3, s11
                  nop
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  auipc        s7, 883493
                  auipc        s7, 883493
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  nop
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  lui          t5, 142675
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  nop
                  and          t6, a6, t6
                  lui          t5, 142675
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  nop
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  nop
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  nop
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  nop
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  nop
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  nop
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  lui          t5, 142675
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  lui          t5, 142675
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  lui          t5, 142675
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  and          t6, a6, t6
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  lui          t5, 142675
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  lui          t5, 142675
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  add          t6, t1, a5
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  lui          t5, 142675
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_23
                  li           t4, 0x80000000
                  li           t1, 0x0
                  li           a0, 0xffffffff
                  li           a6, 0xffffffff
                  li           t0, 0xffffffff
                  li           s7, 0x80000000
                  li           s8, 0x80000000
                  li           t6, 0xffffffff
                  li           t2, 0xf4e4833c
                  add          t6, a0, a5
                  addi         s8, t1, 1891
                  addi         s8, t1, 1891
                  add          t6, a0, a5
                  sub          s8, a6, a0
                  auipc        t4, 883493
                  lui          t6, 142675
                  lui          t6, 142675
                  nop
                  auipc        t4, 883493
                  sub          s8, a6, a0
                  addi         s8, t1, 1891
                  addi         s8, t1, 1891
                  auipc        t4, 883493
                  sub          s8, a6, a0
                  lui          t6, 142675
                  auipc        t4, 883493
                  auipc        t4, 883493
                  lui          t6, 142675
                  addi         s8, t1, 1891
                  sub          s8, a6, a0
                  nop
                  addi         s8, t1, 1891
                  addi         s8, t1, 1891 #end riscv_int_numeric_corner_stream_23
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  nop
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  lui          t5, 142675
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  nop
                  auipc        s7, 883493
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  nop
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  nop
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  lui          t5, 142675
                  and          t6, a6, t6
                  nop
                  srai         s1, t1, 10
                  nop
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  lui          t5, 142675
                  lui          t5, 142675
                  slli         ra, gp, 5
                  lui          t5, 142675
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  nop
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  nop
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  lui          t5, 142675
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  nop
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  nop
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  auipc        s7, 883493
                  or           s7, t3, s11
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  lui          t5, 142675
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  auipc        s7, 883493
                  lui          t5, 142675
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  nop
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  ori          t0, t5, -208
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  nop
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  nop
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  nop
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  nop
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  lui          t5, 142675
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  nop
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  nop
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  nop
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  nop
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  nop
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  lui          t5, 142675
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  nop
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  lui          t5, 142675
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  nop
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  nop
                  nop
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  lui          t5, 142675
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  lui          t5, 142675
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sra          t3, t3, s11
                  lui          t5, 142675
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  auipc        s7, 883493
                  lui          t5, 142675
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  nop
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  nop
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  lui          t5, 142675
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  add          t6, t1, a5
                  nop
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  nop
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  lui          t5, 142675
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  or           s7, t3, s11
                  lui          t5, 142675
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  lui          t5, 142675
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  lui          t5, 142675
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  nop
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  add          t6, t1, a5
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  nop
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  and          t6, a6, t6
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  nop
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  nop
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  nop
                  nop
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  nop
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  lui          t5, 142675
                  nop
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  add          t6, t1, a5
                  nop
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  nop
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  nop
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  nop
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  nop
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  lui          t5, 142675
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  lui          t5, 142675
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  nop
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  nop
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  and          t6, a6, t6
                  or           s7, t3, s11
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  nop
                  add          t6, t1, a5
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  nop
                  sll          s6, gp, a5
                  lui          t5, 142675
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  lui          t5, 142675
                  and          t6, a6, t6
                  auipc        s7, 883493
                  and          t6, a6, t6
                  nop
                  sltu         s11, t6, s7
                  nop
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  nop
                  add          t6, t1, a5
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  nop
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  nop
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  nop
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  lui          t5, 142675
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  li           s0, 0x6b02224d #start riscv_int_numeric_corner_stream_28
                  li           s3, 0xe730e172
                  li           s8, 0x6c70ffe2
                  li           a5, 0x0
                  li           s2, 0x80000000
                  li           t3, 0x16c51bf1
                  li           t4, 0x0
                  li           s10, 0x94d43ff8
                  li           s11, 0xffffffff
                  li           tp, 0x0
                  auipc        t4, 883493
                  sub          s11, s2, s0
                  sub          s11, s2, s0
                  lui          s10, 142675
                  add          t4, s0, a5
                  lui          s10, 142675
                  lui          s10, 142675
                  add          t4, s0, a5
                  sub          s11, s2, s0
                  lui          s10, 142675
                  auipc        t4, 883493
                  auipc        t4, 883493
                  add          t4, s0, a5
                  add          t4, s0, a5
                  lui          s10, 142675
                  auipc        t4, 883493
                  sub          s11, s2, s0
                  sub          s11, s2, s0
                  add          t4, s0, a5
                  add          t4, s0, a5
                  sub          s11, s2, s0
                  sub          s11, s2, s0
                  sub          s11, s2, s0
                  sub          s11, s2, s0
                  lui          s10, 142675
                  lui          s10, 142675
                  addi         t3, t3, 1891
                  sub          s11, s2, s0 #end riscv_int_numeric_corner_stream_28
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  nop
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  nop
                  lui          t5, 142675
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  nop
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  nop
                  andi         sp, a5, -1334
                  nop
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  nop
                  xor          a5, t5, a4
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  nop
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  nop
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  nop
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  lui          t5, 142675
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  nop
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  nop
                  nop
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  nop
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  nop
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  nop
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  nop
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  nop
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  nop
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  nop
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  lui          t5, 142675
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  nop
                  sll          s6, gp, a5
                  lui          t5, 142675
                  lui          t5, 142675
                  nop
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  nop
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  nop
                  auipc        s7, 883493
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  nop
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  nop
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  nop
                  nop
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  nop
                  auipc        s7, 883493
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  nop
                  and          t6, a6, t6
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  nop
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  lui          t5, 142675
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  lui          t5, 142675
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  nop
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  add          t6, t1, a5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  nop
                  nop
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  nop
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  srai         s1, t1, 10
                  lui          t5, 142675
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  li           s4, 0xffffffff #start riscv_int_numeric_corner_stream_14
                  li           t4, 0x0
                  li           tp, 0x0
                  li           a5, 0x0
                  li           s2, 0xffffffff
                  li           t6, 0xffffffff
                  li           sp, 0xffffffff
                  li           a7, 0xfef102b
                  li           t0, 0x80000000
                  li           t1, 0x0
                  auipc        t6, 883493
                  nop
                  addi         s4, t1, 1891
                  lui          t6, 142675
                  add          t1, s2, t6
                  addi         s4, t1, 1891
                  lui          t6, 142675
                  nop
                  addi         s4, t1, 1891
                  auipc        t6, 883493
                  addi         s4, t1, 1891
                  nop
                  lui          t6, 142675
                  add          t1, s2, t6
                  lui          t6, 142675
                  addi         s4, t1, 1891
                  auipc        t6, 883493
                  nop
                  addi         s4, t1, 1891
                  lui          t6, 142675
                  nop
                  sub          s2, a7, sp
                  add          t1, s2, t6
                  sub          s2, a7, sp
                  addi         s4, t1, 1891
                  sub          s2, a7, sp
                  nop #end riscv_int_numeric_corner_stream_14
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  nop
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  auipc        s7, 883493
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  lui          t5, 142675
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  nop
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  lui          t5, 142675
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  lui          t5, 142675
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  nop
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  nop
                  slli         ra, gp, 5
                  nop
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  lui          t5, 142675
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  or           s7, t3, s11
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  nop
                  lui          t5, 142675
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  lui          t5, 142675
                  nop
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  lui          t5, 142675
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  nop
                  or           s7, t3, s11
                  add          t6, t1, a5
                  nop
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  lui          t5, 142675
                  lui          t5, 142675
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  lui          t5, 142675
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  add          t6, t1, a5
                  add          t6, t1, a5
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  lui          t5, 142675
                  nop
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  nop
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  add          t6, t1, a5
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  nop
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  nop
                  lui          t5, 142675
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  nop
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  nop
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  nop
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  nop
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  nop
                  slt          a6, s5, zero
                  and          t6, a6, t6
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  slli         ra, gp, 5
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  nop
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  lui          t5, 142675
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  nop
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  lui          t5, 142675
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  nop
                  add          t6, t1, a5
                  lui          t5, 142675
                  nop
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  nop
                  sub          ra, s9, zero
                  nop
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  nop
                  nop
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  or           s7, t3, s11
                  nop
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  srai         s1, t1, 10
                  lui          t5, 142675
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  slt          a6, s5, zero
                  nop
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  sltiu        zero, zero, 1250
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  or           s7, t3, s11
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  lui          t5, 142675
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  add          t6, t1, a5
                  nop
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  li           s2, 0xffffffff #start riscv_int_numeric_corner_stream_8
                  li           t1, 0xffffffff
                  li           a4, 0x80000000
                  li           a5, 0x80000000
                  li           s10, 0x80000000
                  li           s0, 0xffffffff
                  li           s5, 0x0
                  li           a2, 0x80000000
                  li           gp, 0x80000000
                  li           s8, 0x0
                  nop
                  add          s10, s2, a5
                  auipc        s5, 883493
                  addi         a4, t1, 1891
                  auipc        s5, 883493
                  sub          a5, s10, s0
                  nop
                  sub          a5, s10, s0
                  lui          s10, 142675
                  addi         a4, t1, 1891
                  sub          a5, s10, s0
                  auipc        s5, 883493
                  lui          s10, 142675
                  lui          s10, 142675
                  lui          s10, 142675 #end riscv_int_numeric_corner_stream_8
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  or           s7, t3, s11
                  lui          t5, 142675
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  andi         sp, a5, -1334
                  or           s7, t3, s11
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  nop
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  nop
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  nop
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  nop
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  lui          t5, 142675
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  auipc        s7, 883493
                  lui          t5, 142675
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  nop
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  nop
                  sll          s6, gp, a5
                  lui          t5, 142675
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  nop
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  lui          t5, 142675
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  or           s7, t3, s11
                  nop
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  nop
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  lui          t5, 142675
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  or           s7, t3, s11
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  lui          t5, 142675
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  lui          t5, 142675
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  srl          t0, a4, tp
                  sltu         s11, t6, s7
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  lui          t5, 142675
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  lui          t5, 142675
                  slli         ra, gp, 5
                  sll          s6, gp, a5
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  addi         a5, s4, 1891
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  nop
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  xori         tp, s7, -1074
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  nop
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  srl          t0, a4, tp
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  xor          a5, t5, a4
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  nop
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  nop
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  lui          t5, 142675
                  auipc        s7, 883493
                  slti         t0, a3, 1843
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  lui          t5, 142675
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  slt          a6, s5, zero
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  sub          ra, s9, zero
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  lui          t5, 142675
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  lui          t5, 142675
                  slli         ra, gp, 5
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  nop
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  sltu         s11, t6, s7
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  and          t6, a6, t6
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  nop
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  sra          t3, t3, s11
                  nop
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  srli         zero, s5, 28
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  slt          a6, s5, zero
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  lui          t5, 142675
                  nop
                  lui          t5, 142675
                  lui          t5, 142675
                  auipc        s7, 883493
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  sltiu        zero, zero, 1250
                  add          t6, t1, a5
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  nop
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  add          t6, t1, a5
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  xori         tp, s7, -1074
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  and          t6, a6, t6
                  sltiu        zero, zero, 1250
                  sub          ra, s9, zero
                  srai         s1, t1, 10
                  lui          t5, 142675
                  sltu         s11, t6, s7
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  and          t6, a6, t6
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  sll          s6, gp, a5
                  slli         ra, gp, 5
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_27
                  li           t6, 0xffffffff
                  li           s0, 0x80000000
                  li           s4, 0x0
                  li           sp, 0x80000000
                  li           s2, 0x0
                  li           t3, 0x80000000
                  li           s10, 0xd15a0c7f
                  li           s5, 0x0
                  li           s1, 0x67f3d7ea
                  addi         t5, s4, 1891
                  add          t6, s0, t5
                  lui          t5, 142675
                  auipc        t6, 883493
                  lui          t5, 142675
                  sub          s2, s10, s0
                  auipc        t6, 883493
                  nop
                  sub          s2, s10, s0
                  lui          t5, 142675
                  add          t6, s0, t5
                  addi         t5, s4, 1891
                  add          t6, s0, t5
                  sub          s2, s10, s0
                  auipc        t6, 883493
                  add          t6, s0, t5
                  add          t6, s0, t5
                  nop
                  nop
                  sub          s2, s10, s0
                  lui          t5, 142675
                  auipc        t6, 883493
                  nop
                  addi         t5, s4, 1891
                  lui          t5, 142675
                  sub          s2, s10, s0
                  nop
                  nop #end riscv_int_numeric_corner_stream_27
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  lui          t5, 142675
                  xor          a5, t5, a4
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  nop
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sll          s6, gp, a5
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  auipc        s7, 883493
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  nop
                  sll          s6, gp, a5
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  addi         a5, s4, 1891
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  nop
                  ori          t0, t5, -208
                  nop
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  addi         a5, s4, 1891
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  nop
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  nop
                  lui          t5, 142675
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  auipc        s7, 883493
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  auipc        s7, 883493
                  nop
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  srl          t0, a4, tp
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  and          t6, a6, t6
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  lui          t5, 142675
                  srl          t0, a4, tp
                  slti         t0, a3, 1843
                  add          t6, t1, a5
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  sub          ra, s9, zero
                  lui          t5, 142675
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  li           tp, 0x0 #start riscv_int_numeric_corner_stream_15
                  li           sp, 0x0
                  li           a2, 0xffffffff
                  li           s5, 0xffffffff
                  li           a4, 0xffffffff
                  li           t0, 0x0
                  li           gp, 0x80000000
                  li           a7, 0x61aefa75
                  li           s7, 0x0
                  li           s11, 0xffffffff
                  add          a4, s7, s11
                  sub          s5, sp, sp
                  nop
                  lui          s11, 142675
                  auipc        s7, 883493
                  addi         a2, sp, 1891
                  nop
                  sub          s5, sp, sp
                  nop
                  add          a4, s7, s11
                  nop
                  sub          s5, sp, sp
                  lui          s11, 142675
                  nop
                  nop
                  add          a4, s7, s11
                  auipc        s7, 883493
                  lui          s11, 142675
                  add          a4, s7, s11
                  nop
                  auipc        s7, 883493
                  nop
                  nop #end riscv_int_numeric_corner_stream_15
                  lui          t5, 142675
                  sll          s6, gp, a5
                  slt          a6, s5, zero
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  nop
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  nop
                  nop
                  slti         t0, a3, 1843
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  sub          ra, s9, zero
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  or           s7, t3, s11
                  ori          t0, t5, -208
                  and          t6, a6, t6
                  srai         s1, t1, 10
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sll          s6, gp, a5
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  sub          ra, s9, zero
                  sltu         s11, t6, s7
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_24
                  li           s8, 0x0
                  li           t4, 0x80000000
                  li           ra, 0x80000000
                  li           gp, 0x80000000
                  li           tp, 0x0
                  li           t2, 0x0
                  li           t5, 0x0
                  li           s6, 0xffffffff
                  li           s4, 0x0
                  sub          s8, s4, tp
                  nop
                  nop
                  addi         t4, s4, 1891
                  lui          t5, 142675
                  nop
                  nop
                  nop
                  nop
                  addi         t4, s4, 1891
                  nop
                  nop
                  auipc        s6, 883493
                  nop
                  sub          s8, s4, tp
                  addi         t4, s4, 1891 #end riscv_int_numeric_corner_stream_24
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  auipc        s7, 883493
                  nop
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  nop
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  slt          a6, s5, zero
                  addi         a5, s4, 1891
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  add          t6, t1, a5
                  nop
                  xor          a5, t5, a4
                  ori          t0, t5, -208
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  nop
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  slt          a6, s5, zero
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  srai         s1, t1, 10
                  slti         t0, a3, 1843
                  srli         zero, s5, 28
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  xori         tp, s7, -1074
                  nop
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  nop
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  sll          s6, gp, a5
                  srai         s1, t1, 10
                  sra          t3, t3, s11
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  addi         a5, s4, 1891
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  andi         sp, a5, -1334
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  srl          t0, a4, tp
                  srl          t0, a4, tp
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  and          t6, a6, t6
                  srl          t0, a4, tp
                  sltiu        zero, zero, 1250
                  xor          a5, t5, a4
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  or           s7, t3, s11
                  sltiu        zero, zero, 1250
                  auipc        s7, 883493
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  slt          a6, s5, zero
                  slti         t0, a3, 1843
                  slt          a6, s5, zero
                  nop
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  addi         a5, s4, 1891
                  lui          t5, 142675
                  nop
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  andi         sp, a5, -1334
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  andi         sp, a5, -1334
                  slt          a6, s5, zero
                  lui          t5, 142675
                  or           s7, t3, s11
                  sltu         s11, t6, s7
                  xori         tp, s7, -1074
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  slli         ra, gp, 5
                  nop
                  add          t6, t1, a5
                  xor          a5, t5, a4
                  add          t6, t1, a5
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  srai         s1, t1, 10
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sra          t3, t3, s11
                  xori         tp, s7, -1074
                  sra          t3, t3, s11
                  ori          t0, t5, -208
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  sltiu        zero, zero, 1250
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  or           s7, t3, s11
                  sub          ra, s9, zero
                  and          t6, a6, t6
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  xor          a5, t5, a4
                  nop
                  ori          t0, t5, -208
                  xor          a5, t5, a4
                  srli         zero, s5, 28
                  xor          a5, t5, a4
                  srl          t0, a4, tp
                  slt          a6, s5, zero
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  slt          a6, s5, zero
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  sra          t3, t3, s11
                  sltiu        zero, zero, 1250
                  sltiu        zero, zero, 1250
                  nop
                  sub          ra, s9, zero
                  lui          t5, 142675
                  add          t6, t1, a5
                  srl          t0, a4, tp
                  or           s7, t3, s11
                  xor          a5, t5, a4
                  auipc        s7, 883493
                  srai         s1, t1, 10
                  ori          t0, t5, -208
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  srai         s1, t1, 10
                  srli         zero, s5, 28
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  sltu         s11, t6, s7
                  xor          a5, t5, a4
                  and          t6, a6, t6
                  sub          ra, s9, zero
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  xori         tp, s7, -1074
                  nop
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  or           s7, t3, s11
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  addi         a5, s4, 1891
                  xor          a5, t5, a4
                  srai         s1, t1, 10
                  sltu         s11, t6, s7
                  sra          t3, t3, s11
                  srai         s1, t1, 10
                  xori         tp, s7, -1074
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  ori          t0, t5, -208
                  nop
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  add          t6, t1, a5
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  srl          t0, a4, tp
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  addi         a5, s4, 1891
                  nop
                  srli         zero, s5, 28
                  lui          t5, 142675
                  sub          ra, s9, zero
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  slli         ra, gp, 5
                  nop
                  nop
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  sub          ra, s9, zero
                  add          t6, t1, a5
                  slt          a6, s5, zero
                  sll          s6, gp, a5
                  sll          s6, gp, a5
                  slti         t0, a3, 1843
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  srl          t0, a4, tp
                  add          t6, t1, a5
                  ori          t0, t5, -208
                  xori         tp, s7, -1074
                  xor          a5, t5, a4
                  lui          t5, 142675
                  slli         ra, gp, 5
                  andi         sp, a5, -1334
                  slli         ra, gp, 5
                  xor          a5, t5, a4
                  lui          t5, 142675
                  srai         s1, t1, 10
                  sll          s6, gp, a5
                  srli         zero, s5, 28
                  srai         s1, t1, 10
                  auipc        s7, 883493
                  and          t6, a6, t6
                  nop
                  sltiu        zero, zero, 1250
                  srli         zero, s5, 28
                  and          t6, a6, t6
                  slli         ra, gp, 5
                  add          t6, t1, a5
                  xori         tp, s7, -1074
                  slti         t0, a3, 1843
                  or           s7, t3, s11
                  slli         ra, gp, 5
                  slli         ra, gp, 5
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  srai         s1, t1, 10
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  add          t6, t1, a5
                  sltu         s11, t6, s7
                  andi         sp, a5, -1334
                  sltiu        zero, zero, 1250
                  sra          t3, t3, s11
                  slti         t0, a3, 1843
                  sltu         s11, t6, s7
                  sub          ra, s9, zero
                  xor          a5, t5, a4
                  andi         sp, a5, -1334
                  lui          t5, 142675
                  sltiu        zero, zero, 1250
                  slti         t0, a3, 1843
                  ori          t0, t5, -208
                  slti         t0, a3, 1843
                  addi         a5, s4, 1891
                  ori          t0, t5, -208
                  or           s7, t3, s11
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  andi         sp, a5, -1334
                  and          t6, a6, t6
                  add          t6, t1, a5
                  slli         ra, gp, 5
                  sltiu        zero, zero, 1250
                  nop
                  sub          ra, s9, zero
                  slli         ra, gp, 5
                  addi         a5, s4, 1891
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  srli         zero, s5, 28
                  sltu         s11, t6, s7
                  add          t6, t1, a5
                  and          t6, a6, t6
                  slti         t0, a3, 1843
                  nop
                  sltu         s11, t6, s7
                  srai         s1, t1, 10
                  slt          a6, s5, zero
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  ori          t0, t5, -208
                  sll          s6, gp, a5
                  xori         tp, s7, -1074
                  lui          t5, 142675
                  srli         zero, s5, 28
                  ori          t0, t5, -208
                  andi         sp, a5, -1334
                  sub          ra, s9, zero
                  slti         t0, a3, 1843
                  srl          t0, a4, tp
                  addi         a5, s4, 1891
                  slti         t0, a3, 1843
                  xori         tp, s7, -1074
                  and          t6, a6, t6
                  slt          a6, s5, zero
                  slt          a6, s5, zero
                  auipc        s7, 883493
                  lui          t5, 142675
                  auipc        s7, 883493
                  srli         zero, s5, 28
                  slli         ra, gp, 5
                  srli         zero, s5, 28
                  xori         tp, s7, -1074
                  srli         zero, s5, 28
                  sll          s6, gp, a5
                  and          t6, a6, t6
                  andi         sp, a5, -1334
                  xori         tp, s7, -1074
                  auipc        s7, 883493
                  sra          t3, t3, s11
                  auipc        s7, 883493
                  xori         tp, s7, -1074
                  sub          ra, s9, zero
                  srl          t0, a4, tp
                  auipc        s7, 883493
                  sltu         s11, t6, s7
                  lui          t5, 142675
                  add          t6, t1, a5
                  la x25, test_done
                  jalr x0, x25, 0
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
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_2:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_3:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_4:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_5:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_6:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_7:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_8:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_9:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_10:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_11:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_12:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_13:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_14:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

mmode_intr_vector_15:
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x342 # MCAUSE
                  srli x29, x29, 0x1f
                  beqz x29, 1f
                  j mmode_intr_handler
                  1: la x25, test_done
                  jalr x0, x25, 0

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
                  addi x13, x13, -4
                  sw  x11, (x13)
                  add x11, x13, zero
                  addi x11, x11, -128
                  sw  x1, 4(x11)
                  sw  x2, 8(x11)
                  sw  x3, 12(x11)
                  sw  x4, 16(x11)
                  sw  x5, 20(x11)
                  sw  x6, 24(x11)
                  sw  x7, 28(x11)
                  sw  x8, 32(x11)
                  sw  x9, 36(x11)
                  sw  x10, 40(x11)
                  sw  x11, 44(x11)
                  sw  x12, 48(x11)
                  sw  x13, 52(x11)
                  sw  x14, 56(x11)
                  sw  x15, 60(x11)
                  sw  x16, 64(x11)
                  sw  x17, 68(x11)
                  sw  x18, 72(x11)
                  sw  x19, 76(x11)
                  sw  x20, 80(x11)
                  sw  x21, 84(x11)
                  sw  x22, 88(x11)
                  sw  x23, 92(x11)
                  sw  x24, 96(x11)
                  sw  x25, 100(x11)
                  sw  x26, 104(x11)
                  sw  x27, 108(x11)
                  sw  x28, 112(x11)
                  sw  x29, 116(x11)
                  sw  x30, 120(x11)
                  sw  x31, 124(x11)
                  add x13, x11, zero
                  csrr x29, 0x341 # MEPC
                  csrr x29, 0x342 # MCAUSE
                  li x21, 0x3 # BREAKPOINT
                  beq x29, x21, ebreak_handler
                  li x21, 0x8 # ECALL_UMODE
                  beq x29, x21, ecall_handler
                  li x21, 0x9 # ECALL_SMODE
                  beq x29, x21, ecall_handler
                  li x21, 0xb # ECALL_MMODE
                  beq x29, x21, ecall_handler
                  li x21, 0x1
                  beq x29, x21, instr_fault_handler
                  li x21, 0x5
                  beq x29, x21, load_fault_handler
                  li x21, 0x7
                  beq x29, x21, store_fault_handler
                  li x21, 0xc
                  beq x29, x21, pt_fault_handler
                  li x21, 0xd
                  beq x29, x21, pt_fault_handler
                  li x21, 0xf
                  beq x29, x21, pt_fault_handler
                  li x21, 0x2 # ILLEGAL_INSTRUCTION
                  beq x29, x21, illegal_instr_handler
                  csrr x21, 0x343 # MTVAL
                  1: la x25, test_done
                  jalr x1, x25, 0

ecall_handler:    
                  la x29, _start
                  sw x0, 0(x29)
                  sw x1, 4(x29)
                  sw x2, 8(x29)
                  sw x3, 12(x29)
                  sw x4, 16(x29)
                  sw x5, 20(x29)
                  sw x6, 24(x29)
                  sw x7, 28(x29)
                  sw x8, 32(x29)
                  sw x9, 36(x29)
                  sw x10, 40(x29)
                  sw x11, 44(x29)
                  sw x12, 48(x29)
                  sw x13, 52(x29)
                  sw x14, 56(x29)
                  sw x15, 60(x29)
                  sw x16, 64(x29)
                  sw x17, 68(x29)
                  sw x18, 72(x29)
                  sw x19, 76(x29)
                  sw x20, 80(x29)
                  sw x21, 84(x29)
                  sw x22, 88(x29)
                  sw x23, 92(x29)
                  sw x24, 96(x29)
                  sw x25, 100(x29)
                  sw x26, 104(x29)
                  sw x27, 108(x29)
                  sw x28, 112(x29)
                  sw x29, 116(x29)
                  sw x30, 120(x29)
                  sw x31, 124(x29)
                  la x25, write_tohost
                  jalr x0, x25, 0

instr_fault_handler:
                  add x11, x13, zero
                  lw  x1, 4(x11)
                  lw  x2, 8(x11)
                  lw  x3, 12(x11)
                  lw  x4, 16(x11)
                  lw  x5, 20(x11)
                  lw  x6, 24(x11)
                  lw  x7, 28(x11)
                  lw  x8, 32(x11)
                  lw  x9, 36(x11)
                  lw  x10, 40(x11)
                  lw  x11, 44(x11)
                  lw  x12, 48(x11)
                  lw  x13, 52(x11)
                  lw  x14, 56(x11)
                  lw  x15, 60(x11)
                  lw  x16, 64(x11)
                  lw  x17, 68(x11)
                  lw  x18, 72(x11)
                  lw  x19, 76(x11)
                  lw  x20, 80(x11)
                  lw  x21, 84(x11)
                  lw  x22, 88(x11)
                  lw  x23, 92(x11)
                  lw  x24, 96(x11)
                  lw  x25, 100(x11)
                  lw  x26, 104(x11)
                  lw  x27, 108(x11)
                  lw  x28, 112(x11)
                  lw  x29, 116(x11)
                  lw  x30, 120(x11)
                  lw  x31, 124(x11)
                  addi x11, x11, 128
                  add x13, x11, zero
                  lw  x11, (x13)
                  addi x13, x13, 4
                  mret

load_fault_handler:
                  add x11, x13, zero
                  lw  x1, 4(x11)
                  lw  x2, 8(x11)
                  lw  x3, 12(x11)
                  lw  x4, 16(x11)
                  lw  x5, 20(x11)
                  lw  x6, 24(x11)
                  lw  x7, 28(x11)
                  lw  x8, 32(x11)
                  lw  x9, 36(x11)
                  lw  x10, 40(x11)
                  lw  x11, 44(x11)
                  lw  x12, 48(x11)
                  lw  x13, 52(x11)
                  lw  x14, 56(x11)
                  lw  x15, 60(x11)
                  lw  x16, 64(x11)
                  lw  x17, 68(x11)
                  lw  x18, 72(x11)
                  lw  x19, 76(x11)
                  lw  x20, 80(x11)
                  lw  x21, 84(x11)
                  lw  x22, 88(x11)
                  lw  x23, 92(x11)
                  lw  x24, 96(x11)
                  lw  x25, 100(x11)
                  lw  x26, 104(x11)
                  lw  x27, 108(x11)
                  lw  x28, 112(x11)
                  lw  x29, 116(x11)
                  lw  x30, 120(x11)
                  lw  x31, 124(x11)
                  addi x11, x11, 128
                  add x13, x11, zero
                  lw  x11, (x13)
                  addi x13, x13, 4
                  mret

store_fault_handler:
                  add x11, x13, zero
                  lw  x1, 4(x11)
                  lw  x2, 8(x11)
                  lw  x3, 12(x11)
                  lw  x4, 16(x11)
                  lw  x5, 20(x11)
                  lw  x6, 24(x11)
                  lw  x7, 28(x11)
                  lw  x8, 32(x11)
                  lw  x9, 36(x11)
                  lw  x10, 40(x11)
                  lw  x11, 44(x11)
                  lw  x12, 48(x11)
                  lw  x13, 52(x11)
                  lw  x14, 56(x11)
                  lw  x15, 60(x11)
                  lw  x16, 64(x11)
                  lw  x17, 68(x11)
                  lw  x18, 72(x11)
                  lw  x19, 76(x11)
                  lw  x20, 80(x11)
                  lw  x21, 84(x11)
                  lw  x22, 88(x11)
                  lw  x23, 92(x11)
                  lw  x24, 96(x11)
                  lw  x25, 100(x11)
                  lw  x26, 104(x11)
                  lw  x27, 108(x11)
                  lw  x28, 112(x11)
                  lw  x29, 116(x11)
                  lw  x30, 120(x11)
                  lw  x31, 124(x11)
                  addi x11, x11, 128
                  add x13, x11, zero
                  lw  x11, (x13)
                  addi x13, x13, 4
                  mret

ebreak_handler:   
                  csrr  x29, 0x341
                  addi  x29, x29, 4
                  csrw  0x341, x29
                  add x11, x13, zero
                  lw  x1, 4(x11)
                  lw  x2, 8(x11)
                  lw  x3, 12(x11)
                  lw  x4, 16(x11)
                  lw  x5, 20(x11)
                  lw  x6, 24(x11)
                  lw  x7, 28(x11)
                  lw  x8, 32(x11)
                  lw  x9, 36(x11)
                  lw  x10, 40(x11)
                  lw  x11, 44(x11)
                  lw  x12, 48(x11)
                  lw  x13, 52(x11)
                  lw  x14, 56(x11)
                  lw  x15, 60(x11)
                  lw  x16, 64(x11)
                  lw  x17, 68(x11)
                  lw  x18, 72(x11)
                  lw  x19, 76(x11)
                  lw  x20, 80(x11)
                  lw  x21, 84(x11)
                  lw  x22, 88(x11)
                  lw  x23, 92(x11)
                  lw  x24, 96(x11)
                  lw  x25, 100(x11)
                  lw  x26, 104(x11)
                  lw  x27, 108(x11)
                  lw  x28, 112(x11)
                  lw  x29, 116(x11)
                  lw  x30, 120(x11)
                  lw  x31, 124(x11)
                  addi x11, x11, 128
                  add x13, x11, zero
                  lw  x11, (x13)
                  addi x13, x13, 4
                  mret

illegal_instr_handler:
                  csrr  x29, 0x341
                  addi  x29, x29, 4
                  csrw  0x341, x29
                  add x11, x13, zero
                  lw  x1, 4(x11)
                  lw  x2, 8(x11)
                  lw  x3, 12(x11)
                  lw  x4, 16(x11)
                  lw  x5, 20(x11)
                  lw  x6, 24(x11)
                  lw  x7, 28(x11)
                  lw  x8, 32(x11)
                  lw  x9, 36(x11)
                  lw  x10, 40(x11)
                  lw  x11, 44(x11)
                  lw  x12, 48(x11)
                  lw  x13, 52(x11)
                  lw  x14, 56(x11)
                  lw  x15, 60(x11)
                  lw  x16, 64(x11)
                  lw  x17, 68(x11)
                  lw  x18, 72(x11)
                  lw  x19, 76(x11)
                  lw  x20, 80(x11)
                  lw  x21, 84(x11)
                  lw  x22, 88(x11)
                  lw  x23, 92(x11)
                  lw  x24, 96(x11)
                  lw  x25, 100(x11)
                  lw  x26, 104(x11)
                  lw  x27, 108(x11)
                  lw  x28, 112(x11)
                  lw  x29, 116(x11)
                  lw  x30, 120(x11)
                  lw  x31, 124(x11)
                  addi x11, x11, 128
                  add x13, x11, zero
                  lw  x11, (x13)
                  addi x13, x13, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x29, 0x300 # MSTATUS;
                  csrr  x29, 0x304 # MIE;
                  csrr  x29, 0x344 # MIP;
                  csrrc x29, 0x344, x29 # MIP;
                  add x11, x13, zero
                  lw  x1, 4(x11)
                  lw  x2, 8(x11)
                  lw  x3, 12(x11)
                  lw  x4, 16(x11)
                  lw  x5, 20(x11)
                  lw  x6, 24(x11)
                  lw  x7, 28(x11)
                  lw  x8, 32(x11)
                  lw  x9, 36(x11)
                  lw  x10, 40(x11)
                  lw  x11, 44(x11)
                  lw  x12, 48(x11)
                  lw  x13, 52(x11)
                  lw  x14, 56(x11)
                  lw  x15, 60(x11)
                  lw  x16, 64(x11)
                  lw  x17, 68(x11)
                  lw  x18, 72(x11)
                  lw  x19, 76(x11)
                  lw  x20, 80(x11)
                  lw  x21, 84(x11)
                  lw  x22, 88(x11)
                  lw  x23, 92(x11)
                  lw  x24, 96(x11)
                  lw  x25, 100(x11)
                  lw  x26, 104(x11)
                  lw  x27, 108(x11)
                  lw  x28, 112(x11)
                  lw  x29, 116(x11)
                  lw  x30, 120(x11)
                  lw  x31, 124(x11)
                  addi x11, x11, 128
                  add x13, x11, zero
                  lw  x11, (x13)
                  addi x13, x13, 4
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
