SIM=iverilog
SIMFLAGS=-g2012
TB=tb/tb_fixed_sqrt.sv
RTL=rtl/fixed_sqrt.v

all: sim

sim:
	$(SIM) $(SIMFLAGS) -o sim $(TB) $(RTL)
	vvp sim

clean:
	rm -f sim a.out *.vcd
