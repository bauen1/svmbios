
rom_start = 0xFFFF0000;
rom_end   = 0xFFFFFFFF;

MEMORY {
	RAM (rx!a) : org = 0x0, len = 0x7FFFF
	ROM (rx) : org = rom_start, len = 0xFFFF
}

SECTIONS {
	ENTRY(_init)

	.text : {
		__text_start = .;
		*(.init)
		*(.text)
		*(.rodata)
		__text_end = .;
	}

	.bss : {
		__bss_start = .;
		*(.bss)
		*(COMMON)
		__bss_end = .;
	} > RAM


	__data_load_start = ADDR(.text) + SIZEOF(.text);
	.data : AT (__data_load_start) {
		__data_start = .;
		*(.data);
		__data_end = .;
	} > RAM

	.reset rom_end - 0x10 : ALIGN(0x10){
		*(reset)
	}
}
