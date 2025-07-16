CC32=riscv32-unknown-elf
CC64=riscv64-unknown-elf
CCFLAGS=-march=rv32i -mabi=ilp32 -T ../linksc.ld -nostartfiles -ffunction-sections -fdata-sections -Wl,--gc-sections -o complex_test.elf
	
build:
	$(CC32)-gcc complex_test.c ../crt0.s $(CCFLAGS)
	$(CC32)-objcopy -O binary -j .init -j .text -j .rodata complex_test.elf complex_test.bin
	../rom_generator complex_test.bin

clean:
	rm -f complex_test.elf complex_test.bin complex_test.hex

.PHONY: build clean
