section .rodata
global lgdt_ptr:data (lgdt_ptr.end - lgdt_ptr)
lgdt_ptr:
	dw gdt.end - gdt - 1
	dd gdt
.end:

global gdt:data (gdt.end - gdt)
gdt:
.zero:
	dw 0x0000 ; limit 0:15
	dw 0x0000 ; base 0:15
	db 0x00 ; base 16:23
	db 0x00 ; access
	db 0x00 ; limit 16:19 flags
	db 0x00 ; base 24:31

.code:
	dw 0xFFFF ; limit 0:15
	dw 0x0000 ; base 0:15
	db 0x00 ; base 16:23
	db 0x9A ; access
	db 0xCF ; limit 16:19 flags
	db 0x00 ; base 24:31

.data:
	dw 0xFFFF ; limit 0:15
	dw 0x0000 ; base 0:15
	db 0x00 ; base 16:23
	db 0x92 ; access
	db 0xCF ; limit 16:19 flags
	db 0x00 ; base 24:31

.end:
