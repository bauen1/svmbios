extern handle_isr

global isr_common_stub:function (isr_common_stub.end-isr_common_stub)
isr_common_stub:
	pusha

	push ds
	push es
	push fs
	push gs
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	cld
	push esp
	call handle_isr
	add esp, 4

	pop gs
	pop fs
	pop es
	pop ds

	popa
	; pop err_code and isr_num
	add esp, 8
	iret
.end:

%macro ISR_CUSTOM 2
	global _isr%1
	_isr%1:
		cli
		push %2 ; err_code
		push %1 ; isr_num
		jmp isr_common_stub
%endmacro

%macro ISR_NOERR 1
	global _isr%1
	_isr%1:
		cli
		push 0 ; no err_code
		push %1 ; isr_num
		jmp isr_common_stub
%endmacro

%macro ISR_ERR 1
	global _isr%1
	_isr%1:
		cli
		; err_code already pushed by cpu
		push %1 ; isr_num
		jmp isr_common_stub
%endmacro

; Exception handlers
ISR_NOERR 0
ISR_NOERR 1
ISR_NOERR 2
ISR_NOERR 3
ISR_NOERR 4
ISR_NOERR 5
ISR_NOERR 6
ISR_NOERR 7
ISR_ERR 8
ISR_NOERR 9
ISR_ERR 10
ISR_ERR 11
ISR_ERR 12
ISR_ERR 13
ISR_ERR 14
ISR_NOERR 15
ISR_NOERR 16
ISR_NOERR 17
ISR_NOERR 18
ISR_NOERR 19
ISR_NOERR 20
ISR_NOERR 21
ISR_NOERR 22
ISR_NOERR 23
ISR_NOERR 24
ISR_NOERR 25
ISR_NOERR 26
ISR_NOERR 27
ISR_NOERR 28
ISR_NOERR 29
ISR_NOERR 30
ISR_NOERR 31

; IRQ handler
ISR_CUSTOM 32,0
ISR_CUSTOM 33,1
ISR_CUSTOM 34,2
ISR_CUSTOM 35,3
ISR_CUSTOM 36,4
ISR_CUSTOM 37,5
ISR_CUSTOM 38,6
ISR_CUSTOM 39,7
ISR_CUSTOM 40,8
ISR_CUSTOM 41,9
ISR_CUSTOM 42,10
ISR_CUSTOM 43,11
ISR_CUSTOM 44,12
ISR_CUSTOM 45,13
ISR_CUSTOM 46,14
ISR_CUSTOM 47,15
