SHELL                   := $(shell which bash) -o pipefail
ABS_TOP                 := $(shell pwd)
SRC_DIR                 := $(shell pwd)/src
VIVADO                  ?= vivado
VIVADO_OPTS             ?= -nolog -nojournal -mode batch
FPGA_PART               ?= xc7z007sclg400-1
RTL                     += $(shell find $(SRC_DIR) -type f -name "*.v")
CONSTRAINTS             += $(shell find $(SRC_DIR) -type f -name "*.xdc")
TOP                     ?= skel_top
IVERILOG                := iverilog
IVERILOG_OPTS           := -D IVERILOG=1
VVP                     := vvp
MAX_THREADS         	:= 2

build/target.tcl: $(RTL) $(CONSTRAINTS)
	mkdir -p build
	echo "set ABS_TOP                        $(ABS_TOP)"    	>> $@
	echo "set TOP                            $(TOP)"    		>> $@
	echo "set FPGA_PART                      $(FPGA_PART)"  	>> $@
	echo "set_param general.maxThreads       $(MAX_THREADS)"    >> $@
	echo "set_param general.maxBackupLogs    0"    				>> $@
	echo -n "set RTL { " >> $@
	FLIST="$(RTL)"; for f in $$FLIST; do echo -n "$$f " ; done >> $@
	echo "}" >> $@
	echo -n "set CONSTRAINTS { " >> $@
	FLIST="$(CONSTRAINTS)"; for f in $$FLIST; do echo -n "$$f " ; done >> $@
	echo "}" >> $@

setup: build/target.tcl

build/synth/$(TOP).dcp: build/target.tcl $(ABS_TOP)/scripts/synth.tcl
	mkdir -p ./build/synth/
	cd ./build/synth/ && $(VIVADO) $(VIVADO_OPTS) -source $(ABS_TOP)/scripts/synth.tcl |& tee synth.log

synth: build/synth/$(TOP).dcp

build/impl/$(TOP).bit: build/synth/$(TOP).dcp $(ABS_TOP)/scripts/impl.tcl
	mkdir -p ./build/impl/
	cd ./build/impl && $(VIVADO) $(VIVADO_OPTS) -source $(ABS_TOP)/scripts/impl.tcl |& tee impl.log

impl: build/impl/$(TOP).bit
all: build/impl/$(TOP).bit

program: build/impl/$(TOP).bit $(ABS_TOP)/scripts/program.tcl
	cd build/impl && $(VIVADO) $(VIVADO_OPTS) -source $(ABS_TOP)/scripts/program.tcl

program-force:
	cd build/impl && $(VIVADO) $(VIVADO_OPTS) -source $(ABS_TOP)/scripts/program.tcl

vivado: build
	cd build && nohup $(VIVADO) </dev/null >/dev/null 2>&1 &

lint:
	verilator -I$(SRC_DIR) --lint-only --top-module $(TOP) $(RTL)

sim_build/compile_simlib/synopsys_sim.setup:
	mkdir -p sim_build/compile_simlib
	cd build/sim_build/compile_simlib && $(VIVADO) $(VIVADO_OPTS) -source $(ABS_TOP)/scripts/compile_simlib.tcl

compile_simlib: sim_build/compile_simlib/synopsys_sim.setup

clean:
	rm -rf ./build $(junk) *.daidir sim/output.txt \
	sim/*.tb sim/*.daidir sim/csrc \
	sim/ucli.key sim/*.vpd sim/*.vcd \
	sim/*.tbi sim/*.fst sim/*.jou sim/*.log sim/*.out

.PHONY: setup synth impl program program-force vivado all clean %.tb
