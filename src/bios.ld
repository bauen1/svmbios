OUTPUT_FORMAT(binary)

MEMORY {
	ROM (rx) : org = 0xFFFF0000, len = 0xFFFF
}

SECTIONS {
	ENTRY(_init)
	.main : {
		*(main)
	} > ROM

	.reset 0xFFFFFFF0 : ALIGN(0x10){
		*(reset)
	}
}
