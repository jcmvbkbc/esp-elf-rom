MEMORY
{
  irom0 : org = 0x40000000, len = 0x10000
}

SECTIONS
{
	.rom : ALIGN(4)
	{
		*(.text)
	} > irom0

	/DISCARD/ : { *(.data .bss) }
} 
