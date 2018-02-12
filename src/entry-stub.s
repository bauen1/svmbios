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

	call disable_nmi

	mov al, '!'
	call debug_putc

	jmp _halt
.end:

global debug_putc:function (debug_putc.end - debug_putc)
debug_putc:
	out 0xe9, al
	ret
.end:

global disable_nmi:function (disable_nmi.end - disable_nmi)
disable_nmi:
	in al, 0x70
	or al, 0x80
	out 0x70, al
	ret
.end:
global enable_nmi:function (enable_nmi.end - enable_nmi)
enable_nmi:
	in al, 0x70
	and al, 0x7F
	out 0x70, al
	ret
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
