# Copyright 2018 The svmbios authors.
# This code is distributed under the LICENSE that can be found in the package
# (LICENSE.md)

# Set some useful variables
override name = svmbios
override vers = 0-0-0-0
override file = $(name)$(vers)

.EXPORT_ALL_VARIABLES:
.PHONY: all clean

ifeq ($(strip $(target)), )
# Target is not set, so we print a small how-to

all:
	@echo "$(name) $(vers)"
	@echo "Target is not set!"
	@exit 0;

else ifeq ($(strip $(target)), qemu)
# Target is qemu, proceed

all:
	@echo "Building $(name) / QEMU"
	cd src && make all-qemu
	@echo "Build finished"

else ifeq ($(strip $(target)), bochs)
# Target is qemu, proceed

all:
	@echo "Building $(name) / bochs"
	cd src && make all-bochs
	@echo "Build finished"

endif

clean:
	$(MAKE) -C src clean
