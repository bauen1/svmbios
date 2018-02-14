# Copyright 2018 The svmbios authors.
# This code is distributed under the LICENSE that can be found in the package
# (LICENSE.md)

CC:= gcc
#CC:= tcc
CFLAGS:= -I ./include -ffreestanding -nostdlib
AS:= nasm
ASFLAGS:= -felf -g -Fdwarf
LD:= ld
LDFLAGS:= -m elf_i386

# Add objs here
OBJS:=entry-stub.o gdt.o hello_world.o idt_load.o isrs.o idt.o
DEPS:=$(OBJS:.o=.d)

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $< -MD $*.d

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $< -MD

bios.bin: bios.ld $(OBJS)
	$(LD) $(LDFLAGS) -T $< -o $@ $(OBJS)

.PHONY: all-qemu
all-qemu: bios.bin

.PHONY: all-bochs
all-bochs: bios.bin

.PHONY: run-bochs
run-bochs: bios.bin bochs.cfg
	bochs -qf bochs.cfg

.PHONY: run-qemu
run-qemu: bios.bin
	qemu-system-i386 -bios bios.bin -debugcon stdio

.PHONY: clean
clean:
	rm -f *.o *.d *.bin

-include $(DEPS)
