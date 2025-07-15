.include "user_define.h"
.globl _start
.section .text
.option norvc;
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x28, h0_start
jalr x0, x28, 0
h0_start:
                  li x7, 0x40000100
                  csrw 0x301, x7
kernel_sp:        
                  la x17, kernel_stack_end

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
                  li x0, 0xc2f7a216
                  li x1, 0x80000000
                  li x2, 0x0
                  li x3, 0xb3cda32e
                  li x4, 0x2
                  li x6, 0x6a7ab29e
                  li x7, 0x4b77fa5e
                  li x8, 0xf357a8a2
                  li x9, 0x6765c383
                  li x10, 0x475f34e1
                  li x11, 0x8271e618
                  li x12, 0x0
                  li x13, 0x80000000
                  li x14, 0x0
                  li x15, 0x1
                  li x16, 0x9
                  li x18, 0x80000000
                  li x19, 0xf1e4f354
                  li x20, 0xf34ab172
                  li x21, 0xfcdd7bf9
                  li x22, 0x80000000
                  li x23, 0x0
                  li x24, 0x9
                  li x25, 0xe
                  li x26, 0x80000000
                  li x27, 0x80000000
                  li x28, 0x0
                  li x29, 0xf323f5f6
                  li x30, 0x80000000
                  li x31, 0x1a675354
                  la x5, user_stack_end
main:             li           s7, 0x0 #start riscv_int_numeric_corner_stream_11
                  li           s0, 0xffffffff
                  li           a5, 0x7a46c1e
                  li           a0, 0x0
                  li           t1, 0xffffffff
                  li           t4, 0x80000000
                  li           s10, 0xffffffff
                  li           s9, 0x0
                  li           s5, 0x0
                  li           a3, 0x7e5c7458
                  addi         t1, s10, -705
                  sub          a3, s5, t1
                  sub          a3, s5, t1
                  sub          a3, s5, t1
                  nop
                  nop
                  add          s9, s0, s10
                  add          s9, s0, s10
                  addi         t1, s10, -705
                  add          s9, s0, s10
                  sub          a3, s5, t1
                  addi         t1, s10, -705
                  lui          s10, 548299
                  nop
                  add          s9, s0, s10
                  add          s9, s0, s10
                  sub          a3, s5, t1
                  add          s9, s0, s10
                  addi         t1, s10, -705
                  lui          s10, 548299
                  nop
                  lui          s10, 548299
                  lui          s10, 548299
                  add          s9, s0, s10
                  nop #end riscv_int_numeric_corner_stream_11
                  li           sp, 0xffffffff #start riscv_int_numeric_corner_stream_16
                  li           s1, 0x0
                  li           t1, 0xffffffff
                  li           s7, 0xffffffff
                  li           s4, 0x2b43385b
                  li           t4, 0x0
                  li           s5, 0x0
                  li           s9, 0x0
                  li           a4, 0xb2bd4481
                  li           ra, 0x80000000
                  auipc        sp, 513052
                  add          s9, s9, s4
                  lui          s7, 548299
                  lui          s7, 548299
                  add          s9, s9, s4
                  nop
                  auipc        sp, 513052
                  nop
                  addi         ra, s7, -705
                  sub          t4, s7, t1
                  sub          t4, s7, t1
                  auipc        sp, 513052
                  add          s9, s9, s4
                  add          s9, s9, s4
                  nop
                  sub          t4, s7, t1
                  auipc        sp, 513052
                  nop
                  auipc        sp, 513052
                  nop
                  addi         ra, s7, -705
                  lui          s7, 548299 #end riscv_int_numeric_corner_stream_16
                  li           s3, 0xffffffff #start riscv_int_numeric_corner_stream_0
                  li           t5, 0x2e70c878
                  li           s8, 0x0
                  li           s7, 0xffffffff
                  li           t6, 0x80000000
                  li           s0, 0xb578f8fd
                  li           s11, 0x0
                  li           a6, 0x0
                  li           s6, 0x0
                  li           t2, 0xffffffff
                  auipc        s0, 513052
                  addi         t6, s11, -705
                  add          s0, t5, s8
                  auipc        s0, 513052
                  lui          t5, 548299
                  nop
                  lui          t5, 548299
                  lui          t5, 548299
                  addi         t6, s11, -705
                  sub          a6, a6, t2
                  sub          a6, a6, t2
                  addi         t6, s11, -705
                  add          s0, t5, s8
                  addi         t6, s11, -705
                  auipc        s0, 513052
                  addi         t6, s11, -705
                  lui          t5, 548299
                  addi         t6, s11, -705
                  addi         t6, s11, -705
                  sub          a6, a6, t2
                  lui          t5, 548299
                  nop
                  sub          a6, a6, t2
                  sub          a6, a6, t2
                  nop #end riscv_int_numeric_corner_stream_0
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_36
                  li           s8, 0x7a7744b2
                  li           a5, 0xffffffff
                  li           a6, 0x0
                  li           s5, 0x80000000
                  li           s9, 0xf50e7e67
                  li           a0, 0x0
                  li           s10, 0x80000000
                  li           s11, 0x80000000
                  li           ra, 0x80000000
                  lui          a5, 548299
                  auipc        tp, 513052
                  lui          a5, 548299
                  addi         tp, s10, -705
                  lui          a5, 548299
                  add          s10, a6, a6
                  auipc        tp, 513052
                  sub          s8, ra, a0
                  add          s10, a6, a6
                  auipc        tp, 513052
                  nop
                  addi         tp, s10, -705
                  addi         tp, s10, -705
                  auipc        tp, 513052
                  lui          a5, 548299
                  addi         tp, s10, -705
                  auipc        tp, 513052
                  lui          a5, 548299
                  sub          s8, ra, a0
                  addi         tp, s10, -705
                  add          s10, a6, a6 #end riscv_int_numeric_corner_stream_36
                  li           s9, 0xe5ad5535 #start riscv_int_numeric_corner_stream_4
                  li           a3, 0x0
                  li           s2, 0x0
                  li           a5, 0xffffffff
                  li           t4, 0x64379fb0
                  li           tp, 0x0
                  li           s1, 0xffffffff
                  li           s10, 0x0
                  li           gp, 0x0
                  li           s7, 0x80000000
                  auipc        tp, 513052
                  auipc        tp, 513052
                  add          s1, tp, s2
                  addi         a3, s10, -705
                  add          s1, tp, s2
                  add          s1, tp, s2
                  lui          s10, 548299
                  auipc        tp, 513052
                  addi         a3, s10, -705
                  nop
                  sub          tp, tp, gp
                  nop
                  lui          s10, 548299
                  addi         a3, s10, -705
                  nop
                  auipc        tp, 513052
                  addi         a3, s10, -705
                  nop
                  add          s1, tp, s2
                  nop
                  nop
                  sub          tp, tp, gp #end riscv_int_numeric_corner_stream_4
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_10
                  li           tp, 0x7e6e2542
                  li           s0, 0xc9a9f6bb
                  li           s9, 0x0
                  li           sp, 0xffffffff
                  li           t6, 0x0
                  li           ra, 0x80000000
                  li           a6, 0x0
                  li           a4, 0x0
                  li           s8, 0x74ac728a
                  add          gp, a6, a6
                  add          gp, a6, a6
                  sub          a4, a6, sp
                  addi         ra, t6, -705
                  add          gp, a6, a6
                  addi         ra, t6, -705
                  add          gp, a6, a6
                  sub          a4, a6, sp
                  add          gp, a6, a6
                  lui          t6, 548299
                  auipc        s0, 513052
                  auipc        s0, 513052
                  add          gp, a6, a6
                  addi         ra, t6, -705
                  lui          t6, 548299
                  addi         ra, t6, -705 #end riscv_int_numeric_corner_stream_10
                  li           gp, 0x80000000 #start riscv_int_numeric_corner_stream_25
                  li           s8, 0x80000000
                  li           s6, 0x0
                  li           a6, 0x80000000
                  li           s5, 0x0
                  li           a1, 0xcda21e11
                  li           tp, 0xffffffff
                  li           sp, 0x80000000
                  li           t2, 0x0
                  li           t6, 0x80000000
                  nop
                  add          gp, s8, s8
                  add          gp, s8, s8
                  add          gp, s8, s8
                  lui          s6, 548299
                  nop
                  nop
                  lui          s6, 548299
                  sub          a1, s6, t2
                  auipc        sp, 513052
                  sub          a1, s6, t2
                  lui          s6, 548299
                  auipc        sp, 513052
                  sub          a1, s6, t2
                  sub          a1, s6, t2 #end riscv_int_numeric_corner_stream_25
                  li           ra, 0x0 #start riscv_int_numeric_corner_stream_34
                  li           s8, 0x5687ae71
                  li           s0, 0xffffffff
                  li           t2, 0x7fd235a3
                  li           s2, 0x0
                  li           s6, 0x80000000
                  li           gp, 0x0
                  li           sp, 0xffffffff
                  li           s4, 0xfea6d82c
                  li           s11, 0xffffffff
                  nop
                  auipc        sp, 513052
                  addi         s11, s11, -705
                  nop
                  auipc        sp, 513052
                  nop
                  addi         s11, s11, -705
                  sub          s11, t2, t2
                  nop
                  add          gp, s8, s4
                  lui          s6, 548299
                  auipc        sp, 513052
                  addi         s11, s11, -705
                  auipc        sp, 513052
                  auipc        sp, 513052 #end riscv_int_numeric_corner_stream_34
                  li           a2, 0x0 #start riscv_int_numeric_corner_stream_38
                  li           s5, 0xffffffff
                  li           a6, 0x1840b256
                  li           ra, 0x8f5dc3d3
                  li           t2, 0xffffffff
                  li           a3, 0x80000000
                  li           s4, 0x80000000
                  li           s2, 0x80000000
                  li           s10, 0x80000000
                  li           t1, 0x0
                  nop
                  auipc        t1, 513052
                  auipc        t1, 513052
                  nop
                  nop
                  sub          a2, t2, t2
                  lui          s2, 548299
                  auipc        t1, 513052
                  auipc        t1, 513052
                  lui          s2, 548299
                  nop
                  lui          s2, 548299
                  add          ra, s10, s4
                  nop
                  lui          s2, 548299
                  add          ra, s10, s4
                  sub          a2, t2, t2
                  lui          s2, 548299
                  lui          s2, 548299
                  nop
                  auipc        t1, 513052
                  sub          a2, t2, t2
                  addi         s4, s2, -705
                  addi         s4, s2, -705
                  nop
                  add          ra, s10, s4
                  auipc        t1, 513052
                  auipc        t1, 513052
                  nop #end riscv_int_numeric_corner_stream_38
                  li           s6, 0x80000000 #start riscv_int_numeric_corner_stream_33
                  li           t4, 0x0
                  li           t6, 0xf03036fa
                  li           a3, 0x80000000
                  li           a6, 0x7b375ad
                  li           tp, 0x80000000
                  li           a4, 0x80000000
                  li           a0, 0x2c2a109b
                  li           t2, 0x8a0c0ee4
                  li           s5, 0xffffffff
                  sub          t4, a6, t2
                  addi         tp, s6, -705
                  addi         tp, s6, -705
                  add          t2, a6, a6
                  auipc        tp, 513052
                  auipc        tp, 513052
                  nop
                  auipc        tp, 513052
                  auipc        tp, 513052
                  addi         tp, s6, -705
                  auipc        tp, 513052
                  nop
                  sub          t4, a6, t2
                  addi         tp, s6, -705
                  auipc        tp, 513052
                  addi         tp, s6, -705
                  sub          t4, a6, t2
                  auipc        tp, 513052 #end riscv_int_numeric_corner_stream_33
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_17
                  li           a3, 0x80000000
                  li           tp, 0x6f8ccb50
                  li           s9, 0x0
                  li           t6, 0xffffffff
                  li           t4, 0x80000000
                  li           a6, 0x7dd2bf7a
                  li           s11, 0x7e777053
                  li           s4, 0x0
                  li           s0, 0x80000000
                  addi         a6, t6, -705
                  auipc        s0, 513052
                  lui          t6, 548299
                  nop
                  add          s11, tp, a6
                  sub          a3, s11, s11
                  auipc        s0, 513052
                  add          s11, tp, a6
                  nop
                  lui          t6, 548299
                  lui          t6, 548299
                  sub          a3, s11, s11
                  addi         a6, t6, -705
                  sub          a3, s11, s11
                  auipc        s0, 513052
                  nop
                  sub          a3, s11, s11
                  nop #end riscv_int_numeric_corner_stream_17
                  li           s4, 0xffffffff #start riscv_int_numeric_corner_stream_39
                  li           t4, 0xffffffff
                  li           s7, 0xb42a7975
                  li           s9, 0xffffffff
                  li           a3, 0x0
                  li           a6, 0x0
                  li           s1, 0xffffffff
                  li           s5, 0x80000000
                  li           ra, 0xffffffff
                  li           s0, 0x80000000
                  nop
                  auipc        s0, 513052
                  auipc        s0, 513052
                  add          a6, a6, a6
                  auipc        s0, 513052
                  addi         s7, s7, -705
                  add          a6, a6, a6
                  auipc        s0, 513052
                  auipc        s0, 513052
                  sub          a6, s7, s7
                  nop
                  auipc        s0, 513052
                  sub          a6, s7, s7
                  lui          s7, 548299
                  add          a6, a6, a6
                  auipc        s0, 513052
                  sub          a6, s7, s7
                  add          a6, a6, a6
                  addi         s7, s7, -705
                  auipc        s0, 513052
                  sub          a6, s7, s7
                  auipc        s0, 513052
                  nop
                  nop #end riscv_int_numeric_corner_stream_39
                  li           t1, 0x80000000 #start riscv_int_numeric_corner_stream_14
                  li           sp, 0x448dec4
                  li           t2, 0x0
                  li           gp, 0x0
                  li           ra, 0xffffffff
                  li           a0, 0x0
                  li           s3, 0xffffffff
                  li           s7, 0xffffffff
                  li           s10, 0x0
                  li           a2, 0x80000000
                  add          s7, ra, s10
                  add          s7, ra, s10
                  sub          a0, a2, t2
                  addi         a2, s10, -705
                  addi         a2, s10, -705
                  addi         a2, s10, -705
                  add          s7, ra, s10
                  nop
                  sub          a0, a2, t2
                  nop
                  lui          s10, 548299
                  sub          a0, a2, t2
                  sub          a0, a2, t2
                  sub          a0, a2, t2
                  nop
                  auipc        a2, 513052
                  addi         a2, s10, -705
                  nop
                  add          s7, ra, s10
                  lui          s10, 548299
                  lui          s10, 548299 #end riscv_int_numeric_corner_stream_14
                  li           gp, 0x38c25509 #start riscv_int_numeric_corner_stream_18
                  li           a2, 0x80000000
                  li           s10, 0xcce48cc3
                  li           tp, 0xca9684f5
                  li           s2, 0xffffffff
                  li           t1, 0x80000000
                  li           t4, 0xffffffff
                  li           s6, 0x80000000
                  li           s5, 0xc9ffbe3e
                  li           sp, 0x0
                  lui          s10, 548299
                  addi         t4, s10, -705
                  auipc        tp, 513052
                  lui          s10, 548299
                  add          s10, s10, s6
                  add          s10, s10, s6
                  sub          a2, t1, t1
                  lui          s10, 548299
                  nop
                  lui          s10, 548299
                  add          s10, s10, s6
                  add          s10, s10, s6
                  lui          s10, 548299
                  addi         t4, s10, -705
                  sub          a2, t1, t1
                  addi         t4, s10, -705
                  lui          s10, 548299
                  auipc        tp, 513052
                  addi         t4, s10, -705
                  addi         t4, s10, -705
                  nop
                  auipc        tp, 513052
                  lui          s10, 548299
                  sub          a2, t1, t1
                  sub          a2, t1, t1
                  nop
                  addi         t4, s10, -705
                  nop
                  add          s10, s10, s6
                  sub          a2, t1, t1 #end riscv_int_numeric_corner_stream_18
                  li           s11, 0x80000000 #start riscv_int_numeric_corner_stream_9
                  li           s6, 0x80000000
                  li           ra, 0x721fa188
                  li           tp, 0xffffffff
                  li           a5, 0x6293aa0c
                  li           s9, 0x11b41b36
                  li           gp, 0xffffffff
                  li           a6, 0x0
                  li           t5, 0x80000000
                  li           s4, 0xd5316b6d
                  auipc        tp, 513052
                  nop
                  lui          t5, 548299
                  addi         tp, s11, -705
                  nop
                  auipc        tp, 513052
                  lui          t5, 548299
                  nop
                  sub          s9, a6, gp
                  add          gp, t5, s4
                  sub          s9, a6, gp
                  sub          s9, a6, gp
                  nop
                  lui          t5, 548299
                  lui          t5, 548299 #end riscv_int_numeric_corner_stream_9
                  li           a4, 0x80000000 #start riscv_int_numeric_corner_stream_35
                  li           t2, 0xffffffff
                  li           tp, 0xffffffff
                  li           a0, 0x0
                  li           a5, 0xa7462171
                  li           s8, 0x1de8088d
                  li           gp, 0x0
                  li           t6, 0x80000000
                  li           sp, 0xffffffff
                  li           t1, 0xffffffff
                  addi         gp, t6, -705
                  add          t6, s8, s8
                  auipc        tp, 513052
                  lui          t6, 548299
                  auipc        tp, 513052
                  lui          t6, 548299
                  lui          t6, 548299
                  nop
                  nop
                  sub          t6, t6, t1
                  lui          t6, 548299
                  add          t6, s8, s8
                  addi         gp, t6, -705
                  addi         gp, t6, -705
                  add          t6, s8, s8
                  add          t6, s8, s8
                  addi         gp, t6, -705
                  sub          t6, t6, t1
                  nop
                  sub          t6, t6, t1 #end riscv_int_numeric_corner_stream_35
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_2
                  li           a0, 0x0
                  li           s11, 0x80000000
                  li           a2, 0x80000000
                  li           a1, 0x80000000
                  li           s8, 0x0
                  li           a5, 0xffffffff
                  li           a4, 0xffffffff
                  li           s3, 0xffffffff
                  li           s5, 0xea49ff70
                  add          s11, s5, s8
                  lui          t5, 548299
                  sub          a2, a1, s3
                  sub          a2, a1, s3
                  nop
                  nop
                  addi         a5, s11, -705
                  auipc        a0, 513052
                  addi         a5, s11, -705
                  add          s11, s5, s8
                  sub          a2, a1, s3
                  add          s11, s5, s8
                  nop
                  sub          a2, a1, s3
                  auipc        a0, 513052 #end riscv_int_numeric_corner_stream_2
                  li           a4, 0xffffffff #start riscv_int_numeric_corner_stream_3
                  li           tp, 0xffffffff
                  li           t2, 0x0
                  li           a5, 0x80000000
                  li           s2, 0x80000000
                  li           s5, 0xffffffff
                  li           a3, 0xffffffff
                  li           t1, 0x0
                  li           t5, 0xffffffff
                  li           s11, 0x0
                  auipc        tp, 513052
                  addi         a3, s11, -705
                  lui          t5, 548299
                  auipc        tp, 513052
                  add          t2, tp, s2
                  lui          t5, 548299
                  lui          t5, 548299
                  auipc        tp, 513052
                  lui          t5, 548299
                  lui          t5, 548299
                  add          t2, tp, s2
                  lui          t5, 548299
                  nop
                  sub          a3, t5, t2
                  auipc        tp, 513052 #end riscv_int_numeric_corner_stream_3
                  li           gp, 0x80000000 #start riscv_int_numeric_corner_stream_28
                  li           ra, 0x80000000
                  li           s2, 0x0
                  li           s11, 0xffffffff
                  li           a4, 0x15a24579
                  li           s3, 0x0
                  li           s10, 0x0
                  li           s6, 0xffffffff
                  li           a3, 0x0
                  li           t1, 0x80000000
                  lui          s6, 548299
                  nop
                  add          s3, s6, s10
                  addi         s11, s10, -705
                  add          s3, s6, s10
                  nop
                  nop
                  sub          a4, s6, t1
                  auipc        s2, 513052
                  auipc        s2, 513052
                  add          s3, s6, s10
                  add          s3, s6, s10
                  auipc        s2, 513052
                  sub          a4, s6, t1
                  nop
                  lui          s6, 548299
                  addi         s11, s10, -705 #end riscv_int_numeric_corner_stream_28
                  li           s4, 0xffffffff #start riscv_int_numeric_corner_stream_7
                  li           t4, 0x80000000
                  li           t2, 0xefe111b3
                  li           a3, 0xbb0016bd
                  li           t6, 0xffffffff
                  li           a4, 0x80000000
                  li           s9, 0xffffffff
                  li           sp, 0xffffffff
                  li           tp, 0x0
                  li           s6, 0x80000000
                  nop
                  add          t2, tp, s4
                  addi         tp, s6, -705
                  auipc        tp, 513052
                  auipc        tp, 513052
                  sub          s9, s6, t2
                  auipc        tp, 513052
                  add          t2, tp, s4
                  auipc        tp, 513052
                  auipc        tp, 513052
                  nop
                  auipc        tp, 513052
                  auipc        tp, 513052
                  addi         tp, s6, -705
                  sub          s9, s6, t2
                  sub          s9, s6, t2
                  nop
                  add          t2, tp, s4
                  addi         tp, s6, -705
                  nop
                  lui          s6, 548299 #end riscv_int_numeric_corner_stream_7
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  li           t6, 0x154074e5 #start riscv_int_numeric_corner_stream_27
                  li           s0, 0x65bd70b9
                  li           a3, 0x0
                  li           s5, 0x80000000
                  li           s7, 0x80000000
                  li           a5, 0x0
                  li           ra, 0x0
                  li           a0, 0xffffffff
                  li           a2, 0xe9529ba9
                  li           s1, 0x0
                  sub          s5, a0, s7
                  auipc        s0, 513052
                  nop
                  lui          s7, 548299
                  sub          s5, a0, s7
                  nop
                  auipc        s0, 513052
                  addi         ra, s7, -705
                  nop
                  nop
                  addi         ra, s7, -705
                  addi         ra, s7, -705
                  add          s7, s1, a2
                  sub          s5, a0, s7
                  auipc        s0, 513052
                  nop
                  nop
                  add          s7, s1, a2
                  add          s7, s1, a2
                  add          s7, s1, a2
                  sub          s5, a0, s7
                  auipc        s0, 513052
                  nop
                  sub          s5, a0, s7
                  lui          s7, 548299
                  lui          s7, 548299
                  lui          s7, 548299
                  auipc        s0, 513052
                  sub          s5, a0, s7
                  lui          s7, 548299 #end riscv_int_numeric_corner_stream_27
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  nop
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  nop
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  nop
                  sra          s10, t5, s8
                  lui          t5, 548299
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  nop
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  lui          t5, 548299
                  lui          t5, 548299
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  lui          t5, 548299
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  nop
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  lui          t5, 548299
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  nop
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  nop
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  lui          t5, 548299
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  li           s0, 0x5c84a08d #start riscv_int_numeric_corner_stream_5
                  li           s10, 0x83a543ed
                  li           a6, 0xdd6ca1f5
                  li           s8, 0xffffffff
                  li           s5, 0x80000000
                  li           ra, 0x80000000
                  li           s7, 0x80000000
                  li           s2, 0x0
                  li           a4, 0xffffffff
                  li           s11, 0x0
                  lui          s10, 548299
                  add          s2, s10, s2
                  lui          s10, 548299
                  add          s2, s10, s2
                  sub          s8, a6, s2
                  lui          s10, 548299
                  lui          s10, 548299
                  addi         s11, s10, -705
                  sub          s8, a6, s2
                  addi         s11, s10, -705
                  addi         s11, s10, -705
                  addi         s11, s10, -705
                  addi         s11, s10, -705
                  add          s2, s10, s2
                  nop #end riscv_int_numeric_corner_stream_5
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  and          ra, a2, s11
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  nop
                  xor          sp, t6, s0
                  lui          t5, 548299
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  lui          t5, 548299
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  nop
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  lui          t5, 548299
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  nop
                  slti         a6, s1, 668
                  lui          t5, 548299
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  lui          t5, 548299
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  auipc        zero, 513052
                  and          ra, a2, s11
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  and          ra, a2, s11
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  nop
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  nop
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  lui          t5, 548299
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  nop
                  or           a0, zero, t6
                  nop
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  nop
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  nop
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  auipc        zero, 513052
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  lui          t5, 548299
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  nop
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  lui          t5, 548299
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  nop
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  lui          t5, 548299
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  lui          t5, 548299
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  lui          t5, 548299
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  auipc        zero, 513052
                  lui          t5, 548299
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  nop
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  lui          t5, 548299
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  lui          t5, 548299
                  srli         sp, a6, 6
                  lui          t5, 548299
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  lui          t5, 548299
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  nop
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  nop
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  lui          t5, 548299
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  nop
                  and          ra, a2, s11
                  nop
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  nop
                  addi         t6, s10, -705
                  nop
                  lui          t5, 548299
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  nop
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  nop
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  nop
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  lui          t5, 548299
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  nop
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  lui          t5, 548299
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  nop
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  lui          t5, 548299
                  lui          t5, 548299
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  nop
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  nop
                  nop
                  slti         a6, s1, 668
                  lui          t5, 548299
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  auipc        zero, 513052
                  lui          t5, 548299
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  lui          t5, 548299
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  nop
                  srl          s11, s2, a4
                  nop
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  lui          t5, 548299
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  nop
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  nop
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  nop
                  sltiu        s6, s0, -690
                  nop
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  nop
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  nop
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  auipc        zero, 513052
                  nop
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  or           a0, zero, t6
                  nop
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  lui          t5, 548299
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  nop
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  nop
                  li           t4, 0xa4a7160 #start riscv_int_numeric_corner_stream_32
                  li           a1, 0x0
                  li           sp, 0x74be53a6
                  li           ra, 0x80000000
                  li           s5, 0xffffffff
                  li           s2, 0xb211ea4d
                  li           tp, 0xffffffff
                  li           t2, 0x0
                  li           a6, 0x0
                  li           s11, 0xffffffff
                  sub          tp, t2, t2
                  lui          s2, 548299
                  sub          tp, t2, t2
                  sub          tp, t2, t2
                  add          ra, a6, a6
                  auipc        sp, 513052
                  add          ra, a6, a6
                  auipc        sp, 513052
                  sub          tp, t2, t2
                  sub          tp, t2, t2
                  auipc        sp, 513052
                  add          ra, a6, a6
                  add          ra, a6, a6
                  add          ra, a6, a6
                  auipc        sp, 513052
                  sub          tp, t2, t2
                  auipc        sp, 513052
                  addi         tp, s2, -705
                  lui          s2, 548299
                  lui          s2, 548299
                  add          ra, a6, a6
                  addi         tp, s2, -705
                  addi         tp, s2, -705
                  add          ra, a6, a6
                  auipc        sp, 513052
                  add          ra, a6, a6
                  sub          tp, t2, t2
                  nop
                  addi         tp, s2, -705
                  nop #end riscv_int_numeric_corner_stream_32
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  nop
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  lui          t5, 548299
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  nop
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  and          ra, a2, s11
                  lui          t5, 548299
                  xor          sp, t6, s0
                  nop
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  lui          t5, 548299
                  lui          t5, 548299
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  nop
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  nop
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  lui          t5, 548299
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  nop
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  nop
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  nop
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  or           a0, zero, t6
                  nop
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  nop
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  lui          t5, 548299
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  nop
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  nop
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  nop
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  or           a0, zero, t6
                  add          a5, s6, t3
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  nop
                  sra          s10, t5, s8
                  nop
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  or           a0, zero, t6
                  nop
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  lui          t5, 548299
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  lui          t5, 548299
                  srai         a3, a2, 3
                  nop
                  srl          s11, s2, a4
                  lui          t5, 548299
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  nop
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  li           s6, 0x2c773bc3 #start riscv_int_numeric_corner_stream_21
                  li           s4, 0xffffffff
                  li           s0, 0x80000000
                  li           a3, 0x80000000
                  li           s1, 0xd4d082da
                  li           gp, 0xffffffff
                  li           t1, 0xfd46ea6
                  li           a4, 0x0
                  li           a2, 0x80000000
                  li           a1, 0xddbe9607
                  auipc        s0, 513052
                  sub          a4, s6, t1
                  add          a1, s4, s4
                  sub          a4, s6, t1
                  add          a1, s4, s4
                  addi         s1, s6, -705
                  addi         s1, s6, -705
                  addi         s1, s6, -705
                  nop
                  add          a1, s4, s4
                  lui          s6, 548299
                  add          a1, s4, s4
                  add          a1, s4, s4
                  addi         s1, s6, -705
                  lui          s6, 548299
                  auipc        s0, 513052
                  auipc        s0, 513052
                  add          a1, s4, s4
                  lui          s6, 548299
                  sub          a4, s6, t1
                  auipc        s0, 513052
                  auipc        s0, 513052
                  lui          s6, 548299
                  addi         s1, s6, -705
                  add          a1, s4, s4
                  lui          s6, 548299 #end riscv_int_numeric_corner_stream_21
                  or           a0, zero, t6
                  or           a0, zero, t6
                  and          ra, a2, s11
                  add          a5, s6, t3
                  nop
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  nop
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  nop
                  lui          t5, 548299
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  nop
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  nop
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  or           a0, zero, t6
                  lui          t5, 548299
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  lui          t5, 548299
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  or           a0, zero, t6
                  lui          t5, 548299
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  nop
                  lui          t5, 548299
                  lui          t5, 548299
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  nop
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  nop
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  lui          t5, 548299
                  nop
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  nop
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  nop
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  nop
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  lui          t5, 548299
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  nop
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  add          a5, s6, t3
                  lui          t5, 548299
                  nop
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  add          a5, s6, t3
                  lui          t5, 548299
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  nop
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  nop
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  nop
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  nop
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  lui          t5, 548299
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  nop
                  sll          s10, a0, sp
                  nop
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  lui          t5, 548299
                  nop
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  and          ra, a2, s11
                  nop
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  nop
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  nop
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  lui          t5, 548299
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  lui          t5, 548299
                  srli         sp, a6, 6
                  nop
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  lui          t5, 548299
                  nop
                  add          a5, s6, t3
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  nop
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  lui          t5, 548299
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  lui          t5, 548299
                  or           a0, zero, t6
                  nop
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  add          a5, s6, t3
                  lui          t5, 548299
                  xor          sp, t6, s0
                  lui          t5, 548299
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  lui          t5, 548299
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  nop
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  lui          t5, 548299
                  nop
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  lui          t5, 548299
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  nop
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  nop
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  nop
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  nop
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  lui          t5, 548299
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  nop
                  nop
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  nop
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  nop
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  nop
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  nop
                  lui          t5, 548299
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  lui          t5, 548299
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  auipc        zero, 513052
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  lui          t5, 548299
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  lui          t5, 548299
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  nop
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  nop
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  nop
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  nop
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  lui          t5, 548299
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  lui          t5, 548299
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  lui          t5, 548299
                  nop
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  nop
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  nop
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sub          s7, t4, t2
                  nop
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  nop
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  nop
                  sltu         sp, s2, s4
                  nop
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  add          a5, s6, t3
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  nop
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  lui          t5, 548299
                  or           a0, zero, t6
                  nop
                  and          ra, a2, s11
                  lui          t5, 548299
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  lui          t5, 548299
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  lui          t5, 548299
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  lui          t5, 548299
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  lui          t5, 548299
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  nop
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  li           a0, 0x6d99c905 #start riscv_int_numeric_corner_stream_15
                  li           t2, 0x0
                  li           s4, 0x57616910
                  li           t1, 0x0
                  li           s5, 0x45908ec7
                  li           sp, 0x0
                  li           gp, 0xffffffff
                  li           s6, 0xffffffff
                  li           a3, 0x80000000
                  li           a2, 0xffffffff
                  nop
                  lui          s6, 548299
                  addi         gp, s6, -705
                  auipc        a2, 513052
                  add          gp, s4, s4
                  addi         gp, s6, -705
                  nop
                  nop
                  add          gp, s4, s4
                  nop
                  lui          s6, 548299
                  lui          s6, 548299
                  lui          s6, 548299
                  addi         gp, s6, -705
                  addi         gp, s6, -705
                  lui          s6, 548299
                  addi         gp, s6, -705
                  nop
                  addi         gp, s6, -705
                  lui          s6, 548299
                  addi         gp, s6, -705
                  sub          a2, a3, t2 #end riscv_int_numeric_corner_stream_15
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  nop
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  nop
                  nop
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  nop
                  or           a0, zero, t6
                  nop
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  nop
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  lui          t5, 548299
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  nop
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  auipc        zero, 513052
                  lui          t5, 548299
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  nop
                  nop
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  nop
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  nop
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  nop
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  nop
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  nop
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  lui          t5, 548299
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  and          ra, a2, s11
                  nop
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  lui          t5, 548299
                  lui          t5, 548299
                  srl          s11, s2, a4
                  nop
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  lui          t5, 548299
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  nop
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  nop
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  lui          t5, 548299
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  lui          t5, 548299
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  lui          t5, 548299
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  nop
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  nop
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  nop
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  nop
                  or           a0, zero, t6
                  lui          t5, 548299
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  lui          t5, 548299
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  nop
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  nop
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  xor          sp, t6, s0
                  nop
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  li           s2, 0x1fd5a81a #start riscv_int_numeric_corner_stream_6
                  li           s11, 0x487be3b7
                  li           t6, 0x0
                  li           s5, 0xffffffff
                  li           s3, 0xffffffff
                  li           gp, 0xffffffff
                  li           s7, 0x0
                  li           ra, 0xffffffff
                  li           a3, 0x80000000
                  li           t2, 0x14d78845
                  auipc        s2, 513052
                  addi         t6, s11, -705
                  sub          s11, t6, t2
                  add          a3, t2, s2
                  auipc        s2, 513052
                  lui          s2, 548299
                  nop
                  sub          s11, t6, t2
                  auipc        s2, 513052
                  lui          s2, 548299
                  nop
                  lui          s2, 548299
                  lui          s2, 548299
                  sub          s11, t6, t2
                  auipc        s2, 513052
                  lui          s2, 548299
                  addi         t6, s11, -705
                  addi         t6, s11, -705
                  addi         t6, s11, -705
                  addi         t6, s11, -705
                  addi         t6, s11, -705
                  nop
                  add          a3, t2, s2
                  sub          s11, t6, t2
                  sub          s11, t6, t2
                  auipc        s2, 513052
                  nop
                  sub          s11, t6, t2
                  nop #end riscv_int_numeric_corner_stream_6
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  lui          t5, 548299
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  add          a5, s6, t3
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  lui          t5, 548299
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  li           tp, 0x80000000 #start riscv_int_numeric_corner_stream_8
                  li           s1, 0x9ea7d4bf
                  li           s10, 0x0
                  li           sp, 0xd9f1b9d8
                  li           s0, 0xffffffff
                  li           t6, 0x3368af43
                  li           s5, 0xb42d67e7
                  li           a3, 0x0
                  li           s4, 0x80000000
                  li           t4, 0x0
                  addi         tp, s10, -705
                  addi         tp, s10, -705
                  sub          s1, s10, sp
                  sub          s1, s10, sp
                  addi         tp, s10, -705
                  sub          s1, s10, sp
                  lui          s10, 548299
                  add          sp, tp, s4
                  sub          s1, s10, sp
                  nop
                  nop
                  add          sp, tp, s4
                  lui          s10, 548299
                  lui          s10, 548299
                  add          sp, tp, s4
                  sub          s1, s10, sp
                  sub          s1, s10, sp
                  add          sp, tp, s4
                  nop
                  nop
                  lui          s10, 548299
                  nop
                  lui          s10, 548299
                  lui          s10, 548299
                  auipc        s0, 513052
                  addi         tp, s10, -705
                  add          sp, tp, s4
                  lui          s10, 548299
                  sub          s1, s10, sp
                  lui          s10, 548299 #end riscv_int_numeric_corner_stream_8
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  li           a3, 0xb7f30bf0 #start riscv_int_numeric_corner_stream_30
                  li           t2, 0x80000000
                  li           a0, 0x40283b65
                  li           s7, 0xffffffff
                  li           a6, 0xebe4fc08
                  li           ra, 0x0
                  li           s4, 0xffffffff
                  li           t5, 0x332fc841
                  li           a1, 0xd3904fd2
                  li           gp, 0x80000000
                  nop
                  addi         s4, t5, -705
                  nop
                  addi         s4, t5, -705
                  sub          s4, a6, gp
                  addi         s4, t5, -705
                  lui          t5, 548299
                  sub          s4, a6, gp
                  lui          t5, 548299
                  nop
                  nop
                  nop
                  addi         s4, t5, -705
                  sub          s4, a6, gp
                  add          gp, t5, s4
                  lui          t5, 548299
                  add          gp, t5, s4
                  auipc        a0, 513052
                  sub          s4, a6, gp
                  nop
                  addi         s4, t5, -705
                  add          gp, t5, s4
                  nop
                  addi         s4, t5, -705
                  nop
                  lui          t5, 548299 #end riscv_int_numeric_corner_stream_30
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  lui          t5, 548299
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  lui          t5, 548299
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  lui          t5, 548299
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  nop
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  lui          t5, 548299
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  nop
                  auipc        zero, 513052
                  and          ra, a2, s11
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  nop
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  nop
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  or           a0, zero, t6
                  nop
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  lui          t5, 548299
                  xori         s4, s0, -569
                  lui          t5, 548299
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  add          a5, s6, t3
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  lui          t5, 548299
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  nop
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  lui          t5, 548299
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  nop
                  slt          t4, ra, a1
                  nop
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  nop
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  nop
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  nop
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  nop
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  nop
                  xori         s4, s0, -569
                  nop
                  nop
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  li           s8, 0x80000000 #start riscv_int_numeric_corner_stream_22
                  li           s6, 0x80000000
                  li           s11, 0x80000000
                  li           tp, 0xffffffff
                  li           a5, 0x730cabf7
                  li           s3, 0xad81f068
                  li           sp, 0x49b88cad
                  li           a4, 0xffffffff
                  li           s4, 0xffffffff
                  li           s0, 0x80000000
                  add          s3, s8, s4
                  sub          a4, s4, sp
                  add          s3, s8, s4
                  auipc        s0, 513052
                  add          s3, s8, s4
                  lui          s6, 548299
                  add          s3, s8, s4
                  addi         a5, s11, -705
                  auipc        s0, 513052
                  auipc        s0, 513052
                  sub          a4, s4, sp
                  add          s3, s8, s4
                  nop
                  add          s3, s8, s4
                  auipc        s0, 513052 #end riscv_int_numeric_corner_stream_22
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  lui          t5, 548299
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  lui          t5, 548299
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  nop
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  lui          t5, 548299
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  nop
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  lui          t5, 548299
                  srli         sp, a6, 6
                  lui          t5, 548299
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  lui          t5, 548299
                  srli         sp, a6, 6
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  nop
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  lui          t5, 548299
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  nop
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  lui          t5, 548299
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  lui          t5, 548299
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  lui          t5, 548299
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  lui          t5, 548299
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  nop
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  nop
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  lui          t5, 548299
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  nop
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  nop
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  lui          t5, 548299
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  nop
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  lui          t5, 548299
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  nop
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  nop
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  li           a1, 0x80000000 #start riscv_int_numeric_corner_stream_24
                  li           s5, 0x0
                  li           a4, 0x0
                  li           a5, 0xd2b4ceab
                  li           a2, 0x80000000
                  li           t5, 0x80000000
                  li           t2, 0xa64f440c
                  li           sp, 0x80000000
                  li           t6, 0x0
                  li           a6, 0x0
                  add          t2, a6, a6
                  nop
                  addi         a6, t5, -705
                  nop
                  add          t2, a6, a6
                  nop
                  sub          a6, a6, sp
                  add          t2, a6, a6
                  lui          t5, 548299
                  auipc        a2, 513052
                  lui          t5, 548299
                  auipc        a2, 513052
                  add          t2, a6, a6
                  sub          a6, a6, sp
                  add          t2, a6, a6
                  auipc        a2, 513052
                  nop
                  nop
                  sub          a6, a6, sp
                  sub          a6, a6, sp
                  auipc        a2, 513052
                  sub          a6, a6, sp
                  add          t2, a6, a6
                  add          t2, a6, a6 #end riscv_int_numeric_corner_stream_24
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  nop
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  nop
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  lui          t5, 548299
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  lui          t5, 548299
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  add          a5, s6, t3
                  li           s1, 0x80000000 #start riscv_int_numeric_corner_stream_26
                  li           t1, 0xffffffff
                  li           a0, 0x80000000
                  li           a4, 0x0
                  li           s9, 0x0
                  li           s4, 0x0
                  li           a5, 0x0
                  li           t4, 0xdb53fbd1
                  li           sp, 0xffffffff
                  li           a1, 0x9b8cfc10
                  sub          a4, s4, sp
                  auipc        sp, 513052
                  sub          a4, s4, sp
                  add          a0, t4, s4
                  nop
                  sub          a4, s4, sp
                  auipc        sp, 513052
                  lui          a4, 548299
                  lui          a4, 548299
                  auipc        sp, 513052
                  add          a0, t4, s4
                  add          a0, t4, s4
                  addi         t4, a4, -705
                  addi         t4, a4, -705
                  lui          a4, 548299 #end riscv_int_numeric_corner_stream_26
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  nop
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  lui          t5, 548299
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  lui          t5, 548299
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  nop
                  nop
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  nop
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  nop
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  lui          t5, 548299
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  lui          t5, 548299
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  nop
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  nop
                  lui          t5, 548299
                  auipc        zero, 513052
                  li           s1, 0x0 #start riscv_int_numeric_corner_stream_37
                  li           s7, 0xac4f257f
                  li           t6, 0x80000000
                  li           s9, 0xffffffff
                  li           a3, 0x80000000
                  li           t5, 0xd570e5bc
                  li           s0, 0x0
                  li           s4, 0xffffffff
                  li           s8, 0x0
                  li           t4, 0x0
                  addi         s4, t5, -705
                  lui          t5, 548299
                  nop
                  auipc        s0, 513052
                  nop
                  add          s8, t5, s4
                  add          s8, t5, s4
                  sub          s1, s9, s7
                  sub          s1, s9, s7
                  auipc        s0, 513052
                  addi         s4, t5, -705
                  lui          t5, 548299
                  auipc        s0, 513052
                  auipc        s0, 513052
                  nop
                  auipc        s0, 513052
                  sub          s1, s9, s7
                  lui          t5, 548299
                  nop
                  nop
                  sub          s1, s9, s7
                  sub          s1, s9, s7
                  add          s8, t5, s4
                  add          s8, t5, s4
                  addi         s4, t5, -705
                  addi         s4, t5, -705 #end riscv_int_numeric_corner_stream_37
                  lui          t5, 548299
                  sra          s10, t5, s8
                  nop
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  lui          t5, 548299
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  lui          t5, 548299
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  nop
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  nop
                  or           a0, zero, t6
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  nop
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  lui          t5, 548299
                  or           a0, zero, t6
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  add          a5, s6, t3
                  nop
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  nop
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  nop
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  nop
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  nop
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  nop
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  nop
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  lui          t5, 548299
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  lui          t5, 548299
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  nop
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  nop
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  lui          t5, 548299
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  or           a0, zero, t6
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  nop
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  lui          t5, 548299
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  lui          t5, 548299
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  nop
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  lui          t5, 548299
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  nop
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  nop
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  auipc        zero, 513052
                  or           a0, zero, t6
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  lui          t5, 548299
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  lui          t5, 548299
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  lui          t5, 548299
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  nop
                  lui          t5, 548299
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  nop
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  lui          t5, 548299
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  nop
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  nop
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  nop
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  lui          t5, 548299
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  lui          t5, 548299
                  slt          t4, ra, a1
                  nop
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  nop
                  nop
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  nop
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  lui          t5, 548299
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  lui          t5, 548299
                  nop
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  auipc        zero, 513052
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  nop
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  lui          t5, 548299
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  and          ra, a2, s11
                  nop
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  nop
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  nop
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  lui          t5, 548299
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  nop
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  auipc        zero, 513052
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  nop
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  nop
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  lui          t5, 548299
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  lui          t5, 548299
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  lui          t5, 548299
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  nop
                  nop
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  nop
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  lui          t5, 548299
                  nop
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  li           s9, 0x0 #start riscv_int_numeric_corner_stream_23
                  li           s5, 0x80000000
                  li           s11, 0x0
                  li           t5, 0x80000000
                  li           t6, 0xffffffff
                  li           s8, 0x64f566c7
                  li           s10, 0x0
                  li           s1, 0x80000000
                  li           ra, 0x9ad61a07
                  li           t1, 0x6339bff2
                  sub          s8, s10, t1
                  lui          t5, 548299
                  addi         t6, t5, -705
                  auipc        t1, 513052
                  auipc        t1, 513052
                  add          ra, t5, s10
                  lui          t5, 548299
                  auipc        t1, 513052
                  addi         t6, t5, -705
                  lui          t5, 548299
                  nop
                  nop
                  add          ra, t5, s10
                  nop
                  sub          s8, s10, t1 #end riscv_int_numeric_corner_stream_23
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  lui          t5, 548299
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  nop
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  nop
                  nop
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  nop
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  nop
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  nop
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  lui          t5, 548299
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  lui          t5, 548299
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  nop
                  nop
                  and          ra, a2, s11
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  nop
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  nop
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  lui          t5, 548299
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  and          ra, a2, s11
                  nop
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  and          ra, a2, s11
                  lui          t5, 548299
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  nop
                  or           a0, zero, t6
                  nop
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  nop
                  sll          s10, a0, sp
                  lui          t5, 548299
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  lui          t5, 548299
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  nop
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  lui          t5, 548299
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  lui          t5, 548299
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  lui          t5, 548299
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  nop
                  xor          sp, t6, s0
                  lui          t5, 548299
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  nop
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  lui          t5, 548299
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  nop
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  nop
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  nop
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  or           a0, zero, t6
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  nop
                  lui          t5, 548299
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  nop
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  lui          t5, 548299
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  lui          t5, 548299
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  nop
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  nop
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  lui          t5, 548299
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  nop
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  nop
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  lui          t5, 548299
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  add          a5, s6, t3
                  lui          t5, 548299
                  nop
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  lui          t5, 548299
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  nop
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  nop
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  lui          t5, 548299
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_12
                  li           s1, 0xffffffff
                  li           s0, 0x0
                  li           t5, 0x90a67562
                  li           s9, 0x80000000
                  li           s8, 0xffffffff
                  li           s7, 0x80000000
                  li           s3, 0x80000000
                  li           a2, 0x80000000
                  li           t1, 0x80000000
                  auipc        s0, 513052
                  auipc        s0, 513052
                  add          s9, tp, s8
                  lui          t5, 548299
                  sub          s8, tp, t1
                  nop
                  auipc        s0, 513052
                  auipc        s0, 513052
                  nop
                  sub          s8, tp, t1
                  lui          t5, 548299
                  lui          t5, 548299
                  addi         t1, s3, -705
                  add          s9, tp, s8
                  lui          t5, 548299 #end riscv_int_numeric_corner_stream_12
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  or           a0, zero, t6
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  and          ra, a2, s11
                  nop
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  lui          t5, 548299
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sra          s10, t5, s8
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  nop
                  auipc        zero, 513052
                  nop
                  auipc        zero, 513052
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  nop
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  nop
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  lui          t5, 548299
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  nop
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  nop
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  nop
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  nop
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  nop
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  nop
                  and          ra, a2, s11
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  lui          t5, 548299
                  auipc        zero, 513052
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  lui          t5, 548299
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  and          ra, a2, s11
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  nop
                  nop
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  and          ra, a2, s11
                  nop
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  nop
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  nop
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  add          a5, s6, t3
                  lui          t5, 548299
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  lui          t5, 548299
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  lui          t5, 548299
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  nop
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  nop
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  lui          t5, 548299
                  lui          t5, 548299
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  lui          t5, 548299
                  lui          t5, 548299
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  nop
                  andi         ra, a2, 1345
                  nop
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  lui          t5, 548299
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  nop
                  nop
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  lui          t5, 548299
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  lui          t5, 548299
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  nop
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  lui          t5, 548299
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  nop
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  nop
                  lui          t5, 548299
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  and          ra, a2, s11
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  nop
                  ori          t1, s5, 330
                  nop
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  nop
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  nop
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  nop
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  lui          t5, 548299
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  lui          t5, 548299
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  nop
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  nop
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  nop
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  lui          t5, 548299
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  nop
                  nop
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  lui          t5, 548299
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  lui          t5, 548299
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  nop
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  add          a5, s6, t3
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  lui          t5, 548299
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  lui          t5, 548299
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  nop
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  lui          t5, 548299
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  lui          t5, 548299
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  nop
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  nop
                  nop
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  lui          t5, 548299
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  lui          t5, 548299
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  lui          t5, 548299
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  and          ra, a2, s11
                  and          ra, a2, s11
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  lui          t5, 548299
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  nop
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  nop
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  nop
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  lui          t5, 548299
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  lui          t5, 548299
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  nop
                  slt          t4, ra, a1
                  lui          t5, 548299
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  nop
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  nop
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  nop
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  nop
                  lui          t5, 548299
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  lui          t5, 548299
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  nop
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  lui          t5, 548299
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  nop
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  nop
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  nop
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  nop
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  nop
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  nop
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  nop
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  nop
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  lui          t5, 548299
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  or           a0, zero, t6
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  nop
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  lui          t5, 548299
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  and          ra, a2, s11
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  lui          t5, 548299
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  lui          t5, 548299
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  nop
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  auipc        zero, 513052
                  auipc        zero, 513052
                  lui          t5, 548299
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  nop
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  nop
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  nop
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  nop
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  nop
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  auipc        zero, 513052
                  lui          t5, 548299
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  lui          t5, 548299
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  nop
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  add          a5, s6, t3
                  add          a5, s6, t3
                  lui          t5, 548299
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  add          a5, s6, t3
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  lui          t5, 548299
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  nop
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  and          ra, a2, s11
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  nop
                  lui          t5, 548299
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  lui          t5, 548299
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  nop
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  nop
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  lui          t5, 548299
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  add          a5, s6, t3
                  nop
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  or           a0, zero, t6
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  lui          t5, 548299
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  lui          t5, 548299
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  nop
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  nop
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  nop
                  sltu         sp, s2, s4
                  nop
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  auipc        zero, 513052
                  add          a5, s6, t3
                  nop
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  and          ra, a2, s11
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  nop
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  nop
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  nop
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  li           a3, 0x6b1de598 #start riscv_int_numeric_corner_stream_31
                  li           t4, 0x49685bbc
                  li           a4, 0x0
                  li           t6, 0x9814726
                  li           sp, 0x80000000
                  li           s8, 0x80000000
                  li           s0, 0xffffffff
                  li           a6, 0xffffffff
                  li           a0, 0x5763f481
                  li           a1, 0x80000000
                  auipc        s0, 513052
                  add          a1, a6, a6
                  lui          t6, 548299
                  lui          t6, 548299
                  nop
                  nop
                  nop
                  auipc        s0, 513052
                  add          a1, a6, a6
                  addi         a6, t6, -705
                  sub          s8, a0, sp
                  lui          t6, 548299
                  addi         a6, t6, -705
                  lui          t6, 548299
                  sub          s8, a0, sp
                  add          a1, a6, a6
                  nop
                  sub          s8, a0, sp
                  nop
                  auipc        s0, 513052
                  addi         a6, t6, -705
                  add          a1, a6, a6
                  addi         a6, t6, -705 #end riscv_int_numeric_corner_stream_31
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  lui          t5, 548299
                  nop
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  li           tp, 0x0 #start riscv_int_numeric_corner_stream_1
                  li           s3, 0xffffffff
                  li           s2, 0x0
                  li           a1, 0x0
                  li           gp, 0x0
                  li           s7, 0xd768476
                  li           s11, 0xffffffff
                  li           sp, 0xffffffff
                  li           s5, 0x77a93a0
                  li           s8, 0xffffffff
                  sub          s8, s7, gp
                  add          s3, tp, s2
                  sub          s8, s7, gp
                  sub          s8, s7, gp
                  sub          s8, s7, gp
                  auipc        sp, 513052
                  sub          s8, s7, gp
                  lui          s2, 548299
                  addi         s11, s11, -705
                  nop
                  auipc        sp, 513052
                  nop
                  nop
                  lui          s2, 548299
                  sub          s8, s7, gp
                  addi         s11, s11, -705
                  lui          s2, 548299
                  nop
                  auipc        sp, 513052
                  auipc        sp, 513052
                  sub          s8, s7, gp
                  sub          s8, s7, gp
                  add          s3, tp, s2
                  lui          s2, 548299
                  nop
                  auipc        sp, 513052
                  auipc        sp, 513052
                  lui          s2, 548299 #end riscv_int_numeric_corner_stream_1
                  srli         sp, a6, 6
                  lui          t5, 548299
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  nop
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  lui          t5, 548299
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  lui          t5, 548299
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  nop
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  lui          t5, 548299
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  nop
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  nop
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  nop
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  lui          t5, 548299
                  lui          t5, 548299
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  nop
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  nop
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  nop
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  lui          t5, 548299
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  lui          t5, 548299
                  nop
                  lui          t5, 548299
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  nop
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  nop
                  nop
                  or           a0, zero, t6
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  nop
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  lui          t5, 548299
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  lui          t5, 548299
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  nop
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  or           a0, zero, t6
                  nop
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  nop
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  nop
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  nop
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  lui          t5, 548299
                  nop
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  nop
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  lui          t5, 548299
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  lui          t5, 548299
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  nop
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  nop
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  nop
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  nop
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  nop
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  nop
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  nop
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  lui          t5, 548299
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  nop
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  nop
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  or           a0, zero, t6
                  nop
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_13
                  li           s9, 0x80000000
                  li           s8, 0xdb8e6c8d
                  li           a3, 0x88905e8f
                  li           s10, 0x0
                  li           tp, 0xbe3e9ce6
                  li           t6, 0x8d714d72
                  li           a5, 0x0
                  li           s1, 0x0
                  li           ra, 0x80000000
                  lui          t6, 548299
                  nop
                  sub          s8, s10, a5
                  add          s11, ra, s8
                  addi         tp, s10, -705
                  nop
                  nop
                  addi         tp, s10, -705
                  sub          s8, s10, a5
                  lui          t6, 548299
                  add          s11, ra, s8
                  sub          s8, s10, a5
                  add          s11, ra, s8
                  add          s11, ra, s8
                  add          s11, ra, s8 #end riscv_int_numeric_corner_stream_13
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  and          ra, a2, s11
                  lui          t5, 548299
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  nop
                  auipc        zero, 513052
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  nop
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  nop
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  lui          t5, 548299
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  lui          t5, 548299
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  nop
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  lui          t5, 548299
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  nop
                  srl          s11, s2, a4
                  lui          t5, 548299
                  srl          s11, s2, a4
                  lui          t5, 548299
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  add          a5, s6, t3
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  nop
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  li           s0, 0x80000000 #start riscv_int_numeric_corner_stream_19
                  li           a3, 0x0
                  li           t4, 0x80000000
                  li           t1, 0xffffffff
                  li           t5, 0x80000000
                  li           s6, 0x24665d3c
                  li           gp, 0xffffffff
                  li           s9, 0x0
                  li           a4, 0x4d130f6b
                  li           s8, 0xffffffff
                  add          gp, t1, s8
                  sub          s8, s6, t1
                  sub          s8, s6, t1
                  addi         s6, s6, -705
                  sub          s8, s6, t1
                  auipc        s0, 513052
                  sub          s8, s6, t1
                  nop
                  auipc        s0, 513052
                  lui          s6, 548299
                  lui          s6, 548299
                  nop
                  lui          s6, 548299
                  nop
                  auipc        s0, 513052
                  sub          s8, s6, t1
                  sub          s8, s6, t1
                  auipc        s0, 513052
                  nop
                  auipc        s0, 513052
                  auipc        s0, 513052 #end riscv_int_numeric_corner_stream_19
                  sll          s10, a0, sp
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  lui          t5, 548299
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  lui          t5, 548299
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  lui          t5, 548299
                  and          ra, a2, s11
                  or           a0, zero, t6
                  auipc        zero, 513052
                  nop
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  nop
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  nop
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  lui          t5, 548299
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  nop
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  nop
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  nop
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  lui          t5, 548299
                  lui          t5, 548299
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  nop
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  nop
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  nop
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  lui          t5, 548299
                  srai         a3, a2, 3
                  lui          t5, 548299
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  nop
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  or           a0, zero, t6
                  lui          t5, 548299
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  nop
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  lui          t5, 548299
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  lui          t5, 548299
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  nop
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  nop
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  lui          t5, 548299
                  xor          sp, t6, s0
                  nop
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  nop
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  auipc        zero, 513052
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  lui          t5, 548299
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  and          ra, a2, s11
                  nop
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  nop
                  srl          s11, s2, a4
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  nop
                  lui          t5, 548299
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  nop
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  nop
                  xor          sp, t6, s0
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_20
                  li           a3, 0xffffffff
                  li           t5, 0x80000000
                  li           t2, 0x80000000
                  li           ra, 0x80000000
                  li           a4, 0xffffffff
                  li           s10, 0x5ad30805
                  li           s0, 0x0
                  li           s9, 0xe636677c
                  li           s2, 0x80000000
                  nop
                  sub          a4, s2, t2
                  add          s9, ra, s2
                  auipc        s0, 513052
                  auipc        s0, 513052
                  addi         a3, s10, -705
                  add          s9, ra, s2
                  nop
                  add          s9, ra, s2
                  addi         a3, s10, -705
                  addi         a3, s10, -705
                  auipc        s0, 513052
                  nop
                  lui          s10, 548299
                  add          s9, ra, s2
                  lui          s10, 548299
                  add          s9, ra, s2
                  auipc        s0, 513052
                  auipc        s0, 513052
                  addi         a3, s10, -705
                  addi         a3, s10, -705
                  lui          s10, 548299
                  sub          a4, s2, t2
                  nop
                  lui          s10, 548299 #end riscv_int_numeric_corner_stream_20
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  nop
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  nop
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  auipc        zero, 513052
                  add          a5, s6, t3
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  lui          t5, 548299
                  nop
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  auipc        zero, 513052
                  lui          t5, 548299
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  nop
                  xor          sp, t6, s0
                  nop
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  nop
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  nop
                  lui          t5, 548299
                  add          a5, s6, t3
                  nop
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  lui          t5, 548299
                  or           a0, zero, t6
                  auipc        zero, 513052
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  lui          t5, 548299
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  nop
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  lui          t5, 548299
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  nop
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  lui          t5, 548299
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  add          a5, s6, t3
                  lui          t5, 548299
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  lui          t5, 548299
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  nop
                  and          ra, a2, s11
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  lui          t5, 548299
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  lui          t5, 548299
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  nop
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  lui          t5, 548299
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  lui          t5, 548299
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  lui          t5, 548299
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  nop
                  addi         t6, s10, -705
                  lui          t5, 548299
                  lui          t5, 548299
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  nop
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  nop
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  nop
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  lui          t5, 548299
                  add          a5, s6, t3
                  nop
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  lui          t5, 548299
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  nop
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  or           a0, zero, t6
                  or           a0, zero, t6
                  nop
                  or           a0, zero, t6
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  nop
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  lui          t5, 548299
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  nop
                  slti         a6, s1, 668
                  addi         t6, s10, -705
                  auipc        zero, 513052
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  lui          t5, 548299
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  andi         ra, a2, 1345
                  nop
                  sra          s10, t5, s8
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  sltiu        s6, s0, -690
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  xor          sp, t6, s0
                  sltu         sp, s2, s4
                  nop
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  ori          t1, s5, 330
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  and          ra, a2, s11
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  nop
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  srl          s11, s2, a4
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  lui          t5, 548299
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  lui          t5, 548299
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  and          ra, a2, s11
                  slli         a5, a2, 23
                  sub          s7, t4, t2
                  or           a0, zero, t6
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  add          a5, s6, t3
                  nop
                  xori         s4, s0, -569
                  lui          t5, 548299
                  auipc        zero, 513052
                  and          ra, a2, s11
                  lui          t5, 548299
                  lui          t5, 548299
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  nop
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  nop
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  or           a0, zero, t6
                  lui          t5, 548299
                  slt          t4, ra, a1
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  lui          t5, 548299
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  auipc        zero, 513052
                  add          a5, s6, t3
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  nop
                  and          ra, a2, s11
                  add          a5, s6, t3
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  nop
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  nop
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  nop
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  add          a5, s6, t3
                  and          ra, a2, s11
                  lui          t5, 548299
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  lui          t5, 548299
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  nop
                  auipc        zero, 513052
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  nop
                  sltiu        s6, s0, -690
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  and          ra, a2, s11
                  or           a0, zero, t6
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  sltiu        s6, s0, -690
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  or           a0, zero, t6
                  lui          t5, 548299
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  lui          t5, 548299
                  sub          s7, t4, t2
                  sll          s10, a0, sp
                  lui          t5, 548299
                  nop
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  srli         sp, a6, 6
                  auipc        zero, 513052
                  nop
                  or           a0, zero, t6
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  srai         a3, a2, 3
                  sltiu        s6, s0, -690
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  srli         sp, a6, 6
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  nop
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  lui          t5, 548299
                  nop
                  srai         a3, a2, 3
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  lui          t5, 548299
                  auipc        zero, 513052
                  ori          t1, s5, 330
                  lui          t5, 548299
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  sltiu        s6, s0, -690
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  lui          t5, 548299
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  and          ra, a2, s11
                  sltiu        s6, s0, -690
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  nop
                  srli         sp, a6, 6
                  nop
                  lui          t5, 548299
                  auipc        zero, 513052
                  add          a5, s6, t3
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  lui          t5, 548299
                  srli         sp, a6, 6
                  and          ra, a2, s11
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  sub          s7, t4, t2
                  sub          s7, t4, t2
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  lui          t5, 548299
                  slt          t4, ra, a1
                  ori          t1, s5, 330
                  sltu         sp, s2, s4
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  and          ra, a2, s11
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  slti         a6, s1, 668
                  slti         a6, s1, 668
                  lui          t5, 548299
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  lui          t5, 548299
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  slli         a5, a2, 23
                  slli         a5, a2, 23
                  nop
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  srl          s11, s2, a4
                  auipc        zero, 513052
                  and          ra, a2, s11
                  nop
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  srai         a3, a2, 3
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  add          a5, s6, t3
                  lui          t5, 548299
                  or           a0, zero, t6
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  slt          t4, ra, a1
                  nop
                  sll          s10, a0, sp
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  add          a5, s6, t3
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  add          a5, s6, t3
                  sub          s7, t4, t2
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  slt          t4, ra, a1
                  xori         s4, s0, -569
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  nop
                  nop
                  and          ra, a2, s11
                  lui          t5, 548299
                  sltiu        s6, s0, -690
                  lui          t5, 548299
                  slt          t4, ra, a1
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  xor          sp, t6, s0
                  slli         a5, a2, 23
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  lui          t5, 548299
                  andi         ra, a2, 1345
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  lui          t5, 548299
                  auipc        zero, 513052
                  srli         sp, a6, 6
                  sltu         sp, s2, s4
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  ori          t1, s5, 330
                  addi         t6, s10, -705
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  nop
                  auipc        zero, 513052
                  lui          t5, 548299
                  sub          s7, t4, t2
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  lui          t5, 548299
                  slt          t4, ra, a1
                  slti         a6, s1, 668
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  nop
                  or           a0, zero, t6
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  slti         a6, s1, 668
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  and          ra, a2, s11
                  sll          s10, a0, sp
                  nop
                  slti         a6, s1, 668
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  lui          t5, 548299
                  sltu         sp, s2, s4
                  sltu         sp, s2, s4
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  or           a0, zero, t6
                  xori         s4, s0, -569
                  addi         t6, s10, -705
                  or           a0, zero, t6
                  srai         a3, a2, 3
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  srli         sp, a6, 6
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  sll          s10, a0, sp
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  auipc        zero, 513052
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  and          ra, a2, s11
                  or           a0, zero, t6
                  add          a5, s6, t3
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  lui          t5, 548299
                  srli         sp, a6, 6
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  lui          t5, 548299
                  nop
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  sub          s7, t4, t2
                  auipc        zero, 513052
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  xori         s4, s0, -569
                  and          ra, a2, s11
                  or           a0, zero, t6
                  nop
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  sra          s10, t5, s8
                  nop
                  nop
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  and          ra, a2, s11
                  sra          s10, t5, s8
                  auipc        zero, 513052
                  auipc        zero, 513052
                  sra          s10, t5, s8
                  lui          t5, 548299
                  or           a0, zero, t6
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  lui          t5, 548299
                  auipc        zero, 513052
                  addi         t6, s10, -705
                  srl          s11, s2, a4
                  or           a0, zero, t6
                  nop
                  xor          sp, t6, s0
                  andi         ra, a2, 1345
                  slt          t4, ra, a1
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  sra          s10, t5, s8
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  sub          s7, t4, t2
                  slti         a6, s1, 668
                  sra          s10, t5, s8
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  lui          t5, 548299
                  add          a5, s6, t3
                  and          ra, a2, s11
                  addi         t6, s10, -705
                  sltiu        s6, s0, -690
                  auipc        zero, 513052
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  andi         ra, a2, 1345
                  addi         t6, s10, -705
                  slt          t4, ra, a1
                  nop
                  li           s10, 0xffffffff #start riscv_int_numeric_corner_stream_29
                  li           s9, 0xffffffff
                  li           s3, 0x14d16804
                  li           ra, 0x56d51fe1
                  li           sp, 0xffffffff
                  li           gp, 0xffffffff
                  li           s2, 0xffffffff
                  li           s11, 0x80000000
                  li           a6, 0x0
                  li           t1, 0x80000000
                  nop
                  nop
                  nop
                  add          s3, s10, s2
                  nop
                  nop
                  add          s3, s10, s2
                  addi         s11, s10, -705
                  sub          s9, t1, t1
                  add          s3, s10, s2
                  nop
                  sub          s9, t1, t1
                  nop
                  nop
                  sub          s9, t1, t1
                  add          s3, s10, s2
                  auipc        sp, 513052
                  addi         s11, s10, -705
                  lui          s10, 548299
                  sub          s9, t1, t1
                  lui          s10, 548299
                  lui          s10, 548299
                  add          s3, s10, s2
                  auipc        sp, 513052
                  nop
                  add          s3, s10, s2 #end riscv_int_numeric_corner_stream_29
                  ori          t1, s5, 330
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  nop
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  xori         s4, s0, -569
                  srli         sp, a6, 6
                  srai         a3, a2, 3
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  auipc        zero, 513052
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  sra          s10, t5, s8
                  srai         a3, a2, 3
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  nop
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  nop
                  srai         a3, a2, 3
                  auipc        zero, 513052
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  lui          t5, 548299
                  auipc        zero, 513052
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  sub          s7, t4, t2
                  addi         t6, s10, -705
                  xori         s4, s0, -569
                  nop
                  sltu         sp, s2, s4
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  ori          t1, s5, 330
                  sll          s10, a0, sp
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  sub          s7, t4, t2
                  slli         a5, a2, 23
                  and          ra, a2, s11
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  ori          t1, s5, 330
                  nop
                  xori         s4, s0, -569
                  sll          s10, a0, sp
                  slt          t4, ra, a1
                  andi         ra, a2, 1345
                  xor          sp, t6, s0
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  ori          t1, s5, 330
                  xor          sp, t6, s0
                  addi         t6, s10, -705
                  add          a5, s6, t3
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  ori          t1, s5, 330
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  slti         a6, s1, 668
                  slt          t4, ra, a1
                  or           a0, zero, t6
                  and          ra, a2, s11
                  srl          s11, s2, a4
                  nop
                  add          a5, s6, t3
                  auipc        zero, 513052
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  andi         ra, a2, 1345
                  srai         a3, a2, 3
                  lui          t5, 548299
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  sltu         sp, s2, s4
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  add          a5, s6, t3
                  addi         t6, s10, -705
                  nop
                  slt          t4, ra, a1
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  srai         a3, a2, 3
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  sltu         sp, s2, s4
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  nop
                  nop
                  xori         s4, s0, -569
                  xor          sp, t6, s0
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  sra          s10, t5, s8
                  lui          t5, 548299
                  or           a0, zero, t6
                  xor          sp, t6, s0
                  sltiu        s6, s0, -690
                  xori         s4, s0, -569
                  srai         a3, a2, 3
                  add          a5, s6, t3
                  srl          s11, s2, a4
                  slli         a5, a2, 23
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  slt          t4, ra, a1
                  auipc        zero, 513052
                  sltu         sp, s2, s4
                  addi         t6, s10, -705
                  xor          sp, t6, s0
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  sltu         sp, s2, s4
                  andi         ra, a2, 1345
                  slli         a5, a2, 23
                  srli         sp, a6, 6
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  or           a0, zero, t6
                  srl          s11, s2, a4
                  xori         s4, s0, -569
                  slti         a6, s1, 668
                  srli         sp, a6, 6
                  add          a5, s6, t3
                  slti         a6, s1, 668
                  or           a0, zero, t6
                  andi         ra, a2, 1345
                  sll          s10, a0, sp
                  xor          sp, t6, s0
                  srl          s11, s2, a4
                  lui          t5, 548299
                  srl          s11, s2, a4
                  and          ra, a2, s11
                  nop
                  slti         a6, s1, 668
                  auipc        zero, 513052
                  slli         a5, a2, 23
                  srai         a3, a2, 3
                  srai         a3, a2, 3
                  srli         sp, a6, 6
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  add          a5, s6, t3
                  slt          t4, ra, a1
                  nop
                  sltiu        s6, s0, -690
                  or           a0, zero, t6
                  sltiu        s6, s0, -690
                  sll          s10, a0, sp
                  add          a5, s6, t3
                  sra          s10, t5, s8
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  lui          t5, 548299
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  or           a0, zero, t6
                  srli         sp, a6, 6
                  xor          sp, t6, s0
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  sltu         sp, s2, s4
                  nop
                  slt          t4, ra, a1
                  xor          sp, t6, s0
                  sll          s10, a0, sp
                  or           a0, zero, t6
                  slli         a5, a2, 23
                  slt          t4, ra, a1
                  add          a5, s6, t3
                  slli         a5, a2, 23
                  sltu         sp, s2, s4
                  srl          s11, s2, a4
                  sra          s10, t5, s8
                  slli         a5, a2, 23
                  andi         ra, a2, 1345
                  sub          s7, t4, t2
                  sra          s10, t5, s8
                  sltiu        s6, s0, -690
                  slti         a6, s1, 668
                  andi         ra, a2, 1345
                  sltu         sp, s2, s4
                  sub          s7, t4, t2
                  andi         ra, a2, 1345
                  or           a0, zero, t6
                  sra          s10, t5, s8
                  sub          s7, t4, t2
                  ori          t1, s5, 330
                  and          ra, a2, s11
                  srai         a3, a2, 3
                  nop
                  xor          sp, t6, s0
                  srai         a3, a2, 3
                  andi         ra, a2, 1345
                  ori          t1, s5, 330
                  lui          t5, 548299
                  ori          t1, s5, 330
                  srl          s11, s2, a4
                  slti         a6, s1, 668
                  and          ra, a2, s11
                  and          ra, a2, s11
                  slti         a6, s1, 668
                  srl          s11, s2, a4
                  xor          sp, t6, s0
                  slt          t4, ra, a1
                  addi         t6, s10, -705
                  addi         t6, s10, -705
                  sll          s10, a0, sp
                  srl          s11, s2, a4
                  add          a5, s6, t3
                  ori          t1, s5, 330
                  xori         s4, s0, -569
                  andi         ra, a2, 1345
                  slti         a6, s1, 668
                  xori         s4, s0, -569
                  sra          s10, t5, s8
                  xori         s4, s0, -569
                  slli         a5, a2, 23
                  la x28, test_done
                  jalr x0, x28, 0
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
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_2:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_3:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_4:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_5:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_6:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_7:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_8:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_9:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_10:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_11:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_12:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_13:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_14:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

mmode_intr_vector_15:
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x342 # MCAUSE
                  srli x7, x7, 0x1f
                  beqz x7, 1f
                  j mmode_intr_handler
                  1: la x28, test_done
                  jalr x0, x28, 0

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
                  addi x17, x17, -4
                  sw  x5, (x17)
                  add x5, x17, zero
                  addi x5, x5, -128
                  sw  x1, 4(x5)
                  sw  x2, 8(x5)
                  sw  x3, 12(x5)
                  sw  x4, 16(x5)
                  sw  x5, 20(x5)
                  sw  x6, 24(x5)
                  sw  x7, 28(x5)
                  sw  x8, 32(x5)
                  sw  x9, 36(x5)
                  sw  x10, 40(x5)
                  sw  x11, 44(x5)
                  sw  x12, 48(x5)
                  sw  x13, 52(x5)
                  sw  x14, 56(x5)
                  sw  x15, 60(x5)
                  sw  x16, 64(x5)
                  sw  x17, 68(x5)
                  sw  x18, 72(x5)
                  sw  x19, 76(x5)
                  sw  x20, 80(x5)
                  sw  x21, 84(x5)
                  sw  x22, 88(x5)
                  sw  x23, 92(x5)
                  sw  x24, 96(x5)
                  sw  x25, 100(x5)
                  sw  x26, 104(x5)
                  sw  x27, 108(x5)
                  sw  x28, 112(x5)
                  sw  x29, 116(x5)
                  sw  x30, 120(x5)
                  sw  x31, 124(x5)
                  add x17, x5, zero
                  csrr x7, 0x341 # MEPC
                  csrr x7, 0x342 # MCAUSE
                  li x13, 0x3 # BREAKPOINT
                  beq x7, x13, ebreak_handler
                  li x13, 0x8 # ECALL_UMODE
                  beq x7, x13, ecall_handler
                  li x13, 0x9 # ECALL_SMODE
                  beq x7, x13, ecall_handler
                  li x13, 0xb # ECALL_MMODE
                  beq x7, x13, ecall_handler
                  li x13, 0x1
                  beq x7, x13, instr_fault_handler
                  li x13, 0x5
                  beq x7, x13, load_fault_handler
                  li x13, 0x7
                  beq x7, x13, store_fault_handler
                  li x13, 0xc
                  beq x7, x13, pt_fault_handler
                  li x13, 0xd
                  beq x7, x13, pt_fault_handler
                  li x13, 0xf
                  beq x7, x13, pt_fault_handler
                  li x13, 0x2 # ILLEGAL_INSTRUCTION
                  beq x7, x13, illegal_instr_handler
                  csrr x13, 0x343 # MTVAL
                  1: la x28, test_done
                  jalr x1, x28, 0

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
                  la x28, write_tohost
                  jalr x0, x28, 0

instr_fault_handler:
                  add x5, x17, zero
                  lw  x1, 4(x5)
                  lw  x2, 8(x5)
                  lw  x3, 12(x5)
                  lw  x4, 16(x5)
                  lw  x5, 20(x5)
                  lw  x6, 24(x5)
                  lw  x7, 28(x5)
                  lw  x8, 32(x5)
                  lw  x9, 36(x5)
                  lw  x10, 40(x5)
                  lw  x11, 44(x5)
                  lw  x12, 48(x5)
                  lw  x13, 52(x5)
                  lw  x14, 56(x5)
                  lw  x15, 60(x5)
                  lw  x16, 64(x5)
                  lw  x17, 68(x5)
                  lw  x18, 72(x5)
                  lw  x19, 76(x5)
                  lw  x20, 80(x5)
                  lw  x21, 84(x5)
                  lw  x22, 88(x5)
                  lw  x23, 92(x5)
                  lw  x24, 96(x5)
                  lw  x25, 100(x5)
                  lw  x26, 104(x5)
                  lw  x27, 108(x5)
                  lw  x28, 112(x5)
                  lw  x29, 116(x5)
                  lw  x30, 120(x5)
                  lw  x31, 124(x5)
                  addi x5, x5, 128
                  add x17, x5, zero
                  lw  x5, (x17)
                  addi x17, x17, 4
                  mret

load_fault_handler:
                  add x5, x17, zero
                  lw  x1, 4(x5)
                  lw  x2, 8(x5)
                  lw  x3, 12(x5)
                  lw  x4, 16(x5)
                  lw  x5, 20(x5)
                  lw  x6, 24(x5)
                  lw  x7, 28(x5)
                  lw  x8, 32(x5)
                  lw  x9, 36(x5)
                  lw  x10, 40(x5)
                  lw  x11, 44(x5)
                  lw  x12, 48(x5)
                  lw  x13, 52(x5)
                  lw  x14, 56(x5)
                  lw  x15, 60(x5)
                  lw  x16, 64(x5)
                  lw  x17, 68(x5)
                  lw  x18, 72(x5)
                  lw  x19, 76(x5)
                  lw  x20, 80(x5)
                  lw  x21, 84(x5)
                  lw  x22, 88(x5)
                  lw  x23, 92(x5)
                  lw  x24, 96(x5)
                  lw  x25, 100(x5)
                  lw  x26, 104(x5)
                  lw  x27, 108(x5)
                  lw  x28, 112(x5)
                  lw  x29, 116(x5)
                  lw  x30, 120(x5)
                  lw  x31, 124(x5)
                  addi x5, x5, 128
                  add x17, x5, zero
                  lw  x5, (x17)
                  addi x17, x17, 4
                  mret

store_fault_handler:
                  add x5, x17, zero
                  lw  x1, 4(x5)
                  lw  x2, 8(x5)
                  lw  x3, 12(x5)
                  lw  x4, 16(x5)
                  lw  x5, 20(x5)
                  lw  x6, 24(x5)
                  lw  x7, 28(x5)
                  lw  x8, 32(x5)
                  lw  x9, 36(x5)
                  lw  x10, 40(x5)
                  lw  x11, 44(x5)
                  lw  x12, 48(x5)
                  lw  x13, 52(x5)
                  lw  x14, 56(x5)
                  lw  x15, 60(x5)
                  lw  x16, 64(x5)
                  lw  x17, 68(x5)
                  lw  x18, 72(x5)
                  lw  x19, 76(x5)
                  lw  x20, 80(x5)
                  lw  x21, 84(x5)
                  lw  x22, 88(x5)
                  lw  x23, 92(x5)
                  lw  x24, 96(x5)
                  lw  x25, 100(x5)
                  lw  x26, 104(x5)
                  lw  x27, 108(x5)
                  lw  x28, 112(x5)
                  lw  x29, 116(x5)
                  lw  x30, 120(x5)
                  lw  x31, 124(x5)
                  addi x5, x5, 128
                  add x17, x5, zero
                  lw  x5, (x17)
                  addi x17, x17, 4
                  mret

ebreak_handler:   
                  csrr  x7, 0x341
                  addi  x7, x7, 4
                  csrw  0x341, x7
                  add x5, x17, zero
                  lw  x1, 4(x5)
                  lw  x2, 8(x5)
                  lw  x3, 12(x5)
                  lw  x4, 16(x5)
                  lw  x5, 20(x5)
                  lw  x6, 24(x5)
                  lw  x7, 28(x5)
                  lw  x8, 32(x5)
                  lw  x9, 36(x5)
                  lw  x10, 40(x5)
                  lw  x11, 44(x5)
                  lw  x12, 48(x5)
                  lw  x13, 52(x5)
                  lw  x14, 56(x5)
                  lw  x15, 60(x5)
                  lw  x16, 64(x5)
                  lw  x17, 68(x5)
                  lw  x18, 72(x5)
                  lw  x19, 76(x5)
                  lw  x20, 80(x5)
                  lw  x21, 84(x5)
                  lw  x22, 88(x5)
                  lw  x23, 92(x5)
                  lw  x24, 96(x5)
                  lw  x25, 100(x5)
                  lw  x26, 104(x5)
                  lw  x27, 108(x5)
                  lw  x28, 112(x5)
                  lw  x29, 116(x5)
                  lw  x30, 120(x5)
                  lw  x31, 124(x5)
                  addi x5, x5, 128
                  add x17, x5, zero
                  lw  x5, (x17)
                  addi x17, x17, 4
                  mret

illegal_instr_handler:
                  csrr  x7, 0x341
                  addi  x7, x7, 4
                  csrw  0x341, x7
                  add x5, x17, zero
                  lw  x1, 4(x5)
                  lw  x2, 8(x5)
                  lw  x3, 12(x5)
                  lw  x4, 16(x5)
                  lw  x5, 20(x5)
                  lw  x6, 24(x5)
                  lw  x7, 28(x5)
                  lw  x8, 32(x5)
                  lw  x9, 36(x5)
                  lw  x10, 40(x5)
                  lw  x11, 44(x5)
                  lw  x12, 48(x5)
                  lw  x13, 52(x5)
                  lw  x14, 56(x5)
                  lw  x15, 60(x5)
                  lw  x16, 64(x5)
                  lw  x17, 68(x5)
                  lw  x18, 72(x5)
                  lw  x19, 76(x5)
                  lw  x20, 80(x5)
                  lw  x21, 84(x5)
                  lw  x22, 88(x5)
                  lw  x23, 92(x5)
                  lw  x24, 96(x5)
                  lw  x25, 100(x5)
                  lw  x26, 104(x5)
                  lw  x27, 108(x5)
                  lw  x28, 112(x5)
                  lw  x29, 116(x5)
                  lw  x30, 120(x5)
                  lw  x31, 124(x5)
                  addi x5, x5, 128
                  add x17, x5, zero
                  lw  x5, (x17)
                  addi x17, x17, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x7, 0x300 # MSTATUS;
                  csrr  x7, 0x304 # MIE;
                  csrr  x7, 0x344 # MIP;
                  csrrc x7, 0x344, x7 # MIP;
                  add x5, x17, zero
                  lw  x1, 4(x5)
                  lw  x2, 8(x5)
                  lw  x3, 12(x5)
                  lw  x4, 16(x5)
                  lw  x5, 20(x5)
                  lw  x6, 24(x5)
                  lw  x7, 28(x5)
                  lw  x8, 32(x5)
                  lw  x9, 36(x5)
                  lw  x10, 40(x5)
                  lw  x11, 44(x5)
                  lw  x12, 48(x5)
                  lw  x13, 52(x5)
                  lw  x14, 56(x5)
                  lw  x15, 60(x5)
                  lw  x16, 64(x5)
                  lw  x17, 68(x5)
                  lw  x18, 72(x5)
                  lw  x19, 76(x5)
                  lw  x20, 80(x5)
                  lw  x21, 84(x5)
                  lw  x22, 88(x5)
                  lw  x23, 92(x5)
                  lw  x24, 96(x5)
                  lw  x25, 100(x5)
                  lw  x26, 104(x5)
                  lw  x27, 108(x5)
                  lw  x28, 112(x5)
                  lw  x29, 116(x5)
                  lw  x30, 120(x5)
                  lw  x31, 124(x5)
                  addi x5, x5, 128
                  add x17, x5, zero
                  lw  x5, (x17)
                  addi x17, x17, 4
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
