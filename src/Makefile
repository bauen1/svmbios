# Copyright 2018 The svmbios authors.
# This code is distributed under the LICENSE that can be found in the package
# (LICENSE.md)

AS:= nasm
ASFLAGS:= -felf -g -Fdwarf
LD:= ld
LDFLAGS:= -m elf_i386

# Add objs here
OBJS:=entry-stub.o

%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

bochs-bios.bin: bochs-bios.ld $(OBJS)
	$(LD) $(LDFLAGS) -T $< -o $@ $(OBJS)

qemu-bios.bin: qemu-bios.ld $(OBJS)
	$(LD) $(LDFLAGS) -T $< -o $@ $(OBJS)

.PHONY: all-qemu
all-qemu: qemu-bios.bin

.PHONY: all-bochs
all-bochs: bochs-bios.bin

.PHONY: run-bochs
run-bochs: bochs-bios.bin bochs.cfg
	bochs -qf bochs.cfg

.PHONY: run-qemu
run-qemu: qemu-bios.bin
	qemu-system-i386 -bios qemu-bios.bin -debugcon stdio

.PHONY: clean
clean:
	rm -f $(OBJS) bios.bin
