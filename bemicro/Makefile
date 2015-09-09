
PROJECT := bemicro
PIN_ASSIGNMENTS := $(PROJECT)_pins.tcl

# Launch jtag server on a remote host where a USB blaster and a target are attached
#JTAG_HOST := <host_name>
#REMOTE_JTAG := ssh ${JTAG_HOST} sh -c "jtagconfig && sleep 5" &

ZS_CONFIG := ZscaleFPGASmallConfig
ROCKET_CHIP ?= $(shell pwd)/../../rocket-chip

ZS_TOP := Top.v

SW_DIR := ../sw
BOOTROM := $(SW_DIR)/bootrom.hex

VERILOG_FILES := $(wildcard *.v)
VERILOG_FILES += $(ZS_TOP)

ASSIGNMENT_FILES := $(PROJECT).qpf $(PROJECT).qsf $(PIN_ASSIGNMENTS)

STAMP := echo done >
RM    := rm -f
QUARTUS := quartus

.PHONY: all clean distclean

all: smart.log $(PROJECT).asm.rpt

distclean: clean
	$(RM) *~
	$(RM) -r db incremental_db
	$(RM) $(ZS_TOP)

clean:
	$(RM) -r output_files
	$(RM) *.rpt *.chg *.htm *.txt *.eqn *.pin *.sof *.pof smart.log *.summary

.PHONY: convert pgm cfg

pgm: output_files/$(PROJECT).jic
ifdef REMOTE_JTAG
	$(REMOTE_JTAG)
endif
	$(QUARTUS)_pgm $(PROJECT)_jic.cdf

cfg: output_files/$(PROJECT).sof
ifdef REMOTE_JTAG
	$(REMOTE_JTAG)
endif
	$(QUARTUS)_pgm $(PROJECT)_sof.cdf

convert: output_files/$(PROJECT).jic

output_files/$(PROJECT).jic: output_files/$(PROJECT).sof
	$(QUARTUS)_cpf --convert $(PROJECT).cof

$(ZS_TOP):
	CONFIG=$(ZS_CONFIG) $(MAKE) -C $(ROCKET_CHIP)/fsim verilog
	ln -s $(ROCKET_CHIP)/fsim/generated-src/Top.$(ZS_CONFIG).v $@

$(BOOTROM):
	$(MAKE) -C $(SW_DIR) bootrom

map: smart.log $(PROJECT).map.rpt
fit: smart.log $(PROJECT).fit.rpt
asm: smart.log $(PROJECT).asm.rpt
# sta: smart.log $(PROJECT).sta.rpt
smart: smart.log

COMMON_ARGS := --read_settings_files=on --write_settings_files=off
MAP_ARGS := $(COMMON_ARGS) --family="Cyclone IV E"
FIT_ARGS := $(COMMON_ARGS) --part="EP4CE22F17C7"
ASM_ARGS := $(COMMON_ARGS)
STA_ARGS :=

$(PROJECT).map.rpt: map.chg $(VERILOG_FILES) | $(BOOTROM)
	$(QUARTUS)_map $(MAP_ARGS) $(PROJECT)
	$(STAMP) fit.chg

$(PROJECT).fit.rpt: fit.chg $(PROJECT).map.rpt $(PIN_ASSIGNMENTS)
	$(QUARTUS)_fit $(FIT_ARGS) $(PROJECT)
	$(STAMP) asm.chg
#	$(STAMP) sta.chg

$(PROJECT).asm.rpt: asm.chg $(PROJECT).fit.rpt
	$(QUARTUS)_asm $(ASM_ARGS) $(PROJECT)

#$(PROJECT).sta.rpt: sta.chg $(PROJECT).fit.rpt
#	$(QUARTUS)_sta $(STA_ARGS) $(PROJECT)

smart.log: $(ASSIGNMENT_FILES) $(VERILOG_FILES) $(QSYS_QIP_FILE)
	$(QUARTUS)_sh --determine_smart_action $(PROJECT) > smart.log


map.chg:
	$(STAMP) map.chg
fit.chg:
	$(STAMP) fit.chg
#sta.chg:
#	$(STAMP) sta.chg
asm.chg:
	$(STAMP) asm.chg
