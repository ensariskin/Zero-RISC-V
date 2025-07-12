CC32=riscv32-unknown-elf
CC64=riscv64-unknown-elf
CCFLAGS=-march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -ffunction-sections -fdata-sections -Wl,--gc-sections -o ultra_complex_test.elf
	
build:
	$(CC32)-gcc ultra_complex_test.c ../crt0.s $(CCFLAGS)
	$(CC32)-objcopy -O binary -j .init -j .text -j .rodata ultra_complex_test.elf ultra_complex_test.bin
	../rom_generator ultra_complex_test.bin

clean:
	rm -f ultra_complex_test.elf ultra_complex_test.bin ultra_complex_test.hex

disasm:
	$(CC32)-objdump -d ultra_complex_test.elf > ultra_complex_test.s

.PHONY: build clean disasm
