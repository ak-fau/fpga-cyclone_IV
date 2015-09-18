
OUTPUT_ARCH( "riscv" )
SECTIONS
{

  /* text: code section */
  . = 0x100;
  .text : {
      crt.o(.text)
      *(.text)
  }
  _text_end = .;

  /* data segment (RAM)*/
  . = 0x20000000;
  .data : {
      _gp = . + 0x800;
      *(.data)
  }
  _data_end = .;

  /* bss segment */
  .bss : {
      _bss_start = .;
      *(.bss)
      _bss_end = .;
  }
}
