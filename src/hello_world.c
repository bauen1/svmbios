#include <idt.h>
#include <stdint.h>

static void outb(uint16_t port, uint8_t data) {
        __asm__ __volatile("outb %0, %1" : : "a" (data), "dN" (port));
}

#define debug_out(c) ((void)outb(0xe9,(c)))

static void debug_puts(const char *s) {
	for (int i = 0; s[i] != 0; i++) {
		debug_out(s[i]);
	}
}

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
	return;
}

void main() {
	debug_puts("Hello world!\n");
	idt_install();
	debug_out('H');
	debug_out('e');
	debug_out('l');
	debug_out('l');
	debug_out('o');
	debug_out(' ');
	debug_out('W');
	debug_out('o');
	debug_out('r');
	debug_out('l');
	debug_out('d');
	debug_out(' ');
	debug_out('f');
	debug_out('r');
	debug_out('o');
	debug_out('m');
	debug_out(' ');
	debug_out('C');
	debug_out('!');
	debug_out('\n');
}
