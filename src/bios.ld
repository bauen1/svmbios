OUTPUT_FORMAT(binary)

rom_start = 0xFFFF0000;
rom_end   = 0xFFFFFFFF;

MEMORY {
	RAM (rx!a) : org = 0x0, len = 0x7FFFF
	ROM (rx) : org = rom_start, len = 0xFFFF
}

SECTIONS {
	ENTRY(_init)

	.text : {
		*(.init)
		*(.text)
		*(.rodata)
		*(.data)
	}

	.bss : {
		*(.bss)
	} > RAM

	.reset rom_end - 0x10 : ALIGN(0x10){
		*(reset)
	}
}
