.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x22, h0_start
jalr x0, x22, 0
h0_start:
                  li x8, 0x40000100
                  csrw 0x301, x8
kernel_sp:        
                  la x5, kernel_stack_end

trap_vec_init:    
                  la x8, mtvec_handler
                  ori x8, x8, 1
                  csrw 0x305, x8 # MTVEC

mepc_setup:       
                  la x8, init
                  csrw 0x341, x8

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x8, 0x1800
                  csrw 0x300, x8 # MSTATUS
                  li x8, 0x0
                  csrw 0x304, x8 # MIE
                  mret
init:             
                  li x0, 0x3
                  li x1, 0xfdb2ae84
                  li x2, 0x80000000
                  li x3, 0x0
                  li x4, 0xf488d0c7
                  li x6, 0xa4d1c02b
                  li x7, 0xbe64d3b6
                  li x8, 0x80000000
                  li x9, 0x9
                  li x10, 0x0
                  li x11, 0xa
                  li x12, 0xff422729
                  li x13, 0x80000000
                  li x14, 0xe
                  li x15, 0x7924f4b5
                  li x16, 0x80000000
                  li x17, 0x24541b3d
                  li x18, 0x80000000
                  li x20, 0x80000000
                  li x21, 0x0
                  li x22, 0x80000000
                  li x23, 0x118a577
                  li x24, 0xfeadb471
                  li x25, 0xc5e831dd
                  li x26, 0x0
                  li x27, 0x969dd0a2
                  li x28, 0x94be7a3
                  li x29, 0xff6366e4
                  li x30, 0x80000000
                  li x31, 0xf40c3502
                  la x19, user_stack_end
main:             li           s1, 0xd4fea9ca #start riscv_int_numeric_corner_stream_36
                  li           a4, 0x8313d785
                  li           a3, 0x0
                  li           t3, 0xffffffff
                  li           s8, 0xffffffff
                  li           ra, 0xdbf40674
                  li           a5, 0x80000000
                  li           s2, 0xffffffff
                  li           a2, 0x0
                  li           a6, 0x0
                  nop
                  nop
                  addi         ra, a5, -1202
                  nop
                  sub          a6, a3, a6
                  addi         ra, a5, -1202
                  sub          a6, a3, a6
                  addi         ra, a5, -1202
                  addi         ra, a5, -1202
                  lui          a6, 1015430
                  auipc        s1, 508467
                  add          a3, a5, t3
                  auipc        s1, 508467
                  add          a3, a5, t3
                  sub          a6, a3, a6
                  add          a3, a5, t3
                  addi         ra, a5, -1202
                  sub          a6, a3, a6
                  add          a3, a5, t3
                  sub          a6, a3, a6
                  add          a3, a5, t3
                  add          a3, a5, t3
                  addi         ra, a5, -1202
                  lui          a6, 1015430
                  addi         ra, a5, -1202
                  sub          a6, a3, a6 #end riscv_int_numeric_corner_stream_36
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_14
                  li           s4, 0xffffffff
                  li           s9, 0xbb533ed4
                  li           a0, 0xd5bcc424
                  li           s0, 0x4dcce0c6
                  li           s11, 0xf349a8f7
                  li           a6, 0x80000000
                  li           s2, 0x2f51f688
                  li           t1, 0xffffffff
                  li           a5, 0xffffffff
                  addi         gp, s11, -1202
                  add          s9, a0, s4
                  add          s9, a0, s4
                  nop
                  lui          s0, 1015430
                  addi         gp, s11, -1202
                  add          s9, a0, s4
                  auipc        a5, 508467
                  nop
                  lui          s0, 1015430
                  lui          s0, 1015430
                  lui          s0, 1015430
                  sub          gp, s4, a6
                  lui          s0, 1015430
                  lui          s0, 1015430 #end riscv_int_numeric_corner_stream_14
                  li           s10, 0x80000000 #start riscv_int_numeric_corner_stream_38
                  li           t6, 0xffffffff
                  li           a6, 0x0
                  li           a3, 0x746851fe
                  li           t5, 0x80000000
                  li           s4, 0x80000000
                  li           s9, 0x0
                  li           sp, 0xffffffff
                  li           a0, 0x24a2ba55
                  li           s2, 0x80000000
                  add          s9, a6, s4
                  add          s9, a6, s4
                  nop
                  addi         s9, s10, -1202
                  addi         s9, s10, -1202
                  addi         s9, s10, -1202
                  sub          t5, s4, a6
                  lui          a6, 1015430
                  addi         s9, s10, -1202
                  add          s9, a6, s4
                  sub          t5, s4, a6
                  nop
                  nop
                  addi         s9, s10, -1202
                  nop
                  lui          a6, 1015430
                  nop
                  nop #end riscv_int_numeric_corner_stream_38
                  li           sp, 0x0 #start riscv_int_numeric_corner_stream_39
                  li           a0, 0x80000000
                  li           a7, 0xffffffff
                  li           t3, 0x80000000
                  li           s7, 0xffffffff
                  li           a2, 0xffffffff
                  li           s0, 0x0
                  li           gp, 0xffffffff
                  li           a5, 0xd8d68a4c
                  li           s5, 0xffffffff
                  sub          a2, a0, a7
                  addi         gp, a5, -1202
                  sub          a2, a0, a7
                  lui          s0, 1015430
                  auipc        a5, 508467
                  addi         gp, a5, -1202
                  auipc        a5, 508467
                  nop
                  lui          s0, 1015430
                  addi         gp, a5, -1202
                  sub          a2, a0, a7
                  add          a7, sp, s5
                  addi         gp, a5, -1202
                  addi         gp, a5, -1202
                  add          a7, sp, s5
                  addi         gp, a5, -1202
                  nop
                  lui          s0, 1015430
                  add          a7, sp, s5
                  lui          s0, 1015430
                  nop
                  lui          s0, 1015430
                  add          a7, sp, s5
                  lui          s0, 1015430
                  auipc        a5, 508467
                  add          a7, sp, s5
                  add          a7, sp, s5
                  add          a7, sp, s5
                  sub          a2, a0, a7
                  auipc        a5, 508467 #end riscv_int_numeric_corner_stream_39
                  li           t6, 0x3b116370 #start riscv_int_numeric_corner_stream_7
                  li           a0, 0x9024404f
                  li           s0, 0xffffffff
                  li           t3, 0x6802dc6b
                  li           a7, 0x0
                  li           a2, 0x80000000
                  li           tp, 0x80000000
                  li           a5, 0x0
                  li           s5, 0x80000000
                  li           t2, 0x4a4ef10f
                  auipc        a5, 508467
                  addi         a7, t6, -1202
                  lui          s0, 1015430
                  add          tp, t2, s5
                  sub          t2, a0, a7
                  addi         a7, t6, -1202
                  nop
                  auipc        a5, 508467
                  auipc        a5, 508467
                  nop
                  sub          t2, a0, a7
                  nop
                  lui          s0, 1015430
                  nop
                  sub          t2, a0, a7
                  nop
                  addi         a7, t6, -1202
                  nop
                  auipc        a5, 508467 #end riscv_int_numeric_corner_stream_7
                  li           s5, 0x80000000 #start riscv_int_numeric_corner_stream_33
                  li           tp, 0xffffffff
                  li           s7, 0x0
                  li           a5, 0x80000000
                  li           ra, 0xffffffff
                  li           a1, 0xd20852f9
                  li           t5, 0x0
                  li           t4, 0xaeb127e2
                  li           sp, 0xffffffff
                  li           a4, 0x80000000
                  sub          a1, t4, sp
                  add          tp, s7, s5
                  addi         ra, t5, -1202
                  sub          a1, t4, sp
                  lui          sp, 1015430
                  addi         ra, t5, -1202
                  sub          a1, t4, sp
                  nop
                  nop
                  auipc        a1, 508467
                  addi         ra, t5, -1202
                  nop
                  addi         ra, t5, -1202
                  auipc        a1, 508467
                  lui          sp, 1015430
                  auipc        a1, 508467
                  auipc        a1, 508467
                  add          tp, s7, s5
                  auipc        a1, 508467 #end riscv_int_numeric_corner_stream_33
                  li           t1, 0x80000000 #start riscv_int_numeric_corner_stream_12
                  li           s11, 0xffffffff
                  li           a3, 0x0
                  li           a4, 0x80000000
                  li           gp, 0xffffffff
                  li           s1, 0x80000000
                  li           a0, 0xffffffff
                  li           a6, 0x80000000
                  li           a2, 0x31797cf4
                  li           tp, 0x0
                  addi         s1, s11, -1202
                  add          tp, gp, a2
                  auipc        gp, 508467
                  nop
                  sub          t1, a6, a6
                  sub          t1, a6, a6
                  add          tp, gp, a2
                  addi         s1, s11, -1202
                  lui          a6, 1015430
                  sub          t1, a6, a6
                  sub          t1, a6, a6
                  auipc        gp, 508467
                  nop
                  lui          a6, 1015430
                  sub          t1, a6, a6
                  nop
                  addi         s1, s11, -1202
                  auipc        gp, 508467
                  lui          a6, 1015430
                  addi         s1, s11, -1202
                  lui          a6, 1015430
                  nop
                  add          tp, gp, a2
                  nop
                  auipc        gp, 508467
                  addi         s1, s11, -1202
                  nop
                  auipc        gp, 508467
                  addi         s1, s11, -1202 #end riscv_int_numeric_corner_stream_12
                  li           s9, 0xffffffff #start riscv_int_numeric_corner_stream_5
                  li           a5, 0xffffffff
                  li           s11, 0x0
                  li           s10, 0xffffffff
                  li           s4, 0x1edeed82
                  li           a7, 0x0
                  li           t3, 0x80000000
                  li           a6, 0x80000000
                  li           s8, 0x5c9c0002
                  li           t5, 0xffffffff
                  auipc        a5, 508467
                  addi         a7, s10, -1202
                  auipc        a5, 508467
                  nop
                  lui          a6, 1015430
                  auipc        a5, 508467
                  lui          a6, 1015430
                  sub          t5, s9, s10
                  nop
                  sub          t5, s9, s10
                  sub          t5, s9, s10
                  lui          a6, 1015430
                  add          s9, a6, a7
                  auipc        a5, 508467
                  lui          a6, 1015430
                  lui          a6, 1015430
                  addi         a7, s10, -1202
                  auipc        a5, 508467
                  auipc        a5, 508467
                  lui          a6, 1015430
                  nop
                  addi         a7, s10, -1202 #end riscv_int_numeric_corner_stream_5
                  li           t5, 0xffffffff #start riscv_int_numeric_corner_stream_27
                  li           s5, 0xffffffff
                  li           s8, 0xabe118eb
                  li           s4, 0xffffffff
                  li           a6, 0x80000000
                  li           tp, 0x80000000
                  li           ra, 0xffffffff
                  li           a2, 0x0
                  li           t4, 0x771f7b51
                  li           s9, 0xffffffff
                  addi         a2, t5, -1202
                  nop
                  auipc        s9, 508467
                  sub          t5, t4, s8
                  add          s9, t5, s5
                  addi         a2, t5, -1202
                  auipc        s9, 508467
                  addi         a2, t5, -1202
                  addi         a2, t5, -1202
                  sub          t5, t4, s8
                  addi         a2, t5, -1202
                  auipc        s9, 508467
                  sub          t5, t4, s8
                  add          s9, t5, s5
                  nop
                  addi         a2, t5, -1202
                  nop #end riscv_int_numeric_corner_stream_27
                  li           s4, 0xeda04c14 #start riscv_int_numeric_corner_stream_32
                  li           t4, 0xffffffff
                  li           s2, 0xffffffff
                  li           t2, 0xffffffff
                  li           s7, 0x80000000
                  li           t1, 0x80000000
                  li           t5, 0xffffffff
                  li           s11, 0x80000000
                  li           t6, 0xffffffff
                  li           tp, 0xac5ff595
                  auipc        t2, 508467
                  add          s11, t5, t4
                  add          s11, t5, t4
                  addi         t5, t4, -1202
                  lui          s2, 1015430
                  nop
                  sub          t1, t5, s11
                  lui          s2, 1015430
                  addi         t5, t4, -1202
                  lui          s2, 1015430
                  add          s11, t5, t4
                  add          s11, t5, t4
                  add          s11, t5, t4
                  add          s11, t5, t4
                  sub          t1, t5, s11
                  lui          s2, 1015430
                  nop
                  add          s11, t5, t4
                  addi         t5, t4, -1202
                  nop
                  add          s11, t5, t4
                  lui          s2, 1015430
                  auipc        t2, 508467
                  auipc        t2, 508467
                  auipc        t2, 508467
                  add          s11, t5, t4
                  addi         t5, t4, -1202
                  nop
                  add          s11, t5, t4 #end riscv_int_numeric_corner_stream_32
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_19
                  li           a4, 0x1b77ef17
                  li           a5, 0xffffffff
                  li           s2, 0x19ef764c
                  li           sp, 0x4eee36f6
                  li           s8, 0xa3a29bf4
                  li           t5, 0x0
                  li           t1, 0xfbb7515d
                  li           a0, 0x0
                  li           s0, 0x80000000
                  lui          s0, 1015430
                  lui          s0, 1015430
                  addi         a5, t5, -1202
                  nop
                  addi         a5, t5, -1202
                  nop
                  auipc        a5, 508467
                  auipc        a5, 508467
                  sub          t1, s0, sp
                  nop
                  lui          s0, 1015430
                  sub          t1, s0, sp
                  auipc        a5, 508467
                  add          s2, a6, s0
                  add          s2, a6, s0 #end riscv_int_numeric_corner_stream_19
                  li           t2, 0xa75b4f7d #start riscv_int_numeric_corner_stream_34
                  li           t6, 0x0
                  li           s10, 0x0
                  li           gp, 0x80000000
                  li           t5, 0x0
                  li           s11, 0x80000000
                  li           ra, 0x0
                  li           a0, 0x0
                  li           a3, 0xe31c1eef
                  li           s4, 0x0
                  sub          a0, s4, s10
                  auipc        gp, 508467
                  lui          a0, 1015430
                  addi         s4, s10, -1202
                  auipc        gp, 508467
                  nop
                  addi         s4, s10, -1202
                  auipc        gp, 508467
                  addi         s4, s10, -1202
                  auipc        gp, 508467
                  sub          a0, s4, s10
                  sub          a0, s4, s10
                  nop
                  add          s11, s4, s4
                  sub          a0, s4, s10
                  auipc        gp, 508467
                  auipc        gp, 508467
                  lui          a0, 1015430
                  add          s11, s4, s4
                  sub          a0, s4, s10
                  sub          a0, s4, s10
                  lui          a0, 1015430
                  addi         s4, s10, -1202
                  add          s11, s4, s4 #end riscv_int_numeric_corner_stream_34
                  li           a1, 0x795bd00b #start riscv_int_numeric_corner_stream_8
                  li           t3, 0x80000000
                  li           t5, 0x0
                  li           a3, 0xffffffff
                  li           a4, 0x65c0c2e1
                  li           t4, 0xffffffff
                  li           s7, 0xffffffff
                  li           s0, 0xc20576b8
                  li           s8, 0x9f90741d
                  li           s5, 0xffffffff
                  lui          s0, 1015430
                  auipc        a3, 508467
                  add          s8, s5, s5
                  auipc        a3, 508467
                  add          s8, s5, s5
                  add          s8, s5, s5
                  add          s8, s5, s5
                  lui          s0, 1015430
                  nop
                  addi         a1, t5, -1202
                  add          s8, s5, s5
                  add          s8, s5, s5
                  nop
                  add          s8, s5, s5
                  add          s8, s5, s5
                  nop
                  lui          s0, 1015430
                  addi         a1, t5, -1202
                  sub          a4, t5, a1
                  sub          a4, t5, a1 #end riscv_int_numeric_corner_stream_8
                  li           s4, 0x80000000 #start riscv_int_numeric_corner_stream_21
                  li           ra, 0x2db4a5b5
                  li           a0, 0x0
                  li           s2, 0x80000000
                  li           t4, 0x80000000
                  li           a6, 0x80000000
                  li           gp, 0x0
                  li           s10, 0x0
                  li           a4, 0xac84110d
                  li           s7, 0xffffffff
                  lui          a6, 1015430
                  auipc        gp, 508467
                  addi         ra, a4, -1202
                  auipc        gp, 508467
                  sub          a4, s4, a6
                  lui          a6, 1015430
                  lui          a6, 1015430
                  addi         ra, a4, -1202
                  sub          a4, s4, a6
                  sub          a4, s4, a6
                  auipc        gp, 508467
                  auipc        gp, 508467
                  auipc        gp, 508467
                  auipc        gp, 508467
                  add          s4, a6, s4 #end riscv_int_numeric_corner_stream_21
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  nop
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  nop
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  nop
                  lui          s0, 1015430
                  nop
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  nop
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  add          s2, t5, t0
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  nop
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  nop
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  and          tp, s8, s9
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  nop
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  nop
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  auipc        a1, 508467
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  nop
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  and          tp, s8, s9
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  nop
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  nop
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  nop
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  nop
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  nop
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  nop
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  lui          s0, 1015430
                  add          s2, t5, t0
                  add          s2, t5, t0
                  nop
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  nop
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  lui          s0, 1015430
                  nop
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  nop
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  and          tp, s8, s9
                  or           t3, a6, gp
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  add          s2, t5, t0
                  nop
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  nop
                  nop
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  nop
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  nop
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  nop
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  nop
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  nop
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  li           s7, 0xffffffff #start riscv_int_numeric_corner_stream_30
                  li           t1, 0xffffffff
                  li           s8, 0xffffffff
                  li           a2, 0x483e5738
                  li           s0, 0xffffffff
                  li           a3, 0x45657a91
                  li           t3, 0x80000000
                  li           a7, 0xffffffff
                  li           t5, 0xd6d9235b
                  li           a4, 0x0
                  nop
                  nop
                  addi         a7, a4, -1202
                  auipc        a3, 508467
                  lui          s0, 1015430
                  auipc        a3, 508467
                  nop
                  nop
                  sub          s8, a3, s0
                  auipc        a3, 508467
                  addi         a7, a4, -1202
                  lui          s0, 1015430
                  addi         a7, a4, -1202
                  addi         a7, a4, -1202
                  auipc        a3, 508467
                  lui          s0, 1015430
                  lui          s0, 1015430
                  auipc        a3, 508467
                  addi         a7, a4, -1202
                  sub          s8, a3, s0
                  auipc        a3, 508467
                  addi         a7, a4, -1202
                  lui          s0, 1015430
                  sub          s8, a3, s0
                  lui          s0, 1015430 #end riscv_int_numeric_corner_stream_30
                  add          s2, t5, t0
                  or           t3, a6, gp
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  nop
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  nop
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  add          s2, t5, t0
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  nop
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  nop
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  nop
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  li           s1, 0x8a029d64 #start riscv_int_numeric_corner_stream_20
                  li           t3, 0x80000000
                  li           s9, 0x0
                  li           t2, 0x80000000
                  li           t4, 0x25dbf437
                  li           t1, 0xdda9eb
                  li           s7, 0xffffffff
                  li           a7, 0xffffffff
                  li           a3, 0xc72aeca8
                  li           s11, 0x80000000
                  add          s11, t1, t3
                  auipc        t2, 508467
                  sub          t2, t1, s11
                  auipc        t2, 508467
                  addi         a3, s11, -1202
                  auipc        t2, 508467
                  lui          t1, 1015430
                  nop
                  add          s11, t1, t3
                  nop
                  lui          t1, 1015430
                  lui          t1, 1015430
                  addi         a3, s11, -1202
                  add          s11, t1, t3
                  add          s11, t1, t3
                  sub          t2, t1, s11
                  nop
                  add          s11, t1, t3
                  add          s11, t1, t3
                  add          s11, t1, t3
                  add          s11, t1, t3
                  auipc        t2, 508467
                  addi         a3, s11, -1202
                  sub          t2, t1, s11
                  addi         a3, s11, -1202 #end riscv_int_numeric_corner_stream_20
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  nop
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  nop
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  li           a5, 0xffffffff #start riscv_int_numeric_corner_stream_35
                  li           a3, 0x0
                  li           tp, 0x74b4a2da
                  li           s2, 0x80000000
                  li           t6, 0xd6271738
                  li           sp, 0x0
                  li           s8, 0x0
                  li           t2, 0xffffffff
                  li           t4, 0x0
                  li           a1, 0x80000000
                  auipc        a1, 508467
                  auipc        a1, 508467
                  sub          t2, t4, s2
                  lui          s8, 1015430
                  add          t4, tp, tp
                  auipc        a1, 508467
                  lui          s8, 1015430
                  nop
                  addi         a1, a5, -1202
                  add          t4, tp, tp
                  add          t4, tp, tp
                  addi         a1, a5, -1202
                  auipc        a1, 508467
                  addi         a1, a5, -1202
                  nop
                  add          t4, tp, tp
                  sub          t2, t4, s2
                  nop
                  auipc        a1, 508467
                  auipc        a1, 508467
                  addi         a1, a5, -1202
                  add          t4, tp, tp
                  addi         a1, a5, -1202
                  lui          s8, 1015430
                  lui          s8, 1015430
                  addi         a1, a5, -1202
                  addi         a1, a5, -1202 #end riscv_int_numeric_corner_stream_35
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  nop
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  nop
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  nop
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  nop
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  nop
                  auipc        a1, 508467
                  or           t3, a6, gp
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  nop
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  nop
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  nop
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  nop
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  nop
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  add          s2, t5, t0
                  nop
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  nop
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  nop
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  nop
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  nop
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  nop
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  nop
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  nop
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  add          s2, t5, t0
                  nop
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  nop
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  nop
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  nop
                  lui          s0, 1015430
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  nop
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  nop
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  add          s2, t5, t0
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  nop
                  add          s2, t5, t0
                  add          s2, t5, t0
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  nop
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  or           t3, a6, gp
                  auipc        a1, 508467
                  nop
                  and          tp, s8, s9
                  li           sp, 0xffffffff #start riscv_int_numeric_corner_stream_2
                  li           a4, 0x71f7bf18
                  li           t6, 0xe133942d
                  li           s4, 0xcfe026f5
                  li           s11, 0x0
                  li           a2, 0xd63724bb
                  li           ra, 0x0
                  li           a0, 0x80000000
                  li           t5, 0x707f1b9
                  li           a1, 0xffffffff
                  auipc        a1, 508467
                  nop
                  auipc        a1, 508467
                  nop
                  addi         a1, t5, -1202
                  sub          a4, a0, s11
                  sub          a4, a0, s11
                  lui          sp, 1015430
                  sub          a4, a0, s11
                  sub          a4, a0, s11
                  addi         a1, t5, -1202
                  addi         a1, t5, -1202
                  nop
                  auipc        a1, 508467
                  auipc        a1, 508467
                  nop
                  lui          sp, 1015430
                  nop
                  auipc        a1, 508467
                  add          ra, s4, s4
                  sub          a4, a0, s11
                  add          ra, s4, s4
                  add          ra, s4, s4 #end riscv_int_numeric_corner_stream_2
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  nop
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  nop
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  nop
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  nop
                  lui          s0, 1015430
                  and          tp, s8, s9
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  nop
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  nop
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  nop
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  nop
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  nop
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  nop
                  slli         zero, s11, 14
                  nop
                  nop
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  nop
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  auipc        a1, 508467
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  nop
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  nop
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  nop
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  nop
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  or           t3, a6, gp
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  nop
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  nop
                  auipc        a1, 508467
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  nop
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  nop
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  nop
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  nop
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  nop
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  or           t3, a6, gp
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  lui          s0, 1015430
                  nop
                  nop
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  nop
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  nop
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  nop
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  nop
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  nop
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  nop
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  or           t3, a6, gp
                  lui          s0, 1015430
                  add          s2, t5, t0
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  nop
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  and          tp, s8, s9
                  or           t3, a6, gp
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  nop
                  and          tp, s8, s9
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  nop
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  nop
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  nop
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  nop
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  nop
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  nop
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  add          s2, t5, t0
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  nop
                  lui          s0, 1015430
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  nop
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  li           s7, 0x80000000 #start riscv_int_numeric_corner_stream_11
                  li           t1, 0x6f1c83ab
                  li           t3, 0x3540a283
                  li           a7, 0xd95df881
                  li           a1, 0x0
                  li           t5, 0x884d3a84
                  li           s10, 0x0
                  li           tp, 0x80000000
                  li           ra, 0xac5e2b73
                  li           s9, 0x80000000
                  add          s9, tp, tp
                  sub          t1, tp, a7
                  nop
                  nop
                  lui          s10, 1015430
                  auipc        a1, 508467
                  add          s9, tp, tp
                  sub          t1, tp, a7
                  sub          t1, tp, a7
                  lui          s10, 1015430
                  sub          t1, tp, a7
                  addi         a1, s10, -1202
                  add          s9, tp, tp
                  nop
                  auipc        a1, 508467
                  auipc        a1, 508467
                  auipc        a1, 508467
                  lui          s10, 1015430
                  lui          s10, 1015430
                  sub          t1, tp, a7
                  auipc        a1, 508467
                  add          s9, tp, tp
                  addi         a1, s10, -1202 #end riscv_int_numeric_corner_stream_11
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  nop
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  and          tp, s8, s9
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  nop
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  nop
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  nop
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  nop
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  nop
                  and          tp, s8, s9
                  nop
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  nop
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  nop
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  nop
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  lui          s0, 1015430
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  nop
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  nop
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  nop
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  or           t3, a6, gp
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  add          s2, t5, t0
                  nop
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  nop
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  nop
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  nop
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  nop
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  nop
                  xor          s0, a5, s9
                  nop
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  add          s2, t5, t0
                  or           t3, a6, gp
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  lui          s0, 1015430
                  nop
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  lui          s0, 1015430
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  add          s2, t5, t0
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  lui          s0, 1015430
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  nop
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  nop
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  nop
                  nop
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  nop
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  nop
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  nop
                  sll          sp, s11, s1
                  nop
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  add          s2, t5, t0
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  nop
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  nop
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  nop
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  nop
                  lui          s0, 1015430
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  nop
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  nop
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  nop
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  nop
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  li           a1, 0xf24eeb0c #start riscv_int_numeric_corner_stream_13
                  li           s11, 0x0
                  li           s8, 0x9098fdb3
                  li           sp, 0x0
                  li           s0, 0xd2f3d62e
                  li           a3, 0xffffffff
                  li           a7, 0x0
                  li           t1, 0x0
                  li           s9, 0xffffffff
                  li           gp, 0xffffffff
                  auipc        a1, 508467
                  auipc        a1, 508467
                  lui          s0, 1015430
                  nop
                  lui          s0, 1015430
                  addi         gp, s11, -1202
                  nop
                  nop
                  lui          s0, 1015430
                  nop
                  nop
                  addi         gp, s11, -1202
                  auipc        a1, 508467
                  auipc        a1, 508467
                  auipc        a1, 508467
                  lui          s0, 1015430
                  sub          gp, a3, a7
                  lui          s0, 1015430
                  sub          gp, a3, a7
                  auipc        a1, 508467
                  addi         gp, s11, -1202
                  lui          s0, 1015430
                  lui          s0, 1015430
                  sub          gp, a3, a7
                  auipc        a1, 508467
                  auipc        a1, 508467 #end riscv_int_numeric_corner_stream_13
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  li           a1, 0x80000000 #start riscv_int_numeric_corner_stream_4
                  li           tp, 0xffffffff
                  li           a6, 0x80000000
                  li           sp, 0x80000000
                  li           s2, 0x0
                  li           a3, 0x80000000
                  li           s10, 0x18ed594e
                  li           s9, 0x0
                  li           a0, 0x146b9381
                  li           s4, 0xffffffff
                  lui          a6, 1015430
                  addi         a1, a1, -1202
                  add          tp, s2, s4
                  sub          a6, s4, a6
                  auipc        s9, 508467
                  auipc        s9, 508467
                  nop
                  sub          a6, s4, a6
                  auipc        s9, 508467
                  addi         a1, a1, -1202
                  lui          a6, 1015430
                  add          tp, s2, s4
                  add          tp, s2, s4
                  sub          a6, s4, a6
                  nop
                  nop
                  sub          a6, s4, a6
                  addi         a1, a1, -1202
                  nop
                  auipc        s9, 508467
                  lui          a6, 1015430
                  sub          a6, s4, a6
                  add          tp, s2, s4
                  add          tp, s2, s4 #end riscv_int_numeric_corner_stream_4
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  nop
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  nop
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  auipc        a1, 508467
                  lui          s0, 1015430
                  nop
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  nop
                  slli         zero, s11, 14
                  nop
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  nop
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  or           t3, a6, gp
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  or           t3, a6, gp
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  nop
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  nop
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  nop
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  or           t3, a6, gp
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  nop
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  auipc        a1, 508467
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  nop
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  nop
                  xori         t2, s7, 837
                  nop
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  nop
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  nop
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  nop
                  sra          ra, t0, s6
                  nop
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  nop
                  nop
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  li           s5, 0x80000000 #start riscv_int_numeric_corner_stream_29
                  li           a0, 0x117c61a
                  li           t6, 0x80000000
                  li           s0, 0xc054c2f5
                  li           a4, 0x80000000
                  li           a6, 0xdd7e8132
                  li           ra, 0x51e2f582
                  li           s2, 0xffffffff
                  li           a1, 0x80000000
                  li           a7, 0x0
                  add          s5, a4, s5
                  addi         ra, t6, -1202
                  add          s5, a4, s5
                  lui          s0, 1015430
                  lui          s0, 1015430
                  addi         ra, t6, -1202
                  addi         ra, t6, -1202
                  add          s5, a4, s5
                  lui          s0, 1015430
                  add          s5, a4, s5
                  sub          a1, s5, a6
                  add          s5, a4, s5
                  sub          a1, s5, a6
                  nop
                  add          s5, a4, s5 #end riscv_int_numeric_corner_stream_29
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  nop
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  li           s4, 0xc467bf71 #start riscv_int_numeric_corner_stream_26
                  li           a6, 0x80000000
                  li           gp, 0x0
                  li           sp, 0x80000000
                  li           t6, 0x80000000
                  li           s7, 0xffffffff
                  li           t5, 0x56d6f5e
                  li           a7, 0xccb4f22c
                  li           ra, 0x0
                  li           s8, 0xffffffff
                  addi         ra, t6, -1202
                  nop
                  auipc        gp, 508467
                  sub          gp, s4, a6
                  addi         ra, t6, -1202
                  add          s8, t5, s4
                  lui          a6, 1015430
                  sub          gp, s4, a6
                  nop
                  add          s8, t5, s4
                  addi         ra, t6, -1202
                  sub          gp, s4, a6
                  nop
                  auipc        gp, 508467
                  addi         ra, t6, -1202
                  auipc        gp, 508467
                  add          s8, t5, s4
                  add          s8, t5, s4
                  lui          a6, 1015430
                  sub          gp, s4, a6
                  add          s8, t5, s4
                  addi         ra, t6, -1202
                  sub          gp, s4, a6 #end riscv_int_numeric_corner_stream_26
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  nop
                  lui          s0, 1015430
                  and          tp, s8, s9
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  nop
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  nop
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  nop
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  nop
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  add          s2, t5, t0
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  nop
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  nop
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  nop
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  or           t3, a6, gp
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  li           s5, 0x0 #start riscv_int_numeric_corner_stream_10
                  li           t2, 0xffffffff
                  li           s1, 0x80000000
                  li           s4, 0xef0519c2
                  li           s9, 0x8784ed2d
                  li           t3, 0xdb081251
                  li           a0, 0xde7822a7
                  li           a6, 0x0
                  li           a2, 0xffffffff
                  li           t1, 0x0
                  lui          a6, 1015430
                  add          s9, a0, s5
                  nop
                  auipc        t2, 508467
                  sub          a0, t3, a6
                  nop
                  auipc        t2, 508467
                  nop
                  auipc        t2, 508467
                  lui          a6, 1015430
                  nop
                  lui          a6, 1015430
                  sub          a0, t3, a6
                  addi         a2, a0, -1202
                  addi         a2, a0, -1202
                  nop
                  lui          a6, 1015430
                  addi         a2, a0, -1202
                  addi         a2, a0, -1202
                  nop
                  addi         a2, a0, -1202
                  lui          a6, 1015430
                  sub          a0, t3, a6 #end riscv_int_numeric_corner_stream_10
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  nop
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  nop
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  nop
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  nop
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  and          tp, s8, s9
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  nop
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  lui          s0, 1015430
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  nop
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  add          s2, t5, t0
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  nop
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  nop
                  lui          s0, 1015430
                  add          s2, t5, t0
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  nop
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  add          s2, t5, t0
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  nop
                  xori         t2, s7, 837
                  nop
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  nop
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  nop
                  nop
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  nop
                  or           t3, a6, gp
                  nop
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  nop
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  nop
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  nop
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  auipc        a1, 508467
                  or           t3, a6, gp
                  auipc        a1, 508467
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  nop
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  nop
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  nop
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  nop
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  nop
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  li           a2, 0x4f71e289 #start riscv_int_numeric_corner_stream_16
                  li           tp, 0x80000000
                  li           t5, 0x80000000
                  li           t1, 0x80000000
                  li           a1, 0x0
                  li           gp, 0x0
                  li           t2, 0x80000000
                  li           a4, 0xf82cec6b
                  li           s11, 0x281f96ca
                  li           s0, 0x0
                  nop
                  lui          s0, 1015430
                  nop
                  auipc        s11, 508467
                  add          t5, tp, tp
                  lui          s0, 1015430
                  nop
                  addi         a1, t5, -1202
                  nop
                  addi         a1, t5, -1202
                  lui          s0, 1015430
                  auipc        s11, 508467
                  sub          gp, a4, s11
                  auipc        s11, 508467
                  lui          s0, 1015430
                  addi         a1, t5, -1202
                  lui          s0, 1015430
                  nop
                  sub          gp, a4, s11
                  nop
                  nop
                  nop
                  lui          s0, 1015430
                  sub          gp, a4, s11
                  lui          s0, 1015430
                  add          t5, tp, tp
                  sub          gp, a4, s11
                  auipc        s11, 508467 #end riscv_int_numeric_corner_stream_16
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  nop
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  nop
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  or           t3, a6, gp
                  nop
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  nop
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  nop
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  nop
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  nop
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  lui          s0, 1015430
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  nop
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  nop
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  nop
                  add          s2, t5, t0
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  nop
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  nop
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  nop
                  or           t3, a6, gp
                  lui          s0, 1015430
                  or           t3, a6, gp
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  nop
                  or           t3, a6, gp
                  lui          s0, 1015430
                  nop
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  auipc        a1, 508467
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  nop
                  and          tp, s8, s9
                  nop
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  nop
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  and          tp, s8, s9
                  or           t3, a6, gp
                  li           a1, 0x8dfaa0b1 #start riscv_int_numeric_corner_stream_6
                  li           s0, 0x0
                  li           tp, 0x80000000
                  li           t1, 0x0
                  li           t5, 0x80000000
                  li           a4, 0x430af8de
                  li           a3, 0x80000000
                  li           s7, 0xffffffff
                  li           s9, 0x591a4eec
                  li           s1, 0xffffffff
                  nop
                  nop
                  nop
                  auipc        a3, 508467
                  sub          a1, a4, a1
                  lui          s0, 1015430
                  add          s9, tp, tp
                  sub          a1, a4, a1
                  add          s9, tp, tp
                  addi         s1, t5, -1202
                  nop
                  add          s9, tp, tp
                  lui          s0, 1015430
                  auipc        a3, 508467
                  add          s9, tp, tp
                  nop
                  addi         s1, t5, -1202
                  auipc        a3, 508467
                  lui          s0, 1015430
                  lui          s0, 1015430
                  addi         s1, t5, -1202 #end riscv_int_numeric_corner_stream_6
                  nop
                  add          s2, t5, t0
                  nop
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  nop
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  nop
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  nop
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  nop
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  nop
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  and          tp, s8, s9
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  add          s2, t5, t0
                  add          s2, t5, t0
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  nop
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  nop
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  nop
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  nop
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  lui          s0, 1015430
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  nop
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  nop
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  nop
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  nop
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  nop
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  nop
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  li           s1, 0x7d59e966 #start riscv_int_numeric_corner_stream_1
                  li           s2, 0x80000000
                  li           a1, 0x0
                  li           s7, 0xffffffff
                  li           tp, 0x80000000
                  li           gp, 0xe6dc6724
                  li           s11, 0xffffffff
                  li           a0, 0x9ba8b04c
                  li           t5, 0x0
                  li           t4, 0x0
                  auipc        s1, 508467
                  nop
                  sub          tp, t4, s2
                  addi         a1, t5, -1202
                  lui          s2, 1015430
                  nop
                  addi         a1, t5, -1202
                  nop
                  addi         a1, t5, -1202
                  lui          s2, 1015430
                  addi         a1, t5, -1202
                  sub          tp, t4, s2
                  lui          s2, 1015430
                  lui          s2, 1015430
                  lui          s2, 1015430
                  lui          s2, 1015430
                  sub          tp, t4, s2
                  addi         a1, t5, -1202
                  addi         a1, t5, -1202 #end riscv_int_numeric_corner_stream_1
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  nop
                  and          tp, s8, s9
                  nop
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  nop
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  nop
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  nop
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  nop
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  nop
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  nop
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  nop
                  srl          s0, sp, a4
                  nop
                  auipc        a1, 508467
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  nop
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  nop
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  nop
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  nop
                  auipc        a1, 508467
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  nop
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  nop
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  lui          s0, 1015430
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  nop
                  nop
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  nop
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  nop
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  nop
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  nop
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  nop
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  nop
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  nop
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  nop
                  add          s2, t5, t0
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  nop
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  li           a0, 0xffffffff #start riscv_int_numeric_corner_stream_3
                  li           s5, 0x80000000
                  li           t1, 0xc9521e88
                  li           tp, 0x0
                  li           t5, 0x0
                  li           a4, 0x0
                  li           t2, 0xffffffff
                  li           gp, 0x745e3b8d
                  li           s4, 0x0
                  li           s1, 0x80000000
                  add          tp, gp, s4
                  sub          gp, s5, a0
                  sub          gp, s5, a0
                  add          tp, gp, s4
                  lui          a0, 1015430
                  addi         s1, a4, -1202
                  add          tp, gp, s4
                  add          tp, gp, s4
                  sub          gp, s5, a0
                  nop
                  add          tp, gp, s4
                  add          tp, gp, s4
                  add          tp, gp, s4
                  lui          a0, 1015430
                  nop
                  sub          gp, s5, a0
                  add          tp, gp, s4
                  lui          a0, 1015430
                  lui          a0, 1015430
                  add          tp, gp, s4
                  add          tp, gp, s4
                  sub          gp, s5, a0
                  auipc        gp, 508467
                  sub          gp, s5, a0
                  lui          a0, 1015430
                  sub          gp, s5, a0 #end riscv_int_numeric_corner_stream_3
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  nop
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  nop
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  nop
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  nop
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  nop
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  nop
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  lui          s0, 1015430
                  auipc        a1, 508467
                  nop
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  nop
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  nop
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  nop
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  nop
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  and          tp, s8, s9
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  nop
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  nop
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  lui          s0, 1015430
                  nop
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  nop
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  nop
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  nop
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  nop
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  nop
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  li           t6, 0x89f1e2fb #start riscv_int_numeric_corner_stream_24
                  li           sp, 0x0
                  li           a7, 0x80000000
                  li           a2, 0xffffffff
                  li           s11, 0x20e4081e
                  li           tp, 0x8acacc6a
                  li           gp, 0x80000000
                  li           a5, 0x0
                  li           a1, 0xffffffff
                  li           s5, 0xffffffff
                  lui          sp, 1015430
                  add          tp, gp, s5
                  addi         s11, a5, -1202
                  addi         s11, a5, -1202
                  lui          sp, 1015430
                  lui          sp, 1015430
                  sub          gp, s5, a7
                  nop
                  addi         s11, a5, -1202
                  lui          sp, 1015430
                  auipc        a1, 508467
                  sub          gp, s5, a7
                  add          tp, gp, s5
                  sub          gp, s5, a7
                  lui          sp, 1015430 #end riscv_int_numeric_corner_stream_24
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  li           a7, 0x0 #start riscv_int_numeric_corner_stream_28
                  li           a1, 0x0
                  li           a6, 0xb8f19fdd
                  li           s5, 0x80000000
                  li           s2, 0x0
                  li           s10, 0xe9f28b50
                  li           s11, 0x144dc7c1
                  li           a0, 0x0
                  li           t2, 0x0
                  li           t6, 0xffffffff
                  auipc        a1, 508467
                  nop
                  lui          a0, 1015430
                  addi         s5, t6, -1202
                  add          s5, a6, a7
                  sub          t2, a7, a6
                  add          s5, a6, a7
                  nop
                  auipc        a1, 508467
                  nop
                  auipc        a1, 508467
                  lui          a0, 1015430
                  sub          t2, a7, a6
                  lui          a0, 1015430
                  sub          t2, a7, a6
                  sub          t2, a7, a6
                  auipc        a1, 508467 #end riscv_int_numeric_corner_stream_28
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  lui          s0, 1015430
                  nop
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  nop
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  nop
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  add          s2, t5, t0
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  nop
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  nop
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  lui          s0, 1015430
                  lui          s0, 1015430
                  nop
                  or           t3, a6, gp
                  nop
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  nop
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  nop
                  and          tp, s8, s9
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  nop
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  nop
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  or           t3, a6, gp
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  nop
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  nop
                  add          s2, t5, t0
                  and          tp, s8, s9
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  add          s2, t5, t0
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  nop
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  li           s5, 0x90c75c70 #start riscv_int_numeric_corner_stream_18
                  li           s1, 0x7db7bdb0
                  li           a5, 0x0
                  li           a7, 0xba4f85d7
                  li           a2, 0x0
                  li           s0, 0x24c20443
                  li           a4, 0x80000000
                  li           t4, 0x80000000
                  li           t6, 0xffffffff
                  li           t1, 0x80000000
                  addi         s0, a5, -1202
                  addi         s0, a5, -1202
                  nop
                  lui          t1, 1015430
                  nop
                  addi         s0, a5, -1202
                  addi         s0, a5, -1202
                  lui          t1, 1015430
                  addi         s0, a5, -1202
                  sub          t6, t4, s0
                  lui          t1, 1015430
                  auipc        a5, 508467
                  lui          t1, 1015430
                  auipc        a5, 508467
                  addi         s0, a5, -1202
                  addi         s0, a5, -1202
                  add          s5, t1, s5
                  add          s5, t1, s5
                  addi         s0, a5, -1202
                  lui          t1, 1015430
                  nop
                  nop
                  nop
                  auipc        a5, 508467 #end riscv_int_numeric_corner_stream_18
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  or           t3, a6, gp
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  add          s2, t5, t0
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  nop
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  and          tp, s8, s9
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  nop
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  or           t3, a6, gp
                  nop
                  xori         t2, s7, 837
                  nop
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  nop
                  nop
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  nop
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  add          s2, t5, t0
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  nop
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  nop
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  nop
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  nop
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  nop
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  nop
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  add          s2, t5, t0
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  nop
                  nop
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  nop
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  nop
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  nop
                  slli         zero, s11, 14
                  nop
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  nop
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  li           a3, 0x80000000 #start riscv_int_numeric_corner_stream_31
                  li           a4, 0xffffffff
                  li           s0, 0xffffffff
                  li           a2, 0x80000000
                  li           t1, 0xc37a8f01
                  li           s8, 0x0
                  li           a5, 0x75d31277
                  li           a6, 0x0
                  li           s7, 0xc311af84
                  li           sp, 0x80000000
                  addi         s7, a5, -1202
                  sub          t1, a4, sp
                  addi         s7, a5, -1202
                  addi         s7, a5, -1202
                  auipc        s7, 508467
                  addi         s7, a5, -1202
                  lui          s0, 1015430
                  nop
                  nop
                  lui          s0, 1015430
                  add          a3, a6, a2
                  sub          t1, a4, sp
                  sub          t1, a4, sp
                  lui          s0, 1015430
                  auipc        s7, 508467
                  nop
                  auipc        s7, 508467
                  nop
                  add          a3, a6, a2
                  addi         s7, a5, -1202
                  nop
                  addi         s7, a5, -1202
                  nop
                  sub          t1, a4, sp
                  nop #end riscv_int_numeric_corner_stream_31
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  nop
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  nop
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  nop
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  nop
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  nop
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  lui          s0, 1015430
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  nop
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  or           t3, a6, gp
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  add          s2, t5, t0
                  nop
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  nop
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  nop
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  nop
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  nop
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  or           t3, a6, gp
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  li           s5, 0x18122b93 #start riscv_int_numeric_corner_stream_15
                  li           s2, 0x90471c9d
                  li           s9, 0xffffffff
                  li           a7, 0x80000000
                  li           a0, 0xf2ece5b0
                  li           a1, 0xadbc30f9
                  li           t4, 0x0
                  li           t6, 0x80000000
                  li           a5, 0x0
                  li           a3, 0x0
                  add          t4, a7, s9
                  auipc        a3, 508467
                  nop
                  addi         a1, t6, -1202
                  lui          a0, 1015430
                  addi         a1, t6, -1202
                  nop
                  add          t4, a7, s9
                  sub          a5, a3, a7
                  auipc        a3, 508467
                  lui          a0, 1015430
                  lui          a0, 1015430
                  lui          a0, 1015430
                  lui          a0, 1015430
                  nop #end riscv_int_numeric_corner_stream_15
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  nop
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  nop
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  lui          s0, 1015430
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  nop
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  nop
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  nop
                  and          tp, s8, s9
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  lui          s0, 1015430
                  nop
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  nop
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  add          s2, t5, t0
                  and          tp, s8, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  nop
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  nop
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  nop
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  add          s2, t5, t0
                  nop
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  nop
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  nop
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  nop
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  nop
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  nop
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  nop
                  sra          ra, t0, s6
                  nop
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  lui          s0, 1015430
                  nop
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  nop
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  nop
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  nop
                  srai         t5, s5, 5
                  nop
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  nop
                  nop
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  li           s4, 0x0 #start riscv_int_numeric_corner_stream_17
                  li           a4, 0x80000000
                  li           t6, 0xffffffff
                  li           s5, 0x0
                  li           t1, 0x80000000
                  li           t5, 0xffffffff
                  li           a5, 0x80000000
                  li           s0, 0xe7f1647
                  li           t3, 0xdf2db578
                  li           s7, 0x898c906
                  add          s4, t5, t3
                  auipc        s7, 508467
                  auipc        s7, 508467
                  nop
                  sub          a4, t6, s0
                  lui          s0, 1015430
                  addi         s0, a5, -1202
                  auipc        s7, 508467
                  auipc        s7, 508467
                  addi         s0, a5, -1202
                  add          s4, t5, t3
                  nop
                  addi         s0, a5, -1202
                  lui          s0, 1015430
                  sub          a4, t6, s0
                  lui          s0, 1015430
                  sub          a4, t6, s0
                  add          s4, t5, t3
                  lui          s0, 1015430
                  add          s4, t5, t3
                  sub          a4, t6, s0
                  add          s4, t5, t3 #end riscv_int_numeric_corner_stream_17
                  lui          s0, 1015430
                  nop
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  auipc        a1, 508467
                  add          s2, t5, t0
                  lui          s0, 1015430
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  nop
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  nop
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  nop
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  add          s2, t5, t0
                  and          tp, s8, s9
                  or           t3, a6, gp
                  nop
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  nop
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  auipc        a1, 508467
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  nop
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  nop
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  nop
                  auipc        a1, 508467
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  nop
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  nop
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  nop
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  nop
                  lui          s0, 1015430
                  or           t3, a6, gp
                  or           t3, a6, gp
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  nop
                  or           t3, a6, gp
                  nop
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  nop
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  nop
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  nop
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  nop
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  nop
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  and          tp, s8, s9
                  nop
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  nop
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  nop
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  nop
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  nop
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  or           t3, a6, gp
                  and          tp, s8, s9
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  nop
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  li           a6, 0xcc004530 #start riscv_int_numeric_corner_stream_22
                  li           a7, 0x0
                  li           sp, 0x0
                  li           a0, 0xffffffff
                  li           a4, 0x0
                  li           t2, 0x0
                  li           s0, 0x0
                  li           s2, 0x80000000
                  li           s4, 0x1314a952
                  li           s5, 0x0
                  add          s4, a6, s4
                  nop
                  auipc        a7, 508467
                  nop
                  auipc        a7, 508467
                  nop
                  add          s4, a6, s4
                  lui          s0, 1015430
                  addi         a7, a4, -1202
                  sub          a4, s4, a6
                  auipc        a7, 508467
                  sub          a4, s4, a6
                  add          s4, a6, s4
                  sub          a4, s4, a6
                  add          s4, a6, s4
                  addi         a7, a4, -1202
                  lui          s0, 1015430
                  addi         a7, a4, -1202
                  auipc        a7, 508467
                  sub          a4, s4, a6
                  add          s4, a6, s4
                  sub          a4, s4, a6
                  sub          a4, s4, a6
                  auipc        a7, 508467
                  nop
                  sub          a4, s4, a6
                  lui          s0, 1015430
                  sub          a4, s4, a6
                  lui          s0, 1015430 #end riscv_int_numeric_corner_stream_22
                  nop
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  nop
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  nop
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  nop
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  nop
                  nop
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  nop
                  lui          s0, 1015430
                  and          tp, s8, s9
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  nop
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  nop
                  slli         zero, s11, 14
                  nop
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  nop
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  nop
                  xor          s0, a5, s9
                  nop
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  nop
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  nop
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  nop
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  nop
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  and          tp, s8, s9
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  nop
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  nop
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  nop
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  nop
                  nop
                  and          tp, s8, s9
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  nop
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  nop
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  auipc        a1, 508467
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  nop
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  nop
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  lui          s0, 1015430
                  and          tp, s8, s9
                  nop
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  nop
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  nop
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  and          tp, s8, s9
                  and          tp, s8, s9
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  nop
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  nop
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  slli         zero, s11, 14
                  nop
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  nop
                  srl          s0, sp, a4
                  nop
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  add          s2, t5, t0
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  nop
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  nop
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  nop
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  nop
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  li           a4, 0x80000000 #start riscv_int_numeric_corner_stream_9
                  li           a0, 0xffffffff
                  li           s7, 0xda317374
                  li           t3, 0x80000000
                  li           a7, 0x215f62a3
                  li           a2, 0x4cdd4c8e
                  li           tp, 0x0
                  li           s2, 0xbc0aae77
                  li           s0, 0xffffffff
                  li           sp, 0x0
                  auipc        a7, 508467
                  lui          s0, 1015430
                  addi         a7, t3, -1202
                  sub          s7, t3, s2
                  nop
                  addi         a7, t3, -1202
                  auipc        a7, 508467
                  lui          s0, 1015430
                  addi         a7, t3, -1202
                  add          a7, tp, tp
                  add          a7, tp, tp
                  sub          s7, t3, s2
                  addi         a7, t3, -1202
                  sub          s7, t3, s2
                  add          a7, tp, tp
                  addi         a7, t3, -1202
                  add          a7, tp, tp
                  sub          s7, t3, s2
                  nop
                  add          a7, tp, tp
                  auipc        a7, 508467
                  add          a7, tp, tp
                  addi         a7, t3, -1202 #end riscv_int_numeric_corner_stream_9
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  and          tp, s8, s9
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  nop
                  add          s2, t5, t0
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  nop
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  nop
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  lui          s0, 1015430
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  andi         s11, s1, -182
                  li           ra, 0x858286e4 #start riscv_int_numeric_corner_stream_37
                  li           tp, 0xffffffff
                  li           s1, 0x47caced7
                  li           t1, 0x80000000
                  li           s11, 0xffffffff
                  li           t4, 0x0
                  li           s0, 0x7ea1293d
                  li           s4, 0x80000000
                  li           a5, 0x80000000
                  li           a7, 0x80000000
                  add          tp, a5, s4
                  addi         ra, s11, -1202
                  nop
                  add          tp, a5, s4
                  addi         ra, s11, -1202
                  sub          t1, t4, a7
                  auipc        a5, 508467
                  lui          s0, 1015430
                  lui          s0, 1015430
                  lui          s0, 1015430
                  sub          t1, t4, a7
                  nop
                  sub          t1, t4, a7
                  sub          t1, t4, a7
                  sub          t1, t4, a7
                  add          tp, a5, s4
                  sub          t1, t4, a7
                  addi         ra, s11, -1202
                  lui          s0, 1015430
                  sub          t1, t4, a7
                  auipc        a5, 508467
                  add          tp, a5, s4
                  sub          t1, t4, a7
                  nop
                  add          tp, a5, s4
                  lui          s0, 1015430 #end riscv_int_numeric_corner_stream_37
                  nop
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  or           t3, a6, gp
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sra          ra, t0, s6
                  nop
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  nop
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  nop
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  nop
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  nop
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  nop
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  nop
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  lui          s0, 1015430
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  add          s2, t5, t0
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  nop
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  and          tp, s8, s9
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  nop
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  add          s2, t5, t0
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  nop
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  nop
                  nop
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  nop
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  nop
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  nop
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  ori          t3, s1, -99
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  xor          s0, a5, s9
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  nop
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  nop
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  lui          s0, 1015430
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  nop
                  srli         a5, a5, 28
                  nop
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  add          s2, t5, t0
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  and          tp, s8, s9
                  lui          s0, 1015430
                  and          tp, s8, s9
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  or           t3, a6, gp
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  nop
                  slti         s2, s5, -1881
                  nop
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  nop
                  slli         zero, s11, 14
                  nop
                  sra          ra, t0, s6
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  andi         s11, s1, -182
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  add          s2, t5, t0
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  sub          s0, ra, a7
                  nop
                  nop
                  nop
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  nop
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  and          tp, s8, s9
                  sll          sp, s11, s1
                  nop
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  nop
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  auipc        a1, 508467
                  nop
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  andi         s11, s1, -182
                  nop
                  nop
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sltiu        s0, s1, -1215
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  nop
                  srai         t5, s5, 5
                  nop
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  auipc        a1, 508467
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  xori         t2, s7, 837
                  add          s2, t5, t0
                  nop
                  slti         s2, s5, -1881
                  slti         s2, s5, -1881
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  or           t3, a6, gp
                  add          s2, t5, t0
                  and          tp, s8, s9
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  nop
                  sll          sp, s11, s1
                  xor          s0, a5, s9
                  sll          sp, s11, s1
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  sll          sp, s11, s1
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  or           t3, a6, gp
                  nop
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  nop
                  addi         a7, s10, -1202
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  nop
                  slli         zero, s11, 14
                  nop
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  nop
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  auipc        a1, 508467
                  and          tp, s8, s9
                  auipc        a1, 508467
                  nop
                  andi         s11, s1, -182
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  add          s2, t5, t0
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  add          s2, t5, t0
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  nop
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  sltu         t3, a2, t2
                  nop
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  lui          s0, 1015430
                  or           t3, a6, gp
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  nop
                  andi         s11, s1, -182
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  xor          s0, a5, s9
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  andi         s11, s1, -182
                  ori          t3, s1, -99
                  nop
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  nop
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  sra          ra, t0, s6
                  or           t3, a6, gp
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  nop
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  xor          s0, a5, s9
                  slti         s2, s5, -1881
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  xori         t2, s7, 837
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  sll          sp, s11, s1
                  or           t3, a6, gp
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  nop
                  xor          s0, a5, s9
                  sub          s0, ra, a7
                  auipc        a1, 508467
                  and          tp, s8, s9
                  sub          s0, ra, a7
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  xori         t2, s7, 837
                  sll          sp, s11, s1
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  ori          t3, s1, -99
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  srl          s0, sp, a4
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  slt          s2, zero, s9
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  andi         s11, s1, -182
                  xor          s0, a5, s9
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  li           a2, 0x80000000 #start riscv_int_numeric_corner_stream_25
                  li           t1, 0x0
                  li           ra, 0x6e18bcbd
                  li           s0, 0x0
                  li           s5, 0x0
                  li           tp, 0x0
                  li           t5, 0x82b8a26
                  li           s4, 0x0
                  li           gp, 0xe04d5b1d
                  li           s7, 0x0
                  sub          t1, t5, gp
                  lui          s0, 1015430
                  nop
                  sub          t1, t5, gp
                  sub          t1, t5, gp
                  lui          s0, 1015430
                  sub          t1, t5, gp
                  addi         ra, t5, -1202
                  add          tp, gp, s5
                  auipc        gp, 508467
                  sub          t1, t5, gp
                  nop
                  add          tp, gp, s5
                  sub          t1, t5, gp
                  lui          s0, 1015430 #end riscv_int_numeric_corner_stream_25
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  sll          sp, s11, s1
                  lui          s0, 1015430
                  nop
                  srai         t5, s5, 5
                  nop
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  nop
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  sltiu        s0, s1, -1215
                  and          tp, s8, s9
                  add          s2, t5, t0
                  nop
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  nop
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  andi         s11, s1, -182
                  auipc        a1, 508467
                  add          s2, t5, t0
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  slti         s2, s5, -1881
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  xori         t2, s7, 837
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_0
                  li           a1, 0xf501455b
                  li           a4, 0x0
                  li           s9, 0x80000000
                  li           sp, 0x9ac2cd43
                  li           s0, 0xe4fa59fb
                  li           s4, 0xffffffff
                  li           t1, 0x80000000
                  li           s10, 0x80000000
                  li           t5, 0x80000000
                  auipc        a1, 508467
                  nop
                  nop
                  addi         a1, s10, -1202
                  sub          t1, t3, s10
                  nop
                  nop
                  addi         a1, s10, -1202
                  lui          s0, 1015430
                  sub          t1, t3, s10
                  add          s10, s4, s4
                  nop
                  add          s10, s4, s4
                  addi         a1, s10, -1202
                  addi         a1, s10, -1202 #end riscv_int_numeric_corner_stream_0
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  sltiu        s0, s1, -1215
                  slli         zero, s11, 14
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  add          s2, t5, t0
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  sltu         t3, a2, t2
                  add          s2, t5, t0
                  slti         s2, s5, -1881
                  lui          s0, 1015430
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  andi         s11, s1, -182
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  srli         a5, a5, 28
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  srli         a5, a5, 28
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  nop
                  sltiu        s0, s1, -1215
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  sub          s0, ra, a7
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  srai         t5, s5, 5
                  srli         a5, a5, 28
                  ori          t3, s1, -99
                  sub          s0, ra, a7
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  sltu         t3, a2, t2
                  srli         a5, a5, 28
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  srai         t5, s5, 5
                  nop
                  xori         t2, s7, 837
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  add          s2, t5, t0
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  slti         s2, s5, -1881
                  nop
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  lui          s0, 1015430
                  slli         zero, s11, 14
                  lui          s0, 1015430
                  sltu         t3, a2, t2
                  sltiu        s0, s1, -1215
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  nop
                  auipc        a1, 508467
                  or           t3, a6, gp
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  lui          s0, 1015430
                  srai         t5, s5, 5
                  sra          ra, t0, s6
                  srl          s0, sp, a4
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srai         t5, s5, 5
                  ori          t3, s1, -99
                  xor          s0, a5, s9
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  and          tp, s8, s9
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  and          tp, s8, s9
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  nop
                  srli         a5, a5, 28
                  sub          s0, ra, a7
                  sub          s0, ra, a7
                  slt          s2, zero, s9
                  slt          s2, zero, s9
                  addi         a7, s10, -1202
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  slt          s2, zero, s9
                  sub          s0, ra, a7
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  or           t3, a6, gp
                  and          tp, s8, s9
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  srai         t5, s5, 5
                  slt          s2, zero, s9
                  sra          ra, t0, s6
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  srai         t5, s5, 5
                  xori         t2, s7, 837
                  nop
                  slti         s2, s5, -1881
                  slli         zero, s11, 14
                  srli         a5, a5, 28
                  sra          ra, t0, s6
                  addi         a7, s10, -1202
                  srli         a5, a5, 28
                  xor          s0, a5, s9
                  slt          s2, zero, s9
                  and          tp, s8, s9
                  sra          ra, t0, s6
                  auipc        a1, 508467
                  sll          sp, s11, s1
                  and          tp, s8, s9
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  auipc        a1, 508467
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  xori         t2, s7, 837
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  srai         t5, s5, 5
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  nop
                  and          tp, s8, s9
                  srl          s0, sp, a4
                  nop
                  or           t3, a6, gp
                  sltu         t3, a2, t2
                  or           t3, a6, gp
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  or           t3, a6, gp
                  slli         zero, s11, 14
                  sll          sp, s11, s1
                  slt          s2, zero, s9
                  sltu         t3, a2, t2
                  slti         s2, s5, -1881
                  xor          s0, a5, s9
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  srl          s0, sp, a4
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  nop
                  nop
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  andi         s11, s1, -182
                  slli         zero, s11, 14
                  slti         s2, s5, -1881
                  nop
                  sll          sp, s11, s1
                  sub          s0, ra, a7
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  ori          t3, s1, -99
                  srl          s0, sp, a4
                  ori          t3, s1, -99
                  srli         a5, a5, 28
                  auipc        a1, 508467
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  and          tp, s8, s9
                  ori          t3, s1, -99
                  auipc        a1, 508467
                  sra          ra, t0, s6
                  slti         s2, s5, -1881
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  add          s2, t5, t0
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  slli         zero, s11, 14
                  srai         t5, s5, 5
                  lui          s0, 1015430
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  add          s2, t5, t0
                  add          s2, t5, t0
                  addi         a7, s10, -1202
                  slt          s2, zero, s9
                  srai         t5, s5, 5
                  srl          s0, sp, a4
                  nop
                  ori          t3, s1, -99
                  add          s2, t5, t0
                  xori         t2, s7, 837
                  addi         a7, s10, -1202
                  add          s2, t5, t0
                  slt          s2, zero, s9
                  add          s2, t5, t0
                  or           t3, a6, gp
                  srai         t5, s5, 5
                  sltu         t3, a2, t2
                  sub          s0, ra, a7
                  nop
                  lui          s0, 1015430
                  srl          s0, sp, a4
                  xori         t2, s7, 837
                  sltu         t3, a2, t2
                  lui          s0, 1015430
                  and          tp, s8, s9
                  srli         a5, a5, 28
                  sltiu        s0, s1, -1215
                  andi         s11, s1, -182
                  li           sp, 0x0 #start riscv_int_numeric_corner_stream_23
                  li           a1, 0xffffffff
                  li           t2, 0xf3a5c1c1
                  li           s9, 0x0
                  li           s5, 0x80000000
                  li           s4, 0x80000000
                  li           ra, 0xfe29b74c
                  li           s10, 0xa4ce1a57
                  li           a7, 0x80000000
                  li           s7, 0x0
                  addi         ra, s9, -1202
                  auipc        a1, 508467
                  nop
                  lui          sp, 1015430
                  addi         ra, s9, -1202
                  sub          t2, s4, a7
                  lui          sp, 1015430
                  auipc        a1, 508467
                  auipc        a1, 508467
                  addi         ra, s9, -1202
                  sub          t2, s4, a7
                  auipc        a1, 508467
                  nop
                  sub          t2, s4, a7
                  auipc        a1, 508467
                  nop
                  lui          sp, 1015430
                  auipc        a1, 508467
                  auipc        a1, 508467
                  lui          sp, 1015430
                  nop
                  addi         ra, s9, -1202
                  nop
                  addi         ra, s9, -1202 #end riscv_int_numeric_corner_stream_23
                  xor          s0, a5, s9
                  ori          t3, s1, -99
                  slli         zero, s11, 14
                  or           t3, a6, gp
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  sra          ra, t0, s6
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  ori          t3, s1, -99
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  nop
                  nop
                  ori          t3, s1, -99
                  xori         t2, s7, 837
                  xor          s0, a5, s9
                  sltu         t3, a2, t2
                  srl          s0, sp, a4
                  auipc        a1, 508467
                  add          s2, t5, t0
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  addi         a7, s10, -1202
                  lui          s0, 1015430
                  sra          ra, t0, s6
                  lui          s0, 1015430
                  slt          s2, zero, s9
                  srl          s0, sp, a4
                  addi         a7, s10, -1202
                  sltiu        s0, s1, -1215
                  srl          s0, sp, a4
                  sub          s0, ra, a7
                  sltiu        s0, s1, -1215
                  xori         t2, s7, 837
                  slt          s2, zero, s9
                  sltiu        s0, s1, -1215
                  auipc        a1, 508467
                  xor          s0, a5, s9
                  andi         s11, s1, -182
                  slt          s2, zero, s9
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  or           t3, a6, gp
                  addi         a7, s10, -1202
                  or           t3, a6, gp
                  sltiu        s0, s1, -1215
                  srli         a5, a5, 28
                  slli         zero, s11, 14
                  slli         zero, s11, 14
                  sltiu        s0, s1, -1215
                  sra          ra, t0, s6
                  add          s2, t5, t0
                  nop
                  sll          sp, s11, s1
                  nop
                  add          s2, t5, t0
                  nop
                  add          s2, t5, t0
                  ori          t3, s1, -99
                  addi         a7, s10, -1202
                  andi         s11, s1, -182
                  srli         a5, a5, 28
                  addi         a7, s10, -1202
                  nop
                  xor          s0, a5, s9
                  auipc        a1, 508467
                  and          tp, s8, s9
                  slt          s2, zero, s9
                  xor          s0, a5, s9
                  sra          ra, t0, s6
                  xori         t2, s7, 837
                  nop
                  lui          s0, 1015430
                  or           t3, a6, gp
                  sra          ra, t0, s6
                  xor          s0, a5, s9
                  or           t3, a6, gp
                  srl          s0, sp, a4
                  and          tp, s8, s9
                  slli         zero, s11, 14
                  ori          t3, s1, -99
                  sltiu        s0, s1, -1215
                  lui          s0, 1015430
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  auipc        a1, 508467
                  addi         a7, s10, -1202
                  addi         a7, s10, -1202
                  sub          s0, ra, a7
                  xor          s0, a5, s9
                  lui          s0, 1015430
                  sub          s0, ra, a7
                  add          s2, t5, t0
                  and          tp, s8, s9
                  auipc        a1, 508467
                  srli         a5, a5, 28
                  xori         t2, s7, 837
                  sltiu        s0, s1, -1215
                  srai         t5, s5, 5
                  add          s2, t5, t0
                  sub          s0, ra, a7
                  srli         a5, a5, 28
                  sltu         t3, a2, t2
                  slt          s2, zero, s9
                  slti         s2, s5, -1881
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  sltu         t3, a2, t2
                  srai         t5, s5, 5
                  auipc        a1, 508467
                  slt          s2, zero, s9
                  sll          sp, s11, s1
                  srai         t5, s5, 5
                  addi         a7, s10, -1202
                  nop
                  lui          s0, 1015430
                  andi         s11, s1, -182
                  srl          s0, sp, a4
                  sll          sp, s11, s1
                  srli         a5, a5, 28
                  srl          s0, sp, a4
                  nop
                  ori          t3, s1, -99
                  slti         s2, s5, -1881
                  srai         t5, s5, 5
                  slti         s2, s5, -1881
                  srl          s0, sp, a4
                  srl          s0, sp, a4
                  add          s2, t5, t0
                  sltu         t3, a2, t2
                  la x22, test_done
                  jalr x0, x22, 0
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
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_2:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_3:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_4:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_5:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_6:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_7:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_8:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_9:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_10:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_11:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_12:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_13:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_14:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

mmode_intr_vector_15:
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 0x1f
                  beqz x8, 1f
                  j mmode_intr_handler
                  1: la x22, test_done
                  jalr x0, x22, 0

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
                  addi x5, x5, -4
                  sw  x19, (x5)
                  add x19, x5, zero
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
                  add x5, x19, zero
                  csrr x8, 0x341 # MEPC
                  csrr x8, 0x342 # MCAUSE
                  li x13, 0x3 # BREAKPOINT
                  beq x8, x13, ebreak_handler
                  li x13, 0x8 # ECALL_UMODE
                  beq x8, x13, ecall_handler
                  li x13, 0x9 # ECALL_SMODE
                  beq x8, x13, ecall_handler
                  li x13, 0xb # ECALL_MMODE
                  beq x8, x13, ecall_handler
                  li x13, 0x1
                  beq x8, x13, instr_fault_handler
                  li x13, 0x5
                  beq x8, x13, load_fault_handler
                  li x13, 0x7
                  beq x8, x13, store_fault_handler
                  li x13, 0xc
                  beq x8, x13, pt_fault_handler
                  li x13, 0xd
                  beq x8, x13, pt_fault_handler
                  li x13, 0xf
                  beq x8, x13, pt_fault_handler
                  li x13, 0x2 # ILLEGAL_INSTRUCTION
                  beq x8, x13, illegal_instr_handler
                  csrr x13, 0x343 # MTVAL
                  1: la x22, test_done
                  jalr x1, x22, 0

ecall_handler:    
                  la x8, _start
                  sw x0, 0(x8)
                  sw x1, 4(x8)
                  sw x2, 8(x8)
                  sw x3, 12(x8)
                  sw x4, 16(x8)
                  sw x5, 20(x8)
                  sw x6, 24(x8)
                  sw x7, 28(x8)
                  sw x8, 32(x8)
                  sw x9, 36(x8)
                  sw x10, 40(x8)
                  sw x11, 44(x8)
                  sw x12, 48(x8)
                  sw x13, 52(x8)
                  sw x14, 56(x8)
                  sw x15, 60(x8)
                  sw x16, 64(x8)
                  sw x17, 68(x8)
                  sw x18, 72(x8)
                  sw x19, 76(x8)
                  sw x20, 80(x8)
                  sw x21, 84(x8)
                  sw x22, 88(x8)
                  sw x23, 92(x8)
                  sw x24, 96(x8)
                  sw x25, 100(x8)
                  sw x26, 104(x8)
                  sw x27, 108(x8)
                  sw x28, 112(x8)
                  sw x29, 116(x8)
                  sw x30, 120(x8)
                  sw x31, 124(x8)
                  la x22, write_tohost
                  jalr x0, x22, 0

instr_fault_handler:
                  add x19, x5, zero
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
                  add x5, x19, zero
                  lw  x19, (x5)
                  addi x5, x5, 4
                  mret

load_fault_handler:
                  add x19, x5, zero
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
                  add x5, x19, zero
                  lw  x19, (x5)
                  addi x5, x5, 4
                  mret

store_fault_handler:
                  add x19, x5, zero
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
                  add x5, x19, zero
                  lw  x19, (x5)
                  addi x5, x5, 4
                  mret

ebreak_handler:   
                  csrr  x8, 0x341
                  addi  x8, x8, 4
                  csrw  0x341, x8
                  add x19, x5, zero
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
                  add x5, x19, zero
                  lw  x19, (x5)
                  addi x5, x5, 4
                  mret

illegal_instr_handler:
                  csrr  x8, 0x341
                  addi  x8, x8, 4
                  csrw  0x341, x8
                  add x19, x5, zero
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
                  add x5, x19, zero
                  lw  x19, (x5)
                  addi x5, x5, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x8, 0x300 # MSTATUS;
                  csrr  x8, 0x304 # MIE;
                  csrr  x8, 0x344 # MIP;
                  csrrc x8, 0x344, x8 # MIP;
                  add x19, x5, zero
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
                  add x5, x19, zero
                  lw  x19, (x5)
                  addi x5, x5, 4
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
