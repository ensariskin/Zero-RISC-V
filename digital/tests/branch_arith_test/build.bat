@echo off
REM Compile and generate hex file for branch_arith_test

set RISCV_PREFIX=riscv32-unknown-elf-

REM Assemble
%RISCV_PREFIX%as -march=rv32i -mabi=ilp32 -o test.o test.s

REM Link
%RISCV_PREFIX%ld -T link.ld -o test.elf test.o

REM Generate binary
%RISCV_PREFIX%objcopy -O binary test.elf test.bin

REM Generate hex (verilog format)
%RISCV_PREFIX%objcopy -O verilog test.elf test.hex

REM Disassemble for verification
%RISCV_PREFIX%objdump -d test.elf > test.disasm

echo Done! Check test.hex and test.disasm
