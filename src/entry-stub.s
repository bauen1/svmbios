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

[BITS 32]
extern __bss_start, __bss_end
extern __data_start, __data_end, __data_load_start
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

	; zero .bss
	mov al, 0
	mov edi, __bss_start
	mov ecx, __bss_end
	sub ecx, edi
	rep stosb

	; copy .data
	mov edi, __data_start
	mov esi, __data_load_start
	mov ecx, __data_end
	sub ecx, esi
	rep movsb

	call main

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
[BITS 16]
	jmp 0xf000:0x0
align 16
