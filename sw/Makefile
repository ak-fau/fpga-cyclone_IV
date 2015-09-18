
TARGET := led

RM := rm -f
CC := $(CROSS_COMPILE)gcc
CFLAGS := -m32 -static -Wa,-march=RVIM -O2 -fno-common -fno-builtin-printf
CFLAGS += -I./common

LD := $(CC)
LDFLAGS := -m32 -nostdlib -nostartfiles -ffast-math -lc -lgcc
LDSCRIPT:= ./common/test.ld

OBJDUMP := $(CROSS_COMPILE)objdump
OBJCOPY := $(CROSS_COMPILE)objcopy

COMMON_CFILES := $(wildcard common/*.c)
COMMON_SFILES := $(wildcard common/*.S)
TARGET_CFILES := $(wildcard $(TARGET)/*.c)

OFILES := $(patsubst %.S,%.o,$(COMMON_SFILES))
OFILES += $(patsubst %.c,%.o,$(COMMON_CFILES))
OFILES += $(patsubst %.c,%.o,$(TARGET_CFILES))

.PHONY: all clean distclean objdump hex bin bootrom

all: bootrom

bootrom: bootrom.hex

# crt.o is explicitly referenced from .ld script,
# so handle it separately
OFILES := $(patsubst common/crt.o,,$(OFILES))
crt.o: ./common/crt.o
	ln -sf $< $@

bootrom.o: $(OFILES) crt.o $(LDSCRIPT)
	$(LD) $(LDFLAGS) -T $(LDSCRIPT) -o $@ $(OFILES)

clean:
	$(RM) *.o
	$(RM) common/*.o
	$(RM) $(TARGET)/*.o
	$(RM) *.hex *.bin

distclean: clean
	$(RM) *~

objdump: bootrom.o
	$(OBJDUMP) -d $<

bin: bootrom.bin

bootrom.hex: bootrom.o
	$(OBJCOPY) -O ihex -j.text* -j.rodata $< $@

%.hex: %.o
	$(OBJCOPY) -O ihex $< $@

%.bin: %.o
	$(OBJCOPY) -O binary $< $@

%.o: %.S
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<
