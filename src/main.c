#include <stdint.h>

#include <console.h>
#include <cpu.h>
#include <idt.h>

typedef struct {
	uint32_t gs __attribute__((packed));
	uint32_t fs __attribute__((packed));
	uint32_t es __attribute__((packed));
	uint32_t ds __attribute__((packed));

	uint32_t edi __attribute__((packed));
	uint32_t esi __attribute__((packed));
	uint32_t ebp __attribute__((packed));
	uint32_t esp __attribute__((packed));
	uint32_t ebx __attribute__((packed));
	uint32_t edx __attribute__((packed));
	uint32_t ecx __attribute__((packed));
	uint32_t eax __attribute__((packed));

	uint32_t isr_num __attribute__((packed));
	uint32_t err_code __attribute__((packed));

	uint32_t eip __attribute__((packed));
	uint32_t cs __attribute__((packed));
	uint32_t eflags __attribute__((packed));
	uint32_t usersp __attribute__((packed));
	uint32_t ss __attribute__((packed));
} __attribute__((packed)) registers_t;

void *handle_isr(registers_t *regs) {
	printf("encountered interrupt: 0x%x\n", regs->isr_num);
	halt();
	return;
}

void main() {
	printf("hello world! (%s)\n0x%x\n", "printf", 0xDEADBEEF);
	idt_install();
	while (1) {
		__asm__ __volatile__ ("sti");
		__asm__ __volatile__ ("hlt");
	}
}
