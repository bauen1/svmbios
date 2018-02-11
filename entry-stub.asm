BITS 16

; BIOS entry point
start:
	nop		; do nothing (for now)

times 0xFFF0-($-$$) db 0
jmp 0xF000:start
db -0xFFFF + 0xFFFF
times 0xFFFF-($-$$) db 0
