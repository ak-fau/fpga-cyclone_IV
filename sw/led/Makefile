
TARGET := cnt

RM := rm -f
CC := $(CROSS_COMPILE)gcc
CFLAGS := -m32 -O1

.PHONY: all clean distclean objdump hex bin

all: $(TARGET).o

clean:
	$(RM) *.o *.s
	$(RM) *.hex *.bin

distclean: clean
	$(RM) *~

objdump: $(TARGET).o
	$(CROSS_COMPILE)objdump -d $<

hex: $(TARGET).hex
bin: $(TARGET).bin

%.hex: %.o
	$(CROSS_COMPILE)objcopy -O ihex $< $@

%.bin: %.o
	$(CROSS_COMPILE)objcopy -O binary $< $@

%.s: %.c
	$(CC) $(CFLAGS) -S -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<
