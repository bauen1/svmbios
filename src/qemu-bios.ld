OUTPUT_FORMAT(binary)

rom_start = 0x000F0000;
rom_end   = 0x000FFFFF;

MEMORY {
	ROM (rx) : org = rom_start, len = 0xFFFF
}

SECTIONS {
	ENTRY(_init)
	.main : {
		*(main)
	} > ROM

	.reset rom_end - 0x10 : ALIGN(0x10){
		*(reset)
	}
}
