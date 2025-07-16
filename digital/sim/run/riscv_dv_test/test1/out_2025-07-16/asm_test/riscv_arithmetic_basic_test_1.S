.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x18, h0_start
jalr x0, x18, 0
h0_start:
                  li x13, 0x40000100
                  csrw 0x301, x13
kernel_sp:        
                  la x8, kernel_stack_end

trap_vec_init:    
                  la x13, mtvec_handler
                  ori x13, x13, 0
                  csrw 0x305, x13 # MTVEC

mepc_setup:       
                  la x13, init
                  csrw 0x341, x13

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x13, 0x1800
                  csrw 0x300, x13 # MSTATUS
                  li x13, 0x0
                  csrw 0x304, x13 # MIE
                  mret
init:             
                  li x0, 0xe3c8f38
                  li x1, 0xfa2b59dc
                  li x3, 0xfac5285b
                  li x4, 0xf2e33196
                  li x5, 0x0
                  li x6, 0x0
                  li x7, 0x80000000
                  li x9, 0x0
                  li x10, 0x85bb88c3
                  li x11, 0x0
                  li x12, 0xc
                  li x13, 0x8
                  li x14, 0x80000000
                  li x15, 0x0
                  li x16, 0x80000000
                  li x17, 0x2
                  li x18, 0xd9e4d772
                  li x19, 0x80000000
                  li x20, 0x80000000
                  li x21, 0x3
                  li x22, 0x0
                  li x23, 0x80000000
                  li x24, 0x0
                  li x25, 0xfe062b07
                  li x26, 0x1
                  li x27, 0xf23acf75
                  li x28, 0xfb8ff797
                  li x29, 0xdfd219f1
                  li x30, 0xb
                  li x31, 0xe
                  la x2, user_stack_end
main:             li           s5, 0xa2e2c921 #start riscv_int_numeric_corner_stream_12
                  li           t3, 0x0
                  li           a4, 0x0
                  li           s11, 0x947ccdd5
                  li           a6, 0x80000000
                  li           s8, 0xffffffff
                  li           a1, 0x80000000
                  li           a3, 0x0
                  li           t4, 0xffffffff
                  li           s10, 0x1b6c18ec
                  nop
                  lui          t3, 357512
                  add          a6, a3, a3
                  lui          t3, 357512
                  nop
                  add          a6, a3, a3
                  lui          t3, 357512
                  sub          s11, a6, a1
                  sub          s11, a6, a1
                  add          a6, a3, a3
                  auipc        a6, 486993
                  addi         s5, a4, -1283
                  addi         s5, a4, -1283
                  auipc        a6, 486993
                  lui          t3, 357512
                  lui          t3, 357512
                  auipc        a6, 486993
                  auipc        a6, 486993
                  lui          t3, 357512
                  sub          s11, a6, a1
                  lui          t3, 357512
                  nop
                  nop
                  sub          s11, a6, a1
                  sub          s11, a6, a1
                  nop
                  nop
                  nop
                  add          a6, a3, a3 #end riscv_int_numeric_corner_stream_12
                  li           t5, 0x0 #start riscv_int_numeric_corner_stream_32
                  li           tp, 0xfcb2e46a
                  li           a3, 0xffffffff
                  li           a2, 0x80000000
                  li           t0, 0x0
                  li           ra, 0x0
                  li           t2, 0xd2de8269
                  li           t1, 0x80000000
                  li           gp, 0xffffffff
                  li           s8, 0x150af3af
                  nop
                  lui          a2, 357512
                  add          t5, t0, a3
                  auipc        gp, 486993
                  lui          a2, 357512
                  auipc        gp, 486993
                  addi         a3, a3, -1283
                  lui          a2, 357512
                  add          t5, t0, a3
                  auipc        gp, 486993
                  add          t5, t0, a3
                  sub          s8, s8, a2
                  lui          a2, 357512
                  sub          s8, s8, a2
                  addi         a3, a3, -1283
                  addi         a3, a3, -1283
                  lui          a2, 357512 #end riscv_int_numeric_corner_stream_32
                  li           s7, 0x80000000 #start riscv_int_numeric_corner_stream_4
                  li           a2, 0x80000000
                  li           s5, 0x80000000
                  li           s10, 0x0
                  li           a5, 0xffffffff
                  li           s8, 0x0
                  li           s9, 0xffffffff
                  li           t4, 0x0
                  li           t3, 0x0
                  li           a6, 0x80000000
                  nop
                  nop
                  lui          a2, 357512
                  lui          a2, 357512
                  nop
                  sub          a5, a6, a2
                  auipc        s10, 486993
                  lui          a2, 357512
                  sub          a5, a6, a2
                  nop
                  addi         s5, a5, -1283
                  nop
                  nop
                  sub          a5, a6, a2
                  nop
                  add          t3, s5, t4
                  add          t3, s5, t4 #end riscv_int_numeric_corner_stream_4
                  li           t5, 0x0 #start riscv_int_numeric_corner_stream_39
                  li           a2, 0x80000000
                  li           t0, 0xffffffff
                  li           a0, 0xd00622fa
                  li           s7, 0x0
                  li           a6, 0xee794769
                  li           s5, 0x80000000
                  li           s11, 0x0
                  li           a4, 0x0
                  li           s3, 0x0
                  addi         s3, t0, -1283
                  addi         s3, t0, -1283
                  nop
                  nop
                  auipc        s3, 486993
                  lui          a2, 357512
                  auipc        s3, 486993
                  addi         s3, t0, -1283
                  sub          a4, a0, a2
                  nop
                  nop
                  auipc        s3, 486993
                  addi         s3, t0, -1283
                  lui          a2, 357512
                  sub          a4, a0, a2
                  add          a2, t0, s11
                  nop #end riscv_int_numeric_corner_stream_39
                  li           t5, 0xaef3c54b #start riscv_int_numeric_corner_stream_34
                  li           a2, 0xffffffff
                  li           a6, 0x4e9a7bfe
                  li           s5, 0xffffffff
                  li           s1, 0xd827ea6d
                  li           a7, 0xffffffff
                  li           ra, 0x80000000
                  li           s10, 0x0
                  li           t1, 0xffffffff
                  li           a0, 0x0
                  sub          s5, ra, a0
                  lui          a2, 357512
                  nop
                  lui          a2, 357512
                  add          a0, ra, s5
                  lui          a2, 357512
                  add          a0, ra, s5
                  addi         s5, ra, -1283
                  auipc        a6, 486993
                  addi         s5, ra, -1283
                  lui          a2, 357512
                  nop
                  addi         s5, ra, -1283
                  auipc        a6, 486993
                  nop #end riscv_int_numeric_corner_stream_34
                  li           a6, 0x0 #start riscv_int_numeric_corner_stream_25
                  li           s9, 0xffffffff
                  li           s5, 0x80000000
                  li           tp, 0xffffffff
                  li           t2, 0x888d3e41
                  li           t0, 0xffffffff
                  li           ra, 0xffffffff
                  li           gp, 0x80000000
                  li           s8, 0x80000000
                  li           a4, 0x80000000
                  sub          a6, gp, tp
                  auipc        a6, 486993
                  add          s8, ra, s9
                  addi         a4, gp, -1283
                  add          s8, ra, s9
                  auipc        a6, 486993
                  auipc        a6, 486993
                  nop
                  addi         a4, gp, -1283
                  nop
                  nop
                  addi         a4, gp, -1283
                  lui          s8, 357512
                  auipc        a6, 486993
                  auipc        a6, 486993
                  auipc        a6, 486993 #end riscv_int_numeric_corner_stream_25
                  li           a6, 0xa29fd634 #start riscv_int_numeric_corner_stream_23
                  li           s1, 0x53f5209f
                  li           a1, 0x80000000
                  li           a3, 0xffffffff
                  li           s8, 0xee241230
                  li           tp, 0xcc8cfac4
                  li           t2, 0xffffffff
                  li           s5, 0x6a81a97e
                  li           a2, 0xad931d17
                  li           t1, 0xbe4e991c
                  add          t1, s1, a3
                  addi         a3, a3, -1283
                  addi         a3, a3, -1283
                  sub          s5, a6, a2
                  lui          a2, 357512
                  addi         a3, a3, -1283
                  add          t1, s1, a3
                  sub          s5, a6, a2
                  auipc        a6, 486993
                  sub          s5, a6, a2
                  sub          s5, a6, a2
                  addi         a3, a3, -1283
                  nop
                  lui          a2, 357512
                  addi         a3, a3, -1283 #end riscv_int_numeric_corner_stream_23
                  li           t4, 0xed6eafde #start riscv_int_numeric_corner_stream_26
                  li           s5, 0x80000000
                  li           t3, 0x0
                  li           s8, 0xffffffff
                  li           s4, 0x2ace2693
                  li           a5, 0x0
                  li           t6, 0x8cd0a5f0
                  li           t5, 0xc000475b
                  li           s6, 0xffffffff
                  li           a3, 0x4538aa68
                  auipc        s8, 486993
                  addi         s5, a5, -1283
                  add          s4, a5, t4
                  lui          s8, 357512
                  add          s4, a5, t4
                  lui          s8, 357512
                  auipc        s8, 486993
                  lui          s8, 357512
                  lui          s8, 357512
                  auipc        s8, 486993
                  auipc        s8, 486993
                  addi         s5, a5, -1283
                  add          s4, a5, t4
                  lui          s8, 357512
                  lui          s8, 357512
                  nop
                  addi         s5, a5, -1283
                  add          s4, a5, t4
                  nop
                  auipc        s8, 486993
                  addi         s5, a5, -1283
                  addi         s5, a5, -1283 #end riscv_int_numeric_corner_stream_26
                  li           a3, 0x0 #start riscv_int_numeric_corner_stream_20
                  li           a0, 0x80000000
                  li           s10, 0x80000000
                  li           s3, 0x1cf94c2d
                  li           s8, 0x80000000
                  li           s4, 0x80000000
                  li           ra, 0x80000000
                  li           a5, 0xffffffff
                  li           a6, 0xffffffff
                  li           t1, 0xffffffff
                  sub          a6, ra, a0
                  auipc        a6, 486993
                  nop
                  addi         a5, a3, -1283
                  sub          a6, ra, a0
                  lui          s4, 357512
                  nop
                  auipc        a6, 486993
                  add          t1, ra, a5
                  sub          a6, ra, a0
                  nop
                  lui          s4, 357512
                  auipc        a6, 486993
                  lui          s4, 357512
                  add          t1, ra, a5
                  nop
                  addi         a5, a3, -1283
                  add          t1, ra, a5
                  addi         a5, a3, -1283
                  sub          a6, ra, a0
                  add          t1, ra, a5
                  add          t1, ra, a5
                  auipc        a6, 486993
                  addi         a5, a3, -1283
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sub          a6, ra, a0
                  nop
                  add          t1, ra, a5 #end riscv_int_numeric_corner_stream_20
                  li           gp, 0x80000000 #start riscv_int_numeric_corner_stream_35
                  li           a1, 0x0
                  li           s8, 0xffffffff
                  li           t1, 0x0
                  li           t5, 0x80000000
                  li           a3, 0x8f041248
                  li           tp, 0xffffffff
                  li           a0, 0x5cd9d1bc
                  li           a5, 0x0
                  li           s10, 0x80000000
                  lui          s8, 357512
                  lui          s8, 357512
                  add          a0, a3, a5
                  lui          s8, 357512
                  sub          s8, gp, a0
                  addi         a3, a3, -1283
                  auipc        gp, 486993
                  sub          s8, gp, a0
                  nop
                  lui          s8, 357512
                  auipc        gp, 486993
                  auipc        gp, 486993
                  lui          s8, 357512
                  lui          s8, 357512
                  nop
                  add          a0, a3, a5
                  add          a0, a3, a5
                  auipc        gp, 486993
                  lui          s8, 357512
                  lui          s8, 357512
                  sub          s8, gp, a0
                  add          a0, a3, a5
                  nop
                  sub          s8, gp, a0
                  lui          s8, 357512 #end riscv_int_numeric_corner_stream_35
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_24
                  li           a0, 0x1c0823f8
                  li           s11, 0x80000000
                  li           t3, 0x668277b5
                  li           s3, 0x80000000
                  li           tp, 0x0
                  li           s5, 0x0
                  li           a5, 0x80000000
                  li           t2, 0x256589bb
                  li           s10, 0xc5c41ec3
                  sub          s3, s1, a0
                  lui          t3, 357512
                  add          a0, s1, a5
                  addi         t2, s1, -1283
                  sub          s3, s1, a0
                  nop
                  addi         t2, s1, -1283
                  sub          s3, s1, a0
                  sub          s3, s1, a0
                  nop
                  lui          t3, 357512
                  auipc        s3, 486993
                  auipc        s3, 486993
                  addi         t2, s1, -1283
                  lui          t3, 357512 #end riscv_int_numeric_corner_stream_24
                  li           a2, 0x80000000 #start riscv_int_numeric_corner_stream_6
                  li           t2, 0xffffffff
                  li           t5, 0x0
                  li           a3, 0x0
                  li           gp, 0x80000000
                  li           s10, 0x4e336d4a
                  li           s11, 0x0
                  li           a0, 0x91d8d516
                  li           s8, 0xb800ad2f
                  li           t3, 0x5750d5f
                  addi         a3, a3, -1283
                  auipc        gp, 486993
                  nop
                  addi         a3, a3, -1283
                  add          a0, a3, a3
                  sub          s8, gp, a2
                  sub          s8, gp, a2
                  nop
                  lui          s10, 357512
                  auipc        gp, 486993
                  auipc        gp, 486993
                  nop
                  auipc        gp, 486993
                  sub          s8, gp, a2
                  lui          s10, 357512
                  sub          s8, gp, a2
                  nop
                  nop
                  sub          s8, gp, a2
                  addi         a3, a3, -1283 #end riscv_int_numeric_corner_stream_6
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_1
                  li           s4, 0x80000000
                  li           a2, 0xffffffff
                  li           t4, 0x0
                  li           ra, 0x0
                  li           t5, 0x91705349
                  li           t1, 0xffffffff
                  li           t0, 0xffffffff
                  li           a5, 0x7ee4eb40
                  li           a4, 0xd3b27352
                  nop
                  add          t1, ra, t4
                  lui          s4, 357512
                  lui          s4, 357512
                  nop
                  lui          s4, 357512
                  add          t1, ra, t4
                  lui          s4, 357512
                  add          t1, ra, t4
                  addi         a5, t0, -1283
                  auipc        ra, 486993
                  auipc        ra, 486993
                  nop
                  addi         a5, t0, -1283
                  sub          t4, s4, a2
                  auipc        ra, 486993
                  auipc        ra, 486993
                  add          t1, ra, t4
                  lui          s4, 357512
                  sub          t4, s4, a2
                  auipc        ra, 486993
                  nop
                  lui          s4, 357512
                  nop
                  sub          t4, s4, a2
                  nop
                  lui          s4, 357512
                  addi         a5, t0, -1283
                  sub          t4, s4, a2
                  auipc        ra, 486993 #end riscv_int_numeric_corner_stream_1
                  li           s9, 0x80000000 #start riscv_int_numeric_corner_stream_37
                  li           a6, 0x80000000
                  li           a5, 0x0
                  li           a2, 0xffffffff
                  li           t1, 0x80000000
                  li           tp, 0x0
                  li           ra, 0x0
                  li           s6, 0x1c960a97
                  li           a3, 0x0
                  li           a4, 0xb987fa30
                  add          t1, a3, a3
                  add          t1, a3, a3
                  sub          s6, a6, a2
                  add          t1, a3, a3
                  auipc        a6, 486993
                  add          t1, a3, a3
                  lui          a2, 357512
                  nop
                  sub          s6, a6, a2
                  add          t1, a3, a3
                  auipc        a6, 486993
                  sub          s6, a6, a2
                  sub          s6, a6, a2
                  lui          a2, 357512
                  addi         a5, a3, -1283
                  lui          a2, 357512
                  sub          s6, a6, a2
                  add          t1, a3, a3
                  sub          s6, a6, a2
                  sub          s6, a6, a2
                  lui          a2, 357512
                  auipc        a6, 486993 #end riscv_int_numeric_corner_stream_37
                  li           s9, 0x520a1689 #start riscv_int_numeric_corner_stream_22
                  li           s4, 0x0
                  li           s10, 0xffffffff
                  li           a7, 0xba119250
                  li           s7, 0x0
                  li           a0, 0xdc6073ac
                  li           a6, 0x2347bdfd
                  li           s5, 0xf8941f4c
                  li           a1, 0x80000000
                  li           s3, 0xffffffff
                  addi         a7, a1, -1283
                  sub          a1, a6, a0
                  lui          s4, 357512
                  sub          a1, a6, a0
                  addi         a7, a1, -1283
                  lui          s4, 357512
                  addi         a7, a1, -1283
                  lui          s4, 357512
                  add          s5, a1, s9
                  add          s5, a1, s9
                  sub          a1, a6, a0
                  auipc        s3, 486993
                  lui          s4, 357512
                  addi         a7, a1, -1283
                  addi         a7, a1, -1283
                  nop #end riscv_int_numeric_corner_stream_22
                  li           a1, 0xffffffff #start riscv_int_numeric_corner_stream_38
                  li           gp, 0x80000000
                  li           s10, 0x80000000
                  li           s1, 0xffffffff
                  li           s4, 0x80000000
                  li           s7, 0x0
                  li           s6, 0xffffffff
                  li           t5, 0x80000000
                  li           a0, 0x80000000
                  li           tp, 0x0
                  nop
                  addi         s7, gp, -1283
                  sub          s7, s1, a0
                  addi         s7, gp, -1283
                  sub          s7, s1, a0
                  auipc        gp, 486993
                  sub          s7, s1, a0
                  nop
                  sub          s7, s1, a0
                  lui          s4, 357512
                  lui          s4, 357512
                  sub          s7, s1, a0
                  add          a0, gp, a1
                  auipc        gp, 486993
                  sub          s7, s1, a0
                  auipc        gp, 486993
                  nop #end riscv_int_numeric_corner_stream_38
                  li           s6, 0x80000000 #start riscv_int_numeric_corner_stream_11
                  li           a7, 0x0
                  li           s9, 0x6ada071d
                  li           t4, 0x80000000
                  li           s3, 0x80000000
                  li           s5, 0x92f143a2
                  li           s4, 0xd22a3ece
                  li           a6, 0x7a1c3376
                  li           s10, 0x381dccdd
                  li           t0, 0x433a6cc3
                  nop
                  addi         s10, t0, -1283
                  addi         s10, t0, -1283
                  addi         s10, t0, -1283
                  auipc        s10, 486993
                  add          s3, t0, t4
                  sub          s4, t0, t0
                  add          s3, t0, t4
                  add          s3, t0, t4
                  add          s3, t0, t4
                  auipc        s10, 486993
                  nop
                  lui          s10, 357512
                  auipc        s10, 486993
                  auipc        s10, 486993 #end riscv_int_numeric_corner_stream_11
                  li           s10, 0x0 #start riscv_int_numeric_corner_stream_13
                  li           s1, 0xbadc8457
                  li           a6, 0xffffffff
                  li           t5, 0x80000000
                  li           s3, 0xb2b18c52
                  li           s8, 0xffffffff
                  li           t6, 0x80000000
                  li           t1, 0x0
                  li           a1, 0x80000000
                  li           a4, 0x80000000
                  nop
                  sub          a6, a1, t1
                  nop
                  auipc        s3, 486993
                  sub          a6, a1, t1
                  lui          s8, 357512
                  lui          s8, 357512
                  lui          s8, 357512
                  addi         t6, s1, -1283
                  nop
                  auipc        s3, 486993
                  lui          s8, 357512
                  auipc        s3, 486993
                  addi         t6, s1, -1283
                  lui          s8, 357512 #end riscv_int_numeric_corner_stream_13
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  nop
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  or           a2, t4, s10
                  lui          a2, 357512
                  lui          a2, 357512
                  and          t4, t4, s8
                  lui          a2, 357512
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  and          t4, t4, s8
                  lui          a2, 357512
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  lui          a2, 357512
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  lui          a2, 357512
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  nop
                  srai         s8, gp, 6
                  nop
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  lui          a2, 357512
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  nop
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  lui          a2, 357512
                  lui          a2, 357512
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  nop
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  nop
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  lui          a2, 357512
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  nop
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  nop
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  nop
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  nop
                  lui          a2, 357512
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  lui          a2, 357512
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  nop
                  lui          a2, 357512
                  nop
                  ori          t3, a2, 308
                  nop
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  lui          a2, 357512
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  nop
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  nop
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  lui          a2, 357512
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  nop
                  nop
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  nop
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  nop
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  nop
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  lui          a2, 357512
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  nop
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  nop
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  nop
                  sltu         t6, ra, t6
                  nop
                  ori          t3, a2, 308
                  nop
                  nop
                  nop
                  lui          a2, 357512
                  lui          a2, 357512
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  nop
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  nop
                  sltu         t6, ra, t6
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  or           a2, t4, s10
                  nop
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  lui          a2, 357512
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  nop
                  lui          a2, 357512
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  lui          a2, 357512
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  nop
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  lui          a2, 357512
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  nop
                  nop
                  add          a0, gp, t4
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  nop
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  nop
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  nop
                  nop
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  nop
                  auipc        a6, 486993
                  nop
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  lui          a2, 357512
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  nop
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  nop
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  nop
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  lui          a2, 357512
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  nop
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  nop
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  lui          a2, 357512
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  lui          a2, 357512
                  lui          a2, 357512
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  lui          a2, 357512
                  nop
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  nop
                  and          t4, t4, s8
                  or           a2, t4, s10
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  lui          a2, 357512
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  nop
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  nop
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  lui          a2, 357512
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  lui          a2, 357512
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  lui          a2, 357512
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  nop
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  nop
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  nop
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  lui          a2, 357512
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  lui          a2, 357512
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  nop
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  nop
                  nop
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  nop
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  nop
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  nop
                  sub          t4, t6, a0
                  nop
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  nop
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  nop
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  and          t4, t4, s8
                  nop
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  nop
                  or           a2, t4, s10
                  or           a2, t4, s10
                  nop
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  lui          a2, 357512
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  nop
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  or           a2, t4, s10
                  nop
                  add          a0, gp, t4
                  or           a2, t4, s10
                  add          a0, gp, t4
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  nop
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  or           a2, t4, s10
                  lui          a2, 357512
                  or           a2, t4, s10
                  nop
                  nop
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  nop
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  or           a2, t4, s10
                  auipc        a6, 486993
                  lui          a2, 357512
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  nop
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  nop
                  or           a2, t4, s10
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  nop
                  add          a0, gp, t4
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  nop
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  nop
                  nop
                  nop
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  lui          a2, 357512
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  nop
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  and          t4, t4, s8
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  add          a0, gp, t4
                  or           a2, t4, s10
                  lui          a2, 357512
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  nop
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  lui          a2, 357512
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  nop
                  srl          zero, s0, ra
                  lui          a2, 357512
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  nop
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  add          a0, gp, t4
                  lui          a2, 357512
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  lui          a2, 357512
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  lui          a2, 357512
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  nop
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  lui          a2, 357512
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  nop
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  nop
                  or           a2, t4, s10
                  auipc        a6, 486993
                  nop
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  nop
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  lui          a2, 357512
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  nop
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  lui          a2, 357512
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  nop
                  slt          ra, s3, tp
                  nop
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  nop
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  lui          a2, 357512
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  and          t4, t4, s8
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  nop
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  nop
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  nop
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  lui          a2, 357512
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  lui          a2, 357512
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  nop
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  nop
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  nop
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  nop
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  nop
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  nop
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  nop
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  nop
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  or           a2, t4, s10
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  nop
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  auipc        a6, 486993
                  add          a0, gp, t4
                  lui          a2, 357512
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  nop
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  lui          a2, 357512
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  nop
                  auipc        a6, 486993
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  lui          a2, 357512
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  li           s9, 0x0 #start riscv_int_numeric_corner_stream_36
                  li           s1, 0x80000000
                  li           s6, 0x80000000
                  li           a0, 0xffffffff
                  li           a3, 0xa94e0407
                  li           s5, 0x0
                  li           s4, 0xf8912731
                  li           s3, 0x0
                  li           t6, 0x0
                  li           a6, 0x0
                  addi         s3, a3, -1283
                  add          s4, s5, a3
                  sub          a6, s1, s1
                  nop
                  nop
                  addi         s3, a3, -1283
                  sub          a6, s1, s1
                  add          s4, s5, a3
                  nop
                  addi         s3, a3, -1283
                  add          s4, s5, a3
                  auipc        s3, 486993
                  add          s4, s5, a3
                  nop
                  nop #end riscv_int_numeric_corner_stream_36
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  or           a2, t4, s10
                  add          a0, gp, t4
                  nop
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  nop
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  nop
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  nop
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  lui          a2, 357512
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  li           ra, 0xffffffff #start riscv_int_numeric_corner_stream_15
                  li           gp, 0xffffffff
                  li           t1, 0x0
                  li           t6, 0x80000000
                  li           t4, 0xffffffff
                  li           s5, 0x0
                  li           a6, 0xffffffff
                  li           s11, 0xffffffff
                  li           t3, 0x80000000
                  li           s8, 0x80000000
                  lui          t3, 357512
                  add          t1, s5, t4
                  auipc        a6, 486993
                  add          t1, s5, t4
                  auipc        a6, 486993
                  add          t1, s5, t4
                  addi         s5, t1, -1283
                  addi         s5, t1, -1283
                  nop
                  nop
                  auipc        a6, 486993
                  auipc        a6, 486993
                  addi         s5, t1, -1283
                  auipc        a6, 486993
                  add          t1, s5, t4
                  nop
                  nop #end riscv_int_numeric_corner_stream_15
                  nop
                  sub          t4, t6, a0
                  lui          a2, 357512
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_33
                  li           a7, 0x0
                  li           a3, 0x757cde45
                  li           ra, 0xffffffff
                  li           s1, 0x6df9b9ed
                  li           s8, 0xffffffff
                  li           a6, 0x0
                  li           a0, 0xd00140c2
                  li           a2, 0xffffffff
                  li           a1, 0x80000000
                  addi         a0, s1, -1283
                  add          a6, ra, a3
                  sub          a0, ra, a2
                  lui          a2, 357512
                  auipc        a6, 486993
                  addi         a0, s1, -1283
                  lui          a2, 357512
                  auipc        a6, 486993
                  nop
                  nop
                  sub          a0, ra, a2
                  addi         a0, s1, -1283
                  auipc        a6, 486993
                  auipc        a6, 486993
                  add          a6, ra, a3
                  addi         a0, s1, -1283
                  sub          a0, ra, a2
                  nop
                  lui          a2, 357512
                  sub          a0, ra, a2
                  add          a6, ra, a3 #end riscv_int_numeric_corner_stream_33
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  nop
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  add          a0, gp, t4
                  nop
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  lui          a2, 357512
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  nop
                  nop
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  nop
                  or           a2, t4, s10
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  lui          a2, 357512
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  nop
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  nop
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  or           a2, t4, s10
                  add          a0, gp, t4
                  nop
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  nop
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  lui          a2, 357512
                  lui          a2, 357512
                  sub          t4, t6, a0
                  lui          a2, 357512
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  nop
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  lui          a2, 357512
                  lui          a2, 357512
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  and          t4, t4, s8
                  or           a2, t4, s10
                  auipc        a6, 486993
                  li           t0, 0xe2e57003 #start riscv_int_numeric_corner_stream_18
                  li           s8, 0x80000000
                  li           ra, 0x5830f5a4
                  li           s3, 0x0
                  li           s9, 0xffffffff
                  li           s5, 0xb9ce3ca5
                  li           s7, 0x80000000
                  li           gp, 0x80000000
                  li           a3, 0xe9c224bb
                  li           t2, 0xffffffff
                  sub          s8, gp, ra
                  auipc        gp, 486993
                  addi         a3, t2, -1283
                  sub          s8, gp, ra
                  lui          s8, 357512
                  auipc        gp, 486993
                  nop
                  lui          s8, 357512
                  add          s5, a3, s9
                  sub          s8, gp, ra
                  add          s5, a3, s9
                  add          s5, a3, s9
                  sub          s8, gp, ra
                  lui          s8, 357512
                  lui          s8, 357512
                  nop
                  add          s5, a3, s9
                  addi         a3, t2, -1283
                  addi         a3, t2, -1283
                  addi         a3, t2, -1283
                  auipc        gp, 486993
                  add          s5, a3, s9
                  lui          s8, 357512
                  add          s5, a3, s9
                  addi         a3, t2, -1283
                  addi         a3, t2, -1283
                  nop
                  auipc        gp, 486993
                  auipc        gp, 486993
                  nop #end riscv_int_numeric_corner_stream_18
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  nop
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  nop
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  or           a2, t4, s10
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  lui          a2, 357512
                  nop
                  nop
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  nop
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  nop
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  lui          a2, 357512
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  nop
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  and          t4, t4, s8
                  nop
                  add          a0, gp, t4
                  lui          a2, 357512
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  auipc        a6, 486993
                  lui          a2, 357512
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  nop
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  lui          a2, 357512
                  and          t4, t4, s8
                  nop
                  nop
                  or           a2, t4, s10
                  lui          a2, 357512
                  nop
                  nop
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  lui          a2, 357512
                  nop
                  or           a2, t4, s10
                  lui          a2, 357512
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  lui          a2, 357512
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  nop
                  and          t4, t4, s8
                  or           a2, t4, s10
                  nop
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  nop
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  nop
                  srai         s8, gp, 6
                  lui          a2, 357512
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  nop
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  nop
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  nop
                  lui          a2, 357512
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  lui          a2, 357512
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  lui          a2, 357512
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  nop
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  nop
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  auipc        a6, 486993
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  nop
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  nop
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  add          a0, gp, t4
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  add          a0, gp, t4
                  nop
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  lui          a2, 357512
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  nop
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  nop
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  nop
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  nop
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  and          t4, t4, s8
                  or           a2, t4, s10
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  nop
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  lui          a2, 357512
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  nop
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  nop
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  nop
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  xor          zero, a4, a1
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  nop
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  add          a0, gp, t4
                  auipc        a6, 486993
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  nop
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  nop
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  nop
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  nop
                  and          t4, t4, s8
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  lui          a2, 357512
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  nop
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  nop
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  nop
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  nop
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  nop
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_16
                  li           t4, 0xabf899
                  li           a4, 0x0
                  li           a7, 0xffffffff
                  li           ra, 0x0
                  li           s4, 0x80000000
                  li           a1, 0xb699bedd
                  li           s10, 0x80000000
                  li           a2, 0x80000000
                  li           s1, 0x9c65f2ca
                  sub          a7, s1, a2
                  lui          a2, 357512
                  lui          a2, 357512
                  nop
                  add          s1, ra, t4
                  addi         t4, ra, -1283
                  sub          a7, s1, a2
                  auipc        a6, 486993
                  lui          a2, 357512
                  lui          a2, 357512
                  auipc        a6, 486993
                  sub          a7, s1, a2
                  add          s1, ra, t4
                  addi         t4, ra, -1283
                  auipc        a6, 486993
                  lui          a2, 357512
                  lui          a2, 357512
                  auipc        a6, 486993
                  nop
                  sub          a7, s1, a2
                  nop
                  sub          a7, s1, a2
                  lui          a2, 357512
                  lui          a2, 357512
                  sub          a7, s1, a2 #end riscv_int_numeric_corner_stream_16
                  srli         s11, s10, 4
                  lui          a2, 357512
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  nop
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  nop
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  auipc        a6, 486993
                  lui          a2, 357512
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  nop
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  nop
                  or           a2, t4, s10
                  or           a2, t4, s10
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  and          t4, t4, s8
                  or           a2, t4, s10
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  nop
                  nop
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  lui          a2, 357512
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  nop
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  li           s10, 0xffffffff #start riscv_int_numeric_corner_stream_21
                  li           s9, 0x4fd9ff29
                  li           a4, 0xffffffff
                  li           a0, 0x80000000
                  li           t1, 0x80000000
                  li           t6, 0x80000000
                  li           s4, 0x80000000
                  li           t0, 0x69b7dad8
                  li           a3, 0x80000000
                  li           t4, 0x0
                  sub          t1, a0, a0
                  nop
                  nop
                  nop
                  add          t1, s9, t4
                  add          t1, s9, t4
                  lui          s4, 357512
                  addi         t6, t0, -1283
                  add          t1, s9, t4
                  sub          t1, a0, a0
                  sub          t1, a0, a0
                  lui          s4, 357512
                  lui          s4, 357512
                  nop
                  nop
                  auipc        s10, 486993
                  nop
                  lui          s4, 357512
                  auipc        s10, 486993 #end riscv_int_numeric_corner_stream_21
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  nop
                  nop
                  nop
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  and          t4, t4, s8
                  nop
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  lui          a2, 357512
                  auipc        a6, 486993
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  lui          a2, 357512
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  nop
                  add          a0, gp, t4
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  sll          t3, zero, s11
                  nop
                  slti         s8, s6, 95
                  nop
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  lui          a2, 357512
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  lui          a2, 357512
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  nop
                  nop
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  and          t4, t4, s8
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  nop
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  nop
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  lui          a2, 357512
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  lui          a2, 357512
                  or           a2, t4, s10
                  nop
                  nop
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  auipc        a6, 486993
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  nop
                  nop
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  nop
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  nop
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  nop
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  nop
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  nop
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  nop
                  nop
                  nop
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  nop
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  lui          a2, 357512
                  nop
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  nop
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  nop
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  add          a0, gp, t4
                  add          a0, gp, t4
                  nop
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  nop
                  auipc        a6, 486993
                  add          a0, gp, t4
                  nop
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  lui          a2, 357512
                  add          a0, gp, t4
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  nop
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  lui          a2, 357512
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  nop
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  lui          a2, 357512
                  or           a2, t4, s10
                  and          t4, t4, s8
                  lui          a2, 357512
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  auipc        a6, 486993
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  nop
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  nop
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  nop
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  lui          a2, 357512
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  lui          a2, 357512
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  nop
                  nop
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  nop
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  nop
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  nop
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  lui          a2, 357512
                  lui          a2, 357512
                  lui          a2, 357512
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  lui          a2, 357512
                  or           a2, t4, s10
                  lui          a2, 357512
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  lui          a2, 357512
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  nop
                  srai         s8, gp, 6
                  nop
                  or           a2, t4, s10
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  and          t4, t4, s8
                  auipc        a6, 486993
                  auipc        a6, 486993
                  lui          a2, 357512
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  lui          a2, 357512
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  lui          a2, 357512
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  lui          a2, 357512
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  nop
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  lui          a2, 357512
                  nop
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  nop
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  nop
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  nop
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  lui          a2, 357512
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  nop
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  add          a0, gp, t4
                  or           a2, t4, s10
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  nop
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  nop
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  lui          a2, 357512
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  li           a4, 0x80000000 #start riscv_int_numeric_corner_stream_28
                  li           a0, 0xffffffff
                  li           s4, 0x0
                  li           s6, 0xc2f8d241
                  li           s7, 0xffffffff
                  li           t1, 0x0
                  li           t2, 0xffffffff
                  li           a7, 0x0
                  li           ra, 0x0
                  li           a5, 0xc8dd2795
                  auipc        a7, 486993
                  add          s4, a7, a5
                  auipc        a7, 486993
                  auipc        a7, 486993
                  auipc        a7, 486993
                  auipc        a7, 486993
                  add          s4, a7, a5
                  nop
                  addi         s7, ra, -1283
                  auipc        a7, 486993
                  nop
                  auipc        a7, 486993
                  add          s4, a7, a5
                  sub          a7, ra, a0
                  add          s4, a7, a5
                  add          s4, a7, a5 #end riscv_int_numeric_corner_stream_28
                  auipc        a6, 486993
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  nop
                  add          a0, gp, t4
                  or           a2, t4, s10
                  and          t4, t4, s8
                  and          t4, t4, s8
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  nop
                  nop
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  lui          a2, 357512
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  nop
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  nop
                  add          a0, gp, t4
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  nop
                  nop
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  nop
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  nop
                  xor          zero, a4, a1
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  nop
                  sra          gp, a1, s7
                  nop
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  or           a2, t4, s10
                  nop
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  nop
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  nop
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  nop
                  and          t4, t4, s8
                  nop
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  nop
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  lui          a2, 357512
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  nop
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  nop
                  and          t4, t4, s8
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  or           a2, t4, s10
                  lui          a2, 357512
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  nop
                  or           a2, t4, s10
                  add          a0, gp, t4
                  nop
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  nop
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  nop
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  nop
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  nop
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  nop
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  nop
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  nop
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  lui          a2, 357512
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  nop
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  auipc        a6, 486993
                  auipc        a6, 486993
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  nop
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  lui          a2, 357512
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  lui          a2, 357512
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  nop
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  nop
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  lui          a2, 357512
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  nop
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  nop
                  lui          a2, 357512
                  lui          a2, 357512
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  nop
                  add          a0, gp, t4
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  lui          a2, 357512
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  lui          a2, 357512
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  lui          a2, 357512
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  lui          a2, 357512
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  nop
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  nop
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  nop
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  nop
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  nop
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  lui          a2, 357512
                  add          a0, gp, t4
                  and          t4, t4, s8
                  or           a2, t4, s10
                  lui          a2, 357512
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  nop
                  nop
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  auipc        a6, 486993
                  or           a2, t4, s10
                  lui          a2, 357512
                  srl          zero, s0, ra
                  nop
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  and          t4, t4, s8
                  or           a2, t4, s10
                  and          t4, t4, s8
                  lui          a2, 357512
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  nop
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  nop
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  lui          a2, 357512
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  nop
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  nop
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  lui          a2, 357512
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  nop
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  nop
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  nop
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  nop
                  ori          t3, a2, 308
                  nop
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  lui          a2, 357512
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  lui          a2, 357512
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  lui          a2, 357512
                  lui          a2, 357512
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  nop
                  or           a2, t4, s10
                  nop
                  auipc        a6, 486993
                  or           a2, t4, s10
                  or           a2, t4, s10
                  nop
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  nop
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  nop
                  or           a2, t4, s10
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  nop
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  auipc        a6, 486993
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  nop
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  nop
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  nop
                  nop
                  lui          a2, 357512
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  nop
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  li           s3, 0x80000000 #start riscv_int_numeric_corner_stream_27
                  li           t0, 0xffffffff
                  li           gp, 0x46dff188
                  li           s6, 0x0
                  li           s4, 0xffffffff
                  li           ra, 0xffffffff
                  li           t1, 0x80000000
                  li           s10, 0x80000000
                  li           t5, 0xffffffff
                  li           s11, 0x80000000
                  auipc        gp, 486993
                  nop
                  nop
                  nop
                  addi         t0, t1, -1283
                  sub          s3, gp, ra
                  lui          s4, 357512
                  add          gp, ra, s11
                  add          gp, ra, s11
                  addi         t0, t1, -1283
                  auipc        gp, 486993
                  addi         t0, t1, -1283
                  add          gp, ra, s11
                  nop
                  sub          s3, gp, ra
                  auipc        gp, 486993
                  lui          s4, 357512
                  add          gp, ra, s11
                  add          gp, ra, s11
                  auipc        gp, 486993
                  sub          s3, gp, ra
                  addi         t0, t1, -1283
                  sub          s3, gp, ra
                  sub          s3, gp, ra
                  nop
                  sub          s3, gp, ra
                  lui          s4, 357512
                  auipc        gp, 486993 #end riscv_int_numeric_corner_stream_27
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  nop
                  slt          ra, s3, tp
                  li           ra, 0x80000000 #start riscv_int_numeric_corner_stream_8
                  li           a4, 0xffffffff
                  li           t6, 0xf2c6a3f5
                  li           s10, 0xbdf391c2
                  li           t2, 0x42a592e1
                  li           t4, 0x28828575
                  li           a7, 0xe8067921
                  li           s11, 0x0
                  li           gp, 0x0
                  li           tp, 0xffffffff
                  nop
                  nop
                  sub          a7, gp, tp
                  addi         a4, gp, -1283
                  add          tp, t4, t4
                  lui          tp, 357512
                  lui          tp, 357512
                  auipc        a7, 486993
                  nop
                  add          tp, t4, t4
                  add          tp, t4, t4
                  addi         a4, gp, -1283
                  addi         a4, gp, -1283
                  nop
                  lui          tp, 357512
                  addi         a4, gp, -1283
                  auipc        a7, 486993 #end riscv_int_numeric_corner_stream_8
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  nop
                  or           a2, t4, s10
                  lui          a2, 357512
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  nop
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  nop
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  or           a2, t4, s10
                  lui          a2, 357512
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  nop
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  nop
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  lui          a2, 357512
                  srl          zero, s0, ra
                  nop
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  lui          a2, 357512
                  nop
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  nop
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  nop
                  nop
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  lui          a2, 357512
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  nop
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  lui          a2, 357512
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  nop
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  lui          a2, 357512
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  lui          a2, 357512
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  nop
                  add          a0, gp, t4
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  nop
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  nop
                  add          a0, gp, t4
                  auipc        a6, 486993
                  or           a2, t4, s10
                  nop
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  lui          a2, 357512
                  or           a2, t4, s10
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  nop
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  nop
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  or           a2, t4, s10
                  or           a2, t4, s10
                  nop
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  lui          a2, 357512
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  lui          a2, 357512
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  nop
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  nop
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  lui          a2, 357512
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  or           a2, t4, s10
                  or           a2, t4, s10
                  nop
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  li           t6, 0x97e25013 #start riscv_int_numeric_corner_stream_29
                  li           s4, 0xffffffff
                  li           t1, 0xeac05493
                  li           s7, 0x80000000
                  li           a6, 0xd1b76ed9
                  li           s6, 0xffffffff
                  li           a4, 0x75266f8
                  li           s10, 0x0
                  li           a3, 0xffffffff
                  li           t5, 0x80000000
                  auipc        a6, 486993
                  nop
                  sub          t6, t1, t1
                  auipc        a6, 486993
                  auipc        a6, 486993
                  lui          s4, 357512
                  nop
                  lui          s4, 357512
                  nop
                  auipc        a6, 486993
                  addi         t6, a4, -1283
                  add          a3, a3, t6
                  sub          t6, t1, t1
                  sub          t6, t1, t1
                  sub          t6, t1, t1
                  sub          t6, t1, t1
                  lui          s4, 357512 #end riscv_int_numeric_corner_stream_29
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  add          a0, gp, t4
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  nop
                  sra          gp, a1, s7
                  nop
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  add          a0, gp, t4
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  nop
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  nop
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  nop
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  lui          a2, 357512
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  nop
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  lui          a2, 357512
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  lui          a2, 357512
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  nop
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  nop
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  nop
                  or           a2, t4, s10
                  nop
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  or           a2, t4, s10
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  add          a0, gp, t4
                  or           a2, t4, s10
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  nop
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  nop
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  nop
                  nop
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  lui          a2, 357512
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  nop
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  nop
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  nop
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  li           gp, 0x0 #start riscv_int_numeric_corner_stream_9
                  li           s10, 0xffffffff
                  li           t1, 0x908f21a2
                  li           s11, 0xffffffff
                  li           tp, 0x0
                  li           ra, 0x68556812
                  li           s9, 0xffffffff
                  li           t4, 0xffffffff
                  li           a2, 0x80000000
                  li           a5, 0x11d420c6
                  sub          s9, s10, a2
                  add          ra, a5, t4
                  addi         t4, ra, -1283
                  addi         t4, ra, -1283
                  add          ra, a5, t4
                  addi         t4, ra, -1283
                  nop
                  sub          s9, s10, a2
                  lui          a2, 357512
                  add          ra, a5, t4
                  nop
                  nop
                  lui          a2, 357512
                  sub          s9, s10, a2
                  nop #end riscv_int_numeric_corner_stream_9
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  nop
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  auipc        a6, 486993
                  add          a0, gp, t4
                  or           a2, t4, s10
                  nop
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  and          t4, t4, s8
                  lui          a2, 357512
                  nop
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  lui          a2, 357512
                  and          t4, t4, s8
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  nop
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  nop
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  and          t4, t4, s8
                  lui          a2, 357512
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  nop
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  nop
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  lui          a2, 357512
                  add          a0, gp, t4
                  or           a2, t4, s10
                  lui          a2, 357512
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  nop
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  nop
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  nop
                  andi         t1, s7, -636
                  nop
                  add          a0, gp, t4
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  auipc        a6, 486993
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  nop
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  lui          a2, 357512
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  nop
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  nop
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  nop
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  nop
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  lui          a2, 357512
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  lui          a2, 357512
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  nop
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  nop
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  nop
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  nop
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  lui          a2, 357512
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  nop
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  nop
                  and          t4, t4, s8
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  lui          a2, 357512
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  nop
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  nop
                  auipc        a6, 486993
                  auipc        a6, 486993
                  or           a2, t4, s10
                  auipc        a6, 486993
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  nop
                  srli         s11, s10, 4
                  nop
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  lui          a2, 357512
                  nop
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  nop
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  nop
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  nop
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  nop
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  nop
                  add          a0, gp, t4
                  or           a2, t4, s10
                  nop
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  sra          gp, a1, s7
                  nop
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  nop
                  lui          a2, 357512
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  nop
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  nop
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  nop
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  nop
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_19
                  li           a5, 0x360fa816
                  li           s5, 0x0
                  li           t3, 0x0
                  li           a2, 0x0
                  li           t4, 0x58b6a4ee
                  li           s8, 0x80000000
                  li           t1, 0x36aac48b
                  li           s6, 0xfc87f4cc
                  li           a3, 0xa75af6ea
                  auipc        s8, 486993
                  nop
                  nop
                  nop
                  add          t1, s11, t4
                  nop
                  add          t1, s11, t4
                  nop
                  add          t1, s11, t4
                  sub          a5, t1, t1
                  lui          t3, 357512
                  lui          t3, 357512
                  nop
                  lui          t3, 357512
                  sub          a5, t1, t1
                  nop
                  addi         a5, a2, -1283 #end riscv_int_numeric_corner_stream_19
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  nop
                  lui          a2, 357512
                  lui          a2, 357512
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  lui          a2, 357512
                  add          a0, gp, t4
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  nop
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  lui          a2, 357512
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  lui          a2, 357512
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  lui          a2, 357512
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  nop
                  nop
                  lui          a2, 357512
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  nop
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  nop
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  lui          a2, 357512
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  or           a2, t4, s10
                  lui          a2, 357512
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  lui          a2, 357512
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  lui          a2, 357512
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  nop
                  lui          a2, 357512
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  nop
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  nop
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  lui          a2, 357512
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  nop
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  nop
                  auipc        a6, 486993
                  or           a2, t4, s10
                  auipc        a6, 486993
                  and          t4, t4, s8
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  lui          a2, 357512
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  nop
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  nop
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  nop
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  and          t4, t4, s8
                  lui          a2, 357512
                  nop
                  xori         zero, s3, -1338
                  nop
                  lui          a2, 357512
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  nop
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  and          t4, t4, s8
                  or           a2, t4, s10
                  nop
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  lui          a2, 357512
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  nop
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  or           a2, t4, s10
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  nop
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  nop
                  lui          a2, 357512
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  add          a0, gp, t4
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  auipc        a6, 486993
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  nop
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  nop
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  nop
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  nop
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  nop
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  or           a2, t4, s10
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  nop
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  and          t4, t4, s8
                  lui          a2, 357512
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  lui          a2, 357512
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  nop
                  sltu         t6, ra, t6
                  nop
                  andi         t1, s7, -636
                  nop
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  nop
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  nop
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  lui          a2, 357512
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  nop
                  or           a2, t4, s10
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  or           a2, t4, s10
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  lui          a2, 357512
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  nop
                  slti         s8, s6, 95
                  lui          a2, 357512
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  nop
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  nop
                  auipc        a6, 486993
                  or           a2, t4, s10
                  and          t4, t4, s8
                  and          t4, t4, s8
                  nop
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  nop
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  and          t4, t4, s8
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  nop
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  nop
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  lui          a2, 357512
                  or           a2, t4, s10
                  lui          a2, 357512
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  lui          a2, 357512
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  nop
                  nop
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  add          a0, gp, t4
                  and          t4, t4, s8
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  lui          a2, 357512
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  nop
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  nop
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  lui          a2, 357512
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  lui          a2, 357512
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  lui          a2, 357512
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  nop
                  srai         s8, gp, 6
                  lui          a2, 357512
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  li           s7, 0x0 #start riscv_int_numeric_corner_stream_10
                  li           a5, 0xf91a30f3
                  li           a0, 0xffffffff
                  li           t6, 0x80000000
                  li           s3, 0xffffffff
                  li           s6, 0xffffffff
                  li           s1, 0xace484e1
                  li           s11, 0xffffffff
                  li           s10, 0xffffffff
                  li           s5, 0x0
                  nop
                  nop
                  add          s3, s5, t6
                  lui          s10, 357512
                  auipc        s3, 486993
                  auipc        s3, 486993
                  add          s3, s5, t6
                  nop
                  nop
                  addi         s3, a5, -1283
                  auipc        s3, 486993
                  auipc        s3, 486993
                  auipc        s3, 486993
                  sub          s3, s1, s1
                  addi         s3, a5, -1283
                  lui          s10, 357512
                  add          s3, s5, t6
                  add          s3, s5, t6
                  addi         s3, a5, -1283
                  addi         s3, a5, -1283
                  lui          s10, 357512
                  nop
                  nop
                  sub          s3, s1, s1
                  addi         s3, a5, -1283
                  add          s3, s5, t6
                  sub          s3, s1, s1
                  add          s3, s5, t6 #end riscv_int_numeric_corner_stream_10
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  lui          a2, 357512
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  auipc        a6, 486993
                  lui          a2, 357512
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  nop
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  auipc        a6, 486993
                  lui          a2, 357512
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  and          t4, t4, s8
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  nop
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  lui          a2, 357512
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  nop
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  lui          a2, 357512
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  nop
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  nop
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  nop
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  li           s5, 0x0 #start riscv_int_numeric_corner_stream_30
                  li           t1, 0x0
                  li           t6, 0x0
                  li           tp, 0xef2309ae
                  li           s3, 0x0
                  li           a0, 0xffffffff
                  li           a2, 0x80000000
                  li           s11, 0x24621d10
                  li           s1, 0x80000000
                  li           ra, 0x80000000
                  nop
                  addi         t6, ra, -1283
                  add          a0, ra, t6
                  auipc        s3, 486993
                  add          a0, ra, t6
                  add          a0, ra, t6
                  auipc        s3, 486993
                  add          a0, ra, t6
                  auipc        s3, 486993
                  add          a0, ra, t6
                  lui          a0, 357512
                  add          a0, ra, t6
                  add          a0, ra, t6
                  addi         t6, ra, -1283
                  add          a0, ra, t6 #end riscv_int_numeric_corner_stream_30
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  nop
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  lui          a2, 357512
                  lui          a2, 357512
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  xori         zero, s3, -1338
                  nop
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  nop
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  and          t4, t4, s8
                  lui          a2, 357512
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  srl          zero, s0, ra
                  nop
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  nop
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  nop
                  addi         gp, s1, -1283
                  nop
                  sub          t4, t6, a0
                  nop
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  lui          a2, 357512
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  nop
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  lui          a2, 357512
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  nop
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  nop
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  nop
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  nop
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  nop
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  nop
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  lui          a2, 357512
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  li           a0, 0xffffffff #start riscv_int_numeric_corner_stream_7
                  li           t5, 0xe23427f0
                  li           a1, 0xffffffff
                  li           tp, 0x80000000
                  li           s8, 0x80000000
                  li           t3, 0x0
                  li           a6, 0x80000000
                  li           s1, 0x3720270
                  li           t1, 0x15d004cd
                  li           gp, 0x80000000
                  lui          t3, 357512
                  nop
                  add          a0, gp, a1
                  sub          t3, s1, a0
                  addi         a1, gp, -1283
                  sub          t3, s1, a0
                  add          a0, gp, a1
                  sub          t3, s1, a0
                  auipc        a6, 486993
                  nop
                  add          a0, gp, a1
                  nop
                  add          a0, gp, a1
                  nop
                  sub          t3, s1, a0
                  add          a0, gp, a1
                  sub          t3, s1, a0
                  nop
                  sub          t3, s1, a0
                  nop
                  addi         a1, gp, -1283
                  nop
                  auipc        a6, 486993
                  auipc        a6, 486993
                  nop
                  auipc        a6, 486993
                  addi         a1, gp, -1283
                  add          a0, gp, a1
                  addi         a1, gp, -1283 #end riscv_int_numeric_corner_stream_7
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  nop
                  and          t4, t4, s8
                  lui          a2, 357512
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  nop
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  lui          a2, 357512
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  nop
                  nop
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  lui          a2, 357512
                  nop
                  auipc        a6, 486993
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  nop
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  nop
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  nop
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  nop
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  nop
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  nop
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  nop
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  nop
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  li           a7, 0xffffffff #start riscv_int_numeric_corner_stream_31
                  li           t3, 0xe403958b
                  li           t5, 0x91f27115
                  li           a0, 0xffffffff
                  li           gp, 0x0
                  li           a5, 0x80000000
                  li           t4, 0x0
                  li           s7, 0x247534b8
                  li           s5, 0x0
                  li           a1, 0x80000000
                  nop
                  auipc        gp, 486993
                  addi         a7, a5, -1283
                  nop
                  addi         a7, a5, -1283
                  add          t3, s5, t4
                  nop
                  nop
                  auipc        gp, 486993
                  sub          s7, gp, gp
                  lui          a0, 357512
                  nop
                  add          t3, s5, t4
                  addi         a7, a5, -1283
                  addi         a7, a5, -1283
                  lui          a0, 357512
                  addi         a7, a5, -1283
                  nop
                  lui          a0, 357512
                  nop
                  add          t3, s5, t4
                  auipc        gp, 486993
                  sub          s7, gp, gp
                  add          t3, s5, t4 #end riscv_int_numeric_corner_stream_31
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  nop
                  lui          a2, 357512
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  lui          a2, 357512
                  or           a2, t4, s10
                  nop
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  lui          a2, 357512
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  nop
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  auipc        a6, 486993
                  auipc        a6, 486993
                  lui          a2, 357512
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  xor          zero, a4, a1
                  nop
                  slt          ra, s3, tp
                  lui          a2, 357512
                  or           a2, t4, s10
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  nop
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  nop
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  nop
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  nop
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  nop
                  slli         t0, s3, 26
                  lui          a2, 357512
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  nop
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  nop
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  auipc        a6, 486993
                  lui          a2, 357512
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  nop
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  nop
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  lui          a2, 357512
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  nop
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  nop
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  nop
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  lui          a2, 357512
                  sra          gp, a1, s7
                  nop
                  srli         s11, s10, 4
                  lui          a2, 357512
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  nop
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  nop
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  nop
                  add          a0, gp, t4
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  nop
                  and          t4, t4, s8
                  lui          a2, 357512
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  or           a2, t4, s10
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  nop
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  lui          a2, 357512
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  and          t4, t4, s8
                  auipc        a6, 486993
                  auipc        a6, 486993
                  lui          a2, 357512
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  lui          a2, 357512
                  or           a2, t4, s10
                  nop
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  nop
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  nop
                  add          a0, gp, t4
                  and          t4, t4, s8
                  nop
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  nop
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  nop
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  nop
                  nop
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  nop
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  lui          a2, 357512
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  nop
                  lui          a2, 357512
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  nop
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  nop
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  sll          t3, zero, s11
                  nop
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  nop
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  nop
                  srli         s11, s10, 4
                  nop
                  add          a0, gp, t4
                  nop
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  nop
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  nop
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  nop
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  nop
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  and          t4, t4, s8
                  or           a2, t4, s10
                  nop
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  nop
                  and          t4, t4, s8
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  nop
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  and          t4, t4, s8
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  nop
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  nop
                  nop
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  nop
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  lui          a2, 357512
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  lui          a2, 357512
                  slti         s8, s6, 95
                  nop
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  nop
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  nop
                  lui          a2, 357512
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  lui          a2, 357512
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  nop
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  nop
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  nop
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  lui          a2, 357512
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  lui          a2, 357512
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  nop
                  sll          t3, zero, s11
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  or           a2, t4, s10
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  li           a5, 0x39ebb6a3 #start riscv_int_numeric_corner_stream_17
                  li           a0, 0xffffffff
                  li           a3, 0x598a268d
                  li           tp, 0xffffffff
                  li           gp, 0xffffffff
                  li           s5, 0x73f86d18
                  li           a7, 0xffffffff
                  li           t0, 0xffffffff
                  li           s9, 0x80000000
                  li           s4, 0x0
                  add          a0, s5, a3
                  sub          a7, gp, a0
                  add          a0, s5, a3
                  lui          s4, 357512
                  auipc        gp, 486993
                  auipc        gp, 486993
                  addi         a5, a3, -1283
                  nop
                  nop
                  auipc        gp, 486993
                  add          a0, s5, a3
                  auipc        gp, 486993
                  nop
                  lui          s4, 357512
                  sub          a7, gp, a0
                  sub          a7, gp, a0 #end riscv_int_numeric_corner_stream_17
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  nop
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  auipc        a6, 486993
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  nop
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  lui          a2, 357512
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  lui          a2, 357512
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  nop
                  nop
                  lui          a2, 357512
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  nop
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  nop
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  nop
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  nop
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  nop
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  lui          a2, 357512
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  or           a2, t4, s10
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  nop
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  nop
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  nop
                  ori          t3, a2, 308
                  lui          a2, 357512
                  add          a0, gp, t4
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  lui          a2, 357512
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  and          t4, t4, s8
                  auipc        a6, 486993
                  nop
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  nop
                  and          t4, t4, s8
                  or           a2, t4, s10
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  nop
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  sltu         t6, ra, t6
                  nop
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  lui          a2, 357512
                  nop
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  nop
                  add          a0, gp, t4
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  lui          a2, 357512
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  and          t4, t4, s8
                  nop
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  lui          a2, 357512
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  lui          a2, 357512
                  lui          a2, 357512
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  or           a2, t4, s10
                  nop
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  nop
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  nop
                  auipc        a6, 486993
                  lui          a2, 357512
                  and          t4, t4, s8
                  auipc        a6, 486993
                  nop
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  auipc        a6, 486993
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  lui          a2, 357512
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  nop
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  nop
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  xori         zero, s3, -1338
                  nop
                  lui          a2, 357512
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  nop
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  nop
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  lui          a2, 357512
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  nop
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  and          t4, t4, s8
                  nop
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  nop
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  nop
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  nop
                  and          t4, t4, s8
                  nop
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  nop
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  lui          a2, 357512
                  lui          a2, 357512
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  nop
                  sltu         t6, ra, t6
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  lui          a2, 357512
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  lui          a2, 357512
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  nop
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  nop
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  nop
                  addi         gp, s1, -1283
                  lui          a2, 357512
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  srli         s11, s10, 4
                  lui          a2, 357512
                  slt          ra, s3, tp
                  nop
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  or           a2, t4, s10
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  nop
                  auipc        a6, 486993
                  auipc        a6, 486993
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  nop
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  or           a2, t4, s10
                  or           a2, t4, s10
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  nop
                  nop
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  slli         t0, s3, 26
                  nop
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  nop
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  lui          a2, 357512
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_14
                  li           t4, 0x80000000
                  li           tp, 0x0
                  li           ra, 0x80000000
                  li           s8, 0x80000000
                  li           t2, 0x0
                  li           a4, 0x25ad97da
                  li           a0, 0xffffffff
                  li           s6, 0xffffffff
                  li           gp, 0x0
                  nop
                  addi         a4, gp, -1283
                  lui          s8, 357512
                  add          t4, ra, t4
                  sub          s6, ra, a0
                  lui          s8, 357512
                  add          t4, ra, t4
                  add          t4, ra, t4
                  sub          s6, ra, a0
                  nop
                  addi         a4, gp, -1283
                  add          t4, ra, t4
                  add          t4, ra, t4
                  addi         a4, gp, -1283
                  addi         a4, gp, -1283
                  addi         a4, gp, -1283
                  lui          s8, 357512
                  sub          s6, ra, a0
                  nop
                  auipc        a6, 486993
                  nop
                  add          t4, ra, t4
                  lui          s8, 357512
                  addi         a4, gp, -1283 #end riscv_int_numeric_corner_stream_14
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  nop
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  andi         t1, s7, -636
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  lui          a2, 357512
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  nop
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  nop
                  sra          gp, a1, s7
                  lui          a2, 357512
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  nop
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  lui          a2, 357512
                  or           a2, t4, s10
                  auipc        a6, 486993
                  or           a2, t4, s10
                  add          a0, gp, t4
                  lui          a2, 357512
                  auipc        a6, 486993
                  nop
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  lui          a2, 357512
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  nop
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  lui          a2, 357512
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  or           a2, t4, s10
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  nop
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  lui          a2, 357512
                  nop
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  add          a0, gp, t4
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  and          t4, t4, s8
                  and          t4, t4, s8
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  nop
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  lui          a2, 357512
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  nop
                  lui          a2, 357512
                  auipc        a6, 486993
                  nop
                  nop
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  xori         zero, s3, -1338
                  add          a0, gp, t4
                  nop
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  nop
                  sll          t3, zero, s11
                  lui          a2, 357512
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  lui          a2, 357512
                  lui          a2, 357512
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  nop
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  add          a0, gp, t4
                  auipc        a6, 486993
                  lui          a2, 357512
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  nop
                  sra          gp, a1, s7
                  nop
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  lui          a2, 357512
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  nop
                  nop
                  nop
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  addi         gp, s1, -1283
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  lui          a2, 357512
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  lui          a2, 357512
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  nop
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  nop
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  andi         t1, s7, -636
                  nop
                  auipc        a6, 486993
                  lui          a2, 357512
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  auipc        a6, 486993
                  xori         zero, s3, -1338
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  nop
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  nop
                  nop
                  xor          zero, a4, a1
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  srl          zero, s0, ra
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  nop
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  auipc        a6, 486993
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  lui          a2, 357512
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  srai         s8, gp, 6
                  nop
                  and          t4, t4, s8
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  sll          t3, zero, s11
                  lui          a2, 357512
                  and          t4, t4, s8
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  lui          a2, 357512
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  nop
                  srl          zero, s0, ra
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  nop
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  lui          a2, 357512
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  auipc        a6, 486993
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  nop
                  lui          a2, 357512
                  srai         s8, gp, 6
                  nop
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  lui          a2, 357512
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sra          gp, a1, s7
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  lui          a2, 357512
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  nop
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  or           a2, t4, s10
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  xor          zero, a4, a1
                  nop
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  xori         zero, s3, -1338
                  slti         s8, s6, 95
                  lui          a2, 357512
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  nop
                  xor          zero, a4, a1
                  srl          zero, s0, ra
                  nop
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  nop
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  nop
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  nop
                  or           a2, t4, s10
                  sll          t3, zero, s11
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  and          t4, t4, s8
                  nop
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  nop
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  nop
                  add          a0, gp, t4
                  li           tp, 0xbfa3061d #start riscv_int_numeric_corner_stream_0
                  li           s6, 0xdcf2bf48
                  li           a0, 0x80000000
                  li           s1, 0x80000000
                  li           s3, 0xffffffff
                  li           t1, 0x0
                  li           s5, 0xb96cf2cf
                  li           s9, 0xffffffff
                  li           a1, 0x80000000
                  li           t2, 0x0
                  auipc        s3, 486993
                  addi         s5, s1, -1283
                  addi         s5, s1, -1283
                  auipc        s3, 486993
                  sub          s5, s1, a0
                  lui          tp, 357512
                  add          a0, s1, s9
                  auipc        s3, 486993
                  addi         s5, s1, -1283
                  nop
                  sub          s5, s1, a0
                  nop
                  sub          s5, s1, a0
                  sub          s5, s1, a0
                  auipc        s3, 486993
                  auipc        s3, 486993
                  addi         s5, s1, -1283
                  addi         s5, s1, -1283
                  lui          tp, 357512
                  sub          s5, s1, a0
                  add          a0, s1, s9
                  nop
                  sub          s5, s1, a0
                  add          a0, s1, s9
                  sub          s5, s1, a0 #end riscv_int_numeric_corner_stream_0
                  lui          a2, 357512
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  nop
                  lui          a2, 357512
                  andi         t1, s7, -636
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  lui          a2, 357512
                  and          t4, t4, s8
                  nop
                  sra          gp, a1, s7
                  nop
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  lui          a2, 357512
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  lui          a2, 357512
                  and          t4, t4, s8
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  nop
                  sltiu        a3, s10, -817
                  nop
                  lui          a2, 357512
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  sub          t4, t6, a0
                  addi         gp, s1, -1283
                  li           a3, 0xffffffff #start riscv_int_numeric_corner_stream_2
                  li           t1, 0x0
                  li           t3, 0x7b6f5571
                  li           s6, 0xffffffff
                  li           s7, 0xffffffff
                  li           a5, 0x0
                  li           gp, 0x0
                  li           a1, 0x1337f7b9
                  li           a7, 0x80000000
                  li           ra, 0xffffffff
                  nop
                  auipc        gp, 486993
                  add          t1, a3, a3
                  sub          a1, ra, t1
                  auipc        gp, 486993
                  add          t1, a3, a3
                  auipc        gp, 486993
                  addi         a5, a3, -1283
                  lui          s6, 357512
                  add          t1, a3, a3
                  add          t1, a3, a3
                  sub          a1, ra, t1
                  lui          s6, 357512
                  addi         a5, a3, -1283
                  add          t1, a3, a3
                  auipc        gp, 486993
                  add          t1, a3, a3
                  lui          s6, 357512
                  addi         a5, a3, -1283
                  auipc        gp, 486993
                  add          t1, a3, a3
                  add          t1, a3, a3
                  add          t1, a3, a3 #end riscv_int_numeric_corner_stream_2
                  srli         s11, s10, 4
                  xori         zero, s3, -1338
                  srl          zero, s0, ra
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  ori          t3, a2, 308
                  nop
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  li           t6, 0x0 #start riscv_int_numeric_corner_stream_5
                  li           a0, 0x4cbec278
                  li           tp, 0x0
                  li           ra, 0xffffffff
                  li           s6, 0x80000000
                  li           s7, 0x0
                  li           a2, 0xffffffff
                  li           a3, 0x0
                  li           a4, 0x0
                  li           a1, 0x80000000
                  nop
                  addi         a3, a3, -1283
                  add          tp, a3, a3
                  sub          s7, ra, a0
                  add          tp, a3, a3
                  addi         a3, a3, -1283
                  addi         a3, a3, -1283
                  auipc        a0, 486993
                  addi         a3, a3, -1283
                  add          tp, a3, a3
                  add          tp, a3, a3
                  sub          s7, ra, a0
                  addi         a3, a3, -1283
                  add          tp, a3, a3
                  sub          s7, ra, a0
                  auipc        a0, 486993
                  auipc        a0, 486993
                  addi         a3, a3, -1283
                  add          tp, a3, a3
                  addi         a3, a3, -1283 #end riscv_int_numeric_corner_stream_5
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  nop
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  or           a2, t4, s10
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  nop
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  nop
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  sltiu        a3, s10, -817
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  nop
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  nop
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  sub          t4, t6, a0
                  nop
                  slt          ra, s3, tp
                  lui          a2, 357512
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  nop
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  nop
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  nop
                  srai         s8, gp, 6
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  xor          zero, a4, a1
                  addi         gp, s1, -1283
                  nop
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  lui          a2, 357512
                  slt          ra, s3, tp
                  lui          a2, 357512
                  slt          ra, s3, tp
                  lui          a2, 357512
                  auipc        a6, 486993
                  lui          a2, 357512
                  or           a2, t4, s10
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  srl          zero, s0, ra
                  or           a2, t4, s10
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  sub          t4, t6, a0
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  nop
                  and          t4, t4, s8
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  slti         s8, s6, 95
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  sub          t4, t6, a0
                  sltu         t6, ra, t6
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  nop
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  add          a0, gp, t4
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  nop
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  nop
                  nop
                  srli         s11, s10, 4
                  lui          a2, 357512
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  lui          a2, 357512
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  nop
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  nop
                  slti         s8, s6, 95
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  nop
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  srl          zero, s0, ra
                  ori          t3, a2, 308
                  nop
                  nop
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  nop
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  auipc        a6, 486993
                  and          t4, t4, s8
                  or           a2, t4, s10
                  slli         t0, s3, 26
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  and          t4, t4, s8
                  lui          a2, 357512
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  nop
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  slli         t0, s3, 26
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  lui          a2, 357512
                  and          t4, t4, s8
                  nop
                  srli         s11, s10, 4
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  nop
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  ori          t3, a2, 308
                  auipc        a6, 486993
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  addi         gp, s1, -1283
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  or           a2, t4, s10
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  nop
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  srli         s11, s10, 4
                  sltu         t6, ra, t6
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  or           a2, t4, s10
                  and          t4, t4, s8
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  auipc        a6, 486993
                  nop
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  lui          a2, 357512
                  lui          a2, 357512
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  sub          t4, t6, a0
                  sra          gp, a1, s7
                  lui          a2, 357512
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  and          t4, t4, s8
                  srai         s8, gp, 6
                  slt          ra, s3, tp
                  nop
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  or           a2, t4, s10
                  nop
                  nop
                  nop
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  nop
                  slti         s8, s6, 95
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  lui          a2, 357512
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  xor          zero, a4, a1
                  nop
                  sra          gp, a1, s7
                  andi         t1, s7, -636
                  nop
                  and          t4, t4, s8
                  nop
                  or           a2, t4, s10
                  sub          t4, t6, a0
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  and          t4, t4, s8
                  nop
                  add          a0, gp, t4
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  nop
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  nop
                  nop
                  nop
                  srli         s11, s10, 4
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  addi         gp, s1, -1283
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  addi         gp, s1, -1283
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  lui          a2, 357512
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  lui          a2, 357512
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  slt          ra, s3, tp
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  xor          zero, a4, a1
                  sltu         t6, ra, t6
                  nop
                  sll          t3, zero, s11
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  andi         t1, s7, -636
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_3
                  li           t1, 0x0
                  li           t2, 0x80000000
                  li           gp, 0x0
                  li           s4, 0x1cef148d
                  li           ra, 0x80000000
                  li           a0, 0xffffffff
                  li           s5, 0x0
                  li           a5, 0x0
                  li           s1, 0x0
                  nop
                  auipc        a0, 486993
                  lui          t3, 357512
                  lui          t3, 357512
                  lui          t3, 357512
                  lui          t3, 357512
                  sub          a0, ra, a0
                  nop
                  nop
                  add          t1, ra, a5
                  addi         a5, s1, -1283
                  add          t1, ra, a5
                  sub          a0, ra, a0
                  add          t1, ra, a5
                  auipc        a0, 486993
                  sub          a0, ra, a0 #end riscv_int_numeric_corner_stream_3
                  add          a0, gp, t4
                  and          t4, t4, s8
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  nop
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  addi         gp, s1, -1283
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  nop
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  slti         s8, s6, 95
                  nop
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  add          a0, gp, t4
                  nop
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  slt          ra, s3, tp
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  andi         t1, s7, -636
                  nop
                  or           a2, t4, s10
                  nop
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  nop
                  and          t4, t4, s8
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  or           a2, t4, s10
                  andi         t1, s7, -636
                  slti         s8, s6, 95
                  lui          a2, 357512
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  auipc        a6, 486993
                  and          t4, t4, s8
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  xor          zero, a4, a1
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  add          a0, gp, t4
                  andi         t1, s7, -636
                  sra          gp, a1, s7
                  sltu         t6, ra, t6
                  auipc        a6, 486993
                  slti         s8, s6, 95
                  srl          zero, s0, ra
                  nop
                  or           a2, t4, s10
                  and          t4, t4, s8
                  sltu         t6, ra, t6
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  sll          t3, zero, s11
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  slti         s8, s6, 95
                  srai         s8, gp, 6
                  nop
                  or           a2, t4, s10
                  or           a2, t4, s10
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  sll          t3, zero, s11
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  xor          zero, a4, a1
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  slt          ra, s3, tp
                  sub          t4, t6, a0
                  nop
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  nop
                  or           a2, t4, s10
                  ori          t3, a2, 308
                  or           a2, t4, s10
                  and          t4, t4, s8
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  auipc        a6, 486993
                  or           a2, t4, s10
                  lui          a2, 357512
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  lui          a2, 357512
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  addi         gp, s1, -1283
                  sltiu        a3, s10, -817
                  nop
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  ori          t3, a2, 308
                  nop
                  slti         s8, s6, 95
                  andi         t1, s7, -636
                  slt          ra, s3, tp
                  slt          ra, s3, tp
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  nop
                  andi         t1, s7, -636
                  and          t4, t4, s8
                  nop
                  xor          zero, a4, a1
                  slti         s8, s6, 95
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  or           a2, t4, s10
                  srli         s11, s10, 4
                  slt          ra, s3, tp
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  auipc        a6, 486993
                  nop
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  lui          a2, 357512
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  sub          t4, t6, a0
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  srl          zero, s0, ra
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  srai         s8, gp, 6
                  nop
                  srl          zero, s0, ra
                  xori         zero, s3, -1338
                  slli         t0, s3, 26
                  nop
                  auipc        a6, 486993
                  and          t4, t4, s8
                  and          t4, t4, s8
                  xori         zero, s3, -1338
                  nop
                  ori          t3, a2, 308
                  sltiu        a3, s10, -817
                  sub          t4, t6, a0
                  add          a0, gp, t4
                  slli         t0, s3, 26
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  andi         t1, s7, -636
                  andi         t1, s7, -636
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  slli         t0, s3, 26
                  srai         s8, gp, 6
                  sub          t4, t6, a0
                  ori          t3, a2, 308
                  ori          t3, a2, 308
                  lui          a2, 357512
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  xor          zero, a4, a1
                  sltiu        a3, s10, -817
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  nop
                  slti         s8, s6, 95
                  sltiu        a3, s10, -817
                  slli         t0, s3, 26
                  slt          ra, s3, tp
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  nop
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  nop
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  slti         s8, s6, 95
                  slti         s8, s6, 95
                  add          a0, gp, t4
                  or           a2, t4, s10
                  nop
                  srli         s11, s10, 4
                  add          a0, gp, t4
                  srl          zero, s0, ra
                  lui          a2, 357512
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  sll          t3, zero, s11
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  sltu         t6, ra, t6
                  add          a0, gp, t4
                  sltu         t6, ra, t6
                  ori          t3, a2, 308
                  lui          a2, 357512
                  or           a2, t4, s10
                  lui          a2, 357512
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  lui          a2, 357512
                  nop
                  slt          ra, s3, tp
                  sll          t3, zero, s11
                  ori          t3, a2, 308
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  sltu         t6, ra, t6
                  or           a2, t4, s10
                  lui          a2, 357512
                  sra          gp, a1, s7
                  addi         gp, s1, -1283
                  andi         t1, s7, -636
                  srai         s8, gp, 6
                  and          t4, t4, s8
                  nop
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  srai         s8, gp, 6
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  addi         gp, s1, -1283
                  or           a2, t4, s10
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  nop
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  and          t4, t4, s8
                  sub          t4, t6, a0
                  srl          zero, s0, ra
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  nop
                  sll          t3, zero, s11
                  nop
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  slli         t0, s3, 26
                  srli         s11, s10, 4
                  ori          t3, a2, 308
                  lui          a2, 357512
                  and          t4, t4, s8
                  sll          t3, zero, s11
                  addi         gp, s1, -1283
                  ori          t3, a2, 308
                  xor          zero, a4, a1
                  nop
                  slt          ra, s3, tp
                  add          a0, gp, t4
                  and          t4, t4, s8
                  ori          t3, a2, 308
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  xori         zero, s3, -1338
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  sub          t4, t6, a0
                  srai         s8, gp, 6
                  addi         gp, s1, -1283
                  sra          gp, a1, s7
                  nop
                  slti         s8, s6, 95
                  nop
                  nop
                  nop
                  slli         t0, s3, 26
                  sub          t4, t6, a0
                  auipc        a6, 486993
                  slli         t0, s3, 26
                  lui          a2, 357512
                  nop
                  and          t4, t4, s8
                  auipc        a6, 486993
                  nop
                  nop
                  xor          zero, a4, a1
                  sll          t3, zero, s11
                  srl          zero, s0, ra
                  sub          t4, t6, a0
                  xori         zero, s3, -1338
                  lui          a2, 357512
                  lui          a2, 357512
                  addi         gp, s1, -1283
                  and          t4, t4, s8
                  nop
                  sra          gp, a1, s7
                  and          t4, t4, s8
                  sltiu        a3, s10, -817
                  sra          gp, a1, s7
                  nop
                  slli         t0, s3, 26
                  slli         t0, s3, 26
                  add          a0, gp, t4
                  sub          t4, t6, a0
                  xor          zero, a4, a1
                  add          a0, gp, t4
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  slti         s8, s6, 95
                  lui          a2, 357512
                  sltu         t6, ra, t6
                  andi         t1, s7, -636
                  add          a0, gp, t4
                  xori         zero, s3, -1338
                  sltu         t6, ra, t6
                  slt          ra, s3, tp
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  srl          zero, s0, ra
                  srli         s11, s10, 4
                  andi         t1, s7, -636
                  srl          zero, s0, ra
                  and          t4, t4, s8
                  lui          a2, 357512
                  auipc        a6, 486993
                  srl          zero, s0, ra
                  xor          zero, a4, a1
                  auipc        a6, 486993
                  sra          gp, a1, s7
                  nop
                  lui          a2, 357512
                  slt          ra, s3, tp
                  nop
                  sll          t3, zero, s11
                  and          t4, t4, s8
                  sra          gp, a1, s7
                  sltiu        a3, s10, -817
                  nop
                  sub          t4, t6, a0
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  or           a2, t4, s10
                  srai         s8, gp, 6
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  srli         s11, s10, 4
                  sra          gp, a1, s7
                  srai         s8, gp, 6
                  sll          t3, zero, s11
                  nop
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  sra          gp, a1, s7
                  srli         s11, s10, 4
                  auipc        a6, 486993
                  ori          t3, a2, 308
                  sra          gp, a1, s7
                  or           a2, t4, s10
                  lui          a2, 357512
                  srli         s11, s10, 4
                  srli         s11, s10, 4
                  nop
                  lui          a2, 357512
                  sra          gp, a1, s7
                  sra          gp, a1, s7
                  xori         zero, s3, -1338
                  srai         s8, gp, 6
                  or           a2, t4, s10
                  sltu         t6, ra, t6
                  sra          gp, a1, s7
                  ori          t3, a2, 308
                  add          a0, gp, t4
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  auipc        a6, 486993
                  srai         s8, gp, 6
                  auipc        a6, 486993
                  srli         s11, s10, 4
                  srai         s8, gp, 6
                  slti         s8, s6, 95
                  or           a2, t4, s10
                  nop
                  lui          a2, 357512
                  andi         t1, s7, -636
                  auipc        a6, 486993
                  sltiu        a3, s10, -817
                  slti         s8, s6, 95
                  addi         gp, s1, -1283
                  sll          t3, zero, s11
                  sltiu        a3, s10, -817
                  sltiu        a3, s10, -817
                  lui          a2, 357512
                  slt          ra, s3, tp
                  srl          zero, s0, ra
                  la x18, test_done
                  jalr x0, x18, 0
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
                  addi x8, x8, -4
                  sw  x2, (x8)
                  add x2, x8, zero
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
                  add x8, x2, zero
                  csrr x13, 0x300 # MSTATUS
                  csrr x13, 0x342 # MCAUSE
                  srli x13, x13, 31
                  bne x13, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x13, 0x341 # MEPC
                  csrr x13, 0x342 # MCAUSE
                  li x12, 0x3 # BREAKPOINT
                  beq x13, x12, ebreak_handler
                  li x12, 0x8 # ECALL_UMODE
                  beq x13, x12, ecall_handler
                  li x12, 0x9 # ECALL_SMODE
                  beq x13, x12, ecall_handler
                  li x12, 0xb # ECALL_MMODE
                  beq x13, x12, ecall_handler
                  li x12, 0x1
                  beq x13, x12, instr_fault_handler
                  li x12, 0x5
                  beq x13, x12, load_fault_handler
                  li x12, 0x7
                  beq x13, x12, store_fault_handler
                  li x12, 0xc
                  beq x13, x12, pt_fault_handler
                  li x12, 0xd
                  beq x13, x12, pt_fault_handler
                  li x12, 0xf
                  beq x13, x12, pt_fault_handler
                  li x12, 0x2 # ILLEGAL_INSTRUCTION
                  beq x13, x12, illegal_instr_handler
                  csrr x12, 0x343 # MTVAL
                  1: la x18, test_done
                  jalr x1, x18, 0

ecall_handler:    
                  la x13, _start
                  sw x0, 0(x13)
                  sw x1, 4(x13)
                  sw x2, 8(x13)
                  sw x3, 12(x13)
                  sw x4, 16(x13)
                  sw x5, 20(x13)
                  sw x6, 24(x13)
                  sw x7, 28(x13)
                  sw x8, 32(x13)
                  sw x9, 36(x13)
                  sw x10, 40(x13)
                  sw x11, 44(x13)
                  sw x12, 48(x13)
                  sw x13, 52(x13)
                  sw x14, 56(x13)
                  sw x15, 60(x13)
                  sw x16, 64(x13)
                  sw x17, 68(x13)
                  sw x18, 72(x13)
                  sw x19, 76(x13)
                  sw x20, 80(x13)
                  sw x21, 84(x13)
                  sw x22, 88(x13)
                  sw x23, 92(x13)
                  sw x24, 96(x13)
                  sw x25, 100(x13)
                  sw x26, 104(x13)
                  sw x27, 108(x13)
                  sw x28, 112(x13)
                  sw x29, 116(x13)
                  sw x30, 120(x13)
                  sw x31, 124(x13)
                  la x18, write_tohost
                  jalr x0, x18, 0

instr_fault_handler:
                  add x2, x8, zero
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
                  add x8, x2, zero
                  lw  x2, (x8)
                  addi x8, x8, 4
                  mret

load_fault_handler:
                  add x2, x8, zero
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
                  add x8, x2, zero
                  lw  x2, (x8)
                  addi x8, x8, 4
                  mret

store_fault_handler:
                  add x2, x8, zero
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
                  add x8, x2, zero
                  lw  x2, (x8)
                  addi x8, x8, 4
                  mret

ebreak_handler:   
                  csrr  x13, 0x341
                  addi  x13, x13, 4
                  csrw  0x341, x13
                  add x2, x8, zero
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
                  add x8, x2, zero
                  lw  x2, (x8)
                  addi x8, x8, 4
                  mret

illegal_instr_handler:
                  csrr  x13, 0x341
                  addi  x13, x13, 4
                  csrw  0x341, x13
                  add x2, x8, zero
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
                  add x8, x2, zero
                  lw  x2, (x8)
                  addi x8, x8, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x13, 0x300 # MSTATUS;
                  csrr  x13, 0x304 # MIE;
                  csrr  x13, 0x344 # MIP;
                  csrrc x13, 0x344, x13 # MIP;
                  add x2, x8, zero
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
                  add x8, x2, zero
                  lw  x2, (x8)
                  addi x8, x8, 4
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
