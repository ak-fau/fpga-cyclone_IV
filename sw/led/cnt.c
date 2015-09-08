
void inc_cnt(void)
{
  unsigned int delay;
  unsigned char cnt;

  cnt = 0;

  while (1) {
    *(volatile unsigned char *)0x80000000 = cnt++;
    for (delay=25000000; delay; delay--) /* do nothing */;
  }
}

