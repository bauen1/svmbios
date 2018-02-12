[BITS 16]
section main
global _init:function (_init.end - _init)
_init:
	cli
	cld

	; should always be mapped
	mov esp, 0x7000
	mov ax, 0x0
	mov ss, ax

	mov al, '!'
	out 0xe9, al

	jmp _halt
.end:

global _halt:function (_halt.end - _halt)
_halt:
	cli
.loop:
	hlt
	jmp .loop
.end:

section reset
	jmp 0xf000:0x0
align 16
