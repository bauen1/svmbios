[BITS 16]
section .init
extern lgdt_ptr
global _init:function (_init.end - _init)
_init:
	cli
	cld

	; setup the segment registers
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; The memory at 0x0-0x7fff is mapped at reset
	mov esp, 0x7000
	mov ax, 0x0
	mov ss, ax

	call disable_nmi
	call enable_a20

	; load the gdt
	o32 lgdt [lgdt_ptr]

	; enable Protected Mode
	mov eax, cr0
	or al, 1
	mov cr0, eax

	jmp dword 0x08:b32
.end:

section .text
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

global enable_a20:function (enable_a20.end - enable_a20)
enable_a20:
	in al, 0x92
	test al, 2
	jnz .done
	or al, 2
	and al, 0xFE
	out 0x92, al
.done:
	ret
.end:

global _halt:function (_halt.end - _halt)
_halt:
	cli
.loop:
	hlt
	jmp .loop
.end:

[BITS 32]
extern main
global b32:function (b32.end - b32)
b32:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov esp, 0x7000

	mov al, '#'
	out 0xe9, al

	cli
.halt:
	hlt
	jmp .halt
.end:

section reset
[BITS 16]
	jmp 0xf000:0x0
align 16
