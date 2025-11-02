# © 2024 iss@raxiss
# This file is part of the llvm-mos-sdk project and is redistributable under the
# terms of the Apache 2.0 license with the LLVM exceptions. See the LICENSE file
# in the project root for the full text.

# platform(oric COMPLETE HOSTED PARENT common)
platform(oric HOSTED PARENT common)

if(NOT CMAKE_CROSSCOMPILING)
  return()
endif()

install(FILES
  oric.h
  TYPE INCLUDE)

install(FILES
  linka.ld
  linkc.ld
  TYPE LIB)

# crt0.o is the minimal startup functionality that must be included in any C
# binary. Anything that could be provided more than one wah should be in the
# derived platform's libcrt0.
add_platform_object_file(oric-crt0-o crt0.o crt0.s)

add_platform_library(oric-crt0)
merge_libraries(oric-crt0
  common-init-stack
  # common-copy-zp-data
  # common-copy-data
  common-zero-bss
  common-exit-return
)

add_platform_library(oric-c
  oric.c
  putchar.c
  registers.s
)

target_include_directories(oric-c PUBLIC .)
