##############################################
#
# Convert ROM image to ELF file with exports
#
# (C) 2015 Max Filippov <jcmvbkbc@gmail.com>
#
# License: MIT
#
##############################################

AS = xtensa-lx106-elf-as
LD = xtensa-lx106-elf-ld

all: bootrom.elf
clean:
	rm -f bootrom.elf rom-functions.s bootrom.o

#
# Consolidate multiple eagle.rom.addr.v6.ld files
#
eagle.rom.addr.v6.ld:
	find -name eagle.rom.addr.v6.ld | xargs sort -t ' ' -k 5 -u > $@

%.elf: %.o
	$(LD) -M -T bootrom.ld -r $^ -o $@

rom-functions.s: eagle.rom.addr.v6.ld
	sed -n 's/PROVIDE[[:space:]]*([[:space:]]*\([^[:space:]=]\+\)[^0]\+\(0x4.......\).*/\1 = \2 - 0x40000000 + _stext\n.global \1\n.type \1, @function/p' < $^ > $@

%.o: %.s rom-functions.s
	$(AS) $< -o $@
