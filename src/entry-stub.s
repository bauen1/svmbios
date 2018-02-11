[BITS 16]
section main
global _init
_init:
	nop

section reset
	; FIXME: doesn't work
	jmp _init
align 16
