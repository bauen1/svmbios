[BITS 16]
section main
global _init
_init:
	nop

section reset
	jmp _init
align 16
