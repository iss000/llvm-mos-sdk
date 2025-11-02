/* Fallback putchar used by the llvm-mos libc.
 *
 * © 2024 iss@raxiss
 * This file is part of the llvm-mos-sdk project and is redistributable under
 * the terms of the Apache 2.0 license with the LLVM exceptions. See the LICENSE
 * file in the project root for the full text.
 */

#include <oric.h>
#include <stdio.h>

__attribute__((always_inline, weak)) int
__from_ascii(char c, void *ctx, int (*write)(char c, void *ctx)) {
  if (__builtin_expect(c == '\n', 0))
    if (write('\r', ctx) == EOF)
      return EOF;
  return write(c, ctx);
}

__attribute__((weak)) void __putchar(char c) {
  return;
}
