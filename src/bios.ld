OUTPUT_FORMAT(binary)

MEMORY {
	ROM (rx) : org = 0x000F0000, len = 0xFFFF
}

SECTIONS {
	ENTRY(_init)
	.main : {
		*(main)
	} > ROM

	.reset 0x000FFFF0 : ALIGN(0x10){
		*(reset)
	}
}
