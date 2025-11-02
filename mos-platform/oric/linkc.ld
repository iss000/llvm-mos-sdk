/* Linker script to produce Oric binaries.
 *
 * © 2024 iss@raxiss
 * This file is part of the llvm-mos-sdk project and is redistributable under
 * the terms of the Apache 2.0 license with the LLVM exceptions. See the LICENSE
 * file in the project root for the full text.
 */

_grab = 0;
_start = 0x0600;
_stack_size = 256;

MEMORY {
    zp : ORIGIN = 0x50, LENGTH = 0x40 /*+ 0x10*/
    ram  (rw) : ORIGIN = /*_start*/ 0x0600, LENGTH = 0x9900+((_grab & 1)*(0xb500-0x9900))-/*_start*/0x0600
}

REGION_ALIAS("c_readonly", ram)
REGION_ALIAS("c_writeable", ram)

SECTIONS {
  .zp(NOLOAD) : { } >zp : NONE

  .zp.bss(NOLOAD) : {
    INCLUDE zp-bss-sections.ld
    INCLUDE zp-bss-symbols.ld
  } >zp : NONE

  INCLUDE text.ld
  INCLUDE rodata.ld
  INCLUDE data.ld
  INCLUDE bss.ld

  INCLUDE zp-noinit.ld
  INCLUDE noinit.ld

  __zp_data_start = .;
  .zp.data : {
    *(.zp.data .zp.data.*)
    *(.zp.rodata .zp.rodata.*)
  } >zp AT>ram : init /* TODO: silence the warning */
  __zp_data_load_start = ADDR(.text) + (LOADADDR(.zp.data) - LOADADDR(.text));
  __zp_data_size = SIZEOF(.zp.data);

  .noinit(NOLOAD) : {
      . = . + _stack_size;
      __stack = .;
  }
}

OUTPUT_FORMAT
{
  TRIM(ram)
}
