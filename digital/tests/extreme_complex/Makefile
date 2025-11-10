CC32=riscv32-unknown-elf
CC64=riscv64-unknown-elf
CCFLAGS=-march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -ffunction-sections -fdata-sections -Wl,--gc-sections -o extreme_complex_test.elf
	
build:
	$(CC32)-gcc extreme_complex_test.c ../crt0.s $(CCFLAGS)
	$(CC32)-objcopy -O binary -j .init -j .text -j .rodata extreme_complex_test.elf extreme_complex_test.bin
	$(scripts)/rom_generator extreme_complex_test.bin

clean:
	rm -f extreme_complex_test.elf extreme_complex_test.bin extreme_complex_test.hex

disasm:
	$(CC32)-objdump -d extreme_complex_test.elf > extreme_complex_test.s

.PHONY: build clean disasm
