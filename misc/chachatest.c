#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "chacha.h"


int main(int argc, char **argv)
{
  char key[32] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f,0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1a,0x1b,0x1c,0x1d,0x1e,0x1f};
  uint32_t counter = 1;
  char nonce[12] = {0x00,0x00,0x00,0x09,0x00,0x00,0x00,0x4a,0x00,0x00,0x00,0x00};
  char out[64];
  int i;
  char expected_out[64] = {
0x10,0xf1,0xe7,0xe4,0xd1,0x3b,0x59,0x15,0x50,0x0f,0xdd,0x1f,0xa3,0x20,0x71,0xc4,
0xc7,0xd1,0xf4,0xc7,0x33,0xc0,0x68,0x03,0x04,0x22,0xaa,0x9a,0xc3,0xd4,0x6c,0x4e,
0xd2,0x82,0x64,0x46,0x07,0x9f,0xaa,0x09,0x14,0xc2,0xd7,0x05,0xd9,0x8b,0x02,0xa2,
0xb5,0x12,0x9c,0xd1,0xde,0x16,0x4e,0xb9,0xcb,0xd0,0x83,0xe8,0xa2,0x50,0x3c,0x4e,
};
  struct chacha20_ctx ctx;
  chacha20_block(key, counter, nonce, out);
  if (memcmp(out, expected_out, 64) != 0)
  {
    abort();
  }
  for (i = 0; i < 1000*1000; i++)
  {
    chacha20_block(key, ++counter, nonce, out); // 0.2 us per invocation
    if (memcmp(out, expected_out, 64) == 0)
    {
      abort();
    }
  }
  if (chacha20_init_devrandom(&ctx) != 0)
  {
    abort();
  }
  return 0;
}
