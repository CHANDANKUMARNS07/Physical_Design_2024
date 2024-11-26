export DESIGN_NICKNAME = VSDbabySOC_chandan
export DESIGN_NAME = vsdbabysoc
export PLATFORM    = sky130hd


export ADDITIONAL_LIBS = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/lib/avsddac.lib \
		$(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/lib/avsdpll.lib

export VERILOG_FILES =	$(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/vsdbabysoc.v \
	$(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/riscv_chandan.v \
	$(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/include/clk_gate.v 
		  
export VERILOG_INCLUDE_DIRS = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/include

export SDC_FILE      =  $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export ADDITIONAL_LEFS = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/avsddac.lef \
		$(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/avsdpll.lef

export GDS_FILES  = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/gds/avsddac.gds \
	$(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/gds/avsdpll.gds 


export MACRO_PLACEMENT = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/macro.cfg
export DIE_AREA = 0 0 3000 3000
export CORE_AREA = 50 50 2900 2900
export REMOVE_ABC_BUFFERS = 1
