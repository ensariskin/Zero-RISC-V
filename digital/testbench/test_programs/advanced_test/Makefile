CC32=riscv32-unknown-elf
CC64=riscv64-unknown-elf
CCFLAGS=-march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -ffunction-sections -fdata-sections -Wl,--gc-sections -o advanced_test_clean.elf
	
build:
	$(CC32)-gcc advanced_test_clean.c ../crt0.s $(CCFLAGS)
	$(CC32)-objcopy -O binary -j .init -j .text -j .rodata advanced_test_clean.elf advanced_test_clean.bin
	../rom_generator advanced_test_clean.bin

clean:
	rm -f advanced_test_clean.elf advanced_test_clean.bin advanced_test_clean.hex

disasm:
	$(CC32)-objdump -d advanced_test_clean.elf > advanced_test_clean.s

.PHONY: build clean disasm
