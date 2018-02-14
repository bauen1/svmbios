# Copyright 2018 The svmbios authors.
# This code is distributed under the LICENSE that can be found in the package
# (LICENSE.md)

CC:= gcc
#CC:= tcc
CFLAGS:= -I ./include -ffreestanding -nostdlib -g
AS:= nasm
ASFLAGS:= -felf -g -Fdwarf
LD:= ld
LDFLAGS:= -m elf_i386
OBJCOPY:= objcopy

# Add objs here
OBJS:=entry-stub.o gdt.o main.o idt_load.o isrs.o idt.o console.o cpu.o
DEPS:=$(OBJS:.o=.d)

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $< -MD $*.d

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $< -MD

bios.elf: bios.ld $(OBJS)
	$(LD) $(LDFLAGS) -T $< -o $@ $(OBJS)

bios.bin: bios.elf
	$(OBJCOPY) -O binary $< $@

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

.PHONY: all
all: bios.bin

.PHONY: clean
clean:
	rm -f *.o *.d *.bin

-include $(DEPS)
