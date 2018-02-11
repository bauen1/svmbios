OUTPUT_FORMAT(binary)

rom_start = 0xFFFF0000;

MEMORY {
	ROM (rx) : org = rom_start, len = 0xFFFF
}

SECTIONS {
	ENTRY(_init)
	.main : {
		*(main)
	} > ROM

	.reset rom_start - 0x10 : ALIGN(0x10){
		*(reset)
	}
}
