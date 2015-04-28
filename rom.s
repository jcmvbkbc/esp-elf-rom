	.align 4096
	.text
_stext:
.incbin "iram0.bin"
.include "rom-functions.s"
