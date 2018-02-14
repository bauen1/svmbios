#include <stdint.h>

#include <console.h>
#include <cpu.h>

uint8_t inb(uint16_t port) {
	uint8_t data;
	__asm__ __volatile__("inb %1, %0" : "=a" (data) : "dN" (port));
	return data;
}

uint16_t inw(uint16_t port) {
	uint16_t data;
	__asm__ __volatile__("inw %1, %0" : "=a" (data) : "dN" (port));
	return data;
}

uint32_t inl(uint16_t port) {
	uint32_t data;
	__asm__ __volatile__("inl %1, %0" : "=a" (data) : "dN" (port));
	return data;
}

void outb(uint16_t port, uint8_t data) {
	__asm__ __volatile__("outb %0, %1" : "=a" (data), "dN" (port));
}

void outw(uint16_t port, uint16_t data) {
	__asm__ __volatile__("outw %0, %1" : "=a" (data), "dN" (port));
}

void outl(uint16_t port, uint32_t data) {
	__asm__ __volatile__("outl %0, %1" : "=a" (data), "dN" (port));
}

__attribute__((noreturn))
void halt() {
	puts("halting the cpu...\n");
	_halt();
}
