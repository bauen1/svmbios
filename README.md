# svmbios

`svmbios` is a project that implements a fully operational
BIOS for virtual machines, using tools that any Linux machine
should have.

To build it for qemu, clone this repo and run:
```bash
make target=qemu
```

Or for bochs:
```bash
make target=bochs
```
