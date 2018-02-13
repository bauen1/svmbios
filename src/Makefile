# Copyright 2018 The svmbios authors.
# This code is distributed under the LICENSE that can be found in the package
# (LICENSE.md)

AS:= nasm
ASFLAGS:= -felf -g -Fdwarf
LD:= ld
LDFLAGS:= -m elf_i386

# Add objs here
OBJS:=entry-stub.o gdt.o

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

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
	rm -f $(OBJS) bios.bin
