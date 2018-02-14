#include <stdint.h>

#include <idt.h>
#include <idt_load.h>
#include <isrs.h>

static idt_entry_t idt[256] = {0};
static struct {
	uint16_t limit __attribute__((packed));
	uint32_t base __attribute__((packed));
} __attribute__((packed)) lgdt_ptr;

void idt_set_gate(uint8_t i, void *isr, uint16_t selector, uint8_t flags) {
	uint32_t offset = (uint32_t)isr;
	idt[i].offset_low = (uint16_t)(offset & 0xFFFF);
	idt[i].selector = selector;
	idt[i].zero = 0;
	idt[i].type_attr = flags;
	idt[i].offset_high = (uint16_t)((offset >> 16) & 0xFFFF);
}

void idt_install() {
	lgdt_ptr.limit = sizeof(idt) - 1;
	lgdt_ptr.base = (uint32_t)&idt;
	idt_load((uintptr_t)lgdt_ptr);

	// Exceptions
	idt_set_gate(  0,  _isr0, 0x08, 0x8E);
	idt_set_gate(  1,  _isr1, 0x08, 0x8E);
	idt_set_gate(  2,  _isr2, 0x08, 0x8E);
	idt_set_gate(  3,  _isr3, 0x08, 0x8E);
	idt_set_gate(  4,  _isr4, 0x08, 0x8E);
	idt_set_gate(  5,  _isr5, 0x08, 0x8E);
	idt_set_gate(  6,  _isr6, 0x08, 0x8E);
	idt_set_gate(  7,  _isr7, 0x08, 0x8E);
	idt_set_gate(  8,  _isr8, 0x08, 0x8E);
	idt_set_gate(  9,  _isr9, 0x08, 0x8E);
	idt_set_gate( 10, _isr10, 0x08, 0x8E);
	idt_set_gate( 11, _isr11, 0x08, 0x8E);
	idt_set_gate( 12, _isr12, 0x08, 0x8E);
	idt_set_gate( 13, _isr13, 0x08, 0x8E);
	idt_set_gate( 14, _isr14, 0x08, 0x8E);
	idt_set_gate( 15, _isr15, 0x08, 0x8E);
	idt_set_gate( 16, _isr16, 0x08, 0x8E);
	idt_set_gate( 17, _isr17, 0x08, 0x8E);
	idt_set_gate( 18, _isr18, 0x08, 0x8E);
	idt_set_gate( 19, _isr19, 0x08, 0x8E);
	idt_set_gate( 20, _isr20, 0x08, 0x8E);
	idt_set_gate( 21, _isr21, 0x08, 0x8E);
	idt_set_gate( 22, _isr22, 0x08, 0x8E);
	idt_set_gate( 23, _isr23, 0x08, 0x8E);
	idt_set_gate( 24, _isr24, 0x08, 0x8E);
	idt_set_gate( 25, _isr25, 0x08, 0x8E);
	idt_set_gate( 26, _isr26, 0x08, 0x8E);
	idt_set_gate( 27, _isr27, 0x08, 0x8E);
	idt_set_gate( 28, _isr28, 0x08, 0x8E);
	idt_set_gate( 29, _isr29, 0x08, 0x8E);
	idt_set_gate( 30, _isr30, 0x08, 0x8E);
	idt_set_gate( 31, _isr31, 0x08, 0x8E);

	// IRQs
	idt_set_gate( 32, _isr32, 0x08, 0x8E);
	idt_set_gate( 33, _isr33, 0x08, 0x8E);
	idt_set_gate( 34, _isr34, 0x08, 0x8E);
	idt_set_gate( 35, _isr35, 0x08, 0x8E);
	idt_set_gate( 36, _isr36, 0x08, 0x8E);
	idt_set_gate( 37, _isr37, 0x08, 0x8E);
	idt_set_gate( 38, _isr38, 0x08, 0x8E);
	idt_set_gate( 39, _isr39, 0x08, 0x8E);

	idt_set_gate( 40, _isr40, 0x08, 0x8E);
	idt_set_gate( 41, _isr41, 0x08, 0x8E);
	idt_set_gate( 42, _isr42, 0x08, 0x8E);
	idt_set_gate( 43, _isr43, 0x08, 0x8E);
	idt_set_gate( 44, _isr44, 0x08, 0x8E);
	idt_set_gate( 45, _isr45, 0x08, 0x8E);
	idt_set_gate( 46, _isr46, 0x08, 0x8E);
	idt_set_gate( 47, _isr47, 0x08, 0x8E);
}
