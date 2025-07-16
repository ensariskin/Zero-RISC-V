CC32=riscv32-unknown-elf
CC64=riscv64-unknown-elf
CCFLAGS=-march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -ffunction-sections -fdata-sections -Wl,--gc-sections -o simple_debug.elf
	
build:
	$(CC32)-gcc simple_debug.c ../crt0.s $(CCFLAGS)
	$(CC32)-objcopy -O binary -j .init -j .text -j .rodata simple_debug.elf simple_debug.bin
	../rom_generator simple_debug.bin

clean:
	rm -f simple_debug.elf simple_debug.bin simple_debug.hex

disasm:
	$(CC32)-objdump -d simple_debug.elf > simple_debug.s

.PHONY: build clean disasm
