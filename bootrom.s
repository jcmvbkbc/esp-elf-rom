	.align 4096
	.text
_stext:
.incbin "bootrom.bin"
.include "rom-functions.s"
