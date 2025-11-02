; Imaginary register definitions.
;
; © 2024 iss@raxiss
; This file is part of the llvm-mos-sdk project and is redistributable under the
; terms of the Apache 2.0 license with the LLVM exceptions. See the LICENSE file
; in the project root for the full text.

.macro register n
  .section .zp.reg_\n, "zaw", @nobits
    .global __rc\n
    __rc\n: .fill 1
.endm

register 0
register 1
register 2
register 3
register 4
register 5
register 6
register 7
register 8
register 9
register 10
register 11
register 12
register 13
register 14
register 15
register 16
register 17
register 18
register 19
register 20
register 21
register 22
register 23
register 24
register 25
register 26
register 27
register 28
register 29
register 30
register 31
