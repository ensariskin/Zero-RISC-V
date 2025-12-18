OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv", "elf32-littleriscv")
OUTPUT_ARCH(riscv)

MEMORY
{
    ROM(RX)   : ORIGIN = 0x00000000, LENGTH = 0x00007000
    RAM(WAIL) : ORIGIN = 0x00007000, LENGTH = 0x00000FFC
}

ENTRY(_start)

SECTIONS
{
    PROVIDE(__stack_top = ORIGIN(RAM) + LENGTH(RAM));
    
    . = 0x0;
    
    .text : {
        *(.text .text.*)
    } > ROM
    
    .rodata : {
        *(.rodata .rodata.*)
    } > ROM
    
    .data : {
        *(.data .data.*)
        *(.sdata .sdata.*)
    } > RAM
    
    .bss : {
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    } > RAM
}
