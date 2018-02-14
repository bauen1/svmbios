#include <stdint.h>

#include <idt.h>
#include <idt_load.h>

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
}
