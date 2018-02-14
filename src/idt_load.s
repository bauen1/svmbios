global idt_load:function (idt_load.end - idt_load)
idt_load:
	mov eax, [esp + 4]
	lidt [eax]
	ret
.end:
