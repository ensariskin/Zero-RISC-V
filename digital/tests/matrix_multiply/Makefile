CC32=riscv32-unknown-elf
CC64=riscv64-unknown-elf
CCFLAGS=-march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -ffunction-sections -fdata-sections -Wl,--gc-sections -o matrix_multiply.elf
	
build:
	$(CC32)-gcc matrix_multiply.c ../crt0.s $(CCFLAGS)
	$(CC32)-objcopy -O binary -j .init -j .text -j .rodata matrix_multiply.elf matrix_multiply.bin
	$(scripts)/rom_generator matrix_multiply.bin

clean:
	rm -f matrix_multiply.elf matrix_multiply.bin matrix_multiply.hex

disasm:
	$(CC32)-objdump -d matrix_multiply.elf > matrix_multiply.s

.PHONY: build clean disasm

