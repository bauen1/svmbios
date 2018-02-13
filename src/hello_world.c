#include <stdint.h>

static void outb(uint16_t port, uint8_t data) {
        __asm__ __volatile("outb %0, %1" : : "a" (data), "dN" (port));
}

#define debug_out(c) ((void)outb(0xe9,(c)))

void main() {
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
