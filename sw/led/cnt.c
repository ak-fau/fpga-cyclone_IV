
#include "zscale.h"

void main(void)
{
  unsigned int delay;
  unsigned char cnt=0;

  while (1) {
    *(volatile unsigned char *)LED_ADDR = cnt++;
    for (delay=2500000; delay; delay--); /* do nothing */
  }
}
